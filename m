Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26D3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD14A20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg9mY3bf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgG0Lnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:43:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgG0Lnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595850220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fj8z1m818DDGkVImIUhwVP/NDjsB0jy0U2cJeVkzmBs=;
        b=fg9mY3bfKpiBXrf4XzzMYKgMC2vdMSrV1//q2xovEHXRn//prfNeoD/yRhcyTPz7Tyt1fr
        CFRuewyi1zsxJ7L8pQGXVdLAsAPAZVhMwypbX1V9W8m/WbibzTR/vdSv60j4AFZpxwtIrD
        NkJrex9pOF29nxQstO0eSLlgsn4LOB8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0SXGWZF0P8Wa1nNjWjejyg-1; Mon, 27 Jul 2020 07:43:37 -0400
X-MC-Unique: 0SXGWZF0P8Wa1nNjWjejyg-1
Received: by mail-wr1-f70.google.com with SMTP id z12so3843739wrl.16
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 04:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Fj8z1m818DDGkVImIUhwVP/NDjsB0jy0U2cJeVkzmBs=;
        b=CAbQiCLAil8zb+jrAZrzX/Ab76qYRTK78NmnFq3elAnGOT6h41s0e7U/USUxFW7M+U
         xnXxGf5/CKcrMDMhKJk/0Gbo09heKyQdGoOAMt/G3cna87mmexosOi6hroSTyYNHNiku
         5umBzZlqGGvR1IakYo0B5++iOH3baBulgYb4NUqnZjaCBuMLEpRj7w39yJesGJDajjfy
         mr26Yt//5ti35qbgDWJirfoF5cvoJghWYrYvF9ApobEe2z0Cv8n5Mqjc/xSYK95Sx1ky
         Y2/ZrNNZ1F2h0uqmmsnJlA/wYBEHE/qGY9AwKBm68o1x8mimEosDlEWL+TqG/hthWU6D
         Xjiw==
X-Gm-Message-State: AOAM5331Ap3eE+5vFm2lKvW6sO9dP8Lu57KGhL9WTT+SPyoWma5nzHrX
        VZxLgrbxP79pwQsTIgQgy6cPL1ws9NslQw1NLhrPZTfArApf0NdS9xV4w/m0bdhbnWv1ogBNlOP
        hhmLNvzsSuPtvQ9COMUq96RVa
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr7502920wmf.65.1595850215566;
        Mon, 27 Jul 2020 04:43:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxw1DFiLxTBnx0dQkBfP08qqXab6djnIi+darp7HN96pmEh9Ssi7B4w9eJAMu1Apm8wi3pLdA==
X-Received: by 2002:a1c:1f8b:: with SMTP id f133mr7502892wmf.65.1595850215283;
        Mon, 27 Jul 2020 04:43:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4502:3ee3:2bae:c612? ([2001:b07:6468:f312:4502:3ee3:2bae:c612])
        by smtp.gmail.com with ESMTPSA id f17sm19698789wme.14.2020.07.27.04.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 04:43:34 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: properly pad struct kvm_vmx_nested_state_hdr
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200713082824.1728868-1-vkuznets@redhat.com>
 <20200713151750.GA29901@linux.intel.com>
 <878sfntnoz.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <85fd54ff-01f5-0f1f-1bb7-922c740a37c1@redhat.com>
Date:   Mon, 27 Jul 2020 13:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <878sfntnoz.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/20 17:54, Vitaly Kuznetsov wrote:
> Which means that userspace built for the old kernel will potentially send in
> garbage for the new 'flags' field due to it being uninitialized stack data,
> even with the layout after this patch.

It might as well send it now if the code didn't attempt to zero the
struct before filling it in (this is another good reason to use a
"flags" field to say what's been filled in).  I don't think special
casing padding is particularly useful; C11 for example requires
designated initializers to fill padding with zero bits[1] and even
before it's always been considered good behavior to use memset.

Paolo

[1]  It says: "If an object that has static or thread storage duration
is not initialized explicitly, then [...] any padding is initialized to
zero bits" and even for non-static objects, "If there are fewer
initializers in a brace-enclosed list than there are elements or members
of an aggregate [...] the remainder of the aggregate shall be
initialized implicitly the same as objects that have static storage
duration".

