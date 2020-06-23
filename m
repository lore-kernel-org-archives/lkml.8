Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D423FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA7E220723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUj2kzOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732053AbgFWJiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:38:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731786AbgFWJiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592905095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49gqC52SNruUIJgdOHQWjZ/EQ4cGKnvSIHeC7qzdXXc=;
        b=XUj2kzOPO/JItT4O5zzlqQiEauuB/YJm+MSoIAKD0OS/iDop43sMpbipFtCwdtfxOmrYjh
        Y08sB/XQncp9XuyuUM8924b8cAy4fATsCEPqLXSVVk9Z3XRvMbOb+Tnc43cc32atBTPWiM
        cfcmgwS2s8qXkjDFEG8CTRmrzUs1CWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-qJC5RED6Nwa8g7wk2_V8NQ-1; Tue, 23 Jun 2020 05:38:14 -0400
X-MC-Unique: qJC5RED6Nwa8g7wk2_V8NQ-1
Received: by mail-wr1-f71.google.com with SMTP id l3so5392098wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=49gqC52SNruUIJgdOHQWjZ/EQ4cGKnvSIHeC7qzdXXc=;
        b=DVIB9htEKmyNye8enNep4Nq5nzwGWc+jk/m9OufwDVnHDkU9701vgcqipahbOMs4Eg
         HHtfu8txtNVL0aEJPPVi3dUjytSsWY4Txt09DXZNE1Ni85JACtU7W7QCMO7fSvkHGNot
         1PRW1JC4mQx19+Xu3WjYkacwDhoGHr/LlaRK8cI1glYp4rM39F+0wXTkw6Cf2+XVyv+A
         rjVzI2wYIB0mUgQWY0RnkWzPA9kxGPUJq6bb4oUYJfvCauf3RwiG3tkcQgVbM1fdOhXi
         9pSodeShyM8pv8OPwKM16QOAz8pkLXLGuL3ZcKTxPyNceRyRbXJC8xk3pjObRXJ7f9Do
         zegA==
X-Gm-Message-State: AOAM530kpZliBnXdZS4UTn1AJidx1fBgiXZMSxrDhM6dzdHApx6SqUlO
        M2HWTBzs7CNAYcGczuvrzOlQgJN1TNPdlSRavPGKdpYn2XEmLOW7jclq3ALBzyQX71KJcJMqoal
        k1MVq8g8jAMBS1rLJT2hvPDRz
X-Received: by 2002:a1c:4187:: with SMTP id o129mr3125326wma.38.1592905092961;
        Tue, 23 Jun 2020 02:38:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwq/0679MuZvIaPvX1WWewRB4gARTUFIStDzpJ6aOYCG5tFW9wcbNINeQOYcdxwA9/inspg3Q==
X-Received: by 2002:a1c:4187:: with SMTP id o129mr3125310wma.38.1592905092755;
        Tue, 23 Jun 2020 02:38:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:fd64:dd90:5ad5:d2e1? ([2001:b07:6468:f312:fd64:dd90:5ad5:d2e1])
        by smtp.gmail.com with ESMTPSA id n16sm2777677wmc.40.2020.06.23.02.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:38:12 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Wrap VM-Fail valid path in generic VM-Fail
 helper
To:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200609015607.6994-1-sean.j.christopherson@intel.com>
 <CALMp9eQNF0b8q3naibxtKxo=pym554hRoMJ5ro5febzOUBU-=A@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f7f7592-7d6f-b1ac-aa85-e5904865b21a@redhat.com>
Date:   Tue, 23 Jun 2020 11:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eQNF0b8q3naibxtKxo=pym554hRoMJ5ro5febzOUBU-=A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/20 19:54, Jim Mattson wrote:
> On Mon, Jun 8, 2020 at 6:56 PM Sean Christopherson
> <sean.j.christopherson@intel.com> wrote:
>>
>> Add nested_vmx_fail() to wrap VM-Fail paths that _may_ result in VM-Fail
>> Valid to make it clear at the call sites that the Valid flavor isn't
>> guaranteed.
>>
>> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
> 

Queued, thanks.

Paolo

