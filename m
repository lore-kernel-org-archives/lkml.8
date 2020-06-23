Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC46FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38A5208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 23:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1snu5U2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388409AbgFWXcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 19:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387696AbgFWXcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 19:32:35 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94052C061573;
        Tue, 23 Jun 2020 16:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=OVsi97xHW+lEj+KUOG+QvHgd6uEp9tOe09/6am2CW6I=; b=L1snu5U2r8dJy0a9uovEWFKKN9
        BBGsUX0tmvJuHt2K4KQ7C73ckeio2zPjASjDWZ11FSrdkQAkR5xA5vFWsx0/JpWxj9glwFsmu4IAY
        2X1erLv94ialoJxPIgOOvDTV0HwyCuGeOnkmubpqvaLAttsykrqlizsAzdSNdI2Hwe9Du8BikKH6j
        cdRdtOAE+/ly/KDGBu4uDxL9lDL1BwC4CDX6H8BwCjtn1nmEok3ynXM23M8z26jV+P3IgqCSOryM6
        As9Jqo0RhbyU9NzqkkTw1xKm7pepfJIpNyeljkYg5jod2/YDVEZFu3zJeUavpGCarYe+qmdQUlc+O
        1DmbT4uA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnsOn-0002OP-Mn; Tue, 23 Jun 2020 23:32:18 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
To:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        richard -rw- weinberger <richard.weinberger@gmail.com>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
Date:   Tue, 23 Jun 2020 16:32:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006231610.4993DC5@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 4:10 PM, Kees Cook wrote:
> On Fri, May 29, 2020 at 01:03:43PM -0700, Kees Cook wrote:
>> Hi Greg,
>>
>> Can you please apply these patches to your drivers/misc tree for LKDTM?
>> It's mostly a collection of fixes and improvements and tweaks to the
>> selftest integration.
> 
> Friendly ping -- we're past -rc2 now. :)
> 
> Thanks!
> 
> -Kees
> 
>>
>> Thanks!
>>
>> -Kees
>>
>> Kees Cook (4):
>>   lkdtm: Avoid more compiler optimizations for bad writes
>>   lkdtm/heap: Avoid edge and middle of slabs
>>   selftests/lkdtm: Reset WARN_ONCE to avoid false negatives
>>   lkdtm: Make arch-specific tests always available
>>
>>  drivers/misc/lkdtm/bugs.c               | 45 +++++++++++++------------
>>  drivers/misc/lkdtm/heap.c               |  9 ++---
>>  drivers/misc/lkdtm/lkdtm.h              |  2 --
>>  drivers/misc/lkdtm/perms.c              | 22 ++++++++----
>>  drivers/misc/lkdtm/usercopy.c           |  7 ++--
>>  tools/testing/selftests/lkdtm/run.sh    |  6 ++++
>>  tools/testing/selftests/lkdtm/tests.txt |  1 +
>>  7 files changed, 56 insertions(+), 36 deletions(-)
>>
>> -- 
>> 2.25.1
>>
> 

>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?

> True that, we can rip the file.

Has anyone fixed the uml build errors?

thanks.
-- 
~Randy

