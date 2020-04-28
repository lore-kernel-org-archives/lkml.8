Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D796C83009
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6957A20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVPckYKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgD1QXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgD1QXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:23:47 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA5C03C1AB;
        Tue, 28 Apr 2020 09:23:47 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id k6so23626268iob.3;
        Tue, 28 Apr 2020 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j6RRU0nrN7yUPwoTU3WwW56lws6VJ5/MsTtHloArhl0=;
        b=AVPckYKwTeUisgWMXpahkhhvCC0B7KCgpPE6LKFrZcDSoFrpV7e9aReBGpKH/Fomx2
         PLRSSFlRLBDnumFZpkYSJNBW/iSoL66EK4Cbx/t/yziGMfC8r3ByxTf0S3KvMExFrzSx
         vdKXUJHTDxbvPYE1oBg8rw9hS6mGMi8XDuL8qFWYlM2vEI7CqPGHgRHRobFo2FQk1dPC
         ywpr8WEhqy7y5oD97LeDunmNnuC9DvGi+ZiQ5xnJtgP+8OaMiRBlE+O83DUh4XBKkvU1
         ZQaT87Awc6BKGbQNEB4qwY81/wY/6KsXMMrB1lAh/Y3Ms521kx9LE+r7lyl1+LUz1DMF
         pu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j6RRU0nrN7yUPwoTU3WwW56lws6VJ5/MsTtHloArhl0=;
        b=RTsdgq3rGOnNjRbZAzJ2OzLOhlPE4Gkf0W+db0SLPaanL/rr90h14Gpqx89bEQEmPq
         fvvobLua2Qo5xqpl4MFtOim5iA1NzqTpAVTDyVgfWQ7D/0QDOA7fmkvDiepdGaAGkCtU
         iNWcHSqDbR436KOC36SilEYJBfX3nF6+23yrPcu4uuzaFpd3ODtn2dlyNxXRjtzbJlC/
         HyxjcpQkE/vwWAfBZSGmtviczyvGpq+FkwFeWPc4737tcd0SEoE4LM3eq6MthxQ5hdhX
         3Gva893lxQNdLFOl/ydxf871QxZYWvomiwqTHEznFPAIm9fRR1zYzczPFmwlBOrhKFYu
         x+aQ==
X-Gm-Message-State: AGi0PuZBSKR3x96yHvXBAcI20G/jFT23v2j6s4xUOCs9Tr6acB/JUYP3
        m2lQHna0mE5vzAaWyCSEhrp5oZG0NoRk/kYogGk=
X-Google-Smtp-Source: APiQypJOl6MpBa2BRYe8Hr+y09c1rJYJoKiTY9WejKqf4GN+4FJ4o0seuR6Q1T+jNayBJixEcXKBGhrTo0lIBL1OtX0=
X-Received: by 2002:a02:a004:: with SMTP id a4mr25699613jah.18.1588091027057;
 Tue, 28 Apr 2020 09:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200428142629.8950-1-peron.clem@gmail.com> <98246e5d-ebef-bcb5-f0b8-d74b3834b835@arm.com>
In-Reply-To: <98246e5d-ebef-bcb5-f0b8-d74b3834b835@arm.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 18:23:35 +0200
Message-ID: <CAJiuCcco0d_UoWeHqh6oc0rFNAMFynXjLRQ6APsT0WBh7m+GQg@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2] arm64: dts: allwinner: h6: Use dummy
 regulator for Tanix TX6
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Piotr Oniszczuk <warpme@o2.pl>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Tue, 28 Apr 2020 at 17:21, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2020-04-28 3:26 pm, Cl=C3=A9ment P=C3=A9ron wrote:
> > Tanix TX6 has a fixed regulator. As DVFS is instructed to change
> > voltage to meet OPP table, the DVFS is not working as expected.
>
> Hmm, isn't that really a bug in the DVFS code? I guess it's just blindly
> propagating -EINVAL from the fixed regulators not implementing
> set_voltage, but AFAICS it has no real excuse not to be cleverer and
> still allow switching frequency as long as the voltage *is* high enough
> for the given OPP. I wonder how well it works if the regulator is
> programmable but shared with other consumers... that case probably can't
> be hacked around in DT.

Like you, I thought that the DVFS was clever enough to understand this
but guess not..

Maybe they are some cases where you don't want to leave the voltage high an=
d
reduce the frequency. But I don't know such case.

Regards,
Clement




>
> Robin.
>
> > Avoid to introduce a new dedicated OPP Table where voltage are
> > equals to the fixed regulator as it will only duplicate all the OPPs.
> > Instead remove the fixed regulator so the DVFS framework will create
> > dummy regulator and will have the same behavior.
> >
> > Add some comments to explain this in the device-tree.
> >
> > Reported-by: Piotr Oniszczuk <warpme@o2.pl>
> > Fixes: add1e27fb703 ("arm64: dts: allwinner: h6: Enable CPU opp tables =
for Tanix TX6")
> > Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > ---
> >   .../boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 18 ++++++++++++++++-=
-
> >   1 file changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/ar=
ch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > index be81330db14f..3e96fcb317ea 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
> > @@ -48,7 +48,15 @@
> >   };
> >
> >   &cpu0 {
> > -     cpu-supply =3D <&reg_vdd_cpu_gpu>;
> > +     /*
> > +      * Don't specify the CPU regulator, as it's a fixed
> > +      * regulator DVFS will not work as it is intructed
> > +      * to reach a voltage which can't be reached.
> > +      * Not specifying a regulator will create a dummy
> > +      * regulator allowing all OPPs.
> > +      *
> > +      * cpu-supply =3D <&reg_vdd_cpu_gpu>;
> > +      */
> >   };
> >
> >   &de {
> > @@ -68,7 +76,13 @@
> >   };
> >
> >   &gpu {
> > -     mali-supply =3D <&reg_vdd_cpu_gpu>;
> > +     /*
> > +      * Don't specify the GPU regulator, see comment
> > +      * above for the CPU supply.
> > +      *
> > +      * mali-supply =3D <&reg_vdd_cpu_gpu>;
> > +      */
> > +
> >       status =3D "okay";
> >   };
> >
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/98246e5d-ebef-bcb5-f0b8-d74b3834b835%40arm.com.
