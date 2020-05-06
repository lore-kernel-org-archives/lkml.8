Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EA6C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F15120A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRsFR1E3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgEFQJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:09:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25111 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729418AbgEFQJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588781371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LSgQ8YJxEMhLIrqO/YJcdGSlP0f7eNQQ/CQ1CO6dBlo=;
        b=hRsFR1E3mGwUjE0tkcq9+hd6nY+S7HgXXnw8bQduoCbVRqJMlkPpYvhTBLMSlEw2nXptXu
        Y30CTqEMbR5XAOoNyA2yTnDIfiALiF2eZAqPHMAdkwZ32I6UqsW68vNQn+BsgA/ghJ/I2h
        qX+5mOFOi84itCzryRunbnIzocItCIQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-LguOkTntPW2255Mt4NzQ6w-1; Wed, 06 May 2020 12:09:27 -0400
X-MC-Unique: LguOkTntPW2255Mt4NzQ6w-1
Received: by mail-wr1-f71.google.com with SMTP id a12so1578805wrv.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LSgQ8YJxEMhLIrqO/YJcdGSlP0f7eNQQ/CQ1CO6dBlo=;
        b=spRMtVVqHrBaJk/aATNnUMHsbsiHe+N/6WJT3sm2UxQrjdVpEUTVdbLrtZIb7D6vLa
         iuQ+vePudW0vpzHCWLrsP15pXtuSimARk149jIm3KblIt9tny/veTaISaHwvCSNkuPDl
         MP3jx4T4FW/ecbrVJzisnvJSXaWagunz2UVABEEkVdgfSmiZcLHYHWGqUxWlNBnB09In
         tpOwSSqvWta6uIhvijJE0uzojV7OR0rnycgXx59ZxWG+0KuO3EOIFKABdrGpazN4GbFo
         PXm8CfCI0k9+yWWXP4xT9mSXiwiz8/eeSTBHh5V6nNTT8GU6vMQ/hFv1DN1BvT0OrwhJ
         pMYw==
X-Gm-Message-State: AGi0PuYeEaW3XegIRFIgjvXBy2m1DrU0mLJfaEvkHtxLrmqnHwijVe3e
        b34KCDWGAqgnVDvV36PL//h6Z0JEnItkwOwGN9kHu2Bfd+S6eAzyuz+gqmD9xIC2HM32FzDZ0l6
        AxfbhVr8qSRAgMs+jyzAg1GvS
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr5176815wmg.121.1588781365653;
        Wed, 06 May 2020 09:09:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypI7gzG5qcbx8VG1Ygu0+6ZEU8iGxjvwNjrNCvKqYtR7y1a21HzIpeztonpTyCyr1MPQTdPsGQ==
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr5176789wmg.121.1588781365458;
        Wed, 06 May 2020 09:09:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id m188sm3461061wme.47.2020.05.06.09.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 09:09:24 -0700 (PDT)
Subject: Re: [PATCH 7/9] KVM: x86: simplify dr6 accessors in kvm_x86_ops
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200506111034.11756-1-pbonzini@redhat.com>
 <20200506111034.11756-8-pbonzini@redhat.com> <20200506160623.GO6299@xz-x1>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d44c75f-00df-3cae-31a8-982a0b95f0b0@redhat.com>
Date:   Wed, 6 May 2020 18:09:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200506160623.GO6299@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 18:06, Peter Xu wrote:
> On Wed, May 06, 2020 at 07:10:32AM -0400, Paolo Bonzini wrote:
>> kvm_x86_ops.set_dr6 is only ever called with vcpu->arch.dr6 as the
>> second argument, and for both SVM and VMX the VMCB value is kept
>> synchronized with vcpu->arch.dr6 on #DB; we can therefore remove the
>> read accessor.
>>
>> For the write accessor we can avoid the retpoline penalty on Intel
>> by accepting a NULL value and just skipping the call in that case.
>>
>> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> (I think this patch and the previous one seem to be the same as the previous
>  version.  Anyway...)

Yes, I placed them here because they are needed to solve the SVM bugs in
patch 8.  Sorry for not adding your Reviewed-by.

Paolo

> Reviewed-by: Peter Xu <peterx@redhat.com>

