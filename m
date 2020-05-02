Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC895C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 17:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FA992071E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 17:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTEahbx6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEBRUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 13:20:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42294 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728382AbgEBRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 13:20:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588440007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GUmho2FLAfT35PNKqGTCcuOkwHoviG0UIXTuAz4erg=;
        b=iTEahbx6dISbiWaj2P0SrIne2OQ9YYu3L8VUfcPHMXl7ZgbrAwBQ5xvb0sOAkDjfgEDIHB
        mNwvzK31oXkzXwTbsy6SAzdDb2C6S4zRReWKY0YuXPDigR5Auk53l7r/X3dq8w1GucrWeS
        as1LuKv7VNH5XK3eZIVleJUXTlQbcYc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-3lkw48_uN0yaMh3w4L_gFg-1; Sat, 02 May 2020 13:20:05 -0400
X-MC-Unique: 3lkw48_uN0yaMh3w4L_gFg-1
Received: by mail-wr1-f69.google.com with SMTP id z8so481897wrp.7
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 10:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3GUmho2FLAfT35PNKqGTCcuOkwHoviG0UIXTuAz4erg=;
        b=Dtz5dojg//8WB5QwQ8IU9u3KwgO4lm9j+0apDBCfG1CJJyHPvL+NLN87t5fUvaX5c3
         dUHP9XTFpNi/YcSk4p+wNbadDL7Y0AFP4+JMDMIjRMSycYbRF0MreCw9nwtwj1UmZzFh
         rRkMJjWP8ER3EqqG5YFfLcStfxEsjn/3FKSbPVxHqdKrzRlFG+53N8DfBLTnAV45yopz
         52SdCw/uocNvejp8MVBNoqK7OpwrpQb7Z3EPVKCQDhcDtRfGtxasAHFy2a1c9KOJ/9V/
         gealOIX8BLK3gACiqA1uQflN91mtFBBLcYQAwD8Y0GN7uxUMI60AN9CkgXaKv0AHvJD4
         MlsA==
X-Gm-Message-State: AGi0Pubgy8vyCqhWUzpEa2Pv1/Co6Am8ROLQ1yejfpgoZyAgYMQFKlyk
        jSpw59XsNO3jm3jSm7pnfdO81sFuOc8mxrb+kPUrqtbD9sA66h4gsU7p72ABVGgXppT7KWZ+wmp
        +rcygkSMnmTe4vB+Aa6Q1stVh
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr10914203wrc.220.1588440004541;
        Sat, 02 May 2020 10:20:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypLXdh6qRxuqM+s3YHGH4ZaOfI88KaDgWOXNbSMrqa9XZHlL/hEs5lFobtCoBHp3oWB+dcAF8Q==
X-Received: by 2002:adf:ab1b:: with SMTP id q27mr10912510wrc.220.1588439974357;
        Sat, 02 May 2020 10:19:34 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id c83sm5680943wmd.23.2020.05.02.10.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 May 2020 10:19:33 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: ioapic: Introduce arch-specific check for lazy
 update EOI mechanism
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rkrcmar@redhat.com, joro@8bytes.org, jon.grimm@amd.com,
        borisvk@bstnet.org
References: <1588411495-202521-1-git-send-email-suravee.suthikulpanit@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e09f0be9-6a2f-a8ee-3a96-c8ffdf3add3f@redhat.com>
Date:   Sat, 2 May 2020 19:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1588411495-202521-1-git-send-email-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/20 11:24, Suravee Suthikulpanit wrote:
> This is due to re-entrancy of the lazy update EOI logic
> when enable APICv with VFIO pass-through device, which
> sets up kvm_irqfd() w/ KVM_IRQFD_FLAG_RESAMPLE.
> 
> Fixes by adding re-entrancy check logic.

This does not explain why this is the right fix.

The questions to answer are: what is causing the re-entrancy? and why 
is dropping the second EOI update safe?

The answer to the latter could well be "because we've already processed
it", but the answer to the former is more important.

The re-entrancy happens because the irq state is the OR of
the interrupt state and the resamplefd state.  That is, we don't
want to show the state as 0 until we've had a chance to set the
resamplefd.  But if the interrupt has _not_ gone low then we get an
infinite loop.

So the actual root cause is that this is a level-triggered interrupt,
otherwise irqfd_inject would immediately set the KVM_USERSPACE_IRQ_SOURCE_ID
high and then low and you wouldn't have the infinite loop.  But in the
case of level-triggered interrupts the VMEXIT already happens because
TMR is set; only edge-triggered interrupts need the lazy invocation
of the ack notifier.  So this should be the fix:

diff --git a/arch/x86/kvm/ioapic.c b/arch/x86/kvm/ioapic.c
index 7668fed1ce65..ca2d73cd00a3 100644
--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -225,12 +225,12 @@ static int ioapic_set_irq(struct kvm_ioapic *ioapic, unsigned int irq,
 	}
 
 	/*
-	 * AMD SVM AVIC accelerate EOI write and do not trap,
-	 * in-kernel IOAPIC will not be able to receive the EOI.
+	 * AMD SVM AVIC accelerate EOI write iff the interrupt is level
+	 * triggered, in-kernel IOAPIC will not be able to receive the EOI.
 	 * In this case, we do lazy update of the pending EOI when
 	 * trying to set IOAPIC irq.
 	 */
-	if (kvm_apicv_activated(ioapic->kvm))
+	if (edge && kvm_apicv_activated(ioapic->kvm))
 		ioapic_lazy_update_eoi(ioapic, irq);
 
 	/*

Did I miss anything in the above analysis with respect to AVIC?

Paolo

