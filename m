Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A99C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FB92075E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TClc42ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgFRMZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgFRMZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:25:15 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC84C0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:14 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o26so4734081edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UJIK3eOWDyPeiIHQU/0dVlnLexDXba9OTxbGB4A2gl0=;
        b=TClc42ft33RKTYHUlkBWRBKsios0AGMU7D9gpjxS2oUwxMcT80bd7DgivTYXhb690C
         XiHzmQA4YzrPiQxrocVdRCO07C3p62JJ/o92jBfwRDpddxb9LjPgbm6kQ6AD6/vYxvT+
         dOYeAVVW4x4ZiiGOWY/tjcNfQeoUSSYKL/EokpoSZjJrkOeEvIteZ7jY0IIWayaALA/8
         +TY1cesiZNA9fFeghI5qxn2sBzNglIr7koVGWACUlK6eDy9KZbD4uE7fn2IXjaJ43R4V
         GYPUXzhtarWhOmZV5l/V7JuMJ0x1YewjoA1k68HsPeyVoPlWRfJJK8YkAIDuiSCmvBmc
         HxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UJIK3eOWDyPeiIHQU/0dVlnLexDXba9OTxbGB4A2gl0=;
        b=DxMt+S+8YbtlFViugYU4blLWn/aXZ4pBjk4Mq4Qqnaa5zpJtiej+0anNqIRunUwHq2
         Py9VXE/O2vOTVmecMwgtVfCtCPAholaMrq92oV/IxUIeVh+Y+Nd8g/ULEKar2t+34QWD
         pv/dQjD/WkdPDjL50hpUQobYqcPT8ugusMmZwNDCSdB+xNFXxky+2pTDtpEljqmg/8Ls
         3JX9CjpBXcgFfUQadToWcnxE1HX1ldzUVvRsPbfzjaP83OKGpQOmjfx5YN2mcADGtzxy
         PyKtevQMUW02dfv5oLTAcgp6fyylUYugFsY8aTkmfSHN+X+RVwl5cYW5aWGuXTGUuA3R
         Y2sg==
X-Gm-Message-State: AOAM5309VxIl2fGDRggXSmv/IVhsKWV45tPUj4tYTAAoHccOSjJ6LNrk
        mDF/cHtNv0i+23XM+y0rhYLI1DVkmq5CAQ==
X-Google-Smtp-Source: ABdhPJwqR4gqZ3OqNJw1hJs4k/8ksjobysLkcxPc2MEE1KzpZBuqHII90p7CC0TTvHLdEXaJaY+GyQ==
X-Received: by 2002:aa7:c15a:: with SMTP id r26mr3649380edp.21.1592483113177;
        Thu, 18 Jun 2020 05:25:13 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-140.ip.btc-net.bg. [212.5.158.140])
        by smtp.googlemail.com with ESMTPSA id s17sm2157278eju.80.2020.06.18.05.25.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 05:25:12 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] DVFS for IO devices on sdm845 and sc7180
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mark Brown <broonie@kernel.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, robdclark@gmail.com,
        robdclark@chromium.org, viresh.kumar@linaro.org, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <20200617221546.GC4525@google.com>
 <4f3d4c91-2a01-8ef5-1ad0-73ed354f930a@codeaurora.org>
 <9bb7fbb6-6309-3f30-dd4f-2ee3d187c074@linaro.org>
 <3ec9bc56-3e31-64fe-320a-2dc153a81f98@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <d715708b-db7a-efb7-5861-aa5bb8dfcd86@linaro.org>
Date:   Thu, 18 Jun 2020 15:25:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3ec9bc56-3e31-64fe-320a-2dc153a81f98@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/20 3:11 PM, Rajendra Nayak wrote:
> 
> Hey Stan,
>  
>> On 6/18/20 7:47 AM, Rajendra Nayak wrote:
>>> Hey Matthias, thanks for summarizing this.
>>>
>>> On 6/18/2020 3:45 AM, Matthias Kaehlcke wrote:
>>>> What is the plan for landing these, it seems not all must/should
>>>> go through the QCOM tree.
>>>>
>>>> My guesses:
>>>>
>>>> tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
>>>> spi: spi-geni-qcom: Use OPP API to set clk/perf state
>>>>     QCOM tree due to shared dependency on change in
>>>> include/linux/qcom-geni-se.h
>>>
>>> That's correct, Bjorn/Andy, can these be pulled in now for 5.9?
>>> They have acks from Greg for serial and Mark for the spi patch.
>>>  
>>>> drm/msm/dpu: Use OPP API to set clk/perf state
>>>> drm/msm: dsi: Use OPP API to set clk/perf state
>>>>     drm/msm tree
>>>
>>> Correct, the dsi patch is still not reviewed by Rob, so once that's
>>> done,
>>> I am guessing Rob would pull both of these.
>>>
>>>>
>>>> media: venus: core: Add support for opp tables/perf voting
>>>>     venus tree
>>>
>>> correct, this is pending review/ack from Stan.
>>
>> I tested the changes in the driver, and they looks fine. But when
>> applied the corresponding change in the DT node I see this message when
>> the streaming is stopping:
>>
>> qcom_rpmh TCS Busy, retrying RPMH message send: addr=0x30000
>>
>> I tested on v5.7 (linaro-integration). Should I be worried ?
> 
> Is this seen on sdm845 or sc7180, or both?

Seen on sdm845, I don't have sc7180 to test.

I can try it on 5.8-rc1 integration-linux-qcomlt if you think there
might be a fix in rpmh.


-- 
regards,
Stan
