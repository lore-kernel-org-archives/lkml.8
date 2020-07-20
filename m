Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31763C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F34AF22B51
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595273515;
	bh=bkBrfB1jkpHBom/xzf4N4YzJeQqGL33+njH20Eq8hy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ksBd30V+7zn+IWZVxvatx2RtbI5MVp3FjSXXWmgCB7lLE835lB3H6bScTaIECuTGi
	 jUPL7SCMI7NdjUw6ht6ipnu+g5U59utG2GEkc5FZlvw84XyetCkbnnCY4F1BPXZLRJ
	 NmsXO7ecNfmtrznz+4S+g8ElKu06TZShqnBLyNu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgGTTbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:31:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgGTTbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:31:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D84C207DF;
        Mon, 20 Jul 2020 19:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595273512;
        bh=bkBrfB1jkpHBom/xzf4N4YzJeQqGL33+njH20Eq8hy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZAXB66FLEnbI2/Dhx7bvUvkODcsV+RZghQFaETvcdwiB1KMBQB++GkvkU6ZnEDV41
         g/xdM9/9epo8kvbHpV4/+wZy+EmH5v8xiHHQgK1kdb7qqk1yf8YLvA8cAZjCmxiiw4
         Yob5ZLfAVOFJYETLaX3EF6VXYFlOiOh8rEF5W2j0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E8E3140482; Mon, 20 Jul 2020 16:31:49 -0300 (-03)
Date:   Mon, 20 Jul 2020 16:31:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, ak@linux.intel.com,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        namhyung@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, anju@linux.vnet.ibm.com,
        kan.liang@linux.intel.com, nasastry@in.ibm.com
Subject: Re: [PATCH v4 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200720193149.GA3906670@kernel.org>
References: <20200720070127.109234-1-kjain@linux.ibm.com>
 <20200720192133.GM760733@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720192133.GM760733@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 20, 2020 at 09:21:33PM +0200, Jiri Olsa escreveu:
> On Mon, Jul 20, 2020 at 12:31:22PM +0530, Kajol Jain wrote:
> > Patchset enhance current runtime parameter support. It introduces new
> > fields like "PerChip" and "PerCore" similar to the field "PerPkg" which is
> > used to specify perpkg events. 
> > 
> > The "PerCore" and "PerChip" specifies whether its core or chip events.
> > Based on which we can decide which runtime parameter user want to
> > access. Now character  '?' can refers different parameter based on user
> > requirement.
> > 
> > Initially, every time we want to add new terms like chip, core, thread
> > etc, we need to create corrsponding fields in pmu_events and event
> > struct.
> > This patchset adds an enum called 'aggr_mode_class' which store all these
> > aggregation like perpkg/percore. It also adds new field 'AggregationMode'
> > to capture these terms.
> > Now, if user wants to add any new term, they just need to add it in
> > the enum defined. I try to test it with  my current setup.
> > 
> > I also need to replace PerPkg field to AggregationMode in all the
> > x86 uncore json files. It will great if Andi and team can test it
> > and let me know if they have any concerns.
> > 
> > Changelog:
> > v3 -> v4:
> > - Include pmu-events.h header file in jevents.c and remove
> >   redecalaration of enum aggr_mode_class as Suggested by Jiri.
> > - Add Acked-by tag.
> 
> looks good to me, but still missing reaction from people maintaining
> intel's jsons

Yeah, since this is something trying to be generic enough to describe
events from different arches, we should not double-fail into
generalizing this :-\

- Arnaldo
