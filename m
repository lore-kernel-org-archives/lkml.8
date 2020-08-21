Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525C2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A250207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZAMcBk7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgHUJol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:44:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725855AbgHUJok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598003078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5xvNOCI/T24E9b4WJ3j1AFKLWyH8JLbOkVQBD24hcGw=;
        b=ZAMcBk7hgVEtZvD1pZZFcawcTizIdt9adAcX3q9wXFH7eb2QRYOqy3CQhoY6EkD2mZfcdO
        YR/E81R/oxVQpLF6z4HZW4T8MCgNbU1xLd2EVfEC+7WFA7ecQPFcwRtZS6qtGblkZd76qf
        eN8MpADWUBllnG1Fax/FqnOpoX7ycqk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-7ixooGJrMuKR54bWMfnMjw-1; Fri, 21 Aug 2020 05:44:37 -0400
X-MC-Unique: 7ixooGJrMuKR54bWMfnMjw-1
Received: by mail-wm1-f71.google.com with SMTP id d13so599452wmd.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 02:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xvNOCI/T24E9b4WJ3j1AFKLWyH8JLbOkVQBD24hcGw=;
        b=I83U5FYNsu3i8XHpNyURFJWOtZvkuI85IwjE872liGB29VtXLNA637323XgENwpz+S
         cPSDfFenKLeasDh2u7UestOhnKMSJzGK2+gLcAsoTSihXdvRDliSR2c3UhaE9mXFbZhP
         noeCzdl/Lg/gDBR2Hhz/YzseXcsFQ1itAdqSKmrs3sqG1/qjjZaeCS24/6erVGYCO3sn
         1ksBgYIwSe0qEZCCw5/Sp2wc2UFNP5tpXVPhOqV4FTP2RW+pM5TlCo/yy0ZzUPs4X+IH
         g+k2Z8KBNJd3uKjftwvu3BeI0RAQwHgiFMOAkqw8ZqGOmY8aVPPLrVk9dyLrxtO6GioP
         fV4A==
X-Gm-Message-State: AOAM532FVMqrf3VApusRePDOdny+x/TuPvAdtsqpaPC+LtCFnPt6dWmK
        9o5boXebXWPNoOoSy535HCJdQ/027iOWCPdY9ZHcCTtnbMJvOgPQI57YfvR5U33v3ZXem1uaSwj
        mpeMmVDjBp9gbdAiph05PPBbk
X-Received: by 2002:a1c:7918:: with SMTP id l24mr2908410wme.158.1598003075965;
        Fri, 21 Aug 2020 02:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6JglJ1VS+h/6tPMLaP2AyZuVQTrXmvTg3zqq1jBqyZgkSEMmoLY77Xi2H35dhd6C7SLIcIw==
X-Received: by 2002:a1c:7918:: with SMTP id l24mr2908394wme.158.1598003075764;
        Fri, 21 Aug 2020 02:44:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cc0:4e4e:f1a9:1745? ([2001:b07:6468:f312:1cc0:4e4e:f1a9:1745])
        by smtp.gmail.com with ESMTPSA id k4sm3429929wrd.72.2020.08.21.02.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 02:44:35 -0700 (PDT)
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
 <20200821074743.GB12181@zn.tnic>
 <3eb94913-662d-5423-21b1-eaf75635142a@redhat.com>
 <20200821081633.GD12181@zn.tnic>
 <3b4ba9e9-dbf6-a094-0684-e68248050758@redhat.com>
 <20200821092237.GF12181@zn.tnic>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1442e559-dde4-70f6-85ac-58109cf81c16@redhat.com>
Date:   Fri, 21 Aug 2020 11:44:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200821092237.GF12181@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/20 11:22, Borislav Petkov wrote:
>> Hence the assumption that KVM makes (and has made ever since TSC_AUX was
>> introduced.
> And *this* is the problem. KVM can't just be grabbing MSRs and claiming
> them because it started using them first. You guys need to stop this. If
> it is a shared resource, there better be an agreement about sharing it.

It's not like we grab MSRs every day.  The user-return notifier restores
6 MSRs (7 on very old processors).  The last two that were added were
MSR_TSC_AUX itself in 2009 (!) and MSR_IA32_TSX_CTRL last year.

Paolo

