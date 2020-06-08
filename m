Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5967C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE00A206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEfDgzG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgFHIUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:20:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40210 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729060AbgFHIUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591604449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PgnSUhvnGmVlTMkExDgba+ehKY/BZAg587suJPnB15E=;
        b=gEfDgzG24JxLPS13ESMPnCEyt4DCqpQjFQOQyL1R9JAjxvmbcDfFXzzMwFsLVPflI+khmz
        qFbQgnmSR1ia9F6wZOHb1+jdMc2/kHDsHk87O+D7g/gWWywsVuveTERuB9XtCTlJ0EWq6a
        JqBA6YeFqoaNcYzk7NPqEwtWkbfgFK0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-ZZa4ILpHMkCRCni0ctJX_Q-1; Mon, 08 Jun 2020 04:20:47 -0400
X-MC-Unique: ZZa4ILpHMkCRCni0ctJX_Q-1
Received: by mail-ej1-f69.google.com with SMTP id hj12so5757862ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PgnSUhvnGmVlTMkExDgba+ehKY/BZAg587suJPnB15E=;
        b=ZVpBvWZNQQtTV4h/ob8o9bMUxgkMJNIPKDZpKNDCiqPp0uHftU70GEJIQFDvFugY89
         VosO/Wg/Au0qIRSmwQlxooDusWUhjcQL3X8fcaZnCiEBkQlADcWb8FGLQYKwhyQ5mCUw
         kED3eihFpVv1UxADNuMF9IACm8PUjmWIX8EVPBcDJouwH3s73NsXQhl1QW6ZhUr/XyDn
         dZYwmgf2Hc3ywAefL6zXy+JtA3N+C+x9ft1RXTr7j/1FXS7all0O3QBbU68BHldWdXTG
         dyTIBsQ89KzQ5PZ/+Ykg+3JUfih6DREHicSJrLr1aF6xhci9o8U6Pz8QR8fbydq19yA8
         VcSQ==
X-Gm-Message-State: AOAM530YM+2ipm4EewmyS/Guasn8r9XCdxygRdubQSRsH3lzvyvJvSLm
        sZNazhxBmiJV+OD5xFZ+Ard8McFhtcwBvfJxaomkwDjFcdwVEsqu/MEyqg9J/PGAGsAKTxcvABf
        vOY2T4Chs4kH76d8dtxXR8LVz
X-Received: by 2002:aa7:cd4b:: with SMTP id v11mr21652714edw.356.1591604446386;
        Mon, 08 Jun 2020 01:20:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOniuyMpVDAXmY9mtdQWcLY3TxxXpZEu8EMxsFfa1XUuHyKUuTjPkXBMFkMe7XQkw0Uy6jJA==
X-Received: by 2002:aa7:cd4b:: with SMTP id v11mr21652704edw.356.1591604446164;
        Mon, 08 Jun 2020 01:20:46 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d11sm7157315edy.79.2020.06.08.01.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 01:20:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] KVM: nVMX: Properly handle kvm_read/write_guest_virt*() result
In-Reply-To: <20200605200651.GC11449@linux.intel.com>
References: <20200605115906.532682-1-vkuznets@redhat.com> <20200605200651.GC11449@linux.intel.com>
Date:   Mon, 08 Jun 2020 10:20:44 +0200
Message-ID: <878sgyc6jn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Fri, Jun 05, 2020 at 01:59:05PM +0200, Vitaly Kuznetsov wrote:
>> Introduce vmx_handle_memory_failure() as an interim solution.
>
> Heh, "interim".  I'll take the over on that :-D.
>

We just need a crazy but real use-case to start acting :-)

>> Note, nested_vmx_get_vmptr() now has three possible outcomes: OK, PF,
>> KVM_EXIT_INTERNAL_ERROR and callers need to know if userspace exit is
>> needed (for KVM_EXIT_INTERNAL_ERROR) in case of failure. We don't seem
>> to have a good enum describing this tristate, just add "int *ret" to
>> nested_vmx_get_vmptr() interface to pass the information.

On a loosely related note, while writing this patch I was struggling
with our exit handlers calling convention (that the return value is '1'
- return to the guest, '0' - return to userspace successfully, '< 0' -
return to userspace with an error). This is intertwined with normal
int/bool functions and make it hard to read. At the very minimum we can
introduce an enum for 0/1 return values from exit handlers. Or, maybe,
we can introduce KVM_REQ_USERSPACE_EXIT/KVM_REQ_INTERNAL_ERROR/.. and
make all the exit handlers normal functions returning 0/error?

>> 
>> Reported-by: syzbot+2a7156e11dc199bdbd8a@syzkaller.appspotmail.com
>> Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> ...
>
>> +/*
>> + * Handles kvm_read/write_guest_virt*() result and either injects #PF or returns
>> + * KVM_EXIT_INTERNAL_ERROR for cases not currently handled by KVM. Return value
>> + * indicates whether exit to userspace is needed.
>> + */
>> +int vmx_handle_memory_failure(struct kvm_vcpu *vcpu, int r,
>> +			      struct x86_exception *e)
>> +{
>> +	if (r == X86EMUL_PROPAGATE_FAULT) {
>> +		kvm_inject_emulated_page_fault(vcpu, e);
>> +		return 1;
>> +	}
>> +
>> +	/*
>> +	 * In case kvm_read/write_guest_virt*() failed with X86EMUL_IO_NEEDED
>> +	 * while handling a VMX instruction KVM could've handled the request
>
> A nit similar to your observation on the shortlog, this isn't limited to VMX
> instructions.
>

Yea, it all started with nested_vmx_get_vmptr() then Paolo discovered
vmwrite/vmread/vmptrst/invept/invvpid and then I discovered invpcid but
forgot to update the comment ...

>> +	 * correctly by exiting to userspace and performing I/O but there
>> +	 * doesn't seem to be a real use-case behind such requests, just return
>> +	 * KVM_EXIT_INTERNAL_ERROR for now.
>> +	 */
>> +	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>> +	vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_EMULATION;
>> +	vcpu->run->internal.ndata = 0;
>> +
>> +	return 0;
>> +}
>

-- 
Vitaly

