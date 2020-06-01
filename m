Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A33C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF310207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lLP7HgHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730129AbgFASiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729032AbgFAShm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:37:42 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27388C008630
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CpB7nCiOHth7G0+bKDlWGpYMQSufxub4WvL1UZYxUiM=; b=lLP7HgHyNrFOSucRGlI0jVd/9
        XQWkmPUBiOeOVFqJQRYfR8oZF/og/m2RQXsIISmVygdlgv+hwsIbsJVxsPCE2Odk5iAHPFQGVmhd6
        yJRo+Xohg/igU96un8t3FG3eCWOH52u+1pUvSwCbDYDmmDPoD2z+BFMU8KaQ4JP0/oRVRRY7tJ8JP
        NLRTI8N+AVR249xDDLmmHeZRQeqbwxGJcCthH28DMrO1RRgBynjvXEtgogo709jXA3lh8H+IpRo0Q
        GKbuviSTibX6fshgTHCtQAeEjCJTU6tRvFAqhEQyd4IsOD0+EaNJcUc7lD5ahqplO9HtsW9dQCR/w
        ItYnxLNiA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37610)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jfp8Q-00010n-AB; Mon, 01 Jun 2020 19:26:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jfp8F-0003XJ-QP; Mon, 01 Jun 2020 19:25:55 +0100
Date:   Mon, 1 Jun 2020 19:25:55 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Lukasz Stelmach <l.stelmach@samsung.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 3/5] arm: decompressor: define a new zImage tag
Message-ID: <20200601182555.GP1551@shell.armlinux.org.uk>
References: <20200601145502.GJ1551@shell.armlinux.org.uk>
 <CGME20200601162002eucas1p28eb08a42de6f313458e9391bd5976e90@eucas1p2.samsung.com>
 <dleftjwo4qsqqf.fsf%l.stelmach@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dleftjwo4qsqqf.fsf%l.stelmach@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 06:19:52PM +0200, Lukasz Stelmach wrote:
> It was <2020-06-01 pon 15:55>, when Russell King - ARM Linux admin wrote:
> > On Mon, Jun 01, 2020 at 04:27:52PM +0200, Łukasz Stelmach wrote:
> >> Add DCSZ tag which holds dynamic memory (stack, bss, malloc pool)
> >> requirements of the decompressor code.
> >
> > Why do we need to know the stack and BSS size, when the userspace
> > kexec tool doesn't need to know this to perform the same function.
> 
> 
> kexec-tools load zImage as low in DRAM as possible and rely on two
> assumptions:
> 
>     + the zImage will copy itself to make enough room for the kernel,
>     + sizeof(zImage+mem) < sizeof(kernel+mem), which is true because
>       of compression.
> 
>        DRAM start
>        + 0x8000
> 
> zImage    |-----------|-----|-------|
>             text+data   bss   stack 
> 
>                  text+data           bss   
> kernel    |---------------------|-------------------|
> 
> 
> initrd                                              |-initrd-|-dtb-|

This is actually incorrect, because the decompressor will self-
relocate itself to avoid the area that it is going to decompress
into.  So, while the decompressor runs, in the above situation it
ends up as:


ram    |------------------------------------------------------...
                 text+data           bss   
kernel    |---------------------|-------------------|
zImage                          |-----------|-----|-------|
                                  text+data   bss   stack+malloc

Where "text+data" is actually smaller than the image size that
was loaded - the part of the image that performs the relocation
is discarded (the first chunk of code up to "restart" - 200
bytes.)  The BSS is typically smaller than 200 bytes, so we've
been able to get away without knowing the actual BSS size so
far.


ram    |--|-----------------------------------------|---------...
       |<>| TEXT_OFFSET
kernel    |---------------------|-------------------|
          |<----edata_size----->|<-----bss_size---->|
          |<---------------kernel_size------------->|
zImage                          |-----------|-----|-------|
                                |<-------len------->| (initial)
				|<----------len------------>| (final)

The "final" len value is what the decompressor prints as the "zImage
requires" debugging value.

Hence, the size that the decompressed kernel requires is kernel_size.

The size that the decompressor requires is edata_size + len(final).

Now, if you intend to load the kernel to ram + TEXT_OFFSET + edata_size
then it isn't going to lose the first 200 bytes of code, so as you
correctly point out, we need to know the BSS size.

> >> +struct arm_zimage_tag_dc {
> >> +	struct tag_header hdr;
> >> +	union {
> >> +#define ZIMAGE_TAG_DECOMP_SIZE ARM_ZIMAGE_MAGIC4
> >> +		struct zimage_decomp_size {
> >> +			__le32 bss_size;
> >> +			__le32 stack_size;
> >> +			__le32 malloc_size;
> >> +		} decomp_size;

You certainly don't need to know all this.  All you need to know is
how much space the decompressor requires after the end of the image,
encompassing the BSS size, stack size and malloc size, which is one
value.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
