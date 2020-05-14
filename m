Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BE5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4502065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjVE1iKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENIIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:08:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52842 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbgENIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589443723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cOdfBW82qWXPUyvO4VieSyh6O7YUpxTbdcA3Up+HDqM=;
        b=DjVE1iKEB1GGJwA8uSomAe/1RAi3ydMMQT/kI74QBklshxnjUGB3JSuZQ8/MJItrtq+yPA
        lqYwlxJRApUpEp1yCtOomV+W/3YM+jLC17qLt3xGTjesjXjPgISb8yg4fjBCXrJbQVxXJO
        V8EvUpjAcO2DO5Sl4sZpl3MtAks+87c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-jONsEYa3MSynmjCS04UlkQ-1; Thu, 14 May 2020 04:08:41 -0400
X-MC-Unique: jONsEYa3MSynmjCS04UlkQ-1
Received: by mail-wm1-f72.google.com with SMTP id k17so3777730wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:08:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cOdfBW82qWXPUyvO4VieSyh6O7YUpxTbdcA3Up+HDqM=;
        b=W9mbl/HBLVpCjMQpfVlgYEvr6kU+Ra6/QODyNjqwRMzy0T6SprGmL5Z5U5wPCWvzo6
         WGCiSsf2e4+AEI3sQap08wdPiQR7btqNpjGI5X3LNmyXEr5UrfFJUDLhj8zVitXLxcx2
         8W0BKIpJsV86eSMcZlqHu628bNs4ayMRJ64hVhsFOX2hVL7jIQKsL+9jr9Dp3DZWN/zB
         pzNERi6V/tRICkEexENrzLEOqeobwciyIKoTahUPCQLBI9ceBu1YS1rCvEMt+GcLd4U6
         GZrEG3qvxOVEH9VEustUxetFGO6IEfK6OBKmC5nlK4sYzXikBpvHHG+k5PoJOasDg9JP
         py9A==
X-Gm-Message-State: AOAM530h9vE2QNyJhRrFI+M+e7Ik30GKTRjwhAfauRx+bWrqh21Zhqxx
        TqB04Qje9BWp5BT5iSJyESkcZa+8WzdGQxxqfQ7Ff8Jyp78CRJyJkyL5SpTWfQCo62k0LIsmpl5
        9SqFgssolztHmsBAv4IEuhVf3
X-Received: by 2002:adf:e7cb:: with SMTP id e11mr3781921wrn.145.1589443720510;
        Thu, 14 May 2020 01:08:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxWvR5OzaMV5kvMXVgfd5dF9p4W8++O/sutBCgKyZ2mU/1rmv9IjNsOFC+/o4Jqnay1RbHXA==
X-Received: by 2002:adf:e7cb:: with SMTP id e11mr3781898wrn.145.1589443720313;
        Thu, 14 May 2020 01:08:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 77sm2987286wrc.6.2020.05.14.01.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 01:08:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] KVM: x86: interrupt based APF page-ready event delivery
In-Reply-To: <20200513184641.GF173965@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200511164752.2158645-5-vkuznets@redhat.com> <20200512142411.GA138129@redhat.com> <87lflxm9sy.fsf@vitty.brq.redhat.com> <20200512180704.GE138129@redhat.com> <877dxgmcjv.fsf@vitty.brq.redhat.com> <20200513135350.GB173965@redhat.com> <87ftc3lxqc.fsf@vitty.brq.redhat.com> <20200513184641.GF173965@redhat.com>
Date:   Thu, 14 May 2020 10:08:37 +0200
Message-ID: <87zhabdjlm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@redhat.com> writes:

> On Wed, May 13, 2020 at 04:23:55PM +0200, Vitaly Kuznetsov wrote:
>
> [..]
>> >> Also,
>> >> kdump kernel may not even support APF so it will get very confused when
>> >> APF events get delivered.
>> >
>> > New kernel can just ignore these events if it does not support async
>> > pf? 
>> >
>> > This is somewhat similar to devices still doing interrupts in new
>> > kernel. And solution for that seemed to be doing a "reset" of devices
>> > in new kernel. We probably need similar logic where in new kernel
>> > we simply disable "async pf" so that we don't get new notifications.
>> 
>> Right and that's what we're doing - just disabling new notifications.
>
> Nice.
>
> So why there is a need to deliver "page ready" notifications
> to guest after guest has disabled async pf. Atleast kdump does not
> seem to need it. It will boot into second kernel anyway, irrespective
> of the fact whether it receives page ready or not.

We don't deliver anything to the guest after it disables APF (neither
'page ready' for what was previously missing, nor 'page not ready' for
new faults), kvm_arch_can_inject_async_page_present() is just another
misnomer, it should be named something like
'kvm_arch_can_unqueue_async_page_present()' meaning that 'page ready'
notification can be 'unqueued' from internal KVM queue. We will either
deliver it (when guest has APF enabled) or just drop it (when guest has
APF disabled). The only case when it has to stay in the queue is when
guest has APF enabled and the slot is still busy (so it didn't get to
process a previously delivered notification). We will try to deliver it
again after guest writes to MSR_KVM_ASYNC_PF_ACK.

-- 
Vitaly

