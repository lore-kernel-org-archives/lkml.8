Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B604FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C338206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SEhJWQ57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgETHGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:06:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725998AbgETHGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589958358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12r6Pw0ocdRXl1n2t8Xeq4Bd0G+JXCXMNugfD9+yIIQ=;
        b=SEhJWQ57M4yP1ARlB3EaDU1MfxhZue82ltX8OAdyDjc9/JjaUlnuVpkOfreq70a5NmjhUR
        t7nt2YtQ0aJwVQKWTaavjPDXIrxdnq5/S4N6NM/+vw3w5Z63SXeqhwz4M6qMMEH8q8Kn5g
        7Ly+5gPFGKzuGs6b2DnZdOwErB0MwCI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-hp6Vo_v5MlSkVVNrj1qJlQ-1; Wed, 20 May 2020 03:05:57 -0400
X-MC-Unique: hp6Vo_v5MlSkVVNrj1qJlQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 536AD107ACF2;
        Wed, 20 May 2020 07:05:55 +0000 (UTC)
Received: from krava (unknown [10.40.194.155])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6F14F5D9CA;
        Wed, 20 May 2020 07:05:52 +0000 (UTC)
Date:   Wed, 20 May 2020 09:05:51 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     cj.chengjian@huawei.com, huawei.libin@huawei.com,
        xiexiuqi@huawei.com, mark.rutland@arm.com, guohanjun@huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        wangnan0@huawei.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bpf-loader: Add missing '*' for key_scan_pos
Message-ID: <20200520070551.GC110644@krava>
References: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520033216.48310-1-bobo.shaobowang@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 11:32:16AM +0800, Wang ShaoBo wrote:
> key_scan_pos is a pointer for getting scan position in
> bpf__obj_config_map() for each BPF map configuration term,
> but it's misused when error not happened.
> 
> Fixes: 066dacbf2a32 ("perf bpf: Add API to set values to map entries in a bpf object")
> Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
> ---
>  tools/perf/util/bpf-loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
> index 10c187b8b8ea..460056bc072c 100644
> --- a/tools/perf/util/bpf-loader.c
> +++ b/tools/perf/util/bpf-loader.c
> @@ -1225,7 +1225,7 @@ bpf__obj_config_map(struct bpf_object *obj,
>  out:
>  	free(map_name);
>  	if (!err)
> -		key_scan_pos += strlen(map_opt);
> +		*key_scan_pos += strlen(map_opt);

seems good, was there something failing because of this?

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  	return err;
>  }
>  
> -- 
> 2.17.1
> 

