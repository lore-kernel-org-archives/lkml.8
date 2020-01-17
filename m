Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F248BC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3F621D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgAQXst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:48:49 -0500
Received: from mga06.intel.com ([134.134.136.31]:11481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgAQXss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:48:48 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 15:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,332,1574150400"; 
   d="scan'208";a="424651931"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jan 2020 15:48:18 -0800
Date:   Sat, 18 Jan 2020 07:48:29 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200117234829.GA2844@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard>
 <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:30:18PM -0800, Yang Shi wrote:
>On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
>> >If we get here after successfully adding page to list, err would be
>> >the number of pages in the list.
>> >
>> >Current code has two problems:
>> >
>> >  * on success, 0 is not returned
>> >  * on error, the real error code is not returned
>> >
>>
>> Well, this breaks the user interface. User would receive 1 even the migration
>> succeed.
>>
>> The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
>> id in status if the page is already on the target node").
>
>Yes, it may return a value which is > 0. But, it seems do_pages_move()
>could return > 0 value even before this commit.
>
>For example, if I read the code correctly, it would do:
>
>If we already have some pages on the queue then
>add_page_for_migration() return error, then do_move_pages_to_node() is
>called, but it may return > 0 value (the number of pages that were
>*not* migrated by migrate_pages()), then the code flow would just jump
>to "out" and return the value. And, it may happen to be 1.
>

This is another point I think current code is not working well. And actually,
the behavior is not well defined or our kernel is broken for a while.

When you look at the man page, it says:

    RETURN VALUE
           On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error

So per my understanding, the design is to return -1 on error instead of the
pages not managed to move.

For the user interface, if original code check 0 for success, your change
breaks it. Because your code would return 1 instead of 0. Suppose most user
just read the man page for programming instead of reading the kernel source
code. I believe we need to fix it.

Not sure how to include some user interface related developer to look into
this issue. Hope this thread may catch their eyes.

>I'm not sure if it breaks the user interface since the behavior has
>been existed for years, and it looks nobody complains about it. Maybe
>glibc helps hide it or people just care if it is 0 and the status.
>
>>
>> >Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >---
>> > mm/migrate.c | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/mm/migrate.c b/mm/migrate.c
>> >index 557da996b936..c3ef70de5876 100644
>> >--- a/mm/migrate.c
>> >+++ b/mm/migrate.c
>> >@@ -1677,7 +1677,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>> >       err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>> >       if (!err1)
>> >               err1 = store_status(status, start, current_node, i - start);
>> >-      if (!err)
>> >+      if (err >= 0)
>> >               err = err1;
>> > out:
>> >       return err;
>> >--
>> >2.17.1
>>
>> --
>> Wei Yang
>> Help you, Help me
>>

-- 
Wei Yang
Help you, Help me
