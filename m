Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2495C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9823A2084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIKx0pE3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFKAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:00:18 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54625 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgCFKAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:00:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583488817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AVZKZRodnT8m61EYZkSnJRTdxqQpltbB/y6KfgTIT1g=;
        b=gIKx0pE3ayOl+1aP25PpEwEthcB4DRRm00Ge3I8PzBP96wlK1r5WxeLP5UoX7pc7WyvuuD
        7IZSBbuMKfR3XVt6NnzvItQhuwVoBqKHlolzOz+i1LRZMB8e4WjcnJokrh6UHgsuLIuxdA
        AqNYGPeMxs58SHZ15xkmp9UKLTLLSbk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-tC2jjpZ8PDGfgE4KKz_Ljg-1; Fri, 06 Mar 2020 05:00:16 -0500
X-MC-Unique: tC2jjpZ8PDGfgE4KKz_Ljg-1
Received: by mail-wm1-f69.google.com with SMTP id m4so682727wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:00:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AVZKZRodnT8m61EYZkSnJRTdxqQpltbB/y6KfgTIT1g=;
        b=YdZ+5SRqPc3M5IzRVllTYOK+vtsOJnbOABP4XVkJs2vb+gqcDndwdVz/OVgmMZa7IL
         X9JvJkzBhbd4SLqoiVDnhrinBGrP2U3ZzDScgb24EFCwu4JEl4U7fDi5q2muNgFnlpDh
         t7A8LeyTn+AsduB4SaBVQ27MyWWwKA3wQowdixbJpByaRf9vlwPWzPs5D+1BvOM/BuJI
         n2+waQv0vHMXJ7Pm9O5AIEphiVoWeoycGtmaR2fnFqsZQxJSAONDZ3YP9K0u+2KamwTs
         WmfLkMiOctOu/5B+PGXu6VHs1AtS87HKW3RgnnrYsBdtG/XUWV8t+RwIZlD1EYsSLt/j
         xt3g==
X-Gm-Message-State: ANhLgQ05xnx3TE3Rt3lM1dTdei7htCktWTKinGCXf5Y83b3TtKUPgnLB
        +LvllhFhyP4mkRjiNQXARGGKo9KQZTbRGhk0Q7hVTGYV1zcV/D+/6QoM4s+FKyfLsunZO2FHp3L
        newt6ttBRdkijFwW/R4ngtyoi
X-Received: by 2002:adf:ee03:: with SMTP id y3mr3344809wrn.5.1583488814290;
        Fri, 06 Mar 2020 02:00:14 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsV7StFA621WH1U3poGeCCFj5kAbCl4GYqaDAZLKVQ5l065AMt9smou8/Ov0naR1gFtRC+gAw==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr3344781wrn.5.1583488814004;
        Fri, 06 Mar 2020 02:00:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b99a:4374:773d:f32e? ([2001:b07:6468:f312:b99a:4374:773d:f32e])
        by smtp.gmail.com with ESMTPSA id i67sm25991960wri.50.2020.03.06.02.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 02:00:13 -0800 (PST)
Subject: Re: [PATCH] KVM: VMX: Use wrapper macro
 ~RMODE_GUEST_OWNED_EFLAGS_BITS directly
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linmiaohe <linmiaohe@huawei.com>
Cc:     "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
References: <f1b01b4903564f2c8c267a3996e1ac29@huawei.com>
 <1e3f7ff0-0159-98e8-ba21-8806c3a14820@redhat.com>
 <87sgiles16.fsf@vitty.brq.redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cde5e91-b357-81f9-9e39-fd5d99bb81fd@redhat.com>
Date:   Fri, 6 Mar 2020 11:00:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87sgiles16.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/20 10:44, Vitaly Kuznetsov wrote:
>>> Define a macro RMODE_HOST_OWNED_EFLAGS_BITS for (X86_EFLAGS_IOPL |
>>> X86_EFLAGS_VM) as suggested by Vitaly seems a good way to fix this ?
>>> Thanks.
>> No, what if a host-owned flag was zero?  I'd just leave it as is.
>>
> I'm not saying my suggestion was a good idea but honestly I'm failing to
> wrap my head around this. The suggested 'RMODE_HOST_OWNED_EFLAGS_BITS'
> would just be a define for (X86_EFLAGS_IOPL | X86_EFLAGS_VM) so
> technically the patch would just be nop, no?

It would not be a nop for the reader.

Something called RMODE_{GUEST,HOST}_OWNED_EFLAGS_BITS is a mask.  It
tells you nothing about whether those bugs are 0 or 1.  It's just by
chance that all three host-owned EFLAGS bits are 1 while in real mode.
It wouldn't be the case if, for example, we ran the guest using vm86
mode extensions (i.e. setting CR4.VME=1).  Then VIF would be host-owned,
but it wouldn't necessarily be 1.

Paolo

