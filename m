Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB5ACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 575D7206A5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBEhvVHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbgEMJJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:09:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730334AbgEMJJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:09:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589360969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LkQRKl9tLygDVkb/DJW18fHZ9G4cW+Tv9HaEWtJVlFg=;
        b=fBEhvVHyqHtVvtmuhkPKShNonYuhsEBwy3gL6Z3TYESuzl9BbPXKwHJfThDJLxzxdr80Is
        /Mw3K4sKxGLgtW9pmIWS63i5Z7Jqg8RO5HhfePiikZUquQ5wGk0M2DWOnIeA4KtBV4Nr63
        STGYsiy/st9yuXor7nztEBTcUws+vc8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-hF79RUdkObC-n7oyGVhRag-1; Wed, 13 May 2020 05:09:27 -0400
X-MC-Unique: hF79RUdkObC-n7oyGVhRag-1
Received: by mail-wr1-f69.google.com with SMTP id 30so8349083wrq.15
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LkQRKl9tLygDVkb/DJW18fHZ9G4cW+Tv9HaEWtJVlFg=;
        b=UEP5iJmooGGY2RY1jhMTWxy4rHWedPT2YWDmCNUOVCCJOezWi9T8Ftpqksw11PuZbd
         A5652si88d9o2KAQlmfVR6N0R3VVM+5+1EEzKOl1EaDOYu3SberHoctvUHSg8ChFoutB
         D7BdKhYfcM6GT5P8U/Ril5CsPq7PEFov8NFbRrOl00uned35UA/rCKATRQG/tRKLZ+y/
         +b998rTizuIZg43iruyW+4zI+OiWe4BezZmWtOj3m82hyjoC1uo7Q/4qgjm0URKYy047
         iXCmhw8eZQrMX4fF1sSkP3w2nrofVbH1yHUe2ESdxp7TTHeAiSfVgI5JHgrsXEWNYtM5
         d+VA==
X-Gm-Message-State: AGi0PuYHPYGF1OQMWPimzlamyiU89ZlgWKfFUry8C+IiqAVTB0jprCu7
        pszsDz9TbAUFfXqx591bedBGX4AZMCQ6JUe71gBfHNrfLU6TJXI/iK5pluG+tWolAaAlcbMsRrY
        4eM7kob82jmu4lJpjcJSkEVkE
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr43420406wme.126.1589360965710;
        Wed, 13 May 2020 02:09:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIjv23QQ+2IFmFvDYhwD6Weh2biJtnHzNX52SF/bAHYC2OofdpyPGHaYJrzuFQpZNuwDeYLdw==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr43420381wme.126.1589360965486;
        Wed, 13 May 2020 02:09:25 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b145sm13059757wme.41.2020.05.13.02.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 02:09:24 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vivek Goyal <vgoyal@redhat.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] KVM: x86: extend struct kvm_vcpu_pv_apf_data with token info
In-Reply-To: <20200512175017.GC12100@linux.intel.com>
References: <20200511164752.2158645-1-vkuznets@redhat.com> <20200511164752.2158645-3-vkuznets@redhat.com> <20200512152709.GB138129@redhat.com> <87o8qtmaat.fsf@vitty.brq.redhat.com> <20200512155339.GD138129@redhat.com> <20200512175017.GC12100@linux.intel.com>
Date:   Wed, 13 May 2020 11:09:23 +0200
Message-ID: <874kskmcak.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

>
> Why bother preserving backwards compatibility?  AIUI, both KVM and guest
> will support async #PF iff interrupt delivery is enabled.  Why not make
> the interrupt delivery approach KVM_ASYNC_PF_V2 and completely redefine the
> ABI?  E.g. to make it compatible with reflecting !PRESENT faults without a
> VM-Exit via Intel's EPT Violation #VE?
>

That's the plan, actually. 'page not present' becomes #VE and 'page
present' becomes an interrupt (we don't need to inject them
synchronously). These two parts are fairly independent but can be merged
to reuse the same new capability/CPUID.

-- 
Vitaly

