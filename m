Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B87C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51F20752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPKL1gYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgCQPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:07:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbgCQPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:07:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id v11so26183350wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/cKdMrh8CF0c9lFRCImzxWLQxTgyiXXMxt/wni+pXA=;
        b=JPKL1gYjTfAuY7MB5hUGe4i3gimVdV2GkaTjXnrkkF1es/88j/ZXniHeAzW+0Y5eaI
         4tK6RL9Yj7UMUJYzwB7NmavhmvMMtCPxtDiCLyjjWbLZ8QCVVpUsUkXf899tAqWkNEFB
         IDaH1MbS2/8dk3R78Rbngvpm64ii5mJVsIdJmwksWlu2rZ+RmTXlJEnn4COiAramqJhR
         o+EoK++lVYQsjeoz7aNjcCNgs+p1i9lXHUNF6+xzz0oo5H4vMDIXwP2qBSjeVDTiY20J
         rkcoGW1tSK6J4pDS5hZMMxQK5G8HKIkB2SaWtihSgAbhZF0G4ooE8brh5rEj/fNshZ93
         Rtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/cKdMrh8CF0c9lFRCImzxWLQxTgyiXXMxt/wni+pXA=;
        b=EFw8G6b8KdBLgfaJEa4KosFsWFv+LHPkc3yELsJ65ISZM++6fV3/tKvaGoPBrpoelT
         uxT4SZUH1gz9eOMI+anqZGiLodhwqeKKC8bjhXXDfrJAO67/epZ4MSMdyoa1OgXV0Xvd
         TuP6duExaac5lSAeH0ywzOLc6eh5uZjpnGq+IfCFZth5E8F/rydUo/KxsfbPamsbYqay
         GxUeUTJIMiyhsi1jkIEPmEhNAFKx1xA+jU/xmz/URQrByu0fSFwEc6oOH3i9eMYrUxQz
         aYKxVdvvhnyuwUmoVs0z2xWnp9oe7/WRRDcdD3kcaaJlDsGJNrQ7i3EWlH49QfHnKnxD
         b5EQ==
X-Gm-Message-State: ANhLgQ2tpwJfIB1wHVE/kjeJf4/v/BXvChM6uq7dISzGNI+qdUu1Q6lU
        4BAUiJeMvoaHSCcy3+nMJgQ33g==
X-Google-Smtp-Source: ADFU+vuFeaz2+vfk1K1dxjErqoYuK1xEoaXyKVMQcHXo6oKqvAUbO1wR9RDBY+Sd6RT8WD4MgUGVYA==
X-Received: by 2002:adf:ef0b:: with SMTP id e11mr6855972wro.115.1584457667404;
        Tue, 17 Mar 2020 08:07:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n1sm4983796wrj.77.2020.03.17.08.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 08:07:46 -0700 (PDT)
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
 <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
 <6dde3b32-a29a-3ac9-d95d-283f5b05e64a@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7c7b334d-ae5c-35f6-9cf3-04700677211f@linaro.org>
Date:   Tue, 17 Mar 2020 15:07:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6dde3b32-a29a-3ac9-d95d-283f5b05e64a@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17/03/2020 13:19, Pierre-Louis Bossart wrote:
> 
> 
> On 3/17/20 8:04 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 17/03/2020 12:22, Pierre-Louis Bossart wrote:
>>>
>>> The change below would be an error case for Intel, so it's probably 
>>> better if we go with your suggestion. You have a very specific state 
>>> handling due to your power amps and it's probably better to keep it 
>>> platform-specific.
>>
>> Just trying to understand, why would it be error for Intel case?
>>
>> IMO, If stream state is SDW_STREAM_ENABLED that also implicit that its 
>> prepared too. Similar thing with SDW_STREAM_DEPREPARED.
>> Isn't it?
> 
> the stream state is a scalar value, not a mask. The state machine only 
> allows transition from CONFIGURED TO PREPARED or from DEPREPARED TO 
> PREPARED, or DISABLED to PREPARED.
> There is no allowed transition from ENABLED TO PREPARED, you have to go 
> through the DISABLED state and make sure a bank switch occurred, and 
> re-do a bank switch to prepare again.
I agree with you if are on single dai case. Am happy to move to stream 
handling to machine driver for now.

But this also means that in cases like multi-codec its not recommended 
to call sdw_prepare and sdw_enable in a single function from codec.
Which might be worth documenting.

--srini
