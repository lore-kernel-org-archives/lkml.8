Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C6BC10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514E520857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387509AbgDBIaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:30:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:39980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbgDBIaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:30:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 080ABACC6;
        Thu,  2 Apr 2020 08:30:37 +0000 (UTC)
Subject: Re: [PATCH] mm, dump_page(): do not crash with invalid mapping
 pointer
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Petr Tesarik <ptesarik@suse.cz>
References: <20200331165454.12263-1-vbabka@suse.cz>
 <20200401140544.pkhgfmo5pks3dw6v@box>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a5ebb5eb-ccda-eb74-422c-cddea792894f@suse.cz>
Date:   Thu, 2 Apr 2020 10:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200401140544.pkhgfmo5pks3dw6v@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/20 4:05 PM, Kirill A. Shutemov wrote:
> On Tue, Mar 31, 2020 at 06:54:54PM +0200, Vlastimil Babka wrote:
>> We have seen a following problem on a RPi4 with 1G RAM:
>> 
>> Besides the underlying issue with page->mapping containing a bogus value for
>> some reason, we can see that __dump_page() crashed by trying to read the
>> pointer at mapping->host, turning a recoverable warning into full Oops.
>> 
>> It can be expected that when page is reported as bad state for some reason, the
>> pointers there should not be trusted blindly. So this patch treats all data in
>> __dump_page() that depends on page->mapping as lava, using
>> probe_kernel_read_strict(). Ideally this would include the dentry->d_parent
>> recursively, but that would mean changing printk handler for %pd. Chances of
>> reaching the dentry printing part with an initially bogus mapping pointer
>> should be rather low, though.
>> 
>> Also prefix printing mapping->a_ops with a description of what is being
>> printed.  In case the value is bogus, %ps will print raw value instead of
>> the symbol name and then it's not obvious at all that it's printing a_ops.
>> 
>> Reported-by: Petr Tesarik <ptesarik@suse.cz>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  mm/debug.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++------
>>  1 file changed, 50 insertions(+), 6 deletions(-)
> 
> I'm not sure it worth the effort. It looks way too complex for what it
> does.

Well the human effort is done, and CPU cycles are cheap :P Complex is better
than to crash, IMHO.

> I also expect it to slowdown dump_page(), which is hotpath for some debug
> scenarios :P

It's still a debug code, better safe than fast :P

> Maybe just move printing this info to the end, so we would see the rest
> even if ->mapping is bogus?

Well the thing is designed to be recoverable. Just today "mm: improve
dump_page() for compound pages" was merged that AFAICS prevents similar crashes
when the compound_head() is bogus.
