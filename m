Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112B3C32771
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD18F2469D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 02:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgASClQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 21:41:16 -0500
Received: from mga17.intel.com ([192.55.52.151]:5522 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbgASClP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 21:41:15 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jan 2020 18:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,336,1574150400"; 
   d="scan'208";a="426401963"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jan 2020 18:41:13 -0800
Date:   Sun, 19 Jan 2020 10:41:24 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200119024124.GF9745@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard>
 <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
 <20200117234829.GA2844@richard>
 <CAHbLzko_UC47Y0gBsRRK0oJS5fvhJ80EpvrjTsFi8+PuTCHGEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHbLzko_UC47Y0gBsRRK0oJS5fvhJ80EpvrjTsFi8+PuTCHGEQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 08:56:27PM -0800, Yang Shi wrote:
>On Fri, Jan 17, 2020 at 3:48 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>>
>> On Fri, Jan 17, 2020 at 03:30:18PM -0800, Yang Shi wrote:
>> >On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>> >>
>> >> On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
>> >> >If we get here after successfully adding page to list, err would be
>> >> >the number of pages in the list.
>> >> >
>> >> >Current code has two problems:
>> >> >
>> >> >  * on success, 0 is not returned
>> >> >  * on error, the real error code is not returned
>> >> >
>> >>
>> >> Well, this breaks the user interface. User would receive 1 even the migration
>> >> succeed.
>> >>
>> >> The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
>> >> id in status if the page is already on the target node").
>> >
>> >Yes, it may return a value which is > 0. But, it seems do_pages_move()
>> >could return > 0 value even before this commit.
>> >
>> >For example, if I read the code correctly, it would do:
>> >
>> >If we already have some pages on the queue then
>> >add_page_for_migration() return error, then do_move_pages_to_node() is
>> >called, but it may return > 0 value (the number of pages that were
>> >*not* migrated by migrate_pages()), then the code flow would just jump
>> >to "out" and return the value. And, it may happen to be 1.
>> >
>>
>> This is another point I think current code is not working well. And actually,
>> the behavior is not well defined or our kernel is broken for a while.
>
>Yes, we already spotted a few mismatches, inconsistencies and edge
>cases in these NUMA APIs.
>
>>
>> When you look at the man page, it says:
>>
>>     RETURN VALUE
>>            On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error
>>
>> So per my understanding, the design is to return -1 on error instead of the
>> pages not managed to move.
>
>So do I.
>
>>
>> For the user interface, if original code check 0 for success, your change
>> breaks it. Because your code would return 1 instead of 0. Suppose most user
>> just read the man page for programming instead of reading the kernel source
>> code. I believe we need to fix it.
>
>Yes, I definitely agree we need fix it. But the commit log looks
>confusing, particularly "on error, the real error code is not
>returned". If the error is returned by add_page_for_migration() then
>it will not be returned to userspace instead of reporting via status.
>Do you mean this?
>

Sorry for the confusion.

Here I mean, if add_page_for_migratioin() return 1, and the following err1
from do_move_pages_to_node() is set, the err1 is not returned.

The reason is err is not 0 at this point.

-- 
Wei Yang
Help you, Help me
