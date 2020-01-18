Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173BFC32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C3D246A5
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 21:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NRiBSm+D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgARVfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 16:35:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27348 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbgARVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 16:35:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579383320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s+aSiJdsJ4fdnsSQbUDUXR7vvH5ewWdg7+T/QPxjdZk=;
        b=NRiBSm+DyMCy1Kt/HcF3ibpweyoBg0sOk50wRs047YHhZViW4sMTtrWa6yYPa7fvvG9mh7
        nXua0RLlebc98FTUufz7prLALwX94wtgWKwzbuYkvsRTZbO1zAQTd95txRC+G8f3yWxVqM
        W2XNFm1KD2VKnqMwJh9VyZTsJchngm8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22--CtptkkDPoWUmucfX6NSgA-1; Sat, 18 Jan 2020 16:35:18 -0500
X-MC-Unique: -CtptkkDPoWUmucfX6NSgA-1
Received: by mail-wr1-f72.google.com with SMTP id 90so12056638wrq.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 13:35:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+aSiJdsJ4fdnsSQbUDUXR7vvH5ewWdg7+T/QPxjdZk=;
        b=n/Ua95OZo+rWOCmyo7wSCNUG2rPhDxVYm7CxO4zJ1yTUAYPT90ntqWctX20GDFYetn
         HdAORhS3cSNHjdwdjeCoGFJ1tzP3R3Iq/OMaXXyZxqz4CPKD9KmTBDhUD9nOQOnYczJv
         vgVODUbdICezuSHt3U8JZW5RybONy+fdBBsIcZgx+lbKOZHCSXQgu/j6Lh6ef99n/jhX
         Sd0A1rD/nkqjbyp1W2sOW3xdSHWh2MqptdJOPa9ztZ8punt+I9RBi7X8p7Q7BuX09WZ3
         pQQERKrs43pE52vuT6wWbkIfC+gzJONp20MJnXkt8NFm+veKW6m9IfhmwewqDBl5dvo9
         eqUw==
X-Gm-Message-State: APjAAAXYTzuCFgDzilKTCzhna0gLYYeZ3SKBSGNkgSdTsj9rMgcBFGoJ
        cCfaH2gqUzbWTFPboj3raRIO2Ol3uEOebKJqI82nmPsN141U1YtZSe5kf0Cw/cSJeNcC5K8NkcG
        DVl7rOMj6TI7J/EPLlcxPMKz/
X-Received: by 2002:adf:a141:: with SMTP id r1mr9409750wrr.285.1579383317705;
        Sat, 18 Jan 2020 13:35:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqwB7oJGW0eSsAQNqvqXydSLqwFZBqej1Tf+rmvEJmFTlg4HP0HzdzjgXqe4uuNENhJ80gwRbw==
X-Received: by 2002:adf:a141:: with SMTP id r1mr9409732wrr.285.1579383317489;
        Sat, 18 Jan 2020 13:35:17 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id b21sm4835499wmd.37.2020.01.18.13.35.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 13:35:16 -0800 (PST)
Subject: Re: [PATCH v2 4/4] KVM: x86: Remove unused ctxt param from emulator's
 FPU accessors
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Derek Yerger <derek@djy.llc>,
        kernel@najdan.com, Thomas Lambertz <mail@thomaslambertz.de>,
        Rik van Riel <riel@surriel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20200117193052.1339-1-sean.j.christopherson@intel.com>
 <20200117193052.1339-5-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b8491683-3717-4dbe-637f-c3daeef08d81@redhat.com>
Date:   Sat, 18 Jan 2020 22:35:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200117193052.1339-5-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/20 20:30, Sean Christopherson wrote:
> Remove an unused struct x86_emulate_ctxt * param from low level helpers
> used to access guest FPU state.  The unused param was left behind by
> commit 6ab0b9feb82a ("x86,kvm: remove KVM emulator get_fpu / put_fpu").
> 
> No functional change intended.

Makes sense since the new implementation of emulator_get/put_fpu can be
considered generic, and therefore it's okay not to tie it to ctxt->ops.

Queued, thanks.

Paolo

