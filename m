Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD4AC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5263F2080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asMCyCbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgIHSvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgIHSvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:51:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6ADC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 11:51:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e14so9574717vsa.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zOlhJ759ELcXKOOqGfeV77lWnqUEXIcww3cWbaCaKkc=;
        b=asMCyCblUJ33Hh1IyVh0VZu7tMxhHYb406jcoN65/Ckc5Cy3HmZxaGc0l3YM2bM6ZS
         7vuWk/QUhenCg2yMvFRCoESv3ihcogVS4LwbQZeaUpckhZQmDueM/rWLsXoGdHU4bDTH
         bQfqdBpWSrdeiCNhpGCiHj/vNPk/xDZ4QGTXiRLdR618sMBpoS7HEFfmgqZmGsMLDK48
         S8Hb29RJnLYz1jUUekIIgDiQufX1Gqo3nz73aWI7EkBdhySBUP17SoGbxQdhX1PNhtyH
         137QcCqMVVx92Ej8bRIugQs6Bv5StdTuPOajKPLbZNwHIfFyh9386HCNfNYLOCtUenIA
         L2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOlhJ759ELcXKOOqGfeV77lWnqUEXIcww3cWbaCaKkc=;
        b=LfLqZ329HeeHuEikxAu1MgYIlGe21rN82Z7DSDI0FdNE5HJGfi2oGkxOXSupvkTw45
         jedPE0lb9y/od4CFeK5wQzBJMsuPc9avW4SWakT6sbT6e+DadzhN3El2yb2cmNikxLC4
         pcxZb0hSdJrFLGtrunHUG0tZPGvzANDwL4etaRBbswO6IN6JQGNobPTnH4/bcYRyHzIL
         34CRlayvWAedPTcjahhBuba5DQEvisAZCF44gYRKHGLEPnXBSOs0fPL1XrLab0RD15Py
         c/C0mQC54jrN6aqkM4/67S9ncNYEUJYzLsDc1rtjB1SFUMlF8sH0IQ1qunoHxm2WJiUf
         H29A==
X-Gm-Message-State: AOAM531xS5816QctRyjSuy3PZHqO85u83urM58iWlmxSjwA0urpVnyG9
        Fi4lggvKXHgzIC9vDqrfEocWokYLoPfqeA==
X-Google-Smtp-Source: ABdhPJw98GBSMOkYPltUs3srQGr5Eumbm4ddvK+9PfDnfNephM6uYqG+zAlHSbQLUG/Gj7fnEHvfaw==
X-Received: by 2002:a67:7fd6:: with SMTP id a205mr402989vsd.8.1599591066880;
        Tue, 08 Sep 2020 11:51:06 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id 67sm7767vkr.24.2020.09.08.11.51.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 11:51:05 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id g16so68703uan.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 11:51:05 -0700 (PDT)
X-Received: by 2002:ab0:24cd:: with SMTP id k13mr348997uan.92.1599591064900;
 Tue, 08 Sep 2020 11:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200901195415.4840-1-m-karicheri2@ti.com> <d93fbc54-1721-ebec-39ca-dc8b45e6e534@ti.com>
 <15bbf7d2-627b-1d52-f130-5bae7b7889de@ti.com> <CA+FuTSeri93irC9eaQqrFrY2++d0zJ4-F0YAfCXfX6XVVqU6Pw@mail.gmail.com>
 <bf8a22c2-0ebe-7a52-2e79-7dde72d444ba@ti.com> <CA+FuTSeE_O_XozfnzDED_S4of-NwtRCN+oWr=O3JPpByfCz3Vg@mail.gmail.com>
In-Reply-To: <CA+FuTSeE_O_XozfnzDED_S4of-NwtRCN+oWr=O3JPpByfCz3Vg@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 8 Sep 2020 20:50:26 +0200
X-Gmail-Original-Message-ID: <CA+FuTSde4fAiy6t-Q4o1C8wdU4ZYqNt0Qd2F8PsrnXvA8q03=A@mail.gmail.com>
Message-ID: <CA+FuTSde4fAiy6t-Q4o1C8wdU4ZYqNt0Qd2F8PsrnXvA8q03=A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/1] Support for VLAN interface over HSR/PRP
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

> > >>>
> > >>> Shouldn't it show vlan_do_receive() ?
> > >>>
> > >>>       if (skb_vlan_tag_present(skb)) {
> > >>>           if (pt_prev) {
> > >>>               ret = deliver_skb(skb, pt_prev, orig_dev);
> > >>>               pt_prev = NULL;
> > >>>           }
> > >>>           if (vlan_do_receive(&skb))
> > >>>               goto another_round;
> > >>>           else if (unlikely(!skb))
> > >>>               goto out;
> > >>>       }
> > >>>
> > >>> Thanks
> > >>>
> > >>
> > >> I did an ftrace today and I find vlan_do_receive() is called for the
> > >> incoming frames before passing SKB to hsr_handle_frame(). If someone
> > >> can review this, it will help. Thanks.
> > >>
> > >> https://pastebin.ubuntu.com/p/CbRzXjwjR5/
> > >
> > > hsr_handle_frame is an rx_handler called after
> > > __netif_receive_skb_core called vlan_do_receive and jumped back to
> > > another_round.
> >
> > Yes. hsr_handle_frame() is a rx_handler() after the above code that
> > does vlan_do_receive(). The ftrace shows vlan_do_receive() is called
> > followed by call to hsr_handle_frame(). From ifconfig I can see both
> > hsr and vlan interface stats increments by same count. So I assume,
> > vlan_do_receive() is called initially and it removes the tag, update
> > stats and then return true and go for another round. Do you think that
> > is the case?
>
> That was my understanding.
>
> > vlan_do_receive() calls vlan_find_dev(skb->dev, vlan_proto, vlan_id)
> > to retrieve the real netdevice (real device). However VLAN device is
> > attached to hsr device (real device), but SKB will have HSR slave
> > Ethernet netdevice (in our case it is cpsw device) and vlan_find_dev()
> > would have failed since there is no vlan_info in cpsw netdev struct. So
> > below code  in vlan_do_receive() should have failed and return false.
> >
> >         vlan_dev = vlan_find_dev(skb->dev, vlan_proto, vlan_id);
> >         if (!vlan_dev)
> >                 return false;
> >
> > So how does it goes for another_round ? May be vlan_find_dev is
> > finding the hsr netdevice?
>
> It's good to answer this through code inspection and/or
> instrumentation. I do not have the answer immediately either.

Agreed that from reading the code I would vlan_do_receive to not find
a vlan dev associated with the physical nic, then passes the packet
unmodified to hsr_handle_frame.

Perhaps this seems to work because skb_vlan_untag has already
pulled the tag out of the packet?

But then you should not see counters increased on the vlan dev.
