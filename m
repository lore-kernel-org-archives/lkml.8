Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCA9C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DDC2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="RP2QIgV9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgICMvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728908AbgICMmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:42:17 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E20C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 05:42:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 19so239051qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 05:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jBJ3+UyiPoqroyu1zjiAGjOZlBSROfuJYS4dUaf28y4=;
        b=RP2QIgV9av5cfW4E0jEqmA7mDTpzMBwskor1FkPmpDSAFax6n63uP0gHagAKUBoLXo
         Fb5ct+hksrD6IpdtMufs3DNRrXJocexBW5s+D7hhM320VYplwMb2gIZdEpRcomM/lCth
         3xQa56eJUsxBsQjTtaLonw7TE+A4uMkw/gduUfRH9Z7vNXQiSdaHQkJhCxDJgb9MZqzU
         N3AiS1VwOo/Xrbbco3rCcp7li+dxP25ZUK3tEWdlRxjbmKSHpsuP7nIWa9VoIXYg9ifc
         KmPOt4KLx8zuhtSUs856BF8M2ysnqatk4Gctlv4MSrbnjkbHK9uCK2Q0iHSoE3zcMUfT
         prAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jBJ3+UyiPoqroyu1zjiAGjOZlBSROfuJYS4dUaf28y4=;
        b=D7e7YoU4cFEC4hFALJDWcJsht05WJQEeBxqWooWeOFPGC9Dusn8iI5s/q4iPuAR/6I
         GnHvv+MuRJPJbCeGBkU0UWVG6d8K31uOZOvoDeoXvW+iQkqeR8109BMlheIeBaclpWcw
         nnRcO6dtQVmLjbpDU8K7JPSWJHWZHK8jYtWmfTLFvltKoJNL4H9otx7ZjMYno6IYb7K5
         M/Y46gHgNqK98dzhJ5s6pBtG3/h0WitxZF/+BrXXqlhL9GmZXO11LKWOkRDVKgjUxftt
         HikXQPvF1PbuodRPlhkqV2UagRkoYrdKSYeJbYaHuwot/bAKAZF2PeL2HpduzAOa9PPS
         dprQ==
X-Gm-Message-State: AOAM532sVccwSk2P8JtoG/W4pMAsYjIO27Ih+sByzGLglgOIICYAu4yQ
        /PZVOszurokby5K0SwZsGtbW7w==
X-Google-Smtp-Source: ABdhPJyrJaxeh5GDMtMW9PrexCisLze+QfvJ8U+Z3y3lDDgeB//UFbLK+IEHeSxO627oS4hC+B38Ow==
X-Received: by 2002:ac8:4e0b:: with SMTP id c11mr3199200qtw.37.1599136919515;
        Thu, 03 Sep 2020 05:41:59 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id w59sm1941201qtd.1.2020.09.03.05.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 05:41:58 -0700 (PDT)
Subject: Re: [PATCH v1 6/9] phy: qcom-qmp: Add support for DP in USB3+DP combo
 phy
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Vara Reddy <varar@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@chromium.org>
References: <20200826024711.220080-1-swboyd@chromium.org>
 <20200826024711.220080-7-swboyd@chromium.org>
 <335a0660-40e1-0c1e-3f7d-87f7024de18a@linaro.org>
 <159900847014.334488.14041376759905055412@swboyd.mtv.corp.google.com>
 <62bdac87-b886-58c1-f071-095ec9945f68@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <4165cdc6-dfa6-1ff2-f317-753292a068c2@marek.ca>
Date:   Thu, 3 Sep 2020 08:41:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <62bdac87-b886-58c1-f071-095ec9945f68@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/3/20 8:37 AM, Dmitry Baryshkov wrote:
> On 02/09/2020 04:01, Stephen Boyd wrote:
>> Quoting Dmitry Baryshkov (2020-09-01 06:36:34)
>>> With these functions I'm struggling between introducing
>>> PHY_TYPE_DP_V3/V4 and introducing callbacks into qmp_phy_cfg. What would
>>> you prefer?
>>>
>>> What about the following struct?
>>>
>>> struct qmp_phy_dp_opts {
>>>          void (*dp_aux_init)(struct qmp_phy *qphy);
>>>          void (*dp_configure_tx)(struct qmp_phy *qphy);
>>>          void (*dp_configure_lanes)(struct qmp_phy *qphy);
>>> };
>>>
>>> I'm not sure about dp_calibrate().
>>>
>>
>> Is there v4 code somewhere that I can see? Another level of indirection
>> is always a solution, so it is probably fine. This driver is currently
>> written with many conditionals instead of function tables so I'm not
>> sure it fits in with the style of how things are done though. The
>> alternative is to use an enum and call different functions?
> 
> Downstream DP driver sources can be found here:
> https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/msm/dp/dp_catalog_v420.c?h=LA.UM.8.12.r1-13900-sm8250.0 
> 
> 
> https://source.codeaurora.org/quic/la/platform/vendor/opensource/display-drivers/tree/pll/dp_pll_7nm_util.c?h=LA.UM.8.12.r1-13900-sm8250.0 
> 
> 
>>
>> The calibrate call is there to "turn the crank" on the aux settings.  I
>> need to cycle through the different values for that aux register so that
>> aux can be tuned properly. The AUX channel really has another phy that
>> needs tuning so we're sort of combining the aux and DP link phy together
>> here by letting the calibrate call tune the AUX phy and the configure
>> call tune the DP phy. I don't see any sort of concept of an AUX phy
>> though so this seemed ok. Does v4 need to tune more registers?
> 
> 
> It looks like four values are written to AUX_CFG1:
> 0x20, 0x13, 0x23, 0x1d
> 

AFAICT, it only writes 0x13 to AUX_CFG1, in dp_pll_7nm_util.c, and the 
qcom,aux-cfg1-settings in dts only has 0x13. Same for all other 
AUX_CFGn, which only have one value written. Am I missing something?

