Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F986C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1CC5206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="lNFJs5P4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgDFJQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:16:24 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:49352 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDFJQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qxYNJ7LCMvpTUzf0Ee+5RLGYAIShFJ7XrqkBYcoJs0s=; b=lNFJs5P4ofOPA5mxIwg7fRuEt
        0EQm6naG95vkJkT7SDO5wDMVVCbrKFjuVBTGTIKejMMRX/KLGzRrFJYUao3S9YOAVTYtHhuePzlzG
        j7QqnhGBQ3ytPAMWyzblIFCZeHOluhiqlAIIeNjfPgeULXLJ9djdXf+/RORwSowPAcl0xAG4aar5x
        SGrip2fl8CkOsLM1pdZpSjJRCnJ/DeIpfD9xWjuBLS96NYXzo2xLIMlshqZxqaam7HYcjnBJfJ/13
        0EROtBjZ7pLVM7bJfU/mt1KReGCbharCmWZFWrhhUg25TJg7TdV1vd6GHEblV4ArnRfdnbdqX7Bir
        58ESznODw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:42204)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jLNrP-0000cL-Q8; Mon, 06 Apr 2020 10:16:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jLNrM-0005X5-LI; Mon, 06 Apr 2020 10:16:00 +0100
Date:   Mon, 6 Apr 2020 10:16:00 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     ebiederm@xmission.com, kexec@lists.infradead.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, mripard@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Trying to kexec on Allwinner A80
Message-ID: <20200406091600.GF25745@shell.armlinux.org.uk>
References: <20200406082720.GA31279@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406082720.GA31279@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 10:27:20AM +0200, Corentin Labbe wrote:
> Hello
> 
> I am trying to add the last missing Allwinner Soc in kernelci: the A80.
> But this SoC does not have any way to be used in kernelci, no USB nor network in uboot.
> So I have tried to fake uboot since the kernel has network support and run the new kernel via kexec.
> 
> But kexec 2.0.18 fail to work:
> kexec --force /tmp/kernel --initrd /tmp/ramdisk --dtb /tmp/dtb --command-line='console=ttyS0,115200n8 root=/dev/ram0 earlycon=uart,mmio32,0x7000000 ip=dhcp'

What happens if you omit the dtb argument?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
