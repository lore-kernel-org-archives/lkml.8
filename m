Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA68BC2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4E572063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="EQpvnLI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDGW32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:29:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43006 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGW31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:29:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id 22so1457503pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=0b3dFf0p0sEoGF0Po8/4RVUQz4bKJvzm999agcgzdpU=;
        b=EQpvnLI3qdHriVGWpEZsLWrrSkgiUZscH4WitoZYNAbPTAuIy5zCe1/gzAVYEhzsSo
         gyeCWEZ30o8V21hIvD+Nau1RCjUarV/PuJgnKk+LCrW0Kp8BIRughSTKhw4m6ZxXbMj4
         a/lOoc8R2uAxqc2alLD1vx/eleE5BX8FM4dM2VlQnl+mPkb0dPUq3VvpXW5WOPCJi64R
         ICrKr1VkkmiMSk1OYSa9NEfq947hsvmsnc3wZWJt4lLPRXckXP700lJm5vO4Q77Maevy
         byFgSyVP/1nkE+BFIDoy8HAH/iW14sViiyDOx8JIf0n17JkFNnvUcGGgs4gW88EIhn2I
         yT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=0b3dFf0p0sEoGF0Po8/4RVUQz4bKJvzm999agcgzdpU=;
        b=imGunTcUsMOejZtCaW/ZZ0OvFDPFqXMF/eiYOeai8QJHGw08AWNnsBNWU4tKiQGDCY
         zxmX65lcEKTQetAPXqLVE070faUTB4M9Ulg5siKDOyr6Bb9RAJ9nAHTY2qPIolMBu5wn
         T79BWuhwAEsZILrc7aZIP6d809LVtnvxOeq/SYLvfSWVmRy74erd4mL3xDpGrj1zyVgt
         clq4LKPROhKkTyNOqSyj6wbDoIhoWwZ9iOYT6/ULzw0ptgr+jxkvenfnlpQSlLCNzY6z
         sL1+PSMVzf3ZDUw2pCp31jAjgpT/2arfDBIVui8M+mew3lVAiFZwFXwjnj8bvQw2s2O8
         XTEA==
X-Gm-Message-State: AGi0PuYWx1jaG9pHC528c8MnpVcBTwBiT/X1BfGgQEHy2HuNJt+A5S0K
        kEq+52jjZz31JDLDED2yvntprw==
X-Google-Smtp-Source: APiQypLOSfylfRkaCMr+boM7KCCzYJdOgLLQiUSxo5CgBZ3zkEGs2IB/5ZBvo6C+PhF1ZW4hfF5pMQ==
X-Received: by 2002:a62:5e86:: with SMTP id s128mr4791040pfb.157.1586298566299;
        Tue, 07 Apr 2020 15:29:26 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:a143:7d95:91a:a0ae? ([2601:646:c200:1ef2:a143:7d95:91a:a0ae])
        by smtp.gmail.com with ESMTPSA id o15sm13938279pgj.60.2020.04.07.15.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:29:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] x86/kvm: Disable KVM_ASYNC_PF_SEND_ALWAYS
Date:   Tue, 7 Apr 2020 15:29:23 -0700
Message-Id: <0255CF03-D45D-45E0-BC61-79159B94ED44@amacapital.net>
References: <2776fced-54c2-40eb-7921-1c68236c7f70@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Vivek Goyal <vgoyal@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>, stable <stable@vger.kernel.org>
In-Reply-To: <2776fced-54c2-40eb-7921-1c68236c7f70@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2020, at 3:07 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> =EF=BB=BFOn 07/04/20 23:41, Andy Lutomirski wrote:
>> 2. Access to bad memory results in #MC.  Sure, #MC is a turd, but
>> it=E2=80=99s an *architectural* turd. By all means, have a nice simple PV=

>> mechanism to tell the #MC code exactly what went wrong, but keep the
>> overall flow the same as in the native case.
>>=20
>> I think I like #2 much better. It has another nice effect: a good
>> implementation will serve as a way to exercise the #MC code without
>> needing to muck with EINJ or with whatever magic Tony uses. The
>> average kernel developer does not have access to a box with testable
>> memory failure reporting.
>=20
> I prefer #VE, but I can see how #MC has some appeal.  However, #VE has a
> mechanism to avoid reentrancy, unlike #MC.  How would that be better
> than the current mess with an NMI happening in the first few
> instructions of the #PF handler?
>=20
>=20

It has to be an IST vector due to the possibility of hitting a memory failur=
e right after SYSCALL.  I imagine that making #VE use IST would be unfortuna=
te.

I think #MC has a mechanism to prevent reentrancy to a limited extent. How d=
oes #VE avoid reentrancy?=
