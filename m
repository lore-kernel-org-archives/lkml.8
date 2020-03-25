Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDCC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4BA208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwAtTY5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgCYO2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 10:28:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:20735 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727566AbgCYO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585146530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JqpwltFL/SwS1UhlcIi0MOoODF8Cpbq1cMt7ik4CiTE=;
        b=DwAtTY5FeL0l8g+pWuXvopKrrWYucGwQwduc1nrTtQ7hq6MspeALe2jGt6nVSw8qaYyb9K
        ynUd0CYmDS2h3vCjpFRhJeOex/BfNvmOWD6bkl/6GbbKsREAF1yXrgHu0AK2BRWP1/GPvY
        QPCJc3XcoxB2PUzEq+tApe7GKI40wDE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-uVxAjFQpP_WWUCQ3W7g2FQ-1; Wed, 25 Mar 2020 10:28:49 -0400
X-MC-Unique: uVxAjFQpP_WWUCQ3W7g2FQ-1
Received: by mail-wm1-f70.google.com with SMTP id n25so746929wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 07:28:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JqpwltFL/SwS1UhlcIi0MOoODF8Cpbq1cMt7ik4CiTE=;
        b=fFkhm0ocB0Yb0aaQwz5OHaORb52pyWMT4U1xP7eWBjknaKAyua7Zs1VqZDpxk6g1x7
         4ShUNuxLvN+Fvj70kLtNdQPmLpIlTm9dUGi3QNYXLYz6nI6SvshcJTC0eebFhzctMhCR
         RUXZLeKgPcFdHSvFAiIo90qVZGKGZ4gPoq4DELolMjOL7lgRGAHBEznxj8X3/ZhryIlD
         3FwUB7ATWLqfuncngsQp3yKBpFziOPOMW7Q/whhh7wRrQcY4VER36JUNqlXuD/RWLi5Z
         9ZXdjrTWK01ex6ZRtKIPAcDSGQ+nKdVvaqb+vmp7dIv0Se4T03h+BMC/qPd1x6hMAODe
         Zu0Q==
X-Gm-Message-State: ANhLgQ1wokMX+VS9Y7GPufOV5ucI/DdX8HhwjcNxE3l7cUU2T8e5frOm
        R94IkpbM+vWpxj5YA2LqzhwQxYz6oIoB65ueSE4lnSmGLA+UFkeAyYOM745sPspD8C8Ci8QGL4b
        5KcgBzZCpMf5aIsy7wu9ixBpY
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4024611wmc.68.1585146527995;
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtps1lqlEjeVqhmoxqx06a7QnIYlVTNWJazZkk/ssQW3dTzHNkG7M+s2wksPvvsb7XCMHkt2A==
X-Received: by 2002:a7b:c050:: with SMTP id u16mr4024590wmc.68.1585146527811;
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v7sm9590018wml.18.2020.03.25.07.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 07:28:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Tianyu Lan <ltykernel@gmail.com>
Cc:     Yubo Xie <yuboxie@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix hv sched clock function return wrong time unit
In-Reply-To: <039e126f-f00d-d7e1-aa92-c049c9e3333b@gmail.com>
References: <20200324151935.15814-1-yuboxie@microsoft.com> <87ftdx7nxv.fsf@vitty.brq.redhat.com> <039e126f-f00d-d7e1-aa92-c049c9e3333b@gmail.com>
Date:   Wed, 25 Mar 2020 15:28:45 +0100
Message-ID: <87lfno5x0i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tianyu Lan <ltykernel@gmail.com> writes:

>>> @@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>>>   
>>>   static u64 read_hv_sched_clock_msr(void)
>>>   {
>>> -	return read_hv_clock_msr() - hv_sched_clock_offset;
>>> +	return (read_hv_clock_msr() - hv_sched_clock_offset)
>>> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>>>   }
>> 
>> kvmclock seems to have the same (pre-patch) code ...
>
>
> kvm sched clock gets time from pvclock_clocksource_read() and
> the time unit is nanosecond. So there is such issue in KVM code.
>

Ah, true, kvmclock is always 1Ghz so it's reading 'naturally' converts
to ns.

-- 
Vitaly

