Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B888CC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3C32087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EMGUhIk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBDRqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:46:51 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42184 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727355AbgBDRqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:46:51 -0500
Received: by mail-wr1-f46.google.com with SMTP id k11so24161360wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PViOF49b8qn6ahEHi/SP9r5V6sh5UEmUDNaREM4YCcQ=;
        b=EMGUhIk+XjYOFFJ3c9Yw3ZqrdR9DZ0pwnH3NWzXLRrAB1X9+yUtTC0xYli0RVOF9gH
         fJJymtOT/mru9YC5at4CF4sfyHeKhH/YwKp3e5LIAxYoyBDzgr07fDgtxFFNlsOtGo8i
         gDTm+xUVbltGFTGL/Fsr1govVdyfisDPy4OX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PViOF49b8qn6ahEHi/SP9r5V6sh5UEmUDNaREM4YCcQ=;
        b=JIQOkAYDfg+2jFWwJoYfpa+36UDnmJnV8GUWIfp3NalbHVkMvdwjGSRsR9P5AULe5j
         rM7FwCbwM4EKuMACI39IPz55RqQieKR8QkTu2IkdYSYmklridVOVWAnOAXfMf2WRaLKG
         LaREbyv1iZKsny6tt+Ba5hWVKfpB7SacjhKB0yEE4kqrQcdS/38ZxQ4JuDX4LWe4cU4+
         eP/vvi/xw18R6Tgx/mhdT8j2O97KHexrKwMn7FgTC8S3vMyr+v0SSTenDoN7q0QMpxi8
         QFkmi0fiERGe7OjYhB+pH4fKE9A9r8NWPU0Qth8/9PI012wWoqyRh0fKei8AzKGEpbUt
         1x9g==
X-Gm-Message-State: APjAAAUQGqjyLCwXA4BpvOu/C9Nkcn6kg7lqiq1le7xn6ntWZ224eU/z
        BQ04nyZCD+ifMN7jSCfJ40H+mjnSwkgrQA==
X-Google-Smtp-Source: APXvYqz/5K1UcEofQ7ReFArUC3/pSsCxsk1ESNnijG4XViMGDX+qWejI4E6tiwr2otz0ieBIzUMe4g==
X-Received: by 2002:a5d:65cf:: with SMTP id e15mr22722363wrw.126.1580838409275;
        Tue, 04 Feb 2020 09:46:49 -0800 (PST)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id z8sm30866368wrq.22.2020.02.04.09.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 09:46:48 -0800 (PST)
Subject: Re: RFC: Use of devlink/health report for non-Ethernet devices
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
References: <f8e67e40-71d4-f03c-6bc0-6496663af895@broadcom.com>
 <20200204064854.GK2260@nanopsycho>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <e16de31a-791b-ed27-43a1-5d0e214b0631@broadcom.com>
Date:   Tue, 4 Feb 2020 09:46:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200204064854.GK2260@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 2020-02-03 10:48 p.m., Jiri Pirko wrote:
> Tue, Feb 04, 2020 at 12:01:37AM CET, ray.jui@broadcom.com wrote:
>> Hi Jiri/Eran/David,
>>
>> I've been investigating the health report feature of devlink, and have a
>> couple related questions as follows:
>>
>> 1. Based on my investigation, it seems that devlink health report mechanism
>> provides the hook for a device driver to report errors, dump debug
>> information, trigger object dump, initiate self-recovery, and etc. The
>> current users of health report are all Ethernet based drivers. However, it
>> does not seem the health report framework prohibits the use from any
>> non-Ethernet based device drivers. Is my understanding correct?
> 
> The whole devlink framework is designed to be independent on
> ethernet/networking.
> 
> 

Great. This is what I thought it is. Thanks for confirming.

>>
>> 2. Following my first question, in this case, do you think it makes any sense
>> to use devlink health report as a generic error reporting and recovery
>> mechanism, for other devices, e.g., NVMe and Virt I/O?
> 
> Sure.
> 
> 

Thanks.

>>
>> 3. In the Ethernet device driver based use case, if one has a "smart NIC"
>> type of platform, i.e., running Linux on the embedded processor of the NIC,
>> it seems to make a lot of sense to also use devlink health report to deal
>> with other non-Ethernet specific errors, originated from the embedded Linux
>> (or any other OSes). The front-end driver that registers various health
>> reporters will still be an Ethernet based device driver, running on the host
>> server system. Does this make sense to you?
> 
> Should not be ethetnet based driver. You should create the devlink
> instance in a driver for the particular device you want to report
> the health for.
> 
> 

Okay thanks!

>>
>> Thanks in advance for your feedback!
>>
>> Thanks,
>>
>> Ray
>>
>>
