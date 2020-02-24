Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246E3C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E67EE20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 07:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582530419;
	bh=x8vWVdrCVtYmpsdSTYu+lTyddkui5cEZft/LbfgJlQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lvwAkrfNKCrXGx8duuCW5PqP4kBqi3FGtgiTWEFVDky8/n16aKE43RXH/MUt+DfyQ
	 eqZp1CcCKtKy8I9xK46SE30K9tpfhmOMckzroWFJR/hAi2JM4yZY71Sz8ceyzsgiE/
	 rQqzp0xyIKWWN7bBajvltFGEXlp06cFL3erkjzrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgBXHq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 02:46:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbgBXHq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 02:46:57 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F042420675;
        Mon, 24 Feb 2020 07:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582530417;
        bh=x8vWVdrCVtYmpsdSTYu+lTyddkui5cEZft/LbfgJlQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lipfdEm0MWk7qTMKMmxondt7aV1ammLyd8fB/RxWmkr1XyGtJfqwrRvwIQAGwIEKv
         LnAP/074CSmXimzPb6CvuA7a29S2hRnrX88pD1gVZvYfGzpndwAalCpPfWMSOvNjP6
         xc0EDxlse5qaYwzPUn+qoKrIc/cKKJMQ361HFP7o=
Date:   Mon, 24 Feb 2020 15:46:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx: Align ocotp node name
Message-ID: <20200224074648.GZ27688@dragon>
References: <1582253153-22053-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582253153-22053-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 10:45:53AM +0800, Anson Huang wrote:
> Node name should be generic, use "ocotp-ctrl" instead of "ocotp"
> for all i.MX6 SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
