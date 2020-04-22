Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A2C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0D42076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 14:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQM7awQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgDVOy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 10:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgDVOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 10:54:29 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08A8C03C1A9;
        Wed, 22 Apr 2020 07:54:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n6so2576659ljg.12;
        Wed, 22 Apr 2020 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j4IL19ri7V1Qm+D4j4fO28F9L9bRN2u0iPKVfin1/Rw=;
        b=MQM7awQI4I8Q7+FDbZ8+5oYMV4mYTyFU7tIcXKIItc38paWyJYiMvDYUQIfuHMuSMZ
         C/OIKvP4ooNyLGu/BAW/GOC8j57hJ1xor/l+npcNJz/+Zgj8fg2rB5/cPo0E5wi98hoi
         igU7eLXrmQJxTsmy2Q5RG5anHy6szn4ncvdM3rQEpKG8018kbnuc4zomlLvJvX6/i1dY
         /u0Osabm0g6LHVUvA8FDNKpqZBiuvQAWTnYMPwOQKBCHjOpSSQvSEzQrYI3fZk0j9av9
         xzo9K6psHNRmjE5gS+yDmqjl6yx/X28ogwckVpiFIwRUAKbcqwngQ1MG/6ilwvV0L6QR
         FIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j4IL19ri7V1Qm+D4j4fO28F9L9bRN2u0iPKVfin1/Rw=;
        b=NBsBoALAsdv8DgNyy5/k7ekLNBd7ak+L80I1WXbbl8Wl2zaAIhte+/XhmUsrOBAC7K
         d0q53PpgbP1z7SZv1y0g+TlMrdrowzDbXiN/pcb68Px+geZA3x1OhAmgZAB7WwMW7W4j
         w3p7cLq9+MozYXlM6dTRldTkJynDZXXfDCQtY2TLSSXZs1UzpPBKjaLT0uk3oczWl32o
         u25+AEryBHRlh+0D++d7R/LjDM2hVoyttYT2rcMw9NMBnCMimdlcZigRna71jWyBH8MU
         HcSXfrNavwUYbMb39hk9eX5qXyz0f3EUPk3phjrFqADrnScGqPOHn0S6dQJDbEp4OG8T
         b1oA==
X-Gm-Message-State: AGi0PuZf94GnQBXXtzb6QimMTbQeBP7syievs3JhtDS7NA6XTKtX5DY8
        S3Vbhwl/bwY9RbLzEQT5sx4=
X-Google-Smtp-Source: APiQypLSg8w8M7YXAsS/Bs4hQLKGrRg2Z7PqvsNZ0sH2NFAriwwxv6Ts0Q5ZnxnHB6XTkvqUIMokhQ==
X-Received: by 2002:a2e:7301:: with SMTP id o1mr10636181ljc.264.1587567267052;
        Wed, 22 Apr 2020 07:54:27 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id 4sm4302900ljf.79.2020.04.22.07.54.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 07:54:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [v2] arm64: dts: meson: odroid-n2: extend cpu opp-points
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <20200418214223.GA4484@imac>
Date:   Wed, 22 Apr 2020 18:54:21 +0400
Cc:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        joy.cho@hardkernel.com, tobetter@gmail.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <52230ECA-EA47-499D-B71C-FFCD374B75C3@gmail.com>
References: <20200418214223.GA4484@imac>
To:     Tim Lewis <elatllat@gmail.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 19 Apr 2020, at 1:42 am, Tim Lewis <elatllat@gmail.com> wrote:
>=20
> Odroid N2 has a large heatsink and HardKernel supports overclock
> through the addition to extra opp points in their official kernel
> sources [1]. Add these to the N2 dts only, as other S922X devices
> may not have suitable heatsinks.
>=20
> [1] =
https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6=
bd5a2ad2f
> Signed-off-by: Tim Lewis <elatllat@gmail.com>

Kodi is not a demanding workload, but the extra opp points are being =
used:

