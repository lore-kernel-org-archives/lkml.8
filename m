Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DDDCC3B1AF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C42168B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ux0PhWNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389692AbgBNRna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:43:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37167 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389828AbgBNRnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:43:24 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so11423587ioc.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vH6F7s/7KJOmKxjFPtdbua/0bzQH273F8zOPdozonb8=;
        b=Ux0PhWNqk4sJNEs0icorJrDWXp824NUdWvxe43XntaFe4SR1FlgGObmsib+qpD1Ty7
         umGaCdf7ZDRykv+Sv2UF5ntf+qG8pt5dWqR/xopxpGobdyEjt5xGlt4rw1j4DFllB77o
         FOztyw1X44q3OjHuAhB1kKDHPd0QVA4rXe0fj30RB2ZhUuqqjhwAILokrOlystz9aCtH
         BuJQ4pE3vnGZV+wn6vUDXCbeHqMTyxNMwnukmyBKdCF353gbp6mq3IwTWL+1hDurD3Vq
         OEXtqLyEqHCMjGkg5XDUqbWHcyfnFD5fNCN7/5hBPPH64kCTgNVhIl1huzTna60C8xnK
         fgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vH6F7s/7KJOmKxjFPtdbua/0bzQH273F8zOPdozonb8=;
        b=s/f2iG/z+C+KWloVnrIh4W8Fjys9pwTed9thuOfP0q876Admk/bZ5ba5akfZs4Y0sn
         itfYyIKFP9GS372RoRHOWjRvOM3SgidatFpCVhVvYzEjpYNsdNrEyEP1H16Q9tqZwqiT
         hVRPa9Q78I4hoeHCgJ/IwxZ922odex4s8KJmJjtfiW2mxTJyS3TqGl/Ku0B/xvpWXBCt
         CK0r2MeFhZXxJ+t9NngJz8bgqFrrmlsZBmwm7rozXfFbH21G6EUXtwJ+VBfIf4DrqsX7
         2ieUNxOOJSqPudS+EgC0XmyjrnAtEvHzEmOJ8luW1m9yS23N6o7w7aGPMKX71KBZv4pX
         Fcew==
X-Gm-Message-State: APjAAAV4UE6k83GroQUmBxJQsQOG19WifnHft6aCOU5u+g7Qlg4Miri6
        99p7IPVDIkaUfisVdQ19EUngGrWt38xjb9e2j1QyRw==
X-Google-Smtp-Source: APXvYqzLzSD4wBOn+oU2MaRsuKpeItnXRIq8O1WrWQrL68J+eAQXMFVizCcOMm7FYVALf8go9yilwPgtCiPr2/V3muY=
X-Received: by 2002:a5e:8e4c:: with SMTP id r12mr3089863ioo.119.1581702203932;
 Fri, 14 Feb 2020 09:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20200214143035.607115-1-e.velu@criteo.com>
In-Reply-To: <20200214143035.607115-1-e.velu@criteo.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 14 Feb 2020 09:43:13 -0800
Message-ID: <CALMp9eSdOz4NMHEM_J1V3PiyTsivPG3AJ-NX1CTvyxF_uJFaAQ@mail.gmail.com>
Subject: Re: [PATCH] kvm: x86: Print "disabled by bios" only once per host
To:     Erwan Velu <erwanaliasr1@gmail.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 6:33 AM Erwan Velu <erwanaliasr1@gmail.com> wrote:
>
> The current behavior is to print a "disabled by bios" message per CPU thread.
> As modern CPUs can have up to 64 cores, 128 on a dual socket, and turns this
> printk to be a pretty noisy by showing up to 256 times the same line in a row.
>
> This patch offer to only print the message once per host considering the BIOS will
> disabled the feature for all sockets/cores at once and not on a per core basis.

That's quite an assumption you're making. I guess I've seen more
broken BIOSes than you have. :-) Still, I would rather see the message
just once--perhaps with an additional warning if all logical
processors aren't in agreement.
