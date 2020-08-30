Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F1BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB2D720707
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 14:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgH3Ok4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 10:40:56 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46834 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgH3Ok1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 10:40:27 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kCOUy-0001YY-Lr; Sun, 30 Aug 2020 14:40:00 +0000
Date:   Sun, 30 Aug 2020 16:39:59 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     containers@lists.linux-foundation.org
Cc:     Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: LPC 2020 Hackroom Session: summary and next steps for isolated user
 namespaces
Message-ID: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

## Preliminaries

This is the summary of the Hackroom session Stéphane and I led as a follow-up
to our presentations in the Containers & Checkpoint/Restore micro-conference at
Linux Plumbers 2020.

Please make sure to see the Action Items section below as it outlines the next
concrete steps that came up during the meeting and who seemed interested in
tackling them.

The background for this summary is:

1. Stéphane's and my talk "Isolated Dynamic User Namespaces"
   People interested in the full session can watch it on YouTube:
   https://youtu.be/fSyr_IXM21Y?t=8856

2. The Hackroom session on Wednesday, 25.08.2020 at 17:00 UTC
   This session has been recorded as well. It is not yet on YouTube because
   Hackroom sessions weren't streamed. However, I plan on cutting that video
   and putting it up on YouTube as well just so there's no chance of
   miscommunication.

All people that attended session 1. were asked to send me an e-mail if they
wanted to attend session 2. to hash out details. The following people requested
to attend session 2. and were informed either through the e-mail I sent out or IRC:

Aleksa Sarai
Alexander Mihalicyn
Andy Lutomirski
Christian Brauner
Eric W. Biederman
Geoffrey Thomas
Giuseppe Scrivano
Joseph Christopher Sible
Josh Triplett
Kees Cook
Mickaël Salaün
Mrunal Patel
Pavel Tikhomirov
Sargun Dhillon
Serge Hallyn
Stephane Graber
Vivek Goyal
Wat Lim

All of them should be Cced here. In case I forgot someone don't hesitate to
forward this mail to them!

## Summary

During the Containers & Checkpoint/Restore micro-conference and in the hackroom
session Stéphane Graber and I proposed a way to make using user namespaces
simpler and more isolated. The following current problems were identified:

P1. Isolated id mappings can only be guaranteed to be locally isolated.
    A container runtime/daemon can only guarantee non-overlapping id mappings
    when no other users on the system create containers.

P2. Enforcing isolated id mappings in userspace is difficult.
    It is always possible to create other processes with overlapping id
    mappings. Coordinating id mappings in userspace will always remain
    optional. Quite a few tools nowadays (including systemd) don't care about
    /etc/sub{g,u}id and actively advise against using it. This is made even
    more problematic since sub{g,u}iid delegation is done per-user rather than
    per-container-runtime.

P3. The range of the id mapping of a container can't be predetermined.
    While POSIX mandates that a standard system should use a range of 65536 ids
    reality is very different. Some programs allocate high ids for random
    processes or for network authentication. This means, in practice it is
    often necessary to assign a range of up to 10 million ids to a container.
    This limits a system to less than 500 containers total.

P4. Isolated id mappings severely restrict the number of containers that can be
    run on a system.
    This ties back to the point about pre-determining the id range of a
    container and how large range allocations tend to be on real systems. That
    becomes even more relevant when nesting containers.

P5. Container runtimes cannot reuse overlayfs lower directories if each
    container uses isolated ID mappings, leading to either needless storage
    overhead (LXD -- though the LXD folks don’t really mind), completely
    ignoring the benefits of isolating containers from each other (Docker), or
    not using them at all (Kubernetes). (This is a more general issue but bears
    repeating since it is closely tied to most userns proposals.)

P6. Rlimits pose a problem for containers that share the same id mapping.
    This means containers with overlapping id mappings can DOS each other by
    exhausting their rlimits. The reason for this lies with the current
    implementation of rlimits -- rlimits are currently tied to users and are
    not hierarchically limited like inotify limits are. This is a severe
    problem in unprivileged workloads. Eric and others identified that this
    issue can be fixed independently of the isolated user namespace proposal.

In response to these and other issues, we made the following proposal which was
floated around in less clear form already during Linux Plumber 2019 in Lisbon
during informal discussions:

## Proposal

Introduce an in-kernel concept of an isolated user namespace by switching the
id types in the kernel from 32 to 64 bits. Userspace will only get to see the
lower 32 bits as usual. The upper 32 bits are used for a unique, in-kernel user
namespace token. The owner of such a namespace will either be the effective id
of the creator of that namespace or optionally an owning id can be set (when
created by a privileged user).

The following advantages were identified by various people during the session:

S1. An isolated user namespace has access to the full 32 bit id range.
    This makes it compatible with every Linux workload and allows to support
    post-POSIX range users that allocate high-range ids (LDAP, systemd, etc). 
    This solves P3 and P4.

