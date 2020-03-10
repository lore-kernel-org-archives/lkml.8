Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3332FC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0A2420727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 15:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuKMlEo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgCJPJB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:09:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44644 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgCJPJB (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 11:09:01 -0400
Received: by mail-qt1-f193.google.com with SMTP id h16so9844424qtr.11
        for <Linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 08:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lymXd8NF2HHpZdHn9mrSGmmqXZ1WWs1o5CIbO989zVs=;
        b=FuKMlEo9c9fv5kvmWQ0bCsc00qXK1YDKynzF85LhvgfdVqHEFZIw6OdZJxzAU9H14+
         xCzr9aolTZShFwcuucUgjlYFbog8fhkPFe+XA9xt5FR6cMJqnkOn16AOCppnKWgjP0GJ
         svYLiun1OP1ad+OwP76MP7v7wDjyqzGinXDtjiAZZ7lNyo/wQ9RG6nMEf31xMWr49itm
         JZ3dYD6Uiiqnhe1YJDTNP6bk7jSBTvUfJdxPexZZnM0Pzd7ycqPKIaWRNvvRdq9sl8VG
         NFGNj8uh7A0QDknpjiC3ZIZzhaRuXoE6Nc5mv2bjIBdytbrq8dwlrM9XbTm/WgGeiSu3
         xZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lymXd8NF2HHpZdHn9mrSGmmqXZ1WWs1o5CIbO989zVs=;
        b=mPELSnXpu3m4Yak2uGx0WnrUO2nUj44Ylgzz2ocpaT5JaDX/ZF/mMX20whepyjtOi5
         /LsbfRpdO5nkXmO2XwFxhH/f82vrTB8Bt9E+JmKxIyYVo+nVJ1+gngdZP+eWCgCrAzlX
         5uMSbt/p14JGgwpunLGyGGZMuNm+Y75tn9OQeDCIRia4W87tGqGqVtjUIXjzNX9TvUEa
         h+brAi4r113Y5VP1CpzMqBP+vU7X97I9uANsE+hfSFbZAppTKg2PbbNwMLCMmgp8Cxe+
         T6DFTC8U86fp7jdCnB4gP15Sgg9aHK+DihMunsh1GJlLj/yhdsVwLDE9jHp4ffwSuP8O
         PEnQ==
X-Gm-Message-State: ANhLgQ0C+aVPT2B10BjecmGsDrvwqE3Xazsy66HKvywSXlVJYWZ22rkB
        CVUHpo29LYZHHmZ3a8TTTMZ4u8YXnYk=
X-Google-Smtp-Source: ADFU+vvQIy/rrinMaTPAXQr8OtOD8ZW13pPwv1WTRHVxr/UqKAByAARL7pCfRuM0wEFtz3HsFHhJnQ==
X-Received: by 2002:aed:2d41:: with SMTP id h59mr6773095qtd.115.1583852938963;
        Tue, 10 Mar 2020 08:08:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x19sm23827547qtm.47.2020.03.10.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 08:08:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 70A8E40009; Tue, 10 Mar 2020 12:08:55 -0300 (-03)
Date:   Tue, 10 Mar 2020 12:08:55 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1 01/14] perf util: Create source line mapping table
Message-ID: <20200310150855.GF15931@kernel.org>
References: <20200310070245.16314-1-yao.jin@linux.intel.com>
 <20200310070245.16314-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310070245.16314-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 10, 2020 at 03:02:32PM +0800, Jin Yao escreveu:
