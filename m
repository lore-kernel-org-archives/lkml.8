Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACA3C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93CC2067C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580582735;
	bh=Id3qYUe/BsmcaUwct4ysNg56F9FagbrajjZR23Jz8pM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pLnX8K3LabUF82KUihe42BAPazJ8n762ENlEpWb3HT3tTjHuX/Cpi32lwzSqOfLL3
	 9FcXoijYQaobswtqF8GEB81/gyolmJsM7xE17IHyPqf0Sv47gsre3F2rTV0SYzM69v
	 4BuiH+jds1a+6wKdVscLaNP73bWaoRfGFXxD7uSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgBASpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 13:45:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33889 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgBASpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 13:45:34 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so7067615lfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p9t4kwJmW5ARKxnXZ4PSmUiIMEWNVmwbZmARfKh1tBE=;
        b=gx1D0+QmyxgtSASu1K01jjLcdzW2W7QVPS+we3A9Osh2vJkXIZD2WlELk3mYQf8AF5
         mxuurGDEa676cmu7D5RHAqbVIOTsin6OjZZYYXMc1rOVI/MXNCchXu1aRPSE8DG1p2LK
         ZM0CMUzd+IUSL1wjtPfrRtUrWlE/WTu0uwLao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p9t4kwJmW5ARKxnXZ4PSmUiIMEWNVmwbZmARfKh1tBE=;
        b=S8i0LDxVUH4kiJhyE/6xFVdJSndurySt19rnbXVCM01eZI4MA5q/RmSPc55tsAgygL
         R5aYWG9bVyZFyMuP1T5mKSVzAXuAfFYBpH8l3ztzGWb0DCy3cWANJ5eZCw8ULXLZp5hf
         QECHAzHJbuWiBRhYTqKOSzZHzxymND83AlOSIwo1soAsOWB6PoY2eYJH0rsjvwltALdb
         JMFENZFB3QK8pJkzZxTrmquncyaj19Pm51GFnvD9XguL8ow8IT935HF7noW+Pl/f7l7Z
         p2kBJyncFSzyHEQ3GzN35BayhIx14Ynrp7//9evIF3eMFVAtyD6H7sIq9HuagBLHoTV/
         TxEA==
X-Gm-Message-State: APjAAAXZquo/Zs70GtYZCpvyGVTq931U0UqGa6nbejApl991c1zfhU/c
        6jm8ngyg8rydwKzEOW1kYgJblrNHRSg=
X-Google-Smtp-Source: APXvYqyQd53c974LbD2nkToY7DSU0+L3A9syueoEMYLm1HMKppRdjJjKPAIECvhItzCSiJTOcjyq7A==
X-Received: by 2002:a19:cb17:: with SMTP id b23mr8323749lfg.201.1580582732071;
        Sat, 01 Feb 2020 10:45:32 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y5sm6295734lfl.6.2020.02.01.10.45.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 10:45:31 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id q8so10533362ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Feb 2020 10:45:31 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr9494329ljb.150.1580582730741;
 Sat, 01 Feb 2020 10:45:30 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAS625YwKpv4wfKO78+Rexe2fP5pLDbMD4r71wwiQfN0Ng@mail.gmail.com>
In-Reply-To: <CAK7LNAS625YwKpv4wfKO78+Rexe2fP5pLDbMD4r71wwiQfN0Ng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Feb 2020 10:45:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTEVwmj-PH98reZTibx+C_GLwAmXO0RFmJa9weZcg70g@mail.gmail.com>
Message-ID: <CAHk-=wiTEVwmj-PH98reZTibx+C_GLwAmXO0RFmJa9weZcg70g@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] Kbuild updates for v5.6-rc1
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 8:06 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
>  - simplify built-in initramfs creation

Hmm.

This may simplify it from a _technical_ angle, but it seems to be a
fairly annoying step backwards from a UI perspective.

Now Kconfig asks a completely pointless question that most people have
absolutely zero interest in. The old situation was better, I feel.

Basically, I feel that from a "get normal users to test development
kernels", our Kconfig pain ends up being the biggest hurdle by far.

The kernel is easy to build and doesn't really require all that much
infrastructure, but generating the config - particularly when it
changes over time and you can't just say "just use the distro config"
- is a big step for people.

So honestly, while I've pulled this, I feel that this kind of change
is going _exactly_ the wrong way when it asks people questions that
they don't care one whit about.

If I as a kernel developer can't find it in myself to care and go "why
does it ask this new question", then that should tell you something.

Why do we have this choice in the first place? And no, it's not a
"simplification" to make life more complex for users.

                   Linus
