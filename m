Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7658BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54687206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1kKD74N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgFBRhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFBRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:37:41 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F39CC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:37:41 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id p15so2171356qvr.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EXuKs/ZrhAnv+laNRxA/w5a8bqOks5gwI8BCofPUoP4=;
        b=K1kKD74NXq9TQWEP0sN+piMgV5Qov4NszLh2L4gD2NHoMGAbTTKafgW22Mho7nLrzg
         uKvxUOq+OPaLhktD9N6CuXEPpx5kAtHiXz4fW5qZpuQPShjxhb8LJ1foAE9oqTFsz5GR
         ZIlsETRWogZ1GHXT4X8iqVRjmMggoNxpNiew/BUvETXCOR0lUHiHEjJCw72q6OlDXq0G
         mOaz/TabGjB/zEY2sRVSMN7k/Z5ntlE6anJO2/FIzfE4rq/2lBENct4nUcTuNNUe0j5/
         X8RG4ovMuJX29Iql1ICFQnxEYfC26V6DFRF2s488ZoxSA9VwOqRLFXF6Xip0/PqH8VWc
         bNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EXuKs/ZrhAnv+laNRxA/w5a8bqOks5gwI8BCofPUoP4=;
        b=eLQzZGcWcr40me1EDTOgFDqPpS8c5oVXsEi2OgJPMS4XQDeBVoKZJT+Y7BChAbr0Ap
         D1LONpLprRX0DSSC9udW8sR5IvEljBFIllDnIguYtcogN0m24q6TrPzqRIeQkVNEwNFu
         5aoMTE7Hb/LLU1hXj4fqY98TfPdgsV0KYhU/xlrYjC7POwpxEXx80haOlP9Ixf64simO
         mHe/HRfM1BqDQKuRq2IYKsPb4uE5FDE9W8h9mLTc1SAWE3La0Q95gunsdlVPhT4DTr1T
         GlZLbfmT84sayd87EjsZiYJRzOKtY0n/lNIgKxqbPtA818PJXY75Cz6DLVVwiLIc2TgM
         YM1A==
X-Gm-Message-State: AOAM533opA/+DPO7OhsVHpwWfs0W3AYP2Kq26ulfYTz7Foc8LZfYnkNq
        RLYsApgbxd3k0y5Op6+VCKmT2C/f
X-Google-Smtp-Source: ABdhPJxeUBkVU1bt0GkQezqeoW9EO3j+VcdH4W8n5jRKSlDGAWqyQzgcpF2ImtHedm+wtqRJyQf00A==
X-Received: by 2002:ad4:54ea:: with SMTP id k10mr2889124qvx.66.1591119460142;
        Tue, 02 Jun 2020 10:37:40 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id p63sm2959711qkf.50.2020.06.02.10.37.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:37:38 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id a80so6682337ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:37:38 -0700 (PDT)
X-Received: by 2002:a25:f413:: with SMTP id q19mr45233147ybd.178.1591119457607;
 Tue, 02 Jun 2020 10:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080535.1427-1-victor@inliniac.net> <CA+FuTSfD2-eF0H=Qu09=JXK6WTiWKNtcqRXqv3TfMfB-=0GiMg@mail.gmail.com>
 <b0a9d785-9d5e-9897-b051-6d9a1e8f914e@inliniac.net>
In-Reply-To: <b0a9d785-9d5e-9897-b051-6d9a1e8f914e@inliniac.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 2 Jun 2020 13:37:01 -0400
X-Gmail-Original-Message-ID: <CA+FuTSd07inNysGhx088hq_jybrikSQdxw8HYjmP84foXhnXOA@mail.gmail.com>
Message-ID: <CA+FuTSd07inNysGhx088hq_jybrikSQdxw8HYjmP84foXhnXOA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] af-packet: new flag to indicate all csums are good
To:     Victor Julien <victor@inliniac.net>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Eric Dumazet <edumazet@google.com>,
        Mao Wenan <maowenan@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
        Neil Horman <nhorman@tuxdriver.com>, linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Drozdov <al.drozdov@gmail.com>,
        Tom Herbert <tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 1:03 PM Victor Julien <victor@inliniac.net> wrote:
>
> On 02-06-2020 16:29, Willem de Bruijn wrote:
> > On Tue, Jun 2, 2020 at 4:05 AM Victor Julien <victor@inliniac.net> wrote:
> >>
> >> Introduce a new flag (TP_STATUS_CSUM_UNNECESSARY) to indicate
> >> that the driver has completely validated the checksums in the packet.
> >>
> >> The TP_STATUS_CSUM_UNNECESSARY flag differs from TP_STATUS_CSUM_VALID
> >> in that the new flag will only be set if all the layers are valid,
> >> while TP_STATUS_CSUM_VALID is set as well if only the IP layer is valid.
> >
> > transport, not ip checksum.
>
> Allow me a n00b question: what does transport refer to here? Things like
> ethernet? It isn't clear to me from the doc.

The TCP/UDP/.. transport protocol checksum.

> (happy to follow up with a patch to clarify the doc when I understand
> things better)
>
> > But as I understand it drivers set CHECKSUM_COMPLETE if they fill in
> > skb->csum over the full length of the packet. This does not
> > necessarily imply that any of the checksum fields in the packet are
> > valid yet (see also skb->csum_valid). Protocol code later compares
> > checksum fields against this using __skb_checksum_validate_complete and friends.
> >
> > But packet sockets may be called before any of this, however. So I wonder
> > how valid the checksum really is right now when setting TP_STATUS_CSUM_VALID.
> > I assume it's correct, but don't fully understand where the validation
> > has taken place..
>
> I guess I'm more confused now about what TP_STATUS_CSUM_VALID actually
> means. It sounds almost like the opposite of TP_STATUS_CSUMNOTREADY, but
> I'm not sure I understand what the value would be.
>
> It would be great if someone could help clear this up. Everything I
> thought I knew/understood so far has been proven wrong, so I'm not too
> confident about my patch anymore...

Agreed that we should clear this up.

> > Similar to commit 682f048bd494 ("af_packet: pass checksum validation
> > status to the user"), please update tpacket_rcv and packet_rcv.
>
> Ah yes, good catch. Will add it there as well.
>
> > Note also that net-next is currently closed.
>
> Should I hold off on sending a v3 until it reopens?

Yep, thanks. You can always check
http://vger.kernel.org/~davem/net-next.html when unsure.
