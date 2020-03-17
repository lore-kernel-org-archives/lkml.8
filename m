Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3108CC5ACD6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB05320757
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XV5ngV7z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgCQRuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:50:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:36612 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbgCQRuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584467412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kZ33/ECBpyu+Myh8NlL2Y8VNV52N9Gf0h2NmxjYXvA=;
        b=XV5ngV7zbcqShpkTBeoVtdgwtzwwSv46xhuIEsn8qCNnE5j9K8YsYtnBWyV5+9UUQxS1i/
        VB+Q7Txce49Ibb2Jf0kcCtO5UQQa+fG23S3z6xJVrLJoUikDzJ8VxBqfhVA35G3E1V7qbE
        Up3CzMuSP3rhYkupRiea4CFtN6noZBw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-jaMTW_ZlOJGKA8d3ydXT_w-1; Tue, 17 Mar 2020 13:50:10 -0400
X-MC-Unique: jaMTW_ZlOJGKA8d3ydXT_w-1
Received: by mail-wm1-f69.google.com with SMTP id a13so54108wme.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kZ33/ECBpyu+Myh8NlL2Y8VNV52N9Gf0h2NmxjYXvA=;
        b=pdFDsFlq2zC6aFvsDqUP3vXxqtqLLyVkXENH4Q0EyFv59YCDFgw2p0qCFFGUVgTWIu
         M96oi64WV6x+p1oGNSxKvFRGJwhnG5jlAjVtbwMl+wCkF1+rWasFm8iU3rBmdHX4zLz6
         5X70fuvNXSMccnKL3z9jtZpHLHLJzl90I/HynYPdEZnfWC3PZcNq/1+TfsZpsbe6zJB1
         Gve5Xjowx2zq+Ifmwtam1mHtmFPRmuUQi21ugLZ7OOskJB3g38YJrn/w+EGf4I4vr51R
         3jdIk4bkB3D7mpP1/5WhaEdBRMEPtHeiT6212hi5fDzMgoO0y5vWBQPNf/f4Q0y1GD9K
         oT1g==
X-Gm-Message-State: ANhLgQ3jBs1mjNTkJ0H+aY5GX1oJm6iigSyHCuQj7cUemIW19FdDWNF/
        GXWHIhjcWFj5j1YCANt2FrMrYuXkh7vzZ1BDo9VMp7X433kWg1l+872WM7i8fpnDPJ2IB7qdr7n
        g9FkXqPTWfWB3Mk8LRlKCW6dV
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr216911wmb.8.1584467409230;
        Tue, 17 Mar 2020 10:50:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtzeQrGSnJfn3mUZPpBZWwtPReAzdcQX+Z/VDKTNHGHTPJT+xIkxueKqU3cPAwKEyy9rHOX+Q==
X-Received: by 2002:a1c:1b0e:: with SMTP id b14mr216894wmb.8.1584467409031;
        Tue, 17 Mar 2020 10:50:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.227])
        by smtp.gmail.com with ESMTPSA id n6sm219707wmn.13.2020.03.17.10.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:50:08 -0700 (PDT)
Subject: Re: [PATCH 09/10] KVM: VMX: Cache vmx->exit_reason in local u16 in
 vmx_handle_exit_irqoff()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com>
 <20200312184521.24579-10-sean.j.christopherson@intel.com>
 <87h7ysny6s.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a37d3348-5584-6a34-adfd-830a075dc236@redhat.com>
Date:   Tue, 17 Mar 2020 18:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87h7ysny6s.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/20 15:09, Vitaly Kuznetsov wrote:
> Sean Christopherson <sean.j.christopherson@intel.com> writes:
> 
>> Use a u16 to hold the exit reason in vmx_handle_exit_irqoff(), as the
>> checks for INTR/NMI/WRMSR expect to encounter only the basic exit reason
>> in vmx->exit_reason.
>>
> True Sean would also add:
> 
> "No functional change intended."
> 
> "Opportunistically align the params to handle_external_interrupt_irqoff()."

Ahah that's perhaps a bit too much, but "no functional change intended"
makes sense.

Paolo

