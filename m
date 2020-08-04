Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23284C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0FE2075A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3B4fH44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHDVOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:14:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgHDVOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596575660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d3mMCo8yCnsxE2a4yP5zcYHyRUruahEGxLiAU6kFjIs=;
        b=a3B4fH44NBgTEEFLBEU2knQlss0pX0NTzjnrW5X1/X7Xg77oikpCqapXfGk4ZUafNlD2xK
        SVXPYq78Nu8mPkycYvUKyhj7OttWly/QOapjFLtRjRm6cDJ20U8E7/DYLIc5jjGMK5R79Z
        MvflVl1VWhm0tlfjMLAj+rMpsPZAIHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-mxP43LSMMt-OQJMEAuknlg-1; Tue, 04 Aug 2020 17:14:18 -0400
X-MC-Unique: mxP43LSMMt-OQJMEAuknlg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13637101C8A7;
        Tue,  4 Aug 2020 21:14:17 +0000 (UTC)
Received: from krava (unknown [10.40.192.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id A055674F4D;
        Tue,  4 Aug 2020 21:14:14 +0000 (UTC)
Date:   Tue, 4 Aug 2020 23:14:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Remi Bernon <rbernon@codeweavers.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jacek Caban <jacek@codeweavers.com>
Subject: Re: [PATCH v2 3/3] perf tests: Add test for PE binary format support
Message-ID: <20200804211413.GK139381@krava>
References: <20200804085736.385232-1-rbernon@codeweavers.com>
 <20200804085736.385232-3-rbernon@codeweavers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804085736.385232-3-rbernon@codeweavers.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 10:57:36AM +0200, Remi Bernon wrote:
> This adds a precompiled file in PE binary format, with split debug file,
> and tries to read its build_id and .gnu_debuglink sections, as well as
> looking up the main symbol from the debug file. This should succeed if
> libbfd is supported.
> 
> Signed-off-by: Remi Bernon <rbernon@codeweavers.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jacek Caban <jacek@codeweavers.com>
> ---
> 
> v2: No changes.
> 
>  tools/perf/Makefile.perf           |   1 +
>  tools/perf/tests/Build             |   1 +
>  tools/perf/tests/builtin-test.c    |   4 ++
>  tools/perf/tests/pe-file-parsing.c |  96 +++++++++++++++++++++++++++++
>  tools/perf/tests/pe-file.c         |  14 +++++
>  tools/perf/tests/pe-file.exe       | Bin 0 -> 75595 bytes
>  tools/perf/tests/pe-file.exe.debug | Bin 0 -> 141644 bytes
>  tools/perf/tests/tests.h           |   1 +
>  8 files changed, 117 insertions(+)
>  create mode 100644 tools/perf/tests/pe-file-parsing.c
>  create mode 100644 tools/perf/tests/pe-file.c
>  create mode 100644 tools/perf/tests/pe-file.exe
>  create mode 100644 tools/perf/tests/pe-file.exe.debug
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 86dbb51bb272..11899fdd8eee 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -951,6 +951,7 @@ install-tests: all install-gtk
>  	$(call QUIET_INSTALL, tests) \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>  		$(INSTALL) tests/attr.py '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
> +		$(INSTALL) tests/pe-file.exe* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>  		$(INSTALL) tests/attr/* '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/attr'; \
>  		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell'; \
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index cd00498a5dce..da6aeba3c1e1 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -59,6 +59,7 @@ perf-y += genelf.o
>  perf-y += api-io.o
>  perf-y += demangle-java-test.o
>  perf-y += pfm.o
> +perf-y += pe-file-parsing.o
>  
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>  	$(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index da5b6cc23f25..e54ef171c73d 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -337,6 +337,10 @@ static struct test generic_tests[] = {
>  		.desc = "Demangle Java",
>  		.func = test__demangle_java,
>  	},
> +	{
> +		.desc = "PE file support",
> +		.func = test__pe_file_parsing,
> +	},
>  	{
>  		.func = NULL,
>  	},
> diff --git a/tools/perf/tests/pe-file-parsing.c b/tools/perf/tests/pe-file-parsing.c
> new file mode 100644
> index 000000000000..f40aca016a4f
> --- /dev/null
> +++ b/tools/perf/tests/pe-file-parsing.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdbool.h>
> +#include <inttypes.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <linux/bitops.h>
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <unistd.h>
> +#include <subcmd/exec-cmd.h>
> +
> +#include "debug.h"
> +#include "util/build-id.h"
> +#include "util/symbol.h"
> +#include "util/dso.h"
> +
> +#include "tests.h"
> +
> +#ifdef HAVE_LIBBFD_SUPPORT
> +
> +static int run_dir(const char *d)
> +{
> +	char filename[PATH_MAX];
> +	char debugfile[PATH_MAX];
> +	char build_id[BUILD_ID_SIZE];
> +	char debuglink[PATH_MAX];
> +	char expect_build_id[] = {
> +		0x5a, 0x0f, 0xd8, 0x82, 0xb5, 0x30, 0x84, 0x22,
> +		0x4b, 0xa4, 0x7b, 0x62, 0x4c, 0x55, 0xa4, 0x69,
> +	};
> +	char expect_debuglink[PATH_MAX] = "pe-file.exe.debug";
> +	struct dso *dso;
> +	struct symbol *sym;
> +	int ret;
> +
> +	scnprintf(filename, PATH_MAX, "%s/pe-file.exe", d);
> +	ret = filename__read_build_id(filename, build_id, BUILD_ID_SIZE);
> +	TEST_ASSERT_VAL("Failed to read build_id",
> +			ret == sizeof(expect_build_id));
> +	TEST_ASSERT_VAL("Wrong build_id", !memcmp(build_id, expect_build_id,
> +						  sizeof(expect_build_id)));
> +
> +	ret = filename__read_debuglink(filename, debuglink, PATH_MAX);
> +	TEST_ASSERT_VAL("Failed to read debuglink", ret == 0);
> +	TEST_ASSERT_VAL("Wrong debuglink",
> +			!strcmp(debuglink, expect_debuglink));
> +
> +	scnprintf(debugfile, PATH_MAX, "%s/%s", d, debuglink);
> +	ret = filename__read_build_id(debugfile, build_id, BUILD_ID_SIZE);
> +	TEST_ASSERT_VAL("Failed to read debug file build_id",
> +			ret == sizeof(expect_build_id));
> +	TEST_ASSERT_VAL("Wrong build_id", !memcmp(build_id, expect_build_id,
> +						  sizeof(expect_build_id)));
> +
> +	dso = dso__new(filename);

missing dso != NULL check

other than this all 3 paches look ok to me

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

