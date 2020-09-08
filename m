Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F06C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DE62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBeCm4C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbgIHI4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbgIHI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:56:11 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D47C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:56:11 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id x142so3895875vke.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtS1yuZDIHrpYA/uA91Yd0uc5pmwzeQDnQE4jOwxY9U=;
        b=IBeCm4C0ZPMqPfLyWmdZksg/KxnRqbXrDuxxbVoWNvsW9jyI2uD2Nk4/Xe0e13BrYr
         L9ALlDdRsEUFyZlmyNdIOyzA5CCkan4M2snDdO9Dee88QDfjR26JGfCTj+orNzb9fnW/
         5GdIjVNknnY10KbHn93mN2KKpFxjCXm4wrJoKb5L8Nn2SB8onzr6xgp3Pqqi+1/QvCCD
         lsqywvBRwTTldsnVwgDKNK/Xi9uzWgrL7gHaD13qQf2iT9DKK7+JT8KVXYQA2My+A6F4
         wS7CY/hoDuJ7Ud1Wn8diOaFnTSNSKiyHz9BWeSRrtOp7n+Y14khH9ZKfNTAstCOfZ4yE
         RoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtS1yuZDIHrpYA/uA91Yd0uc5pmwzeQDnQE4jOwxY9U=;
        b=MwV1vtGCrnkLR/BA/mcHXQ4T4Ru0dkorIV3dyWNf5JXbzF9hIYKXhMd+Orkp/oRkzh
         63UcwdCf1GP1WBYtSk3MhxUBUzmtCeCrm77nFx1+t+VxAaee9tvDHp7MvSAgANP4Hszb
         x8rkAmOlsyjvbWSCEh9GWMoi24QrZeoaSvywfMyEXTxmfjhD6QbxLEPJ8cBNgrI+oSiC
         VJ0iuik6HpR8kc+TyfIksH40BaTWFyRNfgCHoh2+wTSlenEzM1jyN9/E6fb7D4Qw1xB3
         1Zi/oK8iU8GjW1rxiFDsoYYj17ojdmSc8kYMVUbr34tvGgL6v/CYbqa8CA/YYpKWjdKL
         yMvQ==
X-Gm-Message-State: AOAM5301/c95ZerGs+GsNEN1PnLUGcMgiaOUe6xAJV6Irmmy8unVOjSF
        8F+pkmqqsqxpURhXXrgaRPbQX2aPMgu6Wg==
X-Google-Smtp-Source: ABdhPJwr2hpNlGBNdtFjHN2SFEBZMYknjS+RRR/x+oZaJ22yXOSn8PLNv53c4fuBs9v2ZWRoBFTMVQ==
X-Received: by 2002:ac5:c748:: with SMTP id b8mr107338vkn.6.1599555370113;
        Tue, 08 Sep 2020 01:56:10 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 23sm2869539vkw.25.2020.09.08.01.56.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 01:56:09 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id p185so8561113vsp.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:56:09 -0700 (PDT)
X-Received: by 2002:a67:c78b:: with SMTP id t11mr13725165vsk.109.1599555368447;
 Tue, 08 Sep 2020 01:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200906031827.16819-1-xie.he.0141@gmail.com> <CA+FuTSfOeMB7Wv1t12VCTOqPYcTLq2WKdG4AJUO=gxotVRZiQw@mail.gmail.com>
 <CAJht_EO13aYPXBV7sEgOTuUhuHFTFFfdg7NBN2cEKAo6LK0DMQ@mail.gmail.com>
