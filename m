Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C31C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9909B206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLiYYjHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgA0QWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:22:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40969 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729600AbgA0QWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580142151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mCzUCbQMTrl/R+TaZnwQIFhM18cIX5gVoFVl9+pfdZA=;
        b=NLiYYjHNqh8nA0bxjyIsbtlZ4hnAzmV3SFM53RpnDOFHZblG7c/Mv8I3Z79RLwnIW63FDa
        fxv2dA0T9yixcVgls1lk6u/JGeNXrprYosxi0MI4L/ZPHHjmKOmkVnVpspSCvF/poJg75j
        aQBkFiN2W4+Fwxb0c4nQ1VbqGEMX/k0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-xQLkrrrcPjyLUUe_xoCY8Q-1; Mon, 27 Jan 2020 11:22:27 -0500
X-MC-Unique: xQLkrrrcPjyLUUe_xoCY8Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8BF318C0E04;
        Mon, 27 Jan 2020 16:22:26 +0000 (UTC)
Received: from krava (ovpn-205-125.brq.redhat.com [10.40.205.125])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 605F98702F;
        Mon, 27 Jan 2020 16:22:25 +0000 (UTC)
Date:   Mon, 27 Jan 2020 17:22:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
Message-ID: <20200127162222.GG1114818@krava>
References: <20200127100031.1368732-1-namhyung@kernel.org>
 <20200127111234.GA1114818@krava>
 <CAM9d7cimJi8V0PtWy=jLSdPrX0na5rLE2NfXTZtW56PdX=fj3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cimJi8V0PtWy=jLSdPrX0na5rLE2NfXTZtW56PdX=fj3Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:58:27PM +0900, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Mon, Jan 27, 2020 at 8:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Mon, Jan 27, 2020 at 07:00:31PM +0900, Namhyung Kim wrote:
> >
> > SNIP
> >
> > > -
> > > -     if (strlen(path) < maxlen) {
> > > -             strcpy(buf, path);
> > > -             return 0;
> > > -     }
> > > -     return -1;
> > > -}
> > > -
> > >  static int open_cgroup(const char *name)
> > >  {
> > >       char path[PATH_MAX + 1];
> > > @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
> > >       int fd;
> > >
> > >
> > > -     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> > > +     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
> >
> > nice, but could you please follow fs API names and change the
> > name to cgroupfs__mountpoint
> >
> > I think we don't need to define the rest of the functions now,
> > if they are not used
> >
> >         #define FS(name)                                \
> >                 const char *name##__mountpoint(void);   \
> >                 const char *name##__mount(void);        \
> >                 bool name##__configured(void);          \
> >
> > just follow the function name
> 
> I thought about it too, but still it has different arguments.
> So I left it as is... Do you really want to rename?

yea I think we should keep the same name, Arnaldo?

jirka

> 
> Thanks
> Namhyung
> 

