Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7663C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9724A21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 18:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587236006;
	bh=UgXOgSwIMyfiGPkOtWwuniPLy2NcYx/OJ8KMhNGbheM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RObXVakJJBP9wtyVjzFwo4EGuStE6BYO0HndrzklywjjOPbkCDwHbI/aAdvRqgf6t
	 6oOLVeYb8+jqQLr+1JI0Er0YjMib79JQ/kaXFq3a/SiPGyxOM4FMwAsw6T7Jj5XcVi
	 rBJ6xbKDY6hfUDd5pRXQmIDPK+yyVH9BTYQFisfg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgDRSxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728130AbgDRSxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 14:53:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E7C061A10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:53:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so5563127ljg.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=Dab8X2CtWipiSivi9nyLxp8nBHQpWedKwzW35yNj8kBU3VxCHrB+3Kn5U3rtIjeKoA
         Lw3k/ndceMaBnN8HktM5POukz2zYdQKxOk+s6N6D5bBob3ys4IoAy4L7IIPc1NiF89LI
         qpPs2HFFi+SoqSVPJ7yi1QNfgGKP7Teiklti0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJRI8oZ6j+rGEg2+OCymOS7794uvyRZcSR2Htjt5TI4=;
        b=gVy0cImD/r9sJMLCq04XHtEPoa/mXjmZfXx0myTkJDYwxEYFqXznrDAMj6CFjBxQtJ
         yjC1/jnlNtiypW7AqnQb6ayiMjun41Jz490bf5afJC8TmGET3smdAUe7xSKQPzea8+lK
         laJvXCq7yjcs0RYtDYxrpPwQcbQ4VxVQEYAp0am9cOeEUjzTEmHkDBJWKnsp1IF82fQB
         8UDMQZ0OrfvM+Bv6k0dshOiREI/HzOheXu9ZBFVoDVzr4b8GQFBiymGrEMLXe/jXHF4y
         czzll8A3DvwfSbbCcFlxsY7QfpItJEJksD7ooZM8QEyluBCEhMG31iPSXosrOW89nntq
         m1IQ==
X-Gm-Message-State: AGi0PuZAVfcLR2v0ZVgc7d4J4JMafsUIqi8GRmrRGFoSrmJ4S841XGd/
        I7rQIuv8k8f/hnDAuFnmqztE8fDX2j0=
X-Google-Smtp-Source: APiQypICP6M1270gL4lsm/8gNhm/azlUy7ce5MR/Yh7QrZEp7fT+W/MmOBdSE0UwGaC0c+W0H26ZIQ==
X-Received: by 2002:a2e:870d:: with SMTP id m13mr5348632lji.64.1587236001146;
        Sat, 18 Apr 2020 11:53:21 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id l18sm5156739ljg.98.2020.04.18.11.53.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2020 11:53:19 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 198so4575376lfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 11:53:19 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr5483360lfk.192.1587235998911;
 Sat, 18 Apr 2020 11:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200418184111.13401-1-rdunlap@infradead.org> <20200418184111.13401-3-rdunlap@infradead.org>
In-Reply-To: <20200418184111.13401-3-rdunlap@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Apr 2020 11:53:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Message-ID: <CAHk-=wjSzuTyyBkmMDG4fx_sXzLJsh+9Xk-ubgbpJzJq_kzPsA@mail.gmail.com>
Subject: Re: [PATCH 2/9] fs: fix empty-body warning in posix_acl.c
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        target-devel <target-devel@vger.kernel.org>,
        Zzy Wysm <zzy@zzywysm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 11:41 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix gcc empty-body warning when -Wextra is used:

Please don't do this.

First off, "do_empty()" adds nothing but confusion. Now it
syntactically looks like it does something, and it's a new pattern to
everybody. I've never seen it before.

Secondly, even if we were to do this, then the patch would be wrong:

>         if (cmpxchg(p, ACL_NOT_CACHED, sentinel) != ACL_NOT_CACHED)
> -               /* fall through */ ;
> +               do_empty(); /* fall through */

That comment made little sense before, but it makes _no_ sense now.

What fall-through? I'm guessing it meant to say "nothing", and
somebody was confused. With "do_empty()", it's even more confusing.

Thirdly, there's a *reason* why "-Wextra" isn't used.

The warnings enabled by -Wextra are usually complete garbage, and
trying to fix them often makes the code worse. Exactly like here.

             Linus
