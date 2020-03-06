Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7C8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2EDC206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfFVnvAf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCFOOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:14:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55484 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726646AbgCFOOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583504054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ulkGxmQ4QBuvsLJy/qkLxzxs0/QgSDhnIHzENOowzf4=;
        b=PfFVnvAfiUjfy00jd9QitkP/co9TBtaqRtN8NE4ciUlZKRUnQfi2W5Y3KGpUTJq0C1iqN4
        Nyi6N9DxUMQ6Vt5VFe+4oPNPfJ2peFdf77NYYGwe+ijH+LHRSxdRcDr4lqltv7rzJD8C0k
        U9Zxkir/aE7PAK2uO324rQ63FM2nfjQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-c9WlLz5hN0Kn-duc3WTfMQ-1; Fri, 06 Mar 2020 09:14:10 -0500
X-MC-Unique: c9WlLz5hN0Kn-duc3WTfMQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DF4C800D54;
        Fri,  6 Mar 2020 14:14:09 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D3B1B5DA2C;
        Fri,  6 Mar 2020 14:14:06 +0000 (UTC)
Date:   Fri, 6 Mar 2020 15:14:04 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 07/10] perf record: Support synthesizing cgroup events
Message-ID: <20200306141404.GC290743@krava>
References: <20200224043749.69466-1-namhyung@kernel.org>
 <20200224043749.69466-8-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224043749.69466-8-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:37:46PM +0900, Namhyung Kim wrote:

SNIP

> +	d = opendir(path);
> +	if (d == NULL) {
> +		pr_debug("failed to open directory: %s\n", path);
> +		return -1;
> +	}
> +
> +	while ((dent = readdir(d)) != NULL) {
> +		if (dent->d_type != DT_DIR)
> +			continue;
> +		if (!strcmp(dent->d_name, ".") ||
> +		    !strcmp(dent->d_name, ".."))
> +			continue;
> +
> +		/* any sane path should be less than PATH_MAX */
> +		if (strlen(path) + strlen(dent->d_name) + 1 >= PATH_MAX)
> +			continue;
> +
> +		if (path[pos - 1] != '/')
> +			strcat(path, "/");
> +		strcat(path, dent->d_name);
> +
> +		ret = perf_event__walk_cgroup_tree(tool, event, path,
> +						   mount_len, process, machine);
> +		if (ret < 0)
> +			break;
> +
> +		path[pos] = '\0';
> +	}
> +
> +	closedir(d);
> +	return ret;
> +}
> +
> +int perf_event__synthesize_cgroups(struct perf_tool *tool,
> +				   perf_event__handler_t process,
> +				   struct machine *machine)
> +{
> +	union perf_event event;
> +	char cgrp_root[PATH_MAX];
> +	size_t mount_len;  /* length of mount point in the path */
> +
> +	if (cgroupfs__mountpoint(cgrp_root, PATH_MAX, "perf_event") < 0) {
> +		pr_debug("cannot find cgroup mount point\n");
> +		return -1;
> +	}
> +
> +	mount_len = strlen(cgrp_root);
> +	/* make sure the path starts with a slash (after mount point) */
> +	strcat(cgrp_root, "/");

the code above checks on this and seems to add '/' if needed,
is this strcat necessary?

jirka

