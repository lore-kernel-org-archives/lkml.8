Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65187C35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBD820828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 12:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="g1I9RIlP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgBXMDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 07:03:14 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:39532 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbgBXMDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 07:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=t5KPllfCzU4AasIlRCx7IzfWUIVfM/xDWS4+N7wn5YA=; b=g1I9RIlPEPLzZWdOSbIZxCjpj
        LpMV7CqOwjfFjrIcnMazJf2/Mmg90x8pv9//qmp8jQeSXfZjcEgb41hEb0Cpa+JHdndB/RDrHMXEl
        kWz02pgsYVHwIV4OEGIvsFv7Zm5QioaBlb2MUhpFH7eu7fQoVzymGUxZZ0fMCIkyqDk1cT36KuBGE
        iO73eFzbLIc6kluM0d8NpnNsm0iSbUFe1j3WLJFgVwOe69LzYFiPwTvkfQdqP98jFOyoqtFohXZQJ
        NGcvXqREeIXSER4KikTrW7pnujpKNi56cCH2F1FGoJqfsDl2o/y/N349pCffazDf2+vgVaH715U5T
        EkbTycHjg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56262)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1j6CS5-0002Xr-Ky; Mon, 24 Feb 2020 12:03:09 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1j6CRz-0006P7-9v; Mon, 24 Feb 2020 12:03:03 +0000
Date:   Mon, 24 Feb 2020 12:03:03 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     yifeng wu <y1feng.wu1234@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] arm/kernel/head.S: optimize
 __create_page_tables function
Message-ID: <20200224120303.GQ25745@shell.armlinux.org.uk>
References: <CAKy1Xqcnkfm7Dn9UvJ7Ufio-szQ75kbGS+GurBjuUFBydi21GA@mail.gmail.com>
 <20200224110508.GP25745@shell.armlinux.org.uk>
 <CAKy1XqdBt=LNpk-7Rt2LXU3tky=fS9jHxD0DV5CKh4wYWxFVRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKy1XqdBt=LNpk-7Rt2LXU3tky=fS9jHxD0DV5CKh4wYWxFVRQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 24, 2020 at 07:54:07PM +0800, yifeng wu wrote:
> Thank you very much for your reply.
> I have tested on my machine. It takes about 0.5 seconds to copy the memory
> (16M size) with "str" instruction, and only 0.1 seconds with "stmia"

ITYM 16k.  You say "copy" but we're setting memory to zero.  I'm quite
surprised by that difference, which CPU was this measured on?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
