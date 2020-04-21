Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71F2C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2AB12072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uaxe171Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDUUjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:39:12 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587501550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e9sm8uWws5+uHKCcXNyGVFLhz50EVwan2O5fmPm/OBY=;
        b=Uaxe171ZqQ7uMr81HTV+S9L6/pTMzgW9pS81ktLdUxxxsg9WH8eRacVuvE0yZqbbj/+3ey
        GrlnGpuUB72GSw87lZT2r8QdEZa/yXJ1jnoWEcQK95Vt6xvHtz6mG7rvxgAItsnUVzvbkt
        IzJzvbbMI7p6TbrZViuSlPmI4OQDX/c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-mgJC3O__Nz62NnUVOqkWjg-1; Tue, 21 Apr 2020 16:39:05 -0400
X-MC-Unique: mgJC3O__Nz62NnUVOqkWjg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5BD08017F6;
        Tue, 21 Apr 2020 20:39:04 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.9])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 358445DA7C;
        Tue, 21 Apr 2020 20:38:58 +0000 (UTC)
Date:   Tue, 21 Apr 2020 16:38:55 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH ghak28 V7] audit: log audit netlink multicast bind and
 unbind events
Message-ID: <20200421203854.dkrvl7oiy5u5ac5j@madcap2.tricolour.ca>
References: <82d85f72416560c155031375fb5b32ac06394c31.1584033222.git.rgb@redhat.com>
 <CAHC9VhRqytBECZ+bgo_OXavbRmPKEu0OOqS=xe=FQFhG+Qv=oA@mail.gmail.com>
 <20200417213423.leermiriy4jzgwf4@madcap2.tricolour.ca>
 <CAHC9VhRy9krH8gxMHX1qpHLNR7De0KyouOrAvEzGKYkr8r2B0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRy9krH8gxMHX1qpHLNR7De0KyouOrAvEzGKYkr8r2B0g@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 18:19, Paul Moore wrote:
> On Fri, Apr 17, 2020 at 5:34 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2020-04-17 17:18, Paul Moore wrote:
> > > On Tue, Mar 17, 2020 at 12:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > >
> > > > Log information about programs connecting to and disconnecting from the
> > > > audit netlink multicast socket. This is needed so that during
> > > > investigations a security officer can tell who or what had access to the
> > > > audit trail.  This helps to meet the FAU_SAR.2 requirement for Common
> > > > Criteria.  Here is the systemd startup event:
> > > >
> > > > type=PROCTITLE msg=audit(2020-02-18 15:26:50.775:10) : proctitle=/init
> > > > type=SYSCALL msg=audit(2020-02-18 15:26:50.775:10) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x19 a1=0x55645c369b70 a2=0xc a3=0x7fff9fedec24 items=0 ppid=0 pid=1 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=systemd exe=/usr/lib/systemd/systemd subj=kernel key=(null)
> > > > type=UNKNOWN[1335] msg=audit(2020-02-18 15:26:50.775:10) : pid=1 uid=root auid=unset tty=(none) ses=unset subj=kernel comm=systemd exe=/usr/lib/systemd/systemd nl-mcgrp=1 op=connect res=yes
> > > >
> > > > And the events from the test suite:
> > > >
> > > > type=PROCTITLE msg=audit(2020-02-18 15:28:01.594:307) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> > > > type=SYSCALL msg=audit(2020-02-18 15:28:01.594:307) : arch=x86_64 syscall=bind success=yes exit=0 a0=0x7 a1=0x558ebc428be0 a2=0xc a3=0x0 items=0 ppid=642 pid=645 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=1 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > > > type=UNKNOWN[1335] msg=audit(2020-02-18 15:28:01.594:307) : pid=645 uid=root auid=root tty=ttyS0 ses=1 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=connect res=yes
> > > >
> > > > type=PROCTITLE msg=audit(2020-03-17 11:35:31.474:344) : proctitle=/usr/bin/perl -w amcast_joinpart/test
> > > > type=SYSCALL msg=audit(2020-03-17 11:35:31.474:344) : arch=x86_64 syscall=setsockopt success=yes exit=0 a0=0x7 a1=SOL_NETLINK a2=0x2 a3=0x7ffee21ca5f0 items=0 ppid=686 pid=689 auid=root uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=ttyS0 ses=3 comm=perl exe=/usr/bin/perl subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> > > > type=UNKNOWN[1335] msg=audit(2020-03-17 11:35:31.474:344) : pid=689 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> > > >
> > > > type=UNKNOWN[1335] msg=audit(2020-01-17 10:36:24.051:295) : pid=674 uid=root auid=root tty=ttyS0 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 comm=perl exe=/usr/bin/perl nl-mcgrp=1 op=disconnect res=yes
> > >
> > > This patch looks fine to me, but this line is curious ... I'm assuming
> > > this is just a stray/cut-n-paste-error from the last time you updated
> > > the commit description?  If so, just let me know and I can drop it
> > > while merging, otherwise there is something odd going on ....
> >
> > That last line is the result of close() from an earlier version of the
> > testsuite, rather than setsockopt(..., NETLINK_DROP_MEMBERSHIP, ...).
> >
> > This is why we need the subject attributes, as noted in the first note
> > above the changelog below.
> 
> Argh.  I wasn't looking at the subject info, I was just noting the
> timestamp was obviously wrong and the connects/disconnects didn't
> match.

