Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58EC35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B9C21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhDOg00k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgBYNLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:11:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52800 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgBYNLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:11:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582636281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrvIza9mOSZ4BvN1tdCV2aqsL8mIKXTuoDQsYHobl7Q=;
        b=JhDOg00kiFCxaR6G9w1rjs1+2nBr49q+lu7R4YXAh0mDUGIz5qd53S54Xvo+fkSFlvYyuE
        /xDc/tE76WBcGg73dwdzcbAkPbERulCNO/rFgzH7czhjC8WAj4PWLUNPH5H9WOaj2cduMn
        f6UHzyW2kt/t9hXdOqwpINgJIvbaOLY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-JZvQRT5OMCCtVB_2acBDEA-1; Tue, 25 Feb 2020 08:11:20 -0500
X-MC-Unique: JZvQRT5OMCCtVB_2acBDEA-1
Received: by mail-wr1-f69.google.com with SMTP id o6so7256897wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SrvIza9mOSZ4BvN1tdCV2aqsL8mIKXTuoDQsYHobl7Q=;
        b=i7WqZP6IV21mPv8eSckwaoop9kSeH8pp7opmScnjZCos3OIDUjyDnK7EpBYuwmfjQJ
         yyhEOoPX3tZ0AnaAOe6dw23dzxuscFmIlpM1LLuD7zFr5C/KdIwJeKv1l0AZcJSB2oRw
         AlUjhFxm86ZWpGeoa3CnutQgo3Lf7PJqWzfaLzKp2E+u4CMSa4HAa+oe+/Ndqsvq4mSH
         GSo3YMJhG6TwUjtb0FlV8RbY9564+8zGz6ZuGE4HsbLT03d4e7ci4CKJt0CwRxny4rdU
         sPXdoCNsjGZm3D7KJy7YkpRShlWl8WtQPLnFX+cU8f+wbEhXg+sCFG67FnIBvECzUmqg
         0DUg==
X-Gm-Message-State: APjAAAV7+lZPV+c+yFJax5qpSuqqqc6JlTapCI5khwdINlIS4DYoWMbe
        BeUCZ60T5CchY28fX1S/mE+Rij6zG5LVgiDWi4qIrivw0cgLnhOfUt2bvbNLMq7UE0QnbAIxIw9
        91JU3KhfkVw5iqdIa07deR+0a
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr74647039wro.263.1582636279021;
        Tue, 25 Feb 2020 05:11:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqxpadiCu4wJadbmfz9YW8gpthFBOSPDdgS5RXo5AREoIYALFfuLJhgF1HiTZB17D3Z3e8IlUg==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr74647024wro.263.1582636278846;
        Tue, 25 Feb 2020 05:11:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a26sm4057339wmm.18.2020.02.25.05.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:11:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] kvm: vmx: Use basic exit reason to check if it's the specific VM EXIT
In-Reply-To: <716806df-c0e4-43d5-b082-627d2c312f53@oracle.com>
References: <20200224020751.1469-1-xiaoyao.li@intel.com> <20200224020751.1469-2-xiaoyao.li@intel.com> <87lfosp9xs.fsf@vitty.brq.redhat.com> <d9744594-4a66-d867-f785-64ce4d42b848@intel.com> <716806df-c0e4-43d5-b082-627d2c312f53@oracle.com>
Date:   Tue, 25 Feb 2020 14:11:16 +0100
Message-ID: <877e0an763.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krish Sadhukhan <krish.sadhukhan@oracle.com> writes:

>
> We have a macro for bit 31,
>
>      VMX_EXIT_REASONS_FAILED_VMENTRY                0x80000000
>
>
> Does it make sense to define a macro like that instead ? Say,
>
>      VMX_BASIC_EXIT_REASON        0x0000ffff
>

0xffffU ?

> and then we do,
>
>      u32 exit_reason = vmx->exit_reason;
>      u16 basic_exit_reason = exit_reason & VMX_BASIC_EXIT_REASON;
>

Just a naming suggestion: if we decide to go down this road, let's name
it e.g. VMX_BASIC_EXIT_REASON_MASK to make it clear this is *not* an
exit reason.  

-- 
Vitaly

