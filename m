Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93C5C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4082168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYl0w06g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgBLTTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:19:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27810 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728930AbgBLTTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581535170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALtsPsHoJJ/yr/NY82gjbpHubR4mBebZy4GAbdTJqzM=;
        b=dYl0w06gTBlDDuT/cwWaN8yaKoSNW/BKDCotNM1A4GQlMXjT5omgzcVMP735cpxaRGILsU
        Mdb7zKn3rGpVoGjSmK2sKAOjyrxAAJD1288G0yem2c01VsW1W8dYHmrOCQblur2wBUbfP+
        I/a7E+7JWVDqkP8q69ykX16/LXIkilw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-lkLT1y3OPRWFrdghI_P21g-1; Wed, 12 Feb 2020 14:19:28 -0500
X-MC-Unique: lkLT1y3OPRWFrdghI_P21g-1
Received: by mail-wm1-f70.google.com with SMTP id f66so1349057wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 11:19:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALtsPsHoJJ/yr/NY82gjbpHubR4mBebZy4GAbdTJqzM=;
        b=kzyIhGeBCiigoHxnNU2YwMZp5/Bgj3rgP+LrSyLr/T8uW601uxfG/IKnOnslCldYeq
         AXniIdM+ZA/Cdz7s0UDyQZ9gsQLQtzwLlYeFhyePK210pQl18FeZc6V5TmlPbojSS6d3
         fkWj+07jeF/MSRJOMMwLYpCXUugpm/d8EeZDZeDQRpOJNfe9O+xXIAKNlNc8BqlekJQ5
         YS/UA/bXAAm30wbtCx4iIEDJoT3no9snyM7rRW+rg2Wr7bPTd7b5X0ygzuT0cTCVXdFO
         tpZmpMJsxtzOJ9kS81mw3FvVedwqE37mOpxkcbZYKh2TvbLAhcQMGSFI9/C3zYWBzL/r
         Ibqg==
X-Gm-Message-State: APjAAAX9DMWPB2JFmqmXwpfCZfs5RJ67AiucBjtTx8vL3urmj/N5yfTM
        GeIQaiSbpY1EZmwupqnsg/bpPa0k+D9+EDYFOh23Lt1Hi7N9mag1Lpa7rvkHpqPyy+Hygv9bF1/
        pMs+ZN6r0bejkLcCE6Xj1vc8V
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr560742wma.31.1581535167688;
        Wed, 12 Feb 2020 11:19:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqyeyaA14PxiDCO4uOSF5JvBIm+xF1sF2jVONkZ/53zgfRVuwKC20eBEA1OtGwEYi/yLlQpFbg==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr560716wma.31.1581535167364;
        Wed, 12 Feb 2020 11:19:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id d204sm1919873wmd.30.2020.02.12.11.19.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:19:26 -0800 (PST)
Subject: Re: [GIT PULL] KVM changes for Linux 5.6-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Oliver Upton <oupton@google.com>
References: <20200212164714.7733-1-pbonzini@redhat.com>
 <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b90a886e-b320-43d3-b2b6-7032aac57abe@redhat.com>
Date:   Wed, 12 Feb 2020 20:19:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wh6KEgPz_7TFqSgg3T29SrCBU+h64t=BWyCKwJOrk3RLQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/20 19:53, Linus Torvalds wrote:
> It doesn't even compile. Just in the patch itself - so this is not a
> merge issue, I see this:
> 
>           int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
>   ..
>   @@ -1599,6 +1599,40 @@ static int skip_emulated_instruction(struct
> kvm_vcpu *vcpu)
>   ..
>   +static void vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
>   +       return skip_emulated_instruction(vcpu);
>   ..
>   -       .skip_emulated_instruction = skip_emulated_instruction,
>   +       .skip_emulated_instruction = vmx_skip_emulated_instruction,
> 
> ie note how that vmx_skip_emulated_instruction() is a void function,
> and then you have
> 
>          return skip_emulated_instruction(vcpu);
> 
> in it, and you assign that garbage to ".skip_emulated_instruction"
> which is supposed to be returning 'int'.

Indeed I missed the warning.  Of course the return value is in %rax so,
despite the patch being shitty (it is), it is also true that it
*happens* to pass the corresponding unit test.

Not a particularly high bar to clear I admit, but enough to explain the
mistake and ensure it doesn't happen again; I have now added "ccflags-y
+= -Werror" to the KVM makefile.

> So this clearly never even got a _whiff_ of build-testing.

Oh come on.

> You're now on my shit-list, which means that I want to see only (a)
> pure fixes and (b) well-tested such. Nothing else will be pulled.

Fair enough, I removed the following patches from the pull request and
will resend:

 KVM: nVMX: Emulate MTF when performing instruction emulation
 KVM: nVMX: Rename nested_ept_get_cr3() to nested_ept_get_eptp()
 KVM: nVMX: Rename EPTP validity helper and associated variables
 KVM: nVMX: Drop unnecessary check on ept caps for execute-only
 KVM: Provide kvm_flush_remote_tlbs_common()
 KVM: MIPS: Drop flush_shadow_memslot() callback
 KVM: MIPS: Replace all the kvm_flush_remote_tlbs() references
 KVM: MIPS: Define arch-specific kvm_flush_remote_tlbs()

The first one is a bug fix, but since it's the one that caused all the
mess I guess it's not really a good idea to argue about it.

Paolo

