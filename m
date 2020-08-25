Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96444C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 641C9206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 22:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcrgcAZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHYWfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 18:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHYWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 18:35:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D03C061574;
        Tue, 25 Aug 2020 15:35:05 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t6so89082ljk.9;
        Tue, 25 Aug 2020 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhI77mTTE3Q9HRTUpRDWftZSAKhyMtuih4ksQk5Kfv8=;
        b=pcrgcAZFXz7Eu75AUFKMmboPdmVsbh1mQWVhuJi0+BbFpj9NGCQS78kuO2Z+CBjifE
         7ML7FCmWie8ruFSNnUxz7iv0PGbKL9KbD+0D+dURzgEuRyBF36slx4qAa58o7/yzEmBA
         gbf5bH3EVvOfEBszH6VHaIpIcjja0dj1BFljplM2vDaX+NbFKkuJGRSyPYpuFf6yQxxC
         PcwQsNROM8serROd8XEF1Lu0YGb0kn8CPx8O/92JGdIdMkdy2/rtUcu9+9aFRFMUBBR1
         hNSPPAa/jaLReAfi6so6pdAACcCZdV0HVU8issXnyZEGYTJG8ijFP7koert9c+H2sVpb
         aW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhI77mTTE3Q9HRTUpRDWftZSAKhyMtuih4ksQk5Kfv8=;
        b=nf4O/9XEGgajix5tOI46OAZSHspagLCeQr7l+8srGg/B8urD+mEpwxI14ASc1NcomY
         m+6/RZBIi072oP9f5ZG9czRKuZKlResY/ix9950LjArF9G9IpdLMbm9a0SGLN7jUYgqa
         MfNJhzFwin1FCCtFzuKDgofR82g2FMdJ8MMPHVo6SWfF23JXnNrK+M2jILt3nt0FUpzZ
         5vP5hoGwkcxISDaFsmUuaS2J1+oDJtZ+en2h0T7KKYfS4yfeGBPzM/1LUxXvV7uUoHHP
         84Nqi/DIabTge6kB5p0+fzicmMBy1S/w2T1gNLHr82ENH/dkmd3cYg5h+zhywKI64GMr
         LLqA==
X-Gm-Message-State: AOAM531K4+1CxjmMNs9kPN6ZTLkL9AOUH5EKBUt+ev0pkhW6suTZFciF
        oFCeLtQdhuoJVNk4eZbEeyjBGC11yvutNlb+Hmmf2zVb6EI=
X-Google-Smtp-Source: ABdhPJxLpkxRg6tHcVTDcmg0hcCpxmN+zClDnZ/HI3J/wOOe37dpERDWmXCSLCjlwatVyfDIEGqmOXbed+f8RzEXoFo=
X-Received: by 2002:a05:651c:82:: with SMTP id 2mr5884377ljq.2.1598394903461;
 Tue, 25 Aug 2020 15:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200821111111.6c04acd6@canb.auug.org.au> <20200825112020.43ce26bb@canb.auug.org.au>
 <CAADnVQLr8dU799ZrUnrBBDCtDxPyybZwrMFs5CAOHHW5pnLHHA@mail.gmail.com>
 <20200825130445.655885f8@canb.auug.org.au> <CAADnVQKGf7o8gJ60m_zjh+QcmRTNH+y1ha_B2q-1ixcCSAoHaw@mail.gmail.com>
 <20200825165029.795a8428@canb.auug.org.au> <CAADnVQ+SZj-Q=vijGkoUkmWeA=MM2S2oaVvJ7fj6=c4S4y-LMA@mail.gmail.com>
 <20200826071046.263e0c24@canb.auug.org.au>
In-Reply-To: <20200826071046.263e0c24@canb.auug.org.au>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 25 Aug 2020 15:34:52 -0700
Message-ID: <CAADnVQJ1KZ1hUGsZY0XrWcQTa6V-y7VA9YdEjxCJfHRe5mH4xw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the bpf-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 2:10 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Alexei,
>
> On Tue, 25 Aug 2020 07:33:51 -0700 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> >
> > what do you suggest to use to make it 'manually enabled' ?
> > All I could think of is to add:
> > depends on !COMPILE_TEST
> > so that allmodconfig doesn't pick it up.
>
> That is probably sufficient.  Some gcc plugins and kasan bits, etc use
> just that.

Ok. Pushed the silencing 'fix':
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=2532f849b5134c4c62a20e5aaca33d9fb08af528
