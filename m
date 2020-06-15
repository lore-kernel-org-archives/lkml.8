Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C129EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D8A720644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592230676;
	bh=4TQGXLtys+5X0Ku9Pe7MEGS5M04KpaAdQGgX7vU0o9w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oOUTUuYPZJF7z0FbjZNN5UFxIczPgFFdlfn+Odd0YMHPls3irK3DbymLR+RNT/oxJ
	 /M6lQU/DKFX6F/rfg6zmF3fn0WP72H8+3DnlgphWhicvcjFiG+dY3vWXPgF1URoq3J
	 LEqKZ3+5cPvtdJBBLBJxdDaMZRR6kRDifqH1E6r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgFOORz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:17:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730042AbgFOORy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:17:54 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DD820644;
        Mon, 15 Jun 2020 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592230673;
        bh=4TQGXLtys+5X0Ku9Pe7MEGS5M04KpaAdQGgX7vU0o9w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vs9r/A2PulQeRjfyJ+v8PHSeItHMR8YRrxshLkIP36o9ou+UYPU48A92+IGpC6VZ5
         VZBfWvyz43dQPxf13yNqLQeArDToOGK33IbCXy7XTFQ/Gl+oDh1GJs3sYfy66tz+RA
         t9Wnv+3AVYOZRueuLSX5O1kRYx7kqybHKUmcEBBI=
Received: by mail-ej1-f44.google.com with SMTP id f7so17636037ejq.6;
        Mon, 15 Jun 2020 07:17:52 -0700 (PDT)
X-Gm-Message-State: AOAM533WXqOIfk0nADBahiptEG6M5gtaT+P61gvjegL12mQrOMd0I3CQ
        Ffq7AvnDZkLQYQjL7hG7ixBO++f48X5BnyiWvg==
X-Google-Smtp-Source: ABdhPJxRAfv0OJUQhybnFlT40bnLF1BhCRKzsXp8nGIZGN4IzFwU+PtUVZl/NtqCZVpeCGaY1vI5Vbf8DXpi5JiGDH4=
X-Received: by 2002:a17:906:468e:: with SMTP id a14mr25689164ejr.124.1592230671616;
 Mon, 15 Jun 2020 07:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <1591698261-22639-1-git-send-email-neal.liu@mediatek.com>
 <1591698261-22639-3-git-send-email-neal.liu@mediatek.com> <CAAOTY_8W7FLrjKbNt+WHXjsBzgn_E7n5stKjv94RBnF7ktVuiA@mail.gmail.com>
 <1592188994.18525.11.camel@mtkswgap22> <CAAOTY_8EFYoAtuAugkYuG=F6kkbu3yeBnyoKBGTnHzPJKHQ5EQ@mail.gmail.com>
In-Reply-To: <CAAOTY_8EFYoAtuAugkYuG=F6kkbu3yeBnyoKBGTnHzPJKHQ5EQ@mail.gmail.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 15 Jun 2020 22:17:40 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8booP95diFN=C-ybTBciqsw=B7Zq4dCS8=VOjgyUTu1A@mail.gmail.com>
Message-ID: <CAAOTY_8booP95diFN=C-ybTBciqsw=B7Zq4dCS8=VOjgyUTu1A@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: add devapc-mt6873 driver
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B46=E6=9C=8815=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi, Neal:
>
> Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8810:43=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >
> > Hi Chun-Kuang,
> >
> >
> > On Sun, 2020-06-14 at 11:26 +0800, Chun-Kuang Hu wrote:
> > > Hi, Neal:
> > >
> > > Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B46=E6=9C=889=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=886:25=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > MT6873 bus frabric provides TrustZone security support and data
> > > > protection to prevent slaves from being accessed by unexpected
> > > > masters.
> > > > The security violations are logged and sent to the processor for
> > > > further analysis or countermeasures.
> > > >
> > > > Any occurrence of security violation would raise an interrupt, and
> > > > it will be handled by devapc-mt6873 driver. The violation
> > > > information is printed in order to find the murderer.
> > > >
> > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > > ---
> > >
> > > [snip]
> > >
> > > > +
> > > > +       /* 50 */
> > > > +       {-1, -1, 50, "OOB_way_en", true},
> > > > +       {-1, -1, 51, "OOB_way_en", true},
> > > > +       {-1, -1, 52, "OOB_way_en", true},
> > > > +       {-1, -1, 53, "OOB_way_en", true},
> > > > +       {-1, -1, 54, "OOB_way_en", true},
> > > > +       {-1, -1, 55, "OOB_way_en", true},
> > > > +       {-1, -1, 56, "Decode_error", true},
> > > > +       {-1, -1, 57, "Decode_error", true},
> > > > +       {-1, -1, 58, "DISP_PWM", false},
> > > > +       {-1, -1, 59, "IMP_IIC_WRAP", false},
> > > > +
> > > > +       /* 60 */
> > > > +       {-1, -1, 60, "DEVICE_APC_PERI_PAR__AO", false},
> > > > +       {-1, -1, 61, "DEVICE_APC_PERI_PAR_PDN", false},
> > >
> > > You does not process the item whose enable_vio_irq is false, so I
> > > think you should remove these items and remove enable_vio_irq because
> > > the rest item's enable_vio_irq would always be true.
> >
> > In some users, they can decide which slaves they want to enable or
> > disable violation irq in different product. We remain this property for
> > compatibility.
>
> I think in upstream version, you could still remove enable_vio_irq and
> process all items. For downstream case, users could remove items they
> does not interest in.
>
> >
> > >
> > > > +};
> > > > +
> > > > +static struct mtk_device_num mtk6873_devices_num[] =3D {
> > > > +       {SLAVE_TYPE_INFRA, VIO_SLAVE_NUM_INFRA},
> > > > +       {SLAVE_TYPE_PERI, VIO_SLAVE_NUM_PERI},
> > > > +       {SLAVE_TYPE_PERI2, VIO_SLAVE_NUM_PERI2},
> > > > +       {SLAVE_TYPE_PERI_PAR, VIO_SLAVE_NUM_PERI_PAR},
> > > > +};
> > > > +
> > > > +static struct PERIAXI_ID_INFO peri_mi_id_to_master[] =3D {
> > > > +       {"THERM2",       { 0, 0, 0 } },
> > > > +       {"SPM",          { 0, 1, 0 } },
> > > > +       {"CCU",          { 0, 0, 1 } },
> > > > +       {"THERM",        { 0, 1, 1 } },
> > > > +       {"SPM_DRAMC",    { 1, 1, 0 } },
> > >
> > > The bits { 1, 1, 0 } equal to a number 0x3, I thiink you should use a
> > > number instead of bits and everything would be more easy.
> >
> > We would like to keep it because the bit value contains more than 0/1,
> > it might be '2' in some cases. '2' means it can be 0 or 1. This totally
> > by hardware design & implementation.
>
> Upstream the patch that has dont-care-bits, otherwise, use a number for t=
his.
> Even there is dont-care-bits, I have a better way to process it. Here
> is an example that has dont-care-bits:
>
> + {"Tinysys",         { 0, 1, 0, 0, 2, 2, 2, 2, 2, 2, 0, 0, 0, 0 } },
>
> I could use a { value, mask } pair for this case,
>
> value =3D 0x0002; /* value for care bits */
> mask =3D 0x3c02; /* mask for care bits */

Sorry, this would be

mask =3D 0x3c0f; /* mask for care bits */

>
> So the compare statement would be
>
> if ((bus_id & mask) =3D=3D value)
>
> So you could get rid of the second for-loop and reduce the processing
> time in irq handler.
>
> Regards,
> Chun-Kuang.
