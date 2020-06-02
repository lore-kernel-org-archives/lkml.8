Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A596C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48335206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 20:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vUcG4I9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFBUTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 16:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBUTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 16:19:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68659C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 13:19:17 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g7so2422701qvx.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kH+c9aUDFBXS9s9kKGzuRINDn8BQbJAM1Dyn57dqTg=;
        b=vUcG4I9N4mCobCOVJckSHosoeFClEfZlEDisL91uLYBgvgM//AL2jVJxM4Cwwcb6Sc
         k5h9KQsbMPnA230WnR9khyJ77e4fk1euYuFBZTdMQWBjfVjcQPzJLj1grqdFaPU6XHOC
         adKPw5619wbCKK+CvT7Qx7qRhtmgo2PcY1tTw0x9W6oZkAXsr4UI185AMK1HSrR4yx/Q
         l182Yo/wjpt50BmN/P1pVPaoFjVzZENZ9r3/SHBvnEidX+kUf4An4+Qcshi70YXipjnD
         tonl/zvQ4txcworwKR0EOaYLnSvbbBaLnKNj+ZwisqO5k0vCGOUbWVuLjv1Szh9PuRif
         ARcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kH+c9aUDFBXS9s9kKGzuRINDn8BQbJAM1Dyn57dqTg=;
        b=EMl0RKbsZO11tKYIhzesrApaidCtJOR+pZ2Rj0r3aRgNjpF6+i4HvUYDOW1/HSY5BI
         /0Pkc0wfXrHhWgTSVei2C0jNvOmXIaEZoBi4P9W6qoL8rL2MsbzXm8kZM89t6r9VKNfl
         86wUTlf1rJS4zAKFQcMSu9or8O2rwVtlYaYGzqQLlOOTmsQPgAmAjw5LBQf7o4tL4YyO
         ODYPX0U47QRQ829JYEjuZ5BVB4JDmlc9esAAclse/2yVl5VlaWZO88G6YenCt6cO/pEC
         2oasyjyJZ4Q51Ityl8obElr6Cv3PX6QkicPtodcgrBKTzHFw5Q146FkzsqbRI7ndOROl
         iGeA==
X-Gm-Message-State: AOAM532pYo+i+m1QPz97aZ8Vbw6SdqCItG8nfkwUnTyoh8pfZJMz1aGR
        3oIz5eCOtru6ZLBx9b1NramsJcjE
X-Google-Smtp-Source: ABdhPJxv9tKY1HqxSq/KbzfKApJ9M01t2QhxxZL6F/nmOBHls0syKIlPnrS0BoeL/U+JLTQufTdCRA==
X-Received: by 2002:ad4:598f:: with SMTP id ek15mr15322246qvb.196.1591129155503;
        Tue, 02 Jun 2020 13:19:15 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id m53sm31256qtb.64.2020.06.02.13.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 13:19:14 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id d13so4395426ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 13:19:14 -0700 (PDT)
X-Received: by 2002:a25:3187:: with SMTP id x129mr46106604ybx.428.1591129153446;
 Tue, 02 Jun 2020 13:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080535.1427-1-victor@inliniac.net> <CA+FuTSfD2-eF0H=Qu09=JXK6WTiWKNtcqRXqv3TfMfB-=0GiMg@mail.gmail.com>
 <b0a9d785-9d5e-9897-b051-6d9a1e8f914e@inliniac.net> <CA+FuTSd07inNysGhx088hq_jybrikSQdxw8HYjmP84foXhnXOA@mail.gmail.com>
 <06479df9-9da4-dbda-5bd1-f6e4d61471d0@inliniac.net> <CA+FuTSci29=W89CLweZcW=RTKwEXpUdPjsLGTB95iSNcnpU_Lw@mail.gmail.com>
 <6a3dcce9-4635-28e9-d78e-1c7f1f7874da@inliniac.net> <CA+FuTSdmtC4+0cnC2K1gwRLksXgb4hffUpyRbHjjGZbOJOfL0w@mail.gmail.com>
 <21a2224a-65f2-6375-589d-9cadb4fab840@inliniac.net>
In-Reply-To: <21a2224a-65f2-6375-589d-9cadb4fab840@inliniac.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 2 Jun 2020 16:18:36 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdczH+i8+FO+eQ+OT4-bsRAKG+jacPiuRu3jMszpV_2XA@mail.gmail.com>
Message-ID: <CA+FuTSdczH+i8+FO+eQ+OT4-bsRAKG+jacPiuRu3jMszpV_2XA@mail.gmail.com>
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

