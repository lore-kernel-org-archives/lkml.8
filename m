Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320D6C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 108EB2085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNOywEA4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgD2Mof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:44:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33657 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2Mod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588164272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1gmxzYwGYkHsTP2qdw/Zf43U7oFKL4OKxMuAWff220=;
        b=ZNOywEA4YY1NTT4Ye1jvV5okn8qml/0suNhCZNiJ9Dgs5oZtxozPQ9fp50PlMugLIUcvwm
        VAv5syt+rvBwpj5K92XxTcj91008IXjVheQdjqVcYPjWOfgSwutRUnp6NUmIS6ZH80tEKi
        +SNJCYxehioYvwNZb3XIuDqnxEikA5M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-I7ZgGLbFNcC4O8s2WtM9bA-1; Wed, 29 Apr 2020 08:44:29 -0400
X-MC-Unique: I7ZgGLbFNcC4O8s2WtM9bA-1
Received: by mail-wm1-f69.google.com with SMTP id f81so901684wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F1gmxzYwGYkHsTP2qdw/Zf43U7oFKL4OKxMuAWff220=;
        b=SvGOc9hdlWPsIrQK6aSsJ9uyiIH4v9TfFVWMuFAIIPnwUCPeSUmG1eeOxCO6pnXmK1
         8Rb4TXE6ye2E6C9+bhc7PG85htpR58PNhJvxx+pul17e1SIm+YyxSUpYhpAp1G8HPGO/
         /Bfmt8jI8Yzb2HD7IH0/eUSR8iwQYP2glDFq1bWo1MrSmOZVJX6ff9YIHHufgiTypWrz
         WqW0PWo70NprlyDJDScMUQp2Uu9v7eVoqkcUonWPrYZ6M9/YJtRV99LAMl6zKKairQ8b
         HRVraGEwz0SaUQmt/ibBGl1GaAH5R4CbMjKufmas15H7bz5FoTg4DnQjDKXS2gC7aJi5
         E0xw==
X-Gm-Message-State: AGi0Pub8aJLRf2IlwUfQhBo+X1+QMnvphVXOsFVwRq10Vg6Vw9/UinTi
        dnQE81UEbcM2Hz0yDcOKJfi2/g+WIZa+N/hrA/KaCymd7/56gdnfdGjX4TATbw3XwAx4TIimnv0
        mXOP13Ixs4W+8vUXC42bF6Ax0
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr3293691wmk.73.1588164268560;
        Wed, 29 Apr 2020 05:44:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypIDy1Gzn5KS6sVj5+mwG0tU6gsAr1QHam6y8lBLNR9VXqx4RnhI2p/igJAUJzVkMROC5wddIQ==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr3293673wmk.73.1588164268383;
        Wed, 29 Apr 2020 05:44:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n2sm30796885wrq.74.2020.04.29.05.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:44:27 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH RFC 6/6] KVM: x86: Switch KVM guest to using interrupts for page ready APF delivery
In-Reply-To: <ee587bd6-a06f-8a38-9182-94218f7d08bb@redhat.com>
References: <20200429093634.1514902-1-vkuznets@redhat.com> <20200429093634.1514902-7-vkuznets@redhat.com> <ee587bd6-a06f-8a38-9182-94218f7d08bb@redhat.com>
Date:   Wed, 29 Apr 2020 14:44:25 +0200
Message-ID: <87blnah36e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 29/04/20 11:36, Vitaly Kuznetsov wrote:
>> +
>> +	if (__this_cpu_read(apf_reason.enabled)) {
>> +		reason = __this_cpu_read(apf_reason.reason);
>> +		if (reason == KVM_PV_REASON_PAGE_READY) {
>> +			token = __this_cpu_read(apf_reason.token);
>> +			/*
>> +			 * Make sure we read 'token' before we reset
>> +			 * 'reason' or it can get lost.
>> +			 */
>> +			mb();
>> +			__this_cpu_write(apf_reason.reason, 0);
>> +			kvm_async_pf_task_wake(token);
>> +		}
>
> If tokens cannot be zero, could we avoid using reason for the page ready
> interrupt (and ultimately retire "reason" completely)?

Yes, we can switch to using 'token' exclusively but personally I'm not
sure it is worth it. We'll still have to have a hole and reason + token
is only u64. Keeping 'reason' in place allows us to easily come up with
any other type of notification through this mecanism (if the reson is
... then 'token' means ...).

-- 
Vitaly

