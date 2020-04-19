Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FA7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D742B21973
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mQ1sT2hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgDSOMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgDSOMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:12:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B26C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iPI9+C0OmqfHPSjDQhvBPW39Tw6U8V5gfT1X3EF41SM=; b=mQ1sT2hPGhAt68e7vQDBJLtWe
        tXEG+VFuhHJl3fOhDrSSB6Lfqa+n7I4RsLet3ztr/tzhtShrGLXbf5HgKVjGXcc6hoZ5koq4y1Wgf
        JNGyt4hhi/MMu2aG+/Oj+DkH/1+1BJut5H2ufCV68abNmr0xqcH0Q9d7K/gaPTrZp30cVPs9oXckN
        pygghQzjGu/RtBXwTFQwsnJ3+gJldt8LTwjy1r++fqTVwAQAQErT11rN3RY8mV0GhHY/BaTiI/l+/
        EorvK49Ned6aio1wv9gljpZTuQmRS00qFCes27XvwBWLfIOXflwdASdV7d7iVlm+S7ebG1ms7Gk8Z
        zD+wsLEtw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:40538)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jQAgZ-0005zm-NF; Sun, 19 Apr 2020 15:12:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jQAgP-0004uU-GD; Sun, 19 Apr 2020 15:12:29 +0100
Date:   Sun, 19 Apr 2020 15:12:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     clang-built-linux@googlegroups.com, arnd@arndb.de,
        ard.biesheuvel@linaro.org, ndesaulniers@google.com,
        linux-kernel@vger.kernel.org, jiancai@google.com,
        yamada.masahiro@socionext.com, manojgupta@google.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/3] ARM: make use of UAL VFP mnemonics when possible
Message-ID: <20200419141229.GX25745@shell.armlinux.org.uk>
References: <cover.1587299429.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1587299429.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 02:35:48PM +0200, Stefan Agner wrote:
> To build the kernel with Clang's integrated assembler the VFP code needs
> to make use of the unified assembler language (UAL) VFP mnemonics.
> 
> At first I tried to get rid of the co-processor instructions to access
> the floating point unit along with the macros completely. However, due
> to missing FPINST/FPINST2 argument support in older binutils versions we
> have to keep them around. Once we drop support for binutils 2.24 and
> older, the move to UAL VFP mnemonics will be straight forward with this
> changes applied.
> 
> Tested using Clang with integrated assembler as well as external
> (binutils assembler), various gcc/binutils version down to 4.7/2.23.
> Disassembled and compared the object files in arch/arm/vfp/ to make
> sure this changes leads to the same code. Besides different inlining
> behavior I was not able to spot a difference.
> 
> In v2 the check for FPINST argument support is now made in Kconfig.

Given what I said in the other thread, Clang really _should_ allow
the MCR/MRC et.al. instructions to access the VFP registers.  There
is no reason to specifically block them.

As we have seen with FPA, having that ability when iWMMXT comes along
is very useful.  In any case:

1. The ARM ARM (DDI0406) states that "These instructions are MRC and MCR
instructions for coprocessors 10 and 11." in section A7.8.

2. The ARM ARM (DDI0406) describes the MRC and MCR instructions as
being able to access _any_ co-processor.

So, Clang deciding that it's going to block access to coprocessor 10
and 11 because some version of the architecture _also_ defines these
as VFP instructions is really not on, and Clang needs to be fixed
irrespective of these patches - and I want to know that *is* going to
get fixed before I take these patches into the kernel.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
