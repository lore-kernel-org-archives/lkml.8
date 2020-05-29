Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57ADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9433B20814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590720353;
	bh=THXM6yMJLgeM3ID+CeJnG1+f+kGDzL+SsbCqIOCpDk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qSG/Hrjo21VztUyaJQXVt+2dfKkBrmQ97EPD6srw36YhlbRwYqg/XaG7oXzoXA4un
	 0aSRC5IKy/Wd/6f4UhSK+uyXiB+0zYrXSeHJq9ZOFeCZ+vzxk6UTPURenoyQmfGxQn
	 f0iSMjJs6Sy6v9693lWJenbDaCrLV9SnDEFk+AKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391611AbgE2Cpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:45:52 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34517 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391576AbgE2Cpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:45:50 -0400
Received: by mail-io1-f67.google.com with SMTP id f3so811947ioj.1;
        Thu, 28 May 2020 19:45:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZW92dcw5H/bw1GgI6KkCUyWQDZDT1sXgzyMQuYH8dw=;
        b=FlsoI/9aatn+5w3dTvLPTqmnJVQ648euxWP7Oz5zEcbzCoziZZ7DeTR23ng78AEmft
         IQMNS4LszGljIkJBqB5FE50ziz2OW77EpAmK/xIyltLm37FaLHmDDwrTbBvM+eIszYM/
         ddE+v2nbdJu5GzEs0NwFjvhisskbXT7ChCWtbcWUoZixsbsch8yRrrYDCI+dSuaDAlmP
         lTB5wueStVX/gBsio8k4JE2KSZwAJARQYc02NVjvZ5GbqLpB08l8SslI2hWvoH63zqZw
         LOjTYRIsX5qn48Q75tdRB4rTL0GmQVkyCEJCDE0l6OtP28iXNGnM0Xhqm0JU5vosaCnk
         I1zQ==
X-Gm-Message-State: AOAM531QH2Ms6XPvwUtbK7EIOx6IKUX1zmG2hxYY7gr4ADMARr7uLY/p
        XOc3cGy+QY0P1Wt9l8CyZg==
X-Google-Smtp-Source: ABdhPJwNgsOx8ZH2IbBRn4sCotiCfhiIJhxDVyqppjNE1/Y6AL/5vOt42MoG2AtRJf5lYySRULjBtw==
X-Received: by 2002:a02:942a:: with SMTP id a39mr5306308jai.50.1590720349628;
        Thu, 28 May 2020 19:45:49 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id m12sm2359902ili.41.2020.05.28.19.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:45:48 -0700 (PDT)
Received: (nullmailer pid 1166896 invoked by uid 1000);
        Fri, 29 May 2020 02:45:46 -0000
Date:   Thu, 28 May 2020 20:45:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        shawnguo@kernel.org, shc_work@mail.ru, devicetree@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, festevam@gmail.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Linux-imx@nxp.com, s.trumtrar@pengutronix.de,
        s.hauer@pengutronix.de
Subject: Re: [PATCH 1/9] dt-bindings: clock: Convert i.MX5 clock to
 json-schema
Message-ID: <20200529024546.GA1166843@bogus>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
 <1590650879-18288-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590650879-18288-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 15:27:51 +0800, Anson Huang wrote:
> Convert the i.MX5 clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/clock/imx5-clock.txt       | 28 ----------
>  .../devicetree/bindings/clock/imx5-clock.yaml      | 63 ++++++++++++++++++++++
>  2 files changed, 63 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.yaml
> 

Applied, thanks!
