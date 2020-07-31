Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EA5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A6D821744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596234238;
	bh=5lKcrovESptabqSMti688rK1rXSn4dNXxP9tTwCbq6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6ftZgkWbruV6468OgAFZuz60jjet/E31jzaig3ETrUV1yi6mkdL6PE1jhvJiB4nc
	 S8nSATertBRGoQG4MFDI4aT54fxVvF1bEWteOM4ZGBLsK1B9FlUpnP+G3xaak+Zadj
	 rlFtCmuR+27zulBJmnLrPLcGSOd9wDeP6MFAu5V4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGaWX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:23:57 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:44881 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:23:56 -0400
Received: by mail-il1-f194.google.com with SMTP id j9so23211940ilc.11;
        Fri, 31 Jul 2020 15:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2RiyFvYYDz1LwKSXtOP2l6n30ZODz6WebBLhJEGcUVo=;
        b=nGGE7zaxSVvBUWTQyrYI7UbX7dmnpZnUqeA8Otfbmyu786GOY/VwQK9eGITYoE7BQd
         EMOCEjvniV9BJKcCCrdiWwLlGs+cvWnh2ltlS5QW2pXsvIfEgMktIQ3w/jalupLuwqz4
         X+myaleqhJV9fMMXYeL9SrdlEkZtQe+qzUdLj89ywgNsPCKIEJhiWioXA7FabiJQdWB4
         pYTlODznHf0maZo2dN3GBijc3+XvLr6nwJcOrDyhDYvnbJOJv6jVgAyC241ajmqWfIeJ
         cxpIMrMO97xN4QEYduKdOtUyOP/MKBTgf6CLA2A0o8LHydBHmon4c6RgWDFzaMHRvnPK
         Dxug==
X-Gm-Message-State: AOAM531CLRfirh/TvrfoPgqeIcX3Q0ZA/bzkowkMZOOU8vt5QVQPnyzx
        wvzAHixppwcZcAgJqVZFsw==
X-Google-Smtp-Source: ABdhPJzRlYjwbMygopPXgQiiD0F+uJYEj0oK8B0zkMWkajXxe0+KwHzZklre68xKcrR6cC4oXYkZ9g==
X-Received: by 2002:a92:90d:: with SMTP id y13mr5585058ilg.246.1596234236091;
        Fri, 31 Jul 2020 15:23:56 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d6sm5143264ioo.9.2020.07.31.15.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:23:55 -0700 (PDT)
Received: (nullmailer pid 912174 invoked by uid 1000);
        Fri, 31 Jul 2020 22:23:54 -0000
Date:   Fri, 31 Jul 2020 16:23:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     devicetree@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 06/17] dt-bindings: clock: imx8mp: Add hdmi blk_ctrl
 clock IDs
Message-ID: <20200731222354.GA912071@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-7-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-7-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:52 +0300, Abel Vesa wrote:
> These will be used by the imx8mp for blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 40 ++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
