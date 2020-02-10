Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE72C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8538E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K3Y3jgcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgBJMID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:08:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35208 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbgBJMIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:08:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581336481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K5X/P5cTna//QaVwWn9YAqQiAEG6LJsWV3uuBWQnAic=;
        b=K3Y3jgcJprrMlS6easp/m8ALh8lN6ijeCaJPxVJEz6bLgxNAy9sifu8sUz563iC8dLD7+x
        sQbF/RJDd2pF4u4pL+LT4bZIAPo/hn9dOy6o2wwsskiuqszeyAE2D3CZ6EuMLldxAZ2SiJ
        3Yo6crCjQYNUVpa8M62k6PBVBYrXjm4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-kNyM94vDMtW_ufBV_bQLrQ-1; Mon, 10 Feb 2020 07:07:57 -0500
X-MC-Unique: kNyM94vDMtW_ufBV_bQLrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E55107ACCC;
        Mon, 10 Feb 2020 12:07:54 +0000 (UTC)
Received: from krava (unknown [10.43.17.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EFFA95C1D4;
        Mon, 10 Feb 2020 12:07:51 +0000 (UTC)
Date:   Mon, 10 Feb 2020 13:07:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        james.clark@arm.com, zhangshaokun@hisilicon.com,
        robin.murphy@arm.com
Subject: Re: [PATCH RFC 3/7] perf jevents: Add support for a system events PMU
Message-ID: <20200210120749.GF1907700@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579876505-113251-4-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:35:01PM +0800, John Garry wrote:

SNIP

>  	- Set of 'PMU events tables' for all known CPUs in the architecture,
> @@ -83,11 +93,11 @@ NOTES:
>  	2. The 'pmu-events.h' has an extern declaration for the mapping table
>  	   and the generated 'pmu-events.c' defines this table.
>  
> -	3. _All_ known CPU tables for architecture are included in the perf
> -	   binary.
> +	3. _All_ known CPU and system tables for architecture are included in
> +	   the perf binary.
>  
> -At run time, perf determines the actual CPU it is running on, finds the
> -matching events table and builds aliases for those events. This allows
> +At run time, perf determines the actual CPU or system it is running on, finds
> +the matching events table and builds aliases for those events. This allows
>  users to specify events by their name:
>  
>  	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
> @@ -150,3 +160,18 @@ where:
>  
>  	i.e the three CPU models use the JSON files (i.e PMU events) listed
>  	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
> +
> +The mapfile_sys.csv format is slightly different, in that it contains a SYSID
> +instead of the CPUID:
> +
> +	Header line
> +	SYSID,Version,Dir/path/name,Type

can't we just add prefix to SYSID types? like:

	SYSID-HIP08,v1,hisilicon/hip08/sys,sys
	0x00000000480fd010,v1,hisilicon/hip08/cpu,core
	0x00000000500f0000,v1,ampere/emag,core

because the rest of the line is the same, right?

seems to me that having one mapfile type would be less confusing

jirka

