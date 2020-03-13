Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E184206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpD39hF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCMS3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:29:19 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34590 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgCMS3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:29:19 -0400
Received: by mail-io1-f66.google.com with SMTP id h131so10508522iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 11:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rgpCisfwliu4dA/jyaDv1MUiSRkvdH5MLMeJWdZUnqI=;
        b=mpD39hF35AgrU7AYEjSQ5nIyCMV3v/hcL//P5TRI6b+2wKLWSozHIsme/iJ/rmGotH
         1xHe9X3Vi4k/fFBOXiahhQl7s4FykK5VXBJyUA+cE0409JJvM/AbLqPM9TYXBpFlLqTB
         PrShPCwAn9C05xrSOr/pHs4hRFEJR3I6DWdrDeV80NcADsyPDgYHWB15pF89zimUK1Y5
         U4PnJfybeN0MV4ngBcE2hLYBuSUHVQdPtnJUk6JTa3U6t1fJX3qIJcO4bhlg/kmNVjfa
         VlxKOjyEDEf1jBHKILfAjuKbyu6EykXk+n190ACwD339qv3pYCALJ0ZgwlbCWdibvZVv
         lHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rgpCisfwliu4dA/jyaDv1MUiSRkvdH5MLMeJWdZUnqI=;
        b=tOhG28+smRi0c0TFbdDrLu35Q+Ms3xuoL1N7/FK9x6L4rLIWiocDB+Mi2uacadCISE
         rIjUj4wQv3w2I/TAe6H0IMPuj73VdlQ5m+xYUyfLESxhVcERfYMNcmbTVw2pg0dmR29l
         6kbA+YaFzdXMRkX8GLp++BAdiUkY/oo/7aqLDvbhsFVzlN4HziQlPaptWL090SUu1W+c
         Qd+OQq/KL5XEcZqfKyzeDED5PznQWUMln58h3/fPkxPaluDAGYRopFdzUmBM6xZkNhd4
         7WYPLUzLajOaw9lzHk+lDLunhmiijGKdb3UQAWU7RZaqn0qQxA9dSFD6D+nb5Y4h4ch9
         7Fpg==
X-Gm-Message-State: ANhLgQ0/UKZC5sX2y7Gzqf9w9XmqM4Z1s5bje3xG6wvS41qlUArxq/JM
        HY+0aqY+U25SIhP9yvUDr+fWaQM/l8g=
X-Google-Smtp-Source: ADFU+vvpM0wd2O7ifP4eXZtrqD9vKFHM5Ib/Y8jdC2N8E3k+3ekJEo86DBUb+v/Wr+W1/3Wl0jxnkw==
X-Received: by 2002:a05:6638:19a:: with SMTP id a26mr14422046jaq.137.1584124158661;
        Fri, 13 Mar 2020 11:29:18 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id b5sm5103751iln.64.2020.03.13.11.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 11:29:18 -0700 (PDT)
Subject: Re: [PATCH] soc: qcom: ipa: build IPA when COMPILE_TEST is enabled
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200313121126.7825-1-elder@linaro.org>
 <20200313.112524.278974546399568453.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <f886a27f-e7ff-3ad9-01ba-6b9fb0045b41@linaro.org>
Date:   Fri, 13 Mar 2020 13:29:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200313.112524.278974546399568453.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 1:25 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Fri, 13 Mar 2020 07:11:26 -0500
> 
>> Make CONFIG_QCOM_IPA optionally dependent on CONFIG_COMPILE_TEST.
>>
>> Suggested-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Alex Elder <elder@linaro.org>
>> ---
>>
>> David, this implements a suggestion made by Jakub Kicinski.  I tested
>> it with GCC 9.2.1 for x86 and found no errors or warnings in the IPA
>> code.  It is the last IPA change I plan to make for v5.7.
>>
>> Once reviewed and found acceptable, it should go through net-next.
> 
> When I try to use this I end up with the following Kconfig warnings:

I'm very sorry about that.  I'll look it over again and fix it.

I got another report today from LKFT saying that there's a different
problem when ARM64 is built 64KB pages.  I'll address both of them in
an update.

					-Alex
 
> WARNING: unmet direct dependencies detected for QCOM_SCM
>   Depends on [n]: ARM || ARM64
>   Selected by [m]:
>   - QCOM_MDT_LOADER [=m]
> 
> So this needs more work.
> 

