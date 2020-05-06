Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0512076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKjFMKkz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEFUVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbgEFUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:21:42 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D55BC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:21:42 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id v10so1508910qvr.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OhnPg6FmM/PvlxA3EMEXSgdF+c8Ak7a+kAiTazPJVjM=;
        b=CKjFMKkzrP6Mx2WcyxkY27qcGV0NfENUgdqxdtN034M1SCcrAMvxG89H+miaUEOtr/
         M0Vq5t2Ad8SG5olAFoLxeIzbySLdpREf07i7JaAjLfKNl/OKHxRiyJcJ+3o4Vk0Sdm3j
         UafJKVF8k0M+ZpJKC++F/52/rW5Z65GVKHIJfaCad8j9V6TbPzmpsh2XjcGfxIph2sEM
         jYSVJAj62whWqEoUqQqWiDQyGssG1WLd92ywGIihwyJM32X/2Vy112lX9Kcs6NUyf6gx
         wL89FL3CM9qrdj+S6VJwsYrq6TZePLUYm14Lx2RRct1swn5ZpudLOmz9ASJj5TM6/ycX
         sNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OhnPg6FmM/PvlxA3EMEXSgdF+c8Ak7a+kAiTazPJVjM=;
        b=cpy9kWkdZnLIZVFsofUnvaIhdUf72SsS90e3YTqgca7w0E3olVl8R7CTDTTRc/u3XB
         yntocSFdhAppI1ev3CFqh49uhEWTMzGcUobS+rabQLR+YIv4NnqJdPO6R+7fCkIEVxHg
         MzshTM+2IzCE7w9Bu8DzY58zs6xkjE0XhK5ZCfOw/z2PX5vDIHBKaX3qELWSqxdXLTN5
         LjBuYwB3QCszA4UyoJaWmrvFaIaBBcO/+PW9zziCGFG9XajF2hGVzKmjKYIRS1aTHBT9
         2h+bLr4fe90VKnV6oCdphKO7FmSmrv7oqf9omTJbma45fnLwX9boXVRlH77QFQNnsdQ5
         GXmA==
X-Gm-Message-State: AGi0PuYBhHmJBbqZ0l9rY6UOAHm6cDz2EsdN42ZGMd0NOj6Z4GGLzbZb
        o4qfUenV7zjsrclsKHAwTcc=
X-Google-Smtp-Source: APiQypLC2mWChUZIKyBvkZGfRick5QyN66G+smc8YWrGB2SR7lvzSma75LYRyTq9pCAaTHwFm7xqOQ==
X-Received: by 2002:ad4:49c1:: with SMTP id j1mr3225948qvy.144.1588796501200;
        Wed, 06 May 2020 13:21:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id y185sm2560874qkd.29.2020.05.06.13.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:21:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B848409A3; Wed,  6 May 2020 17:21:38 -0300 (-03)
Date:   Wed, 6 May 2020 17:21:38 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/11] perf evlist: implement control command handling
 functions
