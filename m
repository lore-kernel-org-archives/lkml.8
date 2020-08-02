Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49DEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C312075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 08:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aeaoKctD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBIGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 04:06:20 -0400
Received: from mout.gmx.net ([212.227.15.15]:43787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHBIGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 04:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1596355539;
        bh=sc1Lq8EFToHTdK5q+UaOStFQfDdgf714wGLLqZKqwoY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aeaoKctDVpeUHPAmtcFrKdeq51XDI04xweIWl2F16QHXj9PmHwY7ImtuqtLcQ404L
         ZoNSNQG3KA50dtvgCtU3Sh8dACc3/CYmOvLgNAIR7un4M5zeHT9eH4XV3eW4tfT8pq
         WFguTteyX8Q+x4g2QdmmWWHKRpLq8IBxeg0j0CPs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [217.61.148.8] ([217.61.148.8]) by web-mail.gmx.net
 (3c-app-gmx-bs58.server.lan [172.19.170.142]) (via HTTP); Sun, 2 Aug 2020
 10:05:39 +0200
MIME-Version: 1.0
Message-ID: <trinity-2bdb3521-256a-4d4d-928a-be9b8c179d4c-1596355539029@3c-app-gmx-bs58>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
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
Subject: Aw: Re: [PATCH v2 1/5] drm/mediatek: config component output by
 device node port
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 2 Aug 2020 10:05:39 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
References: <20200728111800.77641-1-frank-w@public-files.de>
 <20200728111800.77641-2-frank-w@public-files.de>
 <CAAOTY_8nm0KDHFzOX9+qTTHOUd0Vik063J+rScu_y-hTBTkrCQ@mail.gmail.com>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:4FFi9HpCe8lkGtx3qVv8hooKf3hnYGPUlAK5sb6D1cx9f6AKs2Zij3fJVX8u1Kn3vQNVq
 ghyk4N2d0ZnEQ1NBl8Lfkgj5ykKuJZKEOM8PbRHm6zEs1Uir8L3aD8gL7eR7RNmMSZemBSbCpXq9
 u3EFJ4ekTCJo6getq8QxyK/kTZVWz4gM05LhHUOTvEbpq/7bwjk2dCpa0ROeR5Lwdww/Uy7/n1Af
 K1q4PEkOEZregQweoK9VKFwmdH1ziDxUfRSxr6A0VKOv3Qqwt7P78lG5lH1DNZ9xCt8W3qrspwOq
 wY=
X-UI-Out-Filterresults: notjunk:1;V03:K0:EVjTvshynRM=:oj6gH32Ie0JMk3jwUU7SjQ
 L9uQMqjJ5k3YEPDEMXJ6rAjz0+sMxc6rVyEAHpHI1BvB4nFrXBvkvBbchQUq5t7mAFxIgdg08
 ddelQW0Vr16/2ejszizw8Rq4iNbq0jyPXkhgobAtzpXyUn7mpsq58LWHaIKklHI333JX+MLiG
 EQh/VS9Pi6WyoS7/yP9Hw/NGisyRiBwn0pNUf2cx/ok4WFwhUXjcDHxsUq5HUnvEqKZmsIaIE
 VZa5IZBI6DIodDEPHSn9+ov/XZ/VVIO5h49CQTGMh38HIU9xbwNWOyeGAH6UgmjJx5Iww6hah
 awZfuWpOtcon+pq+ByqGNjgQxbwfUliM0boJGG9ODSBLfz8ik146F2K6kEfXMoXmUHAmvzabo
 1qshB/tGhETBWT+fG/c6HaVevZQ7RGHsZ7BjcejSu+LD8tBllAfDz8Hh2cQQJ4mviEWAh8h7J
 Br+88lsiRUgf0imkfW07or2Dov+yJS3D5ewypGtvxHfUqPOSBtuOdJZyMen0goNF6Dc9WbLqn
 acd6E4eSrWANevczDyij3ZOXsdnhit+400o/KqjRiFN39XlWTRbsMAdBPytmY4UDCEhKyQEKq
 csFR+nzSGWIUIcDzGgWP764XbAh4TLQQsxFETrfoCX8GqlMm9dFCpxTfZl8Ha6USHfYwxxnpw
 zONgSdrYR1KLIUqM4NdBfgV4rSLUlTJE0TWLSoPN4zTfAALibdJbrPmFslogGHrLMLOE=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Gesendet: Sonntag, 02. August 2020 um 02:03 Uhr
> Von: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>
> An: "Frank Wunderlich" <frank-w@public-files.de>
> Cc: "Chun-Kuang Hu" <chunkuang.hu@kernel.org>, "Philipp Zabel" <p.zabel@=
pengutronix.de>, "David Airlie" <airlied@linux.ie>, "linux-kernel" <linux-=
kernel@vger.kernel.org>, "DRI Development" <dri-devel@lists.freedesktop.or=
g>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infrad=
ead.org>, "Daniel Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.=
bgg@gmail.com>, "Bibby Hsieh" <bibby.hsieh@mediatek.com>, "Linux ARM" <lin=
ux-arm-kernel@lists.infradead.org>
> Betreff: Re: [PATCH v2 1/5] drm/mediatek: config component output by dev=
ice node port
> > +
> > +               if (comp_type !=3D MTK_DSI && comp_type !=3D MTK_DPI) =
{
> > +                       port =3D of_graph_get_port_by_id(node, 0);
> > +                       if (!port)
> > +                               continue;
> > +                       ep =3D of_get_child_by_name(port, "endpoint");
> > +                       of_node_put(port);
> > +                       if (!ep)
> > +                               continue;
> > +                       remote =3D of_graph_get_remote_port_parent(ep)=
;
> > +                       of_node_put(ep);
> > +                       if (!remote)
> > +                               continue;
> > +                       of_id =3D of_match_node(mtk_ddp_comp_dt_ids, r=
emote);
> > +                       if (!of_id)
> > +                               continue;
> > +                       comp_type =3D (enum mtk_ddp_comp_type)of_id->d=
ata;
> > +                       for (i =3D 0; i < private->data->main_len - 1;=
 i++)
> > +                               if (private->data->main_path[i] =3D=3D=
 comp_id)
> > +                                       private->data->main_path[i + 1=
] =3D
> > +                                       mtk_ddp_comp_get_id(node, comp=
_type);
> > +                       for (i =3D 0; i < private->data->ext_len - 1; =
i++)
> > +                               if (private->data->ext_path[i] =3D=3D =
comp_id)
> > +                                       private->data->ext_path[i + 1]=
 =3D
> > +                                       mtk_ddp_comp_get_id(node, comp=
_type);
> > +               }
>
> The port property is not defined in binding document [1], so define it
> in binding document first.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt?h=
=3Dv5.8-rc7

hi,
would be the following enough for describing the ports?

Port binding
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

some nodes like

- connector (e.g. hdmi-connector)
- bls (mediatek,mt7623-disp-pwm)
- hdmix (mediatek,mt7623-hdmi)

can have port bindings to connect each other. Each port can have only 1 en=
dpoint

more detail about ports/endpoints in ../../media/video-interfaces.txt
hdmi-connector is described here: ../connector/hdmi-connector.txt

example:

connector {
	compatible =3D "hdmi-connector";

	port {
		hdmi_connector_in: endpoint {
			remote-endpoint =3D <&hdmi0_out>;
		};
	};
};


&bls {
	status =3D "okay";

	port {
		bls_out: endpoint {
			remote-endpoint =3D <&dpi0_in>;
		};
	};
};

&dpi0 {
	status =3D "okay";

	ports {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		port@0 {
			reg =3D <0>;
			dpi0_out: endpoint {
				remote-endpoint =3D <&hdmi0_in>;
			};
		};

		port@1 {
			reg =3D <1>;
			dpi0_in: endpoint {
				remote-endpoint =3D <&bls_out>;
			};
		};
	};
};

&hdmi0 {

	ports {
		#address-cells =3D <1>;
		#size-cells =3D <0>;
		port@0 {
			reg =3D <0>;
			hdmi0_in: endpoint {
				remote-endpoint =3D <&dpi0_out>;
			};
		};

		port@1 {
			reg =3D <1>;
			hdmi0_out: endpoint {
				remote-endpoint =3D <&hdmi_connector_in>;
			};
		};
	};
};

regards Frank
