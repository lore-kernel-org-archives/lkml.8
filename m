Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76FAC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9328206F0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 20:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580242039;
	bh=+t4gH/6cEZWpTIvs+VphKJu6DJ1p8PO9dp9lHOUgO5c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ghvmXWgEWR802Q+5/AJbdZTSR1VfRdf9bjR8afLMccAAao64dlJoziC3lgXVGOY4v
	 0K1exgAGQ+4jt7fkiT1qkR7HZisMDV2beCWH8DGRKPkFMm+0L5J07HWyY7VouMYwNH
	 Xa5lrZOSl7v2qmusPp4CyoTtVlT8YeotCmZMXb3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgA1UHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 15:07:13 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35219 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgA1UHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 15:07:13 -0500
Received: by mail-lf1-f68.google.com with SMTP id z18so10086917lfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Nlt/tjFD5YomiN29t88wVXqgOVY3HN5LwPb1TeoyMQ=;
        b=fjxKCNEIL8MNiobXiUQ2LZhUR17pH9rB7rnCnKQhsYTU2ytQnMxMLjeZBNimhw58SX
         xQ3azVty531ADvo2tmF/+jCOsLaafMFFiGNfts71TboTNbjQhs+bXBbbKB3dk3WkJMn0
         cqtZeLCpFlkEAbetKQLcpsIOX5oAEJOmI0ReY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Nlt/tjFD5YomiN29t88wVXqgOVY3HN5LwPb1TeoyMQ=;
        b=lwVbAhgFkPyd3rsS7Gp2ZU0isYGvHYcGCeua4jiTdjJzhfyOV7qjvBuFeXCjEUPYKb
         rNRcr+ryp9E9AmmJvryRZCgzHTWRuIZmY3QTBwwKFzS2xrjJVYxOsF5v0nZ9nnTJ+Mux
         3wHJ72F3RowQF/RqueVN6Urlu9IZLZJFhazgAlO245T+9UZBJcv0/gcOoKFr9YieHivh
         NNbz9ljG7BFI7Zpgtr8SwI56dRJd9YBdqeXeJuy6avHDc1lVHAv90OeIxHDOvMAIW/ya
         RYLdSZNSiWd54K/+IOk1k+okYP5Y3qQCpdDc8enDSByEQRL4BpOIq5OneYfiY+Ee2VBc
         2meQ==
X-Gm-Message-State: APjAAAXGoCkqRWDRN+HQ122QjzwruzgIMunVCtVhQ3tLrKM3YxaicMvl
        XXQUcDv2zMa8n06Ptw88u2YgD0zy8bg=
X-Google-Smtp-Source: APXvYqyOyGN3/V2NHD2Nbk0h+DBNUrb6x0coogU3E0J878zQwPE2LdlLYRNggoMUu7KMXtwOsUeEhw==
X-Received: by 2002:a19:5007:: with SMTP id e7mr3364384lfb.153.1580242030535;
        Tue, 28 Jan 2020 12:07:10 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o6sm10182850lfg.11.2020.01.28.12.07.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 12:07:09 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id b15so10097958lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 12:07:09 -0800 (PST)
X-Received: by 2002:a19:f514:: with SMTP id j20mr3346825lfb.31.1580242029371;
 Tue, 28 Jan 2020 12:07:09 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
In-Reply-To: <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Jan 2020 12:06:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
Message-ID: <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Ingo Molnar <mingo@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@suse.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>         ALTERNATIVE_2 \
>                 "cmp  $680, %rdx ; jb 3f ; cmpb %dil, %sil; je 4f", \
>                 "movq %rdx, %rcx ; rep movsb; retq", X86_FEATURE_FSRM, \
>                 "cmp $0x20, %rdx; jb 1f; movq %rdx, %rcx; rep movsb; retq", X86_FEATURE_ERMS

Note the UNTESTED part.

In particular, I didn't check what the priority for the alternatives
is. Since FSRM being set always implies ERMS being set too, it may be
that the ERMS case is always picked with the above code.

So maybe the FSRM and ERMS lines need to be switched around, and
somebody should add a comment to the ALTERNATIVE_2 macro about the
priority rules for feature1 vs feature2 when both are set..

IOW, testing most definitely required for that patch suggestion of mine..

                Linus
