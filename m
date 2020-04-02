Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83869C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDEE206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 12:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqzuSD2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbgDBMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 08:45:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726252AbgDBMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 08:45:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585831501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OInt6TYyVUeXDP+gHo+3FOpp7iB6V9mt8Oc+n4QQb2g=;
        b=GqzuSD2YGn9xJe4K05RiICQoEvEXYjszK03rb+PPrJsxQPZ96v/B4DnSbh22NAi1kPXPdc
        9J3oYsMSv2M+TDLuapnXuKBzQlunhA+gTOut0X2tnjVgT1+SjoG6W8nbu6/ut0r4Q//Fgy
        TvyteOYL1TvuTrgohTcXZ0KoFetK7Po=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-vzawzjhbNH-JDy1zvz7j1w-1; Thu, 02 Apr 2020 08:44:59 -0400
X-MC-Unique: vzawzjhbNH-JDy1zvz7j1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F171800D53;
        Thu,  2 Apr 2020 12:44:58 +0000 (UTC)
Received: from agerstmayr-thinkpad.redhat.com (unknown [10.40.192.105])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 188915C1B0;
        Thu,  2 Apr 2020 12:44:52 +0000 (UTC)
From:   Andreas Gerstmayr <agerstmayr@redhat.com>
To:     linux-perf-users@vger.kernel.org
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf script: fix invalid read
Date:   Thu,  2 Apr 2020 14:43:38 +0200
Message-Id: <20200402124337.419456-1-agerstmayr@redhat.com>
In-Reply-To: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
References: <05e0d633-54b4-fb3b-3d08-8963271017ea@amd.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

closedir(lang_dir) frees the memory of script_dirent->d_name, which
gets accessed in the next line in a call to scnprintf().

Valgrind report:

Invalid read of size 1
=3D=3D413557=3D=3D    at 0x483CBE6: strlen (vg_replace_strmem.c:461)
=3D=3D413557=3D=3D    by 0x4DD45FD: __vfprintf_internal (vfprintf-interna=
l.c:1688)
=3D=3D413557=3D=3D    by 0x4DE6679: __vsnprintf_internal (vsnprintf.c:114=
)
=3D=3D413557=3D=3D    by 0x53A037: vsnprintf (stdio2.h:80)
=3D=3D413557=3D=3D    by 0x53A037: scnprintf (vsprintf.c:21)
=3D=3D413557=3D=3D    by 0x435202: get_script_path (builtin-script.c:3223=
)
=3D=3D413557=3D=3D  Address 0x52e7313 is 1,139 bytes inside a block of si=
ze 32,816 free'd
=3D=3D413557=3D=3D    at 0x483AA0C: free (vg_replace_malloc.c:540)
=3D=3D413557=3D=3D    by 0x4E303C0: closedir (closedir.c:50)
=3D=3D413557=3D=3D    by 0x4351DC: get_script_path (builtin-script.c:3222=
)

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 656b347f6dd8..170af13b4d53 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3218,10 +3218,10 @@ static char *get_script_path(const char *script_r=
oot, const char *suffix)
 			__script_root =3D get_script_root(script_dirent, suffix);
 			if (__script_root && !strcmp(script_root, __script_root)) {
 				free(__script_root);
-				closedir(lang_dir);
 				closedir(scripts_dir);
 				scnprintf(script_path, MAXPATHLEN, "%s/%s",
 					  lang_path, script_dirent->d_name);
+				closedir(lang_dir);
 				return strdup(script_path);
 			}
 			free(__script_root);
--=20
2.25.1

