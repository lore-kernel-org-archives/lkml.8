Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EE8206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nT+oxDDS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgFBTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:04:37 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1EBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:04:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so13612208qkm.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydjZZ/ilQLsmdZFvWneFx8YQw0naaW6pMoRk4YZc32g=;
        b=nT+oxDDS7llQ8jlw8oVLNxwiKx8QkQh0lqFx+X+OJ4rrD9GaMGlCbh5k+zmjxrgoB7
         aZS50ng2VjS0dmHyWGig7J+DtV+HGrey5UvShw2UKWL30q1y5CyqZgXHpBm33PFkqRjn
         hv25zLn7EKwnljJgEHcxIfj1jwaE6rO1J9c8Q1xA/M7QoqQ55v3Huct2Z8Z/LLgRgd28
         3aLG3NTuAGh/k8jACu9eNjWvR0IMPWTzhGfr+ykXZ0FbhHPGaXXqhJoPGQ3hbg0VY6fb
         qhC/KlJX6NFMiVkOlavw4otwGW9QumjgXovMRgujsFufxretv/CaMxaZEJ+7yyq0ja5K
         QkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydjZZ/ilQLsmdZFvWneFx8YQw0naaW6pMoRk4YZc32g=;
        b=WX5/MX8sBF1D9xribM5l4uHa09sapA79qCnyV9tPTJKC0HF5lwHhbJqqGBKB4AdkUK
         XhzO1FGXsG2ZMUt11Z0JTxX0eEig/qUHwSu2PjQJ7s45l4HESQZoh1lCrBmp5HvzfJzJ
         PFpFVA0cDU2PJ6WZPEMWsblSQpc7pmvuUsefXm2mB5R+r/XYVL7n1gK9I7QU/PbZoZRn
         FoW1xSO5r9Ks/6QHLSXZ20ydUrPTkP4m1D1KsZrz5Jj78G7MswN7zLsUPXgMXxYqTivK
         fI+6nbqnmpgDYxwi/RTejpt61xah44412EQ8LEc3ILuUuU15Q2I9BUu68M83R6pTEKXa
         Wr5w==
X-Gm-Message-State: AOAM530TNOpWq1PgcgCocIpbOV5xnPOoibjS9J/Xj19qazNGDokqsFpr
        sMqVhKT+0O0f+Je/irAzlypYAjf2
X-Google-Smtp-Source: ABdhPJyHy+BVL3iUYNXovJJgsKPzAwOsnJ4rZssVvV6fjooQnT1NWAhXxzTcuh0yBzLywJJ+S8YnIw==
X-Received: by 2002:a37:b847:: with SMTP id i68mr25746055qkf.431.1591124674070;
        Tue, 02 Jun 2020 12:04:34 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id k10sm2870056qkh.47.2020.06.02.12.04.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:04:33 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id j8so7562036ybj.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:04:32 -0700 (PDT)
X-Received: by 2002:a25:f413:: with SMTP id q19mr45810132ybd.178.1591124672091;
 Tue, 02 Jun 2020 12:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200602080535.1427-1-victor@inliniac.net> <CA+FuTSfD2-eF0H=Qu09=JXK6WTiWKNtcqRXqv3TfMfB-=0GiMg@mail.gmail.com>
 <b0a9d785-9d5e-9897-b051-6d9a1e8f914e@inliniac.net> <CA+FuTSd07inNysGhx088hq_jybrikSQdxw8HYjmP84foXhnXOA@mail.gmail.com>
 <06479df9-9da4-dbda-5bd1-f6e4d61471d0@inliniac.net>
In-Reply-To: <06479df9-9da4-dbda-5bd1-f6e4d61471d0@inliniac.net>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 2 Jun 2020 15:03:55 -0400
X-Gmail-Original-Message-ID: <CA+FuTSci29=W89CLweZcW=RTKwEXpUdPjsLGTB95iSNcnpU_Lw@mail.gmail.com>
Message-ID: <CA+FuTSci29=W89CLweZcW=RTKwEXpUdPjsLGTB95iSNcnpU_Lw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] af-packet: new flag to indicate all csums are good
To:     Victor Julien <victor@inliniac.net>
Cc:     Network Development <netdev@vger.kernel.org>,
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

