Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9BCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0DED206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LdBf5J1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgFIOQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:16:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34674 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728338AbgFIOQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591712214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVbTooBt4UUkS5UYs7zdbnUxyfMbXNuMElqnNvrjHoA=;
        b=LdBf5J1Sxe4DKl63+fNvwNimaGGlh5NmNB8xkPzwK4bABrtD93iDLyKBoJ7Nf/giIauACg
        mmcWQlLdx0NYiq5enPOpjaIS1xYjWbd8HYeV95hRb/LAw43Rm2qJMBmxk+DdQyeS+Uj6mt
        G/5qYAzMpi2VrP6zWb5jpBNrIvg3MrQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-ZhSurra8O_2w3QnNQbqLZQ-1; Tue, 09 Jun 2020 10:16:51 -0400
X-MC-Unique: ZhSurra8O_2w3QnNQbqLZQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF2BA464;
        Tue,  9 Jun 2020 14:16:50 +0000 (UTC)
Received: from sandy.ghostprotocols.net (unknown [10.3.128.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 690AF8202B;
        Tue,  9 Jun 2020 14:16:50 +0000 (UTC)
Received: by sandy.ghostprotocols.net (Postfix, from userid 1000)
        id 378671D1; Tue,  9 Jun 2020 11:16:47 -0300 (BRT)
Date:   Tue, 9 Jun 2020 11:16:47 -0300
From:   Arnaldo Carvalho de Melo <acme@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Subject: Re: [PATCH] perf headers: fix processing of pmu_mappings
Message-ID: <20200609141647.GA10172@redhat.com>
References: <20200608161805.65841-1-eranian@google.com>
 <CAP-5=fXmrbBqDj6udGJCLHF5ePERr1S5qTKGZZAUBC1EmA-8LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXmrbBqDj6udGJCLHF5ePERr1S5qTKGZZAUBC1EmA-8LQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 08, 2020 at 09:52:43AM -0700, Ian Rogers escreveu:
> On Mon, Jun 8, 2020 at 9:18 AM Stephane Eranian <eranian@google.com> wrote:
> > This patch fixes a bug in process_pmu_mappings() where the code
> > would not produce an env->pmu_mappings string that was easily parsable.
> > The function parses the PMU_MAPPING header information into a string
> > consisting of value:name pairs where value is the PMU type identifier
> > and name is the PMU name, e.g., 10:ibs_fetch. As it was, the code
> > was producing a truncated string with only the first pair showing
> > even though the rest was there but after the \0.
> > This patch fixes the problem byt adding a proper white space between
> > pairs and moving the \0 termination to the end. With this patch applied,
> > all pairs appear and are easily parsed.

> > Before:
> > 14:amd_iommu_1

> > After:
> > 14:amd_iommu_1 7:uprobe 5:breakpoint 10:amd_l3 19:amd_iommu_6 8:power 4:cpu 17:amd_iommu_4 15:amd_iommu_2 1:software 6:kprobe 13:amd_iommu_0 9:amd_df 20:amd_iommu_7 18:amd_iommu_5 2:tracepoint 21:msr 12:ibs_op 16:amd_iommu_3 11:ibs_fetch

Please check print_pmu_mappings() in tools/perf/util/header.c

Before your patch:

  [root@five ~]# perf report --header-only | grep "pmu mappings"
  # pmu mappings: amd_df = 8, software = 1, ibs_op = 11, ibs_fetch = 10, uprobe = 7, cpu = 4, amd_iommu_0 = 12, breakpoint = 5, amd_l3 = 9, tracepoint = 2, kprobe = 6, msr = 13
  [root@five ~]#

After your patch:

  [root@five ~]# perf report --header-only | grep "pmu mappings"
  # pmu mappings: amd_df 1:software 11:ibs_op 10:ibs_fetch 7:uprobe 4:cpu 12:amd_iommu_0 5:breakpoint 9:amd_l3 2:tracepoint 6:kprobe 13:msr = 8# pmu mappings: unable to read
  [root@five ~]# 

I think having it space separated, as you propose, is best, but haven't
checked if there are other cases that process ff->ph->env.pmu_mappings
and expect it to be \0 separated, like print_pmu_mappings().

Regards,

- Arnaldo

