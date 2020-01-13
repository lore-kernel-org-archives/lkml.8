Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6316AC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37440207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+cqgFwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgAMJZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:25:51 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:36378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgAMJZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578907549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ScBIHsaA7KENiy9TdRBgBzR//MJ0AJ33QcfXPHw+J8k=;
        b=B+cqgFwXB+d2ml8WGWg53EW15JD0h8F2uNHlAZUfgxgf6SoibE70u3JesLNnXaSfSWPKf5
        NAiaT6L7PSFBupTrS5DvbLhhNHrr5EY6ySRq6d3F7uvqDKGx78FfddchwrTfTFVgQ/7UdY
        lsvWv8qFgNPrNWVhFtcmgPFSW2z2TY4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-nmDdpYI6Nj2bTp3UcPwN3w-1; Mon, 13 Jan 2020 04:25:46 -0500
X-MC-Unique: nmDdpYI6Nj2bTp3UcPwN3w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 958BD10054E3;
        Mon, 13 Jan 2020 09:25:44 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 249ED87EFF;
        Mon, 13 Jan 2020 09:25:41 +0000 (UTC)
Date:   Mon, 13 Jan 2020 10:25:39 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Message-ID: <20200113092539.GD35080@krava>
References: <20191205193224.24629-1-acme@kernel.org>
 <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 01:58:59PM +0530, Ravi Bangoria wrote:

SNIP

>         | ^~~~
>   In file included from /usr/include/glib-2.0/gobject/gobject.h:24,
>                    from /usr/include/glib-2.0/gobject/gbinding.h:29,
>                    from /usr/include/glib-2.0/glib-object.h:23,
>                    from /usr/include/glib-2.0/gio/gioenums.h:28,
>                    from /usr/include/glib-2.0/gio/giotypes.h:28,
>                    from /usr/include/glib-2.0/gio/gio.h:26,
>                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:=
30,
>                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
>                    from test-gtk2.c:3:
>   /usr/include/glib-2.0/gobject/gtype.h:679:1: note: declared here
>     679 | {
>         | ^
>   In file included from /usr/include/gtk-2.0/gtk/gtktoolitem.h:31,
>                    from /usr/include/gtk-2.0/gtk/gtktoolbutton.h:30,
>                    from /usr/include/gtk-2.0/gtk/gtkmenutoolbutton.h:30=
,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:126,
>                    from test-gtk2.c:3:
>   /usr/include/gtk-2.0/gtk/gtktooltips.h:73:3: error: =E2=80=98GTimeVal=
=E2=80=99 is deprecated: Use 'GDateTime' instead [-Werror=3Ddeprecated-de=
clarations]
>      73 |   GTimeVal last_popdown;
>         |   ^~~~~~~~
>   In file included from /usr/include/glib-2.0/glib/galloca.h:32,
>                    from /usr/include/glib-2.0/glib.h:30,
>                    from /usr/include/glib-2.0/gobject/gbinding.h:28,
>                    from /usr/include/glib-2.0/glib-object.h:23,
>                    from /usr/include/glib-2.0/gio/gioenums.h:28,
>                    from /usr/include/glib-2.0/gio/giotypes.h:28,
>                    from /usr/include/glib-2.0/gio/gio.h:26,
>                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:=
30,
>                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
>                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
>                    from test-gtk2.c:3:
>   /usr/include/glib-2.0/glib/gtypes.h:551:8: note: declared here
>     551 | struct _GTimeVal
>         |        ^~~~~~~~~
>   cc1: all warnings being treated as errors
>=20

patch below fixes that for me.. please let me know
if it works for you and I'll post full patch

jirka


---
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index f30a89046aa3..7ac0d8088565 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -197,7 +197,7 @@ $(OUTPUT)test-libcrypto.bin:
 	$(BUILD) -lcrypto
=20
 $(OUTPUT)test-gtk2.bin:
-	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
+	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null) -W=
no-deprecated-declarations
=20
 $(OUTPUT)test-gtk2-infobar.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags gtk+-2.0 2>/dev/null)
diff --git a/tools/perf/ui/gtk/Build b/tools/perf/ui/gtk/Build
index ec22e899a224..eef708c502f4 100644
--- a/tools/perf/ui/gtk/Build
+++ b/tools/perf/ui/gtk/Build
@@ -1,4 +1,4 @@
-CFLAGS_gtk +=3D -fPIC $(GTK_CFLAGS)
+CFLAGS_gtk +=3D -fPIC $(GTK_CFLAGS) -Wno-deprecated-declarations
=20
 gtk-y +=3D browser.o
 gtk-y +=3D hists.o
@@ -7,3 +7,8 @@ gtk-y +=3D util.o
 gtk-y +=3D helpline.o
 gtk-y +=3D progress.o
 gtk-y +=3D annotate.o
+gtk-y +=3D zalloc.o
+
+$(OUTPUT)ui/gtk/zalloc.o: ../lib/zalloc.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)

