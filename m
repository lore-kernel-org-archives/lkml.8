Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97085C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF5B20673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJliWuEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgDJSn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:43:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55652 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDJSn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586544238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=muV+cJsdsOKsLWWU/F5WJmj/GF+e031GyF6t6y1qNfQ=;
        b=XJliWuEFkq3UnkzSh5DEJm0o2LalFHs5cv89bQ0x2eSr9bhtbQftcAKn+WOha5jIdP3G+u
        86NqXSH52CepXxNTMWZnJVJ2+2AQ46BrMHOq8+RY2isUTY5frPkgftA3+Zn/y9wrNu3XLo
        H6sVCXBEB9H6ORrqGKlP8frvCEJGOAw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-3XUy1Z7_NKSdqTXSqht4JQ-1; Fri, 10 Apr 2020 14:43:56 -0400
X-MC-Unique: 3XUy1Z7_NKSdqTXSqht4JQ-1
Received: by mail-wm1-f71.google.com with SMTP id o26so1079782wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=muV+cJsdsOKsLWWU/F5WJmj/GF+e031GyF6t6y1qNfQ=;
        b=FPNzHawj8f2d0AzB70tz27gLKNO0xXfKPeXPfesSzC/BPNsJbkSISiklaljLiTaFIP
         XnSpm5hcCv9XLwaSUxBxXfSInBrwvzuTwnsf2x1vzzBQjWStSITBCjx4ZfVc5PTk0SDg
         TFCSRzWd1YTibVrCFsleBXJ9TxPw0ek1TB+XUznGGsdAk2Vh0w6joVab5tzcAWY1AaJz
         Gw1j5xoZMG5j2LHSSYLTiPL/JALfvGnkpanRAVvhb2uSloPTy98lIsvRu+h7GiyFis9T
         Y0DxlWbmRudanyVYcKjt0AcFiWw6YGRY5anMCQk2Kk+AwX6cko02hacv5OM1GoxhRyh/
         58bg==
X-Gm-Message-State: AGi0PuZgX4jYuUAoJ81e2EM0YFTd7VUlmMNa5urPngETEPpiJoERGN3a
        uxevu34xRK83Xtim6DZCoVqCzmA5Wq9mxGc4pvayplSALJP33DBqVweYzUCJ9jO/WfZxwLgyyqQ
        A7dvWGe+OibM7T2uLfNseBFGD
X-Received: by 2002:adf:fc45:: with SMTP id e5mr5496593wrs.427.1586544235733;
        Fri, 10 Apr 2020 11:43:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRX6u3Awun5ouqjbkGartZIXgkX3B2/ELx/x4dsaREKRdnRPWG6TGFHO1CznRrhFt8aqSIWg==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr5496570wrs.427.1586544235489;
        Fri, 10 Apr 2020 11:43:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c938:f991:b948:b0ca? ([2001:b07:6468:f312:c938:f991:b948:b0ca])
        by smtp.gmail.com with ESMTPSA id v7sm3908396wrs.96.2020.04.10.11.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 11:43:54 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: X86: Ultra fast single target IPI fastpath
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haiwei Li <lihaiwei@tencent.com>
References: <f51251cc-885e-2f7a-b18d-faa76db15b87@redhat.com>
 <20200410174703.1138-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7530d71-dd57-5a22-ee34-da65caa3eea8@redhat.com>
Date:   Fri, 10 Apr 2020 20:43:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410174703.1138-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 19:47, Sean Christopherson wrote:
> If that's open-coded in vmx_vcpu_run(), I'm ok with doing the
> fast-IPI handler immediately after the failure checks.
> 
> And fast-IPI aside, the code could use a bit of optimization to
> prioritize successful VM-Enter, which would slot in nicely as a prep
> patch.

Yes, I agree with these.

Paolo

