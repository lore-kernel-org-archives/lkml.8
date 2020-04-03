Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D650EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9652078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="drRH0PMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390666AbgDCKsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:48:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727843AbgDCKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585910893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7ER8I6QMXmdfjnyr4lH0KXok90NchHx4EFsx0f+QgtI=;
        b=drRH0PMYpSwepFQ1nkRzh0F6yKHN0mmNiXWerH9bkktaQiT7SpyD5OZKfOP23j37w1VnGn
        zAL3FTn0KQEOzTvFvTa+l/v9QvWdyXSKxUdL3FMmW493E8W20Fhy8NYXYR0mBai+f6Uq2X
        OSs8IFGVr4RTAwDNlVHzeHdvMGzsSdw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-l9m08IvbPE6O-r_IoC58Cw-1; Fri, 03 Apr 2020 06:48:12 -0400
X-MC-Unique: l9m08IvbPE6O-r_IoC58Cw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7C9107ACC7;
        Fri,  3 Apr 2020 10:48:11 +0000 (UTC)
Received: from krava (unknown [10.40.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E61E71001B28;
        Fri,  3 Apr 2020 10:48:07 +0000 (UTC)
Date:   Fri, 3 Apr 2020 12:48:02 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script: Simplify auxiliary event printing functions
Message-ID: <20200403104802.GJ2784502@krava>
References: <20200402141548.21283-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402141548.21283-1-adrian.hunter@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 05:15:48PM +0300, Adrian Hunter wrote:
> This simplifies the print functions for the following perf script
> options:
> 
> 	--show-task-events
> 	--show-namespace-events
> 	--show-cgroup-events
> 	--show-mmap-events
> 	--show-switch-events
> 	--show-lost-events
> 	--show-bpf-events
> 
> Example:
> 	# perf record --switch-events -a -e cycles -c 10000 sleep 1
>  Before:
> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-before.txt
>  After:
> 	# perf script --show-task-events --show-namespace-events --show-cgroup-events --show-mmap-events --show-switch-events --show-lost-events --show-bpf-events >out-after.txt
> 	# diff -s out-before.txt out-after.txt
> 	Files out-before.txt and out-after.tx are identical
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

