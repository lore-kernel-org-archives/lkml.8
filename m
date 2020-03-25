Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D8C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2611B2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585176727;
	bh=BZo++6PRmqn8ECQe/7430RjXeOgiPlyvU+6fA5R/8iY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UNg+rknw+F+i7Y+oytSk0bYgK72AUScisBZrxBsKH0QM2V7jM/DbPSGmorin8dyJp
	 uCMa04zsY83FNej7RFo8calXPbOD7C/r3suVmpe7MHvWkdwxqa0mOwGfyWF6Vvrycl
	 pQHNUAxONGu3XcI0Ok8M71/M+SThLUeNE7eah8vY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCYWwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:52:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgCYWwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:52:05 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1672620775
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585176725;
        bh=BZo++6PRmqn8ECQe/7430RjXeOgiPlyvU+6fA5R/8iY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oqE2zfQ7M+BGJElI8imezU4HMq/9zP88BjHgISTQpdoLzJnXsVh4L+G6bVqJDNlor
         C9AGXZyus4QTGEQBnmR6rJHUONL8HytIO5IvfL+kQC3PJhOcgHt5VgfiqqZLqCXq2q
         M/Nd0gmjlffukJ1WCmAKUKy1QGHwiAJ7gUGyJC34=
Received: by mail-wr1-f47.google.com with SMTP id p10so5588095wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:52:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Ql8YfXaZXXSUYRN144lgALgMY5oxiAfqKjatjQnrr9RG2EvkH
        0Tz2id862ZLcAqIyf0Jfe4upc9s+iCARTZvtQgoVNQ==
X-Google-Smtp-Source: ADFU+vv21ld+hrhT+I0z4y6bvTelpXW8Ycz3l5c9xhZW6OY7a1I6dFmQWslgtsn+EG3S6IleQh7weJA7gseNw7s3llg=
X-Received: by 2002:adf:9dc6:: with SMTP id q6mr5774802wre.70.1585176723482;
 Wed, 25 Mar 2020 15:52:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200325194317.526492-1-ross.philipson@oracle.com> <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
In-Reply-To: <CACdnJut56WuqO=uLff0qy1Jp=C6f_sRxLpRBsrzb6byBsFYdCg@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 25 Mar 2020 15:51:52 -0700
X-Gmail-Original-Message-ID: <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com>
Message-ID: <CALCETrUshiLMHyf4DShgDRtCvnzUVyRQgmgCiudvhuhw05cDxg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] x86: Trenchboot secure late launch Linux kernel support
To:     Matthew Garrett <mjg59@google.com>
Cc:     Ross Philipson <ross.philipson@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        dpsmith@apertussolutions.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 1:29 PM Matthew Garrett <mjg59@google.com> wrote:
>
> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> <ross.philipson@oracle.com> wrote:
> > To enable the kernel to be launched by GETSEC or SKINIT, a stub must be
> > built into the setup section of the compressed kernel to handle the
> > specific state that the late launch process leaves the BSP. This is a
> > lot like the EFI stub that is found in the same area. Also this stub
> > must measure everything that is going to be used as early as possible.
> > This stub code and subsequent code must also deal with the specific
> > state that the late launch leaves the APs in.
>
> How does this integrate with the EFI entry point? That's the expected
> entry point on most modern x86. What's calling ExitBootServices() in
> this flow, and does the secure launch have to occur after it? It'd be
> a lot easier if you could still use the firmware's TPM code rather
> than carrying yet another copy.

I was wondering why the bootloader was involved at all.  In other
words, could you instead hand off control to the kernel just like
normal and have the kernel itself (in normal code, the EFI stub, or
wherever it makes sense) do the DRTM launch all by itself?  This would
avoid needing to patch bootloaders, to implement this specially for
QEMU -kernel, to get the exact right buy-in from all the cloud
vendors, etc.  It would also give you more flexibility to evolve
exactly what configuration maps to exactly what PCRs in the future.
