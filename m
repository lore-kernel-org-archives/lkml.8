Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65693C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41662206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 17:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPY1Wbuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgEDRG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 13:06:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24842 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728158AbgEDRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 13:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588612017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qM6cBcDrv7XvtKNZfJ9tygW5NlSD4IQZrqyuCyi/QkE=;
        b=GPY1Wbuqc/jJIfG5fxx4WVf8y7LltsTHhtbGdNk36F1oLrPHYAcy57rpXETwxbycFy77gZ
        lHberMU4uas//dTEMBoHnvw6Ce2paPoc4+rAWU7+/P7OLDT5maW/nc/5tmlY6wb2eCjtFQ
        munquh0Eyf1Txj0XUZgeAGWJZpd1g9w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-yV9g12gtOcifytI6bikVfg-1; Mon, 04 May 2020 13:06:55 -0400
X-MC-Unique: yV9g12gtOcifytI6bikVfg-1
Received: by mail-wr1-f71.google.com with SMTP id j16so13970wrw.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 10:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qM6cBcDrv7XvtKNZfJ9tygW5NlSD4IQZrqyuCyi/QkE=;
        b=nsT4+Is1KwRbmKpoNUNpwvx9kGPEDW0/FOte0uycG1oEc6KNaGnhehDoqqE7CEAJay
         rqsJPd/dlJB5eSCs8ziHx3u0PSrYrBhUmmghQxdkdtnL3LsNNIjxSxAlL/WWwyWMeDDA
         NtM7/E5SIiWnsbVqBn9ze96iQr371iE1lO1NdYZ92J5CjrknV307cnTfjZltXCo40tvs
         h9wCq53StJMgLcUmImC5gjo1A+nC+6MLjTdmRhrcf1Ae72ANwPcQrLbg+rRVRw0juLlr
         YxeFI5i4EGRUTF2/B6XkilovbgDlG3cHKow1cLSUocFZEqpaxT6ZTPaU+13tYIBC7Cdx
         88kg==
X-Gm-Message-State: AGi0PuYStU6qf8DHrPB6nu0NNP17XmyhP/5//Rv8hDt+UCDP7d1yV3qK
        6P3Pnes7CYC+R3uBk77Yl9LzavzpGUArJ0rK2kgD+Qbz1byT6txJCXaEtvGeWjEyjpN4/bP3gxR
        gT9JtgLV7KESsvUlnqPf8/Zza
X-Received: by 2002:a1c:c302:: with SMTP id t2mr16273729wmf.85.1588612014739;
        Mon, 04 May 2020 10:06:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypLCobPwEfAYjjdMh4VD49vcI+LbaenE5QaeltpkG+Q9TXPlbUuum+mLzyOuaiLQN9CRB9k2yA==
X-Received: by 2002:a1c:c302:: with SMTP id t2mr16273705wmf.85.1588612014488;
        Mon, 04 May 2020 10:06:54 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id r2sm94839wmg.2.2020.05.04.10.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 10:06:53 -0700 (PDT)
Subject: Re: [PATCH v4 2/7] KVM: X86: Enable fastpath when APICv is enabled
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1588055009-12677-1-git-send-email-wanpengli@tencent.com>
 <1588055009-12677-3-git-send-email-wanpengli@tencent.com>
 <87a72tf67l.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <906b09e3-edcf-9d0e-e43b-ae77741c55e9@redhat.com>
Date:   Mon, 4 May 2020 19:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87a72tf67l.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 15:34, Vitaly Kuznetsov wrote:
>>  static enum exit_fastpath_completion vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
>>  {
>> -	if (!is_guest_mode(vcpu)) {
>> +	if (!is_guest_mode(vcpu) && vcpu->arch.apicv_active) {
>>  		switch (to_vmx(vcpu)->exit_reason) {
>>  		case EXIT_REASON_MSR_WRITE:
>>  			return handle_fastpath_set_msr_irqoff(vcpu);
> I think that apicv_active checks are specific to APIC MSRs but
> handle_fastpath_set_msr_irqoff() can handle any other MSR as well. I'd
> suggest to move the check inside handle_fastpath_set_msr_irqoff().
> 
> Also, enabling Hyper-V SynIC leads to disabling apicv. It it still
> pointless to keep fastpath enabled?

Indeed, only fast paths that only apply to apicv should be disabled (and
ideally there should be a WARN_ON in the code that doesn't support !apicv).

Paolo

