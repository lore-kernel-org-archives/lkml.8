Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAACC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DC720658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbfmhxsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgCQLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:53:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53112 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgCQLxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:53:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id 11so21087911wmo.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 04:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J/c4hDezw2pJMAgIZidLGyuedzPxiW9b3D9y8b4Q62k=;
        b=xbfmhxsdwy76E1h+JAWA7i6+WY9M6AVLfz0EC67dj0y1FQjWCs+3s0mfoYBeUGSXDG
         G2gSLFUTBRPcJKpYXSfRdUtramN2e2E7LlF6NvulC4dLgxvGlaARHJZlX39NPgiDQeMr
         SYxK95ovsqG3kHuzNsTAHXS7m2WCADVQAOW7Wo2lKO2oEqn4qqRqzIjIRFnqp2DxMjls
         Tf6rmnCvecvhlD9z2QpMwQXfxmL1vrS8wRbFvYrTz+hcTXRKnDccsomFs9S/BGAh9173
         zqAzMhDKzUXMt23c2SeOagCiy5ZE+edhfsPwifzuSZBWsUIE7BAdMacl0ljLBdk7mYwK
         3yYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/c4hDezw2pJMAgIZidLGyuedzPxiW9b3D9y8b4Q62k=;
        b=Ud0pE2RSZOHqRsqNqBVkhvMlq9Lm5lTuhmeWa1hxdjG+OnOz4djlfE5MIgix5T5cT+
         JFD/0OwuFLzH/ZjkXkHbwHBsutTYy2NYfAs/74yYPRSiRuOKfIrTSqcY4+ThepBDuZ3q
         XQDZmC8VwQsCaNy+2TSt4uEHQBuB28nbOH4gSlDVVsbU+XlQexv43bbP1sWZLaLchGM+
         L0rVpXHk9FSwBDZLh25A7GqBPfhRvqiuBq+XRrTAf3JwUVh+HqjY1xgzjF5sc/SJTYtm
         aFXveNJFBH7/sGNnBWfkpemM1mWsjq9tcyGCRcKeq31JN8gJWsG5pjY2kXIt4zWTT7Fo
         kNgQ==
X-Gm-Message-State: ANhLgQ1SEf9IXrZQNQ4xiBpR80P1IniLAVcXlVPVjcOtPKzKerjXD04W
        RyDrpXEBAP8tkCa9i+z1aC1eIg==
X-Google-Smtp-Source: ADFU+vurgldOqTe9OEVV89nGK9VasxRVg6EIC8mhyDRpvaUvg8jHL5WFxOjLyksahXRJPKOE3V8cLg==
X-Received: by 2002:a7b:cc8a:: with SMTP id p10mr4999051wma.10.1584446011818;
        Tue, 17 Mar 2020 04:53:31 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id w1sm3441167wmc.11.2020.03.17.04.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 04:53:30 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
Date:   Tue, 17 Mar 2020 11:53:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pierre for this patch,

On 17/03/2020 10:51, Pierre-Louis Bossart wrote:
> In a multi-cpu DAI context, the stream routines may be called from
> multiple DAI callbacks. Make sure the stream state only changes for
> the first call, and don't return error messages if the target state is
> already reached.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>   drivers/soundwire/stream.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 

This patch did not work for me as it is as wsa881x codec does prepare 
and enable in one function, which breaks some of the assumptions in this 
patch.

However with below change I could get it working without moving stream 
handling to machine driver.

---------------------------->cut<-------------------------------
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index be71af4671a4..4a94ea64c1c5 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1574,7 +1574,8 @@ int sdw_prepare_stream(struct sdw_stream_runtime 
*stream)

         sdw_acquire_bus_lock(stream);

-       if (stream->state == SDW_STREAM_PREPARED) {
+       if (stream->state == SDW_STREAM_PREPARED ||
+           stream->state == SDW_STREAM_ENABLED) {
                 /* nothing to do */
                 ret = 0;
                 goto state_err;
@@ -1754,7 +1755,8 @@ int sdw_disable_stream(struct sdw_stream_runtime 
*stream)

         sdw_acquire_bus_lock(stream);

-       if (stream->state == SDW_STREAM_DISABLED) {
+       if (stream->state == SDW_STREAM_DISABLED ||
+           stream->state == SDW_STREAM_DEPREPARED) {
                 /* nothing to do */
                 ret = 0;
                 goto state_err;
---------------------------->cut<-------------------------------

--srini

> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 1b43d03c79ea..3319121cd706 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1572,6 +1572,7 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
>   	sdw_acquire_bus_lock(stream);
>   
>   	if (stream->state == SDW_STREAM_PREPARED) {
> +		/* nothing to do */
>   		ret = 0;
>   		goto state_err;
>   	}
> @@ -1661,6 +1662,12 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
>   
>   	sdw_acquire_bus_lock(stream);
>   
> +	if (stream->state == SDW_STREAM_ENABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>   	if (stream->state != SDW_STREAM_PREPARED &&
>   	    stream->state != SDW_STREAM_DISABLED) {
>   		pr_err("%s: %s: inconsistent state state %d\n",
> @@ -1744,6 +1751,12 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
>   
>   	sdw_acquire_bus_lock(stream);
>   
> +	if (stream->state == SDW_STREAM_DISABLED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>   	if (stream->state != SDW_STREAM_ENABLED) {
>   		pr_err("%s: %s: inconsistent state state %d\n",
>   		       __func__, stream->name, stream->state);
> @@ -1809,6 +1822,12 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
>   
>   	sdw_acquire_bus_lock(stream);
>   
> +	if (stream->state == SDW_STREAM_DEPREPARED) {
> +		/* nothing to do */
> +		ret = 0;
> +		goto state_err;
> +	}
> +
>   	if (stream->state != SDW_STREAM_PREPARED &&
>   	    stream->state != SDW_STREAM_DISABLED) {
>   		pr_err("%s: %s: inconsistent state state %d\n",
> 
