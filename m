Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF09C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA64320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxESRVCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgHMOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:10:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27331 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726142AbgHMOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597327829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUbuth9YsAKh0CAOKDQ5MQczPX5161xmlduVV3vT8TM=;
        b=SxESRVCU3YHs3aVZ1Iu32VmWG4k+OAXQRUwmop3bZEd9nniv5W0UAAuF7z6konKdheJzI/
        FB14lwiCfz5ibr1BKpzAsQPU8OfmEgjJkvF+gfJo8pPdv3OoPuAKX68Y20cjRCSWfwKhiy
        9dvQwpSpo5fEJv4XpY43iSJMbnHbdkA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-EeizELszNKiuq4rU9BHj5w-1; Thu, 13 Aug 2020 10:10:28 -0400
X-MC-Unique: EeizELszNKiuq4rU9BHj5w-1
Received: by mail-wr1-f72.google.com with SMTP id w7so2124564wre.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:10:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rUbuth9YsAKh0CAOKDQ5MQczPX5161xmlduVV3vT8TM=;
        b=n7D9s8lBoCf4bmAcOTG9CJ/i4nOheHmyGLmMRxoPuu3p9yuI2PjM59ZcGbUNpjF7Ax
         VHp1m9d4r5R54jFQunb/G37kXbpgqyErvptp7OU0V0dfXCR6B1/RD2Jz3SNAx+ryUQVM
         F2sYBDy8HDy7Cc8fnadpiyCiE46eILKapcYMFybtp2i4u7zNI8OIdWYSLZdv01Yqvlq5
         GQBoKqxSd28YQOeMfDiBCkyYKn+N2zMp42ncuaqvRIKxWwyS2TqOx/lBHa6G/o01H6gL
         3/4f/NSWPR4q5scn5BFEF8pi/t61AKQ2AhrtRp3UKjKXpwyHkmpidl5tCUcCP6PhpYAn
         EVWA==
X-Gm-Message-State: AOAM532w4eG4WCKLvlkK4w1wVY5mHfDBl3iOqD6H4do+RzZl68uonisy
        h22PKL0cNTf5XaRgc1g2OuW12ECYAJJqAukz6fD4OKvB3FnV8to+Dyl93LB8HkyHAJq8XBEFZiG
        LisDWzkaLZY8pS6+V06ipd3os
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr4485462wma.176.1597327827023;
        Thu, 13 Aug 2020 07:10:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfcHDY8aqtPDjUrHw9QpQSceS/wlBCck79TPwzjfMd/JIYRTJ5uKRTxFiNJ91HMcVXAf4w7w==
X-Received: by 2002:a1c:3c87:: with SMTP id j129mr4485434wma.176.1597327826767;
        Thu, 13 Aug 2020 07:10:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51ad:9349:1ff0:923e? ([2001:b07:6468:f312:51ad:9349:1ff0:923e])
        by smtp.gmail.com with ESMTPSA id 32sm11176734wrh.18.2020.08.13.07.10.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 07:10:26 -0700 (PDT)
Subject: Re: [RFC PATCH 6/7] core/metricfs: expose x86-specific irq
 information through metricfs
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Adams <jwadams@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>
References: <20200807212916.2883031-1-jwadams@google.com>
 <20200807212916.2883031-7-jwadams@google.com>
 <87mu2yluso.fsf@nanos.tec.linutronix.de>
 <2500b04e-a890-2621-2f19-be08dfe2e862@redhat.com>
 <87a6yylp4x.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ffeac3eb-fbd5-a605-c6a5-0456813bd918@redhat.com>
Date:   Thu, 13 Aug 2020 16:10:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87a6yylp4x.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/20 14:13, Thomas Gleixner wrote:
>>>> Add metricfs support for displaying percpu irq counters for x86.
>>>> The top directory is /sys/kernel/debug/metricfs/irq_x86.
>>>> Then there is a subdirectory for each x86-specific irq counter.
>>>> For example:
>>>>
>>>>    cat /sys/kernel/debug/metricfs/irq_x86/TLB/values
>>> What is 'TLB'? I'm not aware of any vector which is named TLB.
>> There's a "TLB" entry in /proc/interrupts.
> It's TLB shootdowns and not TLB.

Yes but it's using the shortcut name on the left of the table.

> +METRICFS_ITEM(LOC, apic_timer_irqs, "Local timer interrupts");
> +METRICFS_ITEM(SPU, irq_spurious_count, "Spurious interrupts");
> +METRICFS_ITEM(PMI, apic_perf_irqs, "Performance monitoring interrupts");
> +METRICFS_ITEM(IWI, apic_irq_work_irqs, "IRQ work interrupts");
> +METRICFS_ITEM(RTR, icr_read_retry_count, "APIC ICR read retries");
> +#endif
> +METRICFS_ITEM(PLT, x86_platform_ipis, "Platform interrupts");
> +#ifdef CONFIG_SMP
> +METRICFS_ITEM(RES, irq_resched_count, "Rescheduling interrupts");
> +METRICFS_ITEM(CAL, irq_call_count, "Function call interrupts");
> +METRICFS_ITEM(TLB, irq_tlb_count, "TLB shootdowns");

Paolo