S2. Kernel-enforced user namespace isolation.
    This means, there is no need for different container runtimes to
    collaborate on id ranges with immediate benefits for everyone.
    This solves P1 and P2.

S3. The need to split existing id ranges is completely removed.
    Nested containers become trivial.

S4. Simplify the usage of user namespaces significantly for newcomers.
    This should hopefully finally increase adoption in userspace especially in
    the application container and Kubernetes space.

S5. The owning id concept of a user namespace makes monitoring and interacting
    with such containers way easier.

S6. When interacting with an isolated user namespace the owning id can be used
    as a credential when interacting with the container from an ancestor user
    namespace.

The need and desire for these features seemed to be expressed by most
participating parties.

### Issues

Two main issues were discussed:

1. How are interactions across isolated user namespaces handled?
   An isolated user namespace can interact with another isolated user namespace
   or an ancestor user namespace. A good example are socket credentials. They
   can be seen and received outside of the container. In those cases the id of
   the isolated user namespace needs to be represented.
   The proposals to solve this problem were:
   1.1. Use the owning id of the isolated user namespace.
	A parent user namespace would see the configured owning id of the
	isolated user namespace (mapped to that user namespace).
        A non ancestor user namespace would see the overflow ids.
   1.2. Always use the overflow id for isolated user namespaces.
	Any other user namespaces would see the overflow id configured on the
	system.
   Proposal 1.1 semmed prefered since it would allow an unprivileged
   user creating an isolated user namespace to kill/ptrace all processes
   in the isolated namespace they spawned. In contrast proposal 1.1
   would not allow for visible ownership of the container, not just
   making tracking down the container harder but also preventing the
   owner from accessing those processes through other APIs.
   
   Related to this proposal it was suggested to introduce a new sysctl
   which would allow the system administrator to prevent any id
   transitions to overflow ids, i.e. a process would not be able to
   set{g,u}id() to the overflow {g,u}id.  A distribution can then decide
   to select specific overflow ids (akin to a system id) and set them
   via the already existing /proc/sys/kernel/overflow{g,u}id sysctl
   interfaces. This increases the security that isolated user namespaces
   provide even more.

2. How is filesystem access in isolated user namespaces handled?
   (This is basically the problem outlined in P5).
   There were quite a few proposals pitched by Andy and some others and it
   would be difficult to summarize them all here, especially since a few of
   them were rather rudimentary sketches. Once the YouTube video of the
   Hackroom session is up people can listen to it in more detail.

   The first consensus reached seemed to be to decouple isolated user
   namespaces from shiftfs. The idea is to solely rely on tmpfs and fuse
   at the beginning as filesystems which can be mounted inside isolated
   user namespaces and so would have proper ownership. For mount points
   that originate from outside the namespace, everything will show as
   the overflow ids and access would be restricted to the most
   restricted permission bit for any path that can be accessed.

### Additional Requirements

Sargun pointed out that they make use of NFSv4 both id mapped, and non-id
mapped. Different id mappings between different filesystems in NFS is not part
of their use-case currently and so it is fine if the ids are passed through as
is. He additionally pointed out that they would like to be able use the
idmapper tool in such isolated containers. This tool maps a given process id to
the highest user id available. It seems that all of these use-cases would work
with the current setup.

It was proposed that for NFS an alternative solution should be considered,
namely making it possible to mount NFS inside of a user namespace. This work
would need to be done by someone well-versed in modern NFS.

### Action Items

The following consensus seemed to have been reached by the end of the session:

1. Fixing rlimits in user namespaces such that one namespace cannot affect
   another.
   This was identified as problem P6 above. During the session it seemed that
   Eric intended to investigate this.

2. Prototyping switching the kernel uid/gid types to 64bit, allowing for a
   hidden 32bit identifier and fully usable 32bit uid/gid range for the
   container.
   The consensus seemed to have been to implement a first version of this and
   do performance testing to see what the performance impact of this change
   would be.
   Aleksa Sarai and Christian Brauner stated they were interested in
   taking on this work jointly.

3. Find a way to allow setgroups() in a user namespace while keeping
   in mind the case of groups used for negative access control.
   This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
   investigate adding a prctl() to allow setgroups() to be called in a user
   namespace at the cost of restricting paths to the most restrictive
   permission. So if something is 0707 it needs to be treated as if it's 0000
   even though the caller is not in its owning group which is used for negative
   access control (how these new semantics will interact with ACLs will also
   need to be looked into).

4. Add optional enforcement that overflow uid/gid as set through
   sysctl cannot be used as regular uid/gid on the system, which will allow
   userspace to disambiguate credential IDs which are unmapped versus the
   “nobody” user (which is actually used by distributions) It seemed that this
   idea was pitched by Geoffrey Thomas.

Special thanks to Stéphane and Aleksa for corrections and additions!

Thanks!
Christian
