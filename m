Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C389CC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470E20735
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="WwQyW3eY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8470E20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbgDMHcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbgDMHcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:32:21 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1853C008651;
        Mon, 13 Apr 2020 00:32:20 -0700 (PDT)
Received: from flygoat-x1e (unknown [IPv6:240e:390:49e:92c0::d68])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id EEB2820D11;
        Mon, 13 Apr 2020 07:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586763139; bh=bhQVP41inNwzZ4QYRL2kZVsflSK4XBShSyjAeWvLFKA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WwQyW3eYa2lybRg3oCYp1RfX49ZM16W8iuJsja/D/MbTjwhPTHL/27832nqi1mmE7
         YrT2DZ4r/gne+9PV10KNIrGNDxcp08eWnHYWEw9vuEI1GL5qRqW0FLuOrSjJHEWY+6
         yMvl+TVtWx6CyBDaX0pTTMCoA8oGdf7HRzib0ALNQo7mG1zR0iJ0BLVhcLIbC5JAJV
         37QRkfTkMZlrQBRqzKimYzzBYR8Y3iT6+pYpL5PNYPFtVj/hyOTCjKkRjpwQ3LroSY
         OhEbudeVM+ogVIpHPzFLQPnQig3oy+ZkYTVnlz1xzJaNzqE1X34nxyUGnU8W9kMP8X
         F1BddQw4pHgKg==
Date:   Mon, 13 Apr 2020 15:32:05 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Borislav Petkov <bp@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] MIPS: Truncate link address into 32bit for 32bit
 kernel
Message-ID: <20200413153205.4ee52239@flygoat-x1e>
In-Reply-To: <alpine.LFD.2.21.2004130736410.851719@eddie.linux-mips.org>
References: <20200413062651.3992652-1-jiaxun.yang@flygoat.com>
        <alpine.LFD.2.21.2004130736410.851719@eddie.linux-mips.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 07:59:29 +0100 (BST)
"Maciej W. Rozycki" <macro@linux-mips.org> wrote:

> On Mon, 13 Apr 2020, Jiaxun Yang wrote:
> 
> > LLD failed to link vmlinux with 64bit load address for 32bit ELF
> > while bfd will strip 64bit address into 32bit silently.
> > To fix LLD build, we should truncate load address provided by
> > platform into 32bit for 32bit kernel.  
> 
> Reviewed-by: Maciej W. Rozycki <macro@linux-mips.org>
> 
> > diff --git a/arch/mips/kernel/vmlinux.lds.S
> > b/arch/mips/kernel/vmlinux.lds.S index a5f00ec73ea6..5226cd8e4bee
> > 100644 --- a/arch/mips/kernel/vmlinux.lds.S
> > +++ b/arch/mips/kernel/vmlinux.lds.S
> > @@ -55,7 +55,7 @@ SECTIONS
> >  	/* . = 0xa800000000300000; */
> >  	. = 0xffffffff80300000;
> >  #endif
> > -	. = VMLINUX_LOAD_ADDRESS;
> > +	. = VMLINUX_LINK_ADDRESS;  
> 
>  The CONFIG_BOOT_ELF64 cruft right above it looks interesting to me,
> never have ever been used.  We have had the current arrangement since:

It confused me either.
It's only used by SGI so probably it's time to rename it as
BOOT_SEG_ELF64.

Wish someone could clarify what is it.

Thanks.

> 
> commit 923ec3d20eef9e36456868b590873ce39f17fe71
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Wed Nov 6 22:16:38 2002 +0000
> 
>     Define load address in linker script instead of relying on the
>     deprecated and notoriously unreliable option -Ttext.
> 
> and previously `-Ttext' was used with this script anyway, though not
> very long, as the script was entirely ignored until:
> 
> commit 7a782968041ffc4c2d89816238e2f8ea5cceddba
> Author: Ralf Baechle <ralf@linux-mips.org>
> Date:   Thu Oct 31 23:54:21 2002 +0000
> 
>     Merge with Linux 2.5.36.
> 
>   Maciej

--
Jiaxun Yang
