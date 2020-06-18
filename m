Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682542070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ncAx5x+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbgFRWDU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgFRWDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:03:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UYTpKINys5q7UogH0MrXFzt2ML29Bof5pSVpOvGOBQ8=; b=ncAx5x+1YGICOfIWpHwKkomK9
        bND/1aWxxt+dgshqhYPBXFpArncVqbfSpKhYYKFMqXYTUq0weEfJoNO5xoajbmF4Xw+JwLx2Lsndl
        lkxwRGIwqOX+S0+HY62LFPEY4JqWQSBBmMpTlntAoPkg98Uqv8GlRl/NtR+gU2yTmffokTIGloIL/
        mAOXdyc6hA1UGOlLD82lVTlMf0GMRaskW9nh19t9yPzq5DZwQfNKKSKMwyZ5FlCy4QOm+kq/mLHkY
        emSGuEZAh2W/Vt4zzQxh2kQqcLaryFyoBGCBHXVV6oquxU8/SBSVCTuoyIdz6Uwhb94XgFmkpy/Vb
        auvbi4H8A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58806)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jm2cs-0005cS-G5; Thu, 18 Jun 2020 23:03:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jm2cq-00052r-7D; Thu, 18 Jun 2020 23:03:12 +0100
Date:   Thu, 18 Jun 2020 23:03:12 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Nathan Huckleberry <nhuck@google.com>, vincent.whitchurch@axis.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] Fix unwind_frame for clang-built kernels
Message-ID: <20200618220312.GK1551@shell.armlinux.org.uk>
References: <20200616223633.73971-1-nhuck@google.com>
 <CA+icZUW4Jv7589yCU55+C-P0=B0ztzvsOZ9TEMcTt4vKjFU1dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUW4Jv7589yCU55+C-P0=B0ztzvsOZ9TEMcTt4vKjFU1dA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:23:48AM +0200, Sedat Dilek wrote:
> On Wed, Jun 17, 2020 at 12:36 AM 'Nathan Huckleberry' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Since clang does not push pc and sp in function prologues, the current
> > implementation of unwind_frame does not work. By using the previous
> > frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
> > kernels.
> >
> > The bounds check on next frame pointer must be changed as well since
> > there are 8 less bytes between frames.
> >
> > This fixes /proc/<pid>/stack.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/912
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
> 
> Just a small nit.
> 
> Please label your patch with: "arm/stacktrace: ..." or "arm: stacktrace: ..."

Convention is to use "ARM: ..." for arch/arm.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
