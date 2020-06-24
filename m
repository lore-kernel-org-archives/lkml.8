Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED5C2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F6F20836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jgwwd3HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403921AbgFXVaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390437AbgFXVaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:30:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCCAC061573;
        Wed, 24 Jun 2020 14:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1HvsEisY+JqAH4eB24qkTv31vmmbufpD8xgSfU5UPdM=; b=Jgwwd3HKSCGDIrGfcDNLwUtCRw
        owE94w39EisUXpMHYIv1pbv2n5zjSMpa7/iif05p6zELIAPYkGaboNNN6TH29l13zX633oAS6RM8i
        u+py1W93Ar3xSPtumosRbnxJhxzE/IlIJ8zzS6Msi31BJfjrcR7Li/mepAU5QxssYRUraWQyCdWh/
        e0DBYe+ioO8w/tPmJJ0AAlXzL2Y9mhiO5Z3pKnX3q8XvSWDPiBsyiYMeVffdZCvaIkWLaSxm+lp/5
        GzV+OHjm+HMcDNoGcHIV0nUjJZLKNJmSJLKH4rSTl33X5olQIgDM/8f26BmNOkuNFTA7+0rVin7ia
        KLsAR9OA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joCxj-0007YQ-1Z; Wed, 24 Jun 2020 21:29:43 +0000
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
To:     Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard.weinberger@gmail.com>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
 <202006241335.2C0FB5DF90@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
Date:   Wed, 24 Jun 2020 14:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006241335.2C0FB5DF90@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/20 1:36 PM, Kees Cook wrote:
> On Wed, Jun 24, 2020 at 09:23:25AM +0200, Richard Weinberger wrote:
>> ----- Ursprüngliche Mail -----
>>>>> Regardless, it seems arch/x86/um/asm/desc.h is not needed any more?
>>>
>>>> True that, we can rip the file.
>>>
>>> Has anyone fixed the uml build errors?
>>
>> I didn't realize that this is a super urgent issue. ;-)
>>
>> Kees, if you want you can carry a patch in your series, I'll ack it.
>> Otherwise I can also do a patch and bring it via the uml tree upstream
>> as soon more fixes queued up.
> 
> I think the lkdtm change will tweak this bug, so I'm happy to carry the
> patch (I just haven't had time to create and test one). Is it really
> just as simple as removing arch/x86/um/asm/desc.h?
> 

I just tried that and the build is still failing, so No, it's not that simple.

But thanks for offering.

I'll just ignore the UML build errors for now.

-- 
~Randy

