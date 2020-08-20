Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7B0206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWAnRGtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgHTK4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:56:49 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730638AbgHTK4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597921000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YyUbWiVt+/pd6NCJLIhu4YVJj7CJ58kl1EyN+2zcEbc=;
        b=UWAnRGtXTK3s66cnQZSThr8J8neiyuiL+INDKpacViA8/6lHekSE+595gdGTKy7IFf3btS
        lcyu9map2/U88NeLkUHtAU7faoL60XW0y8Vp3QgWRBlWkasZeCzMm3tdMEgYddH/SnbV7Z
        tiJK7sIhfDkJ2HevnF02EpL8lKOs7DU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-AUaUt2zkM4yyczV2Gqu5YA-1; Thu, 20 Aug 2020 06:56:38 -0400
X-MC-Unique: AUaUt2zkM4yyczV2Gqu5YA-1
Received: by mail-wm1-f70.google.com with SMTP id d22so654145wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyUbWiVt+/pd6NCJLIhu4YVJj7CJ58kl1EyN+2zcEbc=;
        b=np64JnKamIW09YFSEl+J6ZSz5IfPntQL6ml3lTry+pYNNM0vRDdNtC09/tf8rbjYQA
         9/Pf3V/AU8bQ/yOjB3R0ilfCd/vvcFZBQAHoC0/Dmf7Zo81jL7VdaMy0DdGceiMx1A1R
         sUTr/oDgV7rFlJG1sL5hKlu0CysJjv9CJdEzVsdyaI0tlSvY7xkArjzwk9yWFdpgdKU5
         K5azG4lOmSErhOo2Ir6bf/bAY+j7c21Zoc0XQdyalfu70S3PK8CEU2ISP3+ClhB4I1N1
         Pgcrzm9oNu83oPogF6BgG388tpDzIwuTF0xEbmCOYv2MYhR4Sjp8rPCzaDZ1hIH5vwuL
         T5QQ==
X-Gm-Message-State: AOAM532doz4xlxhHeIUDSGXqlYp0lzNUQBv2zwpTVe3Uq0YdQal28cf0
        lS5R6bEBTEUFRfALhVLMz31FPopSes0HNWOd4CEcOwFaL67aeZexhoBm8rkGSMWejCXC0sxS2p8
        dYMT+wsDLnRWa4G2kL1FObM8Y
X-Received: by 2002:a1c:7f17:: with SMTP id a23mr2873503wmd.28.1597920997679;
        Thu, 20 Aug 2020 03:56:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz4y78/vex3lvu61KJP6j3mDCaLwnKwb2xiZYks8rpAtkPmpBciNL88mgoiDLwRjYGmwwlnw==
X-Received: by 2002:a1c:7f17:: with SMTP id a23mr2873484wmd.28.1597920997427;
        Thu, 20 Aug 2020 03:56:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id t14sm3842691wrg.38.2020.08.20.03.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:56:36 -0700 (PDT)
Subject: Re: [PATCH 2/8] KVM: nSVM: rename nested 'vmcb' to vmcb_gpa in few
 places
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
 <20200820091327.197807-3-mlevitsk@redhat.com>
 <f6bf9494-f337-2e53-6e6c-e0b8a847ec8d@redhat.com>
 <608fe03082dc5e4db142afe3c0eb5f7c165f342b.camel@redhat.com>
 <2e8185af-08fc-18c3-c1ca-fa1f7d4665dd@redhat.com>
 <2b8faaead6f7744dc10b4701bd1583a2b494d4f4.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3effc656-20e8-40c9-d0e3-5c700d9b5572@redhat.com>
Date:   Thu, 20 Aug 2020 12:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <2b8faaead6f7744dc10b4701bd1583a2b494d4f4.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 12:23, Maxim Levitsky wrote:
> I fully agree that adding local variable is a good idea anyway.
> 
> I was just noting that svm->nested.vmcb is already about the nested
> (e.g vmcb12) thus I was thinking that naming this field vmcb12 would be
> redundant and not accepted this way.

We want to have both svm->nested.vmcb12 and svm->nested.vmcb02 in there,
and hsave is also a VMCB of sort (somewhat like a vmcb01 that is only
used while running a nested guest).  So it is clearer to write _which_
vmcb it is, and it also helps by making terminology consistent between
VMX and SVM.

Paolo

