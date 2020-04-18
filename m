Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE58C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9ED214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0i85OPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDRAtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRAts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 20:49:48 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D96C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:49:43 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id f12so2781572edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILGJdPVopH8dcZhs9zo8meFz8ZU1EhEF7xfIxGI/Jew=;
        b=X0i85OPnq74NVcUCzWPdo/3Sdhtgs2brEcb60Il8uSMv8zsbbwQn/ZVdUswz/2UnTl
         Ke0gTwLzfULJVWmSGEfcGmrVBoKjNnY+fBVjbs4Hkc9XusQl20LxTGn0OBOw9gcbyHaQ
         35EdYRiN+b+1dPnswJjZMB6TZS9qRsulPw6ORtRMzjxmXLBbsnCcX8p8y7cPoO1nAFZu
         sjVMx6rk5DHzAHcdTNRPoME3pu7CmOWtZFfLowcGGSYTK/jsH8ALG31Ht9lc1pIRgdW0
         EOcjo1mFOTtSQ10CzXCmgN41Tj5jSaL4GHEurN/NIqQN1wS3j8V/uSWICdBtpEq+B23X
         p/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILGJdPVopH8dcZhs9zo8meFz8ZU1EhEF7xfIxGI/Jew=;
        b=MhGdhmZGRqTThinRH1wtFYFbbnFoPpuKGS7t5CmNTxN6gfSS43b7o3C/XxClFmuSJ7
         N2pOrY4ik/IqVI2wgwl7UWtj4nqEAmeUr715LR0gJIKCshBssWifEzNo4LjH14cLuNGf
         xomGQlveSfK12lWgrJ5uvF5DwlaYzbCkMLVArWN3fj3olYJ1ac73+OftVHjxqOar9Z2m
         fGWY0Ps/+HnNytoV6ac3nvGWm6o6mGRij8v7r/hQNgyL7JUJAfH7l8soXdBGUQVugI3C
         XVYvLA5YzaVxdbSdiKSKSRejW6cTkFC6IGmBMJcfqiFNrp7+YuNoXGQpeVbl/PTwy/sL
         SHhg==
X-Gm-Message-State: AGi0PuacRJ4Gaxq6FKodRsw6rUV4tT4yBY1G4IMjh9WXlpCaUGZ9SQoY
        QjoEIyDPzZYipKEzGgJeqSWKKXwW80o/dSs/8uE=
X-Google-Smtp-Source: APiQypIRQPCAz8bz0tv7D9Le7fVONYWs8EctkxowfXctDK40o7XMsRFbfGSCOUYS/Le3Qz3zTDKlljGXKeiZ6tx8d5M=
X-Received: by 2002:a05:6402:120a:: with SMTP id c10mr5197545edw.15.1587170981913;
 Fri, 17 Apr 2020 17:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAB9dFdtBqrcmKcV=zxPyV5uNB7WeKOqqC4k5KtY+9vxS9ooKoA@mail.gmail.com>
 <87d085zwy9.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d085zwy9.fsf@nanos.tec.linutronix.de>
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Fri, 17 Apr 2020 21:49:30 -0300
Message-ID: <CAB9dFdvJE0LhQsxdUTKmOxp_q1xF1Bpe9E-dNp1Pxg3T0B1xPQ@mail.gmail.com>
Subject: Re: FreeNAS VM disk access errors, bisected to commit 6f1a4891a592
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Marc,
>
> Marc Dionne <marc.c.dionne@gmail.com> writes:
>
> > Commit 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity
> > race") causes Linux VMs hosted on FreeNAS (bhyve hypervisor) to lose
> > access to their disk devices shortly after boot.  The disks are zfs
> > zvols on the host, presented to each VM.
> >
> > Background: I recently updated some fedora 31 VMs running under the
> > bhyve hypervisor (hosted on a FreeNAS mini), and they moved to a
> > distro 5.5 kernel (5.5.15).  Shortly after reboot, the disks became
> > inaccessible with any operation getting EIO errors.  Booting back into
> > a 5.4 kernel, everything was fine.  I built a 5.7-rc1 kernel, which
> > showed the same symptoms, and was then able to bisect it down to
> > commit 6f1a4891a592.  Note that the symptoms do not occur on every
> > boot, but often enough (roughly 80%) to make bisection possible.
> >
> > Applying a manual revert of 6f1a4891a592 on top of mainline from
> > yesterday gives me a kernel that works fine.
>
> we tested on real hardware and various hypervisors that the fix actually
> works correctly.
>
> That makes me assume that the staged approach of changing affinity for
> this non-maskable MSI mess makes your particular hypervisor unhappy.
>
> Are there any messages like this:
>
>  "do_IRQ: 0.83 No irq handler for vector"

I haven't seen those although I only have a VNC console that scrolls
by rather fast.
I did see a report from someone running Ubuntu 18.04 which had this
after the initial errors:

  do_IRQ: 2.35 No irq handler for vector
  ata1.00: revalidation failed (error=-5)

> in dmesg on the Linux side? If they happen then before the disk timeout
> happens.
>
> I have absolutely zero knowledge about bhyve, so may I suggest to talk
> to the bhyve experts about this.

I opened a ticket with iXsystems.  I noticed several people reporting
the same problem in their community forums.

Marc