N2:~ # cat /sys/devices/system/cpu/cpufreq/policy0/stats/trans_table=20
   =46rom  :    To
         :    100000    250000    500000    667000   1000000   1200000   =
1398000   1512000   1608000   1704000   1896000   1992000=20
   100000:         0     20465       294        81        47         0   =
      1         0         0         0         0       183=20
   250000:     20388         0       161        52        59         0   =
      0         0         1         0         1       169=20
   500000:       199       256         0         9        47         1   =
      2         0         0         0         0        57=20
   667000:       177        50        10         0       284         1   =
      1         0         0         0         0       136=20
  1000000:       230        12        15       284         0         1   =
      2         0         0         0         0       285=20
  1200000:         0         0         0         1         0         0   =
      0         0         0         1         0         2=20
  1398000:         1         1         0         2         0         0   =
      0         0         1         1         0         3=20
  1512000:         0         0         0         0         0         0   =
      0         0         0         1         0         2=20
  1608000:         0         0         0         0         0         0   =
      0         1         0         0         0         2=20
  1704000:         0         1         0         0         0         0   =
      1         0         0         0         0         2=20
  1896000:         0         0         1         0         0         0   =
      0         0         0         0         0         1=20
  1992000:        76        47        90       230       392         0   =
      2         2         1         1         1         0=20

N2:~ # cat /sys/devices/system/cpu/cpufreq/policy2/stats/trans_table=20
   =46rom  :    To
         :    100000    250000    500000    667000   1000000   1200000   =
1398000   1512000   1608000   1704000   1800000   1908000=20
   100000:         0      1698       130        76        87         0   =
      0         0         1         0         1       199=20
   250000:      1655         0        25        15       357         1   =
      2         0         1         0         0        12=20
   500000:       258        54         0     50102        30         3   =
      1         0         0         0         1        32=20
   667000:       267       151     49708         0        77         3   =
      0         0         0         0         0        11=20
  1000000:         3         5       525        15         0         3   =
      2         0         1         1         0         6=20
  1200000:         0         2         1         2         2         0   =
      3         0         0         0         1         4=20
  1398000:         1         0         1         1         4         0   =
      0         1         1         0         2         2=20
  1512000:         0         0         0         0         0         0   =
      1         0         0         0         0         1=20
  1608000:         1         0         0         1         0         1   =
      0         0         0         0         0         3=20
  1704000:         0         0         0         0         0         1   =
      0         1         0         0         0         1=20
  1800000:         0         0         1         1         0         0   =
      1         0         1         0         0         1=20
  1908000:         8       158        90         4         3         3   =
      3         0         1         2         0         0=20

Board boots in under 4 seconds, Kodi home-screen in about 7 seconds. I =
haven=E2=80=99t seen the N2 rise over 44=C2=BAC.

I=E2=80=99ve also tested some S922X box devices (moving the change to =
meson-g12b-s922x.dtsi) and no obvious issues.

Tested-by: Christian Hewitt <christianshewitt@gmail.com>

> ---
> .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 19 +++++++++++++++++++
> 1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts =
b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> index 42f154057..6f32ac83f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
> @@ -260,6 +260,25 @@
> 			};
> 		};
> 	};
> +
> +	cpu_opp_table_0: opp-table-0 {
> +		opp-1992000000 {
> +			opp-hz =3D /bits/ 64 <1992000000>;
> +			opp-microvolt =3D <1001000>;
> +		};
> +	};
> +
> +	cpub_opp_table_1: opp-table-1 {
> +		opp-1800000000 {
> +			opp-hz =3D /bits/ 64 <1800000000>;
> +			opp-microvolt =3D <981000>;
> +		};
> +
> +		opp-1908000000 {
> +			opp-hz =3D /bits/ 64 <1908000000>;
> +			opp-microvolt =3D <1022000>;
> +		};
> +	};
> };
>=20
> &arb {
> --=20
> 2.17.1
>=20

