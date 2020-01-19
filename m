Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3413C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A978B20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 16:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="min0ay15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgASQEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 11:04:05 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38165 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASQEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 11:04:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZOZk+gP1VJ2wj7bwOcS87OUCNxDRCwd2z6Z+GhIYdvo=; b=min0ay15iz5Azl8EH2gokGrmJo
        WrALYcl4GAeJrcbW2pClNb1UILmHYNePAK1bqx0uM30oy+8yqh9xSbgu2sxw8ssPPloLPr6GC3Hcq
        AVl/kgQ9TZqsdk5Xben+IttQaB/2e35AB/DQQU6aH+L0P6Pwr3I/p8oiz0ZrsaRSLXri6hyn4m9p+
        p3ayo18SpWGuSRkqGivOS29Pa4ye/dXk+KJld6bYTLGRcFlMnlzb2SiHHd5W1StLHw7oUTLa5VhOT
        QWmNsCsEz67NLeIXcxw/KCoXTgJjKzKMqm8dgDPuaNeeqPviORl8CxkqBSZJiKL6b564h5Xl1/arX
        bQK8owUQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64649 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1itD3Q-0002R4-VY; Sun, 19 Jan 2020 17:04:00 +0100
Subject: Re: [PATCH v2 3/5] drm/mipi_dbi: Add support for display offsets
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        David Lechner <david@lechnology.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200115124548.3951-1-geert+renesas@glider.be>
 <20200115124548.3951-4-geert+renesas@glider.be>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <04ac0b1f-daa9-b7ac-82ee-682c5da5d467@tronnes.org>
Date:   Sun, 19 Jan 2020 17:03:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115124548.3951-4-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 15.01.2020 13.45, skrev Geert Uytterhoeven:
> If the resolution of the TFT display is smaller than the maximum
> resolution supported by the display controller, the display may be
> connected to the driver output arrays with a horizontal and/or vertical
> offset, leading to a shifted image.
> 
> Add support for specifying these offsets.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---

Acked-by: Noralf Trønnes <noralf@tronnes.org>

