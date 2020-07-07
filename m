Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B6CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07FB92065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NLyyVFbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGGSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbgGGSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:12:07 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD7C08C5E1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 11:12:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q15so72836wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 11:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dkBGZFFrCFaqqtw2dRtcsDkg6EDJqwN1Ag4JpnmvXE0=;
        b=NLyyVFbfJQcGzxnQAhzuP9IWH4cBGwOkHvRTVHy7EmlYu877w37ArkMeHogVl2ySlm
         YeADM9JYuwx9Ps6Aa9mRTMui4YBBm5XJXfOpsS+OWtvDusfwButaxMJ8F+pMTB58fTdw
         cP16lfPTR7nSBCfpR5nmCeHVQseIlH5qg8gTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dkBGZFFrCFaqqtw2dRtcsDkg6EDJqwN1Ag4JpnmvXE0=;
        b=N+lQFOxVt4+Qxp0UC4LDNUgEqmmCuwYrSIt9bUKuHxP+Px8YK0Pg8QyECQ0jQ+c4OE
         TYY8nZyATAnBbpX+jD2uSfV71I1erUFztYUJW7EnelWOD84Hsy9IxoFhT3fOVIsnc83L
         q2TiSL0xJwI0+Z8Mxxwj2sSmjTdNeFizeSNTtE2XBd/aUDWm6H+tUYYSe+/ek5jtsOVr
         IDgsjNnYMD8hXidKsXYlK2uNfDei759HvYdKpOMzXMn0sXw39bQBI4Pq4EfWZtZ1C4w4
         SSHmlxHqzBvn+SqWIRfn85D1znAmbAvxIG6BF/LrSxOWj+vGVikrGma2YBvUwlO3EFXT
         XEuQ==
X-Gm-Message-State: AOAM5318V9i9Xz0NsBYtMTcJ5FSfnq9GoVWuo+mSWW1uonhgp+ZrzFbJ
        H9pCGeLAjZFhr5whPmRarPIPtw==
X-Google-Smtp-Source: ABdhPJx80fTYHbVtP4tLN7pHRKrDlRSW1jaNL//yM4e+PTmPZAQS/FYK//pDzT11nfP43EpwYlgB+g==
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr5505804wmj.86.1594145525392;
        Tue, 07 Jul 2020 11:12:05 -0700 (PDT)
Received: from [192.168.1.237] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
        by smtp.gmail.com with ESMTPSA id k11sm2247410wrd.23.2020.07.07.11.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 11:12:04 -0700 (PDT)
Subject: Re: linux-next: Tree for Jul 7 (scsi/lpfc/lpfc_init.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        dick kennedy <dick.kennedy@broadcom.com>
References: <20200707180800.549b561b@canb.auug.org.au>
 <2f85f3c4-a58b-f225-a533-86e209a4651c@infradead.org>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <7ae1c7e3-ce8d-836b-1ae7-d4d00bd8f95c@broadcom.com>
Date:   Tue, 7 Jul 2020 11:12:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2f85f3c4-a58b-f225-a533-86e209a4651c@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/2020 10:09 AM, Randy Dunlap wrote:
> On 7/7/20 1:08 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20200706:
>>
> on i386:
>
> when CONFIG_ACPI is not set/enabled:
>
>
> ../drivers/scsi/lpfc/lpfc_init.c:1265:15: error: implicit declaration of function 'get_cpu_idle_time'; did you mean 'get_cpu_device'? [-Werror=implicit-function-declaration]
>
>
> The cpufreq people want justification for using
> get_cpu_idle_time().  Please see
> https://lore.kernel.org/linux-scsi/20200707030943.xkocccy6qy2c3hrx@vireshk-i7/
>
>
>

The driver is using cpu utilization in order to choose between softirq 
or work queues in handling an interrupt. Less-utilized, softirq is used. 
higher utilized, work queue is used.  The utilization is checked 
periodically via a heartbeat.

-- james

