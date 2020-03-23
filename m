Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ECA920781
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHQBjSaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgCWOhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:37:47 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48382 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgCWOhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584974265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzW9XZ2dG7NQbPkJRPiw3vOqw2mpj2opc/tY5HSMoKk=;
        b=HHQBjSaMJWRY8q3PeAhuF43SxvaJfrSQDFvfUO/wHLkb244qhX9wQQx9yexcJQXpvGiKRl
        A8Af3L2xmOchb36wOxscr5NJbBnBgW6M5bVsrCUvnPohEYuTZ3IctCeAaz/KJbi9MjitNV
        0tS0ZIN5eP5R8AEAioL7TN7Sl07HB0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-ZmUpf54qOTmWvCt8Xw0iAg-1; Mon, 23 Mar 2020 10:37:43 -0400
X-MC-Unique: ZmUpf54qOTmWvCt8Xw0iAg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12C17800D5A;
        Mon, 23 Mar 2020 14:37:42 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94AF967CF2;
        Mon, 23 Mar 2020 14:37:39 +0000 (UTC)
Date:   Mon, 23 Mar 2020 15:37:36 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 00/14] perf: Stream comparison
Message-ID: <20200323143736.GI1534489@krava>
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
 <20200323110514.GG1534489@krava>
 <ed2686f2-a370-4113-5148-e75c194b25bd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed2686f2-a370-4113-5148-e75c194b25bd@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 09:59:13PM +0800, Jin, Yao wrote:
> Hi Jiri,
>=20
> On 3/23/2020 7:05 PM, Jiri Olsa wrote:
> > On Fri, Mar 13, 2020 at 03:11:04PM +0800, Jin Yao wrote:
> > > Sometimes, a small change in a hot function reducing the cycles of
> > > this function, but the overall workload doesn't get faster. It is
> > > interesting where the cycles are moved to.
> >=20
> > I'm getting compilation fail:
> >=20
> > 	  BUILD:   Doing 'make -j1' parallel build
> > 	  CC       util/srclist.o
> > 	util/srclist.c: In function =E2=80=98srclist__node_new=E2=80=99:
> > 	util/srclist.c:388:35: error: =E2=80=98%s=E2=80=99 directive output =
may be truncated writing up to 4095 bytes into a region of size 4091 [-We=
rror=3Dformat-truncation=3D]
> > 	  388 |  snprintf(cmd, sizeof(cmd), "diff %s %s",
> > 	      |                                   ^~
> > 	......
> > 	  456 |  ret =3D init_src_info(b_path, a_path, rel_path, &node->info=
);
> > 	      |                      ~~~~~~
> > 	In file included from /usr/include/stdio.h:867,
> > 			 from util/srclist.c:8:
> > 	/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprint=
f_chk=E2=80=99 output between 7 and 8197 bytes into a destination of size=
 4096
> > 	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_L=
EVEL - 1,
> > 	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> > 	   68 |        __bos (__s), __fmt, __va_arg_pack ());
> > 	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 	cc1: all warnings being treated as errors
> > 	mv: cannot stat 'util/.srclist.o.tmp': No such file or directory
> > 	make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.bui=
ld:97: util/srclist.o] Error 1
> > 	make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.bui=
ld:139: util] Error 2
> > 	make[2]: *** [Makefile.perf:617: perf-in.o] Error 2
> > 	make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > 	make: *** [Makefile:70: all] Error 2
> >=20
> >=20
> > [jolsa@krava ~]$ gcc --version
> > gcc (GCC) 9.3.1 20200317 (Red Hat 9.3.1-1)
> >=20
> > jirka
> >=20
>=20
> Can you help to add following patch on top of the patch-set? Looks we n=
eed
> to check the return value of snprintf for truncation checking.

yep, that helped.. I'll apply it on top for now
and try to do the review soon ;-)

thanks,
jirka

>=20
> jinyao@kbl:~/kbl-ws/perf-dev/lck-7589/acme/tools/perf$ git diff
> diff --git a/tools/perf/util/srclist.c b/tools/perf/util/srclist.c
> index 8060e4855d11..51ca69eaa9fd 100644
> --- a/tools/perf/util/srclist.c
> +++ b/tools/perf/util/srclist.c
> @@ -385,8 +385,12 @@ static int src_info__create_line_mapping(struct
> src_info *info, char *b_path,
>                 goto out;
>         }
>=20
> -       snprintf(cmd, sizeof(cmd), "diff %s %s",
> -                b_path, a_path);
> +       ret =3D snprintf(cmd, PATH_MAX, "diff %s %s",
> +                      b_path, a_path);
> +       if (ret =3D=3D PATH_MAX) {
> +               ret =3D -1;
> +               goto out;
> +       }
>=20
>         pr_debug("Execute '%s'\n", cmd);
>=20
> Thanks
> Jin Yao
>=20

