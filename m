Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50865C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FB3206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xVbecPPq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgEOVG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEOVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:06:28 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC634C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rVW8KezM3i3HcZ5WoaIxiJ9RRMgtGJtV0/SuZwNn25U=; b=xVbecPPq9oJGttjPZ+wLz1nfl
        0Wyv5gVizqqLjk/7dSGcf05+nUTO/+vUG57jxAUcdyZSrAf/NrRiL0dovMKAXqDhv719/HOf50ieD
        6S3IJTlNoGIlQo+Mhx01Qzlt0bf00oR6z5WDhWcNorOZiSEaxOiUDpqdQNznYVH6XiCNqkvWCVxkx
        8GNzLn6CrD4aOEW7oJ/KDIxD27cge6AsPgrjclDCAeumWWbdw1+/eKFpgZjEHAMhGI66xeP3wVJ1e
        1e2YVtALC/wbMPk1YbXxb6GuSheNlok+UT6JvYteYh44uEvUoDakiiNUBEc8rQQ4Oc6e5H6KfR4w2
        XU2rHKvxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:60910)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jZhX2-0006kl-Mb; Fri, 15 May 2020 22:06:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jZhX1-0001rt-5y; Fri, 15 May 2020 22:06:11 +0100
Date:   Fri, 15 May 2020 22:06:11 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: kexec: arm: possible overwrite of initrd
Message-ID: <20200515210611.GS1551@shell.armlinux.org.uk>
References: <20200515135712.GA5979@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515135712.GA5979@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 03:57:12PM +0200, Corentin Labbe wrote:
> Hello
> 
> Following https://lkml.org/lkml/2020/4/6/96 I was able to boot my Cubieboard4 via kexec reliabily.

You can try increasing the kernel size that kexec thinks the kernel
needs, but it should be extremely accurate with modern kexec.

--image-size $((0x01dc8154 + 0x10000))

will add 64k on top of what you currently have.  Note where the first
figure comes from (you'll find it in the debug output, see
"Resulting kernel space").

The best I can say is try playing around with that - but, kexec's
calculations should be spot on to stop the booting kernel from
overwriting the initrd.

The only way to debug that is to get the booted kernel to hexdump the
initrd so it's possible to see what happened to it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
