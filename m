Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC902C81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C08720661
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="kdFwpzCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD0W4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726204AbgD0W4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:56:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38DC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:56:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id re23so15640287ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6oP4VlaFSgV7ud2KRpDv5BaL13F0F42IcKqjskFrEBY=;
        b=kdFwpzCFRttiutv60AYkPug4pefUZZCUWW4qAsqCXSM06e2SNUQSyBb5z+AtpTRFox
         fh5yS6yzmwDt8Y0UJ0sJ4nN8bDjZ3j9m5ZStMFx5MWRKKxv0o9qKfd40g/QsieZpY7wC
         G7ITVy+mxa5Q3e3pNHNMWHeQy0Wiaxpgsw1dr/jLaejH9va7i0L/obvmnjAnbS28Yw5u
         Y46w32dR7BxmsGviue1u8eysyEqleYnb0Jx4BbrejywN0Z5cJFGiEd8k3deG6aPEIKEU
         cMWF6wwnYvY59EDRQo2bbR7ubmD1Nt2zxavNFEQNPghWAfvN0KnGQpFKAGBiFdlaAUcq
         hCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6oP4VlaFSgV7ud2KRpDv5BaL13F0F42IcKqjskFrEBY=;
        b=aNLUlDfd8yaKLrwb/5TkIBcmgAHg9uns7g4tiu02xiDnpdAXEy4HqVKyITkBJyBOpW
         jf8ni5g93esZ+sBoNU7P1rbVco7yOZYMbd6ebRxD6hODWSJF+yhj3us6CDmaAamouwzu
         MwwKb47AkCMqCgbEPMK4N3f9zBm8XF70lKyljffvdwYqhZea6B+2L6kSHuhrEM6BUIlC
         uOwsyfIs/MLUmvSNjorG+RanvBFyWekivOCJcFnsYkz6RNsQHrAVAmBklUzYNvA5IJDO
         8fcjfb5Y/JzPKMWIrIekEcOAyjvIgkoiyXtborORgBTO/hbSaQYIufjsi9JEYtKOdHlU
         2wvA==
X-Gm-Message-State: AGi0PuZOlqCJXnR1JtKVemzEN9tXD7lP1aSeCvaDFlfv1n9WX8Qjcern
        V3hmM/tKhH23GIyejMesMVWrYxzK8VyeD4qtXmtwYc4=
X-Google-Smtp-Source: APiQypKPv6cRsPxh1oTswoSINDboSrGOzuhuDMenrI+BBkA39rvw12ROJ4ljCzKcT7J6ZOvXFB4ZgjG27XHE9S5zQYQ=
X-Received: by 2002:a17:906:d7a2:: with SMTP id pk2mr22931365ejb.272.1588028207028;
 Mon, 27 Apr 2020 15:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <3623b9dba8068d1488681f62683bb42ad3f4debb.1587571187.git.rgb@redhat.com>
In-Reply-To: <3623b9dba8068d1488681f62683bb42ad3f4debb.1587571187.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 18:56:35 -0400
Message-ID: <CAHC9VhRtPKdWmnD7Sh-ZW8S1y9xsPsgWKGcvYQD86AT7JYP2gQ@mail.gmail.com>
Subject: Re: [PATCH ghak28 V8] audit: log audit netlink multicast bind and
 unbind events
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, sgrubb@redhat.com,
        omosnace@redhat.com, Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 5:37 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Log information about programs connecting to and disconnecting from the
> audit netlink multicast socket. This is needed so that during
> investigations a security officer can tell who or what had access to the
> audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> Criteria.
>
> Here is the systemd startup event:
> type=3DPROCTITLE msg=3Daudit(2020-04-22 10:10:21.787:10) : proctitle=3D/i=
nit
> type=3DSYSCALL msg=3Daudit(2020-04-22 10:10:21.787:10) : arch=3Dx86_64 sy=
scall=3Dbind success=3Dyes exit=3D0 a0=3D0x19 a1=3D0x555f4aac7e90 a2=3D0xc =
a3=3D0x7ffcb792ff44 items=3D0 ppid=3D0 pid=3D1 auid=3Dunset uid=3Droot gid=
=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=
=3Droot tty=3D(none) ses=3Dunset comm=3Dsystemd exe=3D/usr/lib/systemd/syst=
emd subj=3Dkernel key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-04-22 10:10:21.787:10) : pid=3D1 ui=
d=3Droot auid=3Dunset tty=3D(none) ses=3Dunset subj=3Dkernel comm=3Dsystemd=
 exe=3D/usr/lib/systemd/systemd nl-mcgrp=3D1 op=3Dconnect res=3Dyes
