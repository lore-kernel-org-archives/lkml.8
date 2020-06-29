Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF75C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43BF2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3C7JMKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732775AbgF2T3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgF2T2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:28:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1D3C061755;
        Mon, 29 Jun 2020 12:28:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f5so3647930ljj.10;
        Mon, 29 Jun 2020 12:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RBInpL/Za49/XjwUK8A/HWIZmWUwGYyRxdCJnIDd3Ig=;
        b=A3C7JMKeEB3sJoq3A6GeNMPUsRgZSUY3/rVmrmegxNpUcrjl6D8Z/ibLjrxtUVuxKS
         nKCOQh3RRYwaLrzSozk96EKdww8+fYCAPdwH8QJGWtFSqVjj8IqlAXWIuUetgdtyywKx
         qzGS+jLA9afBu8dOfYcfwCww2q+LpI5uIb/LdGn/27F4N0jaEetuIyJRJgXAYDdTblVS
         5XZvw+LkVbxktg8T1629GWo79XwHOgfbUh/ZY8OHlACaZ3P0ydhIaqfToNFUR+mq7qMM
         SmUpFmZO5zUjvYMafKFhvwNwR4miilhO63RuAgYds5e70IC7NWAbiV14XOP/RDvNTjmt
         g9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RBInpL/Za49/XjwUK8A/HWIZmWUwGYyRxdCJnIDd3Ig=;
        b=rvCUNbLfVbo9QYXbdPizkDcbW+7bPlJjdUHJLAbFHjh1oZpWmUjtukpe7vwd5zTgMB
         defk3uzDeKnbhBGsTkDFkJ4xpBozxaMil4EHoS3vFLJUcZ+XXTI+TvYoTxvU0Lr5dD34
         l44U489NkV3ElC7qJ7nuOo/q/Ie9qFWxsa76NxInY2p/Srpd3QWdqyByfEXAcvg06g9B
         +6jViRxe2aPAaERH3SgM/kZAyBH+KAf+bfDWg9BT4+zhZhJyazBMGdPWyDDvvHs9/MD9
         0+VTUioVkaP8qEfRqNiFJ8c1+CyboMj9mLIzXkEYQxTX7dgGKlHGTc29mX2dzcyEVSGP
         S5YA==
X-Gm-Message-State: AOAM532sNcrsZ0TG367EtSKdUKZOw9zRRnlizzYkevhcnOM7lrUfVhF5
        2doseLtJd4nNX8QbAndJkjPREUn5aOW7gjViYmw=
X-Google-Smtp-Source: ABdhPJzZJVxmTnAMNUQ40iw0js01vP110xyPx2ui71LxJnZcifaQu49DgbDPTsaYRsoVL+/z5PNnEpbP+zqyYZJFTCo=
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr9390835ljp.310.1593458923219;
 Mon, 29 Jun 2020 12:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200602183354.39707-1-zhouyanjie@wanyeetech.com>
 <20200602183354.39707-2-zhouyanjie@wanyeetech.com> <20200619110524.GA9391@alpha.franken.de>
In-Reply-To: <20200619110524.GA9391@alpha.franken.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jun 2020 16:28:31 -0300
Message-ID: <CAOMZO5CuxzMm+XFX6-mh55mcw5jgf5iYs-ej5NqjCsD6hSnr7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: MIPS: Document Ingenic SoCs binding.
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, linux-mips@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 9:48 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Jun 03, 2020 at 02:33:54AM +0800, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zh=
ou Yanjie) wrote:
> > Document the available properties for the SoC root node and the
> > CPU nodes of the devicetree for the Ingenic XBurst SoCs.
> >
> > Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> > Tested-by: Paul Boddie <paul@boddie.org.uk>
> > Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wa=
nyeetech.com>
> > ---
> >
> > Notes:
> >     v1->v2:
> >     1.Remove unnecessary "items".
> >     2.Add "clocks" as suggested by Paul Cercueil.
> >
> >  .../bindings/mips/ingenic/ingenic,cpu.yaml         | 67 ++++++++++++++=
++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mips/ingenic/inge=
nic,cpu.yaml
>
> applied to mips-next.

This causes 'make dt_binding_check' to fail:

$ make dt_binding_check
  CHKDT   Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml
Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.yaml:
while scanning a block scalar
  in "<unicode string>", line 42, column 5
found a tab character where an indentation space is expected
  in "<unicode string>", line 46, column 1
Documentation/devicetree/bindings/Makefile:20: recipe for target
'Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.example.dts'
failed
make[1]: *** [Documentation/devicetree/bindings/mips/ingenic/ingenic,cpu.ex=
ample.dts]
Error 1
Makefile:1343: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2
