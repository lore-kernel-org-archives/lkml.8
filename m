Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23298C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E393420714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9Im2QR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCQQU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:20:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21717 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbgCQQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584462055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hr3pVOlJUq6wHuVCTKnwOlTcZibMgQuZS4Wu2Y9Ir3g=;
        b=Q9Im2QR3WIRX9fS0LdX3jYNmVM/lWG/OPsyIPCyd0TP8++vbMpjFuM/LTw7vbZ/pnKp4y/
        uXqeLEhyrkcwwenyi7JOTux2oylMe6qcw5FHxZC6tO7sGnD88IMMuFN4uN3DAAr2WElgec
        8Yn9jSoOxUa2Vatr1mLSPnsPNkQYsvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-AmXlN7qYP6u8SV4_EI_6-A-1; Tue, 17 Mar 2020 12:20:51 -0400
X-MC-Unique: AmXlN7qYP6u8SV4_EI_6-A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7352F1007274;
        Tue, 17 Mar 2020 16:20:49 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CC3473894;
        Tue, 17 Mar 2020 16:20:45 +0000 (UTC)
Date:   Tue, 17 Mar 2020 17:20:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 7/7] perf test: Test pmu-events aliases
Message-ID: <20200317162043.GC759708@krava>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-8-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584442939-8911-8-git-send-email-john.garry@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 07:02:19PM +0800, John Garry wrote:

SNIP

>  struct perf_pmu_test_event {
>  	struct pmu_event event;
> +
> +	/* extra events for aliases */
> +	const char *alias_str;
> +
> +	/*
> +	 * Note: For when PublicDescription does not exist in the JSON, we
> +	 * will have no long_desc in pmu_event.long_desc, but long_desc may
> +	 * be set in the alias.
> +	 */
> +	const char *alias_long_desc;
>  };
> +
>  static struct perf_pmu_test_event test_cpu_events[] = {
>  	{
>  		.event = {
> @@ -20,6 +31,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>  			.desc = "L1 BTB Correction",
>  			.topic = "branch",
>  		},
> +		.alias_str = "event=0x8a",
> +		.alias_long_desc = "L1 BTB Correction",
>  	},
>  	{
>  		.event = {
> @@ -28,6 +41,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>  			.desc = "L2 BTB Correction",
>  			.topic = "branch",
>  		},
> +		.alias_str = "event=0x8b",
> +		.alias_long_desc = "L2 BTB Correction",
>  	},
>  	{
>  		.event = {
> @@ -36,6 +51,8 @@ static struct perf_pmu_test_event test_cpu_events[] = {
>  			.desc = "Number of segment register loads",
>  			.topic = "other",
>  		},
> +		.alias_str = "umask=0x80,(null)=0x30d40,event=0x6",

ah so we are using other pmus because of the format definitions

why is there the '(null)' in there?

jirka

