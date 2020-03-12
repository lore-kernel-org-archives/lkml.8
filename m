Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5F3320716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584023256;
	bh=NBfZaoPVGopy564X9jgj14gpTLz9p4AtaD57fbxxlBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pcKuuo95y8u25p1URs8QkdHGopKF7OfBvBqqbOeyf3UK4H0wRzmL56thAQUb9AhK7
	 JHG/qa46MmLusKuuyv/m8FvDbOjqPUX/Wo5Y+YooyeOFm7HIl4NUguy4Z4Vzvks2x1
	 J9HI1F+XxoK6IBQGuQaGs8xkGHmYXxskE/nJu3z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgCLO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:27:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727340AbgCLO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:27:35 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 095EE20650;
        Thu, 12 Mar 2020 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584023254;
        bh=NBfZaoPVGopy564X9jgj14gpTLz9p4AtaD57fbxxlBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/VzJofeHWyEZaMZ4TO3oapRN+d4deZwCz/ZgR9waOARWpnw4C+EdWAQXMvbGxxNi
         fjFr/M1u+iH9Yys4vFp8Oc3vZPpIA9Cf2x6INiJFNJymPQ4zeovLQOGz8g7mp4jqxg
         Rsj+433EcZYFxIp9Qg8SYcEkI+zfwKS0RaAczCck=
Date:   Thu, 12 Mar 2020 22:27:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com, robh+dt@kernel.org,
        mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, catalin.marinas@arm.com,
        will@kernel.org, leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        peng.fan@nxp.com, aford173@gmail.com, ping.bai@nxp.com,
        jun.li@nxp.com, shengjiu.wang@nxp.com, bjorn.andersson@linaro.org,
        olof@lixom.net, vkoul@kernel.org, dinguyen@kernel.org,
        marcin.juszkiewicz@linaro.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 RESEND 4/4] arm64: dts: imx8mm: Add thermal zone
 support
Message-ID: <20200312142721.GC1249@dragon>
References: <1582947862-11073-1-git-send-email-Anson.Huang@nxp.com>
 <1582947862-11073-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582947862-11073-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 11:44:22AM +0800, Anson Huang wrote:
> Add thermal zone and tmu node to support i.MX8MM thermal
> driver, ONLY cpu thermal zone is supported, and cpu cooling
> is also added.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
