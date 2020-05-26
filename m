Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38946C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BEE1207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390701AbgEZT5G convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:57:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35515 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389442AbgEZT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:57:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id z1so5140867qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tv568JygARptrMAgf1Gov6V8e1gDgQj+1HZxw3kgZEU=;
        b=EC90a24b9pMqem3twU7qcw3qTFK2sxJAO29od3RERXuOPaCrvzaLnC3GlVERe23+cL
         WkzumxmAuYhMLKCYNOAgYxaPwfV1fr0etq6Cgms/FDNLwjoZG4tUkQZUildE8Ka6PtXr
         ztn3MS7nTAxXmDM+522qIz6vjstirJBKkBMjCiTjBRw5x4oqvF07q26k+BP3zGE8/rLC
         9S2oMBQiHBLxo93AGyhfOuX89GoFk4ebK1f73mAfpS/ikX61DzUy5qMwnHo4TMynaCtW
         uhmG2vvGFBVXDiuChk3gMeh/cdk0DCcet+2o+FUPKZfUEEbdM7apJYXAW0Q4THicM4RK
         2Jkw==
X-Gm-Message-State: AOAM531q/k/Xs4sGSwG+EiNdi4d59dbG+ZsrBPMPLB2Zk8odZWdyvHSR
        XxcvZXdj9d3vvMiAVQBFWLxSsEp65vw=
X-Google-Smtp-Source: ABdhPJykhwJLkZfOYIhmNNxk/Nz55+Qszo5T+bjgb7h6PcQnjIJ7F+Hna3F5Gfd8TeZb9z0qp6FsxA==
X-Received: by 2002:ac8:342b:: with SMTP id u40mr520776qtb.59.1590523022967;
        Tue, 26 May 2020 12:57:02 -0700 (PDT)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id b189sm504877qkg.110.2020.05.26.12.57.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 12:57:02 -0700 (PDT)
Received: by mail-qk1-f173.google.com with SMTP id z80so22058050qka.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:57:01 -0700 (PDT)
X-Received: by 2002:a37:ecc:: with SMTP id 195mr457918qko.469.1590523021692;
 Tue, 26 May 2020 12:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200518221904.GA22274@embeddedor> <202005181529.C0CB448FBB@keescook>
 <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com>
 <202005202022.588918E61@keescook> <CADRPPNTuUUVOHs76JVzELcsyRH_LSi2PGML1t2wob+45LJCXvA@mail.gmail.com>
 <VE1PR04MB67682776BDC5682B3B330D6A91B30@VE1PR04MB6768.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB67682776BDC5682B3B330D6A91B30@VE1PR04MB6768.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 26 May 2020 14:56:33 -0500
X-Gmail-Original-Message-ID: <CADRPPNSX9cRjuogv1W1TCGzdn0uJWZ3_QBrjDKfdHgaSq0JLdQ@mail.gmail.com>
Message-ID: <CADRPPNSX9cRjuogv1W1TCGzdn0uJWZ3_QBrjDKfdHgaSq0JLdQ@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
To:     Qiang Zhao <qiang.zhao@nxp.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 9:49 PM Qiang Zhao <qiang.zhao@nxp.com> wrote:
>
> On Wed, May 23, 2020 at 5:22 PM Li Yang <leoyang.li@nxp.com>
> > -----Original Message-----
> > From: Li Yang <leoyang.li@nxp.com>
> > Sent: 2020年5月23日 5:22
> > To: Kees Cook <keescook@chromium.org>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>; Qiang Zhao
> > <qiang.zhao@nxp.com>; linuxppc-dev <linuxppc-dev@lists.ozlabs.org>;
> > moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
> > <linux-arm-kernel@lists.infradead.org>; lkml <linux-kernel@vger.kernel.org>;
> > Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
> > struct_size() helper
> >
> > On Wed, May 20, 2020 at 10:24 PM Kees Cook <keescook@chromium.org>
> > wrote:
> > >
> > > On Wed, May 20, 2020 at 06:52:21PM -0500, Li Yang wrote:
> > > > On Mon, May 18, 2020 at 5:57 PM Kees Cook <keescook@chromium.org>
> > wrote:
> > > > > Hm, looking at this code, I see a few other things that need to be
> > > > > fixed:
> > > > >
> > > > > 1) drivers/tty/serial/ucc_uart.c does not do a be32_to_cpu() conversion
> > > > >    on the length test (understandably, a little-endian system has never
> > run
> > > > >    this code since it's ppc specific), but it's still wrong:
> > > > >
> > > > >         if (firmware->header.length != fw->size) {
> > > > >
> > > > >    compare to the firmware loader:
> > > > >
> > > > >         length = be32_to_cpu(hdr->length);
> > > > >
> > > > > 2) drivers/soc/fsl/qe/qe.c does not perform bounds checking on the
> > > > >    per-microcode offsets, so the uploader might send data outside the
> > > > >    firmware buffer. Perhaps:
> > > >
> > > > We do validate the CRC for each microcode, it is unlikely the CRC
> > > > check can pass if the offset or length is not correct.  But you are
> > > > probably right that it will be safer to check the boundary and fail
> > >
> > > Right, but a malicious firmware file could still match CRC but trick
> > > the kernel code.
> > >
> > > > quicker before we actually start the CRC check.  Will you come up
> > > > with a formal patch or you want us to deal with it?
> > >
> > > It sounds like Gustavo will be sending one, though I don't think
> > > either of us have the hardware to test it with, so if you could do
> > > that part, that would be great! :)
> >
> > That will be great.  I think Zhao Qiang can help with the testing part.
> >
>
> Now the firmware are loaded in uboot, and kernel will do nothing for it.
> So testing on it maybe need some extra codes both in driver and dts.
> In the meanwhile, I am so busy on some high priority work that maybe test work
> could not be done in time.
> Once I am free, I will do it.

Thanks.  You are right that most of the QE drivers doesn't support
requesting firmware in kernel except the ucc_uart.  So it probably can
be tested with that driver without requiring code change.

>
> Best Regards
> Qiang Zhao
