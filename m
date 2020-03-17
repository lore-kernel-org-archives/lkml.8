Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA0CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0129620757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRNjU3Uj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCQMnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:43:17 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:38161 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQMnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:43:16 -0400
Received: by mail-wm1-f43.google.com with SMTP id t13so15445931wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 05:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O7+dx4u+Hruy3RY0YPcqfMJYfOQOVzar6fFmyL7+tXk=;
        b=SRNjU3UjPPU2JogOc3pawiJkNPK08TH4bpS78YDRyipn343c8eCRjVFArhAqN/UwRn
         vBf28ueQ2b6eOWQlnKEY5AwP93vzhEctKBTFNDK+NeRx9+3PQ+j7ld5mL2j38Sp2iTes
         jcw/gEljpgeAu6hKnZLoTmfTaMZaVwHHMQlFiaQvLqniz0O5We577uAioQofYQhsmN4P
         KzY53bj/GBfTUH5RrDltAT8+QoZlpHPL18D1CK3x8Qt11N/KgL+R1ZK0spQ1lwAtIVR+
         Inrr0fgIX+YfQmagoA0YbuQ555eAUMO90n4Ua+ibwfqy29Fup7TOmwwjrbWFBDem7rF5
         nQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O7+dx4u+Hruy3RY0YPcqfMJYfOQOVzar6fFmyL7+tXk=;
        b=tlHwf8HX5b03pwkHn8pGOR4owD35ujO2GVvRvZUqbdHkIfEK/tfgvgcEgtE5UBq8Vn
         anPEgbFQuwMIGfLsCg08wbIU92HoGrpz6J2BVGzTkr51ra2uY4ny+BB06tmLOCq+eWJX
         trs09gmzOp1N+F5BorWoB50/0u760NS/Vesl4qR5qFTmjuQEvuReBGFGLbhTKXT7IpxO
         DJTKqfh6sZgTkFfwQSX5DME4DOH6VnEEpoNTzwdB8HOXPppp4xfiBg8w9vrr2XiXvPK8
         trnxaJRG1kJMqeaQiiGoga3rBkT5WwqLvLiUuADfM+5EhSe58DiqTmR5Hu2iXa8QzyOP
         E1hA==
X-Gm-Message-State: ANhLgQ2db5ey4dRej5E8Sey5eCq4sowiUq5e+exl3jJYDlOYUUnU19I3
        Rt36vwFJ4AhvOwWDcNS8iJ7ZLv7MH0A=
X-Google-Smtp-Source: ADFU+vt/AaEOFL5fZe+X/ty23WjTiYTGHdmLhkv0hNuBk8EHyynzPFRjUWzteJ9xT1xDRbMjGxV9HA==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr5165851wmc.15.1584448992252;
        Tue, 17 Mar 2020 05:43:12 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id k133sm3994585wma.11.2020.03.17.05.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 05:43:11 -0700 (PDT)
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
 <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <18a2cb7a-0e4c-e2f2-e3ca-99a8ae85469d@linaro.org>
Date:   Tue, 17 Mar 2020 12:43:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2020 12:22, Pierre-Louis Bossart wrote:
> Hi Srinivas,
> 
>> This patch did not work for me as it is as wsa881x codec does prepare 
>> and enable in one function, which breaks some of the assumptions in 
>> this patch.
> 
> Ah yes, if two transitions happen in the same DAI callback that wouldn't 
> work indeed. We should probably add this restriction to the state 
> machine documentation, the suggested mapping from ASoC DAI states to 
> stream states did not account for compound cases.
> 
>> However with below change I could get it working without moving stream 
>> handling to machine driver.
> 
> The change below would be an error case for Intel, so it's probably 
> better if we go with your suggestion. You have a very specific state 
> handling due to your power amps and it's probably better to keep it 
> platform-specific.
> 
> Can you confirm though that this patch works fine if you move all the 
> stream transitions to the machine driver? That should be a no-op but 
> better make sure there's no misunderstanding.

yes, it works with this patch + moving wsa stream handing to machine driver.

--srini
> 
> Thanks
> -Pierre
