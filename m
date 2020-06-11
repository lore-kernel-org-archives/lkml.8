Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B43C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7163206A4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YuPBqoY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFKDEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFKDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:04:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D28C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=UziU5IlAnnVAjmu1Qe7a8uVFIcZip9sjmZbtLCxRV6w=; b=YuPBqoY20d2lS9iR/5nJ3H8pc2
        o0zIxDskD4clTuqAR8b9/Ie7Natvwg4LduRljWnSlrlNikgVbhzmAe7l4ByhodhRA1h5KTOrb7pDo
        KbRZPKgubiZ5+jrwg8QdLW96h7m71tQWoiU0TNkU7YlSbmSBXuR8aLJ/0dYoQXYHC/6Zqqt0hPrwd
        wuI598dPPBx3vxBBSXvfOYt3NU/9cqR/BHTTkSUPTRqFiGkmNQUmPXJEkMZL7x8DFxWOjIN/+tGvV
        LVmGt0SNEARt80y55CJgit8wpMVVi8JLPZQwtYFanA8d78aVpax3Q9LaWmTGLRCt377ABr5l2LMXk
        54vG/L6g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjDVc-00061S-1S; Thu, 11 Jun 2020 03:04:04 +0000
Subject: Re: Compile error: linux-next-20200610
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org
References: <CAFqt6zaPX75-JYGDZM_qAibxZza-jrARcnzLKCa1tCQ+1M3rCQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <442f081a-ae1a-1594-bf6a-7e369306fa1d@infradead.org>
Date:   Wed, 10 Jun 2020 20:04:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zaPX75-JYGDZM_qAibxZza-jrARcnzLKCa1tCQ+1M3rCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 8:07 PM, Souptick Joarder wrote:
> Hi Stephen,
> 
> While compiling linux-next-20200610, I hit below compile error.
> .config file is attached.
> 
> Steps ->
> 
> 1. Download the tar
> 2. make defconfig
> 3. make -j4
> 
> In file included from drivers/firmware/efi/libstub/efi-stub-helper.c:16:0:
> drivers/firmware/efi/libstub/efi-stub-helper.c: In function ‘efi_char16_puts’:
> ./arch/x86/include/asm/efi.h:355:3: sorry, unimplemented: ms_abi
> attribute requires -maccumulate-outgoing-args or subtarget
> optimization implying it
>    : __efi64_thunk_map(inst, func, inst, ##__VA_ARGS__))
>    ^
> drivers/firmware/efi/libstub/efi-stub-helper.c:37:2: note: in
> expansion of macro ‘efi_call_proto’
>   efi_call_proto(efi_table_attr(efi_system_table, con_out),
>   ^
> drivers/firmware/efi/libstub/efi-stub-helper.c:37: confused by earlier
> errors, bailing out
> Preprocessed source stored into /tmp/ccZ7rSjc.out file, please attach
> this to your bugreport.
> make[5]: *** [drivers/firmware/efi/libstub/efi-stub-helper.o] Error 1
> make[4]: *** [drivers/firmware/efi/libstub] Error 2
> make[3]: *** [drivers/firmware/efi] Error 2
> make[2]: *** [drivers/firmware] Error 2
> make[1]: *** [drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [__sub-make] Error 2
> 
> -Souptick
> 

Patch is here:
https://lore.kernel.org/bpf/20200605150638.1011637-1-nivedita@alum.mit.edu/


thanks.
-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
