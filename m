Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059F2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67F620674
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="BTeF3Bw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgA3QpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:45:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36856 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgA3QpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:45:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so4943263wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g0UrPH6iQiBpC0TWOe6cT/cBGUUxDYJOmDYdrkMQqGI=;
        b=BTeF3Bw1Z3ZKvaNrtxGZZbPesztbis+EK+M6Zu1lrzuWmAO2sew1APe+NTi71+a4QN
         ib6tkL7n2X2rH7G8yoA9y86vuVbBgAKNes1RMuQ1w4szzK4wG+0IB1Cum8EPT4E95BGV
         BovIBaCMSF6/mmziqQdq2+2HcmbLgc3jRxxw+EHaRO6c2nW8mnh9ckd0WlrmMJVxJv6w
         XP86W0s7GsMRW3YCVDnVtzJIHdm67wvriKD11MS7v4PZd+7IA7F7/tITDRkZok4V4VoV
         KW6uMmQ7pVtWOfD4BF6NLk/wX0AlQwqKmju2IM8r4WhRVB8/AzT3RxzV9tOkvX9CmP3H
         cthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g0UrPH6iQiBpC0TWOe6cT/cBGUUxDYJOmDYdrkMQqGI=;
        b=K6CLPcf/vOevIlbduR8n4V9DG0UaJ04NoFPWfTIU/WchTylcCzsZq3qLYo2+TcdPEn
         2i3yPOPQuHd5g3V+h4mWMFB4EZ5dlIWhIy5mD/ZiOVHDG7v5U33KP5+ebcnMtQBViGqo
         JbDRrhR4h9Noc7UK2Uysl36tCHRuExKb6crM0V/o/hiv0+SIIBIJOAJBYZKMgDizP1nA
         z2sTX+Fz9JsXf0mvgVv4RaijSHLM0w9EFHjyDhztu9d+Is8ZlJEjUrYhY0vDomMYqYFI
         p91EXUCLU6pPuJtuG+dMTrY129wA8wdLKZKdnTNTUB7UbZBkOOh6eDwDNV+V0y9CVl/Y
         P5sA==
X-Gm-Message-State: APjAAAXH6xknycigI6GytroLD5D72kg2g2Z9jVLp4gg8Aka6LZrrKPhN
        5jo+z+Q/Arg4tvQneDK42IjKg86WhLL9syiJ9e/Avw==
X-Google-Smtp-Source: APXvYqzns5TdoLjnflFXgHdidMjCxTkXNoTbhg7Y2+9Jap1zOyAGUmBGDo+4TD1LjbTsRKL22TvtmpZo6oaJcErE9kM=
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr6487084wrs.395.1580402715227;
 Thu, 30 Jan 2020 08:45:15 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic> <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com>
 <20200129183404.GB30979@zn.tnic> <c08616b8-d209-ff08-1b74-645a49a486d2@familie-tometzki.de>
 <20200130075549.GA6684@zn.tnic> <20200130111057.GA21459@linux.ibm.com>
 <20200130115326.GG6684@zn.tnic> <20200130115959.GA24611@linux.ibm.com> <20200130120617.GH6684@zn.tnic>
In-Reply-To: <20200130120617.GH6684@zn.tnic>
From:   Damian Tometzki <damian.tometzki@familie-tometzki.de>
Date:   Thu, 30 Jan 2020 17:45:04 +0100
Message-ID: <CAL=B37kQpv+8V0ahyxdhXmJqS2YBEqPyy=07w6FgDQ5csEAk1A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Borislav,

System is now boots without errors.

tested.
Damian

On Thu, Jan 30, 2020 at 1:06 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Thu, Jan 30, 2020 at 01:59:59PM +0200, Mike Rapoport wrote:
> > I've seen similar crash with my qemu/kvm and bisected it to that commit=
.
> >
> > The hpet allocation is off-by-one and as a result hpet corrupts the mem=
ory
> > somewhere in the slab
>
> Oh wow, wonderful. Good that we have bisection in such cases - there's
> no way in hell I'll debug it to that. ;-\
>
> Thanks for saving me a bunch of time.
>
> Damian, can you test the patch at the bottom of that mail:
>
> https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne=
.jp/
>
> ?
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Software Solutions Germany GmbH, GF: Felix Imend=C3=B6rffer, HRB 368=
09, AG N=C3=BCrnberg
