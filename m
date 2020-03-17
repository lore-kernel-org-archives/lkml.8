Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D134C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5307420714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iVlGe0eQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgCQRHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:07:05 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30361 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbgCQRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584464822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DtMQ752kWSoLyMfx0zJhLWBQJ+KAxziM+SQA+3+EK0c=;
        b=iVlGe0eQCH+p3R6NwSfYwhxCY1xGBHAiVs/o9IAGiRqGdfhFGVNv8MwCqpbchz917a9Z8z
        VstHosjmSozvUEGtSIdhDHIfnp314XK5ridaoEs7vN5sHcLcGiMEyxhUAfqZOWK2INAwrX
        yLTY6B2t+9y6GPshbrIaOsW5TRu8W5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-Hao-DTm-M8msT4ZUSzaqiA-1; Tue, 17 Mar 2020 13:06:58 -0400
X-MC-Unique: Hao-DTm-M8msT4ZUSzaqiA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 321ED107ACCA;
        Tue, 17 Mar 2020 17:06:54 +0000 (UTC)
Received: from krava (unknown [10.40.195.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1969D9B918;
        Tue, 17 Mar 2020 17:06:47 +0000 (UTC)
Date:   Tue, 17 Mar 2020 18:06:45 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        james.clark@arm.com, qiangqing.zhang@nxp.com
Subject: Re: [PATCH v2 2/7] perf jevents: Support test events folder
Message-ID: <20200317170645.GE759708@krava>
References: <1584442939-8911-1-git-send-email-john.garry@huawei.com>
 <1584442939-8911-3-git-send-email-john.garry@huawei.com>
 <20200317162052.GD759708@krava>
 <de5b58ee-980e-973a-16db-73f23c3edfef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <de5b58ee-980e-973a-16db-73f23c3edfef@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:25:32PM +0000, John Garry wrote:
> On 17/03/2020 16:20, Jiri Olsa wrote:
> > On Tue, Mar 17, 2020 at 07:02:14PM +0800, John Garry wrote:
> > > With the goal of supporting pmu-events test case, introduce support=
 for a
> > > test events folder.
> > >=20
> > > These test events can be used for testing generation of pmu-event t=
ables
> > > and alias creation for any arch.
> > >=20
> > > When running the pmu-events test case, these test events will be us=
ed
> > > as the platform-agnostic events, so aliases can be created per-PMU =
and
> > > validated against known expected values.
> > >=20
> > > To support the test events, add a "testcpu" entry in pmu_events_map=
[].
> > > The pmu-events test will be able to lookup the events map for "test=
cpu",
> > > to verify the generated tables against expected values.
> > >=20
> > > The resultant generated pmu-events.c will now look like the followi=
ng:
> >=20
> > can't compile this one:
> >=20
> >    HOSTCC   pmu-events/jevents.o
> > pmu-events/jevents.c: In function =E2=80=98main=E2=80=99:
> > pmu-events/jevents.c:1195:3: error: =E2=80=98ret=E2=80=99 undeclared =
(first use in this function)
> >   1195 |   ret =3D 1;
> >        |   ^~~
> > pmu-events/jevents.c:1195:3: note: each undeclared identifier is repo=
rted only once for each function it appears in
> > pmu-events/jevents.c:1196:3: error: label =E2=80=98out_free_mapfile=E2=
=80=99 used but not defined
> >   1196 |   goto out_free_mapfile;
> >        |   ^~~~
> > mv: cannot stat 'pmu-events/.jevents.o.tmp': No such file or director=
y
> > make[3]: *** [/home/jolsa/kernel/linux-perf/tools/build/Makefile.buil=
d:97: pmu-events/jevents.o] Error 1
> > make[2]: *** [Makefile.perf:619: pmu-events/jevents-in.o] Error 2
> > make[1]: *** [Makefile.perf:225: sub-make] Error 2
> > make: *** [Makefile:70: all] Error 2
>=20
> Hi jirka,
>=20
> What baseline are you using? I used v5.6-rc6. The patches are here:

I applied your patches on Arnaldo's perf/core

>=20
> https://github.com/hisilicon/kernel-dev/commits/private-topic-perf-5.6-=
pmu-events-test-upstream-v2

ok, will check

jirka

