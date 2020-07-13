Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCBDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979E02072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="AsDVnUJk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbgGMNsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728950AbgGMNsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:48:31 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:48:31 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w27so9893610qtb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=whfCCmO7TNNcabn6+SFR27U2aTuxTD9IQzPOWcIz0mw=;
        b=AsDVnUJkW8wZ4111n1Q2nBdNdYPimCzz0UVZq8a8y3pPyw4jKLDeAIPjYRjwIHz8a4
         KymFI69PumnZQljIoO+ffRr5sAfyxh9Tx3H1ihNSu6xSBNqO32qk+tcxIRdtO31UIC4H
         LfQPmrPeG2vYkt7eSxE72k5v70O4W2b8JbCF6T6KzqZREOUTQk3C6bc/sJ4+OyzvDOWC
         9UszW5zQUhKDyNdZy5X9IeMqKunocanY56DVBsN64wX96hrvHQFXjEXE9h39GyZUsmfU
         UUIJmZHpfHr85GsHMS24mZR7WE8AusHSUW94rzZc5Cp0HhgwM31f5Sr6pAtjCOMFo0Hy
         iNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=whfCCmO7TNNcabn6+SFR27U2aTuxTD9IQzPOWcIz0mw=;
        b=k0H+MLqDu60HMOijU0ghzPnvjWlo8AtVGvimQpclmFcp468SI0tjiOQ8rk4YIw38Jt
         wWoSvaaIqlBda0VCfcgNRxV0D1KEitHXks6X3/qPqHYdgFSawdMx+vvNPBNL0xxrpO/m
         8I69mQ6zBEukNo5Xc8bNbIBUyVEJyeOcqAen3Js6J++c9bAuTOG8K9PAdeS1V7hr/K51
         eoGfz7fbmj8iUGRwdV7Q/rWECmCdOrQovZpIgHnT2I8/QNhSFuNpv/jhJ8gWmzPKxdBk
         jywt9lAE9feHSbOWegAohL0jWZ4D9p8h3kJbLTOuR8QyOcKKvWc9XPemWfoa4u4me9tt
         FGcA==
X-Gm-Message-State: AOAM531oTv+veahHJ+Q0JTGoRnVEQJpQthNfJ+3fAM0WM8Ih5aUkQ1DS
        FBHhRRnzAO6KJj239uB3GjiHDA==
X-Google-Smtp-Source: ABdhPJxx00W1Vp+MsZHSypI4tIxcsugNKbIon/mXh6bzEpDLyfmXuCLJZ4RJS3bp+btXAF773E+ZRw==
X-Received: by 2002:ac8:3ff9:: with SMTP id v54mr84259416qtk.352.1594648110322;
        Mon, 13 Jul 2020 06:48:30 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id r7sm18415476qtm.66.2020.07.13.06.48.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 06:48:29 -0700 (PDT)
Subject: Re: [PATCH 4/6] interconnect: qcom: Add SM8250 interconnect provider
 driver
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20200701134259.8055-1-jonathan@marek.ca>
 <20200701134259.8055-5-jonathan@marek.ca>
 <5a0eca0e-d496-d8af-ca41-0f07e9a3e01d@linaro.org>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <5074d900-da92-0b8a-a7c6-1ebfe4ae2d56@marek.ca>
Date:   Mon, 13 Jul 2020 09:47:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5a0eca0e-d496-d8af-ca41-0f07e9a3e01d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 9:30 AM, Georgi Djakov wrote:
> Hi Jonathan,
> 
> Thanks for posting these patches!
> 
> On 7/1/20 16:42, Jonathan Marek wrote:
>> Add driver for the Qualcomm interconnect buses found in SM8250 based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
>> Based on SC7180 driver and generated from downstream dts.
>>
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
> [..]
>> +
>> +static const struct of_device_id qnoc_of_match[] = {
>> +	{ .compatible = "qcom,sm8250-aggre1-noc",
>> +	  .data = &sm8250_aggre1_noc},
>> +	{ .compatible = "qcom,sm8250-aggre2-noc",
>> +	  .data = &sm8250_aggre2_noc},
>> +	{ .compatible = "qcom,sm8250-compute-noc",
>> +	  .data = &sm8250_compute_noc},
>> +	{ .compatible = "qcom,sm8250-config-noc",
>> +	  .data = &sm8250_config_noc},
>> +	{ .compatible = "qcom,sm8250-dc-noc",
>> +	  .data = &sm8250_dc_noc},
>> +	{ .compatible = "qcom,sm8250-gem-noc",
>> +	  .data = &sm8250_gem_noc},
>> +	{ .compatible = "qcom,sm8250-ipa-virt",
>> +	  .data = &sm8250_ipa_virt},
>> +	{ .compatible = "qcom,sm8250-mc-virt",
>> +	  .data = &sm8250_mc_virt},
>> +	{ .compatible = "qcom,sm8250-mmss-noc",
>> +	  .data = &sm8250_mmss_noc},
>> +	{ .compatible = "qcom,sm8250-npu-noc",
>> +	  .data = &sm8250_npu_noc},
>> +	{ .compatible = "qcom,sm8250-system-noc",
>> +	  .data = &sm8250_system_noc},
>> +	{ .compatible = "qcom,sm8250-gem-noc-display",
>> +	  .data = &sm8250_gem_noc_display},
>> +	{ .compatible = "qcom,sm8250-mc-virt-display",
>> +	  .data = &sm8250_mc_virt_display},
>> +	{ .compatible = "qcom,sm8250-mmss-noc-display",
>> +	  .data = &sm8250_mmss_noc_display},
>> +	{ }
> 
> My main concern here are the display RSC nodes. We should not add the nodes
> for voting on the display RSC, but use the "qcom,bcm-voters" property in DT
> to list both "hlos" and "disp" as bcm voters for gem-noc, mc-virt and
> mmss-noc.
> 

Would it be OK to just drop the display RSC parts from this series then? 
Not sure if anything needs it to work, but I'm not using it currently.

Though if you can provide details for a solution, I could implement it 
(qcom_icc_provider needs to have a list of voters, but I'm not sure how 
to deal with everything else).

> Thanks,
> Georgi
> 
