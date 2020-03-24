Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE79CC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845322078A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 22:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585088101;
	bh=f77uglcSmAxsgAfAwfMJhkegOVaodxUDDK7fzLLCf3U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xdIj5teN9PIZp5shyRQ22L8ObhH91x34d9YLhnnUF+L5nfDjYXIovBxLryo9OOTdb
	 EznMHyeNU7VQl2oZE2dKQ8biFz7uHIy1HQme3a7jXbAKiVCt2PVZHVxE3iy3++5kJV
	 zota4Tuc3/82nsImas4umf3yjiaRKnVRC+mtjqjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgCXWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:15:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44591 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbgCXWO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 18:14:59 -0400
Received: by mail-lf1-f67.google.com with SMTP id j188so115131lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lj+oeqAAr2QWrfodkjia2HsTEsCYoinzCXF/BidYSkw=;
        b=WDwBRAbEdx1evVQLfeRDVb4gQqRZeJPOFJ7INZV48Gor82hEQSQrzV5JAlG9dfeoH7
         UDlHtDEnZWx5N1TsSoX/y3BerIpUKI2lMnhnSakfkBzvU3z4RGxqVYchxQA2PMjkMPGE
         +RXVLvtFm4wKVJ+4tGwthSHjOm1BXTFch6qZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lj+oeqAAr2QWrfodkjia2HsTEsCYoinzCXF/BidYSkw=;
        b=P3lJzOiUWZSGusK9KKat0qsqCTKHgL3RM9pC+sqMql3NgVL9yiTWmwNMz9P6c5fxDQ
         NWiFlbzsWPZaIi4V7bMwyIQIb38EpxCbhAgbb7D2/zDRfsBs9FK+Ds1tRFWOsmjq0Xnx
         K6O/zyUtvXZj1Ud+MO3KXMprDAWg3BzGASwk5mQ4WAMpz/oszuR5otQZM9TiktR8/rJ+
         3qNNXfb1wDq3SoIjpElLtRp86GO+2f/XKI0QmZ83PCkhFPhePsiFnej+uFjYTw2MYi5+
         aEOhoHU7nzJ+TPn3Mxnw9eGbZYYoPC3j8e0WSOThbCunaVIgIX3E0HIYj5vPh4YeFbfB
         SnSg==
X-Gm-Message-State: ANhLgQ1P+jSYZvGCheY5NjARHMLHeSXKogVqmfxCQTKC7Wbxxm532tpy
        N1O1sLRKTWxTLrcS/zdT6JDBZk/7u0o=
X-Google-Smtp-Source: ADFU+vs/mc5Dq6dQ3Yj9ZRJ2521VP6pirOJJjKDLurOhvwUuTYjCWd6CoZDAf+OIaM9Z0R2lP23wHQ==
X-Received: by 2002:ac2:41c2:: with SMTP id d2mr151854lfi.164.1585088096036;
        Tue, 24 Mar 2020 15:14:56 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t22sm210810lfl.22.2020.03.24.15.14.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 15:14:54 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id q5so109953lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 15:14:54 -0700 (PDT)
X-Received: by 2002:a05:6512:10cf:: with SMTP id k15mr160890lfg.142.1585088094224;
 Tue, 24 Mar 2020 15:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200115122458.GB20975@zn.tnic> <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com> <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <20200324091437.GB22931@zn.tnic> <CAHmME9q2VuhN+Dhi-nzuJKPjXo8dZq013cZ-0x0t9StZFXCAJQ@mail.gmail.com>
 <20200324162843.GE22931@zn.tnic> <CAHk-=whXBO-Z=Ra_UX=w_LefG1r6iLXcPT=sLuZ+EaKFtWtCBQ@mail.gmail.com>
 <20200324164812.GG22931@zn.tnic> <20200324214204.GB3220053@rani.riverdale.lan>
In-Reply-To: <20200324214204.GB3220053@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Mar 2020 15:14:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFfi8J+vMccQ5VYZMecxyAeA9Cpt-Kui-GHZBbB29OhA@mail.gmail.com>
Message-ID: <CAHk-=wiFfi8J+vMccQ5VYZMecxyAeA9Cpt-Kui-GHZBbB29OhA@mail.gmail.com>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 2:42 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> This is just a documentation patch right?

That patch, yes.

However, there's a second patch that knows that if we have binutils >=
2.22, then we don't need to check for AVX2 or ADX support, because we
know it's there.

           Linus
