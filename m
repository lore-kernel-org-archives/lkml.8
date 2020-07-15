Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23DE2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkTKJ6aj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGOVcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:32:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52035 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726670AbgGOVcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594848774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cn1SaLSQDstiuAexdYduLBKyM4+JRq+aaTbG/223jGk=;
        b=dkTKJ6ajvmetaFTdmDGtluvnnPwAXnOGt2SSzdvSV0tWyrwsdTECTXWnytHfbZ5ezacq9F
        3HujWAV5arxxi/IfmH5RxSEkGwqg5yfaz19xNpBR880d+weMyHp4w7rs3ccoGwm+a5z64b
        vobBWVQ+zTu+RQ+pOA6+QMrPabUJgE4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-qJjMikuUMN2bAQwFkmw12Q-1; Wed, 15 Jul 2020 17:32:50 -0400
X-MC-Unique: qJjMikuUMN2bAQwFkmw12Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3957680572E;
        Wed, 15 Jul 2020 21:32:48 +0000 (UTC)
Received: from krava (unknown [10.40.194.44])
        by smtp.corp.redhat.com (Postfix) with SMTP id 65127757DF;
        Wed, 15 Jul 2020 21:32:45 +0000 (UTC)
Date:   Wed, 15 Jul 2020 23:32:44 +0200
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
Subject: Re: [PATCH 18/18] perf metric: Rename group_list to list
Message-ID: <20200715213244.GU183694@krava>
References: <20200712132634.138901-1-jolsa@kernel.org>
 <20200712132634.138901-19-jolsa@kernel.org>
 <CAP-5=fW6OyM1UPZ0HmxjJbHTiag+mCAWd70WO+DJFtBTjsxFHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fW6OyM1UPZ0HmxjJbHTiag+mCAWd70WO+DJFtBTjsxFHg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 11:04:08AM -0700, Ian Rogers wrote:
> On Sun, Jul 12, 2020 at 6:27 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Following the previous change that rename egroup
> > to metric, there's no reason to call the list
> > 'group_list' anymore, renaming it to list.
> 
> List doesn't seem to be adding information beyond the data type. I
> would prefer something like metric_list as it gives a clue what's in
> the list. It's a shame we can't have templated lists, if we did then
> my data type argument would apply and so maybe output_list would add
> information. Probably to save space metric_list is best.

ok, will change to metric_list

thanks,
jirka

