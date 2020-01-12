Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552B1C33CA2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B4021556
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 19:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdIJ8A0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbgALT0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:26:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733146AbgALT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 14:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578857190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPO99Iiuvk75wbMXNt4MOtmHwxYcF0jpPSaSl6xOMMs=;
        b=cdIJ8A0LZCto4C7CVHHm2bhOo7M/KPWoGIZcrAY9DeuESistP9mBvcmc94Ei3yRMjB9Aqu
        uXKVMrTS6JWRWEfMNBiNlK5BYKii4zA1Gc7rPT4IVsIYW+fr5L3Elprqmb+3GLuS92udYB
        VbCaHxm7ELtzbE0PTA5djwEOn/ReR7o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-V_FL090kNFu7dVIR1xesQw-1; Sun, 12 Jan 2020 14:26:26 -0500
X-MC-Unique: V_FL090kNFu7dVIR1xesQw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC5ED10054E3;
        Sun, 12 Jan 2020 19:26:24 +0000 (UTC)
Received: from krava (ovpn-204-50.brq.redhat.com [10.40.204.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B6547E681;
        Sun, 12 Jan 2020 19:26:21 +0000 (UTC)
Date:   Sun, 12 Jan 2020 20:22:59 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH] perf tools: Use %define api.pure full instead of %pure-parser
Message-ID: <20200112192259.GA35080@krava>
References: <20191205193224.24629-1-acme@kernel.org>
 <20191206075701.GA25384@gmail.com>
 <20191206142516.GA31721@krava>
 <20191206144354.GD30698@kernel.org>
 <20191206150455.GC31721@krava>
 <20191206153509.GB13965@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191206153509.GB13965@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 12:35:09PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Dec 06, 2019 at 04:04:55PM +0100, Jiri Olsa escreveu:
> > On Fri, Dec 06, 2019 at 11:43:54AM -0300, Arnaldo Carvalho de Melo wr=
ote:
> > > Em Fri, Dec 06, 2019 at 03:25:16PM +0100, Jiri Olsa escreveu:
> > > > On Fri, Dec 06, 2019 at 08:57:01AM +0100, Ingo Molnar wrote:
> > > >=20
> > > > SNIP
> > > >=20
> > > > > >  tools/include/uapi/drm/drm.h      |   3 +-
> > > > > >  tools/include/uapi/drm/i915_drm.h | 128 ++++++++++++++++++++=
+++++++++++++++++-
> > > > > >  tools/perf/builtin-inject.c       |  13 +---
> > > > > >  tools/perf/builtin-report.c       |   8 +++
> > > > > >  tools/perf/util/sort.c            |  16 +++--
> > > > > >  5 files changed, 147 insertions(+), 21 deletions(-)
> > > > >=20
> > > > > Pulled, thanks a lot Arnaldo!
> > > > >=20
> > > > > JFYI, on my system the default perf/urgent build still has this=
 noise=20
> > > > > generated by util/parse-events.y and util/expr.y:
> > > > >=20
> > > > >   util/parse-events.y:1.1-12: warning: deprecated directive, us=
e =E2=80=98%define api.pure=E2=80=99 [-Wdeprecated]
> > > > >       1 | %pure-parser
> > > > >       | ^~~~~~~~~~~~
> > > > >   util/parse-events.y: warning: fix-its can be applied.  Rerun =
with option '--update'. [-Wother]
> > > > >   util/expr.y:15.1-12: warning: deprecated directive, use =E2=80=
=98%define api.pure=E2=80=99 [-Wdeprecated]
> > > > >      15 | %pure-parser
> > > > >       | ^~~~~~~~~~~~
> > > > >   util/expr.y: warning: fix-its can be applied.  Rerun with opt=
ion '--update'. [-Wother]
> > > >=20
> > > > just saw it in fedora 31 with new bison, change below
> > > > should fix it, I'll post it with other fixes later
> > >=20
> > > As I explained to Ingo, this will make it fail with older systems, =
for
> > > now this is just a warning, thus I've not been eager to get this me=
rged,
> > > Andi alredy submitted this, for instance.
> > >=20
> > > Is there some way to have some sort of ifdef based on bison's versi=
on so
> > > that we can have both?
> >=20
> > I see, I guess we could use one or another based on
> > bison version with macro
>=20
> If you could do that, that would be great, the attempt may well
> enlighten us if that is possible and if not, then, oh well, I can just
> update bison on these older systems and keep a note in my container
> definition files :-)

hi,
so I checked and the api.pure define was introduced quite
long time ago, so perhaps we could change it as it is..
could you please run your distro check on the patch below?

thanks,
jirka


---
Bison deprecated %pure-parser directive in favor of
%define api.pure full. The api.pure got introduced
in bison 2.3 (Oct 2007), so it seems safe to use it
without any version check.

Link: https://lkml.kernel.org/n/tip-qhrf915k2ynym32vf5ii8vzy@git.kernel.o=
rg
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/expr.y         | 3 ++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index f9a20a39b64a..7d226241f1d7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -12,7 +12,8 @@
 #define MAXIDLEN 256
 %}
=20
-%pure-parser
+%define api.pure full
+
 %parse-param { double *final_val }
 %parse-param { struct parse_ctx *ctx }
 %parse-param { const char **pp }
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
index e2eea4e601b4..94f8bcd83582 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -1,4 +1,4 @@
-%pure-parser
+%define api.pure full
 %parse-param {void *_parse_state}
 %parse-param {void *scanner}
 %lex-param {void* scanner}
--=20
2.24.1

