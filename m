Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6043221531
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391225AbgF2V3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:29:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:40460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728889AbgF2SlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80509ABCE;
        Mon, 29 Jun 2020 10:29:29 +0000 (UTC)
Message-ID: <1593426565.3504.6.camel@suse.de>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
From:   Oscar Salvador <osalvador@suse.de>
To:     nao.horiguchi@gmail.com, linux-mm@kvack.org
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Date:   Mon, 29 Jun 2020 12:29:25 +0200
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 15:01 +0000, nao.horiguchi@gmail.com wrote:
> I rebased soft-offline rework patchset [1][2] onto the latest
> mmotm.  The
> rebasing required some non-trivial changes to adjust, but mainly that
> was
> straightforward.  I confirmed that the reported problem doesn't
> reproduce on
> compaction after soft offline.  For more precise description of the
> problem
> and the motivation of this patchset, please see [2].

Hi Naoya,

Thanks for dusting this off.
To be honest, I got stuck with the hard offline mode so this delayed
the resubmission, along other problems.

> I think that the following two patches in v2 are better to be done
> with
> separate work of hard-offline rework, so it's not included in this
> series.
> 
>   - mm,hwpoison: Take pages off the buddy when hard-offlining
>   - mm/hwpoison-inject: Rip off duplicated checks
> 
> These two are not directly related to the reported problem, so they
> seems
> not urgent.  And the first one breaks num_poisoned_pages counting in
> some
> testcases, and The second patch needs more consideration about
> commented point.

I fully agree.

> Any comment/suggestion/help would be appreciated.

My "new" version included a patch to make sure we give a chance to
pages that possibly are in a pcplist.
Current behavior is that if someone tries to soft-offline such a page,
we return an error because page count is 0 but page is not in the buddy
system.

Since this patchset already landed in the mm tree, I could send it as a
standalone patch on top if you agree with it.

My patch looked something like:

From: Oscar Salvador <osalvador@suse.de>
Date: Mon, 29 Jun 2020 12:25:11 +0200
Subject: [PATCH] mm,hwpoison: Drain pcplists before bailing out for
non-buddy
 zero-refcount page

A page with 0-refcount and !PageBuddy could perfectly be a pcppage.
Currently, we bail out with an error if we encounter such a page,
meaning that we do not give a chance to handle pcppages.

Fix this by draining pcplists whenever we find this kind of page
and retry the check again.
It might be that pcplists have been spilled into the buddy allocator
and so we can handle it.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory-failure.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index e90ddddab397..3aac3f1eeed0 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -958,7 +958,7 @@ static int page_action(struct page_state *ps,
struct page *p,
  * Return: return 0 if failed to grab the refcount, otherwise true
(some
  * non-zero value.)
  */
-static int get_hwpoison_page(struct page *page)
+static int __get_hwpoison_page(struct page *page)
 {
 	struct page *head = compound_head(page);
 
@@ -988,6 +988,28 @@ static int get_hwpoison_page(struct page *page)
 	return 0;
 }
 
+static int get_hwpoison_page(struct page *p)
+{
+	int ret;
+	bool drained = false;
+
+retry:
+	ret = __get_hwpoison_page(p);
+	if (!ret) {
+		if (!is_free_buddy_page(p) && !page_count(p) &&
!drained) {
+			/*
+			 * The page might be in a pcplist, so try to
drain
+			 * those and see if we are lucky.
+			 */
+			drain_all_pages(page_zone(p));
+			drained = true;
+			goto retry;
+		}
+	}
+
+	return ret;
+}
+
 /*
  * Do all that is necessary to remove user space mappings. Unmap
  * the pages and send SIGBUS to the processes if the data was dirty.
-- 
2.26.2

-- 
Oscar Salvador
SUSE L3
