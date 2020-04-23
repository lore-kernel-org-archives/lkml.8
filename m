Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1618DC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7EAE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONKOeG7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDWItw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgDWItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:49:51 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DFC08C5F2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:49:51 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id y19so2465962qvv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qo//qD9OD7T8B6dTROYouIyhkWIPZhIPm7QvQRgaKxs=;
        b=ONKOeG7TEeoKoqQp6fjmJ4mPUW+Oe6+vHAU0iZy8grh9BjjfDr2FzSOYKN2t+4SWOH
         UZGxyOzt6xeStIAbFvUtOSZV6LvLEYZbZedmP69vLrmdaybkwhxEFDygJxxtTirJ4m1n
         udmu4ZoGccPoUFi0jCkWJ0U0785GTiTZHqt/uMHxXg2ucqu1Brc+zPMIi5I29KAGHMaT
         Oxs1nNDn0C7lB7e8uAl4iKfNuvZkx83SIzjRPONAlQ0lyGE/9jtZzbdgwbbp8sJhjUeD
         nGGZb/UuijJT9sSotxOGScYcbSoNCAO9Bjp5995/ZHcOXhwJpTGLSMdRk99STmOBPqbx
         EQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qo//qD9OD7T8B6dTROYouIyhkWIPZhIPm7QvQRgaKxs=;
        b=L/FLA6G0LIHCFWrwNESuxwDGJHQnYvYQ8N6gdxB3cR90ZTixqOnlu7UVC0haeyxIlx
         uHaGwVR4X2G/JHTDwRMO7GGwyMlm6wgKSnfNvR2f5zjxJyImF1h4ZM8ea7ALSCv7pN5d
         SbwEk7xN8XQ/ZyGG2H8yQgymZkNdnuJJJbsoi4T7cER8oAspnOKn7nPIKGFnllgFdlBa
         AqadQE6XHziSJbswrMLa4n607RP9Cj6rQ1EFRVdSrV6YabsH874l1vS6GPNF0Ky0fVl2
         8jCsYaeaxN9cbR00HDw2Z6sYk2YkCKoHvfqplptuICwha+kdGd3ZUy6adas/wq+sMnPu
         ezhw==
X-Gm-Message-State: AGi0PuZCF6pVZ2zq4CFap9PoehRID5oyPAQ/7EljK88EMQlMGkk8Hgq/
        m9sdKAxm1B0WTwUeWGOdafOUo6D00U1b83N+CS1PRg==
X-Google-Smtp-Source: APiQypKVoLZ8h/psAn10+YfLXqmNMJ1C8QLjnL9+KZDS7lrDkmiQbibD/cl+DIHUKw4ejfisYtEEwehjctNek3XcsSU=
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr3124690qvl.34.1587631790155;
 Thu, 23 Apr 2020 01:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+ZuGaeyyVsCkqJRo4+0hoMP8Eq_JTuU0L-NFqTrQP_czA@mail.gmail.com>
 <36C7F018-510E-4555-BC6B-42DEB0468CBA@lca.pw>
In-Reply-To: <36C7F018-510E-4555-BC6B-42DEB0468CBA@lca.pw>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 23 Apr 2020 10:49:38 +0200
Message-ID: <CACT4Y+a4NvM3K4auifUHsVM8POTAyhyTCbs6SW6AY27cOsuSMw@mail.gmail.com>
Subject: Re: linux-next test error: WARNING: suspicious RCU usage in ipmr_device_event
To:     Qian Cai <cai@lca.pw>
Cc:     syzbot <syzbot+21f82f61c24a7295edf5@syzkaller.appspotmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 1:21 PM Qian Cai <cai@lca.pw> wrote:
> > On Apr 21, 2020, at 6:51 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > +linux-next, Stephen for a new linux-next breakage
>
> I don=E2=80=99t know why you keep sending the same thing over and over ag=
ain where I replied you just two days ago for the same thing.

Well, formally this bug was never mailed. The other one is about
"WARNING: suspicious RCU usage in ovs_ct_exit". It just happened that
this "WARNING: suspicious RCU usage in ipmr_device_event" was appended
to that one (because kernel somehow failed to respect panic_on_warn?).
But warnings except the first one are ignored, frequently they are
induced and it's not possible to track 2 different bugs at the same
time in a reasonable way anyway.

So effectively this is the first occurance of this bug (presumably the
fix for ovs_ct_exit has reached linux-next). First occurrence is
always mailed.

Now let's tell syzbot that this one is fixed as well:

#syz fix: ipmr: Fix RCU list debugging warning
