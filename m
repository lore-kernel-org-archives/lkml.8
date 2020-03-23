Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3769C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B06D20714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 05:58:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ugUQ+yGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgCWF61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 01:58:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46977 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgCWF61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 01:58:27 -0400
Received: by mail-qk1-f196.google.com with SMTP id u4so2273575qkj.13
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 22:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AvPMLnaaQp5jiQnFy8j79lDeL85S2eJpDF4bBEQ7H5k=;
        b=ugUQ+yGaL0p1o6UW9RpqRggClsYXccqqSB8FplD5exKthFaSGIIM/bgCdB2mzcqEYV
         rdITpGe+oBPR5P1SiacQUztmoejS3s93zIlvhfO0woTNsQTyojw9/idWSLv9bJkBdC3+
         wdy3exjAspK7nQ1RZtj8NwwNEgC3RSwMeIkxtTjlUyq2Amwwtdc7kqlgCtcAsMWhtTcR
         PYaV1/JOX8XEAIgn49RnI1IsKyYT/ykRpJcb3z61Vpc38FjtywISV/mrRgEfxKkuLTBu
         RCZ9B6W03gW2S1x7f1y1AFwHaBJaCV91k5kr3D1OlfknszE1EroIHKpwBwd7489/vqAZ
         iE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AvPMLnaaQp5jiQnFy8j79lDeL85S2eJpDF4bBEQ7H5k=;
        b=scHR7r0ZIb+yzrcYZrtrjmeaSnuc/JFzlssHZnCb1i2qo94TKltxBbSUnH1s/K7D//
         8ORNjiGvGeXkbhqQpZy6EPmfrMc9Josgs9Ka3PBwluIp//KRWWyr/z0juRxi+0dgfIeh
         63IgEQlGT+Y1NJVjBYDd/8ZG0ZaojJEjTv1t4XccnuXY5GswNyA9rk5CDv7dW2SCcvxH
         xHTFX1DHMWeJt6ae76VIy7MZse5EynWlPqhOduZnEXLHLhzndRZxg2hT4ckJkDAwxOar
         mo9oqBObEXVq4loNRMPmlWL8bRb6ST4CdZj5oyTRyB87r7S5lkPJI2wQnx6LUnTBiXUF
         tANA==
X-Gm-Message-State: ANhLgQ3t20WK8dXMVXd4CfjAVxtZ3QEJwtVYSPno7By2uISJZEuxZw0z
        IY0pjGptKt8O+hC967L2O9Q0tGT60ISsKtSeI4k=
X-Google-Smtp-Source: ADFU+vsBWCsq7LemXTgsY9xAMRzKPXtMG8l3GWSVWCDNby+xGCjk3u8G4lK2lTtg/LTSdXLsaN0TJFhT5c2i65ZAksQ=
X-Received: by 2002:a37:8cc1:: with SMTP id o184mr1271395qkd.187.1584943106149;
 Sun, 22 Mar 2020 22:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <1584938972-7430-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584938972-7430-3-git-send-email-iamjoonsoo.kim@lge.com> <20200323052145.GD3039@MiWiFi-R3L-srv>
 <20200323054037.GI2987@MiWiFi-R3L-srv>
In-Reply-To: <20200323054037.GI2987@MiWiFi-R3L-srv>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 23 Mar 2020 14:58:15 +0900
Message-ID: <CAAmzW4O-c23H8ogAwhkM97GEeCKgxGtPx7v+csSTikEq7nH82A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] mm/page_alloc: integrate classzone_idx and high_zoneidx
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 23=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 2:40, B=
aoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > > diff --git a/include/trace/events/compaction.h b/include/trace/events=
/compaction.h
> > > index e5bf6ee..54e5bf0 100644
> > > --- a/include/trace/events/compaction.h
> > > +++ b/include/trace/events/compaction.h
> > > @@ -314,40 +314,44 @@ TRACE_EVENT(mm_compaction_kcompactd_sleep,
> > >
> > >  DECLARE_EVENT_CLASS(kcompactd_wake_template,
> > >
> > > -   TP_PROTO(int nid, int order, enum zone_type classzone_idx),
> > > +   TP_PROTO(int nid, int order, enum zone_type highest_zoneidx),
> > >
> > > -   TP_ARGS(nid, order, classzone_idx),
> > > +   TP_ARGS(nid, order, highest_zoneidx),
> > >
> > >     TP_STRUCT__entry(
> > >             __field(int, nid)
> > >             __field(int, order)
> > > -           __field(enum zone_type, classzone_idx)
> > > +           __field(enum zone_type, highest_zoneidx)
> > >     ),
> > >
> > >     TP_fast_assign(
> > >             __entry->nid =3D nid;
> > >             __entry->order =3D order;
> > > -           __entry->classzone_idx =3D classzone_idx;
> > > +           __entry->highest_zoneidx =3D highest_zoneidx;
> > >     ),
> > >
> > > +   /*
> > > +    * classzone_idx is previous name of the highest_zoneidx.
> > > +    * Reason not to change it is the ABI requirement of the tracepoi=
nt.
> > > +    */
> > >     TP_printk("nid=3D%d order=3D%d classzone_idx=3D%-8s",
> >                                  ~~~~~~~~~~ this one could be missed.
>
> Oh, I realized above 'classzone_idx=3D%-8s' being kept is for the old
> script compatibility? then it's OK.

Yes, this is for userspace compatibility. There are two places that aren't
changed due to compatibility and they are commented on top of the line.

Thanks.

> >
> > And I applied this patch series, use 'git grep classzone_idx' to search
> > any relics, found below classzone_idx leftover in perl script.
> > [~]$ git grep classzone_idx
> > Documentation/trace/postprocess/trace-vmscan-postprocess.pl:my $regex_l=
ru_isolate_default =3D 'isolate_mode=3D([0-9]*) classzone_idx=3D([0-9]*) or=
der=3D([0-9]*) nr_requested=3D([0-9]*) nr_scanned=3D([0-9]*) nr_skipped=3D(=
[0-9]*) nr_taken=3D([0-9]*) lru=3D([a-z_]*)';
> > Documentation/trace/postprocess/trace-vmscan-postprocess.pl:           =
         "isolate_mode", "classzone_idx", "order",
