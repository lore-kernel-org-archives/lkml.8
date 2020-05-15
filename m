Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68366C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C422206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Hup5ZOpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgEOSu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgEOSu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:50:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B89C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:50:56 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d67004cd1c8a6a574a4fa.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6700:4cd1:c8a6:a574:a4fa])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 27A941EC02DD;
        Fri, 15 May 2020 20:50:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589568655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YP9RZMqjeJZdVRtJI2gZU8UCFpzgV4mlHCpsx0w8oyQ=;
        b=Hup5ZOpB1Xg26Fj3NIW+wcvZivoPvwYsr5cO9V6lKmE+EyALZrZuI/JCrQWx9dsN2FGObm
        XZq9Rpw1QKsBdbI9egp4rs2K11bEJR9iWtYaH8BxR8i6lTx/L0CQyD3bYI4CmxCANmA1kg
        G3mvDAhosBfq27HSXduiQinmStc7k1c=
Date:   Fri, 15 May 2020 20:50:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dmitry Golovin <dima@golovin.in>
Cc:     clang-built-linux@googlegroups.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: allow a relocatable kernel to be linked with
 lld
Message-ID: <20200515185051.GC19017@zn.tnic>
References: <20200501084215.242-1-dima@golovin.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200501084215.242-1-dima@golovin.in>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 08:42:13AM +0000, Dmitry Golovin wrote:
> LLD by default disallows relocations in read-only segments. For a

I need more info here about which segment is read-only?

Is this something LLD does by default or what's happening?

Because my BFD-linked vmlinux has:

Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000001000 0x0000000000000000 0x0000000000000000
                 0x000000000070fa28 0x0000000000726b00  RWE    0x1000
  LOAD           0x0000000000000000 0x0000000000727000 0x0000000000727000
                 0x0000000000000000 0x0000000000007000  RW     0x1000
  DYNAMIC        0x00000000007108f8 0x000000000070f8f8 0x000000000070f8f8
                 0x0000000000000130 0x0000000000000130  RW     0x8
  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x0000000000000000 0x0000000000000000  RWE    0x10

so what's up?

> relocatable kernel, we pass -z notext to the linker to explicitly
> allow relocations. This behavior is the default for BFD.

Or are you saying that ld.bfd makes the text segment by default RW while
ld.lld makes it read-only like the elf manpage says:

"p_flags
              This member holds a bit mask of flags relevant to the segment:

              PF_X   An executable segment.
              PF_W   A writable segment.
              PF_R   A readable segment.

              A text segment commonly has the flags PF_X and PF_R."

IOW, don't be afraid to be more verbose in the commit message. :)

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