I can doctor the timestamp if you like?  ;-)

> I was going to be nice and just drop that message during the merge,
> but you need to regenerate those messages with the audit records from
> just this patch since it is 1/3.  As it stands right now someone is
> going to be very confused in a few years when they try to reconcile
> the code changes with your commit description.
> 
> Regardless of the subject info, we should make sure the
> connects/disconnects are matched.  The example you provide from the
> test shows one connect, but two disconnects.  That is going to confuse
> people looking through the audit logs.  I'm hoping you just did a
> copy-n-paste error, but if not we need to figure that out and find a
> way to make them match if there is somewhat to do so.

No, it wasn't a copy/paste error.  It was an intentional inclusion, but
it will need some prose to explain what it demonstrates.

> While you are respinning this patch, please fix the checkpatch.pl
> errors; there were multiple line length, space/tab, and code indent
> problems.  I was going to fix them during the merge, but you might as
> well fix them now.  Feel free to insert my usual plea to run your
> patches through checkpatch.pl before submitting.

I assume this paragraph was to be conditionally included in the ghak25
patchset comments if a respin was necessary since this patch has no
issues (other than one patch description line too long that is a record
sample).  I've fixed all those issues in ghak25 patches 1/3 and 2/3 and
am just doing a test compile to make sure I've not messed anything up
and that the rebase to v5.7-rc1 didn't cause a problem.

> > > > Please see the upstream issue tracker at
> > > >   https://github.com/linux-audit/audit-kernel/issues/28
> > > > With the feature description at
> > > >   https://github.com/linux-audit/audit-kernel/wiki/RFE-Audit-Multicast-Socket-Join-Part
> > > > The testsuite support is at
> > > >   https://github.com/rgbriggs/audit-testsuite/compare/ghak28-mcast-part-join
> > > >   https://github.com/linux-audit/audit-testsuite/pull/93
> > > > And the userspace support patch is at
> > > >   https://github.com/linux-audit/audit-userspace/pull/114
> > > >
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > >
> > > > ---
> > > > Note: subj attrs included due to missing syscall record for disconnect on close
> > > > Note: tried refactor of subj attrs, but this is yet another new order.
> > > >
> > > > Changelog:
> > > > v7:
> > > > - rename audit_log_multicast_bind to audit_log_multicast
> > > >
> > > > v6:
> > > > - rebased on 5.6-rc1 audit/next and audit log BPF
> > > > - updated patch description sample records
> > > >
> > > > v5:
> > > > - rebased on 5.5-rc1 audit/next
> > > > - group bind/unbind ops
> > > > - add audit context
> > > > - justify message number skip
> > > > - check audit_enabled
> > > > - change field name from nlnk-grp to nl-mcgrp
> > > > - fix whitespace issues
> > > >
> > > > v4:
> > > > - 2017-10-13 sgrubb
> > > > - squash to 1 patch
> > > > - rebase on KERN_MODULE event
> > > > - open code subj attrs
> > > >
> > > > v3:
> > > > - 2016-11-30 sgrubb
> > > > - rebase on REPLACE event
> > > > - minimize audit_log_format calls
> > > > - rename audit_log_bind to audit_log_multicast_bind
> > > >
> > > > v2:
> > > > - 2015-07-23 sgrubb
> > > > - spin off audit_log_task_simple in seperate patch
> > > >
> > > > v1:
> > > > - 2014-10-07 rgb
> > > > ---
> > > >  include/uapi/linux/audit.h |  1 +
> > > >  kernel/audit.c             | 48 ++++++++++++++++++++++++++++++++++++++++++----
> > > >  2 files changed, 45 insertions(+), 4 deletions(-)
> 
> -- 
> paul moore
> www.paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

