Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202D520787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 14:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dRaieWLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgEROTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 10:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEROTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 10:19:10 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED85BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8QSHn1QbwUCK/fw9frbOwXuQvZTOpXzHqEg5WkOMan0=; b=dRaieWLESy24cHMis/kxDGiAx
        zLfzIagJbl0bsfF1dOo6xhygWQ1XvDTEaXsUwbO65HN1h5n/itjHT80u1pFJ8ACsohjB+J2S8pZbJ
        YLNHYVlM2qlIcltPJGTfyvXb85LxtImqjSKoMFqrihyrwmyFiTpNx4RkbQk/jmIZ52+X6yU3L562x
        elFI6QRrtmHZyVb2oh2a/mK5E7MJUOs8gU7avzmFhuC6iQgfJMadLMUJIY3Yc3ywHnXKVzJ7W0joU
        MBcU9XxQ2Pei5a4ZMs3+KzqgUdYF/qGK9C1wxJqBoVkHJ/5MSj5aPZJgSbGHQVozKGP9kbprjjsJp
        yXcEnYckQ==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:59570)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jagbc-0002a5-Jj; Mon, 18 May 2020 15:19:00 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jagbb-0004lT-70; Mon, 18 May 2020 15:18:59 +0100
Date:   Mon, 18 May 2020 15:18:59 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Fredrik Strupe <fredrik@strupe.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PING] [PATCH v2] arm: ptrace: Fix mask for thumb breakpoint hook
Message-ID: <20200518141858.GV1551@shell.armlinux.org.uk>
References: <20200413173841.29651-1-fredrik@strupe.net>
 <d7381f90-f597-2a9c-4387-5714b41e02e6@strupe.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7381f90-f597-2a9c-4387-5714b41e02e6@strupe.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 03:12:06PM +0200, Fredrik Strupe wrote:
> call_undef_hook() in traps.c applies the same instr_mask for both 16-bit
> and 32-bit thumb instructions. If instr_mask then is only 16 bits wide
> (0xffff as opposed to 0xffffffff), the first half-word of 32-bit thumb
> instructions will be masked out. This makes the function match 32-bit
> thumb instructions where the second half-word is equal to instr_val,
> regardless of the first half-word.
> 
> The result in this case is that all undefined 32-bit thumb instructions
> with the second half-word equal to de01 (udf #1) work as breakpoints
> and will raise a SIGTRAP instead of a SIGILL, instead of just the one
> intended 16-bit instruction. An example of such an instruction is
> eaa0b650, which is unallocated according to Arm ARM and should raise a
> SIGILL, but instead raises a SIGTRAP.

How can 0xeaa0b650 match 0xde01 when masked with 0xffff ?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
