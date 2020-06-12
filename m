Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACA8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 455D720578
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyleD0Vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgFLIB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:01:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726262AbgFLIB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591948916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFV5q/tNv+oXc5JuBy2ztRIX+iFtdAsbYIzI6VMlHtM=;
        b=VyleD0Vz3hxhiNG4VGsuHodMhh/nTbSufH7l4/+Vf29+rfogYQBliW1TYpFROqFbF9RK2l
        V2YiI+pmjlcPOurlObiJUnVdHacxfOKvGpk5lSPGtyzhbDxh+NtkzowblqZ/V1TI4Mzd/9
        JsILQjIzmBCTeCPmNJhnmiYm/DpiwXo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-7q7saOrwPTe76YJ6u6_Xgg-1; Fri, 12 Jun 2020 04:01:53 -0400
X-MC-Unique: 7q7saOrwPTe76YJ6u6_Xgg-1
Received: by mail-lf1-f69.google.com with SMTP id j21so2385452lfg.18
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFV5q/tNv+oXc5JuBy2ztRIX+iFtdAsbYIzI6VMlHtM=;
        b=sbn0YZ4PuiGbJTFd1Gss33Y6355zNdDdbnEckng0LZmgeNDrzKNF9XM6vZyHhOUFhp
         Cij/zueeywqp/7UNO4057FX0C7RfqUoPBBohR8ODnNhHBwaFLfk1n+e8u+iy5XBXIP6X
         FXLthwBpt+9pjPkxtaLOfRkUFiAbbK3pHKSnvXhvjYoREauR3cdBJqDJzsGSMSSevEpV
         bnZUysQPm4+zegmWBLXjgwevKSS39s67zyhHMfzNi++f31numsoBqAY+r1W7DIUy2qPy
         mZH76ovIPCVIfQ5slIrJjT7L/qxnfV2mnd7zh6e4UR0yYLTt8129FzU5c/0NKkk9iK+v
         zhxg==
X-Gm-Message-State: AOAM530TN6UIdhZeyNo8KeQNoWOYqn7NFLsIAyLAh1gEkJ/1pqOoyn79
        Htq6CsuaQXVuTo6vot9BdRSVH+cmJ5pWfJZWtW+4bMQaK5ZF75f2vdOObAAhU9Ow48UujlsgrQI
        WMF+gLg5G5zQsA2ALF08zrPWInFtQ1oO8+Nvv9lFg
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr6205518ljo.123.1591948912217;
        Fri, 12 Jun 2020 01:01:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgPk3fFoP16ga9S+l/Fq6iJDO3J+vleOTImQgKQw9EjoBMbPNYFSQq3fvFAoYR9jqtbw6BD5CZoffhGjAp85c=
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr6205500ljo.123.1591948911907;
 Fri, 12 Jun 2020 01:01:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com>
 <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com> <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 12 Jun 2020 10:01:41 +0200
Message-ID: <CAFqZXNuVevzXLhCBujJKTPL+HBhOxkUv6a-J1NGY9BzTJ7aWCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Paul Moore <paul@paul-moore.com>
Cc:     Tom Rix <trix@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 11, 2020 at 6:41 PM Tom Rix <trix@redhat.com> wrote:
> > On 6/11/20 3:30 PM, Paul Moore wrote:
> > > On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
> > >> From: Tom Rix <trix@redhat.com>
> > >>
> > >> Clang static analysis reports this double free error
> > >>
> > >> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
> > >>         kfree(node->expr.nodes);
> > >>         ^~~~~~~~~~~~~~~~~~~~~~~
> > >>
> > >> When cond_read_node fails, it calls cond_node_destroy which frees the
> > >> node but does not poison the entry in the node list.  So when it
> > >> returns to its caller cond_read_list, cond_read_list deletes the
> > >> partial list.  The latest entry in the list will be deleted twice.
> > >>
> > >> So instead of freeing the node in cond_read_node, let list freeing in
> > >> code_read_list handle the freeing the problem node along with all of the
> > >> earlier nodes.
> > >>
> > >> Because cond_read_node no longer does any error handling, the goto's
> > >> the error case are redundant.  Instead just return the error code.
> > >>
> > >> Fixes a problem was introduced by commit
> > >>
> > >>   selinux: convert cond_list to array
> > >>
> > >> Signed-off-by: Tom Rix <trix@redhat.com>
> > >> ---
> > >>  security/selinux/ss/conditional.c | 11 +++--------
> > >>  1 file changed, 3 insertions(+), 8 deletions(-)
> > > Hi Tom,
> > >
> > > Thanks for the patch!  A few more notes, in no particular order:
> > >
> > > * There is no need to send a cover letter for just a single patch.
> > > Typically cover letters are reserved for large patchsets that require
> > > some additional explanation and/or instructions beyond the individual
> > > commit descriptions.
> >
> > I was doing this to carry the repo name and tag info.
> >
> > So how do folks know which repo and commit the change applies to ?
>
> We read your mind ;)
>
> Generally it's pretty obvious, and in the rare occasion when it isn't,
> we ask.  Most of the time you can deduce the destination repo by the
> files changed and the mailing lists on the To/CC line.  From there it
> is then just a matter of -next vs -stable and that is something that
> is usually sorted out based on the context of the patch, and if
> needed, a discussion on-list.

Yes, it is normally not necessary, but I wouldn't discourage people
from providing the info if they want to / are used to do that. It can
be really useful in some situations, especially in case of
cross-subsystem changes that are sent to many mailing lists. But of
course this information belongs either to the cover letter or in case
of single patches to the "informational" section between "---" and
"diff --git [...]".

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

