Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F6C76199
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F2A92086A
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 20:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rp6fce5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgBPUWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 15:22:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52958 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbgBPUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 15:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581884527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sbT3FCffiIBi/DwGATrYZPj6EK1+jbLuMonpxYejB40=;
        b=Rp6fce5TQU2hIObIYqiqlERox6j/ywSu5Ht+sgZZn3KYm/ZF48IrIppf7HIl1NsExbc2Jt
        xCvM8sYiysFOWUFn4WQeVWZ1HN6FweI26HMEbdJiKnTCGRk3HNgAxgXgYBMTMul4teA13C
        IwZ/huVPeqyN9tCHPaAggGZEQz4snQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-guAgGHl2MxiS5RN3-k0Lzw-1; Sun, 16 Feb 2020 15:22:00 -0500
X-MC-Unique: guAgGHl2MxiS5RN3-k0Lzw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D821313E4;
        Sun, 16 Feb 2020 20:21:58 +0000 (UTC)
Received: from krava (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 750A319488;
        Sun, 16 Feb 2020 20:21:48 +0000 (UTC)
Date:   Sun, 16 Feb 2020 21:21:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Kajol Jain <kjain@linux.ibm.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH v4] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200216202143.GA145986@krava>
References: <20200212054102.9259-1-kjain@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212054102.9259-1-kjain@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:11:02AM +0530, Kajol Jain wrote:

SNIP

> =20
>  	return metric_events[0];
> @@ -160,6 +161,14 @@ static int metricgroup__setup_events(struct list_h=
ead *groups,
>  	int ret =3D 0;
>  	struct egroup *eg;
>  	struct evsel *evsel;
> +	bool *evlist_used;
> +
> +	evlist_used =3D (bool *)calloc(perf_evlist->core.nr_entries,
> +				     sizeof(bool));
> +	if (!evlist_used) {
> +		ret =3D -ENOMEM;
> +		break;

hum, how did this compile for you? ;-)

util/metricgroup.c: In function =E2=80=98metricgroup__setup_events=E2=80=99=
:
util/metricgroup.c:170:3: error: break statement not within loop or switc=
h
  170 |   break;


jirka

