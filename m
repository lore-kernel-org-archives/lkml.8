Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82EF2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594605757;
	bh=B2AzC/mSGfIVvO4a/OJC+/bayS2PwPoR0tQWN8fuaFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wbAi4woW8p6ReWicVq0FXWfWgV2NhzziulcsZbOg5BSRd699fu7mJewos/uRcgv9I
	 Z4orcEhCLcWag8XXW4rtU+KRPSJ/0F1mW5aDJvIJoBoGEOTPItYxRWS1L8oLQcSD9K
	 vbJCZBpF7ftCEHtVHFkOpx6qR9vnWnZZiihKXK2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgGMCCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMCCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:02:36 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 853622068F;
        Mon, 13 Jul 2020 02:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594605756;
        bh=B2AzC/mSGfIVvO4a/OJC+/bayS2PwPoR0tQWN8fuaFY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDVBu4eybs5dcjRE4DsNY7eOwr1LKD552SJXjIWoMAxKk2xeWI+1S74scWwmmOY0L
         lW5ENc62+lAk2GdjIgXKsLbFjbS2Zm73rFiCfTtmcSsi/wsq0gh5NDBzgQLS+eLKVm
         Qj/DWELkNkMkBWZ4hzocUJj8rpaLlZ/RgzT00PkA=
Date:   Mon, 13 Jul 2020 10:02:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, peng.fan@nxp.com,
        aisheng.dong@nxp.com, daniel.baluta@nxp.com,
        franck.lenormand@nxp.com, arnd@arndb.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH V3] firmware: imx: Move i.MX SCU soc driver into imx
 firmware folder
Message-ID: <20200713020228.GT21277@dragon>
References: <1593119647-30951-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593119647-30951-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:14:07AM +0800, Anson Huang wrote:
> The i.MX SCU soc driver depends on SCU firmware driver, so it has to
> use platform driver model for proper defer probe operation, since
> it has no device binding in DT file, a simple platform device is
> created together inside the platform driver. To make it more clean,
> we can just move the entire SCU soc driver into imx firmware folder
> and initialized by i.MX SCU firmware driver.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
