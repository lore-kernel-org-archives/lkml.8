Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACB0C38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76AAD20781
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 02:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tyCqA5Wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgDUCOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 22:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUCOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 22:14:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D41C061A0E;
        Mon, 20 Apr 2020 19:14:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id e9so5845186iok.9;
        Mon, 20 Apr 2020 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ue82uDYWA62Hy59Wvk+2+qxFCKkQmMn/AGbB8RRC57I=;
        b=tyCqA5WbnRlAG1A0UEbtRMXCtwlCbvvBqUfyP/iw4MncAbCWHIEtQExSiFvOL65Qn4
         hjbMRds+nQeTSof2Lekw0gY96gefVlO/613LP61ywtYGcdaB3qHD2hmv48Bgj3Lbm/uE
         D7Y/j68rCMduqxPiwj80p7ISto7gqEjYpDu8L0bg3m31ygrEYrZA3pIYzctRoKZxxHew
         5qXNsA5B8KlZS3zzfE6RCq+R7wRZTaeGdxCHXWOWEAevfHZgyk41VRAWNgTuNbHN+QRr
         7jnf1UstgTC6qTgBkOzrWAEJbWvRTBAegJVIhdlV7HXDS3qr5IejnGWBu6wVk6/7QimB
         /jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ue82uDYWA62Hy59Wvk+2+qxFCKkQmMn/AGbB8RRC57I=;
        b=F/0C308sjQiJweZbPxfNAqJFmD6qC6eEPU58BG7gFSgX0+e9EJZQSFDAbbexipULJX
         H9AM1u2hRz8ARyPIzafazqQjniis2WqRgzo5amHZdi8pXtxAdtXdZPRqUa7hvsfP8PT5
         5yjfKFvFTEkI02xbMOsGZrV9AiULX9jU5jfL8qucybZw4w9t+ynR+tuvIoVIyxfJifgx
         EfjaNTojSydtp/y4YbvCmSSkZnJhf/BZahL5hmKC3lVO/0KxnqEuirHoX4RNJTR5kv/8
         U21v658mw53R41dXdv3SOMlYT1G1ah5zBO3kD4APsE80XDyujVJ5Is9gX+TfHtPWmQuY
         uxhw==
X-Gm-Message-State: AGi0PuaRPfJ2FU681qy9O/zPSBlEcWgFeFL8B7P/fwh294AUk2cJ3IfY
        +aORC38zn6TMrFcxPueiNYB6qsMlR+gNTVVKMMg=
X-Google-Smtp-Source: APiQypJwTvgHVt3MC3cyrtS/iRoUs1cJRDc1EoqUrFSy0YzEvzaX1lXUlInAMAF8I3JDra5peL0g2+GnpIBWAdwhPCo=
X-Received: by 2002:a5d:8b57:: with SMTP id c23mr18541347iot.161.1587435246122;
 Mon, 20 Apr 2020 19:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200417110723.12235-1-gmayyyha@gmail.com> <ad6ca41f601d4feb2c3bd2850aeab95c3187bf2d.camel@kernel.org>
In-Reply-To: <ad6ca41f601d4feb2c3bd2850aeab95c3187bf2d.camel@kernel.org>
From:   Yanhu Cao <gmayyyha@gmail.com>
Date:   Tue, 21 Apr 2020 10:13:55 +0800
Message-ID: <CAB9OAC1+E6Qs=hr0naT73MNQ5scKOck4vF2gzsCS=0fQMLvG8A@mail.gmail.com>
Subject: Re: [v3] ceph: if we are blacklisted, __do_request returns directly
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 8:16 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-04-17 at 19:07 +0800, Yanhu Cao wrote:
> > If we mount cephfs by the recover_session option,
> > __do_request can return directly until the client automatically reconnects.
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/mds_client.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 486f91f9685b..16ac5e5f7f79 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
> >
> >       put_request_session(req);
> >
> > +     if (mdsc->fsc->blacklisted &&
> > +         ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> > +             err = -EBLACKLISTED;
> > +             goto finish;
> > +     }
> > +
>
> Why check for CLEANRECOVER? If we're mounted with recover_session=no
> wouldn't we want to do the same thing here?
>
> Either way, it's still blacklisted. The only difference is that it won't
> attempt to automatically recover the session that way.

I think mds will clear the blacklist. In addition to loading cephfs
via recover_session=clean, I didn't find a location where
fsc->blacklisted is set to false. If the client has been blacklisted,
should it always be blacklisted (fsc->blacklisted=true)? Or is there
another way to set fsc->blacklised to false?

>
>
> >       mds = __choose_mds(mdsc, req, &random);
> >       if (mds < 0 ||
> >           ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
> --
> Jeff Layton <jlayton@kernel.org>
>
