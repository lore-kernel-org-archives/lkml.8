Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0543C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5722078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hx9H3O4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDTRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:25:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726711AbgDTRZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:25:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587403533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Wi4I6E0HOoTIiwC/qCL3vbIOZi357RgujrqauiVCgo=;
        b=Hx9H3O4+PecACDu9lU1pKPoegTcGxDECulchmzr8CnavF/SstY/VCI02SdkYiP9VDrRRDf
        VHPrGdhVzKRQGgpy2dSE8PSFy/xGLY9sx1eIFAA2N1cATNBYCSjjADbuuHIecz/d5knrl3
        xfIopTPgT9rB0Ky04dPF8F4Z1cOuq0U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-33fWBdtKPqWTEtbE9aYm4w-1; Mon, 20 Apr 2020 13:25:31 -0400
X-MC-Unique: 33fWBdtKPqWTEtbE9aYm4w-1
Received: by mail-wm1-f71.google.com with SMTP id v185so150313wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Wi4I6E0HOoTIiwC/qCL3vbIOZi357RgujrqauiVCgo=;
        b=pCJlS3H7IQHLNwfqeFudrzXKYe7gHwECm19M77Wkj9ajK2Za1nTI0Ryf4lhqQRRvCP
         yCkP+gx8HaR/S5dPiNz6reE+qq4ytCSua2K4I0jkrpJBRg8cq3Sf50CwEnYHw5qYdnYv
         KRZK8GlZIQvep3z3m3OxnhnQBO1aHpKgBI0gaNRprOsIVYYkH3dV19anK/dbrLPOzZPr
         JIJ/zz1sRx5qzTWckOuBHIpm8jAA/2auaz9tdo6GxymetTRgcvLIO6QZlK+kZQds0sp7
         hPpmTR7H3somlzMNB+UpLrGv8G13hKzJ1av7kiT4D9flzZSSOfk8E4nkOEZwYsAOG74C
         3Vwg==
X-Gm-Message-State: AGi0PuamJS4d/VY/ISSgBlZr95lvghPmNVKS97GBTlbzyluvDXnGvZib
        MSB6r99hinl2NHQNK1l48eRqsF1SpFRLgpcSHDmS+cYeXFbZVfjXisNk/ajGppZI4KRTUUA6N6Y
        X4RuNqNy9VctuTjKa1sskESA6
X-Received: by 2002:adf:c109:: with SMTP id r9mr19678375wre.265.1587403530025;
        Mon, 20 Apr 2020 10:25:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypLifiyD2rISqsBTFDUXYG+CQzr+z4iBiqXWbcljpUFDAk2pWd1/77hoQLgJWF6OMqcIiIWbgw==
X-Received: by 2002:adf:c109:: with SMTP id r9mr19678363wre.265.1587403529829;
        Mon, 20 Apr 2020 10:25:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:199a:e5ab:a38c:544c? ([2001:b07:6468:f312:199a:e5ab:a38c:544c])
        by smtp.gmail.com with ESMTPSA id h2sm240458wro.9.2020.04.20.10.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 10:25:29 -0700 (PDT)
Subject: Re: [PATCH v2] kvm: Replace vcpu->swait with rcuwait
To:     Marc Zyngier <maz@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>
Cc:     tglx@linutronix.de, kvm@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>, peterz@infradead.org,
        torvalds@linux-foundation.org, bigeasy@linutronix.de,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        linux-mips@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>,
        joel@joelfernandes.org, will@kernel.org,
        kvmarm@lists.cs.columbia.edu
References: <20200324044453.15733-1-dave@stgolabs.net>
 <20200324044453.15733-4-dave@stgolabs.net>
 <20200420164132.tjzk5ebx35m66yce@linux-p48b>
 <418acdb5001a9ae836095b7187338085@misterjones.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <22800f1b-3bdb-15b4-7592-93a7b244b45a@redhat.com>
Date:   Mon, 20 Apr 2020 19:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <418acdb5001a9ae836095b7187338085@misterjones.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/20 19:12, Marc Zyngier wrote:
>>
>>
>> -    trace_kvm_vcpu_wakeup(block_ns, waited, vcpu_valid_wakeup(vcpu));
>> +    trace_kvm_vcpu_wakeup(block_ns, !block_check,
>> vcpu_valid_wakeup(vcpu));
> 
> This looks like a change in the semantics of the tracepoint. Before
> this change, 'waited' would have been true if the vcpu waited at all.
> Here, you'd have false if it has been interrupted by a signal, even
> if the vcpu has waited for a period of time.
True, good catch.  Perhaps add macros prepare_to_rcuwait and
finish_rcuwait?

Paolo

