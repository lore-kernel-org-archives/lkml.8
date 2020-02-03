Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA08C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E95C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVNMQbRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgBCJuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:50:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44529 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727240AbgBCJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580723321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3SgSFVMx/Ezsv5qsLAwM5EInWLOhNPJNOwKrGHDCpr0=;
        b=AVNMQbRkfdb2kBEqhBQ8/J9bkv0JfAWYJ0Y5g990k2xMpeoTOfcCal8UfsFjbYlN9rUsAd
        9QRGHRz4NyH5ohEnqz5OcVqMWMyXyhb1Xd1UgfIJirsQ0Ljv6YGaxcQc5qFw/ZJoiYlYT9
        K/0gNc5WE400aQSAxnSMe7WkMLb/qsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-3aLqMNyENfqyTev9-h3L8Q-1; Mon, 03 Feb 2020 04:48:37 -0500
X-MC-Unique: 3aLqMNyENfqyTev9-h3L8Q-1
Received: by mail-wm1-f70.google.com with SMTP id o24so4592202wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 01:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3SgSFVMx/Ezsv5qsLAwM5EInWLOhNPJNOwKrGHDCpr0=;
        b=j0E3j+sbT5ieWYjDa4QS+t9nqvH1AfrBaPVHnb79YlYzmbljuTXNZPol2/aDaq5yD4
         a8EFfFEC/txw9544KEbakt0qVVIPVOXOegDHIz+KldF6p9n1fxqfcgdZcnoSRRpUn3S0
         wG4xDot4EbQjwtg7zFOLSD042HOXHJ5OkcWIIb0nK234BE+RuY9EICPeQOf5F9YeWB2h
         2Hvf7C/NEQTteB3zf5S6+3UCPnKRHU5lvsPyiIZNRAjejhc787neGrX7S4wFuAFIC8Ks
         w45Qke2rSpEl/IDYK+XAdQJS2dlN+yJZyW/kfkEY4edR5IHRQcTr8iv0JimOriS2ddLa
         aPzA==
X-Gm-Message-State: APjAAAV/XDkqJlIov271/9GzErXJdKUa0KwJ554VVPaNiES1NQeVujCg
        OWIE9/tq0evMV7msGMie7iSCx23HK7MzilmNwJ7YAAm0+n+OantPGEhzPMj87CS64WhtqF5Iw1B
        JgT1KC5e7unyhSW0c41i8qZgE
X-Received: by 2002:a1c:451:: with SMTP id 78mr26769170wme.125.1580723316787;
        Mon, 03 Feb 2020 01:48:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKe/mFnwg44MggQEmr6tADJLSSeVxx0EmmhwIfpgZGVe/0/aRtIdZ6WRbo1jL3V/pl7Tkq9w==
X-Received: by 2002:a1c:451:: with SMTP id 78mr26769140wme.125.1580723316577;
        Mon, 03 Feb 2020 01:48:36 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z25sm22532796wmf.14.2020.02.03.01.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 01:48:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH] KVM: nVMX: set rflags to specify success in handle_invvpid() default case
In-Reply-To: <668e0827d62c489cbf52b7bc5d27ba9b@huawei.com>
References: <668e0827d62c489cbf52b7bc5d27ba9b@huawei.com>
Date:   Mon, 03 Feb 2020 10:48:35 +0100
Message-ID: <87zhe0ngr0.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> I'm sorry for reply in such a big day. I'am just backing from a really
> hard festival. :(

Let the force be with you guys! We really hope the madness is going to
be over soon. Stay safe!

-- 
Vitaly

