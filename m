Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870D9C2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316F22083E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 09:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enbU4GZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgDIJEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 05:04:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27450 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726583AbgDIJEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586423039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kQ7lBIYRxVIllP8WU3yr1RLlp3Ki4sY9tIMcm8NLXo=;
        b=enbU4GZLdWg9Oxsb7kLZFSfzulPxa4RTDfayTiCMG22gjp8uYp3xqt5YD+ecwSOqZSy3cg
        xmcCvPmt3Ktafqt/bYJgUT6cD9mPngWXwpOObLBh0kk7iEy20bXcMEqI5h6GCC1GfFrbat
        oxv8FpNyqeNuBg/XTZyBKo2tIFSxl48=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-ROahz57vMHmhv6YH0OmnNQ-1; Thu, 09 Apr 2020 05:03:53 -0400
X-MC-Unique: ROahz57vMHmhv6YH0OmnNQ-1
Received: by mail-wr1-f69.google.com with SMTP id 91so6027725wro.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 02:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8kQ7lBIYRxVIllP8WU3yr1RLlp3Ki4sY9tIMcm8NLXo=;
        b=CLe0hjO7sZoTD7wN+Dfpbcy/fO7gXRe0YmaZ2+v30jpzoWmJV9bdWMUyrJIy1Cbm51
         PebN7doJtstawsc9dbrNWJtaXLVyswk4cjQsDGHr9nNrVYaeijOzwg+rBvtXJZ9tGJiD
         9DFZeXlpQvICR9Z30FsBOXjNFmSGNtEdG9v/cQpOpvUj2P7MxFEGdVDwVFHpupM3qRWi
         31d7ttFsuowXEy23culObA3SP+VLllYILt+QsBwmctEvkDR9kUA2ePYA5xGrRoGFvD2/
         7COUNMzmzWZSa/1p4eDqx6RqZTZppeE10jFFg6IdfcKtWwDmnKs+ywRqVmLj8DCSqAkz
         hW7g==
X-Gm-Message-State: AGi0PuZ7AEu+IY1h2GB4i2AeqOoXjw9s/mvA9W6/40dzpiBU/O6u5d1O
        DrVCYPJG4E4FQ1A/Ylpw6gaSjYmp0NM95JNdcZZ0v9Q/L8AZO965L8mmVERh+2skPV8pX+ShQBE
        m7TuTnVunKlWEb8GbIbx7ytqb
X-Received: by 2002:adf:b1c6:: with SMTP id r6mr12632478wra.49.1586423032029;
        Thu, 09 Apr 2020 02:03:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypLF16jQY0MQeLOoeWEjDvj99XBLM/QjgSY70WD35IL8kqp+4bpmhm1qfLNT2fbzdEIEC3sYEw==
X-Received: by 2002:adf:b1c6:: with SMTP id r6mr12632450wra.49.1586423031690;
        Thu, 09 Apr 2020 02:03:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bddb:697c:bea8:abc? ([2001:b07:6468:f312:bddb:697c:bea8:abc])
        by smtp.gmail.com with ESMTPSA id t8sm300999wrq.88.2020.04.09.02.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 02:03:51 -0700 (PDT)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
References: <20200407172140.GB64635@redhat.com>
 <772A564B-3268-49F4-9AEA-CDA648F6131F@amacapital.net>
 <87eeszjbe6.fsf@nanos.tec.linutronix.de>
 <ce81c95f-8674-4012-f307-8f32d0e386c2@redhat.com>
 <874ktukhku.fsf@nanos.tec.linutronix.de>
 <274f3d14-08ac-e5cc-0b23-e6e0274796c8@redhat.com>
 <87pncib06x.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92ea7036-0b77-20da-34ac-f425e6f233c2@redhat.com>
Date:   Thu, 9 Apr 2020 11:03:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87pncib06x.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/04/20 15:01, Thomas Gleixner wrote:
> 
> And it comes with restrictions:
> 
>     The Do Other Stuff event can only be delivered when guest IF=1.
> 
>     If guest IF=0 then the host has to suspend the guest until the
>     situation is resolved.
> 
>     The 'Situation resolved' event must also wait for a guest IF=1 slot.

Additionally:

- the do other stuff event must be delivered to the same CPU that is
causing the host-side page fault

- the do other stuff event provides a token that identifies the cause
and the situation resolved event provides a matching token

This stuff is why I think the do other stuff event looks very much like
a #VE.  But I think we're in violent agreement after all.

> If you just want to solve Viveks problem, then its good enough. I.e. the
> file truncation turns the EPT entries into #VE convertible entries and
> the guest #VE handler can figure it out. This one can be injected
> directly by the hardware, i.e. you don't need a VMEXIT.
> 
> If you want the opportunistic do other stuff mechanism, then #VE has
> exactly the same problems as the existing async "PF". It's not magicaly
> making that go away.

You can inject #VE from the hypervisor too, with PV magic to distinguish
the two.  However that's not necessarily a good idea because it makes it
harder to switch to hardware delivery in the future.

> One possible solution might be to make all recoverable EPT entries
> convertible and let the HW inject #VE for those.
> 
> So the #VE handler in the guest would have to do:
> 
>        if (!recoverable()) {
>        	if (user_mode)
>                 	send_signal();
>                 else if (!fixup_exception())
>                 	die_hard();
>                 goto done;  
>        }                 
> 
>        store_ve_info_in_pv_page();
> 
>        if (!user_mode(regs) || !preemptible()) {
>        	hypercall_resolve_ept(can_continue = false);
>        } else {
>               init_completion();
>        	hypercall_resolve_ept(can_continue = true);
>               wait_for_completion();
>        }
> 
> or something like that.

Yes, pretty much.  The VE info can also be passed down to the hypercall
as arguments.

Paolo

> The hypercall to resolve the EPT fail on the host acts on the
> can_continue argument.
> 
> If false, it suspends the guest vCPU and only returns when done.
> 
> If true it kicks the resolve process and returns to the guest which
> suspends the task and tries to do something else.
> 
> The wakeup side needs to be a regular interrupt and cannot go through
> #VE.

