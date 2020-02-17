Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FC4C3402A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C7D20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 21:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581974448;
	bh=0GJGVNuJ/Rfj0cwm/H5ZEYdtwkrPDr/Nvl/Dav2LPrE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IExtG7wtVvXjUCYOnk/njZ6Nl+smiEclzuWBbDVaIlJilB21M50H0WvvYfGSA9GN8
	 c1ov5oqR3tAS8i5R8aKNSOykqmVlMl21TZx/AFecXFtmQ8VHh9/rzwPKpmCT3WZWfl
	 jzSw+2X/YWaxRRLSsE3Fe859xPZpY2u3gQr7T8tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgBQVUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:20:47 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37591 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728254AbgBQVUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 16:20:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id q23so4361106ljm.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=udxvjk/3f801oiHIjlXs33vrkAUOXT/VVtYKhiHosbA=;
        b=WcQxzpj1Ur2pyqMPFrqi4wkJlXAMrMPJOaoeFhccxC0Ki8Ms89kihm6E1yACkpuwbf
         DbgQ3rXZYL0Zv+p8ZF747ormJh0UsDz2YmKD1q4dL7o9yvF90HjGMjb/mk/5EI9RnCK5
         WF8cHHUnPUgpke3w0BcXO0kwz0FyyfcVKpvL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=udxvjk/3f801oiHIjlXs33vrkAUOXT/VVtYKhiHosbA=;
        b=GYl0GubHcMU02+BKPzAyCc0qJDjIpJWmTOQ/uw7mGrBTuw9D4fez23xaqx4aDpVhvX
         zB6iLJZD56HeJ7WsJXu8stEkLU1QCUfJRmhiPD0Edz834PM+daNR+cmp3jKBP4Q7/JcG
         OE6LE7vvk1iLNQRZhxA745YydcFj3gBmvXzMFqRiqnf6KO67tXVeitihEgjeHNqZ+3mB
         evCxGp0UL8FWpxsGMH2hWbm75jIOeLiwt4hddU7pAgQ+s/iOif5sFwN/pvWhmJjXblR2
         rEpvFNkOyWHNVNgCrkpLRMN+HnVIkgGMVMM9Bhue6wubBINE/9qjXhHy5OnJ92f0vGmB
         LVHg==
X-Gm-Message-State: APjAAAWiVtEQxl1MKGLKZZ7dAWLwcZ2xzr0N8jSx3/YERj3Qc8VfsVuX
        q+Cg/g44H/oL1JbpsR4Hz4+zVfdZnZ4=
X-Google-Smtp-Source: APXvYqx1AwYmR2Bi4ZqRtdsLqYxFg6+C402pFT2g1k43D7GzNePXenrQ6qMXesp0d7/OwSG/JudpKw==
X-Received: by 2002:a2e:99c5:: with SMTP id l5mr10701218ljj.88.1581974444546;
        Mon, 17 Feb 2020 13:20:44 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id g27sm924747lfh.57.2020.02.17.13.20.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 13:20:44 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id 203so12851250lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 13:20:44 -0800 (PST)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr8678032lft.192.1581974442759;
 Mon, 17 Feb 2020 13:20:42 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <158195649797.19707.10238097810752281104@skylake-alporthouse-com>
In-Reply-To: <158195649797.19707.10238097810752281104@skylake-alporthouse-com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Feb 2020 13:20:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wik6C7uCyPZ_qwv0M29uVUdgrpOdubfaVHF8FVBAsCivA@mail.gmail.com>
Message-ID: <CAHk-=wik6C7uCyPZ_qwv0M29uVUdgrpOdubfaVHF8FVBAsCivA@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 8:22 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Linus Torvalds (2020-02-16 21:32:32)
> > Rafael J. Wysocki (4):
> >       ACPI: EC: Fix flushing of pending work
> >       ACPI: PM: s2idle: Avoid possible race related to the EC GPE
> >       ACPICA: Introduce acpi_any_gpe_status_set()
> >       ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system
>
> Our S0 testing broke on all platforms, so we've reverted
> e3728b50cd9b ("ACPI: PM: s2idle: Avoid possible race related to the EC GPE")
> fdde0ff8590b ("ACPI: PM: s2idle: Prevent spurious SCIs from waking up the system")
>
> There wasn't much in the logs, for example,
> https://intel-gfx-ci.01.org/tree/drm-tip/IGT_5445/fi-kbl-7500u/igt@gem_exec_suspend@basic-s0.html

So the machine suspends, but never comes back?

Do you need to revert both for it to work for you? Or is the revert of
fdde0ff8590b just to avoid the conflict?

I'm assuming you bisected this, and the bisect indicated e3728b50cd9b,
and then to revert it you reverted the other commit too..

Or what?

                     Linus
