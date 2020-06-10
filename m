Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A655C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523A120872
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXIiKLoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgFJKkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgFJKkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:40:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7B1C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:40:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so1652959wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qLlLk3V5ioxa5pJGyX00HwHM24UNk9AnRXpgPCWgkA8=;
        b=RXIiKLojET+GmBfIBlY18PfL9PfblafAEJZFIj0V/UCtrbXGvAIeAWG75PsJ8XUeLK
         4hlKNrP/u/8Ze+Ve8R39WNmgTuzD85NMze4bdw4Rg6KkUbDas1CYGfVBFgcqtcjNKRXP
         O7hrA170mwgCTnHULnrgD0mUNuRr1SDX7Y6rg3r52SiAxXcMeQqP927XgVhMupaZkU5V
         XLMxYsIrCLCZpQnkYemssLNbmZLtkWdQWZqwBKkVzcvEcP8l/1Vy+W+tau7NG6ZpWZ7U
         DdaA3MV/w0oKcFFwCah93KF8MWJlzHmJ0KBANYSGdeL8mTy2xAIFyJzBR55FDRiq4CuD
         v51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qLlLk3V5ioxa5pJGyX00HwHM24UNk9AnRXpgPCWgkA8=;
        b=OZs//0HdnojaEmhcRrW8Ny18ODFjqkb5rvTnG8yRlrtGcemnlVYRaOXIBtQoJsfDgr
         LQyiDKGbHKgkU5VEHN4Das82ioyRk05WKBlt/hyybSPCmqltGfZsyEl6OSXJ5ony+JDD
         DGy62vCrT0ik7tDijx+TBn8+QL6MtA4j+m8/4mAsW5GSclaSBiC+xcFvv2jKrtpj2SE/
         cMi2Cbo6MpfcnSP05gK0/yMj8Ex/CMViTIU8Aj+cTGsxHvB3wOzHyp2RPv3Qcab2ruHT
         kV60Tm8YYiYfeyYitKkYpcr+5tpwqZ4Riv7QIyx8a7kLDsv+YEM4+8Zzf7Q/HGX9MnSo
         SAOA==
X-Gm-Message-State: AOAM530YS7uNVj/OfXB50WNvMp53YHEmnufl+7roJNq+gutykW4Jv1m0
        CqpJ9KVIShPnq3W6Ujr5Wk2KVITrzWk=
X-Google-Smtp-Source: ABdhPJxMnh6Q+iHJ/ITsv+IujCAUdhqJPGacWEISNqEsOna4LjK7wdSM4T9bxHxEfageYkx5/m3ygA==
X-Received: by 2002:a5d:6085:: with SMTP id w5mr2919542wrt.322.1591785611772;
        Wed, 10 Jun 2020 03:40:11 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q4sm6201705wma.47.2020.06.10.03.40.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 03:40:11 -0700 (PDT)
Subject: Re: [PATCH 3/5] soundwire: qcom: add v1.5.1 compatible
To:     Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-4-jonathan@marek.ca>
 <20200609052619.GB1084979@vkoul-mobl>
 <53817047-f916-b042-70b7-66aa875a9ade@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <a8fddf74-9f95-9bc8-6e4f-5fb654c6a43c@linaro.org>
Date:   Wed, 10 Jun 2020 11:40:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <53817047-f916-b042-70b7-66aa875a9ade@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2020 12:17, Jonathan Marek wrote:
> On 6/9/20 1:26 AM, Vinod Koul wrote:
>> On 08-06-20, 16:43, Jonathan Marek wrote:
>>> Add a compatible string for HW version v1.5.1 on sm8250 SoCs.
>>
>> Please document this new compatible
>>
> 
> Does it really need to be documented? The documentation already says the 
> compatible should be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>". It gives 
> "qcom,soundwire-v1.5.0" as an example, which is not actually a supported 
> compatible, so my understanding is we don't need to update the list of 
> examples with every possible compatible.

checkpatch should have reported about this, and in future once we 
convert to yaml and list the compatible strings then dt_binding_check 
would fail too. So there is no harm in adding an additional compatible 
string for this new entry.


--srini
