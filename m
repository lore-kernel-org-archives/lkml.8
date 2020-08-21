Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B52EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76696207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN4xvvVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgHUJhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725855AbgHUJhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598002637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HM8iWB8SC7hD7f4RpIcbL31EFLRVSaFi+Uelkb/Y1jg=;
        b=GN4xvvVcrDFt8SsA18jSqlvoZPv5leekixRS85MRZX8R12qXC9Rg55QibYefAMuGxn9eCf
        DEwv3SAy2Zfyujeb2J/7sROEVGwjiXuLJ43yc65oVRB7KN0673m1umsHdA3Ju+Gn5/V3k9
        7GUmU04Mj6st0AXswCwBJDQwuANRlJU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-1sQGRsjSMwqD4JRBF8grow-1; Fri, 21 Aug 2020 05:37:16 -0400
X-MC-Unique: 1sQGRsjSMwqD4JRBF8grow-1
Received: by mail-wm1-f70.google.com with SMTP id q23so327962wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HM8iWB8SC7hD7f4RpIcbL31EFLRVSaFi+Uelkb/Y1jg=;
        b=Qb7Om7PRcJ/dnLzFcbkWnxhxPB1tMQenuy84NzTYPyZdJkk6ZYcLld03U60B/E5+jb
         GKMDVpeCefqivc8PoDNCsWLcz01zciOgFtq5Xl6iL/dn/skdu+HOXtSU+6YztrFI6tF9
         jAkOX40SikK4/6e4w3UUthEkZcbIzy5yNRepK0DcZCjVcDSJrkIDVBaz+gbQnWqtktCK
         MOq9kpOq3eO6fUlGBAhb9j3VZdfN5Tg7dU3qSJB+1P75jQCPVJTQLdggFaJNgmWM5Y2A
         891VxHhocHtI+Hmjmo3brc23j79bib+Yw5y0WSSD0AZ76LZn9lJWd3nJr35DubXvXWPX
         oQkQ==
X-Gm-Message-State: AOAM533qeHhb977KitJQFloqutRDKFndxRHMhGxENHIYI/dziuU5DMYc
        tKD5KUz1ICXCUsaaFgB+ahn2etj9TOi9a7YgOsZg/Rl0GsG6o9lUsDqaxQqECHUxHhqHfobUwVP
        UOTdQNqhchpI4xnnwKKHTiKKf
X-Received: by 2002:a7b:c84e:: with SMTP id c14mr3074368wml.51.1598002635063;
        Fri, 21 Aug 2020 02:37:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwC4R8JV8L5mLEba4NKsTdVDCxAA6Mt6rRW2RutzRg5Vy9Fkhbug+fOmXTIeN9cV11aJiiDA==
X-Received: by 2002:a7b:c84e:: with SMTP id c14mr3074345wml.51.1598002634800;
        Fri, 21 Aug 2020 02:37:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id c10sm2887323wrn.24.2020.08.21.02.37.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:37:14 -0700 (PDT)
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <87r1s0gxfj.fsf@nanos.tec.linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8597183-5a14-de7c-330b-46b9bf015d0c@redhat.com>
Date:   Fri, 21 Aug 2020 11:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87r1s0gxfj.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 11:28, Thomas Gleixner wrote:
> We all know that MSRs are slow, but as a general rule I have to make it
> entirely clear that the kernel has precedence over KVM.

I totally agree.  I just don't think that it matters _in this case_,
because the kernel hardly has any reason to use TSC_AUX while in ring0.

Paolo

> If the kernel wants to use an MSR for it's own purposes then KVM has to
> deal with that and not the other way round. Preventing the kernel from
> using a facility freely is not an option ever.
> 
> The insanities of KVM performance optimizations have bitten us more than
> once.
> 
> For this particular case at hand I don't care much and we should just
> rip the whole RDPID thing out unconditionally. We still have zero
> numbers about the performance difference vs. LSL.

