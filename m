Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A82C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3B3220732
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584789027;
	bh=dbj5j9p0+U/3W4j2ff4ulgbzHoaM6aNjysGbHm0rwZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zc27OLo9F3TVyJOVp/HGsDcc96lB1g0yLc2UYWnQVphNtbBtlf4Skkiw2j2AR8oJY
	 FA2P33EFYg4L9udJjTsOPSTZFZrxmYsJcBK9SsB8CuFtqYxsj7t/jHelX3/3cWaLrA
	 G740JW5C74ZvqMQROdC7N6CPWN7cAVSrt9a537Nc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgCULKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 07:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:38934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgCULKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 07:10:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F6D20732;
        Sat, 21 Mar 2020 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584789025;
        bh=dbj5j9p0+U/3W4j2ff4ulgbzHoaM6aNjysGbHm0rwZ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f/GT57AonrqPPAQqeb4/nZDwFP59yOIjUOvOG9b9tj+A/o+v7C3AHXGOS7XiCpphb
         jzIVSgs6hhoOkFR+G+m+kickqoWZ+f4YJSlRDkw7NjG3qc0i4sbTHie4Nl/IdXDuYn
         wJttGsAok0S9kfGSjrd/m75RYZWUyGEJtOGb+CNw=
Date:   Sat, 21 Mar 2020 12:08:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] PHY: For 5.7 merge window
Message-ID: <20200321110842.GA1169672@kroah.com>
References: <20200320223121.4821-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320223121.4821-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 21, 2020 at 04:01:21AM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the pull request for 5.7 merge window below. (Sorry for the
> delay).
> 
> It adds two new PHY drivers for supporting Qualcomm high Speed PHY and
> super speed PHY, redesigns phy-cadence-dp to phy-cadence-torrent driver
> since Cadence Torrent driver can support PCIe, USB, SGMII etc.. in
> addition to display port (support for the additional protocols will be
> added later).
> 
> It also adds support for Qualcomm's PCIe, UFS and USB2 PHY; TI's
> GMII PHY; Amlogic's USB2 PHY; Socionext's USB3/USB2/PCIe PHY.
> 
> Please see the tag message below for the complete list of changes.
> 
> Let me know If I have to change something.
> 
> Thanks
> Kishon
> 
> The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:
> 
>   Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.7

Pulled and pushed out, thanks.

greg k-h
