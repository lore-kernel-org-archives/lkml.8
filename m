Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF73EC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFC20714
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhcZ/SVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgBZNLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:11:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46775 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbgBZNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582722661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m0TtEHDHCO42Q9GTo9Ybh1BaRZcDi57GOxuE4MyXihQ=;
        b=YhcZ/SVniwnPR0FpE/39Z05byIhdWGlwZk9h49NPknYlavhltgpfsl5bFIlZeGDu4HGDBI
        h9E86CRus83qQGjTx9aGLOWDqYu+1F4bZizvYLsV+feU1KuR4pNIX4WjTtp8VfOUg6IWxj
        YuHXFL692m7F1xqZ8AEQ4gb21mfhos8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-OfW6MSgQNuu8Xc0Wmx6lMg-1; Wed, 26 Feb 2020 08:10:59 -0500
X-MC-Unique: OfW6MSgQNuu8Xc0Wmx6lMg-1
Received: by mail-wm1-f70.google.com with SMTP id m4so896550wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:10:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=m0TtEHDHCO42Q9GTo9Ybh1BaRZcDi57GOxuE4MyXihQ=;
        b=BP4fQhLGWcA3Hl/HIG8w4pGv+2L9/FAH4DDOayIUUt4bbhm2+K+61K7u6B8Lurh2pt
         YLbe2a2I65r/jwFqQrtg2ub9IfMIdYh/FUgIn0K69b865UisGJqEP2WwGoG3CltklVSE
         GY6j0NweC4Iinjky6bhS26uiz/WFfFVX4fws4Jx9nHanZNqb+2ugGye4XzZxIl/HqLGo
         asZM/LFWwKeEr7B86yA5cusZU5StDE8xT2RpfHEDmb03PN3woDaqW8a0+BnaqiKMoTPi
         ou29hnzziygOnUk0d+3ad/ya6byhg5X0AMqNw/iibnZmgDI3rAiShBPmph+uThkBI0EG
         MFoQ==
X-Gm-Message-State: APjAAAUvLaxZtNBU01xK/CfKvJkmicycwQyXEID7OLL9JkDnStWrdZxE
        uskYPtCXH1/lu6gcbuGhny+hMpIuWCH5twRoFUVNugcayr/bUHWKevAERpk9u0JhXpK/owy3YLM
        H1TGm49eoWzFUNRdaYYTR76WN
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr5484070wro.310.1582722658321;
        Wed, 26 Feb 2020 05:10:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxqfgaBcw9P54nxu0njwaxXrTFvBjiwsyYYA1AskRRYgdt+S83CzUmE04FqC5v5uQVR5VjdlA==
X-Received: by 2002:adf:ee4c:: with SMTP id w12mr5484050wro.310.1582722658112;
        Wed, 26 Feb 2020 05:10:58 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z1sm2777575wmf.42.2020.02.26.05.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 05:10:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <kernellwp@gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] KVM: Pre-allocate 1 cpumask variable per cpu for both pv tlb and pv ipis
In-Reply-To: <CAKwvOd=bDW6K3PC7S5fiG5n_kwgqhbnVsBHUSGgYaPQY-L_YmA@mail.gmail.com>
References: <1581988104-16628-1-git-send-email-wanpengli@tencent.com> <1581988104-16628-2-git-send-email-wanpengli@tencent.com> <CANRm+CyHmdbsw572x=8=GYEOw-YQCXhz89i9+VEmROBVAu+rvg@mail.gmail.com> <CAKwvOd=bDW6K3PC7S5fiG5n_kwgqhbnVsBHUSGgYaPQY-L_YmA@mail.gmail.com>
Date:   Wed, 26 Feb 2020 14:10:56 +0100
Message-ID: <87mu95jxy7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:

> (putting Paolo in To: field, in case email filters are to blame.
> Vitaly, maybe you could ping Paolo internally?)
>

I could, but the only difference from what I'm doing right now would
proabbly be the absence of non-@redaht.com emails in To/Cc: fields of
this email :-)

Do we want this fix for one of the last 5.6 RCs or 5.7 would be fine?
Personally, I'd say we're not in a great hurry and 5.7 is OK.

-- 
Vitaly

