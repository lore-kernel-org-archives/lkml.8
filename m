Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD1AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C79F2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qCKjj3/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406831AbgFYTmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406573AbgFYTmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:42:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4C4C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:42:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id m26so3846863lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RBqVnpfnVrl3Eo0TwToDu8x11M7fxl+21M8g4ZFsyRc=;
        b=qCKjj3/AaQfadF2MqDeWIU2rCcH6pnvafyTZrHJtL9EnOyUO3uVvExihLmMI9XvETl
         o7hubNXY7Zhim8aCPWrVw5MkAgbkyCDE3B6w/9wAIp0lMLwZhlhK/RhhAR/Ju8VJdWtx
         TM6RddLYSB4pRAfrcDWnLmwXs1xMZLJg/x3ULIJCJ/XtdTnaXdDC0d5rQSdUt08L0LzM
         y+qgJprN39qmuZl1tZHgLlQOaWmfvf1wsI3xC+bG32IGROcwhJPnOl9l9/zFq2toGQWX
         bCgXFUBOH8OyWzKt6PYjPwNSj3mDr5iVg7sffwtl1c6UQhmG13J5OXdTzACip7VWLX+r
         Mxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RBqVnpfnVrl3Eo0TwToDu8x11M7fxl+21M8g4ZFsyRc=;
        b=rYAIROH5Ri4PMRxJsPI4wlaEtNDP6UuK22IQ4DyFcSalKqPPI8U8SENJVnKXxwJUl6
         6G+Foghob1VlNUYJ7rpM3qYrqXJtAt+r6QwQob5AO8aM+a54zj+GIIXve+JhHD+Ss1XA
         yxnIr6URXJdv6CW2UhUn8vUewtlxBEx+pvjRDjap4OGp8WJX/qiyCfNej1Z/FxDUTBDy
         khEs7cr3hLJdlEqhg+IAcX3P25WOAoyzFtGqRKdn4lFCraaseJG84uaen6k+QUcKilP8
         UvJek4qn0jvDZxJ8AuKAbTXX6ttFUFhxsLuSIe0oOC0xOfidzcKy/7LiXJyodkXIsX9R
         G5ig==
X-Gm-Message-State: AOAM531O3b4wJsatwa2O6wvHSo5BNgI4//RnYJALp1YtH4uacxdCBfZ3
        gYL0JvBR7qDirbo/MXNS3U42+eP/TE8=
X-Google-Smtp-Source: ABdhPJzSOUisrMhM5vq2c+dSBqiSjCjDeE1j1fmo/G3ck5o2Q2Gso9ahJsOwn6621Vmx9QJsY2YGAg==
X-Received: by 2002:a19:c797:: with SMTP id x145mr19437302lff.143.1593114137429;
        Thu, 25 Jun 2020 12:42:17 -0700 (PDT)
Received: from [192.168.1.211] ([188.162.64.162])
        by smtp.gmail.com with ESMTPSA id y16sm4985018ljm.19.2020.06.25.12.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 12:42:16 -0700 (PDT)
Subject: Re: [PATCH 2/3] phy: qcom-qmp: Add QMP V4 USB3 UNIPHY
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-kernel@vger.kernel.org>
References: <20200524021416.17049-1-jonathan@marek.ca>
 <20200524021416.17049-3-jonathan@marek.ca>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <4df0c6c4-985f-de43-8ecd-697e3062b44c@linaro.org>
Date:   Thu, 25 Jun 2020 22:42:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200524021416.17049-3-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/05/2020 05:14, Jonathan Marek wrote:
> Add support for the USB3 PHY used by the secondary usb controller on sm8150
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>

Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
