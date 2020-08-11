Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0CDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B1E2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 18:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHTxic7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHKSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 14:49:34 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57E8C06174A;
        Tue, 11 Aug 2020 11:49:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 140so7239547lfi.5;
        Tue, 11 Aug 2020 11:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7DTn5uFhSyuimkf8VN00wRIDhk5oSwcyOf7Qxcw85tU=;
        b=FHTxic7sIGkNM9Mo36Oe6nF3rOGpsHOfy3yxhDcm5QMz3AhdVdCcXTd3NsgZaqo+qy
         ihoaGod/PfgjHpbpNk5AyW9DJGD6QDZQt76KDc3AvtA0ax1l3eBL5vNL5QsrPwrHLSHx
         GlPlE2dFHy2B79D5xFheaebZMp2jIwR60Dhc4Rx04I3qSjxf16K4GatDDw7Z8ZdjbE7I
         vjPVjy1RBWJWVoMejf5kPcBe4uJwwUKqewXHIMi5WPA1E9qXZOwtJKDwSgQtX6f9wvUD
         tH2k9vgPMyk40flenKHxNwj+s78W3dKo59xMPsb4vJeQO4cioIePxdKkh/nXw9n1i8ay
         Y9DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7DTn5uFhSyuimkf8VN00wRIDhk5oSwcyOf7Qxcw85tU=;
        b=jhpZT/ChH8Fa4WrJTw8GNQwkMcFdZW3dS81QMoid/h84HKiwcCRZy0Q6v3KBA29X7g
         rnkX7XdmEVCbziiutjZAoPXcfWe/4wAZRLrTiY/+BwB2mE/wkz7+cLSlTYJUP9QI+ZMs
         00d7BWt8q34+A/5DhQAtbyvnJ9gUrUnVdGU/r+PVUJzDFwK4iDqC/Gs1xY3vMCHS9y3C
         ORg8fLQB6xgPExIYH43Xqjz2fVApKj17n8MgvOsPzIvZskH/0V7BhLLhQbz4RqcEv+Xg
         4x62EjcRcPgYtYgw0dpCxNbXyB5fGaRMWDD7Sb/BOVHcNexI8SVixfGZZZmRichKqiRK
         hO3g==
X-Gm-Message-State: AOAM5311mhrw0xuxfC4py9ZXb8HJQeeGlu5CNBkxSl0E2YC97hEJVpSa
        J9x2pvDgt9Qm7cnsNvPrdaCLyI0h
X-Google-Smtp-Source: ABdhPJz/FpzQOdn9OOGGCezMzFAL+DHV0SHGzs6yjrB2lFiiEejBhhvW3hCAbATSPtqyb2YfEP5Tow==
X-Received: by 2002:a19:654c:: with SMTP id c12mr3907741lfj.132.1597171771257;
        Tue, 11 Aug 2020 11:49:31 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id i11sm11690790lfl.31.2020.08.11.11.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:49:30 -0700 (PDT)
Subject: Re: [PATCH v9 09/10] media: tegra-video: Add CSI MIPI pads
 calibration
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, sakari.ailus@iki.fi, robh+dt@kernel.org,
        helen.koike@collabora.com
Cc:     gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1596740494-19306-1-git-send-email-skomatineni@nvidia.com>
 <1596740494-19306-10-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0eb1c3ac-7cd7-d58c-9480-bd8d762c27f1@gmail.com>
Date:   Tue, 11 Aug 2020 21:49:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596740494-19306-10-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.08.2020 22:01, Sowjanya Komatineni пишет:
...
> +	err = tegra_mipi_finish_calibration(csi_chan->mipi);
> +
> +	if (ret < 0 && ret != -ENOIOCTLCMD)
> +		goto err_disable_csi_stream;
> +
> +	if (err < 0)
> +		dev_warn(csi_chan->csi->dev,
> +			 "MIPI calibration failed: %d\n", ret);

err
