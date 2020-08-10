Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FB9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0472073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J526to2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHJHcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJHcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:32:22 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:32:22 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id p8so3729570vsm.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJo6TZcaNoJonrq3wQzaYlOn0q7KCaKbS7KLCKU2QzA=;
        b=J526to2DvxuRZ8736kFIZtIMrd+wGpUCmG9v/rejtCm6ZNbh/i5xF906ohsgmAiJ78
         FPeEcYbsYrJ3+Qiyi7vfxUQIT0YTtEeGabjI+phjc6DvfO3d/No2a/62W+3KjbK9N1yE
         C8EIRoSvnU2dzVpWyvin8SRVuszcz2foFihxhvFK6OQYA/F+eJS2pfM1+0cTYy/Z4bn3
         SKofNlcHWdAd0oGfiCt5GOYGUbIDXX+ZVEcHaE/xSSqEV02cBBNtLQs86tNIL+zkUeut
         lIqtPEQSc3Ru8im6pH2QAvwoxYV0EO8jBYG12kwkquzTCdgHQqKnVDF9bVWjNAizum9R
         S8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJo6TZcaNoJonrq3wQzaYlOn0q7KCaKbS7KLCKU2QzA=;
        b=gPb7rg/iEehFGun3jIYm+sYPTVFSWCcmZ1gz9IKJ7ovcwlVCz4Cq/Ag4Wne9t9S+B+
         mt93llGm8Vomu/BxLcWEtgIsCiUJ5tuzyIdx38Di0JjkL4iDbqFGOcEjZtat/fpr/3T1
         RRyi4Sxx+5TVHp8ug/ByNPPGTqg+3N65iRzhoIODUR0rQfFfeZtJWn+cGRS1FQjkTpjS
         G9FEJ2tYhjvji9Tzwwex3IdWB8Om1b+ZUUdcT0mS3289huExQ/5Nvnw4IzkzHWY7l5qA
         cXX+J4+r6ZdTRbXQnKevf1PShDArkrUJqYGKylvoDj/TxP4zBrLfKafL+zXkVTquvxmm
         r+qA==
X-Gm-Message-State: AOAM533cyf/ZSC9MxQVMr/M9N9cE6GND59/MbChBhlzGbK91ayrjw6ed
        xY/ElEaKyli/dw4hZX+vgSripLOcRBY=
X-Google-Smtp-Source: ABdhPJyudg9TxYUfje49+AvVzgPw1QiCaAYSaBC7et8jVAtK4qHpzucU/nEPIgBK0boLNucLjPiD9g==
X-Received: by 2002:a67:7905:: with SMTP id u5mr18155146vsc.179.1597044741562;
        Mon, 10 Aug 2020 00:32:21 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id d204sm1420569vkf.37.2020.08.10.00.32.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 00:32:20 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id g11so2189468ual.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:32:20 -0700 (PDT)
X-Received: by 2002:a9f:2648:: with SMTP id 66mr13443939uag.37.1597044739732;
 Mon, 10 Aug 2020 00:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
 <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com> <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
In-Reply-To: <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 10 Aug 2020 09:31:43 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com>
Message-ID: <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 7:12 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Sun, Aug 9, 2020 at 1:48 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Does this solve an actual observed bug?
> >
> > In many ways lapbeth is similar to tunnel devices. This is not common.
>
> Thank you for your comment!
>
> This doesn't solve a bug observed by me. But I think this should be
> necessary considering the logic of the code.
>
> Using "grep", I found that there were indeed Ethernet drivers that set
> needed_tailroom. I found it was set in these files:
>     drivers/net/ethernet/sun/sunvnet.c
>     drivers/net/ethernet/sun/ldmvsw.c
> Setting needed_tailroom may be necessary for this driver to run those
> Ethernet devices.

What happens when a tunnel device passes a packet to these devices?
That will also not have allocated the extra tailroom. Does that cause
a bug?
