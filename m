Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A38C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC3920730
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 06:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iwH0JI7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgDIGEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:04:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39346 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgDIGEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 02:04:37 -0400
Received: by mail-il1-f196.google.com with SMTP id r5so9161386ilq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 23:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U0k2Xztg7j9SvQNMVkx71cxXQ6AFkKJ2SAjXAl+0SNI=;
        b=iwH0JI7iD6GVpaav0sLt57UZsJUsWbjl8vAtI16qx9IfbT5hpfC9Q/m3Z58vYlN3H9
         bIrELcVGbZoqw9UdiwqsRYQGBHTLiFtAz0Y4o8n1zlUe/B12WZbb3W3VakafXfD3XyCB
         a1qVjM3f9Dm9vIgn6dhIpLoUO1u7oiYA+wquQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U0k2Xztg7j9SvQNMVkx71cxXQ6AFkKJ2SAjXAl+0SNI=;
        b=uUWhnBi7vwVQu42zBW9Mbtz0Q4OMBwbEPESSjTZkvxavpe0nBD5FNz4acE7uxiGVGZ
         eQvIQ2ielmh7Bf9+NeXi2wLgFUL9LiAi75YTRosvcwcM04ccPuWn4DFTPur7l7CV4AOV
         qXQe+UxMjK6UtzjeLpVpEksnTHBRNGUAVmCoF+8pKV8r9bcGBbPXrhtToY7gn52kvdpn
         gG8L+x7mQLEBOLtC0Fbwxalym43nibSUyljvRMj3i26kKyglKATY4R0IwhqqpI9iby+T
         Pzn9v+6c7osl0PI0Sr+L8l5dafSu+7tiJ3MeeaDoHumNtDWV6JcruSrok+0rt1Mp/rn1
         vNLQ==
X-Gm-Message-State: AGi0PubZHa8u5TJyHPyEIwRjrLUvvTxs40Ls7uFb47a+LsxWaP6nOY96
        N2VyJsXZCeahas6OIVaKZRISYgfI+Bangcgdj/noZQ==
X-Google-Smtp-Source: APiQypKsq4Dq9SLFz7Ua4KMnDBywchOcH84tfaonrDZ/Ffl3NFOaaK4qj/XhAmQiYl67GiykhWkxoDEVzS/bOgUAZQY=
X-Received: by 2002:a05:6e02:6cd:: with SMTP id p13mr11240229ils.150.1586412275898;
 Wed, 08 Apr 2020 23:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191118104252.228406-1-hsinyi@chromium.org> <CAFqH_528vidMhTFxNZ=b7SFD2K12UwtdX3uTUzW4YUgeDWkg5A@mail.gmail.com>
 <CAAOTY_8RMboOuKVKPANZ1QN+mt0jvOr13o84VhWKGY1QZqbPDg@mail.gmail.com> <e22e0400-56e0-2ff4-72d8-5231b7fa58fc@collabora.com>
In-Reply-To: <e22e0400-56e0-2ff4-72d8-5231b7fa58fc@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 9 Apr 2020 14:04:09 +0800
Message-ID: <CAJMQK-iQvkQDnhL-LqCz57+3_GqU3EM5m=S2vGsOZuyGeXM74w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8173: Add gce setting in mmsys and display node
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 12:47 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Chun-Kuang
>
> Many thanks to let us know this, I completely missed.
>
> On 8/4/20 18:09, Chun-Kuang Hu wrote:
> > Hi, Hsin-Yi:
> >
> > Enric Balletbo Serra <eballetbo@gmail.com> =E6=96=BC 2020=E5=B9=B44=E6=
=9C=888=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8811:48=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >>
> >> Missatge de Hsin-Yi Wang <hsinyi@chromium.org> del dia dl., 18 de nov.
> >> 2019 a les 11:43:
> >>>
> >>> In order to use GCE function, we need add some informations
> >>> into display node (mboxes, mediatek,gce-client-reg, mediatek,gce-even=
ts).
> >>>
> >>> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> >>
> >> With the fix provided by Hsin-Yi [1] and after the mmsys patches
> >> landed I get GCE function working on mt8173, so
> >>
> >> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>
> >> [1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromi=
um.org/
> >>
> >> Thanks,
> >>  Enric
> >>
> >>> ---
> >>> - This is based on series "support gce on mt8183 platform"
> >>>   https://patchwork.kernel.org/cover/11208309/
> >>> - gce setting in 8183:
> >>>   https://patchwork.kernel.org/patch/11127105/
> >>> ---
> >>>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 16 ++++++++++++++++
> >>>  1 file changed, 16 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/bo=
ot/dts/mediatek/mt8173.dtsi
> >>> index 15f1842f6df3..e84ec3f95d81 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> >>> @@ -911,6 +911,11 @@ mmsys: clock-controller@14000000 {
> >>>                         assigned-clocks =3D <&topckgen CLK_TOP_MM_SEL=
>;
> >>>                         assigned-clock-rates =3D <400000000>;
> >>>                         #clock-cells =3D <1>;
> >>> +                       mboxes =3D <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> >>> +                                <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> >
> > Because of patch [1], atomic_exec parameter should be removed.
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/?h=3Dnext-20200408&id=3D19d8e335d58a961a7ed377e5e2e63664b92c0b9c
> >
>
> Many thanks to point this. Hsin-Yi, as the mt8173 device-tree will not la=
nd in
> current merge window (Matthias correct me if I am  wrong) maybe you could=
 send a
> new version of the device-tree including these changes?
>
>
> >>> +                       mediatek,gce-client-reg =3D <&gce SUBSYS_1400=
XXXX 0 0x1000>;
> >>> +                       mediatek,gce-events =3D <CMDQ_EVENT_MUTEX0_ST=
REAM_EOF>,
> >>> +                                             <CMDQ_EVENT_MUTEX1_STRE=
AM_EOF>;
> >
> > Because of patch [2], these events should be moved to mutex node.
> >
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
commit/?h=3Dv5.6&id=3D60fa8c13ab1a33b8b958efb1510ec2fd8a064bcc
> >
>
> Hsin-Yi, note this will also impact your fixes patch [1].
>
> [1] https://lore.kernel.org/lkml/20200406051131.225748-1-hsinyi@chromium.=
org/
>
> Thanks,
>  Enric
>
> > Regards,
> > Chun-Kuang.
> >
Thanks for pointing this out.

v2: https://lore.kernel.org/lkml/20200409055012.199320-1-hsinyi@chromium.or=
g/
