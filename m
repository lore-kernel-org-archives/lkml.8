Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBCAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01E5520734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amqBxYT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgFBTjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:39:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD73C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:39:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so11670411qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r8eLIVv68gBsRSDz9CW008mKoMt+hqkEqiGDmYD62hw=;
        b=amqBxYT7EMSUspo4HySNczuuD8gZZR0K+lz1bN5U0mWXvLcFNFUlDVXUbLCoJKNsgi
         hyh1sd7ZqBHY6/UWg3tUXMGF/gUjmE4iQvHG21psp4Gl8YqNg/A7sBcJH8xixEnLddEm
         ZZ7YAIE28E3ZF2S6L2FDGUuzRVjz9di4L5xHdwP7nMW8qcVPXY8q8/KK8YhPqRjmLpQH
         /OZ+3Bbus/OQtHKPyNDiggSr5g6W80NQ309xNmiC+5jR8oKqQFPBXOIr0iRYl+zJVFIi
         zQkXgoqAAxtbW0BltoAOmySopm+oNW3zlROFOHNtmGLjmyp5Oj4hAoJ+LQulS+3cby3/
         0iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r8eLIVv68gBsRSDz9CW008mKoMt+hqkEqiGDmYD62hw=;
        b=q6e9RgIAIck1HyNWBlFgAxVbRAOSJsZ0rMe/CKoIGO50JIbtDj2Ptk2qwXMB0e1Lyl
         k3FocGzonMPCqnwNMI1GpRw/hKO2dxvxfLgC8prhzWR43IdRXS8Mnl1vjRRS95mFv6Io
         sw3scxzndz1SfloWy0tOSMN2ov+fcFCqwafco4xlRgHhqXgTQ68nuUCCT6rrPs23zk3x
         jgfdHjiGZ4VGeodfbUPwxCPxLxIn8dpSJmNQWR3Cs8Y9+oBJtPPIP6bgmhw3lCvYUx2g
         GULiPdK26DYtcruxUxtTN+aF4A29IJ4tue/ZIULDwdz6fusM/ERfBaW8MslGhCHYzuJh
         4Jgw==
X-Gm-Message-State: AOAM5301kjILLN4tmUlGi/+SMkjnel5DUNbchtIRp6bnEDNWXocrk5dR
        ON7AeIL0uJlTLp5qhKHsQw7gpOMV
X-Google-Smtp-Source: ABdhPJxeUPavqLJ85WJR2hbenyeKbpgCrcOCnRUZ9abie7qq02CiyQr0AIX7uGqt5yn/y/UuQAjTpQ==
X-Received: by 2002:aed:2a19:: with SMTP id c25mr993057qtd.345.1591126742933;
        Tue, 02 Jun 2020 12:39:02 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id n25sm3144483qkk.76.2020.06.02.12.39.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:39:01 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id n5so1359309ybo.7
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:39:01 -0700 (PDT)
X-Received: by 2002:a25:3187:: with SMTP id x129mr45851100ybx.428.1591126740796;
 Tue, 02 Jun 2020 12:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080535.1427-1-victor@inliniac.net> <CA+FuTSfD2-eF0H=Qu09=JXK6WTiWKNtcqRXqv3TfMfB-=0GiMg@mail.gmail.com>
 <b0a9d785-9d5e-9897-b051-6d9a1e8f914e@inliniac.net> <CA+FuTSd07inNysGhx088hq_jybrikSQdxw8HYjmP84foXhnXOA@mail.gmail.com>
 <06479df9-9da4-dbda-5bd1-f6e4d61471d0@inliniac.net> <CA+FuTSci29=W89CLweZcW=RTKwEXpUdPjsLGTB95iSNcnpU_Lw@mail.gmail.com>
 <6a3dcce9-4635-28e9-d78e-1c7f1f7874da@inliniac.net>
In-Reply-To: <6a3dcce9-4635-28e9-d78e-1c7f1f7874da@inliniac.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 2 Jun 2020 15:38:23 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdmtC4+0cnC2K1gwRLksXgb4hffUpyRbHjjGZbOJOfL0w@mail.gmail.com>
Message-ID: <CA+FuTSdmtC4+0cnC2K1gwRLksXgb4hffUpyRbHjjGZbOJOfL0w@mail.gmail.com>
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

