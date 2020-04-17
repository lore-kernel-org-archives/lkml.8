Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C076AC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A9742083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MU8ylut7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbgDQMDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:03:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38692 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728196AbgDQMDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587125024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2HiKgLpGjG4i07nP9rVsSUNxw62w4Q5rV6+Enm1/11o=;
        b=MU8ylut7j/bl/1zbu0NDOsICy4poyZMQBcbXrtJyMnlo+OwB+36kyfdYhD0xxdW+U5MulN
        f3BNEh1HDoq4OAwd0HT1y4G/D+VvHLgAxxoG+73ri3tDYy78itsm+acwmsHFLM9GRxiJPN
        +fY3r7XJr0ICq6ZGxPwD+oLyf4YnhYI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-hxsygC2APFiTZQlqw2RsaQ-1; Fri, 17 Apr 2020 08:03:42 -0400
X-MC-Unique: hxsygC2APFiTZQlqw2RsaQ-1
Received: by mail-wm1-f70.google.com with SMTP id y1so857142wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2HiKgLpGjG4i07nP9rVsSUNxw62w4Q5rV6+Enm1/11o=;
        b=WyMNb085mBJMiW5KXCdeWrzuyfK3uk95i0t+uaDOaeiGPWucv/sI+0RxpGYxHZsCgE
         zePNvnX1oxtp8aB0RuBypgVGkE/d6Nm/dIAYgjRmLR/wesifAmot3RCZtYaNhQtRph7c
         qN00pVlIA18djnwgtA35F2RTKvaGw1ioUCt5SWOlVjOmxh8x/SP5yGo6FLpjJhdyQTr2
         rwV0DTcf/0wpUtK6/8Kb0pi9kuDV6FRDRY7aVh6yobVx8a3wocEUaSSIRECJjc6Ierhl
         BfD26V1IwAkUXh7aXSCcU9SZ5D0xNchjF+b4Ki/l03F3qZoFwQHI0UoBWX6nfNxYthwI
         nfWw==
X-Gm-Message-State: AGi0Puavv8BJgYYUO2Zm6L8n1DyRza9LM/Bj92JP9J0Ud6/6UFCaDzeY
        fAiKA6jVby/nkqxExw7kZMNo4DLjy5NtiEy38bUZrpqEARKhwdJWPmJXN0bb+WSJc8H1Jb/sd5S
        z3NVsbL/KAo+dHyoWGpancNFT
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3410276wru.376.1587125021300;
        Fri, 17 Apr 2020 05:03:41 -0700 (PDT)
X-Google-Smtp-Source: APiQypJZMS5NEiNrai0mI6AMbtXgPZDaZhTg25gyTNcbiTpAwqbWLD1UsuLFebcZ5vd8dvU/UoiDZg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr3410255wru.376.1587125021043;
        Fri, 17 Apr 2020 05:03:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c190sm7668458wme.10.2020.04.17.05.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 05:03:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Dexuan Cui <decui@microsoft.com>, bp@alien8.de,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sthemmin@microsoft.com, tglx@linutronix.de,
        x86@kernel.org, mikelley@microsoft.com, wei.liu@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Suspend/resume the VP assist page for hibernation
In-Reply-To: <20200417105558.2jkqq2lih6vvoip2@debian>
References: <1587104999-28927-1-git-send-email-decui@microsoft.com> <87blnqv389.fsf@vitty.brq.redhat.com> <20200417105558.2jkqq2lih6vvoip2@debian>
Date:   Fri, 17 Apr 2020 14:03:38 +0200
Message-ID: <87wo6etj39.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Fri, Apr 17, 2020 at 12:03:18PM +0200, Vitaly Kuznetsov wrote:
>> Dexuan Cui <decui@microsoft.com> writes:
>> 
>> > Unlike the other CPUs, CPU0 is never offlined during hibernation. So in the
>> > resume path, the "new" kernel's VP assist page is not suspended (i.e.
>> > disabled), and later when we jump to the "old" kernel, the page is not
>> > properly re-enabled for CPU0 with the allocated page from the old kernel.
>> >
>> > So far, the VP assist page is only used by hv_apic_eoi_write().
>> 
>> No, not only for that ('git grep hv_get_vp_assist_page')
>> 
>> KVM on Hyper-V also needs VP assist page to use Enlightened VMCS. In
>> particular, Enlightened VMPTR is written there.
>> 
>> This makes me wonder: how does hibernation work with KVM in case we use
>> Enlightened VMCS and we have VMs running? We need to make sure VP Assist
>> page content is preserved.
>
> The page itself is preserved, isn't it?
>

Right, unlike hyperv_pcpu_input_arg is is not freed.

> hv_cpu_die never frees the vp_assit page. It merely disables it.
> hv_cpu_init only allocates a new page if necessary.

I'm not really sure that Hyper-V will like us when we disable VP Assist
page and have an active L2 guest using Enlightened VMCS, who knows what
it caches and when. I'll try to at least test if/how it works.

This all is not really related to Dexuan's patch)

-- 
Vitaly

