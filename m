Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914FAC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6866A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582530701;
	bh=66Cc/Y6FUBqCiSi4OnMZIr7inydV8YlUeIUN39HgudY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yw0oRupvl/tvmhXEh3Og5Pt6cJohMgp9/w3lh5iAV5R/g32A7m7fGOxB4dpZF9OAL
	 ZO4iCfUP+aXKlEmQq5NOlg1xp2Iiagu+Pt+mt/UeeVdnocGESZCtlU9MTMRj5U1PGb
	 mXMRExyxMuCtCqW8DZNUVfs19rTY2s48gE7EZoQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbgBXHvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:51:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXHvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:51:40 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8024206E2;
        Mon, 24 Feb 2020 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530699;
        bh=66Cc/Y6FUBqCiSi4OnMZIr7inydV8YlUeIUN39HgudY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xgcAvprFUPw33SKJxG+uE75hIGEG32PfJrwR5/yij/lqhxHNaDrPHGoOmgqZemrG8
         K6EfkN6zyQXksAZN6d0lSWv3unFLAwTnmKW6K8fhGI8sb6HZcQmiEsPxq7FrT9y+wf
         Ci7X9Cb6N33ePg02cLirPI5ZvOic9Qqr4ZTMCebA=
Date:   Mon, 24 Feb 2020 15:51:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, horia.geanta@nxp.com, peng.fan@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2] arm64: dts: imx8mn: Adjust 1.2GHz OPP voltage to OD
 mode
Message-ID: <20200224075132.GB27688@dragon>
References: <1582510060-12272-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582510060-12272-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 10:07:40AM +0800, Anson Huang wrote:
> According to latest datasheet Rev.0, 10/2019, there is restriction
> as below:
> 
> "If VDD_SOC/GPU/DDR = 0.95V, then VDD_ARM must be >= 0.95V."
> 
> As by default SoC is running at OD mode(VDD_SOC = 0.95V), so
> VDD_ARM 1.2GHz OPP's voltage should be increased to 0.95V.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
