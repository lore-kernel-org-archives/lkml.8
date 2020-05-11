Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A27C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A34620801
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zzh+rRGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbgEKLB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:01:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728136AbgEKLB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589194916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/wxVoTSctGeT+2x6Wq8s20j7ese2p9h/0eegbNP4kOM=;
        b=Zzh+rRGDjqoPEUtl17VxGlZQ88UVdUqaXOEAHURT4xJ9y96fax/f08h45oCF7acW1s5RlP
        qX5nCSt4227jqi/3MPce4ogpcK3xGCBFL8nyX7FMJrbAovM0cWga7y1nDr3m2/c9smhOfd
        hQQ2caQNs+3tZUj3HpUlW1jb6ZPx8AU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Db2IzRKJPYKnYViZoazu_A-1; Mon, 11 May 2020 07:01:53 -0400
X-MC-Unique: Db2IzRKJPYKnYViZoazu_A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BBDB61899520;
        Mon, 11 May 2020 11:01:50 +0000 (UTC)
Received: from krava (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3F2486C77D;
        Mon, 11 May 2020 11:01:47 +0000 (UTC)
Date:   Mon, 11 May 2020 13:01:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        qiangqing.zhang@nxp.com, irogers@google.com, robin.murphy@arm.com,
        zhangshaokun@hisilicon.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC v3 02/12] perf jevents: Add support for system events
 tables
Message-ID: <20200511110146.GD2986380@krava>
References: <1588852671-61996-1-git-send-email-john.garry@huawei.com>
 <1588852671-61996-3-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588852671-61996-3-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 07:57:41PM +0800, John Garry wrote:

SNIP

>  
> +static int process_system_event_tables(FILE *outfp)
> +{
> +	struct sys_event_table *sys_event_table;
> +
> +	fprintf(outfp, "struct pmu_sys_events pmu_sys_event_tables[] = {");
> +
> +	list_for_each_entry(sys_event_table, &sys_event_tables, list) {
> +		fprintf(outfp, "\n\t{\n\t\t.table = %s,\n\t},",
> +			sys_event_table->name);
> +	}
> +	fprintf(outfp, "\n\t{\n\t\t.table = 0\n\t},");

this will add extra tabs:

        {
                .table = 0
        },

while the rest of the file starts items without any indent

jirka

