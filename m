Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5696C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40DD20678
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="KArapE08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHLEIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgHLEIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:08:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DC1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e4so481349pjd.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=//mkLAI7oVv7tPrVMf+q8zyv+BuUYqKH5dh+Sj+3EdQ=;
        b=KArapE08iPWlLOYUz2a0GNX7Ix7FzJv4LF6e5BhqlwnkTAOHeijkXm9JE9MkqtROia
         kkR7rHoqSxMX9dXKZDo5fkG/b4gytlCLRiIZRJdE/7EKm7E2jRklbIE4PMfjuyRX12wI
         EozimkgeeX5LuNNaSdkLQ1OZ1nxu1yUMP0UsH4FRGENPKQ4QBfLLMy1tVCJ/DaPRlS9m
         +Pb5GJjH0HO6joiolWK612WMIqhBkLjDfx6VMGLFJtxmD9cSnJiEcWDmOvJBISdS+Azl
         o7WMqYzzqDskQ/IQ1zU234P7lZveJlVl3fypg1aHcmXNYeGyWj7Vafsetu+dAvnhY9Ls
         vzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=//mkLAI7oVv7tPrVMf+q8zyv+BuUYqKH5dh+Sj+3EdQ=;
        b=ldb+SLjdSPULt2j2zlvQ1yI1EsxAu2t/sPDAMG6wtUjcLDTLWwnA/PfgebYCFxoOSM
         PGJ2LpyeSSGtkRvgSidy8xSlo8J9GWKRKuCSp9GU13nUKRJm5AcHkhPkfcV8r1vDsUdK
         e65SA8exPFatvoRrsZT6ilPgPtECP+bZ/dbATXPkGBwVrjF+T+m741j2TQ99f53xEz9M
         Tcx5vG9AU6/mp15izg8CX6mFuMdTE8z+7BAd2Zh5ra/kyLJYoCxhPJTrWvyf5TECv4fU
         6wFjVTeA3E4JaCZMomvii3rU6GZDZhC6PHib+2QbPv/oW5wA4Tap78g8xyGpF8SB/4vT
         ZCRw==
X-Gm-Message-State: AOAM533DKa0zzLV0XTYw3F3J3HBIu+NBqx600PXK1n7ayOpkpTppKZU1
        OboQPpmixRgEbIiMUfK9dnxsfA==
X-Google-Smtp-Source: ABdhPJx61Guq7ex+BBKhltb8y5VOD7ZmMFyE70VC5rtkvlzNYy6g5mXP9vY5H1z1vwQvMDcDPACnEA==
X-Received: by 2002:a17:902:c154:: with SMTP id 20mr3863312plj.64.1597205329263;
        Tue, 11 Aug 2020 21:08:49 -0700 (PDT)
Received: from [10.91.184.177] ([103.136.220.70])
        by smtp.gmail.com with ESMTPSA id z9sm609425pfn.59.2020.08.11.21.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 21:08:48 -0700 (PDT)
Subject: Re: [External] Re: [PATCH] x86/MCE/AMD, EDAC/mce_amd
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        liuxian.1@bytedance.com
References: <20200809043559.9740-1-zhoufeng.zf@bytedance.com>
 <20200810190958.GA3406209@yaz-nikka.amd.com>
From:   zhoufeng <zhoufeng.zf@bytedance.com>
Message-ID: <191bc22e-c1d3-16c3-8ec0-96f3db7c8e24@bytedance.com>
Date:   Wed, 12 Aug 2020 12:08:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200810190958.GA3406209@yaz-nikka.amd.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, as more AMD servers are used in bytedance, we hope to issue a patch 
to the community as soon as possible. Thank you very much.

ÔÚ 2020/8/11 ÉÏÎç3:10, Yazen Ghannam Ð´µÀ:
> On Sun, Aug 09, 2020 at 12:35:59PM +0800, Feng zhou wrote:
>> From: zhoufeng <zhoufeng.zf@bytedance.com>
>>
>> The edac_mce_amd module calls decode_dram_ecc() on AMD Family17h and
>> later systems. This function is used in amd64_edac_mod to do
>> system-specific decoding for DRAM ECC errors. The function takes a
>> "NodeId" as a parameter.
>>
>> In AMD documentation, NodeId is used to identify a physical die in a
>> system. This can be used to identify a node in the AMD_NB code and also
>> it is used with umc_normaddr_to_sysaddr().
>>
>> However, the input used for decode_dram_ecc() is currently the NUMA node
>> of a logical CPU. so this will cause the address translation function to
>> fail or report incorrect results.
>>
>> Signed-off-by: zhoufeng <zhoufeng.zf@bytedance.com>
>> ---
>>   drivers/edac/mce_amd.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
>> index 325aedf46ff2..73c805113322 100644
>> --- a/drivers/edac/mce_amd.c
>> +++ b/drivers/edac/mce_amd.c
>> @@ -996,7 +996,7 @@ static void decode_smca_error(struct mce *m)
>>   	}
>>   
>>   	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
>> -		decode_dram_ecc(cpu_to_node(m->extcpu), m);
>> +		decode_dram_ecc(topology_physical_package_id(m->extcpu), m);
> This will break on Naples systems, because the NodeId and the physical
> package ID will not match.
>
> I can send a patch soon that will work for Naples, Rome, and later
> systems.
>
> Thanks,
> Yazen
