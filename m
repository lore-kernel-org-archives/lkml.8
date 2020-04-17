Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1918AC38A29
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3342221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 22:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="hw60FApB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgDQWTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 18:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728587AbgDQWTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 18:19:21 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4FCC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:19:20 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w4so2603720edv.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 15:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W8Gwda6aJagQ951htxX1UFCzfkSdxr3HJlytQNZ7BG0=;
        b=hw60FApBl0ej+c0ZefeOnuQVfEuhSP+fB30PNrG5RjlKIRKuzXjHydC+fcT5/l48Ea
         xzzz3oqwmdQqAdJVGTVYDzL6wtTJwxdWSXP9RKOcRH7RHkhtegJge9262cKCimRcan+X
         MYo0z7YtN9icpkaCuDEKRSJUHojP+t2Rcp0XD4yu9EVq/2EZh0lEeLW1v9h7Qs9kmzxl
         nWdLz9k8lHu5Nz3edokz7GG+6ttEva33xSc5BZy9GHLZintvDi8U5um8vuN4xCRuqlLq
         ag8pxGKIirk4tCoR4tp/n6wIZqwX//RkLfxKkInKA6TwkRpeYCkuB1ckn/R9faWpO3xY
         efbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W8Gwda6aJagQ951htxX1UFCzfkSdxr3HJlytQNZ7BG0=;
        b=KYJ9aF+2cUX6DsMx7ngFhNMB8mBFGGkwKbXWzXrsgR8/SD04YObbKPYVrSBnNaGq7V
         uzpssqHxIIFIECV2OJ94LJ0hjVfWPp1w1tUCQTaeploN0Srxo2cLpxQWsJuHS5HaDKKU
         9FXhjXFyc70t2qZFvGigq5Evn0Rch9XFok03arFVmDdILOA1PDjmadO3N+AkGqRDEAbe
         QY1OOiZXLAWPHXd5dIO8SN5T0yiFcxiIsQxCBV3FONU2DevETyDSQOD3dc//jI47C3+8
         i4HmOVcIft7iPWSVvxuo9i9Qufcqcf1efnMW8j2BDB+6xcWYuO2VY3BJgf/9PKSAFwIo
         jO+Q==
X-Gm-Message-State: AGi0PuZMRXsTL+4EBKgSb/T5xv6yA0u8ubXARvU7vMAXqmtoGiZVgz39
        FUq7jH+S4YSBsCKUydeIP5kFOUGRs3FnKgGW1U/s
X-Google-Smtp-Source: APiQypKl/tfHK9jHI/GBf28NGrFcg5tn9HvmP2XPnIPytRpWNK1hjfLIGKjX4Ue222ygpwS3+sj0iKDM7sxcH/3cdT4=
X-Received: by 2002:aa7:c401:: with SMTP id j1mr5071836edq.31.1587161959380;
 Fri, 17 Apr 2020 15:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <82d85f72416560c155031375fb5b32ac06394c31.1584033222.git.rgb@redhat.com>
 <CAHC9VhRqytBECZ+bgo_OXavbRmPKEu0OOqS=xe=FQFhG+Qv=oA@mail.gmail.com> <20200417213423.leermiriy4jzgwf4@madcap2.tricolour.ca>
