Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264F8C38A24
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057CB20753
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF9rRF3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEFKIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 06:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbgEFKIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 06:08:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC643C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 03:07:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z8so1492822wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 03:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eh6CjI5qlJbfI0/vhnP4eL4p9yTZrlT7LtScBoT0wAA=;
        b=eF9rRF3kORznrWQ6Ryu3DYtV+uP9iro81Ds3jDSv9PZLgiljc8BeSRWDmWt0EHcu1v
         yc+OcrRTIVK4KIEKG2ikX9qJ8Ghwpv37guMlIDqPMIcxKbAhnIJcMNAhv9kJlNRvZg8w
         ykbxXQtCjh3XePczObskArBb5wqVbvEHrUG0+/SvqwTj6TCpkTovV4JUcDamaefrtQtY
         x4HuBqf7vxVZ800ryyJamkeyn2bNyQmHLUk6N3TcgjgX7pvosP8KzVB7qmbCZ1q3Tu6M
         /ZDNTK1t9ymxM0/a3RWi4RgJxJAv8Sh5+CWOiB44foLpnAMliiporE/qh/wlrfCK0qzO
         1PwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eh6CjI5qlJbfI0/vhnP4eL4p9yTZrlT7LtScBoT0wAA=;
        b=tpmdTOX2mS4DoW6jBsUWCzwFtRH3knWxNfQW3S7yGihEyEj1FhN9PXov6JtxxQFvqo
         pjlchO3WkU6bqCtSxjQUPGsOYE2m6Om5QFhwfj0D+/HEzdhGuWGD7D1gtttp1vjGiDF1
         4IeFTv8bxcYF2ILY2SFii/Kaip9IzRMgUXWpVuFor40Mn7OhZXSfxeHxrP/3MrJvtLS6
         2gw2s+yopJxY+HWFDRrmzNSwzoWt6DtjuiMDIu7nnJ8FrYlv74/WF6QxBLu9xFB54MQ9
         pTyKcvQHAWMqADoEDhiM7ZxiCUqmT2KcIk+liYx2jlgobWb+PzZrcUcTiP75bvEJ6DJg
         3FpQ==
X-Gm-Message-State: AGi0PubQVu2p32EIzBriRK9wzdfrZ4/reX+6rqQxmYvNJR48UffpzV9K
        42nozJ7yQjZiEi3MA8CM52gOAw==
X-Google-Smtp-Source: APiQypKuj4JYfxO8nKTrw9i4Yi3jaNONI0rOK9zdGpxB6OGfTP8PMtsRVxoevWRNas/XupOIzfnd5A==
X-Received: by 2002:adf:f207:: with SMTP id p7mr8527397wro.20.1588759678524;
        Wed, 06 May 2020 03:07:58 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id x5sm1820447wro.12.2020.05.06.03.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 03:07:57 -0700 (PDT)
Date:   Wed, 6 May 2020 11:07:48 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kiran Gunda <kgunda@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        daniel.thompson@linaro.org, jacek.anaszewski@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org, mark.rutland@arm.com,
        robh@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dan Murphy <dmurphy@ti.com>, linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>
Subject: Re: [PATCH V6 1/4] backlight: qcom-wled: convert the wled bindings
 to .yaml format
Message-ID: <20200506100748.GD823950@dell>
References: <1587656017-27911-1-git-send-email-kgunda@codeaurora.org>
 <1587656017-27911-2-git-send-email-kgunda@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1587656017-27911-2-git-send-email-kgunda@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020, Kiran Gunda wrote:

> Convert the qcom-wled bindings from .txt to .yaml format.
> Also replace PM8941 to WLED3 and PMI8998 to WLED4.
> 
> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
> Signed-off-by: Subbaraman Narayanamurthy <subbaram@codeaurora.org>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  .../bindings/leds/backlight/qcom-wled.txt          | 154 ---------------
>  .../bindings/leds/backlight/qcom-wled.yaml         | 208 +++++++++++++++++++++
>  2 files changed, 208 insertions(+), 154 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/qcom-wled.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
