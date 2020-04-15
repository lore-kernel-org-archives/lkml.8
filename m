Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9238AC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1C7208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="F6cQpa1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416335AbgDOQzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:55:05 -0400
Received: from forward104p.mail.yandex.net ([77.88.28.107]:58809 "EHLO
        forward104p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2410578AbgDOQy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:54:56 -0400
X-Greylist: delayed 467 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Apr 2020 12:54:53 EDT
Received: from mxback25o.mail.yandex.net (mxback25o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::76])
        by forward104p.mail.yandex.net (Yandex) with ESMTP id 222C94B00595;
        Wed, 15 Apr 2020 19:47:04 +0300 (MSK)
Received: from myt4-ee976ce519ac.qloud-c.yandex.net (myt4-ee976ce519ac.qloud-c.yandex.net [2a02:6b8:c00:1da4:0:640:ee97:6ce5])
        by mxback25o.mail.yandex.net (mxback/Yandex) with ESMTP id rPLI4hiMtm-l3a49ZBR;
        Wed, 15 Apr 2020 19:47:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1586969224;
        bh=pV1WydyKA+XCWko5RRCDyTFmRt0Y3b8ovuRq4rF/XCY=;
        h=In-Reply-To:Subject:To:From:Cc:References:Date:Message-ID;
        b=F6cQpa1Oth5oeBz3unOr51yrR0dk4njRhZgQqv6MFhy3sIssiSNSFTG15Tm4FpP7m
         uzmg3hPvCBIua9AK5xNmDOFe03RhS77ySVD21ReofIyvCLV7gsw2ec8LLcqx+8tnpe
         Wn0tE0U25JJgsfk8FPfRl3zfvexZXvT+cz22t3sA=
Authentication-Results: mxback25o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt4-ee976ce519ac.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id UBsARPRcxV-l32KeXOk;
        Wed, 15 Apr 2020 19:47:03 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf stat: Honour --timeout for forked workloads
Date:   Wed, 15 Apr 2020 19:46:57 +0300
Message-ID: <2996611.mvXUDI8C0e@constantine-n61ja>
In-Reply-To: <20200415153803.GB20324@kernel.org>
References: <20200415153803.GB20324@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Konstantin Kharlamov <hi-angel@yandex.ru>

On =D1=81=D1=80=D0=B5=D0=B4=D0=B0, 15 =D0=B0=D0=BF=D1=80=D0=B5=D0=BB=D1=8F =
2020 =D0=B3. 18:38:03 MSK Arnaldo Carvalho de Melo wrote:
> Hi guys,
>=20
> 	Please take a look and give this your acks, Tested-by, etc.
>=20
> Thanks,
>=20
> - Arnaldo
>=20
> ----
>=20
> When --timeout is used and a workload is specified to be started by
> 'perf stat', i.e.
>=20
>   $ perf stat --timeout 1000 sleep 1h
>=20
> The --timeout wasn't being honoured, i.e. the workload, 'sleep 1h' in
> the above example, should be terminated after 1000ms, but it wasn't,
> 'perf stat' was waiting for it to finish.
>=20
> Fix it by sending a SIGTERM when the timeout expires.
>=20
> Now it works:
>=20
>   # perf stat -e cycles --timeout 1234 sleep 1h
>   sleep: Terminated
>=20
>    Performance counter stats for 'sleep 1h':
>=20
>            1,066,692      cycles
>=20
>          1.234314838 seconds time elapsed
>=20
>          0.000750000 seconds user
>          0.000000000 seconds sys
>=20
>   #
>=20
> Reported-by: Konstantin Kharlamov <hi-angel@yandex.ru>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=3D207243
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-stat.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index ec053dc1e35c..9207b6c45475 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -686,8 +686,11 @@ static int __run_perf_stat(int argc, const char **ar=
gv,
> int run_idx) break;
>  			}
>  		}
> -		if (child_pid !=3D -1)
> +		if (child_pid !=3D -1) {
> +			if (timeout)
> +				kill(child_pid, SIGTERM);
>  			wait4(child_pid, &status, 0,=20
&stat_config.ru_data);
> +		}
>=20
>  		if (workload_exec_errno) {
>  			const char *emsg =3D=20
str_error_r(workload_exec_errno, msg, sizeof(msg));


=2D-=20
=D0=98=D0=BD=D0=B6=D0=B5=D0=BD=D0=B5=D1=80-=D1=80=D0=B0=D0=B7=D1=80=D0=B0=
=D0=B1=D0=BE=D1=82=D1=87=D0=B8=D0=BA =D0=9A=D0=BE=D0=BD=D1=81=D1=82=D0=B0=
=D0=BD=D1=82=D0=B8=D0=BD =D0=A5=D0=B0=D1=80=D0=BB=D0=B0=D0=BC=D0=BE=D0=B2


