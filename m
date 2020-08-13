Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE01EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AFDA208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZXCH/R3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHML7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:59:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726570AbgHML4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597319770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EZlOhHYV75r7YTUyN5H+sCzjVVAp8wKOhPwk4M3cflE=;
        b=ZXCH/R3Ni1eLV7dh7vzaWHGjOMKRNhwACQOoiCd+i4FjZMhLKHszWpT8E7sFKDVPYEsv8C
        7lUYNG4QKGJEMw+l7tvXQjKg+8/uPz14dolDTHVM4GZGsp8oLzhibKnc6qcxqLWV1xQvyM
        zGbaLkQ9WbbMgyxovQLlZ563/Fj9GCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-AXUPFhH2Mhm-ywsOoBUpHA-1; Thu, 13 Aug 2020 07:48:01 -0400
X-MC-Unique: AXUPFhH2Mhm-ywsOoBUpHA-1
Received: by mail-wr1-f70.google.com with SMTP id z12so1988082wrl.16
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 04:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EZlOhHYV75r7YTUyN5H+sCzjVVAp8wKOhPwk4M3cflE=;
        b=LbJXqbtSbRQQn5xknidJfBOZv0PXK27+3/H4bL7vZVt0p8w/jRblYKB/ZhdT+fMBz2
         3CMhQQ0rrblgHoeQ2pe8bUb+Mijr8zNs8puJx3sRIWXxUaB33g40/q2pujDCoNyMXc9M
         cTuqN1pc4plLr8VPIjaMiD44VT5T8wjY4HB8jRrPtrrbokqEHeOsaUpLLAtsTL9Ug2k5
         h1cAJnblXEgSZOU9n4KgYZIV2h508yDcHCmzGCRC9liuwhDTVRm0BPA6BEZ4LqUomzua
         j6Bt9vieqxPK4Wei3niHb4seNB3BtiYgzFY4Z5Dyna2rPx05rKtScQYoYaMD0GKGdqZc
         2+Vg==
X-Gm-Message-State: AOAM533/ARZZ+xe5gaqyPHfP0b2MnwO8rGAL7g36E67V6a75kFbXcCDV
        azPrGggwuACBj/1UmkrfbyIZGFkhRb0xVxItVBNa6ec5zq2w5Sty/xB7OB7HTHSTIFm65cPgtqG
        wNjgsxMPZp1zzOPq+TXw6KE3z
X-Received: by 2002:adf:f511:: with SMTP id q17mr3637048wro.414.1597319280147;
        Thu, 13 Aug 2020 04:48:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8RW5csMCCrSiBHobEDZMj9QmiDMAx1geqH7u8cSNLCG6KlEWPnnMnrhh1csceZBt9Jv8I0Q==
X-Received: by 2002:adf:f511:: with SMTP id q17mr3637032wro.414.1597319279937;
        Thu, 13 Aug 2020 04:47:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:51ad:9349:1ff0:923e? ([2001:b07:6468:f312:51ad:9349:1ff0:923e])
        by smtp.gmail.com with ESMTPSA id b14sm10751480wrj.93.2020.08.13.04.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 04:47:59 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2500b04e-a890-2621-2f19-be08dfe2e862@redhat.com>
Date:   Thu, 13 Aug 2020 13:47:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87mu2yluso.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/20 12:11, Thomas Gleixner wrote:
>> Add metricfs support for displaying percpu irq counters for x86.
>> The top directory is /sys/kernel/debug/metricfs/irq_x86.
>> Then there is a subdirectory for each x86-specific irq counter.
>> For example:
>>
>>    cat /sys/kernel/debug/metricfs/irq_x86/TLB/values
> What is 'TLB'? I'm not aware of any vector which is named TLB.

There's a "TLB" entry in /proc/interrupts.

Paolo

