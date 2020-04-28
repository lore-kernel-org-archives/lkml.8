Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2915CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0479D206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftbhbo46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgD1OvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727878AbgD1OvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:51:06 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316FFC03C1AB;
        Tue, 28 Apr 2020 07:51:06 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b12so23092687ion.8;
        Tue, 28 Apr 2020 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GgeqmdEmb09cwWnZURvh19BHVHs9QFAo9j/uyja5xe8=;
        b=ftbhbo46DIoclP20MgqTJq6QQRg5IIitlwWEB+J2uWIkW1NTCjW5+JN0e+g2WLF9vX
         EKTRwC5obL6iWDl+wsizqv27kDrSnFwS5opGl2Zcq/MAtIokvA2YFVb/2/tWigKsAib0
         uOLaSE6BjfNoo30LntGvtNE2THRjybP1x/+YqnPP2BlCbHmTKKEBQzl/FzpdYc0xsuyD
         IFf76F2YqZH5MyVkpyeq5vO1yglnBvM0Qo75HG5bdTFhecuJIxKxzuiPOzs5nIBDXZs4
         fNpAWwOZwDSEjEVCu5IZKwpebijosF2ybxlz7kyBJ12/OlwYf9qgogeqZMxcghVtFbM+
         rlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GgeqmdEmb09cwWnZURvh19BHVHs9QFAo9j/uyja5xe8=;
        b=bTqFpyoiPtffcMw88C4BXE+eBW+ylqIcYwwNcvXoc60Xn6XYBmUjKxXcxC2cpR8tMw
         b80XLKReEX7EDfrRr2mX/DZFzSBmmjYmZ1LYld+SyuDGPYaI9VN7UTCaDsSO1OT91AQM
         BTLUQ/5lB+TzU6zcJ5N52d4ny1kBNvi8zKwGdjwRRFVViDJJw7JrXduiwqnkZgJ8MpnV
         DL05KkHW38p/iCpr7s9DRvGF2CamYv3LRvd3NKWc2EwULbm9y536SWFD6WS9E7HRHaZE
         A1eXjGrefgP1N2tY8G9fG4uRUxEH8wvcq+biWBzPEUZg0ALFIIIv6mT/vTuJyztnxL6N
         mlXw==
X-Gm-Message-State: AGi0PuYsMxrskcv+3hUDTufFGgl3mqN/vrytRO9VNTHAakCo1kYllZU8
        nDdIIhHOzpBVXkfsq77Fcdd44CD4Ab/V2hDmsFM=
X-Google-Smtp-Source: APiQypKTD+S1WqOLrfRlXdxvtseawzRWMNX6kR8updafIakHcwBAhBmXxHQROLhLlZ95M3jOMARBiMD5WpWSOUrqEXQ=
X-Received: by 2002:a5d:9494:: with SMTP id v20mr26401979ioj.101.1588085465427;
 Tue, 28 Apr 2020 07:51:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200426161605.52121-1-samuel@sholland.org>
In-Reply-To: <20200426161605.52121-1-samuel@sholland.org>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Tue, 28 Apr 2020 16:50:54 +0200
Message-ID: <CAJiuCcdgDd=xrGU6iDjo=Og+OW=4cbrLG_NWZpzRZXdjJbnRXQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v2] arm64: dts: allwinner: a64: Remove
 unused SPDIF sound card
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 26 Apr 2020 at 18:12, Samuel Holland <samuel@sholland.org> wrote:
>
> As of v5.7-rc2, Linux now prints the following message at boot:
>
>   [   33.848525] platform sound_spdif: deferred probe pending
>
> This is because sound_spdif is waiting on its CPU DAI &spdif to probe,
> but &spdif is disabled in the device tree.
>
> Exposure of the SPDIF pin is board-specific functionality, so the sound
> card and codec DAI belong in the individual board DTS, not the SoC DTSI.
> In fact, no in-tree A64 board DTS enables &spdif, so let's remove the
> card and DAI entirely.

CC: Marcus Cooper <codekipper@gmail.com>

Without any value :
Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>

Regards,
Clement

>
> This reverts commit 78e071370a86473f25923e03b51cbbadacf8be0f.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>
> Changes since v1:
>  - Remove the node instead of disabling it
>  - Also remove the codec DAI
>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 18 ------------------
>  1 file changed, 18 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index 31143fe64d91..c26cc1fcaffd 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -154,24 +154,6 @@ link_codec: simple-audio-card,codec {
>                 };
>         };
>
> -       sound_spdif {
> -               compatible =3D "simple-audio-card";
> -               simple-audio-card,name =3D "On-board SPDIF";
> -
> -               simple-audio-card,cpu {
> -                       sound-dai =3D <&spdif>;
> -               };
> -
> -               simple-audio-card,codec {
> -                       sound-dai =3D <&spdif_out>;
> -               };
> -       };
> -
> -       spdif_out: spdif-out {
> -               #sound-dai-cells =3D <0>;
> -               compatible =3D "linux,spdif-dit";
> -       };
> -
>         timer {
>                 compatible =3D "arm,armv8-timer";
>                 allwinner,erratum-unknown1;
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msg=
id/linux-sunxi/20200426161605.52121-1-samuel%40sholland.org.
