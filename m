Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACBC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E48B20772
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6A45aPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgIDPxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgIDPxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:53:32 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E971C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:53:32 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id b123so3878519vsd.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLumBIyrNOq/hTxfUm0kdkK8AwRxFYD3LDELwXYzMqA=;
        b=R6A45aPlJ0w5msG+4ei9OYnk4jxHSJ8ZdXhLyN/73I7fHxDUvh/hqNdOEof+yNPcW0
         7sYEi3+O0fFnt+QPF5nwB4BuEn7XOT1G2d5F/5JyeiwQ9m+nIj29ZRwQMYNi4hswJszd
         mIt67zsWKVqIJMTy1eefBI7ZAYQtcl+dmDfhPPWZzYCHpA1nki77AkyYUX5x9pdswE5C
         nYl9suhp+b90ERuOE5u7nBTgYeVELqBSK0b81SfCeY3a+bahjVd2uI3vx/hE/KvakVWo
         AbI3A/bG4jxBNwkvT0tj7PRh1Twmwxba5lD/N7wT12B4xpB1x++sqC9ipUaNBml0e4oY
         Q9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLumBIyrNOq/hTxfUm0kdkK8AwRxFYD3LDELwXYzMqA=;
        b=AVcoPxfaj5sx4h0TfYd1cK3WpeDmJLllWaBMyMjMQkVmKalIZALGo0Gm2PXm/kCcFF
         513+qvR1nA9MDE+BnXpeIAMtb1L8IoPZZHntySjENNYFA1asnW0wnrCWr3CWTF8LIG7E
         mEu5++/5zCL1PMzERzZIqOr33xlxcQZE+fL4WWWmEYKKDzrKjpax9GLmlZGPXawRkoWa
         /OJy0IJoc0JngIz1sMXI03Q8DyL/eUwlFn1LcQ6ZrhMY7CBosYBcjbpBEotoZLqebZpQ
         0mDgxnCKigwm76MP/upC1oGiZcvl0mlTA+j+6YI799mLxPjj0Uv8wst8E5ai3ORnX+Bh
         6YXA==
X-Gm-Message-State: AOAM5315j0Xe+CD3opGTE7rnvzjW9vJfGVHCE99XsAnBn+e8uMmEv5G6
        fNXpZPsvRBS6GmxMBcRIgOM0fcyo9al9BA==
X-Google-Smtp-Source: ABdhPJz2ekJ9Md5syEsWeMlwlNwoStJYYDF/JxGZXHbTxMZBV9udtfMfAAIS617NgYOvWkzfpGPtbA==
X-Received: by 2002:a67:2f07:: with SMTP id v7mr6149641vsv.95.1599234810788;
        Fri, 04 Sep 2020 08:53:30 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id g138sm1055402vke.21.2020.09.04.08.53.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 08:53:30 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id v20so2152847ual.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:53:30 -0700 (PDT)
X-Received: by 2002:ab0:24cd:: with SMTP id k13mr5264523uan.92.1599234808972;
 Fri, 04 Sep 2020 08:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200901195415.4840-1-m-karicheri2@ti.com> <d93fbc54-1721-ebec-39ca-dc8b45e6e534@ti.com>
 <15bbf7d2-627b-1d52-f130-5bae7b7889de@ti.com>
