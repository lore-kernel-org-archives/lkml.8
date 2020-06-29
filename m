Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B190EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC9320656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bvr4JcpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbgF2URY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:17:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47418 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732800AbgF2TaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593459006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h8YsmMSc+uzBm3Tq2wPliCvFYeKmpScCtqag1mgAOwg=;
        b=bvr4JcpPlYQtxmf2w9p804yueqCmImcWAf2GCQVWea977pNyT5MDKvDJWW8hCYiI2gJ7Dw
        rKOgYsp97RI7OX7zqufJUjCP7jk5KoE5+J22JvzD2pUpDaNj52EIPcWvJEAXTDvg7B+1pE
        GNfJh92yIHnIlF9Y2w06Nf1KJ4ycUVM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-m22mztghMl2x5yB5BPQSkw-1; Mon, 29 Jun 2020 11:25:32 -0400
X-MC-Unique: m22mztghMl2x5yB5BPQSkw-1
Received: by mail-wm1-f72.google.com with SMTP id g6so12743524wmk.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h8YsmMSc+uzBm3Tq2wPliCvFYeKmpScCtqag1mgAOwg=;
        b=Lhv6Xh3HBtYSHFfkGrMbctx7W98orIW+ZkJt7po+tz+CBq9qiWtDg7/Xd8o1dVn93h
         Zve7ACHX+NCySfhVVmMQNI3/BaRbYOWWBX1+2LTTdVetEq+C3EOjomqsG0SwRi1WSiFO
         2W/XyUBDvZh94KTXVgy9z2wm910kEPAX9yEJQ2YPn+K1A8vhM+rBJUD2R5hAF+3Vb6tM
         G5tUZtBPudDtdthKfiwq/IIh8mctx2FXAmNSDWJb1QzBYu9RLqduQ8vz/7dfdwKpFxLP
         /KfD0Vtgh1cySOPVKNg2e/fF2gze9xbKnSTY2gTD3t9zUh0fUthDdK3TWG4R28DqS68l
         Ej4g==
X-Gm-Message-State: AOAM532c8NAgk7JvphXGbN5b9ud9+szqjve8H8k3THxlzif75M6gQyNu
        Xl+U0EqE87JxcvjVOOlJLuOigQo19n/i09ZGQjBF8p9SdzcnrvfNOcA6X2Wa2ARchdxo4viFpgS
        7uQGK+gsMb0VL7+5BT6a9wGmS
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr18595471wmj.117.1593444330179;
        Mon, 29 Jun 2020 08:25:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5S/sa8P6liiPedMfDgcEMB4JDiBtcXYBUqvs6MOq7NCpJOsBsi1tIcIuRMKcNnUvLGRGqdw==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr18595450wmj.117.1593444329937;
        Mon, 29 Jun 2020 08:25:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b0e5:c632:a580:8b9a? ([2001:b07:6468:f312:b0e5:c632:a580:8b9a])
        by smtp.gmail.com with ESMTPSA id q7sm91034wrs.27.2020.06.29.08.25.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 08:25:29 -0700 (PDT)
Subject: Re: KASAN: out-of-bounds Read in kvm_arch_hardware_setup
To:     syzbot <syzbot+e0240f9c36530bda7130@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sean.j.christopherson@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        vkuznets@redhat.com, wanpengli@tencent.com, x86@kernel.org
References: <000000000000a0784a05a916495e@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04786ba2-4934-c544-63d1-4d5d36dc5822@redhat.com>
Date:   Mon, 29 Jun 2020 17:25:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <000000000000a0784a05a916495e@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reproducer has nothing to do with KVM:

	# https://syzkaller.appspot.com/bug?id=c356395d480ca736b00443ad89cd76fd7d209013
	# See https://goo.gl/kgGztJ for information about syzkaller reproducers.
	#{"repeat":true,"procs":1,"sandbox":"","fault_call":-1,"close_fds":false,"segv":true}
	r0 = openat$fb0(0xffffffffffffff9c, &(0x7f0000000180)='/dev/fb0\x00', 0x0, 0x0)
	ioctl$FBIOPUT_VSCREENINFO(r0, 0x4601, &(0x7f0000000000)={0x0, 0x80, 0xc80, 0x0, 0x2, 0x1, 0x4, 0x0, {0x0, 0x0, 0x1}, {0x0, 0x0, 0xfffffffc}, {}, {}, 0x0, 0x40})

but the stack trace does.  On the other hand, the address seems okay:

	kvm_cpu_caps+0x24/0x50

and there are tons of other kvm_cpu_cap_get calls that aren't causing
KASAN to complain.  The variable is initialized from

	kvm_arch_hardware_setup
	  hardware_setup (in arch/x86/kvm/vmx/vmx.c)
	    vmx_set_cpu_caps
	      kvm_set_cpu_caps

with a simple memcpy that writes the entire array.  Does anyone understand
what is going on here?

Paolo

On 27/06/20 22:01, syzbot wrote:
> BUG: KASAN: out-of-bounds in kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
> BUG: KASAN: out-of-bounds in kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
> BUG: KASAN: out-of-bounds in kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
> BUG: KASAN: out-of-bounds in kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
> Read of size 4 at addr ffffffff896c3134 by task syz-executor614/6786
> 
> CPU: 1 PID: 6786 Comm: syz-executor614 Not tainted 5.7.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1e9/0x30e lib/dump_stack.c:118
>  print_address_description+0x66/0x5a0 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  kvm_cpu_cap_get arch/x86/kvm/cpuid.h:292 [inline]
>  kvm_cpu_cap_has arch/x86/kvm/cpuid.h:297 [inline]
>  kvm_init_msr_list arch/x86/kvm/x86.c:5362 [inline]
>  kvm_arch_hardware_setup+0xb05/0xf40 arch/x86/kvm/x86.c:9802
>  </IRQ>
> 
> The buggy address belongs to the variable:
>  kvm_cpu_caps+0x24/0x50
> 
> Memory state around the buggy address:
>  ffffffff896c3000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffff896c3080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffffffff896c3100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>                                         ^
>  ffffffff896c3180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffffffff896c3200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ==================================================================

