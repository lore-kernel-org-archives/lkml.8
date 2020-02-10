Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6621C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C912080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ma6w1DXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBJUJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:09:13 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727121AbgBJUJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581365352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zefW9F6cB3PjlP2xIHsQltDrSp4Pn5FgnQMxBmPCTg4=;
        b=Ma6w1DXVoAXZonZhfW4Tq12yjqW1f03p3mNP7mZgMBrC1a213Ay0nEz5g4Q3T3BBi/nR8q
        ssM5OdNwCa9osOzjBxB2OTnR4ckwLm8Kng954x3lvBmpMzbOmyGrT+rV913ulfcg2A6Biw
        /qQToO3J7/sGL7lhsJKCmeVuU8cm/o0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-N4bxFSCuNXCOvtTBjrK68w-1; Mon, 10 Feb 2020 15:09:02 -0500
X-MC-Unique: N4bxFSCuNXCOvtTBjrK68w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 987181857342;
        Mon, 10 Feb 2020 20:09:00 +0000 (UTC)
Received: from krava (ovpn-204-37.brq.redhat.com [10.40.204.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3743E87B01;
        Mon, 10 Feb 2020 20:08:58 +0000 (UTC)
Date:   Mon, 10 Feb 2020 21:08:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCHv2 2/4] perf tools: Mark ksymbol dsos with kernel type
Message-ID: <20200210200847.GA36715@krava>
References: <20200210143218.24948-1-jolsa@kernel.org>
 <20200210143218.24948-3-jolsa@kernel.org>
 <20200210151759.GB25639@kernel.org>
 <20200210152537.GA28110@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210152537.GA28110@krava>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 04:25:37PM +0100, Jiri Olsa wrote:
> On Mon, Feb 10, 2020 at 12:17:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Feb 10, 2020 at 03:32:16PM +0100, Jiri Olsa escreveu:
> > > We add ksymbol map into machine->kmaps, so it needs to be
> > > created as 'struct kmap', which is dependent on its dso
> > > having kernel type.
> > > 
> > > Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/machine.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > > index e3e5490f6de5..0a43dc83d7b2 100644
> > > --- a/tools/perf/util/machine.c
> > > +++ b/tools/perf/util/machine.c
> > > @@ -727,8 +727,14 @@ static int machine__process_ksymbol_register(struct machine *machine,
> > >  	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
> > >  
> > >  	if (!map) {
> > > -		map = dso__new_map(event->ksymbol.name);
> > > -		if (!map)
> > > +		struct dso *dso = dso__new(event->ksymbol.name);
> > > +
> > > +		if (dso) {
> > > +			dso->kernel = DSO_TYPE_KERNEL;
> > > +			map = map__new2(0, dso);
> > > +		}
> > > +
> > > +		if (!dso || !map)
> > 
> > We leak dso if map creation fails?
> 
> yep :-\ will post v2

v2 attached, it's also all in my perf/top branch

thanks,
jirka


---
We add ksymbol map into machine->kmaps, so it needs to be
created as 'struct kmap', which is dependent on its dso
having kernel type.

Reported-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index e3e5490f6de5..0ad026561c7f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -727,9 +727,17 @@ static int machine__process_ksymbol_register(struct machine *machine,
 	struct map *map = maps__find(&machine->kmaps, event->ksymbol.addr);
 
 	if (!map) {
-		map = dso__new_map(event->ksymbol.name);
-		if (!map)
+		struct dso *dso = dso__new(event->ksymbol.name);
+
+		if (dso) {
+			dso->kernel = DSO_TYPE_KERNEL;
+			map = map__new2(0, dso);
+		}
+
+		if (!dso || !map) {
+			dso__put(dso);
 			return -ENOMEM;
+		}
 
 		map->start = event->ksymbol.addr;
 		map->end = map->start + event->ksymbol.len;
-- 
2.24.1

