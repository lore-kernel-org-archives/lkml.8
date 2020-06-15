Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B81206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le1ui5h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgFOO2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbgFOO2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:28:49 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2D9C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:28:48 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u26so146692wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGDCFEKi8HPI3D0JqHhVUyKhW7cWu5yo2qs+AF/FFQg=;
        b=Le1ui5h1RFDRX7MHDNBOe50JiR6qxmvuYkfJy1r90c0vukA2QbHtCC4GjaGhFi7aY1
         UfVZVUoClT7O/3WPSZ4WZFovdZUEVQ+XHmOCdzqJvgUdW2BeYmUIncJAZl7SHmK8EPpO
         Xwto79YM518LbFSqELX9i9IoK3X0emmXvFr5P9YjZ+hcflPmSZPE/47zOJ2CLWBPZ9R/
         FjXErRJAQRSufzyoJTBg8TN75eHwMCfckicK/iC/UKtttLIVkCgQbjh9lt2F2CWumOvu
         7KA/feRfIM0R5fdFwxwYKb4mrlNg3sxIJT7hfccnSV4BpnIsevRelZKhwoJwjQwOmEmM
         VhGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGDCFEKi8HPI3D0JqHhVUyKhW7cWu5yo2qs+AF/FFQg=;
        b=Q8JwqFRJqiSsdG3ki3bEL3s9Dn7sPbdPe4B7onFy16V62wOrf7JYE0N1VKep2qbePz
         qNd0J9JC58dwMVqb+OK5ZdUyLQ/7N7MtLd4ArcF0a52eWFD2yXE2VToYuNXzzrKyiDNd
         r1KYZfbTBphZoMG7Do0RY9oWsA9Zm9Xt+SB9JJW/NeTHCZ5ZjRcy9cGJmF+Bj8MTSuUR
         zNEei8ScB1JjQHWyArbymaAApTNaOPRon7IJmyVsTp52L1jK3srQ0cOKzu66BJqUWxH9
         dBuCkIfYx4S+BbGh1nB22DlBQGJtmPoEJ6CpLl1l3cRGNYl100DLJNNBDsGsYLxy/qEu
         k3zQ==
X-Gm-Message-State: AOAM533M5/yaowo3ZrKCYtVw3ztXRbFcFp7JudZkh48wYM9n/0o240y2
        VhkHMfaQzASsCBmBOgVvWhhxww==
X-Google-Smtp-Source: ABdhPJzjPlB084ZbJ22w6JnJ0+3/LKJfBN9RTr2pz+fW7ZJKZZzu0Z/8wTigeY3ja39uTmOlimT/RA==
X-Received: by 2002:a1c:7717:: with SMTP id t23mr13299332wmi.175.1592231327311;
        Mon, 15 Jun 2020 07:28:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id a6sm24329946wrn.38.2020.06.15.07.28.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:28:46 -0700 (PDT)
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for
 qfprom-efuse
To:     Doug Anderson <dianders@chromium.org>
Cc:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org>
 <CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com>
 <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
 <CAD=FV=WGCvQTRHWX4Dvx+pTf010NbEzQMgcV4WDKQ6M8KO-cRw@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <9f702f74-1fb7-423b-0899-0bdaeafbef82@linaro.org>
Date:   Mon, 15 Jun 2020 15:28:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=WGCvQTRHWX4Dvx+pTf010NbEzQMgcV4WDKQ6M8KO-cRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/06/2020 15:27, Doug Anderson wrote:
> Hi,
> 
> On Mon, Jun 15, 2020 at 3:44 AM Srinivas Kandagatla
> <srinivas.kandagatla@linaro.org> wrote:
>>
>>>> +properties:
>>>> +  compatible:
>>>> +    enum:
>>>> +      - qcom,qfprom
>>>
>>> As per discussion in patch #1, I believe SoC compatible should be here
>>> too in case it is ever needed.  This is standard practice for dts
>>> files for IP blocks embedded in an SoC.  AKA, this should be:
>>>
>>>       items:
>>>         - enum:
>>>             - qcom,apq8064-qfprom
>>>             - qcom,apq8084-qfprom
>>>             - qcom,msm8974-qfprom
>>>             - qcom,msm8916-qfprom
>>>             - qcom,msm8996-qfprom
>>>             - qcom,msm8998-qfprom
>>>             - qcom,qcs404-qfprom
>>>             - qcom,sc7180-qfprom
>>>             - qcom,sdm845-qfprom
>>
>>
>> Above is not required for now in this patchset, as we can attach data at
>> runtime specific to version of the qfprom.
>>
>> This can be added when required!
> 
> I'm OK with leaving off for this patchset.  After we get everything
> landed for blowing fuses then I can send out a separate patch where we
> can debate the merits of adding the SoC-specific compatible strings.
> :-)  Sound good?

Sounds good!

--srini

> 
> -Doug
> 
