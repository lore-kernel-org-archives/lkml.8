Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3594C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA432064B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:09:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UvsgbLTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGUBJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgGUBJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:09:31 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E195C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:09:31 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 12so15911365oir.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 18:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dt+Q1yBp4pDTEEa5JxC/tBw6WPMfkbJUYHcrzD2fQPw=;
        b=UvsgbLTUQVe3b9JkR+S3lcYaaULY2+DOIgYkocU2xTKRCoNAhp507MLqfV8Tr7TxY5
         SV2680GHMFFcbul/qFtIEHUMySCfPwia7v4SzLorXXNiUDtiD7SZ9pOE2+AnZPIxqCrp
         nAJ9T6tfwuFOr8XBFfc9SwXZAdsJkxeP/C6j/NqQJyf+3vXmHBVk56fpwRATQ6TWtoOt
         gkob0DsXY93bLDeEgFEEyShn8N6C7hky2zBopNoCIWijwswFg7cyrrQssMsACCIxfoXy
         8LJoO6CFPVZ32L5qPqKXFAVxKcNVCYvNxpdATzgIgnvq3t5A8Ld4C60w5CNENQWJM2M6
         d2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dt+Q1yBp4pDTEEa5JxC/tBw6WPMfkbJUYHcrzD2fQPw=;
        b=l4uQV3cZYxgSABs7dyMqYDzZd6+cndMCijZQ6DnIklOpW5ugU1J5nPXG0BkqNGOQ4R
         tNKTlEPGUmvMG2Ec6J11kXKs6sExkXWuIJr43rh3qHeqlj1N0Em0mAKF+AdAJtjRup3j
         k4K19evMMY+8ofw9GWlkmC57F92AG7E/zV18n4ZteF7yr5nhxVFqavYm5j7RrAoiMH8O
         5WFM+1P3mZAGk2f8WY2CG7K/2RPqrYSc0lrf26ROBewCOq6eu2uXxPC6toT9d6fMqfeR
         hpE0rFUNAuxTc96+7yzonMnFhKT8NfnQ9dyrQwBY0iCRnIDArkeu0gofLt9wE1AXZ+9s
         t54A==
X-Gm-Message-State: AOAM531YXSLqkJhQ7UwHA4M3RqnKvgXSYbg3AR+KKyHrSxDSE4Z3dl1C
        OsncvNBaEgbPT1tJY3Z+UcCEjjqrn3HnumHzSCQ5UQ==
X-Google-Smtp-Source: ABdhPJzbi5+F2TpRM+GQt+/eaPnbEZR9u3OoIuc3AKHNzYvH8Zc12Ws1ii+wl9fUXQMMJAX4w6v2msuWZo+eFSwG/us=
X-Received: by 2002:aca:d643:: with SMTP id n64mr1432769oig.33.1595293770513;
 Mon, 20 Jul 2020 18:09:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200714120917.11253-1-joro@8bytes.org> <20200715092456.GE10769@hirez.programming.kicks-ass.net>
 <20200715093426.GK16200@suse.de> <20200715095556.GI10769@hirez.programming.kicks-ass.net>
 <20200715101034.GM16200@suse.de>
In-Reply-To: <20200715101034.GM16200@suse.de>
From:   Erdem Aktas <erdemaktas@google.com>
Date:   Mon, 20 Jul 2020 18:09:19 -0700
Message-ID: <CAAYXXYxJf8sr6fvbZK=t6o_to4Ov_yvZ91Hf6ZqQ-_i-HKO2VA@mail.gmail.com>
Subject: Re: [PATCH v4 00/75] x86: SEV-ES Guest Support
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It looks like there is an expectation that the bootloader will start
from the 64bit entry point in header_64.S. With the current patch
series, it will not boot up if the bootloader jumps to the startup_32
entry, which might break some default distro images.
What are supported bootloaders and configurations?
I am using grub ( 2.02-2ubuntu8.15) and it fails to boot because of
this reason. I am not a grub expert, so I would appreciate any
pointers on this.
Also, it would be nice to put some error code in the GHCB MSR if the
guest dies for some reason in real mode. Currently, it just dies with
no information provided.

PS: sorry for sending twice due to the wrong email body type.

Regards
-Erdem


On Wed, Jul 15, 2020 at 3:10 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Wed, Jul 15, 2020 at 11:55:56AM +0200, Peter Zijlstra wrote:
> > And recursive #VC was instant death, right? Because there's no way to
> > avoid IST stack corruption in that case.
>
> Right, a #VC exception while still on the IST stack must instantly kill
> the VM. That needs an additional check which is not implemented yet, as
> it only becomes necessary with SNP.
>
> Regards,
>
>         Joerg
>
>