In-Reply-To: <CAJht_EO13aYPXBV7sEgOTuUhuHFTFFfdg7NBN2cEKAo6LK0DMQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 10:55:30 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdK6qgKwgie5Bqof8V5FR__dx-HgHUcDS5sgTQmH9B9uQ@mail.gmail.com>
Message-ID: <CA+FuTSdK6qgKwgie5Bqof8V5FR__dx-HgHUcDS5sgTQmH9B9uQ@mail.gmail.com>
Subject: Re: [PATCH net] net/packet: Fix a comment about hard_header_len and
 headroom allocation
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        Or Cohen <orcohen@paloaltonetworks.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 2:07 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> Thank you for your comment!
>
> On Mon, Sep 7, 2020 at 2:41 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > On Sun, Sep 6, 2020 at 5:18 AM Xie He <xie.he.0141@gmail.com> wrote:
> > >
> > > This comment is outdated and no longer reflects the actual implementation
> > > of af_packet.c.
> >
> > If it was previously true, can you point to a commit that changes the behavior?
>
> This is my understanding about the history of "af_packet.c":
>
> 1. Pre git history
>
> At first, before "needed_headroom" was introduced, "hard_header_len"
> was the only way for a driver to request headroom. However,
> "hard_header_len" was also used in "af_packet.c" for processing the
> header. There was a confusion / disagreement between "af_packet.c"
> developers and driver developers about the use of "hard_header_len".
> "af_packet.c" developers would assume that all headers were visible to
> them through dev->header_ops (called dev->hard_header at that time?).
> But the developers of some drivers were not able to expose all their
> headers to "af_packet.c" through header_ops (for example, in tunnel
> drivers). These drivers still requested the headroom via
> "hard_header_len" but this created bugs for "af_packet.c" because
> "af_packet.c" would assume "hard_header_len" was the length of the
> header visible to them through header_ops.
>
> Therefore, in Linux version 2.1.43pre1, the FIXME comment was added.
> In this comment, "af_packet.c" developers clearly stated that not
> exposing the header through header_ops was a bug that needed to be
> fixed in the drivers. But I think driver developers were not able to
> agree because some drivers really had a need to add their own header
> without using header_ops (for example in tunnel drivers).
>
> In Linux version 2.1.68, the developer of "af_packet.c" compromised
> and recognized the use of "hard_header_len" even when there is no
> header_ops, by adding the comment I'm trying to change now. But I
> guess some other developers of "af_packet.c" continued to treat
> "hard_header_len" to be the length of header of header_ops and created
> a lot of problems.
>
> 2. Introduction of "needed_headroom"
>
> Because this issue has troubled for developers for long, in 2008,
> developers introduced "needed_headroom" to solve this problem.
> "needed_headroom" has only one purpose - reserve headroom. It is not
> used in af_packet.c for processing so drivers can safely use it to
> request headroom without exposing the header via header_ops.
>
> The commit was:
> commit f5184d267c1a ("net: Allow netdevices to specify needed head/tailroom")
>
> After "needed_headroom" was introduced, all drivers that needed to
> reserve the headroom but didn't want "af_packet.c" to interfere should
> change to "needed_headroom".
>
> From this point on, "af_packet.c" developers were able to assume
> "hard_header_len" was only used for header processing purposes in
> "af_packet.c".

Very nice archeology!

Thanks for summarizing.

> 3. Not reserving the headroom of hard_header_len for RAW sockets
>
> Another very important point in history is these two commits in 2018:
> commit b84bbaf7a6c8 ("packet: in packet_snd start writing at link
> layer allocation")
> commit 9aad13b087ab ("packet: fix reserve calculation")
>
> These two commits changed packet_snd to the present state and made it
> no long reserve the headroom of hard_header_len for RAW sockets. This
> made drivers' switching from hard_header_len to needed_headroom became
> urgent because otherwise they might have a kernel panic when used with
> RAW sockets.
>
> > > In this file, the function packet_snd first reserves a headroom of
> > > length (dev->hard_header_len + dev->needed_headroom).
> > > Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
> > > which calls dev->header_ops->create, to create the link layer header.
> > > If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
> > > length (dev->hard_header_len), and checks if the user has provided a
> > > header of length (dev->hard_header_len) (in dev_validate_header).
> >
> > Not entirely, a header greater than dev->min_header_len that passes
> > dev_validate_header.
>
> Yes, I understand. The function checks both hard_header_len and
> min_header_len. I want to explain the role of hard_header_len in
> dev_validate_header. But I feel a little hard to concisely explain
> this without simplifying a little bit.

Ack.

> > >  /*
> > >     Assumptions:
> > > -   - if device has no dev->hard_header routine, it adds and removes ll header
> > > -     inside itself. In this case ll header is invisible outside of device,
> > > -     but higher levels still should reserve dev->hard_header_len.
> > > -     Some devices are enough clever to reallocate skb, when header
> > > -     will not fit to reserved space (tunnel), another ones are silly
> > > -     (PPP).
> > > +   - If the device has no dev->header_ops, there is no LL header visible
> > > +     outside of the device. In this case, its hard_header_len should be 0.
> >
> > Such a constraint is more robustly captured with a compile time
> > BUILD_BUG_ON check. Please do add a comment that summarizes why the
> > invariant holds.
>
> I'm not sure how to do this. I guess both header_ops and
> hard_header_len are assigned at runtime. (Right?) I guess we are not
> able to check this at compile-time.

header_ops should be compile constant, and most devices use
struct initializers for hard_header_len, but of course you're right.

Perhaps a WARN_ON_ONCE, then.

> > More about the older comment, but if reusing: it's not entirely clear
> > to me what "outside of the device" means. The upper layers that
> > receive data from the device and send data to it, including
> > packet_snd, I suppose? Not the lower layers, clearly. Maybe that can
> > be more specific.
>
> Yes, right. If a header is visible "outside of the device", it means
> the header is exposed to upper layers via "header_ops". If a header is
> not visible "outside of the device" and is only used "internally", it
> means the header is not exposed to upper layers via "header_ops".
> Maybe we can change it to "outside of the device driver"? We can
> borrow the idea of encapsulation in object-oriented programming - some
> things that happen inside a software component should not be visible
> outside of that software component.

How about "above"? If sketched as a network stack diagram, the code
paths and devices below the (possibly tunnel) device do see packets
with link layer header.
