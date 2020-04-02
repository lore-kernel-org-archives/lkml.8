Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCCC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE4E206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 14:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIS2UUZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbgDBORs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:17:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49430 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729213AbgDBORs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:17:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585837067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuGP7aJnDFhdZgpYgnvv0xosaA7xrwclM14mlI59qEU=;
        b=SIS2UUZvZbgf0Pa3jGgsVQYYXR+xx9f8vSAp/seBxHdzeIXscIXMU7/fGIwWqIEoagdNJG
        PYLN1kN1I7gJZ1iGmo1PixK3d1+KkUL4TVkSxoCtBAkWyfm4Y+aDuZAKMHPO1sZnTkIV1u
        /22IERFz71sucuDn0zK/Axp7XigA32U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-aZ0J-bxwOPu7RQ4y9aTC0Q-1; Thu, 02 Apr 2020 10:17:44 -0400
X-MC-Unique: aZ0J-bxwOPu7RQ4y9aTC0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 185501922966;
        Thu,  2 Apr 2020 14:17:34 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47F6CA63A6;
        Thu,  2 Apr 2020 14:17:32 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:17:29 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/8] perf evlist: implement control command handling
 functions
Message-ID: <20200402141729.GN2518490@krava>
References: <825a5132-b58d-c0b6-b050-5a6040386ec7@linux.intel.com>
 <1760b862-7a4a-3930-1a53-04667c71cf6f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1760b862-7a4a-3930-1a53-04667c71cf6f@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 11:46:43AM +0300, Alexey Budankov wrote:

SNIP

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
> +			case CTL_CMD_RESUME:
> +				evlist__enable(evlist);
> +				break;
> +			case CTL_CMD_PAUSE:
> +				evlist__disable(evlist);
> +				break;

would CTL_CMD_ENABLE, CTL_CMD_DISABLE be better fit in here?

especialy because we have the 'pause' ioctl for sampling,
which I was thinking initialy you are using for record,

and it's still might be better fit for sampling than disable, no?

jirka

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

SNIP

