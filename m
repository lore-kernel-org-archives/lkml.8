Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97496C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63944206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQFXCtc/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgEUO7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:59:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52682 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728162AbgEUO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:59:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590073176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75FPnYIg4487ji/STTwVV18+TkDRf4bIG3MW4+gphww=;
        b=FQFXCtc/fwGu8F47kSztAG3Jghv3NZ+016ffw7+W+fNP745StGXjiMDOjAPKM63ogOyCKH
        Ufy1CKrioloTUKFhqi4U7HO25Ajd2gAmrpLLS9cHGCYpFistLnaiPEHA+ClSapiBuZpD4+
        OY9lMeQV5FuGpLM1JKLUxRV/AK8qHpA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-ClHZIB3qPR2yu9SGKy2UYg-1; Thu, 21 May 2020 10:59:32 -0400
X-MC-Unique: ClHZIB3qPR2yu9SGKy2UYg-1
Received: by mail-ed1-f72.google.com with SMTP id f10so2787879edn.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=75FPnYIg4487ji/STTwVV18+TkDRf4bIG3MW4+gphww=;
        b=WwPuJXB5Ne3urwlryCdOZmJdNwBF/wiGKnOGetRDpLFzEEwT/92aUcjXD6NrkesYzK
         AcxbPjPIpdYbzA22omPi2fHqzxeWGZe8eduhUoq59pMcZfqoYNkhH0IebsL4ac0ACMvw
         FT57hGZ7Irr5xdf0rEfrNqBvVgYfi6CRzkwF3SG9BmEhwzcKWb1FTzsrO9pqmLoac3/g
         zC6McHZ9vVYxczCn7NKre1M+i5414cF77M+bYahSLc40V9i4ygOhd90S6ieHtRITnZTw
         1lm5ZciDGYdqE69lJJX65puNtc8wyM02zxc3psmVVyA6TUNb+XAP316kFKJf+qQIGOVn
         B+Qw==
X-Gm-Message-State: AOAM533WCLPW3NRE9NxbnH3Q3rYObVy5DHw6t0rolAHzZ79Me4VfFuu0
        T7suborV/XKYrGJUp8L4qRLvS98xSJ1S/lQuHFLyjLyYfxoIAM7ktHnpo6Vg8GFgOPPqdquNH/1
        bd0FMkpJ18MF9ra6UC0qD8ceJ
X-Received: by 2002:aa7:cad3:: with SMTP id l19mr8148090edt.335.1590073171473;
        Thu, 21 May 2020 07:59:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRmjc9KoFWYCB9UJuoPDyXwo3I7zGXEs/M6DBOpaO4a224WEnAMH71JGQVoMcFiFr19StZig==
X-Received: by 2002:aa7:cad3:: with SMTP id l19mr8148065edt.335.1590073171184;
        Thu, 21 May 2020 07:59:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cz9sm4771599edb.18.2020.05.21.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:59:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with token info
In-Reply-To: <943cfc2f-5b18-e00a-f5a2-4577472a1ff5@redhat.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200511164752.2158645-3-vkuznets@redhat.com> <20200512152709.GB138129@redhat.com> <87o8qtmaat.fsf@vitty.brq.redhat.com> <20200512155339.GD138129@redhat.com> <20200512175017.GC12100@linux.intel.com> <20200513125241.GA173965@redhat.com> <0733213c-9514-4b04-6356-cf1087edd9cf@redhat.com> <20200515184646.GD17572@linux.intel.com> <d84b6436-9630-1474-52e5-ffcc4d2bd70a@redhat.com> <20200515204341.GF17572@linux.intel.com> <943cfc2f-5b18-e00a-f5a2-4577472a1ff5@redhat.com>
Date:   Thu, 21 May 2020 16:59:29 +0200
Message-ID: <87y2plqqpa.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> However, interrupts for 'page ready' do have a bunch of advantages (more
> control on what can be preempted by the notification, a saner check for
> new page faults which is effectively a bug fix) so it makes sense to get
> them in more quickly (probably 5.9 at this point due to the massive
> cleanups that are being done around interrupt vectors).
>

Actually, I have almost no feedback to address in v2 :-) Almost all
discussion are happening around #VE. Don't mean to rush or anything but
if the 'cleanups' are finalized I can hopefully rebase and retest very
quickly as it's only the KVM guest part which intersects with them, the
rest should be KVM-only. But 5.9 is good too)

-- 
Vitaly

