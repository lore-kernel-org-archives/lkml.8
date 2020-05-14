Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A2EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82BCB20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kk1bCOr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgENVmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgENVmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:42:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965E0C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:42:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id y16so744804wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yI1U8AUDDWNI+XLdCwvv3rQd/eXkcVvXBcnHMoqn2qs=;
        b=Kk1bCOr+u0FZ27Ewkgo62P8UuxadSMbSCNxeDyztymTB+LAUTxnvfBx3RKlx8eaDBq
         4gRT1WWY3+SYT8cT9GDQ9735amGfk5TXyyUGW/yi29CejUWYEFd/16MeVgD5sWoQ5OSo
         Tgvz0PxpMiQ2OsiNskkJ21U01V81g9N09C2MvATjUyDiL313bTfOsylyNWH+0YJW2wyb
         Wt93Al6Ou9B2ql9V3jjVMwGbbfq6xQ4z5E/5VZC5Qb+Pc5XpXyvnmihbVNgrsE7HHat6
         3gNtsoydhQWTtpT/WxmG37CoTNcL0aIK7eP7onAZ5SxJJKHym0OATkLunzM9zlc54mXz
         qzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yI1U8AUDDWNI+XLdCwvv3rQd/eXkcVvXBcnHMoqn2qs=;
        b=tId7mSWC4rYOKYmY+Faa1AcHSihvvbfOtBqX7XV8hKW/cKdQP7G4xiayDJYcMGJThx
         Kg0xhA1U3HkdKo/TZw3g2cKHe+LvUyqTy/pHpLxsOKBPGXKg63kJgSp+A4/ebj1P6rXq
         byVtJqjmHmevt2h+B9vm0UTSPo6QFsWlkYfS3R3sdRQCpjgduYup1HRV7dOV5+paMe9N
         xksDtR+bSl4nvhEIV4DHJxOuu0d6+8PksKFOdABd5RbTAz8NTT4iDT378fvDcAWI3GXi
         7P9hG2CloFQX27xewktxTwdR3QOZwrzpgVJuz+KZY8kY6fqqJu7Yd0Hsno6srgPOOdMV
         k/pw==
X-Gm-Message-State: AOAM531m5ZRXyFqsphfMxrDXYdslXYy9O/bfkbMAcG2nztj6T2Wf9sUc
        VzjjgAImpxPguODo4G3aUsKLNw==
X-Google-Smtp-Source: ABdhPJwjLsGzxSnhBdTpwCv1KxMeZM+KqYK5ICQ+zgFr9Y8weXPm1qgo3lpneSurN2sf/JsKaNVavQ==
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr506758wrt.48.1589492523207;
        Thu, 14 May 2020 14:42:03 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id p8sm406400wre.11.2020.05.14.14.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 14:42:02 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] clk: qcom: gcc-msm8939: Add MSM8939 Generic Clock
 Controller
To:     Stephen Boyd <sboyd@kernel.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        shawn.guo@linaro.org, p.zabel@pengutronix.de,
        vincent.knecht@mailoo.org, konradybcio@gmail.com
References: <20200512115023.2856617-1-bryan.odonoghue@linaro.org>
 <20200512115023.2856617-3-bryan.odonoghue@linaro.org>
 <158949186096.215346.4442403798485610696@swboyd.mtv.corp.google.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <ae2045bf-52f9-9be8-b48a-90d65c1ab96d@linaro.org>
Date:   Thu, 14 May 2020 22:42:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158949186096.215346.4442403798485610696@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2020 22:31, Stephen Boyd wrote:
> Quoting Bryan O'Donoghue (2020-05-12 04:50:23)
>> This patch adds support for the MSM8939 GCC. The MSM8939 is based on the
>> MSM8916. MSM8939 is compatible in several ways with MSM8916 but, has
>> additional functional blocks added which require additional PLL sources. In
>> some cases functional blocks from the MSM8916 have different clock sources
>> or different supported frequencies.
>>
>> Cc: Andy Gross <agross@kernel.org>
>> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
>> Cc: Michael Turquette <mturquette@baylibre.com>
>> Cc: Stephen Boyd <sboyd@kernel.org>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: linux-clk@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> Is this a co-developed-by tag?

Yep. I'm squashing down about 30-some internal patches to this one patch 
here including one or two from Shawn in this set.

I wasn't quite sure what the etiquette on Co-developed was i.e. it 
wasn't something git allowed me to specify with a "git commit -s 
--co-developed="xyz"" so I just retained the SOB.

Looking through git logs I see an example

I'll apply a
Co-developed-by: Shawn Guo <shawn.guo@linaro.org>

for v5.

>> +static int gcc_msm8939_probe(struct platform_device *pdev)
>> +{
>> +       int ret;
>> +       struct regmap *regmap;
>> +
>> +       ret = qcom_cc_probe(pdev, &gcc_msm8939_desc);
>> +       if (ret)
>> +               return ret;
>> +
>> +       regmap = dev_get_regmap(&pdev->dev, NULL);
>> +       clk_pll_configure_sr_hpm_lp(&gpll3, regmap, &gpll3_config, true);
>> +       clk_pll_configure_sr_hpm_lp(&gpll4, regmap, &gpll4_config, true);
> 
> We should probably configure these before registering the clks. Can you
> do the usual, map registers, configure stuff, and then
> qcom_cc_really_probe()?

I think so. If there was a good reason to configure the plls after the 
registration, I can't recall what that was, maybe the original flow from 
downstream ...

>> +
>> +MODULE_DESCRIPTION("Qualcomm GCC MSM8939 Driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:gcc-msm8939");
> 
> The module alias isn't needed right?

Nope g/msm8916/s//msm8939/g - I can zap that.

Thanks for the review.

---
bod
