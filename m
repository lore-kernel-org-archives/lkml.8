Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D466C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 611A4206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hf+dzLq9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgGLS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:58:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59659 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729310AbgGLS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 14:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594580277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0mFf+rlScTdIpFz+8U33lgP+Xb7z56ppKAKQ7M9UFDY=;
        b=hf+dzLq94CCKJzROuUDNJNMEw37yI+j6JTvRsYfgKsKYTwcRLHUhSdJi1wm8IIroCI6Szt
        ZTkhlFQBmL6T//EW8IwBOQrAX9hw9Wl+/T6SHASZG0ACJxrFwPhpU6hSI+GGWWab81Yn5M
        FoDX0QThqLuGRahqrBI0KzICXZ8xzeY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-LLNkBiaVPpiB2q1BA-hWFQ-1; Sun, 12 Jul 2020 14:57:53 -0400
X-MC-Unique: LLNkBiaVPpiB2q1BA-hWFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55269100AA21;
        Sun, 12 Jul 2020 18:57:51 +0000 (UTC)
Received: from krava (unknown [10.40.192.24])
        by smtp.corp.redhat.com (Postfix) with SMTP id C69A02B6F0;
        Sun, 12 Jul 2020 18:57:47 +0000 (UTC)
Date:   Sun, 12 Jul 2020 20:57:46 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        maddy@linux.ibm.com, ravi.bangoria@linux.ibm.com,
        anju@linux.vnet.ibm.com, kan.liang@linux.intel.com,
        nasastry@in.ibm.com
Subject: Re: [RFC v2 0/5] tools/perf/pmu-events/jevents.c
Message-ID: <20200712185746.GD147742@krava>
References: <20200707122314.624400-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707122314.624400-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:53:09PM +0530, Kajol Jain wrote:
> Patchset enhance current runtime parameter support. It introduces new
> fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> used to specify perpkg events. 
> 
> The "PerCore" and "PerChip" specifies whether its core or chip events.
> Based on which we can decide which runtime parameter user want to
> access. Now character  '?' can refers different parameter based on user
> requirement.
> 
> Initially, every time we want to add new terms like chip, core, thread
> etc, we need to create corrsponding fields in pmu_events and event
> struct.
> This patchset adds an enum called 'aggr_mode_class' which store all these
> aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> to capture these terms.
> Now, if user wants to add any new term, they just need to add it in
> the enum defined. I try to test it with  my current setup.
> 
> I also need to replace PerPkg field to AggregationMode in all the
> x86 uncore json files. It will great if Andi and team can test it
> and let me know if they have any concerns.
> 
> Changelog:
> v1 -> v2:
> - Rather then adding new field as PerCore/PerChip, created a new enum
>   to get these fields. And new field as "AggregationMode" which can
>   be used to capture these fields from json file.

few nits, but generaly looks good to me

Andi,
are you ok with this change? not sure how bad is the
PerPkg -> AggregationMode json change for you

jirka

