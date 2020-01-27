Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EA6C33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8376021739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlCVELBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgA0Vwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:52:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57648 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726080AbgA0Vwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:52:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580161950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=55UOneL2ms6DRqRkSC42nE9sElCV4+6dsT8xJuc/F90=;
        b=dlCVELBl4aSQIkmRBd7xNOs5yr2bRWUsK00iyRjlmC+WFInKgdfTYCCNWs3sQZOseuPMQN
        +WBpUds2+EVMVZwh+WI4QpC8S2SE6LEzfgX77TkCpBUVaq13Zg28tYE5sNSxuOd5Q6PAnS
        aH8aNQuQ6d9Y/eOnziMQ3QRvLssUqKM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-Ne0bdR6OMI25FFTuhmcBOg-1; Mon, 27 Jan 2020 16:52:27 -0500
X-MC-Unique: Ne0bdR6OMI25FFTuhmcBOg-1
Received: by mail-wr1-f71.google.com with SMTP id z10so6893538wrt.21
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=55UOneL2ms6DRqRkSC42nE9sElCV4+6dsT8xJuc/F90=;
        b=D4tYWwKevNcg1/iaLoK3hwWejMqzUZfrGScg7yRs3ZDTY59XspwiKc/O80wxI7OWuh
         x7zHRhr285PZMu2oObzpkTa7MiwlpAk2sy6TG5HX64E50GV91eoG07mxyrBaM8WTKfia
         40MaE+2LfDb4urkImTRCG8GfKMc9YXSqQMGWKHIxjg9bMmSfgBrRtiEAnGoAoT4vdNIP
         DFfB5WJaPSoQ5Vpcr5roJuS446eNP0YFWjNVNZZZQlZd699ZtC8u6YWui1gCO4kXf1Te
         Mo2wZYRBgUe2lMEaNXQ1/M+afrJvFDxIvG8IsMWokETVskAtjzVtcaytWOV5zr8X11QP
         hXow==
X-Gm-Message-State: APjAAAXuECon1C/Qr2qiXp/yl77mQLETEccINbLhzmBxMKfeTdqK4JMp
        5O60MCEGdG5rixNLxI0gNsdDd5R6qSstTrBlHxPyOB0zaofmDoHmpfw8HoaZXWLnFvxQwRuN0xK
        /OsZKN9F8hC17TcpLktx7Mv7w
X-Received: by 2002:adf:f491:: with SMTP id l17mr26182313wro.149.1580161946251;
        Mon, 27 Jan 2020 13:52:26 -0800 (PST)
X-Google-Smtp-Source: APXvYqwW8T//Ne2f8Is87AT0Y5y0DKFSDxo9Fc+kgWX8pRXRYg+owSNawJWD3LvoveF6z4qyBIIsTA==
X-Received: by 2002:adf:f491:: with SMTP id l17mr26182296wro.149.1580161945983;
        Mon, 27 Jan 2020 13:52:25 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n28sm23292967wra.48.2020.01.27.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 13:52:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <437c2710-7148-a675-8945-71dc7a90f7dd@redhat.com>
References: <20200115171014.56405-3-vkuznets@redhat.com> <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com> <20200122054724.GD18513@linux.intel.com> <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com> <87eevrsf3s.fsf@vitty.brq.redhat.com> <20200122155108.GA7201@linux.intel.com> <87blqvsbcy.fsf@vitty.brq.redhat.com> <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com> <87zheer0si.fsf@vitty.brq.redhat.com> <87lfpyq9bk.fsf@vitty.brq.redhat.com> <20200124172512.GJ2109@linux.intel.com> <875zgwnc3w.fsf@vitty.brq.redhat.com> <437c2710-7148-a675-8945-71dc7a90f7dd@redhat.com>
Date:   Mon, 27 Jan 2020 22:52:24 +0100
Message-ID: <87tv4glg87.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 27/01/20 16:38, Vitaly Kuznetsov wrote:
>>>> If there are no objections and if we still think it would be beneficial
>>>> to minimize the list of controls we filter out (and not go with the full
>>>> set like my RFC suggests), I'll prepare v2. (v1, actually, this was RFC).
>>> One last idea, can we keep the MSR filtering as is and add the hack in
>>> vmx_restore_control_msr()?  That way the (userspace) host and guest see
>>> the same values when reading the affected MSRs, and eVMCS wouldn't need
>>> it's own hook to do consistency checks.
>> Yes but (if I'm not mistaken) we'll have then to keep the filtering we
>> currently do in nested_enable_evmcs(): if userspace doesn't do
>> KVM_SET_MSR for VMX MSRs (QEMU<4.2) then the filtering in
>> vmx_restore_control_msr() won't happen and the guest will see the
>> unfiltered set of controls...
>> 
>
> Indeed.  The place you used in the RFC is the best we can do, I am afraid.
>

In case we decide to filter out the full set of unsupported stuff
there's basically nothing to change, feel free to just treat the RFC as
non-RFC :-) (and personally, I'd prefer to keep the 'full set' in the
filter as it is less fragile; the 'short list' I came up with is the
result of my experiments on one hardware host only and I'm not sure what
may make Hyper-V behave differently).

I can re-submit, of course, if needed.

-- 
Vitaly

