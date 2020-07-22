Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BFFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16EF320658
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595421700;
	bh=X4ZRBp6iU+uuxJ2bEWf1RcQy+ZunOEZiEtfXBL/P1p8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uVi/90LJNminS/cNO0o1QaK9PIt8c/6LU4MIFxQcWsU6X6eObGRsfzBaZl8NiMMd0
	 TNhQ+lIvJK7r9+Tc6dyuWRmkkthpjKJLfTaNO7jhTI4vi0sBonT83IVvakhfp7sIdM
	 E5QdjJopfK9G3w7JXzUX0kZE9CIH9tkat3vbz0QI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732278AbgGVMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:41:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:41:38 -0400
Received: from quaco.ghostprotocols.net (unknown [177.17.3.185])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3115F20658;
        Wed, 22 Jul 2020 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595421697;
        bh=X4ZRBp6iU+uuxJ2bEWf1RcQy+ZunOEZiEtfXBL/P1p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kj94biUBvCdM85KBMPTF247z11n/GjVWBDbChzLrzUdiuI38IKeNJKikSwShJ6pdC
         joY69189pdkKC+coC77CVf8/IKiNAmEazF8RO4caex4aZVw9s0kQzgTS+aUNbezjbN
         Qg8qpsKxtAVG2Y5oPCL/Sdx3rtBd8zlWO5JNjyZI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 41B8E404B1; Wed, 22 Jul 2020 09:41:34 -0300 (-03)
Date:   Wed, 22 Jul 2020 09:41:34 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 05/15] perf evlist: implement control command
 handling functions
Message-ID: <20200722124134.GL77866@kernel.org>
References: <8d91c3a0-3db4-0a7a-ae13-299adb444bd6@linux.intel.com>
 <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62518ceb-1cc9-2aba-593b-55408d07c1bf@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 17, 2020 at 10:01:33AM +0300, Alexey Budankov escreveu:
> 
> Implement functions of initialization, finalization and processing
> of control command messages coming from control file descriptors.
> Allocate control file descriptor as descriptor at struct pollfd
> object of evsel_list for atomic poll() operation.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> Acked-by: Jiri Olsa <jolsa@redhat.com>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/evlist.c | 140 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  18 +++++
>  2 files changed, 158 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 36eb50aba1f5..fe900d82815c 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1714,3 +1714,143 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>  	}
>  	return leader;
>  }
> +
> +int evlist__initialize_ctlfd(struct evlist *evlist, int fd, int ack)
> +{
> +	if (fd == -1) {
> +		pr_debug("Control descriptor is not initialized\n");
> +		return 0;
> +	}
> +
> +	evlist->ctl_fd.pos = perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN,
> +						     fdarray_flag__nonfilterable);
> +	if (evlist->ctl_fd.pos < 0) {
> +		evlist->ctl_fd.pos = -1;
> +		pr_err("Failed to add ctl fd entry: %m\n");
> +		return -1;
> +	}
> +
> +	evlist->ctl_fd.fd = fd;
> +	evlist->ctl_fd.ack = ack;
> +
> +	return 0;
> +}
> +
> +bool evlist__ctlfd_initialized(struct evlist *evlist)
> +{
> +	return evlist->ctl_fd.pos >= 0;
> +}
> +
> +int evlist__finalize_ctlfd(struct evlist *evlist)
> +{
> +	struct pollfd *entries = evlist->core.pollfd.entries;
> +
> +	if (!evlist__ctlfd_initialized(evlist))
> +		return 0;
> +
> +	entries[evlist->ctl_fd.pos].fd = -1;
> +	entries[evlist->ctl_fd.pos].events = 0;
> +	entries[evlist->ctl_fd.pos].revents = 0;
> +
> +	evlist->ctl_fd.pos = -1;
> +	evlist->ctl_fd.ack = -1;
> +	evlist->ctl_fd.fd = -1;
> +
> +	return 0;
> +}
> +
> +static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> +			      char *cmd_data, size_t data_size)
> +{
> +	int err;
> +	char c;
> +	size_t bytes_read = 0;
> +
> +	memset(cmd_data, 0, data_size);
> +	data_size--;
> +
> +	do {
> +		err = read(evlist->ctl_fd.fd, &c, 1);
> +		if (err > 0) {
> +			if (c == '\n' || c == '\0')
> +				break;
> +			cmd_data[bytes_read++] = c;
> +			if (bytes_read == data_size)
> +				break;
> +		} else {
> +			if (err == -1)
> +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd.fd);
> +			break;
> +		}
> +	} while (1);

Ok, here you don't know how many bytes you have to read, the protocol is
a string ending in \n or \0, so you can't use 'readn()', but see below
for the write() case.

Also is this ctf_fd in non-blocking mode? Can't this get stuck waiting
forever?

> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> +
> +	if (err > 0) {
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +			     (sizeof(EVLIST_CTL_CMD_ENABLE_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_ENABLE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> +				    (sizeof(EVLIST_CTL_CMD_DISABLE_TAG)-1))) {
> +			*cmd = EVLIST_CTL_CMD_DISABLE;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int evlist__ctlfd_ack(struct evlist *evlist)
> +{
> +	int err;
> +
> +	if (evlist->ctl_fd.ack == -1)
> +		return 0;
> +
> +	err = write(evlist->ctl_fd.ack, EVLIST_CTL_CMD_ACK_TAG,
> +		    sizeof(EVLIST_CTL_CMD_ACK_TAG));
> +	if (err == -1)
> +		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd.ack);

Also the function to use here is 'writen()':

/*
 * Write exactly 'n' bytes or return an error.
 */
ssize_t writen(int fd, const void *buf, size_t n)
{
        /* ion does not modify buf. */
        return ion(false, fd, (void *)buf, n);
}
"tools/lib/perf/lib.c"

-----------------------------

I.e.  libperf's fd based fwrite().

Again, this can be done on top of this patch set, so I'll continue
as-is.

- Arnaldo