In-Reply-To: <15bbf7d2-627b-1d52-f130-5bae7b7889de@ti.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 4 Sep 2020 17:52:51 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeri93irC9eaQqrFrY2++d0zJ4-F0YAfCXfX6XVVqU6Pw@mail.gmail.com>
Message-ID: <CA+FuTSeri93irC9eaQqrFrY2++d0zJ4-F0YAfCXfX6XVVqU6Pw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/1] Support for VLAN interface over HSR/PRP
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, nsekhar@ti.com,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 12:30 AM Murali Karicheri <m-karicheri2@ti.com> wrote:
>
> All,
>
> On 9/2/20 12:14 PM, Murali Karicheri wrote:
> > All,
> >
> > On 9/1/20 3:54 PM, Murali Karicheri wrote:
> >> This series add support for creating VLAN interface over HSR or
> >> PRP interface. Typically industrial networks uses VLAN in
> >> deployment and this capability is needed to support these
> >> networks.
> >>
> >> This is tested using two TI AM572x IDK boards connected back
> >> to back over CPSW  ports (eth0 and eth1).
> >>
> >> Following is the setup
> >>
> >>                  Physical Setup
> >>                  ++++++++++++++
> >>   _______________    (CPSW)     _______________
> >>   |              |----eth0-----|               |
> >>   |TI AM572x IDK1|             | TI AM572x IDK2|
> >>   |______________|----eth1-----|_______________|
> >>
> >>
> >>                  Network Topolgy
> >>                  +++++++++++++++
> >>
> >>                         TI AM571x IDK  TI AM572x IDK
> >>
> >> 192.168.100.10                 CPSW ports                 192.168.100.20
> >>               IDK-1                                        IDK-2
> >> hsr0/prp0.100--| 192.168.2.10  |--eth0--| 192.168.2.20 |--hsr0/prp0.100
> >>                 |----hsr0/prp0--|        |---hsr0/prp0--|
> >> hsr0/prp0.101--|               |--eth1--|              |--hsr0/prp0/101
> >>
> >> 192.168.101.10                                            192.168.101.20
> >>
> >> Following tests:-
> >>   - create hsr or prp interface and ping the interface IP address
> >>     and verify ping is successful.
> >>   - Create 2 VLANs over hsr or prp interface on both IDKs (VID 100 and
> >>     101). Ping between the IP address of the VLAN interfaces
> >>   - Do iperf UDP traffic test with server on one IDK and client on the
> >>     other. Do this using 100 and 101 subnet IP addresses
> >>   - Dump /proc/net/vlan/{hsr|prp}0.100 and verify frames are transmitted
> >>     and received at these interfaces.
> >>   - Delete the vlan and hsr/prp interface and verify interfaces are
> >>     removed cleanly.
> >>
> >> Logs for IDK-1 at https://pastebin.ubuntu.com/p/NxF83yZFDX/
> >> Logs for IDK-2 at https://pastebin.ubuntu.com/p/YBXBcsPgVK/
> >>
> >> Murali Karicheri (1):
> >>    net: hsr/prp: add vlan support
> >>
> >>   net/hsr/hsr_device.c  |  4 ----
> >>   net/hsr/hsr_forward.c | 16 +++++++++++++---
> >>   2 files changed, 13 insertions(+), 7 deletions(-)
> >>
> > I am not sure if the packet flow is right for this?
> >
> > VLAN over HSR frame format is like this.
> >
> > <Start of Frame><VLAN tag><HSR Tag><IP><CRC>
> >
> > My ifconfig stats shows both hsr and hsr0.100 interfaces receiving
> > frames.
> >
> > So I did a WARN_ON() in HSR driver before frame is forwarded to upper
> > layer.
> >
> > a0868495local@uda0868495:~/Projects/upstream-kernel$ git diff
> > diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> > index de21df30b0d9..545a3cd8c71b 100644
> > --- a/net/hsr/hsr_forward.c
> > +++ b/net/hsr/hsr_forward.c
> > @@ -415,9 +415,11 @@ static void hsr_forward_do(struct hsr_frame_info
> > *frame)
> >                  }
> >
> >                  skb->dev = port->dev;
> > -               if (port->type == HSR_PT_MASTER)
> > +               if (port->type == HSR_PT_MASTER) {
> > +                       if (skb_vlan_tag_present(skb))
> > +                               WARN_ON(1);
> >                          hsr_deliver_master(skb, port->dev,
> > frame->node_src);
> > -               else
> > +               } else
> >                          hsr_xmit(skb, port, frame);
> >          }
> >   }
> >
> > And I get the trace shown below.
> >
> > [  275.125431] WARNING: CPU: 0 PID: 0 at net/hsr/hsr_forward.c:420
> > hsr_forward_skb+0x460/0x564
> > [  275.133822] Modules linked in: snd_soc_omap_hdmi snd_soc_ti_sdma
> > snd_soc_core snd_pcm_dmaengine snd_pcm snd_time4
> > [  275.199705] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W
> > 5.9.0-rc1-00658-g473e463812c2-dirty #8
> > [  275.209573] Hardware name: Generic DRA74X (Flattened Device Tree)
> > [  275.215703] [<c011177c>] (unwind_backtrace) from [<c010b6f0>]
> > (show_stack+0x10/0x14)
> > [  275.223487] [<c010b6f0>] (show_stack) from [<c055690c>]
> > (dump_stack+0xc4/0xe4)
> > [  275.230747] [<c055690c>] (dump_stack) from [<c01386ac>]
> > (__warn+0xc0/0xf4)
> > [  275.237656] [<c01386ac>] (__warn) from [<c0138a3c>]
> > (warn_slowpath_fmt+0x58/0xb8)
> > [  275.245177] [<c0138a3c>] (warn_slowpath_fmt) from [<c09564bc>]
> > (hsr_forward_skb+0x460/0x564)
> > [  275.253657] [<c09564bc>] (hsr_forward_skb) from [<c0955534>]
> > (hsr_handle_frame+0x15c/0x190)
> > [  275.262047] [<c0955534>] (hsr_handle_frame) from [<c07c6704>]
> > (__netif_receive_skb_core+0x23c/0xc88)
> > [  275.271223] [<c07c6704>] (__netif_receive_skb_core) from [<c07c7180>]
> > (__netif_receive_skb_one_core+0x30/0x74)
> > [  275.281266] [<c07c7180>] (__netif_receive_skb_one_core) from
> > [<c07c72a4>] (netif_receive_skb+0x50/0x1c4)
> > [  275.290793] [<c07c72a4>] (netif_receive_skb) from [<c071a55c>]
> > (cpsw_rx_handler+0x230/0x308)
> > [  275.299272] [<c071a55c>] (cpsw_rx_handler) from [<c0715ee8>]
> > (__cpdma_chan_process+0xf4/0x188)
> > [  275.307925] [<c0715ee8>] (__cpdma_chan_process) from [<c0717294>]
> > (cpdma_chan_process+0x3c/0x5c)
> > [  275.316754] [<c0717294>] (cpdma_chan_process) from [<c071dd14>]
> > (cpsw_rx_mq_poll+0x44/0x98)
> > [  275.325145] [<c071dd14>] (cpsw_rx_mq_poll) from [<c07c8ae0>]
> > (net_rx_action+0xf0/0x400)
> > [  275.333185] [<c07c8ae0>] (net_rx_action) from [<c0101370>]
> > (__do_softirq+0xf0/0x3ac)
> > [  275.340965] [<c0101370>] (__do_softirq) from [<c013f5ec>]
> > (irq_exit+0xa8/0xe4)
> > [  275.348224] [<c013f5ec>] (irq_exit) from [<c0199344>]
> > (__handle_domain_irq+0x6c/0xe0)
> > [  275.356093] [<c0199344>] (__handle_domain_irq) from [<c056f8fc>]
> > (gic_handle_irq+0x4c/0xa8)
> > [  275.364481] [<c056f8fc>] (gic_handle_irq) from [<c0100b6c>]
> > (__irq_svc+0x6c/0x90)
> > [  275.371996] Exception stack(0xc0e01f18 to 0xc0e01f60)
> >
> > Shouldn't it show vlan_do_receive() ?
> >
> >      if (skb_vlan_tag_present(skb)) {
> >          if (pt_prev) {
> >              ret = deliver_skb(skb, pt_prev, orig_dev);
> >              pt_prev = NULL;
> >          }
> >          if (vlan_do_receive(&skb))
> >              goto another_round;
> >          else if (unlikely(!skb))
> >              goto out;
> >      }
> >
> > Thanks
> >
>
> I did an ftrace today and I find vlan_do_receive() is called for the
> incoming frames before passing SKB to hsr_handle_frame(). If someone
> can review this, it will help. Thanks.
>
> https://pastebin.ubuntu.com/p/CbRzXjwjR5/

hsr_handle_frame is an rx_handler called after
__netif_receive_skb_core called vlan_do_receive and jumped back to
another_round.

That's how it should work right?
