Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1105FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E492068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hIsJrYHH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDUSxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:53:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbgDUSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587495185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2EGJfjTFggwaFFy3edNseI3v+h0M2XMOWbVl/ZbsKrg=;
        b=hIsJrYHHxti7kf9UktPgowQm//lJixXKWRZe70Umoi+y3AFUPOpsz7mDSlJSeKdQ8wUqYX
        3F4Camd8Uhx9xVC/dg0Nyh2RFILnpuEv/Nnz2PvBZnipV+/kPKn5eoHRK68D/UHjXQtIec
        sYn38zgHvGC56ASc4i2JGcRuFA7QdM4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-lqdHmYfsMniKTXzB82Q-Hw-1; Tue, 21 Apr 2020 14:53:01 -0400
X-MC-Unique: lqdHmYfsMniKTXzB82Q-Hw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A1F9107ACCC;
        Tue, 21 Apr 2020 18:52:59 +0000 (UTC)
Received: from krava (unknown [10.40.196.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9EF25C1D4;
        Tue, 21 Apr 2020 18:52:55 +0000 (UTC)
Date:   Tue, 21 Apr 2020 20:52:52 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 3/3] perf stat: Add --metrics-file option
Message-ID: <20200421185252.GA962614@krava>
References: <20200421181337.988681-1-jolsa@kernel.org>
 <20200421181337.988681-4-jolsa@kernel.org>
 <20200421183615.GD608746@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421183615.GD608746@tassilo.jf.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:36:15AM -0700, Andi Kleen wrote:
> > +--metrics-file file::
> > +Read metrics definitions from file in addition to compiled in metrics.
> > +
> 
> You would need to define the syntax and format. Perhaps in a separate
> man page.

I'm not sure it's worthy of new man page, but perhaps section in
perf-stat

> 
> Also there are some asserts that can be triggered by expressions. I think
> you should fix those too and convert them to errors.

do you have some details on this? examples of those failures?

thanks,
jirka

> 
> -Andi
> 

