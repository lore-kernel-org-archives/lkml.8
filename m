Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C23C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3506B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTHdDJnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgFQC1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:27:36 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527AC061573;
        Tue, 16 Jun 2020 19:27:35 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id u13so956262iol.10;
        Tue, 16 Jun 2020 19:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o+3+WHHJ8/T1Wxlro6VgUKACrLkQwhYAFXZ7kke0D9k=;
        b=LTHdDJnDrNomSfUbM5PjQjTr9FrUwPmPariJdqPW2HFl+1wAomframy4GqUiajueTS
         pmGBDsY6llA9/qL5AJSW/Oy5nPqNrBVt5BGlIll+tDOyI57H37kt921kx8hnm6on9OiQ
         dOuVNJDsBkLtNxm0msEyp1Xn9SWJcmWGajWSaH6o1lYcpg83sr5bAusUKkSjUSR52SZE
         PTSiXswF+GgMxxoRpHwaVda7kUC4HK0LS1aPxIZSvjhm902Av6i/EQXv5uX6O2B0F3Mf
         EjzMIaXSnzEdd9171v8M+rpFKnohT4loOpaqu3rpgohdZINXfQWPp7QGgb/Z13dD6ZEr
         Hrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o+3+WHHJ8/T1Wxlro6VgUKACrLkQwhYAFXZ7kke0D9k=;
        b=hOXthZnwPa022geIyjN2WB8nTXkJy7BM3xFLIBzSlZ96QMWXJ8/NQ5QbN/ercmWf7t
         MzbcFmflZuvd4bJbZKS4NAsJPI7B2rp1wnSQ3483MhakXOsc61Pq7sowpJSHlb3p5o63
         gYMfZ6Qm6BMUHxJDFKAqJHN5RaRwZNwuhfml/GvuKAFJVf+yuxPDm14LvHpFCb5qNgMS
         NDAiGrpTn4LtYy81xoYe3INq0jI9xr74UfsqzlJZ/5UMRahDiOhTV8R/+1zVf9fAST4O
         Z0z82BiEp9ATJHEJYFm5P4GZH3k4vKzZyo8dEXCjikAX65AbTIvryLbmvQYe+/XZif8e
         E+Cw==
X-Gm-Message-State: AOAM530MWyO/wAwdWsDtife9gLY1GgHGia6IYmMTs8lg7m2a0oLafzMi
        P7I/JSSHBxhcj8ZPlZ+vgfQkWRtlGlKRe/7fZEo=
X-Google-Smtp-Source: ABdhPJzW2JLOEdfm5n2+1udufWR25HquV0/vCG85pUOkXhf8DeOdEIXFVfOOsjnFIDwFMHJUrRvnDUaBoy0wBiQVTY0=
X-Received: by 2002:a05:6602:2e96:: with SMTP id m22mr5919832iow.165.1592360854942;
 Tue, 16 Jun 2020 19:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <1592310884-4307-1-git-send-email-macpaul.lin@mediatek.com> <20200616140246.GA30975@rowland.harvard.edu>
In-Reply-To: <20200616140246.GA30975@rowland.harvard.edu>
From:   Macpaul Lin <macpaul@gmail.com>
Date:   Wed, 17 Jun 2020 10:27:23 +0800
Message-ID: <CACCg+XNdnzsn4RH+1OWJXNY6mVA9a6tpaUec3=P53WkywcWfkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: introduce flag for large request
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> =E6=96=BC 2020=E5=B9=B46=E6=9C=8816=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=8810:05=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Jun 16, 2020 at 08:34:43PM +0800, Macpaul Lin wrote:
> > Some USB hardware like DMA engine can help to process (split) the data
> > of each URB request into small packets. For example, the max packet siz=
e
> > of high speed is 512 bytes. These kinds of hardware can help to split
> > the continue Tx/Rx data requests into packets just at the max packet
> > size during transmission. Hence upper layer software can reduce some
> > effort for queueing many requests back and forth for larger data.
> >
> > Here we introduce "can_exceed_maxp" flag in gadget when these kinds of
> > hardware is ready to support these operations.
>
> This isn't needed.  All UDC drivers must be able to support requests that
> are larger than the maxpacket size.
>
> Alan Stern

Thanks for your reply, could we just modify the patch 2 (u_serial.c)
for improving
better performance? I'm not sure why there was a restriction about max pack=
et.
Isn't there any historical reason?

--=20
Best regards,
Macpaul Lin
