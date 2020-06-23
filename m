Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8014A20774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MytTFs78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgFWO4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22116 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgFWO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HWZ8wEpT9WswtfFYl1mP0fDjlJkStWexSarfhsNNRC0=;
        b=MytTFs78qblUUAb3LS1o1IE2e0poK3sc874kg/TAWtmipF3gXHW5hbhMT2/XWwKFJRQ1qV
        R1CenIMCh8Gp4XCxAG6JY35fEFDGDMR5gemAk3Lf7Xe40FOn7A5+gszjBUWM4pjLeZxnh6
        8FULF18pNo+8+1souc3RLp2dwg9MmtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-DnVl22kUO86pHT5MRq57aQ-1; Tue, 23 Jun 2020 10:56:17 -0400
X-MC-Unique: DnVl22kUO86pHT5MRq57aQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E88FD801503;
        Tue, 23 Jun 2020 14:56:15 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 21FEF7CAA3;
        Tue, 23 Jun 2020 14:56:13 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:56:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 03/13] perf evlist: implement control command handling
 functions
Message-ID: <20200623145613.GI2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:

SNIP

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
> +
> +	pr_debug("Message from ctl_fd: \"%s%s\"\n", cmd_data,
> +		 bytes_read == data_size ? "" : c == '\n' ? "\\n" : "\\0");

do you want to display the message above only if (err > 0) ?

> +
> +	if (err > 0) {
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {
> +			*cmd = EVLIST_CTL_CMD_ENABLE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {
> +			*cmd = EVLIST_CTL_CMD_DISABLE;
> +		}
> +	}
> +
> +	return err;
> +}

SNIP

> +	int ctlfd_pos = evlist->ctl_fd.pos;
> +	struct pollfd *entries = evlist->core.pollfd.entries;
> +
> +	if (ctlfd_pos == -1 || !entries[ctlfd_pos].revents)
> +		return 0;
> +
> +	if (entries[ctlfd_pos].revents & POLLIN) {
> +		err = evlist__ctlfd_recv(evlist, cmd, cmd_data,
> +					 EVLIST_CTL_CMD_MAX_LEN);
> +		if (err > 0) {
> +			switch (*cmd) {
> +			case EVLIST_CTL_CMD_ENABLE:
> +				evlist__enable(evlist);
> +				break;
> +			case EVLIST_CTL_CMD_DISABLE:
> +				evlist__disable(evlist);
> +				break;
> +			case EVLIST_CTL_CMD_ACK:
> +			case EVLIST_CTL_CMD_UNSUPPORTED:
> +			default:
> +				pr_debug("ctlfd: unsupported %d\n", *cmd);
> +				break;
> +			}
> +			if (!(*cmd == EVLIST_CTL_CMD_ACK || *cmd == EVLIST_CTL_CMD_UNSUPPORTED))
> +				evlist__ctlfd_ack(evlist);
> +		}
> +	}
> +
> +	if (entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
> +		evlist__finalize_ctlfd(evlist);

should this error be propagated via err?

jirka

