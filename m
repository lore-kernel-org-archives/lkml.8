Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7048FC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4139420674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 01:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584322400;
	bh=P3cq495tgq4ifTa5c3/W4DsSgs2FTFImzz2EA50xynQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGisgMwPSHL7Gthd646+c7/sz3JkgOdb0k6ieiLrXqsF0PRj6DWQCVYk7o2nwEP6D
	 eREabqoXVr3WGBptjxX4HXFkgqlyehB2cbeDo6afIRDS+I3IC/L2tThq8KD+L1Hw/m
	 6t8O1LS5fdGo4MQTaZ9bMoP4wwmNKRUAnTDznJRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgCPBdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 21:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgCPBdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 21:33:18 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FA1620663;
        Mon, 16 Mar 2020 01:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584322398;
        bh=P3cq495tgq4ifTa5c3/W4DsSgs2FTFImzz2EA50xynQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbDdyxp8Vw+fAjuRuSXRETN9asPjzSbPamvOhRaCdYDkv1uNJNavCulyvyzGxhxrX
         2FoA7v3UucbIVQuqCgYBDFA2kWKnC3S242PGHi9nFiRgUDeeaMNVEzik8xl1GhGmd2
         m4jN0TNrzroKXpf/A3auRmq0hP4aPYXsC/hj3GQ0=
Date:   Mon, 16 Mar 2020 09:33:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] Enable drivers for NXP/FSL QorIQ arm64 boards
Message-ID: <20200316013312.GQ17221@dragon>
References: <20200311225317.11198-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311225317.11198-1-leoyang.li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:53:02PM -0500, Li Yang wrote:
> The series enables necessary drivers for the QorIQ reference boards
> supported in mainline.
> 
> Li Yang (15):
>   arm64: defconfig: run through savedefconfig for ordering
>   arm64: defconfig: Enable NXP flexcan driver
>   arm64: defconfig: Enable QorIQ DPAA1 drivers
>   arm64: defconfig: Enable QorIQ DPAA2 drivers
>   arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
>   arm64: defconfig: Enable NXP/FSL SPI controller drivers
>   arm64: defconfig: Enable QorIQ cpufreq driver
>   arm64: defconfig: Enable ARM SBSA watchdog driver
>   arm64: defconfig: Enable QorIQ IFC NAND controller driver
>   arm64: defconfig: Enable QorIQ GPIO driver
>   arm64: defconfig: Enable ARM Mali display driver
>   arm64: defconfig: Enable flash device drivers for QorIQ boards
>   arm64: defconfig: Enable RTC devices for QorIQ boards
>   arm64: defconfig: Enable PHY devices used on QorIQ boards
>   arm64: defconfig: Enable e1000 device

Applied all, thanks.
