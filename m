Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC06C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F062073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bD+O85KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgAMH3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:29:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgAMH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:29:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id t2so7423009wrr.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 23:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Whdn2m/U1+HR1RNQq+8AxWESiMgdzhNcD7fmHq1i6N8=;
        b=bD+O85KGDadiliWt3Ps6YuhsgSPwXU8EYhpSch8p+13GrX2HlxbLekt0Q7m5w43NTc
         KU72X99cw/UqTi2iXQzYiev8cXt8UvHfsC5iEU0o9JjBYfQP4IGFo4loiZSrQcHaj+ph
         qfEe8OckgtbZyNM4ZcfXyT0L+HB9TdxF/T8EfwYEQX9bQV905u7RP61+cj0ZsXOaJUQ2
         BnT4z6Rmzco6HRo3UCQx9fBV4dSbRjp4OJtXJ7PFXsBGmP14XS+uTFBR4wQ1FXrYw7sz
         mimNnG+o78KhowrJbnHEPPTi3dlIhRe1x9ud8xc0psJ0tCP9dCDq30klcJVBSSjsPXOk
         Mdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Whdn2m/U1+HR1RNQq+8AxWESiMgdzhNcD7fmHq1i6N8=;
        b=I3qpIzEOyM9I8W3WjCdG7HZnSimwF/SL4uCYCIG5OI5KjvB8bJMYb3OIwAxWOv4hCv
         dCp7UZujEa8S1eq70z88lTfaafJF+1WJrqft56OzVSPR8nJlFAEphjiiQp9qXem8ebOL
         9D14zQOT0OlxS9P55PoblUWGcKG+BfWYBCo5D1dP0Maata+zF/T208ewRMc5n7LMWXay
         WVowHmxftv9ra+WQ8FbB/kcZWO0KcoSxzLEe+RPkF/9y+X2p3S8Jvo3aVJLSnubC7eyv
         8i0LLUQk+8h1tzhoB8SRnbXqEHSyV++tZ0HHxvdE3ueoY6sENzOjn8fBAR8OsRPa1em+
         7LxQ==
X-Gm-Message-State: APjAAAWo6XcZQVGuYlvFoIi3Ar1sWSAEo73893seAgenzYPJ/fAXfmdU
        wrKVbyLCcnZN5pGHURipj0LX58KM53Uxd3JX/t8erw==
X-Google-Smtp-Source: APXvYqybS5eWEDwKlCVck9fBn8ODoIWsy3woTpWRduDt3Jqrcph4In1sPlEdRF1YEQxWKwUulSCwOK9Iz13o914Trto=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr17078276wrw.246.1578900560096;
 Sun, 12 Jan 2020 23:29:20 -0800 (PST)
MIME-Version: 1.0
References: <20200103113953.9571-1-ardb@kernel.org> <CAKv+Gu8pzDSs6G5k9JfX77NB4q2kerxSuprnzFzeGBPd2kPd5g@mail.gmail.com>
 <20200110181312.GB83292@gmail.com>
In-Reply-To: <20200110181312.GB83292@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 13 Jan 2020 08:29:09 +0100
Message-ID: <CAKv+Gu_4GNdu+72iGN5wnzfDx3iQ0uM2x9wC6pOBPvqAvJu8dA@mail.gmail.com>
Subject: Re: [GIT PULL 00/20] More EFI updates for v5.6
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 at 19:13, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > On Fri, 3 Jan 2020 at 12:40, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > Ingo, Thomas,
> > >
> > > This is the second batch of EFI updates for v5.6. Two things are still
> > > under discussion, so I'll probably have a few more changes for this
> > > cycle in a week or so.
> > >
> > > The following changes since commit 0679715e714345d273c0e1eb78078535ffc4b2a1:
> > >
> > >   efi/libstub/x86: Avoid globals to store context during mixed mode calls (2019-12-25 10:49:26 +0100)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-next
> > >
> > > for you to fetch changes up to d95e4feae5368a91775c4597a8f298ba84f31535:
> > >
> > >   efi/x86: avoid RWX mappings for all of DRAM (2020-01-03 11:46:15 +0100)
> > >
> >
> > Ingo, Thomas,
> >
> > I'll be submitting another PR later today or tomorrow that goes on top
> > of these changes. Please let me know if you would like a v2 of this PR
> > with the new content included, or rather keep them separate.
>
> So there's one complication I noticed, there's conflicts with ongoing
> x86/mm work. I've merged x86/mm into efi/core (and will send the branches
> in that order in the merge window), and the final three patches conflict.
>
> Mind sending those three patches and your other patches on top of the
> latest efi/core (4444f8541dad)?
>

No problem. I'll rebase and retest, and send out the result end of
today or tomorrow.

Thanks,
Ard.
