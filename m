Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7DFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F28C20674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBleOo+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732888AbgGVPuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgGVPuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:50:21 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7426C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:50:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id h7so2409418qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbZpQKjkyVWA5idi3w+btcCrZiLttKv+UA9Wn+yjyV0=;
        b=OBleOo+TpJlNHgO3Hupf36nyBJkcwDDKREwPcTAtj6Sp2D5PjGq5CvkBZSLh7t0ptU
         TYUv4+DllNHf7bn3Rh1p34Ffb8mU63zP0IIi9Ai2qGwBI3Qrv07OVzkOkL05OQ1rbeFR
         9oBCEv+aVCb98tGVAtAEHt5/ZY8dADMil0LVidWEPfbhtXdHA965EUvmMKGsuXdontIb
         plNtHfvt1rTUVyFJRXM/R++7bl/E3CKm13FQ4u8VO8jOMskk/G1ilzLFdZp225CLN0B8
         +XbqihxsVQqSYOFAuzVAqzg25leFXoVIL9Zu2oV1pzHbi08PdZv63INm2RU2vKOOhiIz
         VzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbZpQKjkyVWA5idi3w+btcCrZiLttKv+UA9Wn+yjyV0=;
        b=fxLHXm3yZ5fFlG76IRKtpU2o6/au7nTcf5sR0bc9PVXDrjEUHOmPsaYn4LfAWDUfMp
         4WmciVksw9LRTxJ6vgkhtYmG2U2NMKEWzjqW8dV6ghLmn5hCZLXVLy8iDcKezhcYvYAG
         cSoami0xMJ/fadp4TJG79WVzEfuk+VuUDMJ9uKcW8vs8rcBR7tslT0537OVjCeX8E5sN
         HOwGtPPlGerOOAQpR7eMRABI1kuIT41DPifWavbPN5UKW/SfasJswtT1vqOA70z3UMOS
         +DkiA1P6EnF+jie1SLLCSjuBbt++J/gvkw8srIE3N8+WwuZX/Pq4feZcCiO2Y/kjdmsv
         bPLA==
X-Gm-Message-State: AOAM531hNLuCymJAErsGEX7d78KLjIFu9WkeqZ9SJcpIdnM/LDFclStk
        GJ4A4+j9cFCfsGzpYUoOFRZQl96d
X-Google-Smtp-Source: ABdhPJwZNilzGv4ZKlTw9+1gZBbdUAf9PIZUXB5bz1Uyc+fh4Dls82j3PcJBRGrW3lPEI1p1PKtENQ==
X-Received: by 2002:a37:9347:: with SMTP id v68mr567052qkd.281.1595433019094;
        Wed, 22 Jul 2020 08:50:19 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id a8sm35205qth.69.2020.07.22.08.50.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 08:50:17 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id g6so1235544ybo.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:50:17 -0700 (PDT)
X-Received: by 2002:a25:cc4e:: with SMTP id l75mr52192685ybf.165.1595433016973;
 Wed, 22 Jul 2020 08:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <87wo2vwxq6.fsf@cloudflare.com> <20200722144212.27106-1-kuniyu@amazon.co.jp>
 <87v9ifwq2p.fsf@cloudflare.com> <CA+FuTScto+Z_qgFxJBzhPUNEruAvKLSTL7-0AnyP-M6Gon_e5Q@mail.gmail.com>
 <87tuxzwp0v.fsf@cloudflare.com>
In-Reply-To: <87tuxzwp0v.fsf@cloudflare.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 22 Jul 2020 11:49:40 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdQWKFam0KwCg_REZdhNB6+BOwAHL00eRgrJ2FwPDRjcA@mail.gmail.com>
Message-ID: <CA+FuTSdQWKFam0KwCg_REZdhNB6+BOwAHL00eRgrJ2FwPDRjcA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the net tree
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Miller <davem@davemloft.net>,
        kernel-team <kernel-team@cloudflare.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:25 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>
> On Wed, Jul 22, 2020 at 05:05 PM CEST, Willem de Bruijn wrote:
> > On Wed, Jul 22, 2020 at 11:02 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >>
> >> On Wed, Jul 22, 2020 at 04:42 PM CEST, Kuniyuki Iwashima wrote:
> >> > Can I submit a patch to net tree that rewrites udp[46]_lib_lookup2() to
> >> > use only 'result' ?
> >>
> >> Feel free. That should make the conflict resolution even easier later
> >> on.
> >
> > Thanks for the detailed analysis, Jakub.
> >
> > Would it be easier to fix this wholly in bpf-next, by introducing
> > reuseport_result there?
>
> Did you mean replicating the Kuniyuki fix in bpf-next, or just
> introducing the intermediate 'reuseport_result' var?
>
> I'm assuming the former, so that the conflict resolving later on will
> reduce to selecting everything from bpf-next side.

Indeed. Since you are already adding a patch to bpf-next to move the
reuseport_has_conns check back. At the same time, it can introduce
reuseport_result:

                if (score > badness) {
                        reuseport_result = lookup_reuseport(net, sk,
skb, saddr, sport, daddr, hnum);
                        if (reuseport_result && !reuseport_has_conns(sk, false))
                                return reuseport_result;

                        result = reuseport_result ? : sk;
                        badness = score;
                }

> TBH, I don't what is the preferred way to handle it. Perhaps DaveM or
> Alexei/Daniel can say what would make their life easiest?

Good point.

With the above, there still remains a merge conflict, of course. But
then we can take bpf-next as is, so I think it would save a separate
patch to net. But not sure whether that helps anything. It does add an
unnecessary variable.
