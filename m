Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48277C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2829A206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EoRIJCZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgDUNip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:38:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46569 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728786AbgDUNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587476323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LEkmEchC7I6Vap+POG7SrCstDGTOmfDnvgVnpaVVqk0=;
        b=EoRIJCZpLtBSoreadek2bJaY7n8tLDc3usSGlQaN4Q3Qb1wgLV3s5fRRKvz/i7vvvYWH9j
        mpik2VG4C+VTyFBVC00kPCQrs5g31fPeNydaPVsl92MkxAIFEAjizGBB2pFWc0Sx33ALAb
        /sqzEwHzgLVmsKnSO7bII0PsY0F2wVI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-hfN_2UzvNp2qIToTwFQxOA-1; Tue, 21 Apr 2020 09:38:41 -0400
X-MC-Unique: hfN_2UzvNp2qIToTwFQxOA-1
Received: by mail-wr1-f70.google.com with SMTP id g7so6606639wrw.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LEkmEchC7I6Vap+POG7SrCstDGTOmfDnvgVnpaVVqk0=;
        b=Df+XJniRCvuktK/jeNnxxdvtuEdLbW3T1YOHX6Cy1BL7u53x7o9WLRX6D7kXCkDeIB
         U/gWUfSnH+gJDJzuoUOErPgukeUjqBZscYtV7wttRLaAp50XCiCR3uWA29lgw4J3umEJ
         NYm8hl6WtqucbJOAhWUyjE6Utwss84buoz4Pmbx67csEUE8S0RIPQ5i1ZsWFQSEFw/ZC
         DtFYF1roA4Cqyy8ORWvR0r3+s0uuVPgdD3I7c89b+28QfHEgG3cXyHeF//7UMfZrVIpH
         z3pnwD2SOyFr+aX94dUt3RbNiR2WEkFBdc6O1yzKaV+FNYBNqS1dBVJ8VuqNIKaHxfB3
         Xw/Q==
X-Gm-Message-State: AGi0PuaP1ggFHMPmcF+EB0GyE3o0J4esIvnEctE47Yr6P7OhN9PtDUlc
        5N5K3nQY+VLl+Rsfl8VuwdFZG1KZOvti/zj31+g5aib0CSMjHJCsu51xcs8AjHc6GTK/rpx+pSV
        UcpeJuXC4J+pKwmwox5cveD06
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr24315811wrs.415.1587476320532;
        Tue, 21 Apr 2020 06:38:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypKGek4tZqkiTucU3V8cPDTVi9zZurddNwoKPsBF0EAMyszVMjHpOEpUuGJxWg6voWo+68yGKQ==
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr24315782wrs.415.1587476320320;
        Tue, 21 Apr 2020 06:38:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id k9sm3741361wrd.17.2020.04.21.06.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 06:38:39 -0700 (PDT)
Subject: Re: KASAN: out-of-bounds Write in nested_sync_vmcs12_to_shadow
To:     syzbot <syzbot+6ad11779184a3afe9f7e@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <000000000000b77ac905a3c1e81f@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3fed5719-9b30-fe69-9b2d-3584440759d1@redhat.com>
Date:   Tue, 21 Apr 2020 15:38:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000b77ac905a3c1e81f@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 02:15, syzbot wrote:
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+6ad11779184a3afe9f7e@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: out-of-bounds in copy_vmcs12_to_enlightened arch/x86/kvm/vmx/nested.c:1820 [inline]
> BUG: KASAN: out-of-bounds in nested_sync_vmcs12_to_shadow+0x49e3/0x4a60 arch/x86/kvm/vmx/nested.c:2000
> Write of size 2 at addr ffffc90004db72e8 by task syz-executor.4/8294
> 
> CPU: 1 PID: 8294 Comm: syz-executor.4 Not tainted 5.7.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x188/0x20d lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:382
>  __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
>  kasan_report+0x33/0x50 mm/kasan/common.c:625
>  copy_vmcs12_to_enlightened arch/x86/kvm/vmx/nested.c:1820 [inline]
>  nested_sync_vmcs12_to_shadow+0x49e3/0x4a60 arch/x86/kvm/vmx/nested.c:2000
>  </IRQ>

That's a weird stack trace for a reproducer that is doing operations on
/dev/fb0.  What's going on?

Paolo

