Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC0C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0076920644
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586872402;
	bh=NMgaJWPe4RE4D3u/3SBXJpCKZ4XxNpOnSyZRc7k5tbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZiJqe/gH/HcvB/0expe9Mh5ut/ccD8ppQRKV4/AO2wLDxtbqQ7fN0CDM2VnJr+0VT
	 wtW3Xwa9sjuqbS02B+rpPAytW8FxIgWKJFzjgD+pDtMs4DSkH15XFNTpNE8c+W+R86
	 kpmsOlS/kf2tg5mENAqLhmGdPPPS+AdorHfE+YFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388280AbgDNNxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388218AbgDNNxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:53:08 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70CC120578;
        Tue, 14 Apr 2020 13:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586872387;
        bh=NMgaJWPe4RE4D3u/3SBXJpCKZ4XxNpOnSyZRc7k5tbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CudoBOfEyjeqmmwvYEIPftXzpeUzw5+Cy6BUccfqOT3cIISFTCPazo7HfRSXpztoT
         NjE4RiM8deXAGQlf4/qdTKXYLTpng5umh65laz6DstCZmM4I+CJ5upNODbcrp9wrEV
         th/FI7taIOx+mDvhMHQcZxcEvIeuAaCJVi378o3Y=
Date:   Tue, 14 Apr 2020 21:53:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        leonard.crestez@nxp.com, abel.vesa@nxp.com, l.stach@pengutronix.de,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx8m: No need to put node when
 of_find_compatible_node() failed
Message-ID: <20200414135259.GG30676@dragon>
References: <1584409053-23116-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584409053-23116-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 09:37:33AM +0800, Anson Huang wrote:
> No need to put node when of_find_compatible_node() failed, return
> immediately to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
