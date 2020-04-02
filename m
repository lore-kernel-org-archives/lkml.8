Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096F3C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C59206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3ZQUbM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbgDBNlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23400 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388602AbgDBNlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585834908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/L0m6FBxyJndh8qJ0KHst3AgU4LJ/n6vrula4bAFlc=;
        b=K3ZQUbM09U1twh9TG64S7K/kYA1NElhpN2VCmiQc46an/XT+iRpNhu06OF6pbJyRs8yUh6
        RoqYhMQgfJ0cXE/eEgCCI3gOzxJjMWSHlnXGW1qrZtSPqI0PCCqUfSoSjWgj7XBNQQib+K
        a4mXQGcxQil7/natDGmR1ZQ3m/9/UGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-zFhQQdWxN6m-NujUm1AlqQ-1; Thu, 02 Apr 2020 09:41:46 -0400
X-MC-Unique: zFhQQdWxN6m-NujUm1AlqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8862E8024D0;
        Thu,  2 Apr 2020 13:41:44 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 03A8E26E75;
        Thu,  2 Apr 2020 13:41:39 +0000 (UTC)
Date:   Thu, 2 Apr 2020 15:41:37 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 4/5] tools api: add a lightweight buffered reading api
Message-ID: <20200402134137.GL2518490@krava>
References: <20200401233945.133550-1-irogers@google.com>
 <20200401233945.133550-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401233945.133550-5-irogers@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 04:39:44PM -0700, Ian Rogers wrote:
> The synthesize benchmark shows the majority of execution time going to
> fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> reading library that will be used to replace these calls in a follow-up
> CL.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h | 103 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 tools/lib/api/io.h
> 
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> new file mode 100644
> index 000000000000..e88d76c59440
> --- /dev/null
> +++ b/tools/lib/api/io.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Lightweight buffered reading library.
> + *
> + * Copyright 2019 Google LLC.
> + */

missing the recursion header check

#ifndef __PERF_IO_H
#define __PERF_IO_H 

> +
> +struct io {
> +	/* File descriptor being read/ */
> +	int fd;
> +	/* Size of the read buffer. */
> +	unsigned int buf_len;
> +	/* Pointer to storage for buffering read. */
> +	char *buf;
> +	/* End of the storage. */
> +	char *end;
> +	/* Currently accessed data pointer. */
> +	char *data;
> +	/* Set true on when the end of file on read error. */
> +	bool eof;
> +};
> +
> +static inline void init_io(struct io *io, int fd,
> +			   char *buf, unsigned int buf_len)
> +{
> +	io->fd = fd;
> +	io->buf_len = buf_len;
> +	io->buf = buf;
> +	io->end = buf;
> +	io->data = buf;
> +	io->eof = false;
> +}

looks good, could you please add io__ prefix for all functions?

thanks,
jirka

> +
> +/* Reads one character from the "io" file with similar semantics to fgetc. */
> +static inline int get_char(struct io *io)
> +{
> +	char *ptr = io->data;
> +
> +	if (ptr == io->end) {
> +		ssize_t n = read(io->fd, io->buf, io->buf_len);
> +
> +		if (n <= 0) {
> +			io->eof = true;
> +			return -1;
> +		}
> +		ptr = &io->buf[0];
> +		io->end = &io->buf[n];
> +	}
> +	io->data = ptr + 1;
> +	return *ptr;
> +}
> +
> +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the hexadecimal value.
> + */
> +static inline int get_hex(struct io *io, __u64 *hex)
> +{
> +	bool first_read = true;
> +
> +	*hex = 0;
> +	while (true) {
> +		char ch = get_char(io);
> +
> +		if (ch < 0)
> +			return ch;
> +		if (ch >= '0' && ch <= '9')
> +			*hex = (*hex << 4) | (ch - '0');
> +		else if (ch >= 'a' && ch <= 'f')
> +			*hex = (*hex << 4) | (ch - 'a' + 10);
> +		else if (ch >= 'A' && ch <= 'F')
> +			*hex = (*hex << 4) | (ch - 'A' + 10);
> +		else if (first_read)
> +			return -1;
> +		else
> +			return ch;
> +		first_read = false;
> +	}
> +}
> +
> +/* Read a decimal value into the out argument dec.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the decimal value.
> + */
> +static inline int get_dec(struct io *io, __u64 *dec)
> +{
> +	bool first_read = true;
> +
> +	*dec = 0;
> +	while (true) {
> +		char ch = get_char(io);
> +
> +		if (ch < 0)
> +			return ch;
> +		if (ch >= '0' && ch <= '9')
> +			*dec = (*dec * 10) + ch - '0';
> +		else if (first_read)
> +			return -1;
> +		else
> +			return ch;
> +		first_read = false;
> +	}
> +}
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

