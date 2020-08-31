Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C854C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE522073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 13:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="InDaqzGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHaNTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 09:19:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726249AbgHaNTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 09:19:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598879975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nw5D3n6QT07qapvmc8+NpUosdv4SxRu/zTaxzspJQIE=;
        b=InDaqzGkyILLyKpPwTlv5i6b5tbZlAzOE+WHLByNojcoHb+OffbByAyae21n+oFFMKih9C
        9HrlbE5tr3uJ9u8JhhPwSysHzgcTsP3dVJqwUwfoq7OALglULPleyYBSLGYyEuzDzhV8jZ
        uSIw7+omI4/8e2455ij9R+J3zdSQJ8k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-124-rMJFHjiVPZ6PsuhL2o-H5A-1; Mon, 31 Aug 2020 09:19:33 -0400
X-MC-Unique: rMJFHjiVPZ6PsuhL2o-H5A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE4F8107B276;
        Mon, 31 Aug 2020 13:19:30 +0000 (UTC)
Received: from krava (unknown [10.40.192.186])
        by smtp.corp.redhat.com (Postfix) with SMTP id 174251057FA9;
        Mon, 31 Aug 2020 13:19:28 +0000 (UTC)
Date:   Mon, 31 Aug 2020 15:19:27 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] perf tools: Add FIFO file names as alternative
 options to --control
Message-ID: <20200831131927.GD406859@krava>
References: <20200829105015.10800-1-adrian.hunter@intel.com>
 <20200829105015.10800-5-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829105015.10800-5-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 01:50:13PM +0300, Adrian Hunter wrote:

SNIP

> +		*p = '\0';
> +
> +	/*
> +	 * O_RDWR avoids POLLHUPs which is necessary to allow the other
> +	 * end of a FIFO to be repeatedly opened and closed.
> +	 */
> +	fd = open(s, O_RDWR | O_NONBLOCK | O_CLOEXEC);
> +	if (fd < 0) {
> +		pr_err("Failed to open '%s'\n", s);
> +		ret = -errno;
> +		goto out_free;
> +	}
> +	*ctl_fd = fd;
> +	*ctl_fd_close = true;
> +
> +	if (p && *++p) {
> +		/* O_RDWR | O_NONBLOCK means the other end need not be open */
> +		fd = open(p, O_RDWR | O_NONBLOCK | O_CLOEXEC);
> +		if (fd < 0) {
> +			pr_err("Failed to open '%s'\n", p);
> +			ret = -errno;
> +			goto out_free;
> +		}
> +		*ctl_fd_ack = fd;
> +	}
> +
> +out_free:
> +	free(s);
> +	return ret;
> +}
> +
> +int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close)
>  {
>  	char *comma = NULL, *endptr = NULL;
>  
>  	if (strncmp(str, "fd:", 3))
> -		return -EINVAL;
> +		return evlist__parse_control_names(str, ctl_fd, ctl_fd_ack, ctl_fd_close);

do we want to mention somewhere that the fifo name is everything
except for 'fd:' ?

also how likely is that we will add another channel type that
will need another keyword (likd 'fd:')? I originaly thought
we'd use 'fifo:filename' for this ... would be great to somehow
avoid future confusions

thanks,
jirka

