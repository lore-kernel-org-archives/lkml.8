Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112EC20773
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+5hkIQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGGOyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgGGOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:54:48 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB70C08C5DC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:54:47 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so46866570wml.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PzICV5P/5fXN0O8oi3hO1LTBadk24TZeOM2WE369Tyc=;
        b=E+5hkIQUoTRgV1/j/Ma9SS3yMkFKRNhWTaqdcl+5qmDfS9hUkLjwIVZarQFI3ZHI6b
         rlH5ZDKM/dhHSvMwZX2MnqgX1SpikG1diuKSVaIQmftVBmPxVAD8GFe5942oiEgkbfIf
         K4MXWdmpgYGbPN9O8fnM2nE4Pd82giJkcvzg/u32INEnyM54iJm2TxQOiHr6WQVF7nrZ
         fw6huJWr5zZ7djbbyiivbCCGabI6CaY3uAUtQKp6bSNMzUtjeqMPHQzOvyucYIsEPXZy
         /1QOsJYJF61qDA2Peg5s2ZES6oVye/HAV2m6kD5MAeGhYPCKPuQKvGNpkOEyCai/lPjU
         /QAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PzICV5P/5fXN0O8oi3hO1LTBadk24TZeOM2WE369Tyc=;
        b=Cf7Vh19uLQlNUYURux+Sf3q+IMgiC2e07T3ndO3Bm714MithDcgkDcWNM+K7xaWoYe
         DithUFi9OE8ohXvJk76V7s15ZyfgAkI+t3EXUkv/5ZE3jSubQnilm0S1Euhl9DQp8yb8
         m9qJYhQw8CVBD0VT70DPYrPz2d/K2Zq6Npt8zOMAzvnGWFTVb6Xkf7VCCilcvRAOEo3u
         yn/JklYBYPWGn+7IJXKHtNjeDwIZiCZhoGuy8F46aiBBvnZ/DAA+4l+5JLMoIcJIc/tK
         BZVM3X2130pWtpXHEBNUWS3H8XYwn1iB64nxl93wfAVBN9CT4D7D8WbngREYADjcZkK5
         8nEQ==
X-Gm-Message-State: AOAM532XRgc39bezXVP/OfbLqhgbuG8yh+dKdU9EHt561O1N6JF0zHia
        F9BbPxTISmibEo8ECAc7Qwp8RXa9DKU=
X-Google-Smtp-Source: ABdhPJyuonfrVFjpjX9TLl886a/7yKFi5J1qixNTUhlNFpixziv4HhnXXZg5sCj4A2JCjd5SaKBJZg==
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr4526284wmi.128.1594133686255;
        Tue, 07 Jul 2020 07:54:46 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id z1sm1363432wru.30.2020.07.07.07.54.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 07:54:45 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] nvmem: qfprom: Add fuse blowing support
To:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     mturney@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, dhavalp@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        sparate@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        mkurumel@codeaurora.org, Ravi Kumar Bokka <rbokka@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200622144929.230498-1-dianders@chromium.org>
 <20200622074845.v4.3.I68222d0b5966f652f29dd3a73ab33551a6e3b7e0@changeid>
 <CAD=FV=UJ9fm0z-6kAm4wDCfb8Ugr53i4RciCHTJT91ec27Mm4A@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bf75ef0d-1267-377e-9875-e44be3f5e406@linaro.org>
Date:   Tue, 7 Jul 2020 15:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=UJ9fm0z-6kAm4wDCfb8Ugr53i4RciCHTJT91ec27Mm4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2020 15:52, Doug Anderson wrote:
> 
> Given that I've resolved previous feedback, I've been assuming that
> the series looks fine and we're sitting waiting for Rob Herring's
> blessings on the bindings before landing.  Is that correct?

That's correct!

--srini


