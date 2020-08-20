Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A66C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7DD720658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hNqLU63Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgHTKee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:34:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52437 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731375AbgHTKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597918760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=34Fudio4VU2L9NDM258KSxl3iDnftB/ysyHG0W39VZc=;
        b=hNqLU63ZEFUtY+a5phIHdRevvjdrctzYsDmXOtuPFzx8oRidBr5vqmWltvX03guLVZikiD
        /c9h6/BXPeL4ka5pnQ3RXiEZ6hjbuJxhGjLOJHCZpMjxioU0jPPFQcn+yYqvz+qrnGLQv/
        jXW710cJeMNBEr6uGxJ+WWn4jwLBPXQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-8W1XISl7NPq1Q9aswYW3ug-1; Thu, 20 Aug 2020 06:19:19 -0400
X-MC-Unique: 8W1XISl7NPq1Q9aswYW3ug-1
Received: by mail-wm1-f70.google.com with SMTP id h7so612325wmm.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 03:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34Fudio4VU2L9NDM258KSxl3iDnftB/ysyHG0W39VZc=;
        b=nRhLfiA7BQv923UZjE8kREyCTNPdItSeIXfn0N4/zJ/sqFaZJrzolv1RpqJaTrnJ4v
         ZHJ0J5M7SWabxlggmI3X4V1oaHLb+DGbddvSwY0VWu7jdQGnoh5vBFpFyU7S6oyb7Mgn
         X46A4sI73LuyD83w/JU/vrjQxFtFgLvUmOcnFb5apdTPOsb5Ger7fW6BORVLYP0XDx3U
         vbGs3Haw/faefIRX8JcpMIMRPbNUHFBZ9a7/OVj9jPfoEiq6cKoRK1fXnAJlRz6uawnB
         WjioZhsSuRSvvm1hdEcN9SlQGCBi2NFQiVBbnka1z9pmEP2YUtMGeAVAJNPO+4QH2ckh
         KnZQ==
X-Gm-Message-State: AOAM531sCaqHY8RvSO48Tj8cn+aGWjGyyEPYXqa0itxdqSmVqm4hquk9
        b2MVKeGZJcjkZZPSq4lN1AJOYjs8bbizfikeVmALi8JM+gZWTzTZdFAfc2pdT64IDHxYI0urywV
        3LITxr9svQvOBJ5NVelxdpIWu
X-Received: by 2002:a5d:538a:: with SMTP id d10mr2629008wrv.280.1597918757985;
        Thu, 20 Aug 2020 03:19:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcmOd0V2f8YQ+GGOMTGELWjIMpMo5QSR9ODiDyEBM79MegWciDEkcINCLPVWrrTLa38NO7ew==
X-Received: by 2002:a5d:538a:: with SMTP id d10mr2628987wrv.280.1597918757808;
        Thu, 20 Aug 2020 03:19:17 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id d11sm3113354wrw.77.2020.08.20.03.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:19:17 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2e8185af-08fc-18c3-c1ca-fa1f7d4665dd@redhat.com>
Date:   Thu, 20 Aug 2020 12:19:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <608fe03082dc5e4db142afe3c0eb5f7c165f342b.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/20 12:00, Maxim Levitsky wrote:
>> Please use vmcb12_gpa, and svm->nested.vmcb12 for the VMCB in patch 6.
>>
>> (You probably also what to have local variables named vmcb12 in patch 6
>> to avoid too-long lines).
> The limit was raised to 100 chars recently, thats why I allowed some lines to
> go over 80 characters to avoid adding too much noise.
> 

True, but having svm->nested.vmcb12->control repeated all over isn't
pretty. :)

Since you're going to touch all lines anyway, adding the local variable
is a good idea.

Paolo

