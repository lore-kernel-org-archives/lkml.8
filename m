Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50101C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1682465A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583812205;
	bh=V6Fs8/S/s0dumZ8zRQ2hxKHD2zRTiM/tcLO3wbRf1kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EAgTAGSgHig/zcKEYd/vDpked7kDT4xD2pcXgxqlxgE2HBnUWcQ+Ua3sPyEweH5pk
	 qUwBLIEgTlBuItHBoKowHrRosGIkdP2XKLJV2G5SOINX3Okffe9ZHZypa5+fD+PcPg
	 ab+T5c/GgCI1ybQM+s4CHat7SEMHNeh6R8oEh8xQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCJDuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 23:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgCJDuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 23:50:04 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82D2C24649;
        Tue, 10 Mar 2020 03:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583812203;
        bh=V6Fs8/S/s0dumZ8zRQ2hxKHD2zRTiM/tcLO3wbRf1kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivKooelmrdr2ntwdFFobIbBeuTiXiBvIXHsTpFFwRrULfocXoxWtCuXUUh8m10p+q
         ffDvYRUJS/2/uCvGDJMi899BuzsVAk0YyahYb61AwXylOFPaxlISzpQiSrXB9jQKKm
         RPlE6G6Y0z9z4AvnC34I5bqpZmicTJzGkDsjDQaQ=
Date:   Tue, 10 Mar 2020 11:49:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        Anson.Huang@nxp.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com, peng.fan@nxp.com,
        fugang.duan@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] arch: arm64: dts: imx8qxp: add device node for I2C
 and INTMUX in CM40 SS
Message-ID: <20200310034953.GD15729@dragon>
References: <1581909561-12058-1-git-send-email-qiangqing.zhang@nxp.com>
 <1581909561-12058-6-git-send-email-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581909561-12058-6-git-send-email-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:19:19AM +0800, Joakim Zhang wrote:
> Add device node for I2C and INTMUX in CM40 SS.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>

The 'arch:' prefix in subject is not necessary.

Shawn
