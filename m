Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB9C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37EE3206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EacWWQNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730998AbgGTTVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:21:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728324AbgGTTVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595272906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BTy7Vylm/2cgsocuaY+5SvdAm96/zyV/OFP3pz2O2Bk=;
        b=EacWWQNhg3ARanIpDJzoe+2eK/OQ942JjC+vzO4BHAHph/f0BLGXPA4NNxb4MR8/mzNVWq
        jCXe2aUKa0hl46ol3Bp9CFUzqKcu8KkZs+itvWAlaRz8BtxNiq7qQ88ZzFGrUlDIeBSP5a
        ncS2O6azs6IlnJyHir26J2wlccG7xWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-nvZCT-bmPvGnSnmldRUYDA-1; Mon, 20 Jul 2020 15:21:40 -0400
X-MC-Unique: nvZCT-bmPvGnSnmldRUYDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F3AE80183C;
        Mon, 20 Jul 2020 19:21:37 +0000 (UTC)
Received: from krava (unknown [10.40.194.11])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0744B5C1D4;
        Mon, 20 Jul 2020 19:21:33 +0000 (UTC)
Date:   Mon, 20 Jul 2020 21:21:33 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>, ak@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        pc@us.ibm.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com,
        kan.liang@linux.intel.com, nasastry@in.ibm.com
Subject: Re: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200720192133.GM760733@krava>
References: <20200720070127.109234-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720070127.109234-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:31:22PM +0530, Kajol Jain wrote:
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
> v3 -> v4:
> - Include pmu-events.h header file in jevents.c and remove
>   redecalaration of enum aggr_mode_class as Suggested by Jiri.
> - Add Acked-by tag.

looks good to me, but still missing reaction from people maintaining
intel's jsons

jirka

