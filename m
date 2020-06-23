Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBD3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D875320774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDiQkved"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732933AbgFWOy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:54:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732821AbgFWOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592924097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zX5l+igiDXxjHKbiKasVHbs9DlDXfu+pmjhSPoSV2Mo=;
        b=SDiQkved8k0/9+0M0+u9qeb1K8c3DLdZLjiNSTZvUnl/xLDf/NfJ78GQm9GNHrcpS0Y1Zy
        DCL3rUHzhhDmVfFMrJYbWN6WrKJMlEukkseJXwOJWOVUpBDB7WgYi3WA5AjG8tKV40GcEl
        o51yzBc3Zmbw224El0Fy5+Nzeh19d6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-hvqOmfvHMTebEwcPPzNrVg-1; Tue, 23 Jun 2020 10:54:54 -0400
X-MC-Unique: hvqOmfvHMTebEwcPPzNrVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49C138018D9;
        Tue, 23 Jun 2020 14:54:53 +0000 (UTC)
Received: from krava (unknown [10.40.192.77])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3782B60F8D;
        Tue, 23 Jun 2020 14:54:51 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:54:50 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/13] perf evlist: implement control command handling
 functions
Message-ID: <20200623145450.GF2619137@krava>
References: <5de4b954-24f0-1e8d-5a0d-7b12783b8218@linux.intel.com>
 <88988ce1-52d3-21e7-f0dc-bac5fde63cb2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88988ce1-52d3-21e7-f0dc-bac5fde63cb2@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 06:54:47PM +0300, Alexey Budankov wrote:

SNIP

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
> +	if (stat_entries[ctlfd_pos].revents & (POLLHUP | POLLERR))
> +		evlist__finalize_ctlfd(evlist);
> +	else
> +		stat_entries[ctlfd_pos].revents = 0;
> +
> +	return err;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 0d8b361f1c8e..bccf0a970371 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -360,4 +360,21 @@ void perf_evlist__force_leader(struct evlist *evlist);
>  struct evsel *perf_evlist__reset_weak_group(struct evlist *evlist,
>  						 struct evsel *evsel,
>  						bool close);
> +#define EVLIST_CTL_CMD_ENABLE_TAG  "enable"
> +#define EVLIST_CTL_CMD_DISABLE_TAG "disable"
> +#define EVLIST_CTL_CMD_ACK_TAG     "ack\n"

why the \n at the end of ack?

jirka

