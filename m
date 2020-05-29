Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8008FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CF0E207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 16:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sjXdEt+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgE2QVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 12:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgE2QVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 12:21:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EAEC03E969;
        Fri, 29 May 2020 09:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vtMTWZdV9tWXEMRPXCgiVbI13lSkgosNjsgh2PbbuvI=; b=sjXdEt+Fp6fx3P5mwwJeQlcfW+
        9NqIEpf4A4epvYWa+afRPBHRbbdp8TNbbdKnMUFhLtG/pvbWLVK7oxo3+9nRCc3So1jMiHawbVWp9
        +vew4HqvRp7upQviIC1/A+Vlaf3+RjA/stPsfA52H8+BfUEGtI1O8adPvFTAzKUgT3+m3Bjx637KA
        kNLc6zHSWONDrWsTGRAAfSK/LWkMH1TR4pijkitkrfpRJQLQNgdxqfx9GXIiiLZbecyfegMtF5ahd
        OKZzLwfCC+z0CxqBii5qVTHw0qvd75SbwPnUlhsJR5aR78CC4kyv4A+7oRIu5/AMEIkbMbNZgtFRO
        tQswXVeg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jehkf-00061U-26; Fri, 29 May 2020 16:20:57 +0000
Subject: Re: linux-next: Tree for May 14 (objtool 2/2)
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20200514210716.30b416ee@canb.auug.org.au>
 <742521db-1e8c-0d7a-1ed4-a908894fb497@infradead.org>
 <20200528154404.74sjv4bdj3myacn6@treble> <202005282258.94570AF@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <70a6f89e-ec5a-52e8-8692-34e34364c36c@infradead.org>
Date:   Fri, 29 May 2020 09:20:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <202005282258.94570AF@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/20 11:06 PM, Kees Cook wrote:
> On Thu, May 28, 2020 at 10:44:04AM -0500, Josh Poimboeuf wrote:
>> On Thu, May 14, 2020 at 09:04:36AM -0700, Randy Dunlap wrote:
>>> On 5/14/20 4:07 AM, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20200512:
>>>>
>>>
>>> on x86_64:
>>>
>>> drivers/ide/ide-tape.o: warning: objtool: ide_tape_discard_merge_buffer.constprop.7()+0x4e: unreachable instruction
>>> drivers/scsi/sd.o: warning: objtool: sd_pr_clear()+0x1e: unreachable instruction
>>> drivers/scsi/sd_zbc.o: warning: objtool: sd_zbc_update_wp_offset_workfn()+0xec: unreachable instruction
>>> drivers/target/target_core_xcopy.o: warning: objtool: target_xcopy_do_work()+0xdd6: unreachable instruction
>>>
>>>
>>> randconfig file is attached.
>>
>> Kees,
>>
>> More UBSAN_TRAP fun.  This randconfig has:
>>
>> CONFIG_UBSAN_TRAP=y
>> CONFIG_UBSAN_ALIGNMENT=y
>> # CONFIG_COMPILE_TEST is not set
> 
> Ugh, I thought CONFIG_COMPILE_TEST always gets set for randconfig and
> the all*config choices, but now I see that CONFIG_COMPILE_TEST is
> enabled due to the "all" part of the all*config choices. Okay. Big
> hammer:
> 
> diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> index 929211039bac..27bcc2568c95 100644
> --- a/lib/Kconfig.ubsan
> +++ b/lib/Kconfig.ubsan
> @@ -63,7 +63,7 @@ config UBSAN_SANITIZE_ALL
>  config UBSAN_ALIGNMENT
>         bool "Enable checks for pointers alignment"
>         default !HAVE_EFFICIENT_UNALIGNED_ACCESS
> -       depends on !X86 || !COMPILE_TEST
> +       depends on !UBSAN_TRAP
>         help
>           This option enables the check of unaligned memory accesses.
>           Enabling this option on architectures that support unaligned
> 
> How about that?
> 

Sure, that works. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

-- 
~Randy
