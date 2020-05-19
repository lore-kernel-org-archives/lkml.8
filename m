Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC89C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F43207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IO0t+/Xw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgESPCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgESPCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:02:15 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F43C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1pGtsBo5aOZTLv1u9iVXQX/bDAadqeLEppbHbTjdp4k=; b=IO0t+/Xwp5xyMj7qc1jMk6LQR
        CE/R6Y9eOaBlMnb1FKriyi12K2IFP1vzmt/cm421S0yngnGOi/HZRhFdjiN94gPUNOppJ5fWC1DhY
        DLB9ky1yKCdHdkm0fpVaGedDOCcPqCa2oiebchwHaRkPv1722dpx37NaVohILYMzxR4XJxBdJqjTm
        3l7EDAYm8cXcT/dTfgBEXJKcoxsh/yvKvQbjDkGI9Wd8P1tEoLkYrTUborIBMkWl18JDoOYBzfeIZ
        Lj5RHmojzi5UrjbakD2DBucM+Ye+bR5GLfP8qkiDbRXyc32Afp8DfmspXGR0tFb3Enn2X0VHLyy2v
        uO876bNNw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:42290)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jb3kr-0005gS-Dc; Tue, 19 May 2020 16:02:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jb3kq-0005ot-5Q; Tue, 19 May 2020 16:02:04 +0100
Date:   Tue, 19 May 2020 16:02:04 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     linux-arm-kernel@lists.infradead.org, oleg@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: Implement functions for HAVE_FUNCTION_ARG_ACCESS_API
Message-ID: <20200519150204.GG1551@shell.armlinux.org.uk>
References: <20200519143132.603579-1-andrew@aj.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519143132.603579-1-andrew@aj.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 12:01:32AM +0930, Andrew Jeffery wrote:
> This allows extraction of kernel function arguments via kprobes on ARM.
> Based on the arm64 implementation and adapted for the 32-bit AAPCS.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> The description for HAVE_FUNCTION_ARG_ACCESS_API was pretty vague on what was
> required. I've implemented enough to enable argument extraction for kprobes; is
> there anything else needed to satisfy HAVE_FUNCTION_ARG_ACCESS_API?

What about 64-bit arguments?  How do they get handled?

regs_get_kernel_argument() talks about 'n' being the argument number,
and maps this directly to a register.  If a function argument
prototype is:

	(something *foo, long long bar, int baz)

The foo is in r0, bar is in r2/r3 on EABI, and baz is on the stack.

n=0 will return foo.  n=1 will be undefined.  n=2 will return part of
bar, and n=3 will return the other half.  Is this what is expected?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
