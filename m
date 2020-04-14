Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F263DC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D48232076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586889900;
	bh=z4iu8C1IUFKQhpGWzQYlz4dLK97VHM1ENEaA66JseC4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2BwIL+zJpDGnHLBWrIyj6c7HbtFn50ohaX+EWq3OrMPEMb34xHAbeQT/YvRbS9QyO
	 Ml2ViTdH0+POR+egpq8eBBG1TtgnyK5MN/1ImH3pHyqXOywVL48R7Nc6uPAldQhwRA
	 dc/VwfGzSrtpE4L1kA4VJKpmykJ5QfeDKLLlFMzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504281AbgDNSo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504258AbgDNSoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:44:54 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC83C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:44:53 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t11so613173lfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vUAvoCKNNXDeCMUdwCSeLoMbMAb/KChWz9ujE+OyHCM=;
        b=ONAUHEL13p5Y/2ha0FDA/acN9wDJouk3bUIGvZBWK8Ba4OIop6w0BIFm2VTAZqpMmL
         vmVA+NzYHqIKDdUCS3JsX3CDuR4T890vJuLmkMrFfHiBagBwM4wsxv9Mwf2QW4GLIMNa
         fQiZRKHMlUbiAGRyHbsnkUsNcTq5+DXaQYNig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vUAvoCKNNXDeCMUdwCSeLoMbMAb/KChWz9ujE+OyHCM=;
        b=IdvPrKO/6fA0J+MgqMfnUK09aHtKuqSr4+VAn57MPnbB2DRB/xbFVJ6qtgmA81GYXz
         Ga1qDVXdUN1AvqIQnxPbOE8VKUMGk38wks1wEKaY1Pg8Ln9rbXEOe9TsUX50JXtnmFmr
         sSXRS8b8yjc1188BtNu2Xx0Vg8FrevLkDkLtL56Bt+Gj09pPFoJnsHWKXYpHjJ75zdI/
         wLgXUk9APCyEIadP/0He94zFtwCOq4qgDlE6eiII35uuqy4M71+wH9RWP1evKIP5IVtn
         HzfaGxq5R4b+ok+Pr8/my/WOxQ+W0uZMj/AdMueawIY8jCLH2Vv3fOD5QdViqARHl2vc
         4Cpw==
X-Gm-Message-State: AGi0PubL5xf3vf/GZ6ZnXRs3DMSo5JRZIVD8Rcwx0Efl2Qottc5XT7AW
        I/MrSrWpZTK8Tk34/CNOiiHaOMO4oz8=
X-Google-Smtp-Source: APiQypLwVrFTccEHAKnudRPXNAUetvhxaE/yFeJfsA5RnIKp2B7pdsE793KTIhGMJ2lyxoXC/DburA==
X-Received: by 2002:a19:3848:: with SMTP id d8mr694799lfj.44.1586889891726;
        Tue, 14 Apr 2020 11:44:51 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id u3sm11146119lff.26.2020.04.14.11.44.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id h6so636788lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
X-Received: by 2002:a19:240a:: with SMTP id k10mr725139lfk.30.1586889890348;
 Tue, 14 Apr 2020 11:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
 <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com> <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
In-Reply-To: <CAMj1kXE9046X9EDd636Bw1A9npv0QKAuLcTAzMXAn=JVZeCN0Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Apr 2020 11:44:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNWkTPvMnhoggNOig98=YvXULnq15Z07rQw-9YyVdx+w@mail.gmail.com>
Message-ID: <CAHk-=wjNWkTPvMnhoggNOig98=YvXULnq15Z07rQw-9YyVdx+w@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 11:32 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> That is the quick fix, but Arvind is working on getting rid of
> __efistub_global entirely, and use the right linker foo to put .bss in
> .data.

Oh, that sounds even better. Yeah, a linker script fix to just make
.bss be in the executable is the right thing to do if we have
unreliable loaders.

Thanks,
             Linus
