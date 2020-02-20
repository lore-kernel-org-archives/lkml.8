Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0304C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A2ED207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 11:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LnywNgr+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBTL4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 06:56:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727545AbgBTL4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 06:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582199802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VQuAY+FWx1o4FX7FYltHtE08eGBQmvdsb4/8EksyjCg=;
        b=LnywNgr+RrcWZI4dDARhkBEMj4mVSSAAeODsglwuUxfdta36NFZ/YtVGkmRgkrN2xgz5wN
        0sdywHqD5R66DrpJMtqAmxwmiFl5U3TsmgPuqrnDpPpR2EELrtPucph3SPzfpGCdbqOViF
        J4+x7qWvuyllgfQIyuow4vhShGhAxXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-r7ejy0VVPtOYaAoJPF6J1A-1; Thu, 20 Feb 2020 06:56:35 -0500
X-MC-Unique: r7ejy0VVPtOYaAoJPF6J1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 37C8F100550E;
        Thu, 20 Feb 2020 11:56:34 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 994AF5DA82;
        Thu, 20 Feb 2020 11:56:31 +0000 (UTC)
Date:   Thu, 20 Feb 2020 12:56:29 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 0/2] perf report: Support annotation of code without
 symbols
Message-ID: <20200220115629.GC565976@krava>
References: <20200220005902.8952-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200220005902.8952-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:59:00AM +0800, Jin Yao wrote:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
>=20
> We should support the annotation functionality even without symbols.
>=20
> The first patch uses al_addr to print because it's easy to dump
> the instructions from this address in binary for branch mode.
>=20
> The second patch supports the annotation on stripped binary.
>=20
> Jin Yao (2):
>   perf util: Print al_addr when symbol is not found
>   perf annotate: Support interactive annotation of code without symbols

looks good, but I'm getting crash when annotating unresolved kernel address:

jirka


Samples: 14  of event 'cycles:u', Event count (approx.): 1822321
Overhead  Command  Shared Object     Symbol
  26.86%  ls       libc-2.30.so      [.] __strcoll_l                       =
                                                                           =
                                                             =E2=96=92
  17.03%  ls       ls                [.] 0x0000000000008968                =
                                                                           =
                                                             =E2=96=92
  13.10%  ls       [unknown]         [k] 0xffffffff81c00ae7                =
                                                                           =
                                                             =E2=96=92
  13.02%  ls       ld-2.30.so        [.] _dl_cache_libcmp                  =
                                                                           =
                                                             =E2=96=92
  12.84%  ls       libc-2.30.so      [.] _int_malloc                       =
                                                                           =
                                                             =E2=96=92
  11.94%  ls       libc-2.30.so      [.] __memcpy_chk                      =
                                                                           =
                                                             =E2=96=92
   5.21%  ls       ld-2.30.so        [.] __GI___tunables_init              =
                                                                           =
                                                             =E2=96=92
                                                                           =
                                                                           =
                                                             =E2=96=92
                                                                           =
                                                                           =
                                                             Program receiv=
ed signal SIGSEGV, Segmentation fault.                                     =
                                                                           =
                                                =E2=96=92
                                                   add_annotate_opt (browse=
r=3D0xec34a0, act=3D0x7fffffffabf0, optstr=3D0x7fffffffab70, ms=3D0xdbdb60,=
 addr=3D18446744071591430887) at ui/browsers/hists.c:2500              =E2=
=96=92
2500            if (ms->map->dso->annotate_warned)                         =
                                                                           =
                                                             =E2=96=92
