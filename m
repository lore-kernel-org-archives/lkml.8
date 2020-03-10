Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B72C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266B221D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLOtJXj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbgCJSb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:31:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727588AbgCJSb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583865115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dJlX4LDcBzFdWvngwJvzTwhVKuVae1yG8vpkDvU+OQ8=;
        b=cLOtJXj+bYI95ngwsqqhjyZs9AFTqgC5wN7VCJwJl2NdP23/xanpTBjc9W4wmVbz/+8Wr3
        ni6se94CmMAuJBYN7QnTyXPJFdLtHyCOcftx4fqjDIj7pDJMDgsteQhKkkr1YkPt5IWFYE
        REmSwBwC88lao8BAyDR0ZChn/VivGns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-0j1lLHBCNWqPdafvCSTckw-1; Tue, 10 Mar 2020 14:31:54 -0400
X-MC-Unique: 0j1lLHBCNWqPdafvCSTckw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BA09100550D;
        Tue, 10 Mar 2020 18:31:51 +0000 (UTC)
Received: from krava (ovpn-204-223.brq.redhat.com [10.40.204.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A7DE360C87;
        Tue, 10 Mar 2020 18:31:44 +0000 (UTC)
Date:   Tue, 10 Mar 2020 19:31:38 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        mpe@ellerman.id.au, sukadev@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de
Subject: Re: [PATCH v4 0/8] powerpc/perf: Add json file metric support for
 the hv_24x7 socket/chip level events
Message-ID: <20200310183138.GB181091@krava>
References: <20200309062552.29911-1-kjain@linux.ibm.com>
 <20200309093506.GB67774@krava>
 <20200310181836.GA12036@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310181836.GA12036@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:18:36PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Mar 09, 2020 at 10:35:06AM +0100, Jiri Olsa escreveu:
> > On Mon, Mar 09, 2020 at 11:55:44AM +0530, Kajol Jain wrote:
> > > First patch of the patchset fix inconsistent results we are getting when
> > > we run multiple 24x7 events.
> > > 
> > > Patchset adds json file metric support for the hv_24x7 socket/chip level
> > > events. "hv_24x7" pmu interface events needs system dependent parameter
> > > like socket/chip/core. For example, hv_24x7 chip level events needs
> > > specific chip-id to which the data is requested should be added as part
> > > of pmu events.
> > > 
> > > So to enable JSON file support to "hv_24x7" interface, patchset expose
> > > total number of sockets and chips per-socket details in sysfs
> > > files (sockets, chips) under "/sys/devices/hv_24x7/interface/".
> > > 
> > > To get sockets and number of chips per sockets, patchset adds a rtas call
> > > with token "PROCESSOR_MODULE_INFO" to get these details. Patchset also
> > > handles partition migration case to re-init these system depended
> > > parameters by adding proper calls in post_mobility_fixup() (mobility.c).
> > > 
> > > Patch 6 & 8 of the patchset handles perf tool plumbing needed to replace
> > > the "?" character in the metric expression to proper value and hv_24x7
> > > json metric file for different Socket/chip resources.
> > > 
> > > Patch set also enable Hz/hz prinitg for --metric-only option to print
> > > metric data for bus frequency.
> > > 
> > > Applied and tested all these patches cleanly on top of jiri's flex changes
> > > with the changes done by Kan Liang for "Support metric group constraint"
> > > patchset and made required changes.
> > > 
> > > Changelog:
> > > v3 -> v4
> > > - Made changes suggested by jiri.
> > 
> > could you please mention them next time? ;-)
> > 
> > > - Apply these patch on top of Kan liang changes.
> > 
> > Arnaldo, could you please pull the expr flex changes and Kan's
> > metric group constraint changes? it's both prereq of this patchset
> 
> Both are now in my perf/core branch, will go upstream soon, should I go
> and pickup the perf tooling bits in this patchkit?

Kajol mentioned there are still some issues with the
global variable, I plan to check on it this week

thanks,
jirka

