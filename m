Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C0CC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00697207BB
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 09:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cNZLA23C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgH3Jwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 05:52:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58458 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbgH3Jwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 05:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598781163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=shLz+NHIQw6ehBccBaS6HwdyHsjPr6eHCbl/kzv3/W0=;
        b=cNZLA23CbaxUrHcgy8/MkBgwwkGcf+fLwUeyMy97dh+cF0rUDxmnM8zrMRmGJhXzoCrGYM
        WEZRL+Uqr9GAU5c9/S3YMGuNK4IRCJa/kCnVG0NvsxjCMYopWp7HtaWHauqs367drVSRiz
        xB8qOcefZ7jyZw+NfNEpYYUpCIlBOOg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-UhJQaOaHNNq6GJjACYuQbA-1; Sun, 30 Aug 2020 05:52:41 -0400
X-MC-Unique: UhJQaOaHNNq6GJjACYuQbA-1
Received: by mail-wm1-f70.google.com with SMTP id d5so588264wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 02:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shLz+NHIQw6ehBccBaS6HwdyHsjPr6eHCbl/kzv3/W0=;
        b=AEFApAN3wMSXShw56gyGuw+AXbNVXPqo9iqLS0FYjOK51nRwzEZAlna6IAMl8OASpf
         a/FQvYxkeYmgGE5HbJ4DQuGbYV6aOxEv2mqh5U9W5biUgtZqVbL4eeCgeFVflJZdxwVB
         k1P7KhWM1dPwSzWwikAnFuITWN+dbM+AEpceurhfo161a9G43R2f7+v4fiRDf35RVjem
         0q+8WJGNbGVKJgd1MkAjfehQqLWi0QKNoUujv7vvrU8TCx63FwrNr3FAdpOxeMR6R4kT
         TOJzGiVnyNGQRFc7oUUOhQcdPLLd9PcBnNy3f1gKOxSrtcEincwi97vZZFxN/F5hD58P
         kGjw==
X-Gm-Message-State: AOAM532WQzVIjW+WcfcujXUAHeH6xizD6C6D7Kh1/fqho8PBdBAx/36s
        /+rNGSl0fkcJWbpYCV1LJQEbz26Bgfx/lZvknI5cNRjradZEkCPSOH1AEyNSW1p6vAe71mqQG1K
        pFAolpzZfR7LX5mVKYPoQCevE
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1674900wmg.137.1598781160436;
        Sun, 30 Aug 2020 02:52:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu3YdiiJZJIOOb9YNtA+ULjbymzyuHXduF3D7yxpxJzNd5MhrgTQiao4swsuBo5MOq0oLLYw==
X-Received: by 2002:a1c:e256:: with SMTP id z83mr1674885wmg.137.1598781160243;
        Sun, 30 Aug 2020 02:52:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9d8:ed0a:2dde:9ff7? ([2001:b07:6468:f312:9d8:ed0a:2dde:9ff7])
        by smtp.gmail.com with ESMTPSA id q6sm6274965wmq.19.2020.08.30.02.52.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Aug 2020 02:52:39 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: nVMX: fix the layout of struct
 kvm_vmx_nested_state_hdr
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200713162206.1930767-1-vkuznets@redhat.com>
 <CALMp9eR+DYVH0UZvbNKUNArzPdf1mvAoxakzj++szaVCD0Fcpw@mail.gmail.com>
 <CALMp9eRGStwpYbeHbxo79zF9EyQ=35wwhNt03rjMHMDD9a5G0A@mail.gmail.com>
 <20200827204020.GE22351@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ba02f98-045d-a089-cb7e-8d0b613f76e7@redhat.com>
Date:   Sun, 30 Aug 2020 11:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200827204020.GE22351@sjchrist-ice>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/20 22:40, Sean Christopherson wrote:
> Paolo pushed an alternative solution for 5.8, commit 5e105c88ab485 ("KVM:
> nVMX: check for invalid hdr.vmx.flags").  His argument was that there was
> no point in adding proper padding since we already broke the ABI, i.e.
> damage done.
> 
> So rather than pad the struct, which doesn't magically fix the ABI for old
> userspace, just check for unsupported flags.  That gives decent odds of
> failing the ioctl() for old userspace if it's passing garbage (through no
> fault of its own), prevents new userspace from setting unsupported flags,
> and allows KVM to grow the struct by conditioning consumption of new fields
> on an associated flag.

In general userspace (as a hygiene/future-proofing measure) should
generally zero the contents of structs before filling in some fields
only.  There was no guarantee that smm wouldn't grow new fields that
would have occupied the padding, for example.  The general solution we
use is flags fields and checking them.

(The original KVM_GET/SET_NESTED_STATE patches did add a generic flags
fields, but not a VMX-specific one field).

Paolo