>
> And events from the test suite that just uses close():
> type=3DPROCTITLE msg=3Daudit(2020-04-22 11:47:08.501:442) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSYSCALL msg=3Daudit(2020-04-22 11:47:08.501:442) : arch=3Dx86_64 s=
yscall=3Dbind success=3Dyes exit=3D0 a0=3D0x7 a1=3D0x563004378760 a2=3D0xc =
a3=3D0x0 items=3D0 ppid=3D815 pid=3D818 auid=3Droot uid=3Droot gid=3Droot e=
uid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tt=
y=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-04-22 11:47:08.501:442) : pid=3D818=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Dconnect res=3Dyes
>
> type=3DUNKNOWN[1335] msg=3Daudit(2020-04-22 11:47:08.501:443) : pid=3D818=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Ddisconnect res=3Dyes
>
> And the events from the test suite using setsockopt with NETLINK_DROP_MEM=
BERSHIP:
> type=3DPROCTITLE msg=3Daudit(2020-04-22 11:39:53.291:439) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSYSCALL msg=3Daudit(2020-04-22 11:39:53.291:439) : arch=3Dx86_64 s=
yscall=3Dbind success=3Dyes exit=3D0 a0=3D0x7 a1=3D0x5560877c2d20 a2=3D0xc =
a3=3D0x0 items=3D0 ppid=3D772 pid=3D775 auid=3Droot uid=3Droot gid=3Droot e=
uid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tt=
y=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunconfined_u:uncon=
fined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-04-22 11:39:53.291:439) : pid=3D775=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Dconnect res=3Dyes
>
> type=3DPROCTITLE msg=3Daudit(2020-04-22 11:39:53.292:440) : proctitle=3D/=
usr/bin/perl -w amcast_joinpart/test
> type=3DSYSCALL msg=3Daudit(2020-04-22 11:39:53.292:440) : arch=3Dx86_64 s=
yscall=3Dsetsockopt success=3Dyes exit=3D0 a0=3D0x7 a1=3DSOL_NETLINK a2=3D0=
x2 a3=3D0x7ffc8366f000 items=3D0 ppid=3D772 pid=3D775 auid=3Droot uid=3Droo=
t gid=3Droot euid=3Droot suid=3Droot fsuid=3Droot egid=3Droot sgid=3Droot f=
sgid=3Droot tty=3DttyS0 ses=3D1 comm=3Dperl exe=3D/usr/bin/perl subj=3Dunco=
nfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=3D(null)
> type=3DUNKNOWN[1335] msg=3Daudit(2020-04-22 11:39:53.292:440) : pid=3D775=
 uid=3Droot auid=3Droot tty=3DttyS0 ses=3D1 subj=3Dunconfined_u:unconfined_=
r:unconfined_t:s0-s0:c0.c1023 comm=3Dperl exe=3D/usr/bin/perl nl-mcgrp=3D1 =
op=3Ddisconnect res=3Dyes
>
> Please see the upstream issue tracker at
>   https://github.com/linux-audit/audit-kernel/issues/28
> With the feature description at
>   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-So=
cket-Join-Part
> The testsuite support is at
>   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-j=
oin
>   https://github.com/linux-audit/audit-testsuite/pull/93
> And the userspace support patch is at
>   https://github.com/linux-audit/audit-userspace/pull/114
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>

Merged into audit/next.

I like when examples of the audit records are included in the commit
description, but in the future it might be a good idea to line wrap
those records between the fields when the records are excessively long
(I would further suggest a hanging indent to ease readability).

--=20
paul moore
www.paul-moore.com
