Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A71C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 706AD20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SNkQbmm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbgFXNQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbgFXNQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:16:55 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B86EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:16:53 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s10so1542617oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 06:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrq4bU7gW/zMadgffXP6inYxHXZqoA5vMZOPEq8EPJg=;
        b=SNkQbmm6GBRU2KhBaTQKfcfmn3IqVyo1IEsawGEMXu1m/zaaJfewRLW+JgQxzyNplo
         PMxdiHAHUJj1jcLrCJu0EMigY/jpaqGRCjn9eKfBNn9ASxC662tvzS+E+WsmVKZ3s9t6
         NrRZIGxw9m88UnZv/NKxQWD5/cTP5KjXmezEvqgj+jMn3++GyHopD3hTboMCLUQVqj5/
         UMP41AzRmIsaMtAw6crTx5unAExkCuX3t+OXDZpMJKrjD9+bLYiMdGeEtS7Xq5lDB1sS
         xprDV5SPobMBnB9pS/vy+Vaf9C1Pruluatlv2PWS/VaTGPus5vwEvqkJyBc64kFKRbIy
         QHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrq4bU7gW/zMadgffXP6inYxHXZqoA5vMZOPEq8EPJg=;
        b=X09C70BlCQr3PjjjBQzaAAiBATrGw7k7s+GEMaRdmPAQOlbHwDuepZ5xEcToKEubsn
         45FAO93sjA1HPiFww5ea7P2QYmlUWTL9cOJ8qscvUP6azqQJPqI9MiK02UvsIkgVt7n5
         CHNHqrJRx+FjUoZx4Pbbst4769X8P+YIe3FDN/afKGZcL+ttGQeqUC+a3nLnkpoNgTHx
         xc3uVY2AARSA6nNarIRpVLWf7/vnEtX4MLeTqdAMVStpvL4xFy1fiKtIce8IxKY+BGKI
         M+cqYQXphmAlZmPQDqqyXORnWQhwjz6pQk5r59X9ck4awMfYkKJ8NS6db42kmA0YAUkO
         AlJw==
X-Gm-Message-State: AOAM530QuCQFPyKuNf9R2ijZUOUKdg0iIOHMlrVEXvxsSFH3DSXL2OgQ
        i5hmxVzFuxGZSDnSqwEFpeRbweogeq5iVa08DYMysQ==
X-Google-Smtp-Source: ABdhPJx8qSm/SisU7nPLHdrxBsDzhY4RaZrh+8tIbppoxAScIc3iEG1s2KuYqRjROS5f3+6X1lPiJtMoj8EFpKdT+Q4=
X-Received: by 2002:a54:4694:: with SMTP id k20mr4411799oic.146.1593004612263;
 Wed, 24 Jun 2020 06:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200617123844.29960-1-steven.price@arm.com> <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
 <20200624093846.GA11863@gaia> <20200624103412.GD25945@arm.com>
 <faa68f22-4d8e-0290-b52a-63ae7425b988@arm.com> <20200624110904.GB11863@gaia> <904edac0-3de7-35a6-a9bc-b983ccd3490c@arm.com>
In-Reply-To: <904edac0-3de7-35a6-a9bc-b983ccd3490c@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 24 Jun 2020 14:16:41 +0100
Message-ID: <CAFEAcA_LOVox4z=x8nH3S4=Oyc5_5zSkdxbsvnm=jiODaBTvsw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 at 12:18, Steven Price <steven.price@arm.com> wrote:
> Ah yes, similar to (1) but much lower overhead ;) That's probably the
> best option - it can be hidden in a memcpy_ignoring_tags() function.
> However it still means that the VMM can't directly touch the guest's
> memory which might cause issues for the VMM.

That's kind of awkward, since in general QEMU assumes it can
naturally just access guest RAM[*] (eg emulation of DMAing devices,
virtio, graphics display, gdb stub memory accesses). It would be
nicer to be able to do it the other way around, maybe, so that the
current APIs give you the "just the memory" and if you really want
to do tagged accesses to guest ram you can do it with tag-specific
APIs. I haven't thought about this very much though and haven't
read enough of the MTE spec recently enough to make much
sensible comment. So mostly what I'm trying to encourage here
is that the people implementing the KVM/kernel side of this API
also think about the userspace side of it, so we get one coherent
design rather than a half-a-product that turns out to be awkward
to use :-)

[*] "guest ram is encrypted" also breaks this assumption, of course;
I haven't looked at the efforts in that direction that are already in
QEMU to see how they work, though.

thanks
-- PMM
