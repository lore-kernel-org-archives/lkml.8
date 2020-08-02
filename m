Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7ABC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732E22070A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 23:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596412039;
	bh=H6xs6d3dgK+96AhAZfXFX14NGYOEMH4Vnh+W+8vKrRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xQkYq0TDRp+hOFzoRHcgZcBl7XgnMI4z/N8BJrSz6leuwTI7Qei6s10t1Yo+DXbDo
	 waqhapQKkUUsHnNEbsRIvRJddqDP1d2Kx0Z2gq1129Gem77z26z5C5fnT46T1cV1VO
	 h4AR8rBnTIdN/T+RMS/dbrdVSleTNI9Bhb+BIKZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHBXrR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 19:47:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726797AbgHBXrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 19:47:17 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A5542070A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596412035;
        bh=H6xs6d3dgK+96AhAZfXFX14NGYOEMH4Vnh+W+8vKrRM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CbX1Vq0dV9eP9b/mhUJB9UQPhoIxMhukuHjRemSl0NuMpm97ysyVwo9ADqqW9timx
         9mocM9uwc9Z/Qvc+ARM2EPlv38tMZ04smxjp8dTNb6MZZP2tFDX9J9zPUS/qjka6hJ
         1yKMsVdRm70L325t4/RXujKW+5NECg7lJWKq/MyU=
Received: by mail-ej1-f46.google.com with SMTP id bo3so14163762ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 16:47:15 -0700 (PDT)
X-Gm-Message-State: AOAM5328nSxBgigEaWCyXwgY/Ruv87Z69EvtgiGoLI/aNFuFZEuGVrk8
        j7Fm53T+stpE/Op20IbYm9+aO1hYT70cQGdgmg==
X-Google-Smtp-Source: ABdhPJyL2FRZjVaVXf05r+Yl7rsuKM/lyGziOQXjYfTFU+c3+d5hQt1lqNUv6jMUYMcrdqrwKRXBJ0KXCVGRZuVao9A=
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr663711ejk.94.1596412034498;
 Sun, 02 Aug 2020 16:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-2-frank-w@public-files.de> <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
 <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
In-Reply-To: <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 3 Aug 2020 07:47:01 +0800
X-Gmail-Original-Message-ID: <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com>
Message-ID: <CAAOTY__TsqrfRX-z+DE0+X_UzxBqChJ+VdyQG6z9N6Qr4bn2Kg@mail.gmail.com>
Subject: Re: Re: [PATCH v2 1/5] drm/mediatek: config component output by
 device node port
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

Frank Wunderlich <frank-w@public-files.de> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=882=E6=97=A5 =E9=80=B1=E6=97=A5 =E4=B8=8B=E5=8D=884:06=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> > Gesendet: Sonntag, 02. August 2020 um 02:03 Uhr
> > Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
> > An: "Frank Wunderlich" <frank-w@public-files.de>
> > Cc: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel=
@pengutronix.de>, "David Airlie" <airlied@linux.ie>, "linux-kernel" <linux-=
kernel@vger.kernel.org>, "DRI Development" <dri-devel@lists.freedesktop.org=
>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradea=
d.org>, "Daniel Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.bgg=
@gmail.com>, "Bibby Hsieh" <bibby.hsieh@mediatek.com>, "Linux ARM" <linux-a=
rm-kernel@lists.infradead.org>
> > Betreff: Re: [PATCH v2 1/5] drm/mediatek: config component output by de=
vice node port
> > > +
> > > +               if (comp_type !=3D MTK_DSI && comp_type !=3D MTK_DPI)=
 {
> > > +                       port =3D of_graph_get_port_by_id(node, 0);
> > > +                       if (!port)
> > > +                               continue;
> > > +                       ep =3D of_get_child_by_name(port, "endpoint")=
;
> > > +                       of_node_put(port);
> > > +                       if (!ep)
> > > +                               continue;
> > > +                       remote =3D of_graph_get_remote_port_parent(ep=
);
> > > +                       of_node_put(ep);
> > > +                       if (!remote)
> > > +                               continue;
> > > +                       of_id =3D of_match_node(mtk_ddp_comp_dt_ids, =
remote);
> > > +                       if (!of_id)
> > > +                               continue;
> > > +                       comp_type =3D (enum mtk_ddp_comp_type)of_id->=
data;
> > > +                       for (i =3D 0; i < private->data->main_len - 1=
; i++)
> > > +                               if (private->data->main_path[i] =3D=
=3D comp_id)
> > > +                                       private->data->main_path[i + =
1] =3D
> > > +                                       mtk_ddp_comp_get_id(node, com=
p_type);
> > > +                       for (i =3D 0; i < private->data->ext_len - 1;=
 i++)
> > > +                               if (private->data->ext_path[i] =3D=3D=
 comp_id)
> > > +                                       private->data->ext_path[i + 1=
] =3D
> > > +                                       mtk_ddp_comp_get_id(node, com=
p_type);
> > > +               }
> >
> > The port property is not defined in binding document [1], so define it
> > in binding document first.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt?h=
=3Dv5.8-rc7
>
> hi,
> would be the following enough for describing the ports?
>
> Port binding
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> some nodes like
>
> - connector (e.g. hdmi-connector)
> - bls (mediatek,mt7623-disp-pwm)
> - hdmix (mediatek,mt7623-hdmi)

Now I just care about the bls to dpi. So in mediatek,disp.txt, you
just need to add a Optional properties - port (input and output), and
modify mediatek,dpi.txt for its input port.

Regards,
Chun-Kuang.

>
> can have port bindings to connect each other. Each port can have only 1 e=
ndpoint
>
> more detail about ports/endpoints in ../../media/video-interfaces.txt
> hdmi-connector is described here: ../connector/hdmi-connector.txt
>
> example:
>
> connector {
>         compatible =3D "hdmi-connector";
>
>         port {
>                 hdmi_connector_in: endpoint {
>                         remote-endpoint =3D <&hdmi0_out>;
>                 };
>         };
> };
>
>
> &bls {
>         status =3D "okay";
>
>         port {
>                 bls_out: endpoint {
>                         remote-endpoint =3D <&dpi0_in>;
>                 };
>         };
> };
>
> &dpi0 {
>         status =3D "okay";
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 port@0 {
>                         reg =3D <0>;
>                         dpi0_out: endpoint {
>                                 remote-endpoint =3D <&hdmi0_in>;
>                         };
>                 };
>
>                 port@1 {
>                         reg =3D <1>;
>                         dpi0_in: endpoint {
>                                 remote-endpoint =3D <&bls_out>;
>                         };
>                 };
>         };
> };
>
> &hdmi0 {
>
>         ports {
>                 #address-cells =3D <1>;
>                 #size-cells =3D <0>;
>                 port@0 {
>                         reg =3D <0>;
>                         hdmi0_in: endpoint {
>                                 remote-endpoint =3D <&dpi0_out>;
>                         };
>                 };
>
>                 port@1 {
>                         reg =3D <1>;
>                         hdmi0_out: endpoint {
>                                 remote-endpoint =3D <&hdmi_connector_in>;
>                         };
>                 };
>         };
> };
>
> regards Frank
