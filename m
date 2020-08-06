Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD94C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A200E20748
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 22:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kF/rEQ3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgHFW6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgHFW6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 18:58:32 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20BC061574;
        Thu,  6 Aug 2020 15:58:32 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i26so33003246edv.4;
        Thu, 06 Aug 2020 15:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VtslGrVU5SAGgzW7ltz0AWj8DRyVUchOuuqr0kZRa5k=;
        b=kF/rEQ3Upz30sy/q3PWqJOWBXzsQPT5udDoKLn0UMVtp2nGshMNkeBK7y2wl5N0nnp
         bDp82L6sUeACUxMObpLrF7kPXE9bRfbRGloAUa2dgzSqmy2ajLMpMznJFgWWYrKfLPlr
         9DvvgK1tvE/32QyHh3JRWLghCgw6rLbD6yz2ILaPOpfI+0Nqdd1w+a8HwMUmlPY3Rdnt
         kLDyvxpnv11bHNIFVrkAadk8H8pS476mcq4O6zg/vzEwQBCIWLX/txP6gf22EOkPGWOw
         woblvaqpzUw/7sM/zgEefGKYTAfM5HWFE/ymiPh0shUyjzjIhMxK0ZmE11EH7eivFFbk
         TdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VtslGrVU5SAGgzW7ltz0AWj8DRyVUchOuuqr0kZRa5k=;
        b=hKR2irNR1rW5+fmWjWXoYnNysNYlDvZMK0BOrcTXZhKuKM0gnICBk7WWRPm0BPHtIn
         +HZwIf1F2Zqh86uOgUMjGoLH7OKTRtt9EM9W0kmi4WudA3SgmprQ54L1p4akzcqMAWwD
         zAFlUX95LiOg5wxlvMhc+9G4FAhx4VXEInjvDIgdAzLMQqRvm0SYIZEcQj4u9uYxcV+G
         MexTsBWBI/J3N1JYpAf8SDSOFwuyUh3tqUW1zM9D8k8hzkrvbczOCOpxs1c0MI3VTGHu
         sYaaHXqGQA8hMHVPMNfJEHex+XOW4rQAByia92lStNuy2lHGOkVGyZ4iqPlEa35N8xCk
         gG6g==
X-Gm-Message-State: AOAM532X5SfODJWn2/dPjWPh4UWXsJzY/Lq7QsbQXrRp1i4ExN1UxBXq
        NZL/3zRvzwCfZ1Ff+sgnbP0wFqsrbyFXoVQtEes=
X-Google-Smtp-Source: ABdhPJy7M1v3UbuJwCxS7d3k0GfNAu1Z2svSkVIyAj9XiXhqCh18sFq+Q96lb3zshRUkqnjrLeBL4eXChstRAtRq59E=
X-Received: by 2002:a05:6402:1855:: with SMTP id v21mr6335735edy.355.1596754710231;
 Thu, 06 Aug 2020 15:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAMdYzYoqKcG+LtFZy+TeYWB=GJo8Ya60r3Los4T5j7j3Okdbtw@mail.gmail.com>
 <20200806222254.GF1551@shell.armlinux.org.uk>
In-Reply-To: <20200806222254.GF1551@shell.armlinux.org.uk>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 6 Aug 2020 18:58:18 -0400
Message-ID: <CAMdYzYoa52gZ5TdPU366QoaVjGFxPxvjTn15ipyNp428iR_Seg@mail.gmail.com>
Subject: Re: [PATCH] arm: Add support for ZSTD compressed kernel
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     nolange79@gmail.com, linux-kernel@vger.kernel.org,
        Petr Malat <oss@malat.biz>, Kees Cook <keescook@chromium.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 6:22 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Thu, Aug 06, 2020 at 05:46:50PM -0400, Peter Geis wrote:
> > Good Evening,
> >
> > I had attempted to get this working as well, but have run into
> > difficulties with both my implementation and yours as well.
> > My implementation was almost the same as yours, with the exception of
> > also changing:
> > @@ -303,7 +305,7 @@ restart: adr r0, LC1
> >
> >  #ifndef CONFIG_ZBOOT_ROM
> >   /* malloc space is above the relocated stack (64k max) */
> > - add r10, sp, #0x10000
> > + add r10, sp, #0x30000
> >  #else
> >   /*
> >   * With ZBOOT_ROM the bss/stack is non relocatable,
> >
> > On QEMU this implementation works fine.
> > However on bare metal tegra30, I get the following error:
> >
> > Jumping to kernel at:4861 ms
> >
> > C:0x80A000C0-0x8112BA40->0x8152C700-0x81C58080
> > Uncompressing Linux...
> >
> > ZSTD-compressed dstSize is too small
> >
> >  -- System halted
> >
> > The only difference between the bare metal test and the qemu test is
> > the zImage with appended dtb is packaged in the android boot format
> > for the bare metal test.
> > Otherwise it's exactly the same file.
>
> So it's relocating the compressed kernel and decompressor from
> 0x80A000C0-0x8112BA40 to 0x8152C700-0x81C58080 and then failing.
> Does the QEMU version also do similar?

Here is the output from QEMU, note boot doesn't work because this
image isn't for QEMU:

C:0x400100C0-0x4073B1E0->0x4152C600-0x41C57720
Uncompressing Linux... done, booting the kernel.

>
> On the off-hand, I'm not sure why it should fail.  I assume that
> you've tried the other decompressors and they work fine on the
> same setups?

Correct, all other compressors work.
ZSTD is handy for arm because size and speed are both important.

>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
