Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D492DC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72AC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q81ARYit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgCWLF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 07:05:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40949 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727987AbgCWLF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 07:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584961525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=00MKPbXZ63cfOilQO8B9I2vlOri+Kk2uF23onL/zrT4=;
        b=Q81ARYitEhExoJZrAJuvIYYP09AUG2QEMm8j6e3OGpPDUvVIRVjelMvP3xKmZzBevGxK8f
        Smc+HspILiPbdSwo4vAW6Nv0q+jHGdkbqepqzObwocA4Rko/qrU9N0ej1ARPPkZNLJQwsY
        PJkqEdpnaPMJJZigXdygq1xN2FN0TnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-lAwfkKudMR29QrahG7uVmA-1; Mon, 23 Mar 2020 07:05:21 -0400
X-MC-Unique: lAwfkKudMR29QrahG7uVmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC61F1137840;
        Mon, 23 Mar 2020 11:05:19 +0000 (UTC)
Received: from krava (unknown [10.40.192.119])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B845119C70;
        Mon, 23 Mar 2020 11:05:17 +0000 (UTC)
Date:   Mon, 23 Mar 2020 12:05:14 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 00/14] perf: Stream comparison
Message-ID: <20200323110514.GG1534489@krava>
References: <20200313071118.11983-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200313071118.11983-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 03:11:04PM +0800, Jin Yao wrote:
> Sometimes, a small change in a hot function reducing the cycles of
> this function, but the overall workload doesn't get faster. It is
> interesting where the cycles are moved to.

I'm getting compilation fail:

	  BUILD:   Doing 'make -j1' parallel build
	  CC       util/srclist.o
	util/srclist.c: In function =E2=80=98srclist__node_new=E2=80=99:
	util/srclist.c:388:35: error: =E2=80=98%s=E2=80=99 directive output may =
be truncated writing up to 4095 bytes into a region of size 4091 [-Werror=
=3Dformat-truncation=3D]
	  388 |  snprintf(cmd, sizeof(cmd), "diff %s %s",
	      |                                   ^~
	......
	  456 |  ret =3D init_src_info(b_path, a_path, rel_path, &node->info);
	      |                      ~~~~~~       =20
	In file included from /usr/include/stdio.h:867,
			 from util/srclist.c:8:
	/usr/include/bits/stdio2.h:67:10: note: =E2=80=98__builtin___snprintf_ch=
k=E2=80=99 output between 7 and 8197 bytes into a destination of size 409=
6
	   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL=
 - 1,
	      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
	   68 |        __bos (__s), __fmt, __va_arg_pack ());
	      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	cc1: all warnings being treated as errors
	mv: cannot stat 'util/.srclist.o.tmp': No such file or directory
	make[4]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:9=
7: util/srclist.o] Error 1
	make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.build:1=
39: util] Error 2
	make[2]: *** [Makefile.perf:617: perf-in.o] Error 2
	make[1]: *** [Makefile.perf:225: sub-make] Error 2
	make: *** [Makefile:70: all] Error 2


[jolsa@krava ~]$ gcc --version
gcc (GCC) 9.3.1 20200317 (Red Hat 9.3.1-1)

jirka