Message-ID: <20200506202138.GF9893@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <142da58d-7ff1-ea73-89e0-30342a710aab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142da58d-7ff1-ea73-89e0-30342a710aab@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 09:19:22PM +0300, Alexey Budankov escreveu:
> 
> Implement functions of initialization, finalization and processing
> of control commands coming from control file descriptors.
> 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/evlist.c | 100 +++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  12 +++++
>  2 files changed, 112 insertions(+)
> 
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 2db4bedc4f81..e086c846ef3a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1707,3 +1707,103 @@ struct evsel *perf_evlist__reset_weak_group(struct evlist *evsel_list,
>  	}
>  	return leader;
>  }
> +
> +int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack)
> +{
> +	if (ctl_fd == -1) {
> +		pr_debug("Control descriptor is not initialized\n");
> +		return 0;
> +	}
> +
> +	evlist->ctl_fd_pos = perf_evlist__add_pollfd(&evlist->core, ctl_fd, NULL, POLLIN);
> +	if (evlist->ctl_fd_pos < 0) {
> +		evlist->ctl_fd_pos = -1;
> +		pr_err("Failed to add ctl fd entry: %m\n");
> +		return -1;
> +	}
> +
> +	evlist->ctl_fd = ctl_fd;
> +	evlist->ctl_fd_ack = ctl_fd_ack;
> +
> +	return 0;
> +}
> +
> +int perf_evlist__finalize_ctlfd(struct evlist *evlist)
> +{
> +	if (evlist->ctl_fd_pos == -1)
> +		return 0;
> +
> +	evlist->core.pollfd.entries[evlist->ctl_fd_pos].fd = -1;
> +	evlist->ctl_fd_pos = -1;
> +	evlist->ctl_fd_ack = -1;
> +	evlist->ctl_fd = -1;
> +
> +	return 0;
> +}
> +
> +static int perf_evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> +{
> +	int err;
> +	char buf[2];
> +
> +	err = read(evlist->ctl_fd, &buf, sizeof(buf));
> +	if (err > 0)
> +		*cmd = buf[0];
> +	else if (err == -1)
> +		pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd);
> +
> +	return err;
> +}
> +
> +static int perf_evlist__ctlfd_ack(struct evlist *evlist)
> +{
> +	int err;
> +	char buf[2] = {CTL_CMD_ACK, '\n'};
> +
> +	if (evlist->ctl_fd_ack == -1)
> +		return 0;
> +
> +	err = write(evlist->ctl_fd_ack, buf, sizeof(buf));
> +	if (err == -1)
> +		pr_err("failed to write to ctl_ack_fd %d: %m\n", evlist->ctl_fd_ack);
> +
> +	return err;
> +}
> +
> +int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
> +{
> +	int err = 0;
> +	int ctlfd_pos = evlist->ctl_fd_pos;
> +	struct pollfd *entries = evlist->core.pollfd.entries;
> +
> +	if (!entries[ctlfd_pos].revents)
> +		return 0;
> +
> +	if (entries[ctlfd_pos].revents & POLLIN) {
> +		err = perf_evlist__ctlfd_recv(evlist, cmd);
> +		if (err > 0) {
> +			switch (*cmd) {
> +			case CTL_CMD_ENABLE:
> +				evlist__enable(evlist);
> +				break;
> +			case CTL_CMD_DISABLE:
> +				evlist__disable(evlist);
> +				break;
> +			case CTL_CMD_ACK:
> +			case CTL_CMD_UNSUPPORTED:
> +			default:
> +				pr_debug("ctlfd: unsupported %d\n", *cmd);
> +				break;
> +			}
> +			if (!(*cmd == CTL_CMD_ACK || *cmd == CTL_CMD_UNSUPPORTED))
> +				perf_evlist__ctlfd_ack(evlist);
> +		}
> +	}
> +
> +	if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
> +		perf_evlist__finalize_ctlfd(evlist);
> +	else
> +		entries[ctlfd_pos].revents = 0;
> +
> +	return err;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 62f259d89b41..84386850c290 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -358,4 +358,16 @@ void perf_evlist__force_leader(struct evlist *evlist);
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>  						 struct evsel *evsel,
>  						bool close);
> +
> +enum evlist_ctl_cmd {
> +	CTL_CMD_UNSUPPORTED = 0,
> +	CTL_CMD_ENABLE = 'e',
> +	CTL_CMD_DISABLE = 'd',
> +	CTL_CMD_ACK = 'a'
> +};

Can we make this a string, I think we'll eventually ask for lots more
stuff, like asking for a --switch-output snapshot with --overwrite,
reconfiguring events to increase/decrease frequency, etc, interfacing
with PERF_EVENT_IOC_MODIFY_ATTRIBUTES, PERF_EVENT_IOC_SET_FILTER, etc.

This will also allow us to have parameters, etc, wdyt?

Also please since these are events that deal with 'struct evlist', name
them with the evlist__ prefix, not the perf_evlist__ one, as those
should be used with 'struct perf_evlist', i.e. the one in libperf
(tools/lib/perf/).

Right now this is inconsistent, we did it that way to minimize
disruption of the codebase when moving things from tools/perf/ to
tools/lib/perf/, but this confuses things and I just did a
s/perf_evsel__/evsel__) for things dealing with 'struct evsel', so lets
not add new ones with the wrong prefix, eventually we'll have perf_ only
for things in libperf.

> +
> +int perf_evlist__initialize_ctlfd(struct evlist *evlist, int ctl_fd, int ctl_fd_ack);
> +int perf_evlist__finalize_ctlfd(struct evlist *evlist);
> +int perf_evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd);
> +
>  #endif /* __PERF_EVLIST_H */
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
