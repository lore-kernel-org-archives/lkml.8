Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC0D206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8DC93i8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgBKOrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:47:05 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25834 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727511AbgBKOrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581432423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AREW9gFLm5gusZ2z//TUVRAYCVObZ/wwLl56roh1D+s=;
        b=b8DC93i80Cc65/ABHrrsK7lyUzpuxsaMdsSjtEJ7e/RR2Pw4n7iucpwrq/XuUf132Ni2LU
        R6V0BQC3EADo3p3/ENNJmQB/SbPV8NJ9msj1t8rXVtFP8fIIEvWKXfG32PU84A6MRfJ2tl
        jaR6XF9U/2WGWhO6JFVh3BtLjWI1Hew=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-JvW_ZqV2OTyZrIbkaNku0g-1; Tue, 11 Feb 2020 09:47:01 -0500
X-MC-Unique: JvW_ZqV2OTyZrIbkaNku0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5EB10054E3;
        Tue, 11 Feb 2020 14:46:58 +0000 (UTC)
Received: from krava (ovpn-206-93.brq.redhat.com [10.40.206.93])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47FE55C240;
        Tue, 11 Feb 2020 14:46:54 +0000 (UTC)
Date:   Tue, 11 Feb 2020 15:46:51 +0100
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
Message-ID: <20200211144651.GD93194@krava>
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
 <1579876505-113251-4-git-send-email-john.garry@huawei.com>
 <20200210120749.GF1907700@krava>
 <b148f0b6-d2ae-6520-8da1-7aed2c9e1d6b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b148f0b6-d2ae-6520-8da1-7aed2c9e1d6b@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 03:55:00PM +0000, John Garry wrote:
> On 10/02/2020 12:07, Jiri Olsa wrote:
> > On Fri, Jan 24, 2020 at 10:35:01PM +0800, John Garry wrote:
> > 
> > SNIP
> > 
> > >   	- Set of 'PMU events tables' for all known CPUs in the architecture,
> > > @@ -83,11 +93,11 @@ NOTES:
> > >   	2. The 'pmu-events.h' has an extern declaration for the mapping table
> > >   	   and the generated 'pmu-events.c' defines this table.
> > > -	3. _All_ known CPU tables for architecture are included in the perf
> > > -	   binary.
> > > +	3. _All_ known CPU and system tables for architecture are included in
> > > +	   the perf binary.
> > > -At run time, perf determines the actual CPU it is running on, finds the
> > > -matching events table and builds aliases for those events. This allows
> > > +At run time, perf determines the actual CPU or system it is running on, finds
> > > +the matching events table and builds aliases for those events. This allows
> > >   users to specify events by their name:
> > >   	$ perf stat -e pm_1plus_ppc_cmpl sleep 1
> > > @@ -150,3 +160,18 @@ where:
> > >   	i.e the three CPU models use the JSON files (i.e PMU events) listed
> > >   	in the directory 'tools/perf/pmu-events/arch/x86/silvermont'.
> > > +
> > > +The mapfile_sys.csv format is slightly different, in that it contains a SYSID
> > > +instead of the CPUID:
> > > +
> > > +	Header line
> > > +	SYSID,Version,Dir/path/name,Type
> > 
> 
> Hi jirka,
> 
> > can't we just add prefix to SYSID types? like:
> > 
> > 	SYSID-HIP08,v1,hisilicon/hip08/sys,sys
> > 	0x00000000480fd010,v1,hisilicon/hip08/cpu,core
> > 	0x00000000500f0000,v1,ampere/emag,core
> > 
> > because the rest of the line is the same, right?
> 
> I did consider that already. It should be workable.
> 
> > 
> > seems to me that having one mapfile type would be less confusing
> 
> I thought that having it all in a single file would be more confusing :)

hum, I think that if we keep it separated like:

	SYSID-HIP08,v1,hisilicon/hip08/sys,sys
	SYSID-krava,v1,hisilicon/krava/sys,sys
	0x00000000480fd010,v1,hisilicon/hip08/cpu,core
	0x00000000500f0000,v1,ampere/emag,core

then we should be fine.. not too many humans read that file anyway ;-)

jirka

