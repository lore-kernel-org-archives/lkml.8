Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66706C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3913C2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:04:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PQsg+Bbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgHQSEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:04:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32062 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389200AbgHQSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 14:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597687268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qqyeS+9IC/amrYQ+e7XmNFqASQdZw1AwC4c5vP7yh44=;
        b=PQsg+BbxauN/n0Y3p31bBK5eG4PPqwD5SC9JZ9uhV47nCLqEX5N4fYuKaADqSQPi5D60j0
        Tf8jD8QDLM5BIPmt9Dc/eEPwI0UF8/A697waTEF7OnLTkz0sz2YYKVhKTySQk4QoYIMDi9
        YxJz2Hq+y3lcDtQrPLoLRBZwyjrMiS0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-zjUO3_mCP8-gvQ0r5ogcdA-1; Mon, 17 Aug 2020 14:01:03 -0400
X-MC-Unique: zjUO3_mCP8-gvQ0r5ogcdA-1
Received: by mail-wm1-f71.google.com with SMTP id d22so6292057wmd.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 11:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qqyeS+9IC/amrYQ+e7XmNFqASQdZw1AwC4c5vP7yh44=;
        b=kRtFkA5PbUXwXhCJIcZPELvdeWez5lbtnkabhTp5dtYU93XDa6IYYpH+95X0bkBISl
         wCTySGVOgqIz+rFI18ljq49aFbT4kt/HM5jHXeYzuBItI198xw/71soeeCXx+6tuZoUW
         ygQC9lqbfUe/0mBSMIrMNz5Oawuyos4PX37ls4BOXX1xH7GYg+GhC1yqfHsVmfYGs+kz
         W61g+mmerkPwxKdmDlzlbHrViLeil/h6nNLom1t6P3xcCmerRQC8bSxDOtNdeMe6DGDo
         Kwzx5ylFRsoJThCdecIz341Rw3sgT2QR9MDvTDCv7E9Iqb51YXlCTsnLrchdjpT/3qaL
         xOVA==
X-Gm-Message-State: AOAM531il2hFby/D5jCcGoxDlhfWRwmtdcWY7P230ZI7p5mPKtdRWJNk
        CKg34nBEBXPnYXMmx+Y2m0Sx25ghZ6WBuEbdkn6QsoYT1sPD56hNwFBFUKtv/F1zFEA6vXfDD1E
        jr0Xe8rfGz628xDFMEOgA0Nfe
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr16354149wrt.91.1597687262366;
        Mon, 17 Aug 2020 11:01:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAhxieT6QpX/fLPoPSTQkaGqwRYwftZmk8+5FwC8rtE7g/Sg70OBuAvNPg+GbA63ZR+JjROg==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr16354132wrt.91.1597687262126;
        Mon, 17 Aug 2020 11:01:02 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0d1:fc42:c610:f977? ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
        by smtp.gmail.com with ESMTPSA id a10sm31354680wro.35.2020.08.17.11.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 11:01:01 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] KVM: VMX: Add guest physical address check in EPT
 violation and misconfig
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org
References: <20200710154811.418214-1-mgamal@redhat.com>
 <20200710154811.418214-8-mgamal@redhat.com>
 <20200715230006.GF12349@linux.intel.com>
 <20200817172233.GF22407@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f3595331-07e2-55d8-d390-4f421d8e5561@redhat.com>
Date:   Mon, 17 Aug 2020 20:01:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200817172233.GF22407@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/20 19:22, Sean Christopherson wrote:
>> This splats when running the PKU unit test, although the test still passed.
>> I haven't yet spent the brain power to determine if this is a benign warning,
>> i.e. simply unexpected, or if permission_fault() fault truly can't handle PK
>> faults.

It's more or less unexpected; the error is in the caller.  This is not
an error code but an access mask so only U/F/W bits are valid.  Patch
sent, thanks.

Paolo

>>   WARNING: CPU: 25 PID: 5465 at arch/x86/kvm/mmu.h:197 paging64_walk_addr_generic+0x594/0x750 [kvm]
>>   Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS WLYDCRB1.SYS.0014.D62.2001092233 01/09/2020
>>   RIP: 0010:paging64_walk_addr_generic+0x594/0x750 [kvm]
>>   Code: <0f> 0b e9 db fe ff ff 44 8b 43 04 4c 89 6c 24 30 8b 13 41 39 d0 89
>>   RSP: 0018:ff53778fc623fb60 EFLAGS: 00010202
>>   RAX: 0000000000000001 RBX: ff53778fc623fbf0 RCX: 0000000000000007
>>   RDX: 0000000000000001 RSI: 0000000000000002 RDI: ff4501efba818000
>>   RBP: 0000000000000020 R08: 0000000000000005 R09: 00000000004000e7
>>   R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
>>   R13: ff4501efba818388 R14: 10000000004000e7 R15: 0000000000000000
>>   FS:  00007f2dcf31a700(0000) GS:ff4501f1c8040000(0000) knlGS:0000000000000000
>>   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>   CR2: 0000000000000000 CR3: 0000001dea475005 CR4: 0000000000763ee0
>>   DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>   DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>   PKRU: 55555554
>>   Call Trace:
>>    paging64_gva_to_gpa+0x3f/0xb0 [kvm]
>>    kvm_fixup_and_inject_pf_error+0x48/0xa0 [kvm]
>>    handle_exception_nmi+0x4fc/0x5b0 [kvm_intel]
>>    kvm_arch_vcpu_ioctl_run+0x911/0x1c10 [kvm]
>>    kvm_vcpu_ioctl+0x23e/0x5d0 [kvm]
>>    ksys_ioctl+0x92/0xb0
>>    __x64_sys_ioctl+0x16/0x20
>>    do_syscall_64+0x3e/0xb0
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>   ---[ end trace d17eb998aee991da ]---
> 
> Looks like this series got pulled for 5.9, has anyone looked into this?
> 

