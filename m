Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A36C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915C7207DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594477945;
	bh=UqWFBHcsmz1nBysnWIV+Cuhkrsz5c16BQDv6NLgGk/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2PYVv9Df4TW1Z6SrnC57Qd3ywTb8cbLN7m0yDAy0WRendraXkNgVA1xoWuxUs7xCe
	 a9m/wlzZ0KW5Rw8TlySCWwiSW+plMNXo9df8rVueEBmNowE5Yb7aIYUpzkV1hXVFP5
	 R4TFGeRq/HzF0C+jny5fH1VZs/VwSA4fToWQVaQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgGKOcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 10:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgGKOcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 10:32:24 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14BB220720;
        Sat, 11 Jul 2020 14:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594477943;
        bh=UqWFBHcsmz1nBysnWIV+Cuhkrsz5c16BQDv6NLgGk/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJfsj+ZPAB8k4L09HNHzrZG7ZvoClAPFCTA5SNU78mzrkTkanJI9Ldfi1jFG2Lr7I
         2FZTUvkKVO9ZpzQ2QbEiepROTP8fmDF5mk4IZWWdo3BsvCFyfO1T8WRenyJ0O7raVx
         GqArakqzl1vyaeCwtbcia9gt0Lf/cYgKt7+UjrGg=
Date:   Sat, 11 Jul 2020 22:32:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: imx6qdl-gw551x: fix audio SSI
Message-ID: <20200711143217.GK21277@dragon>
References: <1592937087-8885-1-git-send-email-tharvey@gateworks.com>
 <1592939214-13637-1-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592939214-13637-1-git-send-email-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 12:06:54PM -0700, Tim Harvey wrote:
> The audio codec on the GW551x routes to ssi1
> 
> Cc: stable@vger.kernel.org
> Fixes: 3117e851cef1 ("ARM: dts: imx: Add TDA19971 HDMI Receiver to GW551x")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks.