On Tue, Jun 2, 2020 at 2:31 PM Victor Julien <victor@inliniac.net> wrote:
>
> Hi Willem,
>
> On 02-06-2020 19:37, Willem de Bruijn wrote:
> > On Tue, Jun 2, 2020 at 1:03 PM Victor Julien <victor@inliniac.net> wrote:
> >>
> >> On 02-06-2020 16:29, Willem de Bruijn wrote:
> >>> On Tue, Jun 2, 2020 at 4:05 AM Victor Julien <victor@inliniac.net> wrote:
> >>>>
> >>>> Introduce a new flag (TP_STATUS_CSUM_UNNECESSARY) to indicate
> >>>> that the driver has completely validated the checksums in the packet.
> >>>>
> >>>> The TP_STATUS_CSUM_UNNECESSARY flag differs from TP_STATUS_CSUM_VALID
> >>>> in that the new flag will only be set if all the layers are valid,
> >>>> while TP_STATUS_CSUM_VALID is set as well if only the IP layer is valid.
> >>>
> >>> transport, not ip checksum.
> >>
> >> Allow me a n00b question: what does transport refer to here? Things like
> >> ethernet? It isn't clear to me from the doc.
> >
> > The TCP/UDP/.. transport protocol checksum.
>
> Hmm that is what I thought originally, but then it didn't seem to work.
> Hence my patch.
>
> However I just redid my testing. I took the example tpacketv3 program
> and added the status flag checks to the 'display()' func:
>
>                 if (ppd->tp_status & TP_STATUS_CSUM_VALID) {
>                         printf("TP_STATUS_CSUM_VALID, ");
>                 }
>                 if (ppd->tp_status & (1<<8)) {
>                         printf("TP_STATUS_CSUM_UNNECESSARY, ");
>
>                 }
>
> Then using scapy sent some packets in 2 variants:
> - default (good csums)
> - deliberately bad csums
> (then also added a few things like ip6 over ip)
>
>
> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(),
> iface="enp1s0") // good csums
>
> srp1(Ether()/IP(src="1.2.3.4", dst="5.6.7.8")/IPv6()/TCP(chksum=1),
> iface="enp1s0") //bad tcp

Is this a test between two machines? What is the device driver of the
machine receiving and printing the packet? It would be helpful to know
whether this uses CHECKSUM_COMPLETE or CHECKSUM_UNNECESSARY.

>
> 1.2.3.4 -> 5.6.7.8, TP_STATUS_CSUM_VALID, TP_STATUS_CSUM_UNNECESSARY,
> rxhash: 0x81ad5744
> 1.2.3.4 -> 5.6.7.8, rxhash: 0x81ad5744
>
> So this suggests that what you're saying is correct, that it sets
> TP_STATUS_CSUM_VALID if the TCP/UDP csum (and IPv4 csum) is valid, and
> does not set it when either of them are invalid.

That's not exactly what I said. It looks to me that a device that sets
CHECKSUM_COMPLETE will return TP_STATUS_CSUM_VALID from
__netif_receive_skb_core even if the TCP checksum turns out to be bad.
If a driver would insert such packets into the stack, that is.

> I'll also re-evaluate things in Suricata.
>
>
> One thing I wonder if what this "at least" from the 682f048bd494 commit
> message means:
>
> "Introduce TP_STATUS_CSUM_VALID tp_status flag to tell the
>  af_packet user that at least the transport header checksum
>  has been already validated."
>
> For TCP/UDP there wouldn't be a higher layer with csums, right? And
> based on my testing it seems lower levels (at least IP) is also
> included. Or would that perhaps refer to something like VXLAN or Geneve
> over UDP? That the csums of packets on top of those layers aren't
> (necessarily) considered?

The latter. All these checksums are about transport layer checksums
(the ip header checksum is cheap to compute). Multiple checksums
refers to packets encapsulated in other protocols with checksum, such
as GRE or UDP based like Geneve.

>
> Thanks,
> Victor
>
>
> >> (happy to follow up with a patch to clarify the doc when I understand
> >> things better)
> >>
> >>> But as I understand it drivers set CHECKSUM_COMPLETE if they fill in
> >>> skb->csum over the full length of the packet. This does not
> >>> necessarily imply that any of the checksum fields in the packet are
> >>> valid yet (see also skb->csum_valid). Protocol code later compares
> >>> checksum fields against this using __skb_checksum_validate_complete and friends.
> >>>
> >>> But packet sockets may be called before any of this, however. So I wonder
> >>> how valid the checksum really is right now when setting TP_STATUS_CSUM_VALID.
> >>> I assume it's correct, but don't fully understand where the validation
> >>> has taken place..
> >>
> >> I guess I'm more confused now about what TP_STATUS_CSUM_VALID actually
> >> means. It sounds almost like the opposite of TP_STATUS_CSUMNOTREADY, but
> >> I'm not sure I understand what the value would be.
> >>
> >> It would be great if someone could help clear this up. Everything I
> >> thought I knew/understood so far has been proven wrong, so I'm not too
> >> confident about my patch anymore...
> >
> > Agreed that we should clear this up.
> >
> >>> Similar to commit 682f048bd494 ("af_packet: pass checksum validation
> >>> status to the user"), please update tpacket_rcv and packet_rcv.
> >>
> >> Ah yes, good catch. Will add it there as well.
> >>
> >>> Note also that net-next is currently closed.
> >>
> >> Should I hold off on sending a v3 until it reopens?
> >
> > Yep, thanks. You can always check
> > http://vger.kernel.org/~davem/net-next.html when unsure.
> >
>
>
> --
> ---------------------------------------------
> Victor Julien
> http://www.inliniac.net/
> PGP: http://www.inliniac.net/victorjulien.asc
> ---------------------------------------------
>