On Tue, Jun 2, 2020 at 3:22 PM Victor Julien <victor@inliniac.net> wrote:
>
> On 02-06-2020 21:03, Willem de Bruijn wrote:
> > On Tue, Jun 2, 2020 at 2:31 PM Victor Julien <victor@inliniac.net> wrote:
> >> On 02-06-2020 19:37, Willem de Bruijn wrote:
> >>> On Tue, Jun 2, 2020 at 1:03 PM Victor Julien <victor@inliniac.net> wrote:
> >>>>
> >>>> On 02-06-2020 16:29, Willem de Bruijn wrote:
> >>>>> On Tue, Jun 2, 2020 at 4:05 AM Victor Julien <victor@inliniac.net> wrote:
> >>>>>>
> >>>>>> Introduce a new flag (TP_STATUS_CSUM_UNNECESSARY) to indicate
> >>>>>> that the driver has completely validated the checksums in the packet.
> >>>>>>
> >>>>>> The TP_STATUS_CSUM_UNNECESSARY flag differs from TP_STATUS_CSUM_VALID
> >>>>>> in that the new flag will only be set if all the layers are valid,
> >>>>>> while TP_STATUS_CSUM_VALID is set as well if only the IP layer is valid.
> >>>>>
> >>>>> transport, not ip checksum.
> >>>>
> >>>> Allow me a n00b question: what does transport refer to here? Things like
> >>>> ethernet? It isn't clear to me from the doc.
> >>>
> >>> The TCP/UDP/.. transport protocol checksum.
> >>
> >> Hmm that is what I thought originally, but then it didn't seem to work.
> >> Hence my patch.
> >>
> >> However I just redid my testing. I took the example tpacketv3 program
> >> and added the status flag checks to the 'display()' func:
> >>
> >>                 if (ppd->tp_status & TP_STATUS_CSUM_VALID) {
> >>                         printf("TP_STATUS_CSUM_VALID, ");
> >>                 }
> >>                 if (ppd->tp_status & (1<<8)) {
> >>                         printf("TP_STATUS_CSUM_UNNECESSARY, ");
> >>
> >>                 }
> >>
> >> Then using scapy sent some packets in 2 variants:
> >> - default (good csums)
> >> - deliberately bad csums
> >> (then also added a few things like ip6 over ip)
> >>
> >>
> >> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(),
> >> iface="enp1s0") // good csums
> >>
> >> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(chksum=1),
> >> iface="enp1s0") //bad tcp
> >
> > Is this a test between two machines? What is the device driver of the
> > machine receiving and printing the packet? It would be helpful to know
> > whether this uses CHECKSUM_COMPLETE or CHECKSUM_UNNECESSARY.
>
> Yes 2 machines, or actually 2 machines and a VM. The receiving Linux
> sits in a kvm vm with network pass through and uses the virtio driver
> (host uses e1000e). Based on a quick 'git grep CHECKSUM_UNNECESSARY'
> virtio seems to support that.
>
> I've done some more tests. In a pcap replay that I know contains packet
> with bad TCP csums (but good IP csums for those pkts), to a physical
> host running Ubuntu Linux kernel 5.3:
>
> - receiver uses nfp (netronome) driver: TP_STATUS_CSUM_VALID set for
> every packet, including the bad TCP ones
> - receiver uses ixgbe driver: TP_STATUS_CSUM_VALID not set for the bad
> packets.

Great. Thanks a lot for running all these experiments.

We might have to drop the TP_STATUS_CSUM_VALID with CHECKSUM_COMPLETE
unless skb->csum_valid.

For packets with multiple transport layer checksums,
CHECKSUM_UNNECESSARY should mean that all have been verified.

I believe that in the case of multiple transport headers, csum_valid
similarly ensures all checksums up to csum_start are valid. Will need
to double check.

If so, there probably is no need for a separate new TP_STATUS.
TP_STATUS_CSUM_VALID is reported only when all checksums are valid.

> Again purely based on 'git grep' it seems nfp does not support
> UNNECESSARY, while ixgbe does.
>
> (my original testing was with the nfp only, so now I at least understand
> my original thinking)
>
>
> >>
> >> 1.2.3.4 -> 5.6.7.8, TP_STATUS_CSUM_VALID, TP_STATUS_CSUM_UNNECESSARY,
> >> rxhash: 0x81ad5744
> >> 1.2.3.4 -> 5.6.7.8, rxhash: 0x81ad5744
> >>
> >> So this suggests that what you're saying is correct, that it sets
> >> TP_STATUS_CSUM_VALID if the TCP/UDP csum (and IPv4 csum) is valid, and
> >> does not set it when either of them are invalid.
> >
> > That's not exactly what I said. It looks to me that a device that sets
> > CHECKSUM_COMPLETE will return TP_STATUS_CSUM_VALID from
> > __netif_receive_skb_core even if the TCP checksum turns out to be bad.
> > If a driver would insert such packets into the stack, that is.
>
> Ok, this might be confirmed by my nfp vs virtio/ixgbe observations
> mentioned above.
>
>
> >> I'll also re-evaluate things in Suricata.
> >>
> >>
> >> One thing I wonder if what this "at least" from the 682f048bd494 commit
> >> message means:
> >>
> >> "Introduce TP_STATUS_CSUM_VALID tp_status flag to tell the
> >>  af_packet user that at least the transport header checksum
> >>  has been already validated."
> >>
> >> For TCP/UDP there wouldn't be a higher layer with csums, right? And
> >> based on my testing it seems lower levels (at least IP) is also
> >> included. Or would that perhaps refer to something like VXLAN or Geneve
> >> over UDP? That the csums of packets on top of those layers aren't
> >> (necessarily) considered?
> >
> > The latter. All these checksums are about transport layer checksums
> > (the ip header checksum is cheap to compute). Multiple checksums
> > refers to packets encapsulated in other protocols with checksum, such
> > as GRE or UDP based like Geneve.
>
> If nothing else comes from this I'll at least propose doc patch to
> clarify this for ppl like myself.
>
> Thanks,
> Victor
>
> --
> ---------------------------------------------
> Victor Julien
> http://www.inliniac.net/
> PGP: http://www.inliniac.net/victorjulien.asc
> ---------------------------------------------
>
