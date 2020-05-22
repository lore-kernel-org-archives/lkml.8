Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5F8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AC4C2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgEVVWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:22:06 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33150 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVVWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:22:05 -0400
Received: by mail-io1-f65.google.com with SMTP id k18so12988551ion.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXll0AzrUS0bkYtIGXOwEZ5Oxhk9R9vDypCx0QbqWbc=;
        b=mdF5ammYfHQQmcb/hu8zjDXi38E6Mom4riTZ8+9jMtDXbgjlBAAHvhbzcT82kJ3AkU
         TRmPQRIOJh1j1lRdUwoYocyLBElLPDPQ/YVkD3lJcboIbdKbnf1vyNwRND5ctSYKx05Q
         gNAkWtuuz09dagiYoV3v8LNpE+VhsX8pwov/BJP3jVFkuQQVZOGicUgmPeqQoGLoXLfE
         LgPB/VK/GK4HgnjhiGGQTtxFrcLcpzpQ+gHKn8hVWBQUEdQhiSvImbe779WCyJ/T9ASm
         Aw3lLrcrxESA89Z1CbvW7ulJeDJ1hOKEZZfDfvmLKU1bm+cQHm60LbifMFYMEty1FGZF
         DlhA==
X-Gm-Message-State: AOAM531LjEb53Xe9Ajwu3WVEB3ARWOMMo2JekuHgSHT2HUAC368n2QI5
        IZ7AzOrJvuP9QJIYsT8B6YZSNw0NT2w=
X-Google-Smtp-Source: ABdhPJz0BLKzeCTPh9iVzWyr0kbywmDVgotFEo6HVszuaM28rdoCWFnGhaHwdoKn8nyxpyclWYIL/g==
X-Received: by 2002:a6b:1448:: with SMTP id 69mr1997157iou.83.1590182523136;
        Fri, 22 May 2020 14:22:03 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id q6sm5421056ill.59.2020.05.22.14.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:22:02 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id c20so12143247ilk.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:22:02 -0700 (PDT)
X-Received: by 2002:a05:6e02:f:: with SMTP id h15mr14653120ilr.90.1590182521978;
 Fri, 22 May 2020 14:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200518221904.GA22274@embeddedor> <202005181529.C0CB448FBB@keescook>
 <CADRPPNR-Croux9FgnrQJJmdF2jNnuAmC+2xMJSgSbkbRv9u8Mw@mail.gmail.com> <202005202022.588918E61@keescook>
In-Reply-To: <202005202022.588918E61@keescook>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:21:38 -0500
X-Gmail-Original-Message-ID: <CADRPPNTuUUVOHs76JVzELcsyRH_LSi2PGML1t2wob+45LJCXvA@mail.gmail.com>
Message-ID: <CADRPPNTuUUVOHs76JVzELcsyRH_LSi2PGML1t2wob+45LJCXvA@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: qe: Replace one-element array and use
 struct_size() helper
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Qiang Zhao <qiang.zhao@nxp.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:24 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, May 20, 2020 at 06:52:21PM -0500, Li Yang wrote:
> > On Mon, May 18, 2020 at 5:57 PM Kees Cook <keescook@chromium.org> wrote:
> > > Hm, looking at this code, I see a few other things that need to be
> > > fixed:
> > >
> > > 1) drivers/tty/serial/ucc_uart.c does not do a be32_to_cpu() conversion
> > >    on the length test (understandably, a little-endian system has never run
> > >    this code since it's ppc specific), but it's still wrong:
> > >
> > >         if (firmware->header.length != fw->size) {
> > >
> > >    compare to the firmware loader:
> > >
> > >         length = be32_to_cpu(hdr->length);
> > >
> > > 2) drivers/soc/fsl/qe/qe.c does not perform bounds checking on the
> > >    per-microcode offsets, so the uploader might send data outside the
> > >    firmware buffer. Perhaps:
> >
> > We do validate the CRC for each microcode, it is unlikely the CRC
> > check can pass if the offset or length is not correct.  But you are
> > probably right that it will be safer to check the boundary and fail
>
> Right, but a malicious firmware file could still match CRC but trick the
> kernel code.
>
> > quicker before we actually start the CRC check.  Will you come up with
> > a formal patch or you want us to deal with it?
>
> It sounds like Gustavo will be sending one, though I don't think either
> of us have the hardware to test it with, so if you could do that part,
> that would be great! :)

That will be great.  I think Zhao Qiang can help with the testing part.

Regards,
Leo
