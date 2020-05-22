Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DD2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9187C207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590139010;
	bh=+P5DbH+AIsYNWPmv6pViWEeIbunPXxfLSvFWHwHY8gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i6l4I6FS44CWZtxIAFw0/945p73qVPjxYoboj1t35TKvYRGkZHEFSGE2aFL0HNclA
	 P0q/oQzzyw2uCbCerz4z9TqQB6enby0CPN9bzlpLIv7qHbyTzEfOgBuxDTrTxcGAC9
	 EIKi10Mhy39bseaMForlmavE2wlvS2R1Mipr0qLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgEVJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgEVJQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:16:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F302206B6;
        Fri, 22 May 2020 09:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590139009;
        bh=+P5DbH+AIsYNWPmv6pViWEeIbunPXxfLSvFWHwHY8gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2MET8yL0hrR9szNF2qjGr0Q9f0XmZYyeRzfO9cwgnzRc7gE9C2hqJAuL4QyCjPEuh
         S+jCF+1hyELdBX2llOqy+gwMrDj5FyKDkyYBsau7ZXRRWnXm+CIyaoqo6qvoHrTz37
         L/u84VnMTLHqiQ9giljAjryHZXmtc5aCdRcfwrt8=
Date:   Fri, 22 May 2020 11:16:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     ulf.hansson@linaro.org
Cc:     rui_feng@realsil.com.cn, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [V2] mmc: rtsx: Add SD Express mode support for RTS5261
Message-ID: <20200522091646.GA1201234@kroah.com>
References: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589875163-3367-1-git-send-email-rui_feng@realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 03:59:23PM +0800, rui_feng@realsil.com.cn wrote:
> From: rui_feng <rui_feng@realsil.com.cn>
> 
> RTS5261 support legacy SD mode and SD Express mode.
> In SD7.x, SD association introduce SD Express as a new mode.
> SD Express mode is distinguished by CMD8.
> Therefore, CMD8 has new bit for SD Express.
> SD Express is based on PCIe/NVMe.
> RTS5261 uses CMD8 to switch to SD Express mode.
> 
> Signed-off-by: rui_feng <rui_feng@realsil.com.cn>
> ---
> v2: remove config option MISC_RTSX_PCI_SD_EXPRESS 
> ---
> 
>  drivers/misc/cardreader/rts5261.c  |  5 ++++
>  drivers/misc/cardreader/rts5261.h  | 23 ----------------
>  drivers/misc/cardreader/rtsx_pcr.c |  5 ++++
>  drivers/mmc/core/sd_ops.c          |  9 ++++++-
>  drivers/mmc/host/rtsx_pci_sdmmc.c  | 43 ++++++++++++++++++++++++++++++
>  include/linux/mmc/host.h           |  1 +
>  include/linux/rtsx_pci.h           | 27 +++++++++++++++++++
>  7 files changed, 89 insertions(+), 24 deletions(-)

If I can get an ack from the MMC maintainer, I can take this in my
tree...

{hint}

thanks,

greg k-h
