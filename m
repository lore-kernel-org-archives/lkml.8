Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BDCC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723F8208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VWNuwIhB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCESWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:22:40 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35711 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCESWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:22:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id r7so8248458wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a2anD5Dg00GGuu7ktR9RjZ1JvnNFmxQvljFzM320Nd8=;
        b=VWNuwIhBEjZXRKsfnczg9Nar5nP19oQIsTjNVfOwlpnT2o0Edu74Cg6q6NVLYtXjUA
         E9nVpSHSsePW+xMi+RojasqAHh/bjZV6PWhQFj/5L23C5tqN5r/AjGSz+FVnwfUDCMdN
         15tXe+toeuzyogjsrS/PS3RJum4fyTGzn+/FJ1wPYU3UnoZZZyT0LbH6hpV41YSuBe57
         MccFfyffCoaYz7/YMgPwxlbJtIrk+MXnSx0JbsuMu7k5HV6FkZOmslK3dQr5lwFwBPua
         GeJTncZf1uCih1NQFBeD5jwAGcH08LG4z8isOct4xPSPei+BL/2cdkofNgiEYIskLiYx
         SPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a2anD5Dg00GGuu7ktR9RjZ1JvnNFmxQvljFzM320Nd8=;
        b=QcukG1c1ZtbT9Vj+cMNm4ddZtndMzF5LU9tCfvUOLQlgk4G4IYMNmSgxDsETvQAhuZ
         turqxRGZTSFlJsHo6QdRpJhNZqs6uyoPr9J+EJ97JOfIEO+hOCis7XOYC115PiXwApch
         3vLh+/87b3SN4/BuZOWm/8UzBQ8aMpacmwVX46ESpqV4X8lNAItilS9K1MrOJH+ZpyTO
         zT9SRanu+lV93F8WORQXRTzX1xLkllOUeooHLyPy9iEHakG+rLf5YbPaO7kk+9AGXmfE
         qR6cwlh/9WJy4J9yh+v94OW6QsbMsrE37NAXWwRszaUO7uqhjK5XAmn4smp9eRXi4uHK
         yIgg==
X-Gm-Message-State: ANhLgQ3T/QkpmWk6ptzonCFLo3X/P1pt+GgEbWbglalHJbJN4+mmpoUM
        OEYrQagWG0sjxcXCD051I47heA==
X-Google-Smtp-Source: ADFU+vuCteNRVdM76+1URbWXLgUW9P5Y1amlPIfd1vL0VirqlcrPpKof6N7OxhEHf4vAFLSoMXjYvg==
X-Received: by 2002:adf:df8c:: with SMTP id z12mr225481wrl.174.1583432557745;
        Thu, 05 Mar 2020 10:22:37 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id p16sm45367737wrw.15.2020.03.05.10.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 10:22:37 -0800 (PST)
Subject: Re: [PATCH v2 1/3] nvmem: Add support for write-only instances
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB0438930B1FC30EF79F15FD1780E70@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <b934ddde-702a-1731-034d-1682a9df23e2@linaro.org>
 <PSXP216MB04383EBB7FFBAEA7D9ABCAEE80E20@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c9f4b098-3a57-38c6-8ca8-7dcda5e4c099@linaro.org>
Date:   Thu, 5 Mar 2020 18:22:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB04383EBB7FFBAEA7D9ABCAEE80E20@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/03/2020 18:11, Nicholas Johnson wrote:
>> If for any reasons you would want to add Write only file then it should be
>> added for both with root and user privileges.
> Mika just advised me that we should not have world-writable files
I totally agree with him, should have been careful before replying it 
too early!
lets keep root only writeable file.

--srini
