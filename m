Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C85FAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B638208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 12:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599740595;
	bh=n/nYytuB1Q25l16PO534yoS6vNLUD0xrSYrjXKcSBTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VNCSGJ8jn0fqVxQOE4EJlZIEJGwsUjwWRcFseZ5n0nt+32Zm775p6MClIFLtT1sZN
	 FRNPXfv1+0AJHarHOww6/89ekFxQpOfFXyH8ShUGI5jVEyYrbq0CPaRB91cndrm5Te
	 2/BDbdyfDmImvPMksDI7cHmm4Z1u6a2cGQPNX2io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbgIJMXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 08:23:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730474AbgIJMUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:20:52 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5126A206A2;
        Thu, 10 Sep 2020 12:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599740450;
        bh=n/nYytuB1Q25l16PO534yoS6vNLUD0xrSYrjXKcSBTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I6dF2Wdx2QuguwnmDa6l9q/qdYqfncMSjCUJrEoD77LtQZptYekUr9rIqSbRPR/lY
         7ALXjDCnIEyXhxwwKY1mOUBUwE4oUCm35fMavvaUJmu4igodWuOBoEPuSYXvviJrFn
         4FsB/0jAn0NzN7rXyi8c/odw9zEHs3yYmq8XcF04=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 638B140D3D; Thu, 10 Sep 2020 09:20:48 -0300 (-03)
Date:   Thu, 10 Sep 2020 09:20:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, pc@us.ibm.com,
        namhyung@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        irogers@google.com, maddy@linux.ibm.com,
        ravi.bangoria@linux.ibm.com, john.garry@huawei.com
Subject: Re: [PATCH v9 0/5] powerpc/perf: Add json file support for hv_24x7
 core level events
Message-ID: <20200910122048.GD4018363@kernel.org>
References: <20200907064133.75090-1-kjain@linux.ibm.com>
 <20200907100529.GF1199773@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907100529.GF1199773@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 07, 2020 at 12:05:29PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 07, 2020 at 12:11:28PM +0530, Kajol Jain wrote:
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
> > aggregation like perchip/percore. It also adds new field 'AggregationMode'
> > to capture these terms.
> > Now, if user wants to add any new term, they just need to add it in
> > the enum defined.
> > 
> > This patchset also adds  changes of adding new structure
> > called 'json_event' inside jevents.c
> > file to improve the callback prototype inside jevent file.
> > Initially, whenever user want to add new field, they need to update
> > in all function callback which makes it more and more complex with
> > increased number of parmeters.
> > With this change, we just need to add it in new structure 'json_event'.
> > link to the RFC patch: https://lkml.org/lkml/2020/8/25/217
> > 
> > Changelog:
> > v8 -> v9
> > - Free aggr_mode memory [Jiri Olsa].
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo
