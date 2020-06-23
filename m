Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5E6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79C8E20723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U/r3cIe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbgFWO4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:56:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgFWO4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=taUePkUfct5gQK42OEwhtebKEPSLXjf9XgefEPEv1jI=;
        b=U/r3cIe/dI+lZDO8IoWYpGJn+CRBE46GqMlkBNtt/Kr3UeFPm1OaG7KIIX/HAfAnqng2VO
        e8WaDrCxYR94alvyKRGYEAiu2OBmKxv+p9UZzZU6PeW5hFdZwhQNLVbg8r5YQasF5ss1Mx
        U2TmKE3ndE2RfO6kpAhsHVX8p0r9f4s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-_cBp9mn5NPe9xiWkGNqSrw-1; Tue, 23 Jun 2020 10:56:07 -0400
X-MC-Unique: _cBp9mn5NPe9xiWkGNqSrw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E061800597;
        Tue, 23 Jun 2020 14:56:06 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 92B1860F8D;
        Tue, 23 Jun 2020 14:56:02 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:56:01 +0200
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
Message-ID: <20200623145601.GH2619137@krava>
References: <0781a077-aa82-5b4a-273e-c17372a72b93@linux.intel.com>
 <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d47ef616-e2cf-9131-159f-5be1a31438a7@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 11:36:46AM +0300, Alexey Budankov wrote:

SNIP

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
> +
> +	if (err > 0) {
> +		if (!strncmp(cmd_data, EVLIST_CTL_CMD_ENABLE_TAG,
> +			     strlen(EVLIST_CTL_CMD_ENABLE_TAG))) {

you could use sizeof(EVLIST_CTL_CMD_ENABLE_TAG) instead, no function call

> +			*cmd = EVLIST_CTL_CMD_ENABLE;
> +		} else if (!strncmp(cmd_data, EVLIST_CTL_CMD_DISABLE_TAG,
> +				    strlen(EVLIST_CTL_CMD_DISABLE_TAG))) {

ditto

jirka

