Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E690C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 407AD24684
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ggsc+B01"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbgA1JWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:22:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725879AbgA1JV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580203319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwTFVytqzdZgGrLeXqDOeP41f1oDUcp+CON1Yhodcvg=;
        b=Ggsc+B01bliDxPQWaUwcSM5hT59Mt8NOAIthWC3mIooD6v3zbAYm1UmBTTZXxFkieXYMLV
        YoU6ak2tAHfP5IMhMp6ON1qqhKt1lsAJEKi6v/h/wOaXdUzmPHgNmt/nbnvh+eUeGdtqN9
        Ay5l5UCNaOoFXvwldpb3iDKtz3EufBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-Qpz8JNhjM2KIGk7ld4T5MA-1; Tue, 28 Jan 2020 04:21:57 -0500
X-MC-Unique: Qpz8JNhjM2KIGk7ld4T5MA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA86FDB61;
        Tue, 28 Jan 2020 09:21:55 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3E63860EB;
        Tue, 28 Jan 2020 09:21:53 +0000 (UTC)
Date:   Tue, 28 Jan 2020 10:21:51 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 3/4] perf util: Flexible to set block info output
 formats
Message-ID: <20200128092151.GA1209308@krava>
References: <20200115192904.16798-1-yao.jin@linux.intel.com>
 <20200115192904.16798-3-yao.jin@linux.intel.com>
 <20200120094737.GF608405@krava>
 <6c35864b-e396-6865-12a9-2fd001b0f567@linux.intel.com>
 <23bec83b-b55d-8e9f-5b74-f58f0cd4a618@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <23bec83b-b55d-8e9f-5b74-f58f0cd4a618@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 08:31:23PM +0800, Jin, Yao wrote:
>=20
>=20
> On 1/20/2020 11:00 PM, Jin, Yao wrote:
> >=20
> >=20
> > On 1/20/2020 5:47 PM, Jiri Olsa wrote:
> > > On Thu, Jan 16, 2020 at 03:29:03AM +0800, Jin Yao wrote:
> > >=20
> > > SNIP
> > >=20
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 block_hpp=
s, nr_hpps);
> > > > -=A0=A0=A0 perf_hpp_list__register_sort_field(&bh->block_list,
> > > > -=A0=A0=A0=A0=A0=A0=A0 &block_fmts[PERF_HPP_REPORT__BLOCK_TOTAL_C=
YCLES_PCT].fmt);
> > > > +=A0=A0=A0 /* Sort by the first fmt */
> > > > +=A0=A0=A0 perf_hpp_list__register_sort_field(&bh->block_list,
> > > > &block_fmts[0].fmt);
> > > > =A0 }
> > > > -static void process_block_report(struct hists *hists,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct block_re=
port *block_report,
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u64 total_cycle=
s)
> > > > +static int process_block_report(struct hists *hists,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct block_repor=
t *block_report,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 u64 total_cycles, =
int *block_hpps,
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int nr_hpps)
> > > > =A0 {
> > > > =A0=A0=A0=A0=A0 struct rb_node *next =3D rb_first_cached(&hists->=
entries);
> > > > =A0=A0=A0=A0=A0 struct block_hist *bh =3D &block_report->hist;
> > > > =A0=A0=A0=A0=A0 struct hist_entry *he;
> > > > -=A0=A0=A0 init_block_hist(bh, block_report->fmts);
> > > > +=A0=A0=A0 if (nr_hpps > PERF_HPP_REPORT__BLOCK_MAX_INDEX)
> > >=20
> > > hum, should be '>=3D' above.. ?
> > >=20
> > > jirka
> > >=20
> >=20
> > '=3D' should be OK.
> >=20
> > enum {
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_RANGE,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_DSO,
> >  =A0=A0=A0=A0PERF_HPP_REPORT__BLOCK_MAX_INDEX
> > };
> >=20
> > PERF_HPP_REPORT__BLOCK_MAX_INDEX is 6.
> >=20
> > If nr_hpps is 6, for example, block_hpps[] is,
> >=20
> >  =A0=A0=A0=A0=A0=A0=A0 int block_hpps[6] =3D {
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_TOTAL_CYCLE=
S_PCT,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_LBR_CYCLES,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_CYCLES_PCT,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_AVG_CYCLES,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_RANGE,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PERF_HPP_REPORT__BLOCK_DSO,
> >  =A0=A0=A0=A0=A0=A0=A0 };
> >=20
> >  =A0=A0=A0=A0=A0=A0=A0 block_info__create_report(session->evlist,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rep-=
>total_cycles,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 block_hpps, 6,
> >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &rep->nr_block_rep=
orts);
> >=20
> > That should be legal.
> >=20
> > Thanks
> > Jin Yao
>=20
> Hi Jiri,
>=20
> Does this explanation make sense?

ok, make sense

thanks,
jirka

