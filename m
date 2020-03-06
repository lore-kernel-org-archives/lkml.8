Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38544C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1132084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KZE7cHlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCFIaL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:30:11 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725901AbgCFIaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:30:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583483409;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NdmOFAVJ4UxQ9026OKh0Ci3bPinGjUfiDaTeHKEZwfw=;
        b=KZE7cHlLMMWDnojGry9lFZVBW+qhk4KqzUM+Zw+0JrXxXKBOguAU/PPv/pSBpFLofGmnMD
        PmGj3oXt02sS9Hfbc0AutYf/mZcqyc86+viWPhelxx4rBNkWBjuvl+SgSy1q3Sui/CWjJ8
        FBBZDvLf2EarqxwqcIdHkYmFDiWkeLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-F-YbjSwUPpin8kEb0YeJtA-1; Fri, 06 Mar 2020 03:30:08 -0500
X-MC-Unique: F-YbjSwUPpin8kEb0YeJtA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7A6721937FC0;
        Fri,  6 Mar 2020 08:30:06 +0000 (UTC)
Received: from krava (ovpn-205-205.brq.redhat.com [10.40.205.205])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C5F187B2F;
        Fri,  6 Mar 2020 08:30:02 +0000 (UTC)
Date:   Fri, 6 Mar 2020 09:30:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, jolsa@kernel.org,
        meyerk@hpe.com, linux-kernel@vger.kernel.org, acme@kernel.org
Subject: Re: [PATCH] perf: Fix crash due to null pointer dereference when
 iterating cpu map
Message-ID: <20200306083000.GB248782@krava>
References: <1583405239-352868-1-git-send-email-zhe.he@windriver.com>
 <20200305152755.GA6958@redhat.com>
 <20200305183206.GA1454533@tassilo.jf.intel.com>
 <20200305195843.GA7262@redhat.com>
 <f5a7ff48-659a-bce1-2ad0-54f334c27379@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <f5a7ff48-659a-bce1-2ad0-54f334c27379@windriver.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 03:20:55PM +0800, He Zhe wrote:
>=20
>=20
> On 3/6/20 3:58 AM, Arnaldo Carvalho de Melo wrote:
> > Em Thu, Mar 05, 2020 at 10:32:06AM -0800, Andi Kleen escreveu:
> >> On Thu, Mar 05, 2020 at 12:27:55PM -0300, Arnaldo Carvalho de Melo w=
rote:
> >>> Em Thu, Mar 05, 2020 at 06:47:19PM +0800, zhe.he@windriver.com escr=
eveu:
> >>>> From: He Zhe <zhe.he@windriver.com>
> >>>>
> >>>> NULL pointer may be passed to perf_cpu_map__cpu and then cause the
> >>>> following crash.
> >>>>
> >>>> perf ftrace -G start_kernel ls
> >>>> failed to set tracing filters
> >>>> [  208.710716] perf[341]: segfault at 4 ip 00000000567c7c98
> >>>>                sp 00000000ff937ae0 error 4 in perf[56630000+1b2000=
]
> >>>> [  208.724778] Code: fc ff ff e8 aa 9b 01 00 8d b4 26 00 00 00 00 =
8d
> >>>>                      76 00 55 89 e5 83 ec 18 65 8b 0d 14 00 00 00 =
89
> >>>>                      4d f4 31 c9 8b 45 08 8b9
> >>>> Segmentation fault
> >>> I'm not being able to repro this here, what is the tree you are usi=
ng?
> >> I believe that's the same bug that Jann Horn reported recently for p=
erf trace.
> >> I thought the patch for that went in.
> > Ok, Zhe, that patch is at the end of this message, and it is in:
> >
> > [acme@five perf]$ git tag --contains cb71f7d43ece3d5a4f400f510c61b2ec=
7c9ce9a1 | grep ^v
> > v5.6-rc1
> > v5.6-rc2
> > v5.6-rc3
> > v5.6-rc4
> > [acme@five perf]$
> >
> > Can you try with that?
>=20
> Thanks, that does fix the issue I met.
>=20
> BTW, my change in perf_cpu_map__cpu can be used as a preventive check
> and the "1"=A0 in perf_cpu_map__cpu should be "0", and assigning a NULL=
 in

I agree, can't see why we had 1 in here.. must be connected to the dummy
map.. could you please double check with all the perf_cpu_map__nr usages
that the 0 will work as expected?

> perf_evlist__exit makes the clearing complete. So are they worth a new =
patch?

the rest of the hunks looks good as preventive checks

thanks,
jirka

