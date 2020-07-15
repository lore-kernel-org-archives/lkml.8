Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A5CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C219C2053B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTSEyblP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgGOJTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgGOJTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:19:12 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783FBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:19:12 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so4829772wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 02:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6S4rQcbbTZAnnQ2mAS4yWMNRrJk1s3+AGlDrxLO8KXg=;
        b=ZTSEyblPv2P83EojiNZREKOaW+HEbHXuQwZA+qzHoDEeevYBXsbb/m7Cv2JKaRUPSC
         OMB2+0GdNF/GhRmuYrohmDcZPNviTo39lIFcOjNItuFg9iC6sSjI/0gxJSYjOA64Hnp/
         V0VP57wQFxu+O9su7OIDG57xbfzaTmscPLBmK+zp8eVmLJ/IGvHVlj1ENw7MdYwUmKz0
         3+zmUDmRqQlHD1KpGX7yMHc/YHXnDZUAQjUG1Nh03TgiZAinVyQqrl+RG0RoAOfdwKSo
         /XLiw9utxk91lHgTqrPuKUYEs1l4gC+Xw7ZQRa8Mb3Gaf72hktg0TmZLVm29pQWo+44b
         Yemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6S4rQcbbTZAnnQ2mAS4yWMNRrJk1s3+AGlDrxLO8KXg=;
        b=TVCIna8R1kpyqOBYGjMDAmcL4mfoFztOx8jfW/Av7Et/9cO9CKoL6+qPP/xnkDGg87
         I9bcKwseIxx76GN4eSR+hwiEPVmEBEJTXfNVEun0RFjdAb8SVIdljHQU/5pZmUF22J6i
         MQYadxUVjWQOMYfC5F6YvtMqC0sPWNQmhQWSY9uBH7RcX1Lal85VSgugn0YC8O2Ycbek
         7PqP7qL+/qRr+1163H0JaIQoXGSN3LihiCOW6lHaD//EpFu2Mw0Z7AxKbOqWKrOIwFEu
         TJNB3xaQ7I0MsuxJkcVnNHcjO2FwzVtdoWxGfL6AJVhxW6jUCwQb/9XZHT58gBK8mqQt
         IUCw==
X-Gm-Message-State: AOAM533Jf7CVSNbP9E5/mbl0Nd4T1nCscrZJmef5TP9SnUSfSUD7dsCl
        LflRXaAGmZS6GSRj8SM2zuAP1g==
X-Google-Smtp-Source: ABdhPJz01iAz6XrxpaOaf1z0Na2lpWh6FhP27ILMosYGk50ZrcsrE3mRryySLa/rmuI3t6DXkfpSwA==
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr7477060wmf.87.1594804750107;
        Wed, 15 Jul 2020 02:19:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9? ([2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9])
        by smtp.googlemail.com with ESMTPSA id q3sm2371916wmq.22.2020.07.15.02.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 02:19:09 -0700 (PDT)
Subject: Re: [PATCH] Revert "thermal: mediatek: fix register index error"
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, matthias.bgg@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Michael Kao <michael.kao@mediatek.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20200707103412.1010823-1-enric.balletbo@collabora.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7aa6c0a5-3fc4-fd27-ece8-d062078c6faa@linaro.org>
Date:   Wed, 15 Jul 2020 11:19:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707103412.1010823-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/2020 12:34, Enric Balletbo i Serra wrote:
> This reverts commit eb9aecd90d1a39601e91cd08b90d5fee51d321a6
> 
> The above patch is supposed to fix a register index error on mt2701. It
> is not clear if the problem solved is a hang or just an invalid value
> returned, my guess is the second. The patch introduces, though, a new
> hang on MT8173 device making them unusable. So, seems reasonable, revert
> the patch because introduces a worst issue.
> 
> The reason I send a revert instead of trying to fix the issue for MT8173
> is because the information needed to fix the issue is in the datasheet
> and is not public. So I am not really able to fix it.
> 
> Fixes the following bug when CONFIG_MTK_THERMAL is set on MT8173
> devices.

Applied for v5.8-rc6


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
