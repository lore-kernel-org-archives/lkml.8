Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8624C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B7720838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guww+fno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgCaLUg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:20:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44672 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730343AbgCaLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585653634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EgVXfSbdEiIceutRcqYMXl2BzCyVe5g+grLOfxv7pm8=;
        b=guww+fnopykCUybGsYsjj2jszVnfEiR32oECkTsWnfIaWykLSp8+TklH13Ww3mSJdb4/hv
        5hO45C6esJl+DKxljIXt6yWg/eU7UkVc1rgJlC5drkywPrVlwkGw2m2E9kSPMCEPOcp/bZ
        EKOvvZXRFw/tt+JNicNWwhghNEyiFE0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-zNgtW-5JPAWaBuvIcK8dmg-1; Tue, 31 Mar 2020 07:20:33 -0400
X-MC-Unique: zNgtW-5JPAWaBuvIcK8dmg-1
Received: by mail-wr1-f69.google.com with SMTP id q14so3232196wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 04:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EgVXfSbdEiIceutRcqYMXl2BzCyVe5g+grLOfxv7pm8=;
        b=A8yqCynPcNxFC51uHEMXaM3mMDvXj+8yfdn+4nAUhwQC9+4M54JNj4AkNPzTPCidOf
         ji3w0Bs1japtS9+ayOFV6GM2dj4i/8kXVMiQES3SkMuvhWa11LPZxJQjIpXLQAHfucJ9
         1R+xNmKWkY62JjS+1uipPTg4eoZoAKumqvmDxDxH6+blCSVr6TbauNecg/FrzPzBNcak
         RtHctaSoDKGpOiSnej4SOyNreGmpOE0E3L5VzGi5bHRbbss4r6vID+prH6rVynwgR1aI
         0E8H4wgGBHQ6XG0CwkmFXmfY2MdJiwLCJdSjxT/5BpFuGbApF8Cv2Vf2Wi4YE9m+WTNE
         6i5g==
X-Gm-Message-State: ANhLgQ3jxiRcDBgmuIkrHjeVgNXzWRi45u5XQOVoQiikRc5GGu1EZ9jm
        HVnjDgm14uqcZvljDNznF1Sw++NhcbEO39icD0c+ka4pGEqMRboQpk5QHJJ1x4LGdEcNbkuP0jd
        lgXVWtVSVhf7/iJVVh0IV2mYU
X-Received: by 2002:adf:f104:: with SMTP id r4mr19389699wro.375.1585653632023;
        Tue, 31 Mar 2020 04:20:32 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsj73M4ya+/mbx5V8pR8T+pH0jDHJTdrCEDydbcDb9MlQv9v+fm1NZ8qgyAARz58WsbCWvRiQ==
X-Received: by 2002:adf:f104:: with SMTP id r4mr19389663wro.375.1585653631773;
        Tue, 31 Mar 2020 04:20:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r9sm3477744wma.47.2020.03.31.04.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 04:20:31 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     ltykernel@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH V2] x86/Hyper-V: don't allocate clockevent device when synthetic timer is unavailable
In-Reply-To: <20200331021738.2572-1-Tianyu.Lan@microsoft.com>
References: <20200331021738.2572-1-Tianyu.Lan@microsoft.com>
Date:   Tue, 31 Mar 2020 13:20:29 +0200
Message-ID: <87sgho22ki.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltykernel@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Current code initializes clock event data structure for syn timer
> even when it's unavailable. Fix it.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> Change since v1:
> 	Update title and commit log. 
>
>  drivers/hv/hv.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 632d25674e7f..2e893768fc76 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -212,13 +212,16 @@ int hv_synic_alloc(void)
>  		tasklet_init(&hv_cpu->msg_dpc,
>  			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>  
> -		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
> -					  GFP_KERNEL);
> -		if (hv_cpu->clk_evt == NULL) {
> -			pr_err("Unable to allocate clock event device\n");
> -			goto err;
> +		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +			hv_cpu->clk_evt =
> +				kzalloc(sizeof(struct clock_event_device),
> +						  GFP_KERNEL);
> +			if (hv_cpu->clk_evt == NULL) {
> +				pr_err("Unable to allocate clock event device\n");
> +				goto err;
> +			}
> +			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>  		}
> -		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>  
>  		hv_cpu->synic_message_page =
>  			(void *)get_zeroed_page(GFP_ATOMIC);

Thank you for fixing the subject! I had one more question on the
previous version which still stands: which tree is this patch for?
Upstream, clockevent allocation has moved to
drivers/clocksource/hyperv_timer.c and the code there is different.

Is this intended for some stable tree?

-- 
Vitaly

