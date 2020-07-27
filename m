Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317F4C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD502078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 16:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuTQSyB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgG0QRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 12:17:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35927 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731542AbgG0QRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595866621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsUwnhDK87WKgN3gqd90CcbtRyIxe05OQOcWAwl8fSE=;
        b=IuTQSyB2ZJs58ydl0LAtJwvDyXThs2+AWlGZ+dlNC3u9TG6lex16s+BswLCmvoTG4lsNVy
        8DUkXHEJgWM2V9b7MLiNa8yTzgEwrGd6brElj6E5dTVxBlHC/R7xeoAbS/4VL4WsSY3Jwq
        QkO8BOA49hqOYcbmFUfhr9iHBlxMxTM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-B5H_vO1jPPqp1TMy90Z1og-1; Mon, 27 Jul 2020 12:17:00 -0400
X-MC-Unique: B5H_vO1jPPqp1TMy90Z1og-1
Received: by mail-wr1-f72.google.com with SMTP id w7so1811933wre.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BsUwnhDK87WKgN3gqd90CcbtRyIxe05OQOcWAwl8fSE=;
        b=WWxUvDxDcMw6CZ35dYqv1pNtLs0SLmlkWj+zKvDV1+F62iidmO/jzYL2w2OzaCclK3
         740BIsLvfgC1iO342J5MV8MdltRPOIq0UtAP4ETbomR7gnCJZMcrZN17pqpLxtLHrN6f
         lXahD8m6fTn8Pv47IMVOSI/wJq1p4sNDZRvvJEkiTNRhLnONTpViMcYfzTp6bbCgmRVY
         If/8qOLcV+8NMlwfD44W1pP0aJO7/Yn7IGNKtHABYkqb8GLVkj5c6AxP4yTjxggWZahJ
         TtEmtExXweuKLJWSMBBiDPamhkmhWdnGhVGNDqvnSgkSzKu0yL4Nj8dGrhT3HHsh2k5B
         aS2A==
X-Gm-Message-State: AOAM533PN830cBWEp7ytZ5Ld/YzE26pRGTyc6/bKgSLI6se1aOxMrV+/
        ZcjLwTEHIbtwWLXh/SpGb57RDWKyIpU5Ua/+pyodjxRvbzPVwwOiPOnJ3iu9++IYXtJE6oAklqW
        5uCd5JiLyIlv/jl7a1Q9qWMOF
X-Received: by 2002:a1c:6408:: with SMTP id y8mr84041wmb.52.1595866618758;
        Mon, 27 Jul 2020 09:16:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLKcAmtjP5qdwtcop3VZz69phHqUmhA/GYnUvT8EjsYnFf+2mjdi7w0x6HCc4EEuewJ9M+uA==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr84025wmb.52.1595866618480;
        Mon, 27 Jul 2020 09:16:58 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id u66sm76686wmu.37.2020.07.27.09.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 09:16:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: properly pad struct kvm_vmx_nested_state_hdr
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200713082824.1728868-1-vkuznets@redhat.com>
 <20200713151750.GA29901@linux.intel.com>
 <878sfntnoz.fsf@vitty.brq.redhat.com>
 <85fd54ff-01f5-0f1f-1bb7-922c740a37c1@redhat.com>
 <20200727154654.GA8675@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d50ea1e-f2a2-8aa9-1dd3-4cbca6c6f885@redhat.com>
Date:   Mon, 27 Jul 2020 18:16:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200727154654.GA8675@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/20 17:46, Sean Christopherson wrote:
>> It might as well send it now if the code didn't attempt to zero the
>> struct before filling it in (this is another good reason to use a
>> "flags" field to say what's been filled in).
> The issue is that flags itself could hold garbage.
> 
> https://lkml.kernel.org/r/20200713151750.GA29901@linux.intel.com

Quoting from there:

> Which means that userspace built for the old kernel will potentially send in
> garbage for the new 'flags' field due to it being uninitialized stack data,
> even with the layout after this patch.

Userspace should always zero everything.  I don't think that the padding
between fields is any different from the other bytes padding the header
to 128 bytes.

>   struct kvm_vmx_nested_state_hdr hdr = {
>       .vmxon_pa = root,
>       .vmcs12_pa = vmcs12,
>   };
> 
> QEMU won't see issues because it zero allocates the entire nested state.
> 
> All the above being said, after looking at the whole picture I think padding
> the header is a moot point.  The header is padded out to 120 bytes[*] when
> including in the full nested state, and KVM only ever consumes the header in
> the context of the full nested state.  I.e. if there's garbage at offset 6,
> odds are there's going to be garbage at offset 18, so internally padding the
> header does nothing.

Yes, that was what I was hinting at with "it might as well send it now"
(i.e., after the patch).

(All of this is moot for userspace that just uses KVM_GET_NESTED_STATE
and passes it back to KVM_SET_NESTED_STATE).

> KVM should be checking that the unused bytes of (sizeof(pad) - sizeof(vmx/svm))
> is zero if we want to expand into the padding in the future.  Right now we're
> relying on userspace to zero allocate the struct without enforcing it.

The alternative, which is almost as good, is to only use these extra
fields which could be garbage if the flags are not set, and check the
flags (see the patches I have sent earlier today).

The chance of the flags passing the check will decrease over time as
more flags are added; but the chance of having buggy userspace that
sends down garbage also will.

> [*] Amusing side note, the comment in the header is wrong.  It states "pad
>     the header to 128 bytes", but only pads it to 120 bytes, because union.
> 
> /* for KVM_CAP_NESTED_STATE */
> struct kvm_nested_state {
> 	__u16 flags;
> 	__u16 format;
> 	__u32 size;
> 
> 	union {
> 		struct kvm_vmx_nested_state_hdr vmx;
> 		struct kvm_svm_nested_state_hdr svm;
> 
> 		/* Pad the header to 128 bytes.  */
> 		__u8 pad[120];
> 	} hdr;

There are 8 bytes before the union, and it's not a coincidence. :)
"Header" refers to the stuff before the data region.

> Odds are no real VMM will have issue given the dynamic size of struct
> kvm_nested_state, but 

... *suspence* ...

Paolo

