Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BBC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6221206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585280974;
	bh=jr1lPHnHtEqW+YA8/Ve62viynsdyqWC4DGyTVWBuSkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1JHIpjXmGLCK+u3SK2Awo7r7WkToFe4BOpDU+E/5o/d97ebuwUvwJmEpZ9jo9c5kr
	 ob9ybcNg3BkXDwydKfK8GlHKp/2fHpcXVIbGYeAzrsYLGgrPcLDdOWYoLBO2aYX1ZU
	 EvrbUL/2xu6PBYOlXPT90CsEX3M6oDxpwfoHO9gU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgC0Dtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:49:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33680 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgC0Dtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:49:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id c20so6753581lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JGnIujlqsP1EwSxPZh4UU/rxnN8C1WE6pJPB0ya4XmU=;
        b=csoHctWwRiNSLM02vUHeKFr+/Ns1hF/fNbL0qoqNqKnu90xKMBYyEBSB9MHGlyiUzo
         f0BMHBAFAPD5cSj1pQhiBm6nq5JaTLlflr5ABnIcMKRBGMvqp3gkZx8RBqIq7mTo65Ip
         asSwoeIU4umfYFI0cBV04MdMuAUc/HNprzRrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JGnIujlqsP1EwSxPZh4UU/rxnN8C1WE6pJPB0ya4XmU=;
        b=kb6yQ5TCQ8PS6EXNSh6cki+XDxGuUc4XI7H9fEBXPD3SX61SL1WgnkwYBtSaJsDMvb
         nDz6IgpmffV6m2dar2aHtzMXDytQWZNo+nqQx4rRwLffkTFddxE29+TASeexV0Fy+IPG
         p7T6h1ZyqoPFiREOnU+BctQ+bN31gSlKj1bpSx/TqEO2fMt2bXvOUnr6wvnpFHnIbhta
         AFftHdXsa14Kn042uFvsIBI5Xo6igGnEfSd23eQutKcjCB42i+ohwwYOEdP8IDc35nbV
         h2cbr8VIrhaNap+bohQ4jc2TqV86aRjSP3ptskDQReBeiZ/Y3rkt8W2HwRNZhfvzWDbo
         a/MQ==
X-Gm-Message-State: ANhLgQ3+KtfvUqIgeMd6XPlAcIe1OvbZ5R3vXSwxS9bSxGipipcsNdTW
        7pURAbrhSLp5At6q11srsJ7pTNIyDwk=
X-Google-Smtp-Source: ADFU+vs5pGbbpBo418KeYeomXKlwl7nrrgRUk/fvq1uzXKYG0/IgR1Z99HhZlWT9DMby4aT4pcSrgw==
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr7770773lfp.21.1585280967652;
        Thu, 26 Mar 2020 20:49:27 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m17sm2202023ljb.61.2020.03.26.20.49.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 20:49:26 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c5so6728075lfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:49:26 -0700 (PDT)
X-Received: by 2002:ac2:4a72:: with SMTP id q18mr3577678lfp.10.1585280966276;
 Thu, 26 Mar 2020 20:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200323185057.GE23230@ZenIV.linux.org.uk> <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk> <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk> <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
 <20200324204246.GH23230@ZenIV.linux.org.uk> <CAHk-=whnTRF5yA2MrPGcmMm=hXaGHfC2HEDtNzA=_1=szhJ4-w@mail.gmail.com>
 <20200327024227.GT23230@ZenIV.linux.org.uk> <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
In-Reply-To: <CAHk-=wjn9Ohb7TW3OxaS0MTURi=boXzk=0Lo0WT-pN2CPE9PzA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Mar 2020 20:49:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjk+GjHu-P_KNW3zw2uDsz6yz=U2CUT2hT4jKgyxLEfPQ@mail.gmail.com>
Message-ID: <CAHk-=wjk+GjHu-P_KNW3zw2uDsz6yz=U2CUT2hT4jKgyxLEfPQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to user_access_begin/user_access_end()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 8:42 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I will not boot with both series applied in a test-tree.
         ^^^ now
> Wish me luck.

Seems to work for me.

That's with the futex bug fixed. Not that it looks like it would have
mattered except for the (unlikely) exception case, so my testing is
meaningless.

But on the whole it seems to work for me, and I can't see anything
else wrong than that incorrect branch target in the futex rewrite.

            Linus
