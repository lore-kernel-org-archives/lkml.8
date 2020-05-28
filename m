Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EA6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DB7207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btSLREQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgE1LAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:00:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59019 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387995AbgE1LAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590663599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAtwMEwAU7e6Ig2GLlYlZ1/unoKvCe+FnGy9o9JuaP0=;
        b=btSLREQ8JDUxj4JS82IxMU0jEQYZF0I4GwVKegwzvog0dcyB0WthMoCIaWUUJJqmB7PKNW
        k2hT+i7NoXPye4gMfHXi9j/K4cO/K4WnGjEJG1ai0ohwv31q/Qr7gO50YmnjQZX6x/ROri
        uSOHO0bHWpsAMn1TbZhj5qWhENmlVZw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-MrNbi7qEOwmlK3iAgNZpBw-1; Thu, 28 May 2020 06:59:57 -0400
X-MC-Unique: MrNbi7qEOwmlK3iAgNZpBw-1
Received: by mail-ej1-f72.google.com with SMTP id gl5so10099057ejb.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAtwMEwAU7e6Ig2GLlYlZ1/unoKvCe+FnGy9o9JuaP0=;
        b=eas87g+zTL1wgRMkPbLDpsFp6rryODhpl74RX0c8Gsp8LfPnBi3a9NFiTViCgCAnQX
         nNGyNs/OF7a5a3I1rPEVxVJxthSQ2T+fM6U1rNiQcgphNmHFUf+JCb2a1XcushtdaFZK
         vYtQqUHKUFvHPylOXcolhJqIxTzcXVBq1FGa/fZaB+Hj54GYUSajZz7YAB2ixgu6X2/m
         LK/hjz1D7IGgLtRz3fJ9f8oqUx5UAxSAZdNkaJAENA0Fo9nLBMQDPhAOuNd6DPFCM1xK
         PAsTiAWjwaFQ1PRs5UejIeFNiVPY6/bUAcAZ1kti/F/4TRtG2XYDrBJ3ul6UK6h/b7g2
         AfNw==
X-Gm-Message-State: AOAM532NSrC6fCvDxi4laq66+2TzrVISRcfxN5caW4IW3AKct9eixG5o
        XbJ25/F7mso+PRcv3utl2RU7DKFJKtjC6IhSKS4ODc+4E86frBYr7ODi/Kmv9Hj9VX5zs0vKI2D
        imnp2SJ/KdmCzuxLoIoa+99EX
X-Received: by 2002:a50:f094:: with SMTP id v20mr2402347edl.77.1590663596054;
        Thu, 28 May 2020 03:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuw/10cekC7U8aATGy+RMKlI6bOWDOv3kRPSG7W4XKxOfRR1rTW+uD9WoHNzoYlJLSNsD8Qg==
X-Received: by 2002:a50:f094:: with SMTP id v20mr2402321edl.77.1590663595667;
        Thu, 28 May 2020 03:59:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id lw27sm5064998ejb.80.2020.05.28.03.59.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 03:59:55 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] KVM: x86: extend struct kvm_vcpu_pv_apf_data
 with token info
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-3-vkuznets@redhat.com>
 <20200526182745.GA114395@redhat.com> <875zcg4fi9.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb07dcc4-141a-6fea-51f9-86527c454638@redhat.com>
Date:   Thu, 28 May 2020 12:59:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <875zcg4fi9.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 10:42, Vitaly Kuznetsov wrote:
> How does it work with the patchset: 'page not present' case remains the
> same. 'page ready' case now goes through interrupts so it may not get
> handled immediately. External interrupts will be handled by L0 in host
> mode (when L2 is not running). For the 'page ready' case L1 hypervisor
> doesn't need any special handling, kvm_async_pf_intr() irq handler will
> work correctly.
> 
> I've smoke tested this with VMX and nothing immediately blew up.

Indeed.

It would be an issue in the remote (read: nonexistent) case of a
hypervisor that handles async page faults and does not VMEXIT on
interrupts.  In this case it would not be able to enable page ready as
interrupt, and it would have to get rid of async page fault support.

Paolo

