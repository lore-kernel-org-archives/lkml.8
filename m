Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B67C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC7620738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFJ5yExL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgIHRhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731436AbgIHRfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:35:38 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC13FC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:35:37 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a16so9426814vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGxIFib/r1AIVUzF+ck89MPfdIoxyJ1DlRxuo3IZNeQ=;
        b=NFJ5yExL7/3iQk83uUdYEh0bCvRb1MSngEDrzPI56Q9R9TU5wB44JoXh0X93C/OBPF
         +G6RTxSI6s4NdshRb0TQfbOnAMNtqbyhgCkNMtPY81TUvxP380mkbh7S3EcM44rzP+LC
         Oli4l27QuVi0RBnEg5H9F1NXjfK4SlQvmPzLKbYHwbnnHsaTl96d4q+7rg1HT2jLpKgL
         ZVeNNk5uron6dcUdmrg5YPJxIiuZz/6yba0xlDbdEJMlJJjonQsvlvkgUOoKAfajpOHU
         HMiH/IgF1BUM0h9bVsnKOdhtA5DiA+ivfpABT6AnhNgD8E9qEs+Iu4Mx0cIUDpEq6gT2
         cmug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGxIFib/r1AIVUzF+ck89MPfdIoxyJ1DlRxuo3IZNeQ=;
        b=a5a7ODvoSK2EBRKWsAxybIhiULlQKBTU9aCMqeywbnVgXju4k9BJ2QvRayT3g7Atsx
         lJcENmh78nUwVUKkpcGatmZ4rFnWbC/M2SkMNcjFy01O84oUl31LQXM+rsspCw8OmYHO
         VwDGbE+pMdEWtcii/a4NQkTaHgNYylk0JioMf/vSg3+TYwQgrGlg+0N1fhUJqHAyfCHG
         ELqA8q9wFEuj8OIMsxzEt3BSHp1uqzSZ9ZOIUhR+WtAA1xJZLeaz/CS846xLHh8NLWSX
         rYjjtvEySaSwsfnf9IqRtRDWoVcjfHOVWS4eEuBBgR/qdjuAn0SZgifOqG6+KQskn97s
         PlJA==
X-Gm-Message-State: AOAM531I3cxMXO5rEGgaXUno+216IKMua/EILO/4PC2MJAcWAgbny5Lw
        3XIU838OQci2V2Gh2mwbIpCHo0P4wnR8Tw==
X-Google-Smtp-Source: ABdhPJyuIUl0/SPxVjgT+DGKmQonld71g0/PJibRYYf4mmHP6ackrP4d770L8tO9a30IA3OMHGjlCw==
X-Received: by 2002:a67:ef52:: with SMTP id k18mr151169vsr.25.1599586536398;
        Tue, 08 Sep 2020 10:35:36 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id s3sm1190001vkd.49.2020.09.08.10.35.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 10:35:35 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id q67so9478703vsd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:35:35 -0700 (PDT)
X-Received: by 2002:a67:f5d4:: with SMTP id t20mr176891vso.1.1599586534810;
 Tue, 08 Sep 2020 10:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200901195415.4840-1-m-karicheri2@ti.com> <20200901195415.4840-2-m-karicheri2@ti.com>
 <CA+FuTScPZ5sfHBwbFKQza6w4G1UcO8DaqrcpFuSvr9svgMEepw@mail.gmail.com> <581a90d0-243e-f62e-1c2e-a9683807805c@ti.com>
