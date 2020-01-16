Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493D2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA3520748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0xyXB8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbgAPI1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:27:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727007AbgAPI1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:27:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579163262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6OKWorUpXtJWORIatOckAmUa1LJaKhueVthosat7x4=;
        b=A0xyXB8iVxpwkoYKnyo5aDV5h45P0CvX6ull1JarP2bB6bsEhuSLZfp6arExHJZYNjLCsB
        vhXlnEj2wujduNl/MQ4fQ19V6+tNpgVp/kZ8BtX6GQsw01GZoJiO6ihigw/7zk9U/xtPqz
        7Bh40KSEc2irinWyJe8H3j5qEzjzOzM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-C4zO1LDqNamtQJ5e1J4iSg-1; Thu, 16 Jan 2020 03:27:41 -0500
X-MC-Unique: C4zO1LDqNamtQJ5e1J4iSg-1
Received: by mail-wr1-f72.google.com with SMTP id r2so8991675wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=n6OKWorUpXtJWORIatOckAmUa1LJaKhueVthosat7x4=;
        b=NiryLITWeqfam1xJTVExRbfiFqkAehQLvckuKLK6v7BaFy/rdm3HurwtqOKLqZWqlo
         1gy8Fiw7d3qYiq523bOF2N9Tk4B75S8jyMkV2yBiY3DK/a874LVmp11EISKRc7R7twtZ
         HFRkiGAPhNzve4tu/ImvTtnrZBcHnieAGdGKV6KdmTRNVZ8nLq5/AKyjA0ZvTeC49DcQ
         0PHTE/USgs+fpnYAgEkIggH0enKHwlqIH8dv+XgcjJPqzfKWGEY6/dD+VVrWq9DY/Ep3
         9pZGoeXjbr6SBVldmdskP+k5Ws+XmeDtJrvtLmHKznpBQYWSKW0i7ustl6/ZomSaqfmn
         61NQ==
X-Gm-Message-State: APjAAAUafCnt2S+dZ+1JTmxpnLfsMLKZVb8ku77+HllmIZfnB5NAgrqN
        /nKyGOdLjtvsBqnV5RQNPoHSnQIniMNM0qjeqDginC/YMmgg228ubxx81I8MBUwhYv5DhBpWrxs
        iHoLLN5aDGgWKDHkaFus1Ztl1
X-Received: by 2002:a1c:f210:: with SMTP id s16mr4684975wmc.57.1579163260068;
        Thu, 16 Jan 2020 00:27:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVolGeukQa36Dfr81fPYllOJxeYL24l5Z41rqF1Lj8IsfizGSC2C91s7ayuKdoMSkQ+1ZraA==
X-Received: by 2002:a1c:f210:: with SMTP id s16mr4684950wmc.57.1579163259854;
        Thu, 16 Jan 2020 00:27:39 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p7sm1879703wmp.31.2020.01.16.00.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:27:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>, bp@alien8.de,
        "hpa\@zytor.com" <hpa@zytor.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] KVM: Adding 'else' to reduce checking.
In-Reply-To: <2a1a3b72-acc5-4977-5621-439aac53f243@gmail.com>
References: <2a1a3b72-acc5-4977-5621-439aac53f243@gmail.com>
Date:   Thu, 16 Jan 2020 09:27:37 +0100
Message-ID: <87d0bjiz5y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

>  From 4e19436679a97e3cee73b4ae613ff91580c721d2 Mon Sep 17 00:00:00 2001
> From: Haiwei Li <lihaiwei@tencent.com>
> Date: Thu, 16 Jan 2020 13:51:03 +0800
> Subject: [PATCH] Adding 'else' to reduce checking.
>
> These two conditions are in conflict, adding 'else' to reduce checking.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>   arch/x86/kvm/lapic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 679692b..ef5802f 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1573,7 +1573,7 @@ static void 
> kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
>          kvm_apic_local_deliver(apic, APIC_LVTT);
>          if (apic_lvtt_tscdeadline(apic))
>                  ktimer->tscdeadline = 0;
> -       if (apic_lvtt_oneshot(apic)) {
> +       else if (apic_lvtt_oneshot(apic)) {
>                  ktimer->tscdeadline = 0;
>                  ktimer->target_expiration = 0;
>          }

I bet the compiler will generate the exact same code
(apic_lvtt_tscdeadline() and apic_lvtt_oneshot() are inlines), however,
I think your patch is still worthy: 'else' makes it obvious it's either
one or another and not both.

One nitpick: coding style requires braces even for single statements in
case other branches require them so in your case it should now be:

if (apic_lvtt_tscdeadline(apic)) {
	ktimer->tscdeadline = 0;
} else if (apic_lvtt_oneshot(apic)) {
        ktimer->tscdeadline = 0;
        ktimer->target_expiration = 0;
}

With that,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