> Sometimes, a small change in a hot function reducing the cycles of
> this function, but the overall workload doesn't get faster. It is
> interesting where the cycles are moved to.
> 
> What it would like is to diff before/after streams. A stream is a
> callchain which is aggregated by the branch records from samples.
> 
> By browsing the hot streams, we can understand the hot code flow.
> By comparing the cycles variation of same streams between old perf
> data and new perf data, we can understand if the cycles are moved to
> the unchanged code.
> 
> The before stream is the stream before source line changed
> (e.g. streams in perf.data.old). The after stream is the stream
> after source line changed (e.g. streams in perf.data).
> 
> Diffing before/after streams compares all streams (or compares top
> N hot streams) between two perf data files.
> 
> If all entries of one stream in perf.data.old are fully matched with
> all entries of another stream in perf.data, we think these two streams
> are matched, otherwise the streams are not matched.
> 
> For example,
> 
>    cycles: 1, hits: 26.80%                 cycles: 1, hits: 27.30%
> --------------------------              --------------------------
>              main div.c:39                           main div.c:39
>              main div.c:44                           main div.c:44
> 
> It looks that two streams are matched and we can see for the same
> streams the cycles are equal and the stream hit percents are
> slightly changed. That's expected in the normal range.
> 
> But that's not always true if source lines are changed in perf.data
> (e.g. div.c:39 is changed). If the source line is changed, they
> are different streams, we can't compare them. We just think the
> stream in perf.data is a new one.
> 
> The challenge is how to identify the changed source lines. The basic
> idea is to use linux command 'diff' to compare the source file A and
> source file A* line by line (assume A is used in perf.data.old
> and A* is updated in perf.data). Create a source line mapping table.
> 
> For example,
> 
>   Execute 'diff ./before/div.c ./after/div.c'
> 
>   25c25
>   <       i = rand() % 2;
>   ---
>   >       i = rand() % 4;
>   39c39
>   <       for (i = 0; i < 2000000000; i++) {
>   ---
>   >       for (i = 0; i < 20000000001; i++) {
> 
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
> 
> From the table, we can easily know div.c:39 is source line changed.
> (it's mapped to -1). So these two streams are not matched.
> 
> This patch can also handle the cases of new source lines insertion
> and old source lines deletion. This source line mapping table is a
> base for next processing for stream comparison.
> 
> This patch creates a new rblist 'srclist' to manage the source line
> mapping tables. Each node contains the source line mapping table of
> a before/after source file pair. The node is created on demand as
> we process the samples. So it's likely we don't need to create so many
> nodes.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/Build     |   1 +
>  tools/perf/util/srclist.c | 552 ++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/srclist.h |  65 +++++
>  3 files changed, 618 insertions(+)
>  create mode 100644 tools/perf/util/srclist.c
>  create mode 100644 tools/perf/util/srclist.h
> 
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index c0cf8dff694e..b9bf620b60f0 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -99,6 +99,7 @@ perf-y += call-path.o
>  perf-y += rwsem.o
>  perf-y += thread-stack.o
>  perf-y += spark.o
> +perf-y += srclist.o
>  perf-$(CONFIG_AUXTRACE) += auxtrace.o
>  perf-$(CONFIG_AUXTRACE) += intel-pt-decoder/
>  perf-$(CONFIG_AUXTRACE) += intel-pt.o
> diff --git a/tools/perf/util/srclist.c b/tools/perf/util/srclist.c
> new file mode 100644
> index 000000000000..cb1d42a3a8ed
> --- /dev/null
> +++ b/tools/perf/util/srclist.c
> @@ -0,0 +1,552 @@
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
> +	if (dir[strlen(dir) - 1] == '/')
> +		snprintf(full_path, size, "%s%s", dir, rel_path);
> +	else
> +		snprintf(full_path, size, "%s/%s", dir, rel_path);

Just use 

	snprintf(full_path, size, "%s/%s", dir, rel_path);

an extra / won't matter, the code will be smaller. At first I thought
you could use path__join(), please check if that is the case.

> +}
> +
> +static int get_line_num(char *path)

So this is to get how many lines a given file has? I.e. 'wc -l'? Maybe:

static int path__number_of_lines(const char *path)

?

> +{
> +	FILE *fh;
> +	int num = 0, ch, last = 0;
> +
> +	fh = fopen(path, "r");
> +	if (!fh) {
> +		pr_debug("Failed to open file %s\n", path);
> +		return -1;
> +	}
> +
> +	while (!feof(fh)) {
> +		ch = fgetc(fh);
> +		if (ch == '\n')
> +			num++;
> +		last = ch;

Maybe use fgets() instead as it already stops at '\n'?

> +	}
> +
> +	fclose(fh);
> +
> +	if (last != '\n')
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
> +	errno = 0;
> +	v = strtol(str, &end, 10);
> +	if ((errno == ERANGE && (v == INT_MAX || v == INT_MIN))
> +		|| (errno != 0 && v == 0)) {
> +		return -1;
> +	}
> +
> +	if (end == str)
> +		return -1;
> +
> +	*val = v;
> +	*end_str = end;
> +	return 0;
> +}
> +
> +static int get_range(char *str, int *start_val, int *end_val)
> +{
> +	int val, ret;
> +	char *end, *next;
> +
> +	*start_val = -1;
> +	*end_val = -1;
> +
> +	ret = get_digit(str, &end, &val);
> +	if (ret)
> +		return ret;
> +
> +	*start_val = val;
> +
> +	if (*end != '\0') {
> +		next = end + 1;
> +		ret = get_digit(next, &end, &val);
> +		if (ret)
> +			return ret;
> +
> +		*end_val = val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int opr_str_idx(char *str, int len, char ch)
> +{
> +	int i;
> +
> +	for (i = 0; i < len; i++) {
> +		if (str[i] == ch)
> +			break;
> +	}
> +
> +	if (i == len || i == 0 || i == len - 1)
> +		return -1;
> +
> +	if (str[i - 1] >= '0' && str[i - 1] <= '9' &&
> +	    str[i + 1] >= '0' && str[i + 1] <= '9') {
> +		return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static bool get_diff_operation(char *str, int *opr, int *b_start, int *b_end,
> +			       int *a_start, int *a_end)
> +{
> +	int idx, len;
> +
> +	if (str[0] == '<' || str[0] == '>' || str[0] == '-')
> +		return false;
> +
> +	len = strlen(str);
> +
> +	/*
> +	 * For example,
> +	 * 5,6d4
> +	 * 8a7
> +	 * 20,21c19
> +	 */
> +	idx = opr_str_idx(str, len, 'd');
> +	if (idx != -1) {
> +		*opr = DIFF_LINE_DEL;
> +		goto exit;
> +	}
> +
> +	idx = opr_str_idx(str, len, 'a');
> +	if (idx != -1) {
> +		*opr = DIFF_LINE_ADD;
> +		goto exit;
> +	}
> +
> +	idx = opr_str_idx(str, len, 'c');
> +	if (idx != -1) {
> +		*opr = DIFF_LINE_CHANGE;
> +		goto exit;
> +	}
> +
> +exit:
> +	if (idx != -1) {
> +		str[idx] = 0;
> +		get_range(str, b_start, b_end);
> +		get_range(&str[idx + 1], a_start, a_end);

get_range() may return -1, don't you have to check this here?

> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static int del_lines(struct line_pair *lines, int b_start, int b_end,
> +		     int a_start, int a_end __maybe_unused,
> +		     int *nr_lines, int *b_adjust)
> +{
> +	int i = *nr_lines;
> +	bool set = false;
> +
> +	/*
> +	 * For example, 5,6d4
> +	 * It means line5~line6 of file1 are not same as line4 of file2
> +	 * since line5~line6 are deleted.
> +	 */
> +
> +	if (a_start == i) {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = i + *b_adjust;
> +		set = true;
> +	}
> +
> +	if (b_end != -1)
> +		*b_adjust += b_end - b_start + 1;
> +	else
> +		*b_adjust += 1;
> +
> +	if (!set) {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = i + *b_adjust;
> +	}
> +
> +	*nr_lines = i + 1;
> +	return 0;
> +}
> +
> +static int add_lines(struct line_pair *lines,
> +		     int b_start __maybe_unused, int b_end __maybe_unused,
> +		     int a_start, int a_end, int *nr_lines, int *b_adjust)
> +{
> +	int i = *nr_lines;
> +
> +	/*
> +	 * For example, 8a7
> +	 * It means line8 of file1 is not same as line7 of file2
> +	 * since a new line (line7) is inserted to file2.
> +	 */
> +	if (a_end != -1) {
> +		for (int j = 0; j < a_end - a_start + 1; j++) {
> +			lines[i].a_nr = i;
> +			lines[i].b_nr = -1;
> +			i++;
> +		}
> +		*b_adjust -= a_end - a_start + 1;
> +	} else {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = -1;
> +		i++;
> +		*b_adjust -= 1;
> +	}
> +
> +	*nr_lines = i;
> +	return 0;
> +}
> +
> +static int change_lines(struct line_pair *lines, int b_start, int b_end,
> +			int a_start, int a_end, int *nr_lines, int *b_adjust)
> +{
> +	int i = *nr_lines;
> +
> +	/*
> +	 * For example, 20,21c19
> +	 * It means line20~line21 of file1 are not same as line19 of file2
> +	 * since they are changed.
> +	 */
> +
> +	if (a_end != -1) {
> +		for (int j = 0; j < a_end - a_start + 1; j++) {
> +			lines[i].a_nr = i;
> +			lines[i].b_nr = -1;
> +			i++;
> +		}
> +	} else {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = -1;
> +		i++;
> +	}
> +
> +	if (b_end != -1)
> +		*b_adjust += b_end - b_start;
> +
> +	if (a_end != -1)
> +		*b_adjust -= a_end - a_start;
> +
> +	*nr_lines = i;
> +	return 0;
> +}
> +
> +static int update_lines(struct line_pair *lines, int opr, int b_start,
> +			int b_end, int a_start, int a_end, int *nr_lines,
> +			int *b_adjust)


Functions operating on thisa 'struct line_pair' should have the
line_pair__ prefix, so that we can use ctags, etc, as we have other
places that process lines, etc, which may end up clashing.

> +{
> +	int i = *nr_lines;
> +
> +	while (i < a_start) {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = i + *b_adjust;
> +		i++;
> +	}
> +
> +	*nr_lines = i;
> +
> +	switch (opr) {
> +	case DIFF_LINE_DEL:
> +		del_lines(lines, b_start, b_end, a_start, a_end,
> +			  nr_lines, b_adjust);
> +		break;
> +
> +	case DIFF_LINE_ADD:
> +		add_lines(lines, b_start, b_end, a_start, a_end,
> +			  nr_lines, b_adjust);
> +		break;
> +
> +	case DIFF_LINE_CHANGE:
> +		change_lines(lines, b_start, b_end, a_start, a_end,
> +			     nr_lines, b_adjust);
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static void update_remaining(struct line_pair *lines, int a_num, int *nr_lines,
> +			     int b_adjust)
> +{
> +	int i;
> +
> +	for (i = *nr_lines; i <= a_num; i++) {
> +		lines[i].a_nr = i;
> +		lines[i].b_nr = i + b_adjust;
> +	}
> +
> +	*nr_lines = i;
> +}
> +
> +static int build_mapping_table(FILE *diff_fd, struct line_pair *lines,
> +			       int *nr_lines, int a_num)
> +{
> +	char *str, *p;
> +	size_t len;
> +	int opr, b_start, b_end, a_start, a_end, b_adjust = 0;
> +
> +	*nr_lines = 1;  /* First line is reserved */
> +
> +	while (!feof(diff_fd)) {
> +		str = NULL;

Forgot to set len to zero? (See getline manpage)

> +		if (getline(&str, &len, diff_fd) < 0 || !len)
> +			break;
> +
> +		p = strchr(str, '\n');
> +		if (p)
> +			*p = '\0';
> +
> +		pr_debug("%s\n", str);
> +
> +		if (!get_diff_operation(str, &opr, &b_start, &b_end,
> +					&a_start, &a_end)) {
> +			continue;
> +		}
> +
> +		update_lines(lines, opr, b_start, b_end, a_start, a_end,
> +			     nr_lines, &b_adjust);

So, since str was allocated, where is it being kept? above you're always
setting it to NULL before calling getline.

> +	}
> +
> +	update_remaining(lines, a_num, nr_lines, b_adjust);
> +
> +	free(str);
> +	return 0;
> +}
> +
> +static int create_line_mapping(struct src_info *info, char *b_path,
> +			       char *a_path)

src_info__create_line_mappings() ?

> +{
> +	char cmd[PATH_MAX];
> +	FILE *diff_fd = NULL;
> +	int ret = -1;
> +
> +	info->nr_lines_before = get_line_num(b_path);
> +	if (info->nr_lines_before == -1)
> +		goto out;
> +
> +	info->nr_lines_after = get_line_num(a_path);
> +	if (info->nr_lines_after == -1)
> +		goto out;
> +
> +	/* Reserve first line */
> +	info->nr_max = info->nr_lines_before + info->nr_lines_after + 1;
> +	info->lines = calloc(info->nr_max, sizeof(struct line_pair));
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
> +	diff_fd = popen(cmd, "r");
> +	if (!diff_fd) {
> +		pr_err("Failed to execute '%s'\n", cmd);
> +		goto out;
> +	}
> +
> +	ret = build_mapping_table(diff_fd, info->lines, &info->nr_lines,
> +				  info->nr_lines_after);
> +
> +out:
> +	if (diff_fd)
> +		fclose(diff_fd);
> +
> +	return ret;
> +}
> +
> +static void free_src_info(struct src_info *info)
> +{
> +	if (info->rel_path)
> +		zfree(&info->rel_path);
> +
> +	if (info->lines)
> +		zfree(&info->lines);

No need to check if it is NULL, call zfree() straight away.

> +}
> +
> +static int init_src_info(char *b_path, char *a_path, const char *rel_path,
> +			 struct src_info *info)
> +{
> +	int ret;
> +
> +	info->rel_path = strdup(rel_path);
> +	if (!info->rel_path)
> +		return -1;
> +
> +	ret = create_line_mapping(info, b_path, a_path);
> +	if (ret) {
> +		free_src_info(info);
> +		return ret;
> +	}
> +
> +	return 0;

	if (ret)
		free_src_info(info);

	return ret;

Should be equivalent and shorter, no?


> +}
> +
> +static void free_src_node(struct src_node *node)
> +{

Free routines should accept a NULL arg, i.e. first thing:

        if (node == NULL)
		return;

> +	free_src_info(&node->info);
> +	free(node);
> +}
> +
> +static struct rb_node *srclist__node_new(struct rblist *rblist,
> +					 const void *entry)
> +{
> +	struct srclist *slist = container_of(rblist, struct srclist, rblist);
> +	const char *rel_path = entry;
> +	char b_path[PATH_MAX], a_path[PATH_MAX];
> +	struct src_node *node;
> +	int ret;
> +
> +	get_full_path(slist->before_dir, rel_path, b_path, PATH_MAX);
> +	get_full_path(slist->after_dir, rel_path, a_path, PATH_MAX);
> +
> +	node = calloc(1, sizeof(*node));

	zalloc()?

> +	if (!node)
> +		return NULL;
> +
> +	ret = init_src_info(b_path, a_path, rel_path, &node->info);
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
> +	struct src_node *node = container_of(rb_node, struct src_node, rb_node);
> +
> +	free_src_info(&node->info);
> +	free(node);
> +}
> +
> +static int srclist__node_cmp(struct rb_node *rb_node, const void *entry)
> +{
> +	struct src_node *node = container_of(rb_node, struct src_node, rb_node);
> +	const char *str = entry;
> +
> +	return strcmp(node->info.rel_path, str);
> +}
> +
> +struct srclist *srclist__new(const char *before_dir, const char *after_dir)
> +{
> +	struct srclist *slist = calloc(1, sizeof(*slist));

zalloc()

> +
> +	if (!slist)
> +		return NULL;
> +
> +	rblist__init(&slist->rblist);
> +	slist->rblist.node_cmp = srclist__node_cmp;
> +	slist->rblist.node_new = srclist__node_new;
> +	slist->rblist.node_delete = srclist__node_delete;
> +
> +	slist->before_dir = before_dir;
> +	slist->after_dir = after_dir;
> +	return slist;
> +}
> +
> +void srclist__delete(struct srclist *slist)
> +{
> +	if (slist)
> +		rblist__delete(&slist->rblist);


Correct, delete operations should accept NULL, just like free()

> +}
> +
> +struct src_node *srclist__find(struct srclist *slist, char *rel_path,
> +			       bool create)
> +{
> +	struct src_node *node = NULL;
> +	struct rb_node *rb_node;
> +
> +	if (create)
> +		rb_node = rblist__findnew(&slist->rblist, (void *)rel_path);
> +	else
> +		rb_node = rblist__find(&slist->rblist, (void *)rel_path);
> +
> +	if (rb_node)
> +		node = container_of(rb_node, struct src_node, rb_node);
> +
> +	return node;
> +}
> +
> +struct line_pair *srclist__line_pair(struct src_node *node, int a_nr)
> +{
> +	struct src_info *info = &node->info;
> +
> +	if (a_nr < info->nr_lines && a_nr > 0)
> +		return &info->lines[a_nr];
> +
> +	pr_debug("Exceeds line range: nr_lines = %d, a_nr = %d\n",
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
> +		info = &node->info;
> +
> +		pr_debug("%s (after -> before) lines mapping:\n",
> +			 info->rel_path);
> +
> +		for (i = 0; i < info->nr_lines; i++) {
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
> +struct srclist *srclist__new(const char *before_dir, const char *after_dir);
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
> +	struct rb_node *rn = rb_first_cached(&slist->rblist.entries);
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
> +	rn = rb_next(&sn->rb_node);
> +	return rn ? rb_entry(rn, struct src_node, rb_node) : NULL;
> +}
> +
> +#define srclist__for_each_entry(pos, slist)	\
> +	for (pos = srclist__first(slist); pos; pos = srclist__next(pos))
> +
> +#endif /* __PERF_SRCLIST_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
