Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E21B206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="A/sme5V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgFKPWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbgFKPWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:22:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA9DC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:22:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so5323061wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 08:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1nlSpRW9uKZkujI3ovnMqEgLfpyhYszTXX8pA7a9rw8=;
        b=A/sme5V/cIhwe8I9Of5+XKkmePLK6qEFBuhVnLMz3sN9Y9LtjoVeRg2QC+gBfqakOo
         D7ACqOpcgouR08YG/q+5EbqcykmmmZt8FjsEVm1zcHiHcdIQTBdOIh4Twa3JOP5WB5cF
         v4Vkxtyf3AsgAFi7urVL2nqe8OI5y0bb89E8nXexnvfLWCc1s/OSw9tJgj3etzRiyuSG
         nEiTzC9DYj/pd/8EeNBqDzHgigmRmo6AOBlxblrS4dp1AtsUkkw3jQyOHltBa+1xLZqN
         Kq4uV2dgv/wfuUsT5lkpnNNuYH8nAOzuux679lKkZNeyusFXoMFckaP6pYxNJ49dTr24
         +vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1nlSpRW9uKZkujI3ovnMqEgLfpyhYszTXX8pA7a9rw8=;
        b=ozDGVDFu5UFnl1wTnFPZGcC4gLZH2DlTVtqb5/g1JC7UExgwBCJThSUYoGesBSK7Ut
         YRA2ycg+VW66BFtnBvMxajcDiLTCuXyaltlNTDSvNGQycYP886Db2pkOYAjg3G0/Ary1
         zZxQDLF99I0RM1LHOEr5Iqy5twS+7E6fFDBSKMD/PnCYbDEJ8IO7JLq5YKGXpa8nZiLt
         9zzsaePLoORmqjqOPPcdbux3jDwZkRPapU6U7Fb1BOTAEsWnOMn44DvmWh6DD4/uOmHP
         yAiu0OHzORcde8F3FIW9nkvwB5hJzG2XRXnB6bmgomq0GnHvDeulIYcpGzriSriPC9/E
         TYMg==
X-Gm-Message-State: AOAM531O0QVB2VYTvpEv4jo7DugJY2Nb0ECV4+fsVx5sWqmeDczm8oLZ
        ocvPXKTgGNfc1qlGojXkTL9EUQ==
X-Google-Smtp-Source: ABdhPJwgOUF0ACQW0V2iGQEHEnECqPXsLPsoErKd6xk/1/oN48hrXu8XWttb4+F2J1GolhZuGaGGEg==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr9144654wmj.185.1591888923973;
        Thu, 11 Jun 2020 08:22:03 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id q8sm4290865wmq.1.2020.06.11.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:22:03 -0700 (PDT)
Date:   Thu, 11 Jun 2020 17:22:00 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Phong LE <ple@baylibre.com>
Cc:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Baozhu Zuo <zuobaozhu@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>,
        Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH v2 3/4] drm: bridge: add it66121 driver
Message-ID: <20200611152200.GA3106776@x1>
References: <20200311125135.30832-1-ple@baylibre.com>
 <20200311125135.30832-4-ple@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200311125135.30832-4-ple@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 01:51:34PM +0100, Phong LE wrote:
> This commit is a simple driver for bridge HMDI it66121.
> The input format is RBG and there is no color conversion.
> Audio, HDCP and CEC are not supported yet.
> 
> Signed-off-by: Phong LE <ple@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig       |   8 +
>  drivers/gpu/drm/bridge/Makefile      |   1 +
>  drivers/gpu/drm/bridge/ite-it66121.c | 997 +++++++++++++++++++++++++++
>  3 files changed, 1006 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c

Thanks for working on this driver.  Do you plan to post a v3?

I am interested as the it66121 is used on the HDMI "cape" expansion
board for the BeagleBone Green by Seeed Studio [0] and is currently
supported by an out-of-tree driver [1]

-drew

[0] https://wiki.seeedstudio.com/BeagleBone_Green_HDMI_Cape/
[1] https://github.com/RobertCNelson/ti-linux-kernel-dev/blob/ti-linux-4.4.y/patches/drivers/it66121/0001-gpu-drm-i2c-suppot-it66121-hdmi-chip.patch
