Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493A9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26755207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="0BTxf6DY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgFILRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgFILRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:17:14 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F08C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 04:17:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so17230173qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8K/jnkPsdiZF6eJ0n8tJ/WJEe8w05I+4ekJ4W32fFhU=;
        b=0BTxf6DYNmwWNxgjnTyhdLS2gDHt0tdhFxIufvs5rouUZ5s7OVTL3OToXj4U94EtvZ
         7ZOu8FTAXMIV9tPB0hmqwPP7j60dqxLxnRUAvadi9P51FjGmAHIhX3hgz58HkeX9jSIR
         eG4vOcTNHAfF94fFcciRb2HhwAxwCX5GvUWXDKN2WYHB35Qk1CMSMAAUGm6+kn2W19Xp
         uAvCoPY5+Nlyn6BkE9L7/B9PGEbVTg6lY7mRzn0FhQQRNjN7xuCO691bOTsikoS4OOkF
         sTIH5f0oaq3u9AZ/mmcRqOpsjvquTvOMeJgnH8xgjGdexXzwNMfO6Z638OLU/dv8roSx
         4/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8K/jnkPsdiZF6eJ0n8tJ/WJEe8w05I+4ekJ4W32fFhU=;
        b=blKB2tzJwSlu0Tm1EdcO/Ol2GZya0O38ksJGz6glPi/X3zZfriavmGJF04AL1ZsTZo
         aR8LexChmEvI0OyPcgPIN3o1AOmpF9Fw3CqQP+OFV6cpWuXxYDXK8+4+KbDILivMtFNt
         KttyLqsOb1EE1Dnt2aZ8zEf0JFbWWjiwhQj5SQDq/lLZDpQ793Dm878U5jG8/cGSr4Fy
         qqmLcB02aBmEsZZWJ7Yx8S91VyIzc7pxAZKBV5F46o2CctKgHG/nqqqFdzWuV+aGAti/
         9uYhYaKvnD4p5fZoiI1BKxuC6B4dCpaSj2XpbYqI3klVQS8MEvVrl7eD/vAcB6i1mpQ9
         7XnA==
X-Gm-Message-State: AOAM532QWbZYcc97py8cnh2RllvGQQkyWQJZd92rc+QzR5W+T0bLKjB4
        qkligS0+EIBHnVathI0wvojz3bKTHiQ=
X-Google-Smtp-Source: ABdhPJymdvBdrGAG6nTuShwBgY51Grt5Q2yeOf0MfZe95FaTvjZbkacfY2Sa7EQU4T2ZbivS/uDBtQ==
X-Received: by 2002:ac8:3267:: with SMTP id y36mr29064664qta.241.1591701432472;
        Tue, 09 Jun 2020 04:17:12 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id y129sm9011684qkc.1.2020.06.09.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 04:17:11 -0700 (PDT)
Subject: Re: [PATCH 3/5] soundwire: qcom: add v1.5.1 compatible
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200608204347.19685-1-jonathan@marek.ca>
 <20200608204347.19685-4-jonathan@marek.ca>
 <20200609052619.GB1084979@vkoul-mobl>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <53817047-f916-b042-70b7-66aa875a9ade@marek.ca>
Date:   Tue, 9 Jun 2020 07:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200609052619.GB1084979@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/20 1:26 AM, Vinod Koul wrote:
> On 08-06-20, 16:43, Jonathan Marek wrote:
>> Add a compatible string for HW version v1.5.1 on sm8250 SoCs.
> 
> Please document this new compatible
> 

Does it really need to be documented? The documentation already says the 
compatible should be "qcom,soundwire-v<MAJOR>.<MINOR>.<STEP>". It gives 
"qcom,soundwire-v1.5.0" as an example, which is not actually a supported 
compatible, so my understanding is we don't need to update the list of 
examples with every possible compatible.
