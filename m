Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611CC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79A2214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 00:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579824096;
	bh=RRahF+ARZ6cJAqaF4zE6hus0930sflN4Y7agMfjizKw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MzeXW07CP6NlPsXuiGVFumN9c3up3rE8C4wu39w5ofj8Kap2LYL2P7WblD2EmwOSk
	 RkwW10OPtW8E4D73uNXq3OvyjxINkNcF1Nq8vFYmd8HGpHaORffUuq9ZJYwZ8XwiXx
	 j+L1PkHtVj1KrmprW/6tzETjiKvEnHaBILOdVu6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbgAXABf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 19:01:35 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41292 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729149AbgAXABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 19:01:35 -0500
Received: by mail-lf1-f67.google.com with SMTP id m30so21332lfp.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 16:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jhm2D+li3tmVDnNelGAqg3FFAOKpjt8nabPCXHsBG0s=;
        b=eKsTsz3Wf3wiI8V2rq1anbSVH1riJLeQn47OGE8BF0Q1CYE2V9ccR1xO7DlIcJ1pQy
         71wkXkKtS/oqShBMuWd3FnkQjd+IxNRrQR1+BU9RCFPCvDLs2DVCbN/VY4PESU/m18IJ
         xen30k5igK5m42e4s/djap8cawEzHd2B1YLu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jhm2D+li3tmVDnNelGAqg3FFAOKpjt8nabPCXHsBG0s=;
        b=kmIFT8Hedx+qW+9M13u2C9SaGSX8oFgOGN8YK1q1rrTamx9YyaQxrpVGDmJhtpJ0VC
         dZ92QuIV2edMeTxDUH4v2vaRHXeygyrcvxJPbonIQBUIQWyiHMYZvKXXp/W9Uk6/c8LZ
         YvQIlBZcqRPMR/PmUSQh6FXqzxBaHwTmuhpVDZVRG1O1xBg9ng9ZRdKlFUYAE763o/9N
         HPDS08tLIUfxMlHwEOeaGk26GbCJfOkquPFJG9C67u96RkO3SPMsc3Khhc9W3kNealSE
         /9IA4b/PlULc9U4h93iG6ZVB4G8uUl15VCjwxSO5e79Ehvyh9uNH5HLcjj4Hm1Ntt99Q
         9ROw==
X-Gm-Message-State: APjAAAVe+OrPaLhTSDoDsIx6sXKtAlbPANo1enNwF/YtUFJwOUJqC41L
        u8/e1K24G1aD9AsnCjIVCr3VIetxVLM=
X-Google-Smtp-Source: APXvYqyRfA1dSPG9JIhR0fNUrvo2pEXldpcgzoVtv6wBURFm++9pRzvS/BSum1HUMftGEBt+cPjjEw==
X-Received: by 2002:ac2:5983:: with SMTP id w3mr131144lfn.137.1579824092683;
        Thu, 23 Jan 2020 16:01:32 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id b17sm2056194ljd.5.2020.01.23.16.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 16:01:31 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id j26so339454ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 16:01:31 -0800 (PST)
X-Received: by 2002:a2e:3a13:: with SMTP id h19mr556562lja.16.1579824091393;
 Thu, 23 Jan 2020 16:01:31 -0800 (PST)
MIME-Version: 1.0
References: <20200123190456.8E05ADE6@viggo.jf.intel.com> <CAHk-=wgLR5JnaBgCtg0-AAxtdN3=4=LMp6-0212608=vbmCAxg@mail.gmail.com>
 <20200123202600.GG10328@zn.tnic> <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
In-Reply-To: <636d5f4b-c47f-77f6-067f-a6b342db5650@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jan 2020 16:01:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wibZoVAzGpO-OssKN8cidpCKrfdDcMaspM6JW-3fbcSmQ@mail.gmail.com>
Message-ID: <CAHk-=wibZoVAzGpO-OssKN8cidpCKrfdDcMaspM6JW-3fbcSmQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] x86: finish the MPX removal process
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 1:23 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> I'm confident I can send patches to the x86 maintainers and not make
> them too angry.  Sending pull requests to Linus, not so much. :)

With a diffstat summary like

 24 files changed, 2 insertions(+), 1697 deletions(-)

there's not a lot I could complain about ;l)

> I'll just plan to send it to Linus directly.

I do note that while I've merged patch series from you before, I don't
seem to have done a git pull from you.

But since you already have a git tree, and the tree looks fine, it
really is just a git request-pull, and you basically already have the
cover-letter to add to the email.

In fact, you don't even have to use a signed tag since it's on
kernel.org - but it's always nice to see, and you can put the cover
letter explanation into the tag.

             Linus
