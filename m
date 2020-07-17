Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260FAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA42B20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CMZF3sTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgGQIdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:33:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38290 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725970AbgGQIdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594974817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n6HQ4cRfKiCj6MVs/01fSUjQjB0YRcJewpfMhE5xrqw=;
        b=CMZF3sTpM/qd2EhEroXqzA2yZOcTGEhucw8c4Z95QBO+8fZOCqq4979oPY3+l7c36UC9Hv
        82GQiJn0HzjGxvLVMoOcvUeyteDOt2xRjOXj+ggMgNDH0/CeiIKlA5OoaoYagBhcozrY2T
        26P3VR0B97MTynqYPSHrFnG09jlcb6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-sKrxrS3ONJuKpSRaoS_KVQ-1; Fri, 17 Jul 2020 04:33:33 -0400
X-MC-Unique: sKrxrS3ONJuKpSRaoS_KVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 619C1800464;
        Fri, 17 Jul 2020 08:33:31 +0000 (UTC)
Received: from krava (unknown [10.40.192.81])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1CC1E10013D7;
        Fri, 17 Jul 2020 08:33:28 +0000 (UTC)
Date:   Fri, 17 Jul 2020 10:33:28 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, len.brown@intel.com
Subject: Re: [PATCH 1/3] perf/x86/rapl: Fix missing psys sysfs attributes
Message-ID: <20200717083328.GA528602@krava>
References: <20200716151859.6854-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716151859.6854-1-rui.zhang@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:18:57PM +0800, Zhang Rui wrote:
> This fixes a problem introduced by
> commit 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
> that perf event sysfs attributes for psys RAPL domain are missing.
> 
> Fixes: 5fb5273a905c ("perf/x86/rapl: Use new MSR detection interface")
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> ---
>  arch/x86/events/rapl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 0f2bf59f4354..51ff9a3618c9 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -665,7 +665,7 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	&rapl_events_pkg_group,
>  	&rapl_events_ram_group,
>  	&rapl_events_gpu_group,
> -	&rapl_events_gpu_group,
> +	&rapl_events_psys_group,

I did copy & paste but did not change to psys :-\

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

>  	NULL,
>  };
>  
> -- 
> 2.17.1
> 

