Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF8C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2437F208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N60YE/qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgIGIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgIGIRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:17:25 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BEBC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 01:17:24 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so13272656wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e3Ta+K0mK8PpGvlCwRAXKhWKCtC3zo1Ck8yWJNQiAbc=;
        b=N60YE/qv46tYYNcmpPR8FroUI42HP4mXIwHEKFuWaGPimLjJ9X3TifejU9aqxqqk8B
         aE2FD/IljOK8O1Py57X18zSa7Q5k211I0qCnq7Urb7sSDcd8kX4aPn6DY1luVHtH4eHD
         FAw4gW7HXAtpTkTtBGw/V3hgmAypm+uug7M1ttHV6PbBictZ/TGCrnAjHm6QCAKIrnNc
         YMMVxDv5HKOtnlgM/RUdgkfSEnwOdBR1bOozmHY9Zhu3cpQ+uxZh5/Owv+Im8bBCJs0P
         CRhUs+rjqD+24Cxv7SEUdOnAcSz9GbvwH0Sz85YrrMl/O21+QjRNM2D9LTm+AfdpDxz/
         nHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e3Ta+K0mK8PpGvlCwRAXKhWKCtC3zo1Ck8yWJNQiAbc=;
        b=QwaUTQ2oG3B1elB3euf2s2gxvTA3ES7Wmc2GvbncuegoyYENvPjxg4/0Oquz2Zv4cE
         ZpBz4ybEjXKg+n8QLXJj2i7Ne6EzPzlXxiEhSdDrixytLvxsxRuqH47CPjy0Av/kO2KA
         EqRVfazc2bfOFsSgmZsxvueial3OjUC7efTlYA9Pd/uB0j84FMk2zbnOtEe9cgrdBKEu
         xeKsrdZ7tyhFeIXfPk/LuqtxRHgC7q+/d/jrMmVDs3zRZvLOJpMYtN4YPJtt/MJ2NF9F
         ko2vVTQ+CekqMthl4DrT2meYd/T+Wt+RIuONdalDq/LYK6/fsj/opWrJc+0MvXqg21cL
         OyzA==
X-Gm-Message-State: AOAM533lPoYA1NgNCGfZQSH3oGX908KACr0XYa1Dw3KHA/FgORddqkqS
        lRggx7HUlMqJvzuOPXiAC/3PhQ==
X-Google-Smtp-Source: ABdhPJzqlqQ/xXSxZ0lbww5TZ6AZTnF7NA2XnTh1An/jnwbvuMzqoK0s9KMICLsQ2iJA4xPkNvSEbg==
X-Received: by 2002:a1c:3bd7:: with SMTP id i206mr19701901wma.162.1599466643283;
        Mon, 07 Sep 2020 01:17:23 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u17sm25259954wmm.4.2020.09.07.01.17.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 01:17:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] soundwire: qcom: add support for mmio soundwire
 master
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     "moderated list:SOUNDWIRE SUBSYSTEM" <alsa-devel@alsa-project.org>,
        Andy Gross <agross@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200905173905.16541-1-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <ec241abf-c1e1-8b2d-a0bb-93a60241330c@linaro.org>
Date:   Mon, 7 Sep 2020 09:17:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200905173905.16541-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/09/2020 18:39, Jonathan Marek wrote:
> This adds initial support for soundwire device on sm8250.
> 
> Tested with the "wsa" sdw device, which is simpler than the others.
> 
> v2 addresses some feedback, but I kept this series as simple as possible.
> In particular, I didn't implement CMD_NACKED from FIFO_STATUS, because
> the downstream driver doesn't define this bit, so I can't implement it.
> Soundwire works without it and It shouldn't be difficult to implement later.
> 
> Jonathan Marek (4):
>    soundwire: qcom: fix abh/ahb typo
>    soundwire: qcom: avoid dependency on CONFIG_SLIMBUS
>    soundwire: qcom: add support for mmio soundwire master devices
>    soundwire: qcom: add v1.5.1 compatible
> 
Hi Jonathan,
I have tested these patches on RB5 with WSA8810 and they work fine.

I can try to add support to command ignored in future, but for now these 
look good to me!


Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


Thanks,
srini

>   .../bindings/soundwire/qcom,sdw.txt           |  1 +
>   drivers/soundwire/Kconfig                     |  2 +-
>   drivers/soundwire/qcom.c                      | 38 +++++++++++++++++--
>   3 files changed, 36 insertions(+), 5 deletions(-)
> 
