Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B47CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E718D20771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PidKPYPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGGR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:26:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727791AbgGGR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594142767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KfTUk9PAGIk1UnNRy8zSV6nw0M/fTj95s0UbcyGGc9I=;
        b=PidKPYPrALwhbmXlB1ChI/nfKVZ+iIOjTKKcDpNhAz4AbyEq3hQ6RkXL9ePESbh42veD9I
        uIct8H7JiTSzIkrDNlGx8aFRaAr6irfwG0C1FeigUbL1fQrm0ip/x2emX3UExQldFISzv3
        dwHFaRQGlAIDCgnfZPQtZDSXtN2zR0s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-IvBLMaS-NDSMQdrpxA1XqA-1; Tue, 07 Jul 2020 13:26:06 -0400
X-MC-Unique: IvBLMaS-NDSMQdrpxA1XqA-1
Received: by mail-wr1-f69.google.com with SMTP id j3so29599866wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 10:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KfTUk9PAGIk1UnNRy8zSV6nw0M/fTj95s0UbcyGGc9I=;
        b=LH+QHOwBsG7VSNorcd8PxhRb/BniQpq/kAZEpe2cDd1fC/fUzu8qS4/c2k9EPxj3ko
         3KWBWSegW3Xy7fESKSrSb//G0KdPF5PqUtEoBqrSDnkw+9Wl0WRoo72RarkatjUCA4hw
         BbTchVgRNmfXkE1XMc6C0ucM8vZxW+lonRu2XKie8T2YQID82eO5oDF4ceAuV4+9LLNx
         Ogi43QOPYVrx5DqBU4Q5aZophI3H3j/QLWeyR2+LBcJAx2T6fep/AvljMyTnXJEP/Uwy
         g1Vwiwq/Yagd4QG75tfH9AWf5JF9CkEIkYkn0H6opBL20+xkUue0n9MqpuHE0T0kVdKb
         gufA==
X-Gm-Message-State: AOAM531Su02j2NRwtfgnBfQPQzr+uNwA2Nvw4/dZXm9V4bFDtlP5QA97
        ZTUS9qToKHMNp82fBMLiHd7pcuwmCCcCJoz6Zq0RM0838cmJUSIiH/NXLwmbTzoVfo/Q4bfI5qj
        /RhepneuP/J+L2potc9JD8xX0
X-Received: by 2002:a5d:5587:: with SMTP id i7mr53279461wrv.314.1594142764774;
        Tue, 07 Jul 2020 10:26:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJys31mXYPkvFr+OKDY2YGUbbkO9gWFPb7K0WfeuTUl+TuLBtnwm1fCRnPSymz3Zh67H8Nqlmg==
X-Received: by 2002:a5d:5587:: with SMTP id i7mr53279447wrv.314.1594142764544;
        Tue, 07 Jul 2020 10:26:04 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e95f:9718:ec18:4c46? ([2001:b07:6468:f312:e95f:9718:ec18:4c46])
        by smtp.gmail.com with ESMTPSA id a3sm1808226wmb.7.2020.07.07.10.26.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 10:26:03 -0700 (PDT)
Subject: Re: [PATCH] kvm: x86: rewrite kvm_spec_ctrl_valid_bits
To:     Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>
References: <20200702174455.282252-1-mlevitsk@redhat.com>
 <20200702181606.GF3575@linux.intel.com>
 <3793ae0da76fe00036ed0205b5ad8f1653f58ef2.camel@redhat.com>
 <20200707061105.GH5208@linux.intel.com>
 <7c1d9bbe-5f59-5b86-01e9-43c929b24218@redhat.com>
 <20200707081444.GA7417@linux.intel.com>
 <f3c243b06b5acfea9ed4e4242d8287c7169ef1be.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed934ade-f377-4de1-55bb-d0c1a2770be0@redhat.com>
Date:   Tue, 7 Jul 2020 19:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <f3c243b06b5acfea9ed4e4242d8287c7169ef1be.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/07/20 13:35, Maxim Levitsky wrote:
> After thinking about this, I am thinking that we should apply similiar logic
> as done with the 'cpu-pm' related features.
> This way the user can choose between passing through the IA32_SPEC_CTRL,
> (and in this case, we can since the user choose it, pass it right away, and thus
> avoid using kvm_spec_ctrl_valid_bits completely), and between correctness,
> in which case we can always emulate this msr, and therefore check all the bits,
> both regard to guest and host supported values.

Unfortunately, passing it through is just too slow.  So I think it's
overkill.  There's two ways to deal with badly-behaved guests blocking
migration: 1) hide SPEC_CTRL altogether 2) kill them when migration
fails; both are acceptable depending on the situation.

Paolo

> Does this makes sense, or do you think that this is overkill?

