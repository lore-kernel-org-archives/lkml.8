Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E1C4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C1A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8sfd8Zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCWTk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:40:28 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42634 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgCWTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:40:28 -0400
Received: by mail-ot1-f67.google.com with SMTP id s18so5135772otr.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U/bCL8bTfl1EfMNw+Nryh8HIXGeBo7ogCKX6OXjV2XI=;
        b=O8sfd8ZpMydvMK+IvZp6FXI5zLQGBDwfZ9T5ESPGPGpr3zm7fVX9fG4/z4qoJ0Js7/
         tBXl3LaJdCPEyoP6WyQIv+gnwYEilquwbjHBQHq+cS4O8A/rI+yxrKq4lCIubSzQKEHz
         wgbzyaRPRWx4lsmtI6SrVj5z7aeHJJIQhPmppPO+lmyDjMYOZpghKtzCiqloJ3vhkUXy
         4EhemGdf+vgUk74CirfGCvmW77Yj7YBZgyTzQXkGXc7uGmOD3+1jBMN2nw979Ykt7ZA5
         S3xQNHFEuoNR9R+WmOhV3l3sMgDt8KexSQ6megZbQfpl1171YClobxqHO2E9G+TMY9lI
         pi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U/bCL8bTfl1EfMNw+Nryh8HIXGeBo7ogCKX6OXjV2XI=;
        b=PXLef4IezCn5ZN1bCUCe0bH3o8a7rIiagGF8MPXL22zf2mjDEc5nclCY4wEKNsxwYt
         Ua+xLt7Sb9QBw3T0QMiu2NSJz14dhXh9ORDhVxkVrNHdGLNFsT54IBkjBiwZjYLan50K
         aR/tNmSJvF4ytNqqR1WfwFJklGcggqHh0j4Drh8dh1RCBEA7N/j6e56+uO3U51qi86c9
         dSAEH1bachmiFybJv5ZSLvNnc8Z/K4UTeZr6MwgaT7krvuwKUwcqoOHVCvThOR6fqfws
         DJ31SH9FrYhcp1hzeudZUg/yde052zmYA4FMNiZSGRucKGKZXQY8bFH65HdzyedqVzjZ
         YK+A==
X-Gm-Message-State: ANhLgQ2RVzt4DdcBQ91AZcIP1bTFFMQzxNhzo0JkLQ6lOFUpUM+4mEi9
        vs9TGufWp3xeR6A2u079Uk1xKaz4OyveCYV5u5U/DJZr
X-Google-Smtp-Source: ADFU+vt5VGYAFKbXB0lvMmOyshFUCU66epvIJ+plFNJSuqinf37hCg+t5thlbAnCcaNIz/FHhefVC3w48amdDKnKJTI=
X-Received: by 2002:a9d:414:: with SMTP id 20mr19810316otc.300.1584992427120;
 Mon, 23 Mar 2020 12:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com>
In-Reply-To: <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 23 Mar 2020 12:40:15 -0700
Message-ID: <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering -- adding initrdmem= is easy, do you think we'll ever be
able to end uses of initrd= in the ARM and MIPS world? Is it ok to
have these two identical command line parameters? I'm guessing just
changing initrd= would be hard.

Do we just accept initrd= from this day forward, as well as initrdmem=?

On Mon, Mar 23, 2020 at 12:06 PM <hpa@zytor.com> wrote:
>
> On March 23, 2020 11:54:28 AM PDT, ron minnich <rminnich@gmail.com> wrote:
> >On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor.com> wrote:
> >> Pointing to any number of memory chunks via setup_data works and
> >doesn't need to be exposed to the user, but I guess the above is
> >reasonable.
> >
> >so, good to go?
> >
> >>
> >> *However*, I would also suggest adding "initrdmem=" across
> >architectures that doesn't have the ambiguity.
> >
> >agreed. I can look at doing that next.
> >
> >ron
>
> I would prefer if we could put both into the same patchset.
> --
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
