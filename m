Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA39FC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B62F420863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqZadlvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgBJUfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:35:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727120AbgBJUfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581366932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cbrjdh40dEpsDZqqW3INfvQLM26Cbx+DuwGT67kydb0=;
        b=TqZadlvYMp+pdUR+W3aOKfBdl1rBj57zJwukmUWVRs5A8iHoYDQv3jMYegH3MQinLkzhee
        ujbUJEBJg/Vvg4yjp+ayPOrIaacLrx0BnL2STbMtIPrWxgeE3w8Qu6gHWXxunkDRBgUtPD
        b9mitddedhtT3JzdevADQyWfHgFFdZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-RNYsaog-NBuUfTHpSfxIpA-1; Mon, 10 Feb 2020 15:35:28 -0500
X-MC-Unique: RNYsaog-NBuUfTHpSfxIpA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DCDDDB66;
        Mon, 10 Feb 2020 20:35:26 +0000 (UTC)
Received: from krava (ovpn-204-37.brq.redhat.com [10.40.204.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D09F5C1D6;
        Mon, 10 Feb 2020 20:35:21 +0000 (UTC)
Date:   Mon, 10 Feb 2020 21:35:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH 0/4] perf tools: Fix kmap handling
Message-ID: <20200210203518.GC36715@krava>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <7de7aa09-d59b-3e98-6289-d497aa0496d4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7de7aa09-d59b-3e98-6289-d497aa0496d4@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:47:11AM -0600, Kim Phillips wrote:
> On 2/10/20 8:32 AM, Jiri Olsa wrote:
> > hi,
> > Ravi Bangoria reported crash in perf top due to wrong kmap
> > objects management, this patchset should fix that.
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > Jiri Olsa (4):
> >       perf tools: Mark modules dsos with kernel type
> >       perf tools: Mark ksymbol dsos with kernel type
> >       perf tools: Fix map__clone for struct kmap
> >       perf tools: Move kmap::kmaps setup to maps__insert
> > 
> >  tools/perf/util/machine.c | 24 ++++++++++--------------
> >  tools/perf/util/map.c     | 17 ++++++++++++++++-
> >  2 files changed, 26 insertions(+), 15 deletions(-)
> > 
> 
> This series fixes a segmentation fault I was seeing on a
> couple of AMD systems, so:
> 
> Tested-by: Kim Phillips <kim.phillips@amd.com>

great, thanks a lot for testing

jirka

