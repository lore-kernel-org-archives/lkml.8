Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C529EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04572072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/hsqM8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgHQS4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:56:40 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44570 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731467AbgHQS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597690585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P+SWVW+pjg81S9WWqotQ3smvkOJqzR+CExLaQMZK0Pw=;
        b=Q/hsqM8I1IA1A2Csj8E/CJWcCySYokbi0wnDz4vVjX7E2sELmz+D/v38jTOu6NpFPTl6pw
        +Dsl++ULV1dc1WSoAzHbNHxmIuWR1SpFVN4ylqR5qLWRzOWgvrRfAnq5Uvz2M2dmfeo10t
        XF7UYGArExM3gghVBStvbB6zK9q6HLg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-0cPwofDoP4WTQ4hZHAIp8w-1; Mon, 17 Aug 2020 14:56:23 -0400
X-MC-Unique: 0cPwofDoP4WTQ4hZHAIp8w-1
Received: by mail-wr1-f72.google.com with SMTP id 89so7372274wrr.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P+SWVW+pjg81S9WWqotQ3smvkOJqzR+CExLaQMZK0Pw=;
        b=C92iEX5AX4c4BooKs/zda9+lgNKBMIjuT9nB+mqI3DETA+J5yiEvMcWnZ8HLI46EON
         nlzwHYWA/TxJS/aIF8j4/qG3PXiww0YVeFJUOqkF69sXtTmFayChIKeZDCIUbwwQW/lK
         VthK7VK3UEz9wuBlHv9s99tLn/CwO6b2e/G9fMu4z949LbhzRyLe8bRiFHnhU7Kx9iiA
         y+aepSFz6V/H6FLuBaj9SrWBH2Y2fN8mPQW9ra/2EgnEHslpIZ1pm5MKlJ15qerVv39k
         y2nhC6/RogIJW/tqhwrSwpjtUr5ejjbMmLZRNzPpTJ7gG0kljFuD01XAcb/z+S7y0qBo
         MjaQ==
X-Gm-Message-State: AOAM5337wWTDlfydgbGYvUqXATSQKi9P/YWLriHJFLppqvDjIN+ZFKGX
        OvE7fb9SlamvCbGz2VGhoRsOQubzLuEwszxCUy9uxLcsElfG54A4Mpjh6+D9dk5CFhTAtOdwM64
        UwYlI1y7revX6EUJSJRzVR2Es
X-Received: by 2002:a1c:7705:: with SMTP id t5mr16436381wmi.112.1597690582493;
        Mon, 17 Aug 2020 11:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxV6kFCk0mELAK5UYZBHElUrR6OjmsPsIgsjsuvWmke05COroSNIAs3VHHaBHPOCPA2bimU5A==
X-Received: by 2002:a1c:7705:: with SMTP id t5mr16436367wmi.112.1597690582208;
        Mon, 17 Aug 2020 11:56:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977? ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
        by smtp.gmail.com with ESMTPSA id r3sm29893163wro.1.2020.08.17.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:56:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: fix access code passed to gva_to_gpa
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200817180042.32264-1-pbonzini@redhat.com>
 <20200817184226.GJ22407@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <77e46758-4b00-9db9-13ab-329c6dad66f3@redhat.com>
Date:   Mon, 17 Aug 2020 20:56:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817184226.GJ22407@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/20 20:42, Sean Christopherson wrote:
> 
> Don't suppose you'd be in the mood to kill the bare 'unsigned'?
> 
>   WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

u32 is even better.

> Alternatively, what about capturing the result in a new variable (instead of
> defining the mask) to make the wrap suck less (or just overflow like the
> current code), e.g.:
> 
>         u32 access = error_code &
>                      (PFERR_WRITE_MASK | PFERR_FETCH_MASK | PFERR_USER_MASK);
> 
>         if (!(error_code & PFERR_PRESENT_MASK) ||
>             vcpu->arch.walk_mmu->gva_to_gpa(vcpu, gva, access, &fault) != UNMAPPED_GVA) {

Sure, that's better.

Paolo

