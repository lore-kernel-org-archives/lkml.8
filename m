Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0234EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB592072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5FgpOZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgD0KLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:11:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbgD0KLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587982271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/r6OCCFJCs+suY+jsP9RHTl1UjcuuUzhDsd42oINWI=;
        b=B5FgpOZoKyHViIrvRswSBEkQFRHGKufJdIvr3j9nCbHle0d7NqhnNR4Fk8OnGOT6wizgDZ
        UmKjkDSzxfRhCFsXP4AxgMtCLtzGzkQUybLSIwwdMpOrcz4StsLjbJKUS7tWg/ZCSTF0o8
        d/gh7UlmnivCi6wGfKKEi2VlxSAi+qw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-WD5IPPuWMt6UxJpC3kfjwA-1; Mon, 27 Apr 2020 06:11:07 -0400
X-MC-Unique: WD5IPPuWMt6UxJpC3kfjwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 535A1468;
        Mon, 27 Apr 2020 10:11:06 +0000 (UTC)
Received: from krava (unknown [10.40.195.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D04FB5C5D9;
        Mon, 27 Apr 2020 10:11:03 +0000 (UTC)
Date:   Mon, 27 Apr 2020 12:11:01 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 1/7] perf util: Create source line mapping table
Message-ID: <20200427101101.GC1457790@krava>
References: <20200420010451.24405-1-yao.jin@linux.intel.com>
 <20200420010451.24405-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200420010451.24405-2-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 09:04:45AM +0800, Jin Yao wrote:
> Sometimes, a small change in a hot function reducing the cycles of
> this function, but the overall workload doesn't get faster. It is
> interesting where the cycles are moved to.
>=20
> What it would like is to diff before/after streams. A stream is a
> callchain which is aggregated by the branch records from samples.
>=20
> By browsing the hot streams, we can understand the hot code flow.
> By comparing the cycles variation of same streams between old perf
> data and new perf data, we can understand if the cycles are moved to
> the unchanged code.
>=20
> The before stream is the stream before source line changed
> (e.g. streams in perf.data.old). The after stream is the stream
> after source line changed (e.g. streams in perf.data).
>=20
> Diffing before/after streams compares all streams (or compares top
> N hot streams) between two perf data files.
>=20
> If all entries of one stream in perf.data.old are fully matched with
> all entries of another stream in perf.data, we think these two streams
> are matched, otherwise the streams are not matched.
>=20
> For example,
>=20
>    cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
> --------------------------              --------------------------
>              main div.c:39                           main div.c:39
>              main div.c:44                           main div.c:44

hi,
I'm getting compile error with this patch:

	[jolsa@krava perf]$ make JOBS=3D1
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

thanks,
jirka


>=20
> It looks that two streams are matched and we can see for the same
> streams the cycles are equal and the stream hit percents are
> slightly changed. That's expected in the normal range.
>=20
> But that's not always true if source lines are changed in perf.data
> (e.g. div.c:39 is changed). If the source line is changed, they
> are different streams, we can't compare them. We just think the
> stream in perf.data is a new one.
>=20
> The challenge is how to identify the changed source lines. The basic
> idea is to use linux command 'diff' to compare the source file A and
> source file A* line by line (assume A is used in perf.data.old
> and A* is updated in perf.data). Create a source line mapping table.
>=20
> For example,
>=20
>   Execute 'diff ./before/div.c ./after/div.c'
>=20
>   25c25
>   <       i =3D rand() % 2;
>   ---
>   >       i =3D rand() % 4;
>   39c39
>   <       for (i =3D 0; i < 2000000000; i++) {
>   ---
>   >       for (i =3D 0; i < 20000000001; i++) {
>=20
>   div.c (after -> before) lines mapping:
>   0 -> 0
>   1 -> 1
>   2 -> 2
>   3 -> 3
>   4 -> 4
>   5 -> 5
>   6 -> 6
>   7 -> 7
>   8 -> 8
>   9 -> 9
>   ...
>   24 -> 24
>   25 -> -1
>   26 -> 26
>   27 -> 27
>   28 -> 28
>   29 -> 29
>   30 -> 30
>   31 -> 31
>   32 -> 32
>   33 -> 33
>   34 -> 34
>   35 -> 35
>   36 -> 36
>   37 -> 37
>   38 -> 38
>   39 -> -1
>   40 -> 40
>   ...
>=20
> From the table, we can easily know div.c:39 is source line changed.
> (it's mapped to -1). So these two streams are not matched.
>=20
> This patch can also handle the cases of new source lines insertion
> and old source lines deletion. This source line mapping table is a
> base for next processing for stream comparison.
>=20
> This patch creates a new rblist 'srclist' to manage the source line
> mapping tables. Each node contains the source line mapping table of
> a before/after source file pair. The node is created on demand as
> we process the samples. So it's likely we don't need to create so many
> nodes.
>=20
>  v2:
>  ---
>  Refine the code
>  1. calloc -> zalloc
>  2. Functions operating on a 'struct line_pair' have the
>     line_pair__ prefix.
>  3. Check get_range() return value.
>  4. Use fgets to replace fgetc for getting the number of lines.
>  5. Use path__join to generate the full path.
>  6. Keep the buffer after calling getline.
>=20
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/Build     |   1 +
>  tools/perf/util/srclist.c | 555 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/srclist.h |  65 +++++
>  3 files changed, 621 insertions(+)
>  create mode 100644 tools/perf/util/srclist.c
>  create mode 100644 tools/perf/util/srclist.h
>=20
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index c0cf8dff694e..b9bf620b60f0 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -99,6 +99,7 @@ perf-y +=3D call-path.o
>  perf-y +=3D rwsem.o
>  perf-y +=3D thread-stack.o
>  perf-y +=3D spark.o
> +perf-y +=3D srclist.o
>  perf-$(CONFIG_AUXTRACE) +=3D auxtrace.o
>  perf-$(CONFIG_AUXTRACE) +=3D intel-pt-decoder/
>  perf-$(CONFIG_AUXTRACE) +=3D intel-pt.o
> diff --git a/tools/perf/util/srclist.c b/tools/perf/util/srclist.c
> new file mode 100644
> index 000000000000..8060e4855d11
> --- /dev/null
> +++ b/tools/perf/util/srclist.c
> @@ -0,0 +1,555 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Manage difference of source lines
> + * Copyright (c) 2020, Intel Corporation.
> + * Author: Jin Yao
> + */
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <sys/types.h>
> +#include <inttypes.h>
> +#include <string.h>
> +#include <strings.h>
> +#include <unistd.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <limits.h>
> +#include <stdbool.h>
> +#include <linux/zalloc.h>
> +#include "strlist.h"
> +#include "srclist.h"
> +#include "debug.h"
> +#include "path.h"
> +
> +enum {
> +	DIFF_LINE_ADD,
> +	DIFF_LINE_DEL,
> +	DIFF_LINE_CHANGE
> +};
> +
> +static void get_full_path(const char *dir, const char *rel_path,
> +			  char *full_path, int size)
> +{
> +	if (!dir) {
> +		snprintf(full_path, size, "%s", rel_path);
> +		return;
> +	}
> +
> +	path__join(full_path, size, dir, rel_path);
> +}
> +
> +static int path__number_of_lines(char *path)
> +{
> +	FILE *fp;
> +	char buf[4096], *p, last =3D 0;
> +	int num =3D 0;
> +
> +	fp =3D fopen(path, "r");
> +	if (!fp) {
> +		pr_debug("Failed to open file %s\n", path);
> +		return -1;
> +	}
> +
> +	while (!feof(fp)) {
> +		p =3D fgets(buf, sizeof(buf), fp);
> +		if (!p)
> +			break;
> +
> +		last =3D p[strlen(p) - 1];
> +		if (last =3D=3D '\n')
> +			num++;
> +	}
> +
> +	fclose(fp);
> +
> +	if (last !=3D '\n' && last !=3D 0)
> +		num++;
> +
> +	return num;
> +}
> +
> +static int get_digit(char *str, char **end_str, int *val)
> +{
> +	int v;
> +	char *end;
> +
> +	errno =3D 0;
> +	v =3D strtol(str, &end, 10);
> +	if ((errno =3D=3D ERANGE && (v =3D=3D INT_MAX || v =3D=3D INT_MIN))
> +		|| (errno !=3D 0 && v =3D=3D 0)) {
> +		return -1;
> +	}
> +
> +	if (end =3D=3D str)
> +		return -1;
> +
> +	*val =3D v;
> +	*end_str =3D end;
> +	return 0;
> +}
> +
> +static int get_range(char *str, int *start_val, int *end_val)
> +{
> +	int val, ret;
> +	char *end, *next;
> +
> +	*start_val =3D -1;
> +	*end_val =3D -1;
> +
> +	ret =3D get_digit(str, &end, &val);
> +	if (ret)
> +		return ret;
> +
> +	*start_val =3D val;
> +
> +	if (*end !=3D '\0') {
> +		next =3D end + 1;
> +		ret =3D get_digit(next, &end, &val);
> +		if (ret)
> +			return ret;
> +
> +		*end_val =3D val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int opr_str_idx(char *str, int len, char ch)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < len; i++) {
> +		if (str[i] =3D=3D ch)
> +			break;
> +	}
> +
> +	if (i =3D=3D len || i =3D=3D 0 || i =3D=3D len - 1)
> +		return -1;
> +
> +	if (str[i - 1] >=3D '0' && str[i - 1] <=3D '9' &&
> +	    str[i + 1] >=3D '0' && str[i + 1] <=3D '9') {
> +		return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static bool get_diff_operation(char *str, int *opr, int *b_start, int =
*b_end,
> +			       int *a_start, int *a_end)
> +{
> +	int idx, len;
> +
> +	if (str[0] =3D=3D '<' || str[0] =3D=3D '>' || str[0] =3D=3D '-')
> +		return false;
> +
> +	len =3D strlen(str);
> +
> +	/*
> +	 * For example,
> +	 * 5,6d4
> +	 * 8a7
> +	 * 20,21c19
> +	 */
> +	idx =3D opr_str_idx(str, len, 'd');
> +	if (idx !=3D -1) {
> +		*opr =3D DIFF_LINE_DEL;
> +		goto exit;
> +	}
> +
> +	idx =3D opr_str_idx(str, len, 'a');
> +	if (idx !=3D -1) {
> +		*opr =3D DIFF_LINE_ADD;
> +		goto exit;
> +	}
> +
> +	idx =3D opr_str_idx(str, len, 'c');
> +	if (idx !=3D -1) {
> +		*opr =3D DIFF_LINE_CHANGE;
> +		goto exit;
> +	}
> +
> +exit:
> +	if (idx !=3D -1) {
> +		str[idx] =3D 0;
> +		if (get_range(str, b_start, b_end) !=3D 0)
> +			return false;
> +
> +		if (get_range(&str[idx + 1], a_start, a_end) !=3D 0)
> +			return false;
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int line_pair__del_lines(struct line_pair *lines, int b_start, =
int b_end,
> +				int a_start, int a_end __maybe_unused,
> +				int *nr_lines, int *b_adjust)
> +{
> +	int i =3D *nr_lines;
> +	bool set =3D false;
> +
> +	/*
> +	 * For example, 5,6d4
> +	 * It means line 5 ~ line 6 of file1 are not same as line 4 of file2
> +	 * because line 5 ~ line 6 are deleted.
> +	 */
> +
> +	if (a_start =3D=3D i) {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D i + *b_adjust;
> +		set =3D true;
> +	}
> +
> +	if (b_end !=3D -1)
> +		*b_adjust +=3D b_end - b_start + 1;
> +	else
> +		*b_adjust +=3D 1;
> +
> +	if (!set) {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D i + *b_adjust;
> +	}
> +
> +	*nr_lines =3D i + 1;
> +	return 0;
> +}
> +
> +static int line_pair__add_lines(struct line_pair *lines,
> +				int b_start __maybe_unused,
> +				int b_end __maybe_unused,
> +				int a_start, int a_end, int *nr_lines,
> +				int *b_adjust)
> +{
> +	int i =3D *nr_lines;
> +
> +	/*
> +	 * For example, 8a7
> +	 * It means line 8 at file1 is not same as line 7 at file2
> +	 * because a new line (line 7) is inserted to file2.
> +	 */
> +	if (a_end !=3D -1) {
> +		for (int j =3D 0; j < a_end - a_start + 1; j++) {
> +			lines[i].a_nr =3D i;
> +			lines[i].b_nr =3D -1;
> +			i++;
> +		}
> +		*b_adjust -=3D a_end - a_start + 1;
> +	} else {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D -1;
> +		i++;
> +		*b_adjust -=3D 1;
> +	}
> +
> +	*nr_lines =3D i;
> +	return 0;
> +}
> +
> +static int line_pair__change_lines(struct line_pair *lines, int b_star=
t,
> +				   int b_end, int a_start, int a_end,
> +				   int *nr_lines, int *b_adjust)
> +{
> +	int i =3D *nr_lines;
> +
> +	/*
> +	 * For example, 20,21c19
> +	 * It means line20~line21 of file1 are not same as line19 of file2
> +	 * since they are changed.
> +	 */
> +
> +	if (a_end !=3D -1) {
> +		for (int j =3D 0; j < a_end - a_start + 1; j++) {
> +			lines[i].a_nr =3D i;
> +			lines[i].b_nr =3D -1;
> +			i++;
> +		}
> +	} else {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D -1;
> +		i++;
> +	}
> +
> +	if (b_end !=3D -1)
> +		*b_adjust +=3D b_end - b_start;
> +
> +	if (a_end !=3D -1)
> +		*b_adjust -=3D a_end - a_start;
> +
> +	*nr_lines =3D i;
> +	return 0;
> +}
> +
> +static int line_pair__update_lines(struct line_pair *lines, int opr,
> +				   int b_start, int b_end, int a_start,
> +				   int a_end, int *nr_lines, int *b_adjust)
> +{
> +	int i =3D *nr_lines;
> +
> +	while (i < a_start) {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D i + *b_adjust;
> +		i++;
> +	}
> +
> +	*nr_lines =3D i;
> +
> +	switch (opr) {
> +	case DIFF_LINE_DEL:
> +		line_pair__del_lines(lines, b_start, b_end, a_start, a_end,
> +				     nr_lines, b_adjust);
> +		break;
> +
> +	case DIFF_LINE_ADD:
> +		line_pair__add_lines(lines, b_start, b_end, a_start, a_end,
> +				     nr_lines, b_adjust);
> +		break;
> +
> +	case DIFF_LINE_CHANGE:
> +		line_pair__change_lines(lines, b_start, b_end, a_start,
> +					a_end, nr_lines, b_adjust);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void line_pair__update_remaining(struct line_pair *lines, int a=
_num,
> +					 int *nr_lines, int b_adjust)
> +{
> +	int i;
> +
> +	for (i =3D *nr_lines; i <=3D a_num; i++) {
> +		lines[i].a_nr =3D i;
> +		lines[i].b_nr =3D i + b_adjust;
> +	}
> +
> +	*nr_lines =3D i;
> +}
> +
> +static int build_mapping_table(FILE *fp, struct line_pair *lines,
> +			       int *nr_lines, int a_num)
> +{
> +	char *str =3D NULL, *p;
> +	size_t len =3D 0;
> +	int opr, b_start, b_end, a_start, a_end, b_adjust =3D 0;
> +
> +	*nr_lines =3D 1;  /* First line is reserved */
> +
> +	while (getline(&str, &len, fp) > 0) {
> +		p =3D strchr(str, '\n');
> +		if (p)
> +			*p =3D '\0';
> +
> +		pr_debug("%s\n", str);
> +
> +		if (!get_diff_operation(str, &opr, &b_start, &b_end,
> +					&a_start, &a_end)) {
> +			continue;
> +		}
> +
> +		line_pair__update_lines(lines, opr, b_start, b_end, a_start,
> +					a_end, nr_lines, &b_adjust);
> +	}
> +
> +	line_pair__update_remaining(lines, a_num, nr_lines, b_adjust);
> +
> +	free(str);
> +	return 0;
> +}
> +
> +static int src_info__create_line_mapping(struct src_info *info, char *=
b_path,
> +					 char *a_path)
> +{
> +	char cmd[PATH_MAX];
> +	FILE *fp =3D NULL;
> +	int ret =3D -1;
> +
> +	info->nr_lines_before =3D path__number_of_lines(b_path);
> +	if (info->nr_lines_before =3D=3D -1)
> +		goto out;
> +
> +	info->nr_lines_after =3D path__number_of_lines(a_path);
> +	if (info->nr_lines_after =3D=3D -1)
> +		goto out;
> +
> +	/* Reserve first line */
> +	info->nr_max =3D info->nr_lines_before + info->nr_lines_after + 1;
> +	info->lines =3D calloc(info->nr_max, sizeof(struct line_pair));
> +	if (!info->lines) {
> +		pr_err("Failed to alloc memory for lines\n");
> +		goto out;
> +	}
> +
> +	snprintf(cmd, sizeof(cmd), "diff %s %s",
> +		 b_path, a_path);
> +
> +	pr_debug("Execute '%s'\n", cmd);
> +
> +	fp =3D popen(cmd, "r");
> +	if (!fp) {
> +		pr_err("Failed to execute '%s'\n", cmd);
> +		goto out;
> +	}
> +
> +	ret =3D build_mapping_table(fp, info->lines, &info->nr_lines,
> +				  info->nr_lines_after);
> +
> +out:
> +	if (fp)
> +		fclose(fp);
> +
> +	return ret;
> +}
> +
> +static void free_src_info(struct src_info *info)
> +{
> +	zfree(&info->rel_path);
> +	zfree(&info->lines);
> +}
> +
> +static int init_src_info(char *b_path, char *a_path, const char *rel_p=
ath,
> +			 struct src_info *info)
> +{
> +	int ret;
> +
> +	info->rel_path =3D strdup(rel_path);
> +	if (!info->rel_path)
> +		return -1;
> +
> +	ret =3D src_info__create_line_mapping(info, b_path, a_path);
> +	if (ret)
> +		free_src_info(info);
> +
> +	return ret;
> +}
> +
> +static void free_src_node(struct src_node *node)
> +{
> +	if (!node)
> +		return;
> +
> +	free_src_info(&node->info);
> +	free(node);
> +}
> +
> +static struct rb_node *srclist__node_new(struct rblist *rblist,
> +					 const void *entry)
> +{
> +	struct srclist *slist =3D container_of(rblist, struct srclist, rblist=
);
> +	const char *rel_path =3D entry;
> +	char b_path[PATH_MAX], a_path[PATH_MAX];
> +	struct src_node *node;
> +	int ret;
> +
> +	get_full_path(slist->before_dir, rel_path, b_path, PATH_MAX);
> +	get_full_path(slist->after_dir, rel_path, a_path, PATH_MAX);
> +
> +	node =3D zalloc(sizeof(*node));
> +	if (!node)
> +		return NULL;
> +
> +	ret =3D init_src_info(b_path, a_path, rel_path, &node->info);
> +	if (ret)
> +		goto err;
> +
> +	return &node->rb_node;
> +
> +err:
> +	free_src_node(node);
> +	return NULL;
> +}
> +
> +static void srclist__node_delete(struct rblist *rblist __maybe_unused,
> +				 struct rb_node *rb_node)
> +{
> +	struct src_node *node =3D container_of(rb_node, struct src_node, rb_n=
ode);
> +
> +	free_src_info(&node->info);
> +	free(node);
> +}
> +
> +static int srclist__node_cmp(struct rb_node *rb_node, const void *entr=
y)
> +{
> +	struct src_node *node =3D container_of(rb_node, struct src_node, rb_n=
ode);
> +	const char *str =3D entry;
> +
> +	return strcmp(node->info.rel_path, str);
> +}
> +
> +struct srclist *srclist__new(const char *before_dir, const char *after=
_dir)
> +{
> +	struct srclist *slist =3D zalloc(sizeof(*slist));
> +
> +	if (!slist)
> +		return NULL;
> +
> +	rblist__init(&slist->rblist);
> +	slist->rblist.node_cmp =3D srclist__node_cmp;
> +	slist->rblist.node_new =3D srclist__node_new;
> +	slist->rblist.node_delete =3D srclist__node_delete;
> +
> +	slist->before_dir =3D before_dir;
> +	slist->after_dir =3D after_dir;
> +	return slist;
> +}
> +
> +void srclist__delete(struct srclist *slist)
> +{
> +	if (slist)
> +		rblist__delete(&slist->rblist);
> +}
> +
> +struct src_node *srclist__find(struct srclist *slist, char *rel_path,
> +			       bool create)
> +{
> +	struct src_node *node =3D NULL;
> +	struct rb_node *rb_node;
> +
> +	if (create)
> +		rb_node =3D rblist__findnew(&slist->rblist, (void *)rel_path);
> +	else
> +		rb_node =3D rblist__find(&slist->rblist, (void *)rel_path);
> +
> +	if (rb_node)
> +		node =3D container_of(rb_node, struct src_node, rb_node);
> +
> +	return node;
> +}
> +
> +struct line_pair *srclist__line_pair(struct src_node *node, int a_nr)
> +{
> +	struct src_info *info =3D &node->info;
> +
> +	if (a_nr < info->nr_lines && a_nr > 0)
> +		return &info->lines[a_nr];
> +
> +	pr_debug("Exceeds line range: nr_lines =3D %d, a_nr =3D %d\n",
> +		 info->nr_lines, a_nr);
> +
> +	return NULL;
> +}
> +
> +void srclist__dump(struct srclist *slist)
> +{
> +	struct src_node *node;
> +	struct src_info *info;
> +	int i;
> +
> +	srclist__for_each_entry(node, slist) {
> +		info =3D &node->info;
> +
> +		pr_debug("%s (after -> before) lines mapping:\n",
> +			 info->rel_path);
> +
> +		for (i =3D 0; i < info->nr_lines; i++) {
> +			pr_debug("%d -> %d\n",
> +				 info->lines[i].a_nr,
> +				 info->lines[i].b_nr);
> +		}
> +	}
> +}
> diff --git a/tools/perf/util/srclist.h b/tools/perf/util/srclist.h
> new file mode 100644
> index 000000000000..f25b0de91a13
> --- /dev/null
> +++ b/tools/perf/util/srclist.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PERF_SRCLIST_H
> +#define __PERF_SRCLIST_H
> +
> +#include <linux/types.h>
> +#include <linux/rbtree.h>
> +#include "rblist.h"
> +
> +struct line_pair {
> +	int a_nr;	/* line nr in after.c */
> +	int b_nr;	/* line nr in before.c */
> +};
> +
> +struct src_node;
> +
> +struct src_info {
> +	char *rel_path; /* relative path */
> +	struct line_pair *lines;
> +	int nr_max;
> +	int nr_lines;
> +	int nr_lines_before;
> +	int nr_lines_after;
> +};
> +
> +struct src_node {
> +	struct rb_node rb_node;
> +	struct src_info info;
> +};
> +
> +struct srclist {
> +	struct rblist rblist;
> +	const char *before_dir;
> +	const char *after_dir;
> +};
> +
> +struct srclist *srclist__new(const char *before_dir, const char *after=
_dir);
> +void srclist__delete(struct srclist *slist);
> +
> +struct src_node *srclist__find(struct srclist *slist, char *rel_path,
> +			       bool create);
> +
> +struct line_pair *srclist__line_pair(struct src_node *node, int a_nr);
> +void srclist__dump(struct srclist *slist);
> +
> +static inline struct src_node *srclist__first(struct srclist *slist)
> +{
> +	struct rb_node *rn =3D rb_first_cached(&slist->rblist.entries);
> +
> +	return rn ? rb_entry(rn, struct src_node, rb_node) : NULL;
> +}
> +
> +static inline struct src_node *srclist__next(struct src_node *sn)
> +{
> +	struct rb_node *rn;
> +
> +	if (!sn)
> +		return NULL;
> +	rn =3D rb_next(&sn->rb_node);
> +	return rn ? rb_entry(rn, struct src_node, rb_node) : NULL;
> +}
> +
> +#define srclist__for_each_entry(pos, slist)	\
> +	for (pos =3D srclist__first(slist); pos; pos =3D srclist__next(pos))
> +
> +#endif /* __PERF_SRCLIST_H */
> --=20
> 2.17.1
>=20

