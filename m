Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6054C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CDB2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbGif9cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgBUNPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:15:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42203 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgBUNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:15:31 -0500
Received: by mail-io1-f65.google.com with SMTP id z1so2287080iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zDn5C3xv6dXYKrjaHTGWkXdQBcdK60nBC9wVMKjt8WA=;
        b=RbGif9crxh5U8AFJaQcwjKLg3pjkvQblsGUJ/mz0L4vreJUc3yQ1ZD60EwmkYswfBU
         7kOYpcKdQQFOv6YaN/h6zb6VFYxTTHuY29xM2Zeh/BO5jNRiIr1M53l6wgAgq0meuvwI
         cVVxgXOSPqp7ff/Z1TUnuZgTmRoqU4dNOBgiIPgpKuUoVsyCLr5AvVZbi+MHRaCpLhSh
         69aBMxqD93DjXsK0Z4FVQAL1D0CQw4yre6Gx7mrFqeiuwzi6c0tLD5LCe0kAvPDyJTmx
         Q69so67DzaVnClUVXFUaylCppaU+gngz7W82yFriZEPXWxCAJprfiQSnoweZ+cGB7E2U
         PSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zDn5C3xv6dXYKrjaHTGWkXdQBcdK60nBC9wVMKjt8WA=;
        b=clLEwn9YUa+tj2Fob808mcQ3A+p3AaGMvRNEy4Laxh8kWJivykdtuvF+kBU7pkzner
         J8+zkg9DrQ3XfsAgK5oeOF4PHDghqXQTYLTXfy/sve31ykETS1h8nThX8mZhFCZ4tTNr
         +8KIUk6UnvgpglwIk5E/n5geNlwOLm4SIOwMessV3Zsa0tB3W2k8uetvjXyQEUx/5Llg
         NPypvCNR1BHeYmXU25gc4a1as2X2g5QqX+necfGztE8FM3lqADR3FT+DV79qIFPyUSp8
         fVxNzBSCOxvBBWeerKMWKbBv/001kVE925fGD+PIPKpG/Jcwqs0hv1aD88vq4o/kbJdV
         QzKw==
X-Gm-Message-State: APjAAAX4PLm3P0jxbWKMPKnJ6n+YZuxHgjK6qJ4QUaIiSjvu1k+jIHOn
        Kyr7r4rslOD7ASNbgVEWlJZdQ/Et2WW984iRhwfx
X-Google-Smtp-Source: APXvYqyNWiYV6786lLaXb1e2HDQmEpkhbVuvP9MuqYvPju5KQeelvesy9MLBXmyUdOjxnUX+6Vner8bdXGpcfWU7W1c=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr32144026jac.126.1582290930632;
 Fri, 21 Feb 2020 05:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20200221050934.719152-1-brgerst@gmail.com> <20200221060756.GA3368@light.dominikbrodowski.net>
In-Reply-To: <20200221060756.GA3368@light.dominikbrodowski.net>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 21 Feb 2020 08:15:19 -0500
Message-ID: <CAMzpN2iQuaNdTdL6G1rGbUFo+r16iRFo1zbiD_VMrrjtGf0acw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Enable pt_regs based syscalls for x86-32 native
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 2:07 AM Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
>
> Brian,
>
> On Fri, Feb 21, 2020 at 12:09:29AM -0500, Brian Gerst wrote:
> > This patch series cleans up the x86 syscall wrapper code and converts
> > the 32-bit native kernel over to pt_regs based syscalls.
>
> thanks for your patchset. Could you explain a bit more what the rationale
> is. Due to asmlinkage, it doesn't leak "random user-provided register
> content down the call chain" (as was the case for x86-64). But it may be
> cleaner, and you mention in patch 5/5 that the new way is "a bit more
> efficient" -- do you have numbers?

The main rationale for this patch set is to make the 32-bit native
kernel consistent with the 64-bit kernel.  It's also slightly more
efficient because the old code pushed all 6 arguments onto the stack
whereas the new code only reads the args the syscall needs, with the
pt_regs pointer passed in through a register.  By efficient I mean
that it uses fewer instructions and stack accesses, not that it will
actually have a significant difference on a benchmark.

--
Brian Gerst
