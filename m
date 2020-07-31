Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA7A021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 22:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596234161;
	bh=IgaVL2AT0FTg7LUUjxf6CeqdR+cxSCWeUL4LkUacTN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2YGJNpHPgVIEkKjVoCDcYinfM66XQJnifS7OyDR6nrQkNHZrEsyTrtgwv7hzwUnEJ
	 Ra7A/2LK8on8HkCcXQifvs4Qeks+RiCryZaX1YwMi20XZXi+0Clg7W5aiNO6+w6noM
	 qG8EjyzaQJjudCi5VUdFYV0sPbENLEDz8Is562MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgGaWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:22:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42347 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 18:22:40 -0400
Received: by mail-io1-f67.google.com with SMTP id j8so20795868ioe.9;
        Fri, 31 Jul 2020 15:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U9siMEW0hgsBeSbMHX+zK/B4W7o7H4/UOC3IWqbCbww=;
        b=eLRSYWq/f0oW1Gmh5U0F2WhK6ZGPe4QEpC2XdwJYXs5caKcP/oVa2P1nXk87JfNt+C
         nWZnTgk4103XSa/DXhi1d6Ox0kVIncUAuhq7XVDpp7jmY3PWZlgMqw+ZgdC/500j3keq
         ezjpv+OUf4Ss9WQO3pPTDwWwViXs0mrs74JwvuxhQW3F7bBTHD916neMBERbCo2yFS2f
         8FAmfo1EG8Xb7sf7U2NaHDTNiytI4Af94c6k8IdEtwWU5j/zgRQ+ZVz8AEaguDpgJXHL
         esEXF6lIxmGEnCwTuBbFJKe6Ugz2hQnYrk0d7BsjPNoUAmww7FY/at21zhQgVR4OOyRU
         4Jtg==
X-Gm-Message-State: AOAM530dXDU1rtiTOXKIhQ8RJ6MpPLB7cqHJpA5R82trGbunQXlT+GF2
        kpC6yQNW//DwRfEHpIrjLQ==
X-Google-Smtp-Source: ABdhPJzRVXj0cDKRe3ATwGRgPRvQPoYJPZg8d7S8GrDJU8xqE4kaGXKNK28CjUze9dtWEDgT/AbMUA==
X-Received: by 2002:a02:9149:: with SMTP id b9mr4863557jag.50.1596234159075;
        Fri, 31 Jul 2020 15:22:39 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v4sm5539207ilo.44.2020.07.31.15.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:22:38 -0700 (PDT)
Received: (nullmailer pid 909866 invoked by uid 1000);
        Fri, 31 Jul 2020 22:22:35 -0000
Date:   Fri, 31 Jul 2020 16:22:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     linux-clk@vger.kernel.org, Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mike Turquette <mturquette@baylibre.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fugang Duan <fugang.duan@nxp.com>,
        Stephen Boyd <sboyd@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 04/17] dt-bindings: clock: imx8mp: Add media blk_ctrl
 clock IDs
Message-ID: <20200731222235.GA909756@bogus>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-5-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596024483-21482-5-git-send-email-abel.vesa@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 15:07:50 +0300, Abel Vesa wrote:
> These will be used by the imx8mp for blk-ctrl driver.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  include/dt-bindings/clock/imx8mp-clock.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
