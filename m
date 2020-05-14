Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FB6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCF62065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzRXsrDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgENIKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:10:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725886AbgENIKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589443834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QauBrq1Oc2T93JfbGvTvQs0eWJrFDhKFCSa33hfTtB8=;
        b=SzRXsrDhGjwV4XTQNlxA/roBy9002Vl9mUCGmL4mKQgKUFkvJOE/CcT9XYISmTaG7DlIqK
        CHmGb62mxi/leRe0dGul2EgyXKFjrYZi9pN2Vn0TBT0X+QYHRYQUNSthYdvPGNVru6hNJg
        nkb1RQaSJcR8EzWalG5GZ5GeJwNJXU4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-z9G0ftqCPKGHBoJSNFzTMQ-1; Thu, 14 May 2020 04:10:31 -0400
X-MC-Unique: z9G0ftqCPKGHBoJSNFzTMQ-1
Received: by mail-wr1-f72.google.com with SMTP id u5so1144810wrt.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QauBrq1Oc2T93JfbGvTvQs0eWJrFDhKFCSa33hfTtB8=;
        b=ZCYF+FrYl3vDgAYUfclHipsz7vn2h6ZBisMOtBzlGJQxZZHskVayd+u871hbUSOXTP
         GycLU2fGRgwXcL5Sh9jweDmR01J8E5w+EXrCKNPIskSYYjfUeV3I5LIQ3oVm62xFUk9x
         kyIzeRDTF/M5VZFKbXAY+PRyjCCxdsvkzB5/2WYEnq4k4Vxv/dbbOT96ZnxNz2dx/d73
         Xu1UQc0Ah9xfm0nNZ42bKH7AWJQmkM6biXJASSBD1+5efyU78bimb/p8n78rT+kRoTo7
         qyzuNsf0pOxjVCuXIiiJ/QDSXHEPnolR50d50zYO9hh2Nf3hoVmRrIaNIim4XL3+9PkK
         I9eg==
X-Gm-Message-State: AGi0Pua9rhBEbRikG54+su91Qv2diduQdQ2CaMDjOwrdsazZUcmis1hu
        9VZqfLgTtZ4rfzwrSR/GESNf7LSgW5UFVpVzXgHQ7Vl/8qe5gwbphNF1ff2A1Vyn13sNVw2tZCF
        9zlZXSCgX52O8xKo/FDwfkVVB
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr31881514wmc.10.1589443830807;
        Thu, 14 May 2020 01:10:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJwb1WVmE7Jc2Wey4S0cB1B25rXmq0PGyqTviLPNT4mX4xK+tt4EGXSfkCN81V7zVXLqXxdag==
X-Received: by 2002:a1c:7d92:: with SMTP id y140mr31881503wmc.10.1589443830591;
        Thu, 14 May 2020 01:10:30 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l13sm2818996wrm.55.2020.05.14.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:10:29 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>, x86@kernel.org
Subject: Re: [PATCH v2 0/3] x86/idt: Minor alloc_intr_gate() sanitization
In-Reply-To: <87imgz1wvz.fsf@nanos.tec.linutronix.de>
References: <20200428093824.1451532-1-vkuznets@redhat.com> <87imh0kn5t.fsf@vitty.brq.redhat.com> <87imgz1wvz.fsf@nanos.tec.linutronix.de>
Date:   Thu, 14 May 2020 10:10:28 +0200
Message-ID: <87wo5fdjij.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>>
>>> This series is a successor of "[PATCH] x86/idt: Keep spurious entries unset
>>> in system_vectors".
>>>
>>> The original issue I tried to address was that /proc/interrupts output
>>> was always containing all possible system vectors, including non allocated
>>> ones (e.g. 'Hypervisor callback interrupts' on bare metal). Thomas
>>> suggested to expand this cosmetic change to making alloc_intr_gate()
>>> __init.
>>>
>>> Vitaly Kuznetsov (3):
>>>   x86/xen: Split HVM vector callback setup and interrupt gate allocation
>>>   x86/idt: Annotate alloc_intr_gate() with __init
>>>   x86/idt: Keep spurious entries unset in system_vectors
>>>
>>
>> Ping?
>
> It's in my pile and I just did not come around to merge it.
>

No problem, just wanted to make sure it didn't slip through the
cracks. I see tip-bot already queued it, thanks!

-- 
Vitaly