On Tue, Jun 2, 2020 at 4:05 PM Victor Julien <victor@inliniac.net> wrote:
>
> On 02-06-2020 21:38, Willem de Bruijn wrote:
> > On Tue, Jun 2, 2020 at 3:22 PM Victor Julien <victor@inliniac.net> wrote:
> >>
> >> On 02-06-2020 21:03, Willem de Bruijn wrote:
> >>> On Tue, Jun 2, 2020 at 2:31 PM Victor Julien <victor@inliniac.net> wrote:
> >>>> On 02-06-2020 19:37, Willem de Bruijn wrote:
> >>>>> On Tue, Jun 2, 2020 at 1:03 PM Victor Julien <victor@inliniac.net> wrote:
> >>>>>>
> >>>>>> On 02-06-2020 16:29, Willem de Bruijn wrote:
> >>>>>>> On Tue, Jun 2, 2020 at 4:05 AM Victor Julien <victor@inliniac.net> wrote:
> >>>>>>>>
> >>>>>>>> Introduce a new flag (TP_STATUS_CSUM_UNNECESSARY) to indicate
> >>>>>>>> that the driver has completely validated the checksums in the packet.
> >>>>>>>>
> >>>>>>>> The TP_STATUS_CSUM_UNNECESSARY flag differs from TP_STATUS_CSUM_VALID
> >>>>>>>> in that the new flag will only be set if all the layers are valid,
> >>>>>>>> while TP_STATUS_CSUM_VALID is set as well if only the IP layer is valid.
> >>>>>>>
> >>>>>>> transport, not ip checksum.
> >>>>>>
> >>>>>> Allow me a n00b question: what does transport refer to here? Things like
> >>>>>> ethernet? It isn't clear to me from the doc.
> >>>>>
> >>>>> The TCP/UDP/.. transport protocol checksum.
> >>>>
> >>>> Hmm that is what I thought originally, but then it didn't seem to work.
> >>>> Hence my patch.
> >>>>
> >>>> However I just redid my testing. I took the example tpacketv3 program
> >>>> and added the status flag checks to the 'display()' func:
> >>>>
> >>>>                 if (ppd->tp_status & TP_STATUS_CSUM_VALID) {
> >>>>                         printf("TP_STATUS_CSUM_VALID, ");
> >>>>                 }
> >>>>                 if (ppd->tp_status & (1<<8)) {
> >>>>                         printf("TP_STATUS_CSUM_UNNECESSARY, ");
> >>>>
> >>>>                 }
> >>>>
> >>>> Then using scapy sent some packets in 2 variants:
> >>>> - default (good csums)
> >>>> - deliberately bad csums
> >>>> (then also added a few things like ip6 over ip)
> >>>>
> >>>>
> >>>> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(),
> >>>> iface="enp1s0") // good csums
> >>>>
> >>>> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(chksum=1),
> >>>> iface="enp1s0") //bad tcp
> >>>
> >>> Is this a test between two machines? What is the device driver of the
> >>> machine receiving and printing the packet? It would be helpful to know
> >>> whether this uses CHECKSUM_COMPLETE or CHECKSUM_UNNECESSARY.
> >>
> >> Yes 2 machines, or actually 2 machines and a VM. The receiving Linux
> >> sits in a kvm vm with network pass through and uses the virtio driver
> >> (host uses e1000e). Based on a quick 'git grep CHECKSUM_UNNECESSARY'
> >> virtio seems to support that.
> >>
> >> I've done some more tests. In a pcap replay that I know contains packet
> >> with bad TCP csums (but good IP csums for those pkts), to a physical
> >> host running Ubuntu Linux kernel 5.3:
> >>
> >> - receiver uses nfp (netronome) driver: TP_STATUS_CSUM_VALID set for
> >> every packet, including the bad TCP ones
> >> - receiver uses ixgbe driver: TP_STATUS_CSUM_VALID not set for the bad
> >> packets.
> >
> > Great. Thanks a lot for running all these experiments.
> >
> > We might have to drop the TP_STATUS_CSUM_VALID with CHECKSUM_COMPLETE
> > unless skb->csum_valid.
> >
> > For packets with multiple transport layer checksums,
> > CHECKSUM_UNNECESSARY should mean that all have been verified.
> >
> > I believe that in the case of multiple transport headers, csum_valid
> > similarly ensures all checksums up to csum_start are valid. Will need
> > to double check.
> >
> > If so, there probably is no need for a separate new TP_STATUS.
> > TP_STATUS_CSUM_VALID is reported only when all checksums are valid.
>
> So if I understand you correctly the key may be in the call to
> `skb_csum_unnecessary`:
>
> That reads:
>
> static inline int skb_csum_unnecessary(const struct sk_buff *skb)
> {
>         return ((skb->ip_summed == CHECKSUM_UNNECESSARY) ||
>                 skb->csum_valid ||
>                 (skb->ip_summed == CHECKSUM_PARTIAL &&
>                  skb_checksum_start_offset(skb) >= 0));
> }
>
> But really only the first 2 conditions are reachable

.. from this codepath. That function is called in other codepaths as well.

> , as we already know
> skb->ip_summed is not CHECKSUM_PARTIAL when we call it.
>
> So our unmodified check is:
>
>         else if (skb->pkt_type != PACKET_OUTGOING &&
>                 (skb->ip_summed == CHECKSUM_COMPLETE ||
>                  skb->ip_summed == CHECKSUM_UNNECESSARY ||
>                  skb->csum_valid))
>
> Should this become something like:
>
>         else if (skb->pkt_type != PACKET_OUTGOING &&
>                 (skb->ip_summed == CHECKSUM_COMPLETE &&
>                  skb->csum_valid) ||
>                  skb->ip_summed == CHECKSUM_UNNECESSARY)
>
> Is this what you had in mind?

I don't suggest modifying skb_csum_unnecessary probably. Certainly not
until I've looked at all other callers of it.

But in case of packet sockets, yes, adding that csum_valid check is my
first rough approximation.

That said, first let's give others more familiar with
TP_STATUS_CSUM_VALID some time to comment.
