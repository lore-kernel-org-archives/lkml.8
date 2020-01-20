Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7575C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4082077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLUe6bgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgATJYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:24:01 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22821 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726039AbgATJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579512240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrHv7U16b0hpMhKonKhllashBRa3U27D9d/xyzuh1sY=;
        b=HLUe6bgCiU0E9krIr4sw+di2zGVpAXh7upPJknNUV3pabLHeUDVp6Q33xw7HvWqxC48cd+
        INtwvv9nKc11cflMd9iZn4Lu9umTVn14xo0ouyxDNXXW1gEbw3ylM4aYoLwJxNkqn2Wd/i
        iSde7h0MfMDijJMUw2FnXk3tQi5xomY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-bTPf7-FSNuyHvO3jE0m2VA-1; Mon, 20 Jan 2020 04:23:58 -0500
X-MC-Unique: bTPf7-FSNuyHvO3jE0m2VA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D594718A6EC0;
        Mon, 20 Jan 2020 09:23:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6854A84D9F;
        Mon, 20 Jan 2020 09:23:54 +0000 (UTC)
Date:   Mon, 20 Jan 2020 10:23:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kajoljain <kjain@linux.ibm.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
Message-ID: <20200120092352.GA608405@krava>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
 <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
 <822bcb9d-4c08-39c5-e6e7-9c3e20d77852@linux.ibm.com>
 <20200108160249.GD402774@krava>
 <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <dde66abd-6025-31e3-9bda-a6eb1986eea8@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 02:23:19PM +0530, kajoljain wrote:
>=20
> On 1/8/20 9:32 PM, Jiri Olsa wrote:
> > On Wed, Jan 08, 2020 at 02:41:35PM +0530, kajoljain wrote:
> >=20
> > SNIP
> >=20
> > > > > -=A0=A0=A0 int i =3D 0;
> > > > > +=A0=A0=A0 int i =3D 0, j =3D 0;
> > > > >  =A0=A0=A0=A0=A0 bool leader_found;
> > > > >  =A0 =A0=A0=A0=A0=A0 evlist__for_each_entry (perf_evlist, ev) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0 j++;
> > > > > +=A0=A0=A0=A0=A0=A0=A0 if (j <=3D iterator_perf_evlist)
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!strcmp(ev->name, ids[i])) {
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!metric_events[i])
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 metric_eve=
nts[i] =3D ev;
> > > > > @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struc=
t
> > > > > evlist *perf_evlist,
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > >  =A0=A0=A0=A0=A0 }
> > > > > +=A0=A0=A0 iterator_perf_evlist =3D j;
> > > > >  =A0 =A0=A0=A0=A0=A0 return metric_events[0];
> > > > >  =A0 }
> > > > >=20
> > > > Thanks for reporting and fixing this issue.
> > > >=20
> > > > I just have one question, do we really need a *static variable* t=
o track
> > > > the matched events? Perhaps using an input parameter?
> > > Hi Jin,
> > >=20
> > > The other way I come up with to solve this issue is, making change =
in
> > > perf_evlist itself by adding some flag in event name, to keep track=
 of
> > > matched events.
> > >=20
> > > As if we change event name itself, next time when we compare it won=
't
> > > matched. But in that case we need to remove those flag later. Which=
 will
> > > increase the
> > >=20
> > > complexity. If you have any suggestions, please let me know.
> > we already keep evsel::cpu_iter for similar concept
> >=20
> > so I guess we could have some iterator_perf_evlist variable in evlist=
..
> > that is if we don't find other solution (other than static varable)
>=20
> Hi Jiri,
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0 Thanks for reviewing the patch. I checked 'evs=
el::cpu_iter'
> variable, I think it added recently and I am not able to find any simil=
ar
> kind of variable in
>=20
> =A0=A0=A0 =A0=A0=A0=A0 evlist. Please let me know if my understanding i=
s fine. Do you want
> me to add new variable in evlist itself or there is any other way possi=
ble.

please check Arnaldo's tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core

jirka

