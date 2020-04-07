Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9DAC2BABC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0500D2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 07:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpH+2BMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgDGH2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 03:28:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24561 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727833AbgDGH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586244486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+zSuESAdmDNaSehXE++KKHmAinJZPYbBQIlb8YW2/Kg=;
        b=HpH+2BMFOa1YIDMeRKFYLaJ0Dt5DCryvujN2IrXV3aPqJY8m8olFsakIYzTHtOzGs8aADH
        Xmyj57deFq2/zmlcMV0jUU3FCSe4Az0EG5BXS+rl4tcUfRqe+aPwIIP5pKg6ot/OUbUQqU
        v+rqsaTFO1tCIKySchc7a8kTNX4zrVo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-Eh72ZufgP9mh76PQr6Zfkw-1; Tue, 07 Apr 2020 03:28:04 -0400
X-MC-Unique: Eh72ZufgP9mh76PQr6Zfkw-1
Received: by mail-wr1-f71.google.com with SMTP id o10so1292929wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 00:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+zSuESAdmDNaSehXE++KKHmAinJZPYbBQIlb8YW2/Kg=;
        b=h6Fn72fd1q46YND/STQPOCWY/9EFllERfib/h3Eqqq4ECWgZ4COiHAVDKaNpJblqKE
         +tx0PzNdu0e2Vv3tXofDb3/G/d1qv9KxMUOdNgzV3JdcG/VUEWWEudXxwDx43rAklVcp
         n73rBGk1GMB3dBJlofNYYUoF7bgbq6EHpO1VzJBuXV5ksB89TdsU6b03FBbXe4mJcjnL
         AIWzUttuarTZKLRPRTfwzCZ3pw/FB2kuc6utBT+07I6o2IlMzisA+wTmlzWpNwURfaAz
         Ha6Zele4TuKXvl9i/hlrCwg7rD1PkD/9dC9qlml2MoLU2Mv42Ne67mqoHeCYJlD+GncN
         6J0g==
X-Gm-Message-State: AGi0PubdtEhBt9yOOtrGEZnTu2fOmzeW+2koe0eB+VnsqFN8F1mpSc6g
        Jvw22eLRMjcisjvG9rG0yC/DQ0O2ehVTkO4QSGaKXj5tnt8g6nJEkMc6tqT47y8nL5b3R0b9E6S
        UfjiueUOFaR8l8FEVtSr0P0q6
X-Received: by 2002:adf:9e49:: with SMTP id v9mr1200687wre.34.1586244483391;
        Tue, 07 Apr 2020 00:28:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypLvoxh+i4BgWxDcfk/zNNWVBGiWj/CCu99qpamlIgjACcFmj10/koCLpDW3NtDhyVjYTtCmFw==
X-Received: by 2002:adf:9e49:: with SMTP id v9mr1200664wre.34.1586244483136;
        Tue, 07 Apr 2020 00:28:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c20sm1186423wmd.36.2020.04.07.00.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 00:28:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: hv_hypercall_pg page permissios
In-Reply-To: <20200407065500.GA28490@lst.de>
References: <20200407065500.GA28490@lst.de>
Date:   Tue, 07 Apr 2020 09:28:01 +0200
Message-ID: <87v9mblpq6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> Hi all,
>
> The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
> in the kernel using __vmalloc with exectutable persmissions, and the
> only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
> be readable?  Otherwise we could use vmalloc_exec and kill off
> PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn off
> write permission on the hypercall page") it was even mapped writable..

[There is nothing secret in the hypercall page, by reading it you can
figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
likely not the only possible way :-)]

I see no reason for hv_hypercall_pg to remain readable. I just
smoke-tested

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7581cab74acb..17845db67fe2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -382,7 +382,7 @@ void __init hyperv_init(void)
        guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
        wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-       hv_hypercall_pg  = __vmalloc(PAGE_SIZE, GFP_KERNEL, PAGE_KERNEL_RX);
+       hv_hypercall_pg  = vmalloc_exec(PAGE_SIZE);
        if (hv_hypercall_pg == NULL) {
                wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
                goto remove_cpuhp_state;

on a Hyper-V 2016 guest and nothing broke, feel free to go ahead and
kill PAGE_KERNEL_RX.

-- 
Vitaly