In-Reply-To: <20200417213423.leermiriy4jzgwf4@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 17 Apr 2020 18:19:07 -0400
Message-ID: <CAHC9VhRy9krH8gxMHX1qpHLNR7De0KyouOrAvEzGKYkr8r2B0g@mail.gmail.com>
Subject: Re: [PATCH ghak28 V7] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 5:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-04-17 17:18, Paul Moore wrote:
> > On Tue, Mar 17, 2020 at 12:04 PM Richard Guy Briggs <rgb@redhat.com> wr=
ote:
> > >
> > > Log information about programs connecting to and disconnecting from t=
he
> > > audit netlink multicast socket. This is needed so that during
> > > investigations a security officer can tell who or what had access to =
the
> > > audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> > > Criteria.  Here is the systemd startup event:
> > >
> > > type=3DPROCTITLE msg=3Daudit(2020-02-18 15:26:50.775:10) : proctitle=
=3D/init
> > > type=3DSYSCALL msg=3Daudit(2020-02-18 15:26:50.775:10) : arch=3Dx86_6=
4 syscall=3Dbind success=3Dyes exit=3D0 a0=3D0x19 a1=3D0x55645c369b70 a2=3D=
0xc a3=3D0x7fff9fedec24 items=3D0 ppid=3D0 pid=3D1 auid=3Dunset uid=3Droot =
gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsg=
id=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd exe=3D/usr/lib/systemd/sy=
stemd subj=3Dkernel key=3D(null)
> > > type=3DUNKNOWN[1335] msg=3Daudit(2020-02-18 15:26:50.775:10) : pid=3D=
1 uid=3Droot auid=3Dunset tty=3D(none) ses=3Dunset subj=3Dkernel comm=3Dsys=
temd exe=3D/usr/lib/systemd/systemd nl-mcgrp=3D1 op=3Dconnect res=3Dyes
> > >
> > > And the events from the test suite:
> > >
> > > type=3DPROCTITLE msg=3Daudit(2020-02-18 15:28:01.594:307) : proctitle=
=3D/usr/bin/perl -w amcast_joinpart/test
> > > type=3DSYSCALL msg=3Daudit(2020-02-18 15:28:01.594:307) : arch=3Dx86_=
64 syscall=3Dbind success=3Dyes exit=3D0 a0=3D0x7 a1=3D0x558ebc428be0 a2=3D=
0xc a3=3D0x0 items=3D0 ppid=3D642 pid=3D645 auid=3Droot uid=3Droot gid=3Dro=
ot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droo=
t tty=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunconfined_u:u=
nconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> > > type=3DUNKNOWN[1335] msg=3Daudit(2020-02-18 15:28:01.594:307) : pid=
=3D645 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgr=
p=3D1 op=3Dconnect res=3Dyes
> > >
> > > type=3DPROCTITLE msg=3Daudit(2020-03-17 11:35:31.474:344) : proctitle=
=3D/usr/bin/perl -w amcast_joinpart/test
> > > type=3DSYSCALL msg=3Daudit(2020-03-17 11:35:31.474:344) : arch=3Dx86_=
64 syscall=3Dsetsockopt success=3Dyes exit=3D0 a0=3D0x7 a1=3DSOL_NETLINK a2=
=3D0x2 a3=3D0x7ffee21ca5f0 items=3D0 ppid=3D686 pid=3D689 auid=3Droot uid=
=3Droot gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3D=
root fsgid=3Droot tty=3DttyS0 ses=3D3 comm=3Dperl exe=3D/usr/bin/perl subj=
=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> > > type=3DUNKNOWN[1335] msg=3Daudit(2020-03-17 11:35:31.474:344) : pid=
=3D689 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgr=
p=3D1 op=3Ddisconnect res=3Dyes
> > >
> > > type=3DUNKNOWN[1335] msg=3Daudit(2020-01-17 10:36:24.051:295) : pid=
=3D674 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D3 subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgr=
p=3D1 op=3Ddisconnect res=3Dyes
> >
> > This patch looks fine to me, but this line is curious ... I'm assuming
> > this is just a stray/cut-n-paste-error from the last time you updated
> > the commit description?  If so, just let me know and I can drop it
> > while merging, otherwise there is something odd going on ....
>
> That last line is the result of close() from an earlier version of the
> testsuite, rather than setsockopt(..., NETLINK_DROP_MEMBERSHIP, ...).
>
> This is why we need the subject attributes, as noted in the first note
> above the changelog below.

Argh.  I wasn't looking at the subject info, I was just noting the
timestamp was obviously wrong and the connects/disconnects didn't
match.

I was going to be nice and just drop that message during the merge,
but you need to regenerate those messages with the audit records from
just this patch since it is 1/3.  As it stands right now someone is
going to be very confused in a few years when they try to reconcile
the code changes with your commit description.

Regardless of the subject info, we should make sure the
connects/disconnects are matched.  The example you provide from the
test shows one connect, but two disconnects.  That is going to confuse
people looking through the audit logs.  I'm hoping you just did a
copy-n-paste error, but if not we need to figure that out and find a
way to make them match if there is somewhat to do so.

While you are respinning this patch, please fix the checkpatch.pl
errors; there were multiple line length, space/tab, and code indent
problems.  I was going to fix them during the merge, but you might as
well fix them now.  Feel free to insert my usual plea to run your
patches through checkpatch.pl before submitting.

> > > Please see the upstream issue tracker at
> > >   https://github.com/linux-audit/audit-kernel/issues/28
> > > With the feature description at
> > >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicas=
t-Socket-Join-Part
> > > The testsuite support is at
> > >   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-pa=
rt-join
> > >   https://github.com/linux-audit/audit-testsuite/pull/93
> > > And the userspace support patch is at
> > >   https://github.com/linux-audit/audit-userspace/pull/114
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > >
> > > ---
> > > Note: subj attrs included due to missing syscall record for disconnec=
t on close
> > > Note: tried refactor of subj attrs, but this is yet another new order=
.
> > >
> > > Changelog:
> > > v7:
> > > - rename audit_log_multicast_bind to audit_log_multicast
> > >
> > > v6:
> > > - rebased on 5.6-rc1 audit/next and audit log BPF
> > > - updated patch description sample records
> > >
> > > v5:
> > > - rebased on 5.5-rc1 audit/next
> > > - group bind/unbind ops
> > > - add audit context
> > > - justify message number skip
> > > - check audit_enabled
> > > - change field name from nlnk-grp to nl-mcgrp
> > > - fix whitespace issues
> > >
> > > v4:
> > > - 2017-10-13 sgrubb
> > > - squash to 1 patch
> > > - rebase on KERN_MODULE event
> > > - open code subj attrs
> > >
> > > v3:
> > > - 2016-11-30 sgrubb
> > > - rebase on REPLACE event
> > > - minimize audit_log_format calls
> > > - rename audit_log_bind to audit_log_multicast_bind
> > >
> > > v2:
> > > - 2015-07-23 sgrubb
> > > - spin off audit_log_task_simple in seperate patch
> > >
> > > v1:
> > > - 2014-10-07 rgb
> > > ---
> > >  include/uapi/linux/audit.h |  1 +
> > >  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++=
++++++----
> > >  2 files changed, 45 insertions(+), 4 deletions(-)

--=20
paul moore
www.paul-moore.com
