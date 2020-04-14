Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89CA6C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D93206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586868809;
	bh=1Ze3diwrbjA7BtxT3+FyzxurdagX5pNnS3OkXL/9zBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qjFbVhfkICjZEd4yiwnaBY190ewQHzflbRqxWFo7qq1IOmm6hBWoEku0KJAnYHoCS
	 sMi8rnQ1cz82gqXQM/IxnjYgLcuBQzNQ1zsYKkmvJ+x6JywRyzxnQFVsyBlSVRO8RY
	 4PftpJaWiR1Sv5J6+Rq6CawDhhIVY+zIug+RywO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502285AbgDNMx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:53:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2502214AbgDNMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:53:12 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57B5206A2;
        Tue, 14 Apr 2020 12:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586868791;
        bh=1Ze3diwrbjA7BtxT3+FyzxurdagX5pNnS3OkXL/9zBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ltk6dIVxKSMbIoO/6xziiLfPHOBD06ak/vGRajgw9Fr20DqRWd0bFwPdbcC7aH9uB
         sc3uwRBMIu6ITAnSc6IxD3dZJRYnViF4Usu/Es3m1eIM+4kxEvwB3R4tj1vXffvn6p
         OKFv1jDjpsHeGTSiIAIX1jgUjYVgWEIPlGuaxDAQ=
Date:   Tue, 14 Apr 2020 20:53:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, daniel.baluta@nxp.com,
        leonard.crestez@nxp.com, alifer.wsdm@gmail.com,
        shengjiu.wang@nxp.com, ping.bai@nxp.com, jun.li@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-evk: Add secondary cpus supply
Message-ID: <20200414125302.GA30676@dragon>
References: <1584006465-28494-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584006465-28494-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 05:47:44PM +0800, Anson Huang wrote:
> Each cpu-core is supposed to list its supply separately, add
> supply for secondary cpus.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
