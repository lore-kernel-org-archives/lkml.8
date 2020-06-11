Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4073CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18FB420760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iN1AZcZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgFKM6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgFKM6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:58:04 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ECDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:58:03 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id l6so5308597ilo.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L4FmGBeOqb7XHmV2su2Hlr1yuXc/ftlMBpAtmSul0aY=;
        b=iN1AZcZlv5iRcZ8ELgmWpm5NDm89/CA0vnSJH7TavV0gbT6NdbPMg/s1O0TF/kA8tU
         mMIoumF4qi29fC0mCpkZdcmPXxSsa89axQiuWpsRyaEnTGNnPfvc4gIlQ35pfOkmL5ix
         2eOHy8Jj/nTGdozcGHNNlq6N5bReaU/oSAS/XvYT/ahWE+KC/L1IdWp0U6TEjUQgb0+A
         3EY+hTkKWwMBdEXnuxKvPXOy0+brccnSvTMxJiqPIv0xJLy2cCpmXhfUf6f9BdPZrUFK
         UBbBfjzqSLeaHFIb3wldD2iAAlwjHpu3YesOdrhONpAjO+YVfPvX1VoQicE/THjTFsN2
         Zknw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L4FmGBeOqb7XHmV2su2Hlr1yuXc/ftlMBpAtmSul0aY=;
        b=J+BzA/3cHy41zpGA6S6ZDPCpejtfhGHxlCTW+H0M8aml+kHS6wQyphBGiBWlnK4Cw3
         m/gch6sHtQ72ynIGEy75mNZnr6v9zWmD5xWs4va/1L03EAWFvq7goEEV2fMWlhGFSYRX
         nNXgDMMT0HuObuRmtusa1/TVG2Dy+Wnfi85EzvCiSJFReNMCxu3WXbDRb3uzmV47+YuF
         VVka9yTVzVF6HCbw3PtbuF6i80/qUgQ84iMyf+HTU2igsIzZ2mp6186JqsJQgW5fGnsM
         ShLfWG30FMLp7lmD8JrkaJe/WSokC35GKskMQ512TOaHN++nMjDyvTUqUbujEFd1Dr7T
         +VtA==
X-Gm-Message-State: AOAM530jDtJBSEckNMJH1IyjR7qokF6pOXfKyDnEUvX43jj/gfB32L77
        wQ3ZRaJj4dB/8plPNL6TAnwKe2m1Hbs=
X-Google-Smtp-Source: ABdhPJymwQMdZhFaSyjGDnlt+menDtwzQQADglIsXXECW6hndG5cCdTG68VLPtru0r96t/v1fmFy2g==
X-Received: by 2002:a92:290c:: with SMTP id l12mr7549411ilg.279.1591880282837;
        Thu, 11 Jun 2020 05:58:02 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id a10sm1513662ilb.31.2020.06.11.05.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 05:58:02 -0700 (PDT)
Subject: Re: [PATCH net 5/5] net: ipa: warn if gsi_trans structure is too big
To:     David Miller <davem@davemloft.net>
Cc:     kuba@kernel.org, evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200610195332.2612233-1-elder@linaro.org>
 <20200610195332.2612233-6-elder@linaro.org>
 <20200610.163658.2043816131147701638.davem@davemloft.net>
From:   Alex Elder <elder@linaro.org>
Message-ID: <448830d1-c19e-b8d6-169a-a114baae133f@linaro.org>
Date:   Thu, 11 Jun 2020 07:58:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610.163658.2043816131147701638.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/20 6:36 PM, David Miller wrote:
> From: Alex Elder <elder@linaro.org>
> Date: Wed, 10 Jun 2020 14:53:32 -0500
> 
>> When the DEBUG_SPINLOCK and DEBUG_LOCK_ALLOC config options are
>> enabled, sizeof(raw_spinlock_t) grows considerably (from 4 bytes
>> to 56 bytes currently).  As a consequence the size of the gsi_trans
>> structure exceeds 128 bytes, and this triggers a BUILD_BUG_ON()
>> error.
>>
>> These are useful configuration options to enable, so rather than
>> causing a build failure, just issue a warning message at run time
>> if the structure is larger than we'd prefer.
>>
>> Signed-off-by: Alex Elder <elder@linaro.org>
> 
> Please fix the problem or prevent the build of this module in such
> configurations since obviously it will fail to load successfully.

It will not fail to load; this really shouldn't have been treated as
a BUG to begin with.  The condition can be detected at build time but
I'm not aware of a BUILD_WARN_ON() (which would probably break the
build anyway).  The check should at least have remained under the
control of IPA_VALIDATE, because it's really there for my benefit
so I'm told if the structure grows unexpectedly.

Your pushback on this has made me think a bit more about how much
of a problem this really is though, so I'll omit this last patch
in version 2 of this series that I will post today.  Then after a
little more consideration I'll post a revised version of this one
(or not).

Thanks.

					-Alex

> It is completely unexpected for something to fail at run time that
> could be detected at build time.
> 

