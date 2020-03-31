Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38B0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83FE12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgFFgsAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbgCaWJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:09:41 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38332 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbgCaWJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:09:41 -0400
Received: by mail-ot1-f66.google.com with SMTP id t28so23826047ott.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifrIprtCmZCzS2rJSxbv6FFXsExlpwqRTV97NQIJ9rs=;
        b=IgFFgsAWYaFEytOk8+1XW190BObyf7+0lOQae8kvvO91eG2YNPGCGIYDcNIgf8OD5c
         bbzyop+Ku5KhHsy0IwV12gH+siQ4xtMhSnbz01VygvXCE/pZwMLp1dv8yTX3DpoRRrbj
         aq+PShu3V8Rf1ggxGBtgAgMCIC40cy4erilzdOe7u4t2pmkxnzt53kuE9t9Ookgayq6u
         zZflX3MboDDfQAo1FermwmveXvPRUp8rm1jAhl1zctqw6fw0Z+5+hYRcTlsJX39MZpBt
         iGZUuWVvdQrz6g3XworAKW8B9XJQaUMb7R9l9cd35cM/w/g0U4TWdzrFyrqGixkH1McU
         PSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifrIprtCmZCzS2rJSxbv6FFXsExlpwqRTV97NQIJ9rs=;
        b=n+Tw/LO11sAZhc46D1J7rdX9pS/gZg056EkD16XMpS/4G1uDlNF3lqAVZxgiZK8xwF
         xTqEVC3kwWFFIiNYxX7ZGT8i86Ijoe65r4oT4ufOZO2379e5pO8/Y0XAKRfO8VDyVuS2
         +LHgVe0+GwvQsEBfdsZVNz8foWLMJ6Cprzx6HBFRC1Lh3PYOIrFYNFLOD7O59nXpAgYs
         oltL2Xq23Y+wMiQq+sUEDy0KNJoUIXIy0yUapuutapI+Cp+Pp4k4sitZ5InRng6xcVGw
         SZzr+OEd16Z13FT6/zp0xGnE+xQ1BBGI5KtpeDPAmQrTbqnof2+z3jMLag2haH9HB/ET
         SyyQ==
X-Gm-Message-State: ANhLgQ1oouavrGc6DOMZJyO8nh3u1N2jsxPKnigp/Q0ww4wHdPm22uFL
        YRClLhusk80EoqEWgVlnlL/f4p/93x82NVWQnQaX4Q==
X-Google-Smtp-Source: ADFU+vvQD06/XmjeJyI4FrtAXAGmuuiEX1yjtwfPNoFnp54Fkwnbl5A1nBoHeuT4QWFafHtq2rTg2jUtvFNiqwrNXOo=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr13961381ota.221.1585692580240;
 Tue, 31 Mar 2020 15:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200311170120.12641-1-jeyu@kernel.org> <CANcMJZDhSUV8CU_ixOSxstVVBMW3rVrrQVYMmy1fz=OdhxA_GQ@mail.gmail.com>
 <CANcMJZD9Lz-J_idL5i225VR_3Mo6PcTRsYBBrGsMByX6W4jepQ@mail.gmail.com> <20200331095802.GA3026@linux-8ccs>
In-Reply-To: <20200331095802.GA3026@linux-8ccs>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 31 Mar 2020 15:09:27 -0700
Message-ID: <CALAqxLWZ8aET=gHpYUi_v0ez-gDT5nPEnAEb+2uxebFU8D9RXg@mail.gmail.com>
Subject: Re: [PATCH v2] modpost: move the namespace field in Module.symvers last
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matthias Maennich <maennich@google.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 2:58 AM Jessica Yu <jeyu@kernel.org> wrote:
> +++ John Stultz [30/03/20 23:25 -0700]:
> >On Mon, Mar 30, 2020 at 10:49 PM John Stultz <john.stultz@linaro.org> wrote:
> >> The only difference I can find is that the Module.symvers in the
> >> external module project doesn't seem to have a tab at the end of each
> >> line (where as Module.symvers for the kernel - which doesn't seem to
> >> have any namespace names - does).
> >>
> >> Is there something I need to tweak on the external Kbuild to get
> >> Module.symvers to be generated properly (with the empty tab at the
> >> end) for this new change?
> >> Or does the parser need to be a bit more flexible?
> >>
> >
> >One extra clue on this: I noticed the external module Makefile had
> >KBUILD_EXTRA_SYMBOLS="$(EXTRA_SYMBOLS)"  in the $(MAKE) string, where
> >EXTRA_SYMBOLS pointed to some files that no longer exist.  I removed
> >the KBUILD_EXTRA_SYMBOLS= argument, and magically, the generated
> >Module.symvers now had tabs at the end of each line.
> >
> >I wonder if there some path in the KBUILD_EXTRA_SYMBOLS= handling that
> >isn't generating the output in the same way?
>
> I'm afraid we're going to need some specifics on reproducing this
> issue. Could you provide a reproducer or steps on how to reproduce? I
> have not been able to trigger this problem even with
> KBUILD_EXTRA_SYMBOLS pointing to an invalid path (I also tested with
> valid paths).
>
> I tested with a skeleton external module that exports two functions,
> one with a namespace and one without. I built this module against the
> latest v5.6 kernel. The generated Module.symvers was correct - the
> namespaced function had the namespace at the end and the other
> function without a namespace had a tab at the end.
>
> I also tested with two external modules, one with a symbol dependency
> on the other, so KBUILD_EXTRA_SYMBOLS usage is required here. The
> generated Module.symvers was also correct here.
>
> The only advice I can offer at this time is that all external modules
> must be built against the new kernel to generate a correctly formated
> Module.symvers file. If you have any KBUILD_EXTRA_SYMBOLS pointing to
> an outdated Module.symvers file for example, you will see the "FATAL:
> parse error in symbol dump file" error.

Well, my apologies.  :(  In the light of day, this isn't reproducing
anymore. I'm a bit at a loss as to why I was tripping over it so
regularly before, but I suspect something in the build is leaving a
stale Modules.symvers around from before this patch landed.

Terribly sorry for the noise.

thanks
-john