In-Reply-To: <581a90d0-243e-f62e-1c2e-a9683807805c@ti.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 19:34:56 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdDqx8ZwmvLceygpxTDC9=S8=jqFRCTWFoW-6YwihXTUQ@mail.gmail.com>
Message-ID: <CA+FuTSdDqx8ZwmvLceygpxTDC9=S8=jqFRCTWFoW-6YwihXTUQ@mail.gmail.com>
Subject: Re: [PATCH net-next 1/1] net: hsr/prp: add vlan support
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, nsekhar@ti.com,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 6:39 PM Murali Karicheri <m-karicheri2@ti.com> wrote:
>
> Hi Willem,
>
> Thanks for the response!
> On 9/4/20 11:45 AM, Willem de Bruijn wrote:
> > On Tue, Sep 1, 2020 at 9:54 PM Murali Karicheri <m-karicheri2@ti.com> wrote:
> >>
> >> This patch add support for creating vlan interfaces
> >> over hsr/prp interface.
> >>
> >> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> >> ---
> >>   net/hsr/hsr_device.c  |  4 ----
> >>   net/hsr/hsr_forward.c | 16 +++++++++++++---
> >>   2 files changed, 13 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> >> index ab953a1a0d6c..e1951579a3ad 100644
> >> --- a/net/hsr/hsr_device.c
> >> +++ b/net/hsr/hsr_device.c
> >> @@ -477,10 +477,6 @@ void hsr_dev_setup(struct net_device *dev)
> >>
> >>          /* Prevent recursive tx locking */
> >>          dev->features |= NETIF_F_LLTX;
> >> -       /* VLAN on top of HSR needs testing and probably some work on
> >> -        * hsr_header_create() etc.
> >> -        */
> >> -       dev->features |= NETIF_F_VLAN_CHALLENGED;
> >>          /* Not sure about this. Taken from bridge code. netdev_features.h says
> >>           * it means "Does not change network namespaces".
> >>           */
> >> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> >> index cadfccd7876e..de21df30b0d9 100644
> >> --- a/net/hsr/hsr_forward.c
> >> +++ b/net/hsr/hsr_forward.c
> >> @@ -208,6 +208,7 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
> >>                                      struct hsr_port *port, u8 proto_version)
> >>   {
> >>          struct hsr_ethhdr *hsr_ethhdr;
> >> +       unsigned char *pc;
> >>          int lsdu_size;
> >>
> >>          /* pad to minimum packet size which is 60 + 6 (HSR tag) */
> >> @@ -218,7 +219,18 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
> >>          if (frame->is_vlan)
> >>                  lsdu_size -= 4;
> >>
> >> -       hsr_ethhdr = (struct hsr_ethhdr *)skb_mac_header(skb);
> >> +       pc = skb_mac_header(skb);
> >> +       if (frame->is_vlan)
> >> +               /* This 4-byte shift (size of a vlan tag) does not
> >> +                * mean that the ethhdr starts there. But rather it
> >> +                * provides the proper environment for accessing
> >> +                * the fields, such as hsr_tag etc., just like
> >> +                * when the vlan tag is not there. This is because
> >> +                * the hsr tag is after the vlan tag.
> >> +                */
> >> +               hsr_ethhdr = (struct hsr_ethhdr *)(pc + VLAN_HLEN);
> >> +       else
> >> +               hsr_ethhdr = (struct hsr_ethhdr *)pc;
> >
> > Instead, I would pass the header from the caller, which knows the
> > offset because it moves the previous headers to make space.
> >
> So if I understood you correctly a diff for the above would like this
> where pass dst + movelen as  struct hsr_ethhdr *hsr_ethhdr
> pointer to hsr_fill_tag(), right?
>
> a0868495local@uda0868495:~/Projects/upstream-kernel$ git diff
> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index de21df30b0d9..4d9192c8bcf8 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c
> @@ -204,11 +204,10 @@ static void hsr_set_path_id(struct hsr_ethhdr
> *hsr_ethhdr,
>   }
>
>   static struct sk_buff *hsr_fill_tag(struct sk_buff *skb,
> +                                   struct hsr_ethhdr *hsr_ethhdr,
>                                      struct hsr_frame_info *frame,
>                                      struct hsr_port *port, u8
> proto_version)
>   {
> -       struct hsr_ethhdr *hsr_ethhdr;
> -       unsigned char *pc;
>          int lsdu_size;
>
>          /* pad to minimum packet size which is 60 + 6 (HSR tag) */
> @@ -219,19 +218,6 @@ static struct sk_buff *hsr_fill_tag(struct sk_buff
> *skb,
>          if (frame->is_vlan)
>                  lsdu_size -= 4;
>
> -       pc = skb_mac_header(skb);
> -       if (frame->is_vlan)
> -               /* This 4-byte shift (size of a vlan tag) does not
> -                * mean that the ethhdr starts there. But rather it
> -                * provides the proper environment for accessing
> -                * the fields, such as hsr_tag etc., just like
> -                * when the vlan tag is not there. This is because
> -                * the hsr tag is after the vlan tag.
> -                */
> -               hsr_ethhdr = (struct hsr_ethhdr *)(pc + VLAN_HLEN);
> -       else
> -               hsr_ethhdr = (struct hsr_ethhdr *)pc;
> -
>          hsr_set_path_id(hsr_ethhdr, port);
>          set_hsr_tag_LSDU_size(&hsr_ethhdr->hsr_tag, lsdu_size);
>          hsr_ethhdr->hsr_tag.sequence_nr = htons(frame->sequence_nr);
> @@ -280,10 +266,12 @@ struct sk_buff *hsr_create_tagged_frame(struct
> hsr_frame_info *frame,
>          memmove(dst, src, movelen);
>          skb_reset_mac_header(skb);
>
> -       /* skb_put_padto free skb on error and hsr_fill_tag returns NULL in
> -        * that case
> +       /* dst point to the start of hsr tag. So pass it to fill the
> +        * hsr info. Also skb_put_padto free skb on error and hsr_fill_tag
> +        * returns NULL in that case.
>           */
> -       return hsr_fill_tag(skb, frame, port, port->hsr->prot_version);
> +       return hsr_fill_tag(skb, (struct hsr_ethhdr *)(dst + movelen),
> +                           frame, port, port->hsr->prot_version);

It's a bit hard to see, since this is a draft patch on top of the
existing patch. But I think so.

Only, instead of dst + movelen, you can use src.

>   }
>
>
> > Also, supporting VLAN probably also requires supporting 802.1ad QinQ,
> > which means code should parse the headers instead of hardcoding
> > VLAN_HLEN.
> >
>
> iec-62439-3 standard only talks about VLAN (TPID 0x8100), not about
> QinQ. So what I could do is to check and bail out if 802.1ad frame is
> received at the interface from upper layer. Something like below and
> frame will get dropped.
>
> @@ -519,6 +507,8 @@ static int fill_frame_info(struct hsr_frame_info *frame,
>
>          if (proto == htons(ETH_P_8021Q))
>                  frame->is_vlan = true;
> +       else if (proto == htons(ETH_P_8021AD))
> +               return -1; /* Don't support 802.1ad */
>
>          if (frame->is_vlan) {
>                  vlan_hdr = (struct hsr_vlan_ethhdr *)ethhdr;
>
> What do you think?

It's good to err on the safe side. That should probably be a separate patch.
