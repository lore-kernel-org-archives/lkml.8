Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535A8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27AA920758
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6Nf2Mwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgETMiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:38:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47800 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgETMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589978295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NhwYEb+DwJrIkmy7L0krdQJinx9f7VmDRd5lenUbKQU=;
        b=I6Nf2MwqXwmloFnmmuqFbqgvqTlQN9ejx5vzcLemF5XNuDS+vLdlwWBs15yPdL79kUyhQx
        PMOf4YNwjUBxewh5eidkpGVXf/xBn68onGTltcUbI65Q+p6hYX1GFLwjOAtFRuwqOdEC8M
        33OkSzTqFSWmk9UA7XT730rrjPXJMbk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-ZaOicCEfNNGUC0PuVWBLqQ-1; Wed, 20 May 2020 08:38:11 -0400
X-MC-Unique: ZaOicCEfNNGUC0PuVWBLqQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86C101005510;
        Wed, 20 May 2020 12:38:10 +0000 (UTC)
Received: from krava (unknown [10.40.193.10])
        by smtp.corp.redhat.com (Postfix) with SMTP id B4CB019C4F;
        Wed, 20 May 2020 12:38:08 +0000 (UTC)
Date:   Wed, 20 May 2020 14:38:07 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/9] perf evlist: implement control command handling
 functions
Message-ID: <20200520123807.GD157452@krava>
References: <eb38e9e5-754f-d410-1d9b-e26b702d51b7@linux.intel.com>
 <ffcdb43a-8f7d-b16f-d59b-19293037af84@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ffcdb43a-8f7d-b16f-d59b-19293037af84@linux.intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:00:02AM +0300, Alexey Budankov wrote:

SNIP

> +
> +static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
> +			      char *cmd_data, size_t data_size)
> +{
> +	int err;
> +	char c;
> +	size_t bytes_read = 0;
> +
> +	memset(cmd_data, 0, data_size--);
> +
> +	do {
> +		err = read(evlist->ctl_fd, &c, 1);
> +		if (err > 0) {
> +			if (c == '\n' || c == '\0')
> +				break;
> +			cmd_data[bytes_read++] = c;
> +			if (bytes_read == data_size)
> +				break;
> +		} else {
> +			if (err == -1)
> +				pr_err("Failed to read from ctlfd %d: %m\n", evlist->ctl_fd);
> +			break;
> +		}
> +	} while (1);
> +
> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");
> +
> +	if (err > 0) {
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
> +			*cmd = EVLIST_CTL_CMD_ENABLE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
> +			*cmd = EVLIST_CTL_CMD_DISABLE;
> +		}

are there more comands comming?

jirka

