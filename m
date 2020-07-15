Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D9DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FA422065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b41Y3YFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgGOVB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:01:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33319 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgGOVB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594846888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OH200y1oPX+RP3T1aRFymBiTupL+7e3hrQnJD2zNgsc=;
        b=b41Y3YFq3uZXMYFO77Vkw0sWIRQ3ypMdvSw0l4QumU6jDoYUVwl273GCLoKHUGhDXI0Jvj
        abynFDFQXQPUM7b+b4+OyWhHHlUkIpla736sOdNJ86+PEJe7kQvJYs1YxiJvAO1iJif/JG
        fkeQ/kAiuj7pD01GQjZXHaYUvbURC1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-i2Q5c5bhPJaSJSgVHjJDuA-1; Wed, 15 Jul 2020 17:01:26 -0400
X-MC-Unique: i2Q5c5bhPJaSJSgVHjJDuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0E6419067E0;
        Wed, 15 Jul 2020 21:01:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id EEE3C60C05;
        Wed, 15 Jul 2020 21:01:20 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:01:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 07/18] perf metric: Add add_metric function
Message-ID: <20200715210120.GQ183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-8-jolsa@kernel.org>
 <CAP-5=fUdSGvd9DYoFM5eGU8itjER=AYXcL33vDWDMTP3GZfZJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUdSGvd9DYoFM5eGU8itjER=AYXcL33vDWDMTP3GZfZJg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:11:02PM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Decouple metric adding login into add_metric function,
> 
> s/login/logging/ ?

ugh yes

> 
> > so it can be used from other places in following changes.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Acked-by: Ian Rogers <irogers@google.com>

thanks,
jirka

