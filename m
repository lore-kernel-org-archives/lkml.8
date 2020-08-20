Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC8EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00D5520758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UB4G3768"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgHTMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:20:35 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47938 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729921AbgHTJzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597917335;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jf8gbz8LQopQe0J21yTGM4+cDZmGtIYLJCcRhjeOrR4=;
        b=UB4G3768jo311kVvi91ndf8WfkCNMZI0tbXGq94FtxVsP8v2k57IQdp9rXawNzfXycdsrR
        Ky9khbVd45mCsiJU8FeR5vbqQJY0WD/Aw5AUYNUs7400yyDhEDClZV1kjysdWmPkV4qAfS
        IIbp6yYYv0FFw1YxUEY+k8tnypVF118=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-GRfa2RLmNqiSiRzBIxstPA-1; Thu, 20 Aug 2020 05:55:34 -0400
X-MC-Unique: GRfa2RLmNqiSiRzBIxstPA-1
Received: by mail-wr1-f72.google.com with SMTP id r14so471704wrq.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 02:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jf8gbz8LQopQe0J21yTGM4+cDZmGtIYLJCcRhjeOrR4=;
        b=DnEa6edBYyAwScKT9fwjz2drP9CzWJGc8CUlIxp6Eu4TfsEZaapL+SvY/ME+lcBTWE
         N3FFAfX0jPDg6hZNrg+pnBmxo9JK/4qtWgw+exv1P6GidHnmV5+du6bRELB+xZkexZd4
         nHl1q21r31s/lUGcXBbjqScxBC557pMK0xXpTRjgoaPt51BbLTs4oekJhaeeYJ7NchQW
         Q7ZorjvXghWVKQX3v35CR/o/ajC4DEMp4Ccis2HUtniEt5ux8r/AybXdPeDkTzRpOptW
         JhK77Kw2HlRkwiVutf1msVuK3YWp3YMhE6bJcDGwcYPAJP6u3iZrv8FMiczPeT3vZ5Lk
         VugQ==
X-Gm-Message-State: AOAM5302I+DsiYhe9CC1y/hmpD8/S9RMtk+dDztshWrJZkYV9Cci+/8k
        jZzTZpQaLZ5N4SrpG4EyOTvcmMYhkykpwGhD9nwSkL8HqoUHnGQXqbeXQZFCw2IYiivg3vKVgSK
        /9HEa9viqk4r+dh+B0NBAEuT9
X-Received: by 2002:a1c:e244:: with SMTP id z65mr2712572wmg.34.1597917332842;
        Thu, 20 Aug 2020 02:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7+uOoYVXeIwgWOAsbxvSNBUeYTbpN+9/M9HQCIj4IkWFjHWhPfBPnCwQmglmYgMwvO0mang==
X-Received: by 2002:a1c:e244:: with SMTP id z65mr2712561wmg.34.1597917332571;
        Thu, 20 Aug 2020 02:55:32 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id g145sm4323729wmg.23.2020.08.20.02.55.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 02:55:32 -0700 (PDT)
Subject: Re: [PATCH 8/8] KVM: nSVM: read only changed fields of the nested
 guest data area
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20200820091327.197807-1-mlevitsk@redhat.com>
 <20200820091327.197807-9-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <766e669d-9b0b-aad6-b1d2-19ef77cbb791@redhat.com>
Date:   Thu, 20 Aug 2020 11:55:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200820091327.197807-9-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 11:13, Maxim Levitsky wrote:
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 06668e0f93e7..f0bb7f622dca 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3924,7 +3924,7 @@ static int svm_pre_leave_smm(struct kvm_vcpu *vcpu, const char *smstate)
>  		if (kvm_vcpu_map(&svm->vcpu, gpa_to_gfn(vmcb_gpa), &map) == -EINVAL)
>  			return 1;
>  
> -		load_nested_vmcb(svm, map.hva, vmcb);
> +		load_nested_vmcb(svm, map.hva, vmcb_gpa);
>  		ret = enter_svm_guest_mode(svm);
>  

Wrong patch?

Paolo

