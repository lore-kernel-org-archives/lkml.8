Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3D9C2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECB420780
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 19:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+LYUFcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgDEThy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 15:37:54 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46352 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbgDEThy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 15:37:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so12320265ljg.13;
        Sun, 05 Apr 2020 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/2/BZYY6tziL1rowFqv/WZjJQ1bVo6WtxgyQ+EB6IhI=;
        b=P+LYUFcU1CdNqGk1ZFGww7kPsFxv289pMKA+OGBQ8mWmub9FhsWGIP2TPoeFI9Xyaz
         n67YyDPR4osdklykNePsTyH/GfctlRzMcUFq51vu1Nr/V5/ABrITAh6tzgET/Ej3ai5z
         +Fy4yyGzFVs6LqtSc+yzcaPqN7iw3/EhbC1C7EYNBh6L9KZ7Wu9z0QU1C1BsOKlLy5d/
         CgSzZPccT/bSRNvSU1L8DhsrWIhVZ++2FI3qHq/ub4EWLkdpLo51X1AGCl+EyRaLXXe8
         tEkUxsXuj4nyYYBnaXazzdThA0a1qYOOBcmh8YgoBssCGF8PZixqzScMWk0Sc20mrylW
         dXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/2/BZYY6tziL1rowFqv/WZjJQ1bVo6WtxgyQ+EB6IhI=;
        b=f1FPS1zo/FjvuGW7O8kD2v4bRCoGrsfLBYsBGtVFx3ikKgRAO/TQdxCAmTzxk8Irts
         EqZX8M+Nvi91mKMQ9uhnUc1SzX3VIayxQvQeSvmMBBF54XDugvLfOBw5LetVMFR8evea
         utrNcx2zQcjry74ZYFYWzQsv50N1b4B8NQlplwdZob0ANNS0V1OM1CMqE9I1rGraUqxD
         DSp3cQiw6e3IbViHz+zNW0uudHle7S59dpfJxmD868NRr54Nh1WCXC0+Qs0iIUVduwKI
         J9wJAnkxTyXrcqTo5ft9djzOz7T3lfvC43qgM9UEPr+fQoYZd9DjwXpAKHfbYIWvQOiv
         3IAA==
X-Gm-Message-State: AGi0PubgpLMSoGlfMSXN2vvifXROsbZWeBhSDo/V/A+B8Uymz6/PnQNX
        /IjS4pHODCjJmndtxSAzDek5E/7H
X-Google-Smtp-Source: APiQypKM/1MzWi2j3tW5sVbf8l7ahjvkA6YmnT2KiVpjwF3GCanIAqK8rWUmndSdp2djevnlKdxIEg==
X-Received: by 2002:a2e:9b55:: with SMTP id o21mr9853233ljj.74.1586115469896;
        Sun, 05 Apr 2020 12:37:49 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id q1sm10159991lfc.92.2020.04.05.12.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2020 12:37:49 -0700 (PDT)
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ca9a792f-ff5e-c82b-c2bc-32c4875e558d@gmail.com>
Date:   Sun, 5 Apr 2020 22:37:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

04.04.2020 04:25, Sowjanya Komatineni пишет:
...
> +static int tegra_csi_init(struct host1x_client *client)
> +{
> +	struct tegra_csi *csi = host1x_client_to_csi(client);
> +	struct tegra_video_device *vid = dev_get_drvdata(client->host);
> +	int ret;
> +
> +	vid->csi = csi;
> +
> +	INIT_LIST_HEAD(&csi->csi_chans);
> +
> +	if (pm_runtime_enabled(csi->dev)) {
> +		ret = pm_runtime_get_sync(csi->dev);
> +		if (ret < 0) {
> +			dev_err(csi->dev,
> +				"failed to get runtime PM: %d\n", ret);
> +			pm_runtime_put_noidle(csi->dev);
> +			return ret;
> +		}
> +	} else {

RPM is supposed to be always available on Tegra nowadays.