Missing separate debuginfos, use: dnf debuginfo-install brotli-1.0.7-6.fc31=
=2Ex86_64 bzip2-libs-1.0.8-1.fc31.x86_64 cyrus-sasl-lib-2.1.27-2.fc31.x86_6=
4 elfutils-debuginfod-client-0.178-7.fc31.x86_64 elfutils-libelf-0.178-7.fc=
31.x86_64 elfutils-libs-0.178-7.fc31.x86_64 glib2-2.62.5-1.fc31.x86_64 keyu=
tils-libs-1.6-3.fc31.x86_64 krb5-libs-1.17-46.fc31.x86_64 libbabeltrace-1.5=
=2E7-2.fc31.x86_64 libcap-2.26-6.fc31.x86_64 libcom_err-1.45.5-1.fc31.x86_6=
4 libcurl-7.66.0-1.fc31.x86_64 libgcc-9.2.1-1.fc31.x86_64 libidn2-2.3.0-1.f=
c31.x86_64 libnghttp2-1.40.0-1.fc31.x86_64 libpsl-0.21.0-2.fc31.x86_64 libs=
elinux-2.9-5.fc31.x86_64 libssh-0.9.3-1.fc31.x86_64 libunwind-1.3.1-5.fc31.=
x86_64 libuuid-2.34-4.fc31.x86_64 libxcrypt-4.4.14-1.fc31.x86_64 libzstd-1.=
4.4-1.fc31.x86_64 openldap-2.4.47-3.fc31.x86_64 openssl-libs-1.1.1d-2.fc31.=
x86_64 pcre-8.43-3.fc31.x86_64 pcre2-10.34-6.fc31.x86_64 perl-libs-5.30.1-4=
49.fc31.x86_64 popt-1.16-18.fc31.x86_64 python2-libs-2.7.17-1.fc31.x86_64 s=
lang-2.3.2-6.fc31.x86_64 xz-libs-5.2.4-6.fc31.x86_64 zlib-1.2.11-20.fc31.x8=
6_64         =E2=96=92
(gdb) bt                                                                   =
                                                                           =
                                                             =E2=96=92
#0  add_annotate_opt (browser=3D0xec34a0, act=3D0x7fffffffabf0, optstr=3D0x=
7fffffffab70, ms=3D0xdbdb60, addr=3D18446744071591430887) at ui/browsers/hi=
sts.c:2500                                                             =E2=
=96=92
#1  0x000000000061caf9 in perf_evsel__hists_browse (evsel=3D0xc58860, nr_ev=
ents=3D1, helpline=3D0xef69f0 "Tip: Show current config key-value pairs: pe=
rf config --list", left_exits=3Dfalse, hbt=3D0x0, min_pcnt=3D0,          =
=E2=96=92
    env=3D0xc5c7b0, warn_lost_event=3Dtrue, annotation_opts=3D0x7fffffffb51=
8) at ui/browsers/hists.c:3265                                             =
                                                                   =E2=96=92
#2  0x000000000061dbc2 in perf_evlist__tui_browse_hists (evlist=3D0xc55ed0,=
 help=3D0xef69f0 "Tip: Show current config key-value pairs: perf config --l=
ist", hbt=3D0x0, min_pcnt=3D0, env=3D0xc5c7b0, warn_lost_event=3Dtrue,   =
=E2=96=92
    annotation_opts=3D0x7fffffffb518) at ui/browsers/hists.c:3569          =
                                                                           =
                                                               =E2=96=92
#3  0x00000000004511e4 in report__browse_hists (rep=3D0x7fffffffb380) at bu=
iltin-report.c:630                                                         =
                                                               =E2=96=92
#4  0x00000000004521db in __cmd_report (rep=3D0x7fffffffb380) at builtin-re=
port.c:975                                                                 =
                                                               =E2=96=92
#5  0x000000000045444a in cmd_report (argc=3D0, argv=3D0x7fffffffd820) at b=
uiltin-report.c:1540                                                       =
                                                                 =E2=96=92
#6  0x00000000004e384a in run_builtin (p=3D0xa5b370 <commands+240>, argc=3D=
1, argv=3D0x7fffffffd820) at perf.c:312                                    =
                                                                   =E2=96=92
#7  0x00000000004e3ab7 in handle_internal_command (argc=3D1, argv=3D0x7ffff=
fffd820) at perf.c:364                                                     =
                                                                 =E2=96=92
#8  0x00000000004e3bfe in run_argv (argcp=3D0x7fffffffd67c, argv=3D0x7fffff=
ffd670) at perf.c:408                                                      =
                                                                 =E2=96=92
#9  0x00000000004e3fca in main (argc=3D1, argv=3D0x7fffffffd820) at perf.c:=
538                                                                        =
                                                                 =E2=96=92
(gdb)                                                                      =
                                                                           =
                                                             =E2=96=92




