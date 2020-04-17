Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2CFC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6B3B208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6pt2Ss9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbgDQLDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729468AbgDQLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:03:15 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA962C061A0C;
        Fri, 17 Apr 2020 04:03:13 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f19so1861065iog.5;
        Fri, 17 Apr 2020 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rKZ5LKH/jIP7y5LmXn/553OEG8Zghb9n8OmO/kJff2U=;
        b=c6pt2Ss9CBC8+Pfx/bjUQBRxDsNhm6dQB3PO97vCcmHRm3nJz56w8FLVUlCiz3cm3b
         M9NwFzcghXl8FGpyiPO7w/WzlnIS3FLWYu2pIjR5mFsseNqXutVBcdr3fEZVyWIGcOWb
         6NkpbR27MZAX8z1/yq/HslMGfufMTWQ/Dzuu47eXeW2T9fraG6JYY0ngSBuNxQGUniAA
         763hdxGucK5hqPG5t3Ssxz6O7ma08vXATyeRPJkaYANHqPX+K0I7i3s86SzMIdLHky0r
         M7hw8sD8Rs5hsKVlfDQfa5VcNuQhga8YopZQnYH30UTGl5nCWhfLhEM7MyEBhsdWuz7m
         0P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rKZ5LKH/jIP7y5LmXn/553OEG8Zghb9n8OmO/kJff2U=;
        b=flLhUKC8HNdRUlJ8sUmWOja563klYK0ccm4o4AH12jQQMs2V34pmslOaEf3MyA5vLK
         fKklhYMx+VQR5HuhM0BoRAJRjDBgz5cFKmc855CHAKOaauBrIcAma5Lc586/5jUtHjnT
         I9PdrEwB4VwpKJtNI6tivJTlwqIIxMIDzFjymXqrhyfmQz+WD8p4VHJjY5i/ThDuPYm+
         8eW9Y7npKVF7TAhMeLb2tY30GP+Gl5vBVTTadLDRHh2NoKulTIJU8fsa46ZhERc0Dh0M
         q7qDKKPrgMrgLOAhpljEq7ckAb35R9FjNg5t+btg6+F8talv7p1Xco9e/54Lf8eIWgMn
         zzcw==
X-Gm-Message-State: AGi0PuaB9au5+rIhJ497R8z7edc1J5qLAcqcwcD1Ks7SFi1k+GHv8XBK
        w9VTRyFbUu0xcA/NpLNPbaSnIlerMCdcOdIVDog=
X-Google-Smtp-Source: APiQypKanfBqnhFzrm37S2fgWgkzG7VGy9N+YbCbozwz26erK7mZnaUZrKH/bRnoX7+rE4uKxUbvplcaIqmZIdkmCKA=
X-Received: by 2002:a02:7785:: with SMTP id g127mr2681569jac.134.1587121393133;
 Fri, 17 Apr 2020 04:03:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200417093626.10892-1-gmayyyha@gmail.com> <faaf27530cafc9b00e81de58fb4ad153a1687622.camel@kernel.org>
In-Reply-To: <faaf27530cafc9b00e81de58fb4ad153a1687622.camel@kernel.org>
From:   Yanhu Cao <gmayyyha@gmail.com>
Date:   Fri, 17 Apr 2020 19:03:02 +0800
Message-ID: <CAB9OAC3++ALF3RPt=S9m2+DS8t=1obM70OdL9Uar=qKj_BhqPA@mail.gmail.com>
Subject: Re: [v2] ceph: if we are blacklisted, __do_request returns directly
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, patch the next commit.

On Fri, Apr 17, 2020 at 6:41 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Fri, 2020-04-17 at 17:36 +0800, Yanhu Cao wrote:
> > If we mount cephfs by the recover_session option,
> > __do_request can return directly until the client automatically reconnects.
> >
> > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > ---
> >  fs/ceph/mds_client.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> > index 486f91f9685b..e6cda256b136 100644
> > --- a/fs/ceph/mds_client.c
> > +++ b/fs/ceph/mds_client.c
> > @@ -2708,6 +2708,12 @@ static void __do_request(struct ceph_mds_client *mdsc,
> >
> >       put_request_session(req);
> >
> > +     if (mdsc->fsc->blacklisted &&
> > +         ceph_test_mount_opt(mdsc->fsc, CLEANRECOVER)) {
> > +             err = -EACCES;
> > +             goto finish;
> > +     }
> > +
> >       mds = __choose_mds(mdsc, req, &random);
> >       if (mds < 0 ||
> >           ceph_mdsmap_get_state(mdsc->mdsmap, mds) < CEPH_MDS_STATE_ACTIVE) {
>
> We do have an EBLACKLISTED error defined, which is the same as
> ESHUTDOWN. The read and write code can return that when the client is
> blacklisted. Same for cap handling (in __ceph_pool_perm_get. Should this
> return -EBLACKLISTED instead?
>
> --
> Jeff Layton <jlayton@kernel.org>
>
