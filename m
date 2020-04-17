Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C998C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2899C221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJ6FedXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgDQKD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:03:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54302 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726366AbgDQKDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587117804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ElYTrTrSJKdE2tYQriD77Ds10y+cL36iV21AUMPYK8=;
        b=WJ6FedXCjSxzHXR2Ym+0z1zXq7vuDaHcx3/n7he8xfb+zNnFspb5y2Ezq/R54s252jDtIB
        4QMIlVOgXjSuh/U1rXOy0ukLCZOZ8iRp8GhEGFBd64jabGU9O4Iad01EGn9obxD2N5Bqbx
        zmJu60jCA71qdNa8m+k0pmhX3lmMZVI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-F3M7daGpP2eLuDIxTvFxOQ-1; Fri, 17 Apr 2020 06:03:22 -0400
X-MC-Unique: F3M7daGpP2eLuDIxTvFxOQ-1
Received: by mail-wr1-f69.google.com with SMTP id r17so735418wrg.19
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5ElYTrTrSJKdE2tYQriD77Ds10y+cL36iV21AUMPYK8=;
        b=I0mz/FI4QyQi3mqDaSO+Ydpqgdb75xgKcsZQpR4lFk/WbXREAG0xS32Qv/2VSWCR4u
         v6KUL+rtFMBKXctUzgIMmMqcTImJtfvMk4sdOwr8K/4lDIVFIN6oy9w0Qi/LsgF93/vu
         Q4q5M0PtDOyNXPyzzCGAE9Pu2EnxyLQvAInemieAB1H7y5XMObPqiiB4g7JDEP5/GCam
         ocjDqkSinWTX8M1YmvGF0FQRYQs4IfWMRf27pFpdqykj7lZWq7TkDO27pg6+e0GCoZcQ
         7uWwtwMrMuklhkd0RCjPCMymah2rz7TlZfZuLH5sYrzy+Dga7XuPB1JwB5eTxuIF8eTM
         cPkQ==
X-Gm-Message-State: AGi0PuaLHuGVtcArcAHx7Ao8RMZjU0PXFAPaSyBI8BX+3TCRuLt4U+AH
        6uumONtvzE9/JFffqvgqBx43rdNWIwk3vFJG+yRX52ImwEG0QtcozKl/SWHv8UtGrWA2oyqKX/L
        /JLWzeBHulOyayPI1WcKcK61c
X-Received: by 2002:adf:97cc:: with SMTP id t12mr2964674wrb.261.1587117801267;
        Fri, 17 Apr 2020 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: APiQypKYH+JBn8/yn3IYbL7Qlc8+A7kS9lt5b8RYcDiZb5T6r+5ekluPE9YgLZGiyQIkvKPQZtVJZg==
X-Received: by 2002:adf:97cc:: with SMTP id t12mr2964656wrb.261.1587117801045;
        Fri, 17 Apr 2020 03:03:21 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s8sm1178080wru.38.2020.04.17.03.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:03:20 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     bp@alien8.de, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        sthemmin@microsoft.com, tglx@linutronix.de, x86@kernel.org,
        mikelley@microsoft.com, wei.liu@kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for hibernation
In-Reply-To: <1587104999-28927-1-git-send-email-decui@microsoft.com>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com>
Date:   Fri, 17 Apr 2020 12:03:18 +0200
Message-ID: <87blnqv389.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
> resume path, the "new" kernel's VP assist page is not suspended (i.e.
> disabled), and later when we jump to the "old" kernel, the page is not
> properly re-enabled for CPU0 with the allocated page from the old kernel.
>
> So far, the VP assist page is only used by hv_apic_eoi_write().

No, not only for that ('git grep hv_get_vp_assist_page')

KVM on Hyper-V also needs VP assist page to use Enlightened VMCS. In
particular, Enlightened VMPTR is written there.

This makes me wonder: how does hibernation work with KVM in case we use
Enlightened VMCS and we have VMs running? We need to make sure VP Assist
page content is preserved.

-- 
Vitaly

