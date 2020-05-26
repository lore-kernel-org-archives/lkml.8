Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49696205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b="FNc4aIV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388510AbgEZJhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388460AbgEZJhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:37:45 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD08C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:37:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so4105998wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zKgkx1RN+yOQz5t5MmLQDLEnUMA9zwlAKS6pKOreKZY=;
        b=FNc4aIV0nhulL4pN4Z88kKa4a79yXjgO7FI8T76etE4vtRUUh9t/HH+YRM7VFHS2ay
         n/0LqPWK9UNVH2Bo5dEVeRHWvrn9fdBi/z1hUfb4jujqGmcwAfK/QDngGUkWTLdrndf1
         wDucR67QFkeCQd6TGpLQNakoGmVGAW5tGG/DWWSwlGcL+CG0VhJB2QhjW1NK0XlUUjE7
         Ni/VX5WekMngIpi6qy6WlEHLTXQ1TweR2TG+w+B4Nq0qjvxFf7LB0FYa60tPDK+Z/hTq
         dMmrq1HFfkc06E/JUaNF6K5/iPT/K3W3d51vq/yLUXYz/p3/t31o1IeGTczThkCuX9NC
         7xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zKgkx1RN+yOQz5t5MmLQDLEnUMA9zwlAKS6pKOreKZY=;
        b=tSWYtvcxmXEl3f66MP/bp7MIYhPttxoRBiqzrEBRGUsUDK1sf2dVxVaqVVcYnhX1lb
         rS0+lz1CW4dhba0i5p9RMpB3Z54GZRAUdQQNE5juhlZfuk6trvSVnPn/PPSsjTIdkbA4
         19TkPMQFew9HOgg/cjP1lUzhDignCiMCUz7tclpT9bewtIRz/gmiAjgpVwd1JVaxMlpi
         xd3zZ9YH8GYZSThG9fjNudimZQ61cS4iYqDtTzdHZcGR+h7J/1PahFe6lTEsirQnrAQG
         bLCNB3yH+nq5ZT4rycyvNxtfUoq713oqxwpVx9xscympMe1Pklcqp9cc/srRHvo+MhTj
         9LhA==
X-Gm-Message-State: AOAM532pnFRYNk+DYC0tCwn4lngm5Aj+Ra95v7i7oAR3z8l9Z0FYoJrp
        GbWgtY1V0OGa26TZPQwrvK2PbUcThdA=
X-Google-Smtp-Source: ABdhPJzfEXYdCF/DEyjlvvWvfNcMNSgFSqWgMZJUcODo9tJ+VjhsEhG1votkhojXE9haIoAN3q15Tw==
X-Received: by 2002:a5d:4d01:: with SMTP id z1mr18065341wrt.29.1590485864008;
        Tue, 26 May 2020 02:37:44 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b185sm388031wmd.3.2020.05.26.02.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 02:37:43 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock
 Controller
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        vincent.knecht@mailoo.org, konradybcio@gmail.com
References: <20200517131348.688405-1-bryan.odonoghue@linaro.org>
 <20200517131348.688405-3-bryan.odonoghue@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <af35d732-08bf-fe95-3c98-063b32fe992a@nexus-software.ie>
Date:   Tue, 26 May 2020 10:38:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200517131348.688405-3-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2020 14:13, Bryan O'Donoghue wrote:
> This patch adds support for the MSM8939 GCC. The MSM8939 is based on the
> MSM8916. MSM8939 is compatible in several ways with MSM8916 but, has
> additional functional blocks added which require additional PLL sources. In
> some cases functional blocks from the MSM8916 have different clock sources
> or different supported frequencies.
> 
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Co-developed-by: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Tested-by: Vincent Knecht <vincent.knecht@mailoo.org>
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

ping

just sending a reminder on this one

