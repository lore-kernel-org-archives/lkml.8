Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAFEC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D98CF20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fzWaT5aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAaNnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:43:46 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37196 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbgAaNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:43:45 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so8732615wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Z/QqKPZRNPOFz7Xr+UvMoQ/x/R9CxVbSeJizVEab2M=;
        b=fzWaT5awKSTprWGNFjvI5CWYnpVIrcnpr/AbZvBQFVBcyiGG+bYBV2uAED78hSAEz0
         7zsFtBxH85RtgleESDclo/phjJl0zeCBDiIqdBdt/oDG636i/yRAF9NlJVHdUemRVUy6
         vC+sSqdEcIgsBUtMrVwGouKeiHl//FBWO1Ln3kPU6kgmjlyo4w2yQzhCLbWSkMMS+K68
         +ixaKPMOyhESZQw4ZJWuPLJaVEhp/KetXJBZKLrHAMXkGY/3LQktbA1oIoL8nNdoWdyM
         l6zu1UeE01BWgm8s5Xnw22cGgb7DrvNxpuTfTXMdjPGN/k4oj/XEp+RQRAN5+N+mQVTh
         TfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Z/QqKPZRNPOFz7Xr+UvMoQ/x/R9CxVbSeJizVEab2M=;
        b=n0+BXjA5gpE3vBbpZz5UhWSXtMCamnoO2XvjNvbOLN+NwDqCeEG3bPweLWuQyyrjlu
         8ajEyVLM7ALTM9z0h7S2qvFe5CP69GKbh/PxibBlyXEul9sumyuf/ZFz/Fl12/nFVnSK
         MvuQFVYlkQEp32dMSW/oFsvSxOu2q1DzjGMurfpdvBfVsyViAxg6PSf3RY8iBtdiLoHJ
         4Eo9xj+pIg581LK+2yrn5e6cZ1Nffzfb6D1jcSU8J4NotDKsI+DB6vd3Bi73RoHB5xtT
         ZQypRtq6O5Us8J4LYopNjhPWA2rJZpUcVJ9DR4L7HmiaxnlpN/1574xqpVbWgBv/xe50
         8pvg==
X-Gm-Message-State: APjAAAU8iWLK8Bj0WPP94v9MRcAeQOp1TQrKeqI/IPguZt6dRfrabJaW
        QnrTkqNj3CrgrZqLqdFopLfMKg==
X-Google-Smtp-Source: APXvYqzt/Q19RKB5qlDxzHOJGecKCDHb2QXQ847rq1x4DycbKl05VzkB6sXzwu8DxSWkFSpV18idNA==
X-Received: by 2002:a1c:2358:: with SMTP id j85mr12487076wmj.28.1580478223062;
        Fri, 31 Jan 2020 05:43:43 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id g25sm16185615wmh.3.2020.01.31.05.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 05:43:42 -0800 (PST)
Subject: Re: [PATCH v3 10/19] usb: dwc3: Add support for
 role-switch-default-mode binding
To:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        jackp@codeaurora.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        devicetree@vger.kernel.org
References: <20200122185610.131930-1-bryan.odonoghue@linaro.org>
 <20200122185610.131930-11-bryan.odonoghue@linaro.org>
 <87o8uj7nzj.fsf@kernel.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <9b95478d-5ac7-3dfa-a70e-1dd881bd5b2c@linaro.org>
Date:   Fri, 31 Jan 2020 13:43:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87o8uj7nzj.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2020 13:29, Felipe Balbi wrote:
> 
> Hi,
> 
> Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:
>> From: John Stultz <john.stultz@linaro.org>
>>
>> Support the new role-switch-default-mode binding for configuring
>> the default role the controller assumes as when the usb role is
>> USB_ROLE_NONE
> 
> per specification, device is supposed to be the default role. Why isn't
> that working for you?
> 

Speaking for myself - its only the role-switch logic I need. This patch 
seemed to go along with the the role-switch stuff but, now that you ask, 
this series can probably do without it.

---
bod
