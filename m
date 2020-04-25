Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0898AC54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAD720704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 15:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IQY3D/zq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDYPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 11:32:06 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37493 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726062AbgDYPcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587828725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzRp1k5dc8WKlXfsFPGhR2nlnYOxZPdvqIx1ngvuQb8=;
        b=IQY3D/zqEjrkJ9iYUWrrBb823xJs1Oc7/K7V5Q+yR9VQpbtGYlMK8SzzQT3d7zJvaQ2Enj
        oSYO0L4YuVc7TvkjlX9aJ6DXFUmEop3NdZc/8mrYEqbIJhkcyJl7/DLxB0JZ3oaIEtG1xw
        mFuMTI/7mqxuTKM92VC2Pqs7cnnNIFA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-iI-bMm5FOvGgPwXUwKnACw-1; Sat, 25 Apr 2020 11:32:03 -0400
X-MC-Unique: iI-bMm5FOvGgPwXUwKnACw-1
Received: by mail-wr1-f72.google.com with SMTP id d17so6826346wrr.17
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 08:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BzRp1k5dc8WKlXfsFPGhR2nlnYOxZPdvqIx1ngvuQb8=;
        b=BoaJt7duWRvKt10FnKq7qqhRCCyFK3gGHJrcj9XnkwRKbU8+QSXHdbX69NGdc6Dsdx
         QdUdEfPkSg98dEUJlEsw5MAH8c8oRYzHCGXejeCkY8wAOM1YDauvQk/Ibrq0Yh6LKHWz
         BP2VxFzdX3zBheOFq2e1K20Sj8D0d82hkiHZbLI5zUhej7SXaBVZa1t/X3vWlBH8ChhB
         twYqJS8WFzJ8YXK6G0JYQYgvlUxn2m8s00dd/6Bj1OxosDfZGK0utkWFaBeMevb3Vjsb
         No13WbRWE4xz7zn8M7yAF1MKref9MMR9mAjCpOLUw3xrWG39dYOKwQ+9Sj1ALPNKwuRU
         onaA==
X-Gm-Message-State: AGi0Pubvgq5vzoGkNlI1BEYqPmz9myKnnrOpObpyX1pjJgyiF5bdQWRf
        093a1zEbYJj4gnieY1JTbuCSruw2esjWnzwcJNdz7riPbzpG9P/Ugt8TU8y3nvivLB80XFLAzAP
        D/2r4gweygg4LXJ4GHjkS9sYr
X-Received: by 2002:a5d:4301:: with SMTP id h1mr18013780wrq.144.1587828721999;
        Sat, 25 Apr 2020 08:32:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKxxnDSm/VF3uk0PKMA3ZoLYy6mbz4JxZCdemvQx51TsVlUG0uJlpkeUpyPFw2DqwsfIQNYcQ==
X-Received: by 2002:a5d:4301:: with SMTP id h1mr18013766wrq.144.1587828721754;
        Sat, 25 Apr 2020 08:32:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id y40sm14033685wrd.20.2020.04.25.08.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 08:32:01 -0700 (PDT)
Subject: Re: [PATCH v11 7/9] KVM: X86: Add userspace access interface for CET
 MSRs
To:     Yang Weijiang <weijiang.yang@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, sean.j.christopherson@intel.com,
        jmattson@google.com
Cc:     yu.c.zhang@linux.intel.com
References: <20200326081847.5870-1-weijiang.yang@intel.com>
 <20200326081847.5870-8-weijiang.yang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <08457f11-f0ac-ff4b-80b7-e5380624eca0@redhat.com>
Date:   Sat, 25 Apr 2020 17:31:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200326081847.5870-8-weijiang.yang@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/20 09:18, Yang Weijiang wrote:
> There're two different places storing Guest CET states, states
> managed with XSAVES/XRSTORS, as restored/saved
> in previous patch, can be read/write directly from/to the MSRs.
> For those stored in VMCS fields, they're access via vmcs_read/
> vmcs_write.
> 
> To correctly read/write the CET MSRs, it's necessary to check
> whether the kernel FPU context switch happened and reload guest
> FPU context if needed.

I have one question here, it may be just a misunderstanding.

As I understand it, the PLx_SSP MSRs are only used when the current
privilege level changes; the processor has a hidden SSP register for the
current privilege level, and the SSP can be accessed via VMCS only.

These patches do not allow saving/restoring this hidden register.
However, this should be necessary in order to migrate the virtual
machine.  The simplest way to plumb this is through a KVM-specific MSR
in arch/x86/include/uapi/asm/kvm_para.h.  This MSR should only be
accessible to userspace, i.e. only if msr_info->host_initiated.

Testing CET in the state-test selftest is a bit hard because you have to
set up S_CET and the shadow stack, but it would be great to have a
separate test similar to tools/testing/selftests/x86_64/smm_test.  It's
not an absolute requirement for merging, but if you can put it on your
todo list it would be better.

Thanks,

Paolo

