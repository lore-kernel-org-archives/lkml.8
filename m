Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97074C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C292072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgAQW1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:27:31 -0500
Received: from mga14.intel.com ([192.55.52.115]:58479 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgAQW1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:27:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 14:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="426149525"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jan 2020 14:27:28 -0800
Date:   Sat, 18 Jan 2020 06:27:40 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200117222740.GB29229@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117074534.25324-1-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
>If we get here after successfully adding page to list, err would be
>the number of pages in the list.
>
>Current code has two problems:
>
>  * on success, 0 is not returned
>  * on error, the real error code is not returned
>

Well, this breaks the user interface. User would receive 1 even the migration
succeed.

The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
id in status if the page is already on the target node").

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> mm/migrate.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/migrate.c b/mm/migrate.c
>index 557da996b936..c3ef70de5876 100644
>--- a/mm/migrate.c
>+++ b/mm/migrate.c
>@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
> 	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> 	if (!err1)
> 		err1 = store_status(status, start, current_node, i - start);
>-	if (!err)
>+	if (err >= 0)
> 		err = err1;
> out:
> 	return err;
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
