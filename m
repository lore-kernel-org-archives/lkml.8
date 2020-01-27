Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA64A20716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580137121;
	bh=gxEaZ4KE6pzonk6bxlFEY0VpEsOeSKnJVv7VaNnLVkg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wRAijPp/ZkkmPvm0I+I54B+Kgz0vKnyK0898DKaXFrou3s/TTakq3NXFy4WI4brGA
	 wuCOrTl4IxD+bZT9o2pBryvJf11kRq6DW4Ff5zOqPlEk72uCoop6MlGhDWO1zWCu2Y
	 io1iJxeYeg7zpc5JzUC18GxLnSqIjiPYS5Zwb1+M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgA0O6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:58:40 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33369 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA0O6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:58:40 -0500
Received: by mail-wm1-f65.google.com with SMTP id m10so8741772wmc.0;
        Mon, 27 Jan 2020 06:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/FwNSt4/8vC5KfsfPGKzFax9QH8bqrtKi3O+OhMD0cY=;
        b=D/JThCWaliUF/sycgUIZ5cA7Ogm7ZxSjFthb2TbQTz/GBJdvsPJtpC1nBXDo8PIfpv
         o2dS7Rm1n4MWQI5Pwam6Fw8XUUOFcyB7WMWYcBnI+VqtgmqWojkRVh6W5+HqjsYDDstx
         UzcXyLqntBIye/bwF7bEvsSQomM/KilMY+HrJALk5uSJEhdeCvJlV+vCR0QWhDWTn3S1
         NfeiOUELvmND/wckPuImJ/fLCRUWx0BcQinvTRXQy2EMBybHdlvumfXOkL2NKRHLZ1En
         YBMyDHJx2Eb1V/toRQH/zf+v5YYi28+hnC9RatE7FGnLRY42nNjsodga/y+65xabdaVl
         Xqjg==
X-Gm-Message-State: APjAAAUT+qHaIoC3+m2lN4fLrovK0LPISpzkRByoBugRRMEI3iq0Vio7
        uE5jm2EVC/3gNYt/dG6ShMbNB0RWorTq1geu8Ls=
X-Google-Smtp-Source: APXvYqyN/ShG7knKaIA7fQGn+oAr1g2YMuZDwv88Pf5iKz1ihsZnAbd1u/bVB+bfTZ6VM9wqsd7qr54Nt9KYzIRhq9g=
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr14882474wmg.154.1580137118168;
 Mon, 27 Jan 2020 06:58:38 -0800 (PST)
MIME-Version: 1.0
References: <20200127100031.1368732-1-namhyung@kernel.org> <20200127111234.GA1114818@krava>
In-Reply-To: <20200127111234.GA1114818@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 27 Jan 2020 23:58:27 +0900
Message-ID: <CAM9d7cimJi8V0PtWy=jLSdPrX0na5rLE2NfXTZtW56PdX=fj3Q@mail.gmail.com>
Subject: Re: [PATCH] tools lib api fs: Move cgroupsfs_find_mountpoint()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Jan 27, 2020 at 8:12 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jan 27, 2020 at 07:00:31PM +0900, Namhyung Kim wrote:
>
> SNIP
>
> > -
> > -     if (strlen(path) < maxlen) {
> > -             strcpy(buf, path);
> > -             return 0;
> > -     }
> > -     return -1;
> > -}
> > -
> >  static int open_cgroup(const char *name)
> >  {
> >       char path[PATH_MAX + 1];
> > @@ -79,7 +20,7 @@ static int open_cgroup(const char *name)
> >       int fd;
> >
> >
> > -     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1))
> > +     if (cgroupfs_find_mountpoint(mnt, PATH_MAX + 1, "perf_event"))
>
> nice, but could you please follow fs API names and change the
> name to cgroupfs__mountpoint
>
> I think we don't need to define the rest of the functions now,
> if they are not used
>
>         #define FS(name)                                \
>                 const char *name##__mountpoint(void);   \
>                 const char *name##__mount(void);        \
>                 bool name##__configured(void);          \
>
> just follow the function name

I thought about it too, but still it has different arguments.
So I left it as is... Do you really want to rename?

Thanks
Namhyung
