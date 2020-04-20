Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38689C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BF720736
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UjHOBBPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbgDTM4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:56:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41515 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726779AbgDTM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587387367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aQuiO+56fM83jue+pc8NC1/acthLiygj2WkuZrb/ns0=;
        b=UjHOBBPPEsCK/H1ldbtsoP5PjkYnZxG7c9L/PS2Fgc6ieJXmwG4Y4PKGW81rQAw7TanUq0
        NKdxfWYjXjHMkDmL9Nv49j6m49rKdaJ1bB8La2WnzSWXDyoa5nUt7VqADOVULOobOusW0w
        KYMeShv/mJvoqbRbJlKyFzD7+yw5Y/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-RY_AvQcYMPu5lZgX1_CboA-1; Mon, 20 Apr 2020 08:56:05 -0400
X-MC-Unique: RY_AvQcYMPu5lZgX1_CboA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 811081085983;
        Mon, 20 Apr 2020 12:56:04 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 961835C1BB;
        Mon, 20 Apr 2020 12:56:03 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 11D06119; Mon, 20 Apr 2020 09:56:00 -0300 (BRT)
Date:   Mon, 20 Apr 2020 09:55:59 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     jagdsh.linux@gmail.com
Cc:     jolsa@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] tools/lib/perf/: Remove duplicate headers
Message-ID: <20200420125559.GA4471@redhat.com>
References: <1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587276836-17088-1-git-send-email-jagdsh.linux@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 19, 2020 at 11:43:56AM +0530, jagdsh.linux@gmail.com escreveu:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Code cleanup: Remove duplicate headers which are included twice.

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> ---
>  tools/lib/perf/evlist.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 5b9f2ca..def5505 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -11,10 +11,8 @@
>  #include <internal/mmap.h>
>  #include <internal/cpumap.h>
>  #include <internal/threadmap.h>
> -#include <internal/xyarray.h>
>  #include <internal/lib.h>
>  #include <linux/zalloc.h>
> -#include <sys/ioctl.h>
>  #include <stdlib.h>
>  #include <errno.h>
>  #include <unistd.h>
> -- 
> 1.8.3.1

