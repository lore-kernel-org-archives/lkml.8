Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D9DC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5536520706
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3DJbJBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgDYXNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726238AbgDYXNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:13:40 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8E6C09B04F;
        Sat, 25 Apr 2020 16:13:39 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so13754201ljd.3;
        Sat, 25 Apr 2020 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Vmbfgj+KhhWIRPQO0Y7xejCzKCfT3B/GizNa4s124Dc=;
        b=g3DJbJBCWv485BsgVXF8GDfzccu5Psm5tUNZeup5nFWON4WGl4Gg1d1SJPl++9hzUK
         O/UH5wrIicb/Bb+nKJKc0exlmi/XYPr6oKmEYO58rTs0qAvYKS85meiGYvTjBvbJGD3N
         H9rO+PmxQ3HwDd7CLXe+kTqOTm7lV7g6fhYMXWcOag3UGufACtIbuaMgIeK1E7akULCe
         QJVEktNeeh3zTjWeTDCyJTw7ubS0iqUw6fWk9wsjG6fgY9AdsBoPF9QTdTdt+7KYMSYF
         sG6EnBXS22UKJt3ua+p2GirPNzBRrMCJial29nu240vgASd/pCcDhsnxdS5hKi3AUA49
         xakA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Vmbfgj+KhhWIRPQO0Y7xejCzKCfT3B/GizNa4s124Dc=;
        b=owlKnOK/Z4Ba1MeitAwQHr16HOC9uwtwePKxX1b1cuxZ6fa+TFvIQCL7qU3E0lUYsl
         4lJ0dQfvv/u3fd8qhjiiLBMjn3gBWWS6uJz0n/kWssFXBbJhMe2mE3syKc8S7AwSTpcx
         l88+i60r5rRCigms/NGDKH8TTTivvNBgP08FqbSrQqUosurGb8a3VihlVa9/DWnpxDDV
         ljUM2vRGvtt5OHgn6BlwF3hK6tFGxkYRU1SG3hA5qeIIyhtD+Lx9cWuonH8jnW7N0k/2
         KcodBkkmrl28JhL8jAuGnzfXTGJkUDPsqWx8ssgPzYBkcFG0LY/Wvtndu7jlnqrloLob
         H/rw==
X-Gm-Message-State: AGi0PuYTHDjh06+ED84WnIXqNMrXFRGCspFtdWsh+QmpOrDMUVmaFKPZ
        xIi+95Jl6q3xTkWhxRn1m3xWx1of
X-Google-Smtp-Source: APiQypLPLLlFK6SUt122hbClzC+1jGC5XEHeRT//ouxPvHt7RAx0CUb9YTAsKvpZj4H0ruXIT3YpAQ==
X-Received: by 2002:a2e:9990:: with SMTP id w16mr9913314lji.194.1587856417724;
        Sat, 25 Apr 2020 16:13:37 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id o6sm6917564lja.70.2020.04.25.16.13.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 16:13:37 -0700 (PDT)
Subject: Re: [RFC PATCH v10 6/9] media: tegra: Add Tegra210 Video input driver
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587700513-28449-1-git-send-email-skomatineni@nvidia.com>
 <1587700513-28449-7-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <fd5300fd-33af-babe-95d0-9669b66a8c06@gmail.com>
Date:   Sun, 26 Apr 2020 02:13:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587700513-28449-7-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

24.04.2020 06:55, Sowjanya Komatineni пишет:
> +static int __maybe_unused vi_runtime_resume(struct device *dev)
> +{
> +	struct tegra_vi *vi = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(vi->vdd);
> +	if (ret) {
> +		dev_err(dev, "failed to enable VDD supply: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_set_rate(vi->clk, vi->soc->vi_max_clk_hz);
> +	if (ret) {
> +		dev_err(dev, "failed to set vi clock rate: %d\n", ret);
> +		goto disable_vdd;
> +	}

Isn't setting clock rate using assigned-clocks in a device-tree enough?
Could you please clarify why this vi_max_clk_hz is needed?
