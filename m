Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A9DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2839420774
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N82OtXxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHXLd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgHXLc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:32:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F49C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:32:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s20so2940433wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9DiUHolhkNru49P23XOkyQDXz+EeQP5GDOxo76bpdxo=;
        b=N82OtXxzEv7KNfxea1kKJyIvBhm6oAmVu1OS5Zx6ff698tfVJnjMBvLrwkHPg2N11q
         evTXJg1xx9TRBnSvInQ1x96tb+1cutj/8oblHmVH3fegXDvsgZoNElu6kNtiDMNeaQ8K
         KfbiHbU2w+hAzzPOrJaSpMOl5jpUKbdH/w9T7RSRQ3bQbNBFOl8HC8V62qr/x/w2qF0X
         VMZU5KwuxEuxxmOKrOks2kFswyx3rFmGEHhc0beu8fKirt6s5m9cdkqE06PudufJ9Dwl
         MOUovMDINJzRGFcGj+n1Dg+CVsjEuVCedvQCpLR4A8TL1QTux1FEN0t15UHvam+d9Hnj
         e1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9DiUHolhkNru49P23XOkyQDXz+EeQP5GDOxo76bpdxo=;
        b=KkGzbsucXQvhOMuOxfBjpZr786S6meyh6D1aJFz+zl3Zb5VQpSwBi9hW6a+2RFEXbN
         fMIUVuMFRtzbtEWq9jQUazxhUfppg9LQB/j+qFJavddNPnI47DSlsynxv5GdxQ1MZkIF
         QpCUc/G3wRMaCbkE4vGpp+Dw7aSBy/rTh+fQLgBES8WtIkN6Q8MH3DqZqIGJEkp/u7w+
         gaNDWDD9RBGGXyBGzCR6RsFqV9LBrhQjg2X6YmFXh4LZQ/88DY1zk/4X5mwbAfrQH8Zh
         PqC4N5IDfpkGM8aOj+WuXzbZVjHNES0RFVe7nGBZr1t8nolq4yZ4vlu/e0SR2bV+om0e
         TySw==
X-Gm-Message-State: AOAM530ncshJAe1e8aLwftQ8SkzPif5sLm+EhHpsbkCthAJ8/O7shOrh
        xOGgBCCVjNeGil77hETVw/4FBQ9T9fWDI8mqHeU=
X-Google-Smtp-Source: ABdhPJwaRwEDNW7PLgfF+M/JTI1lLafL7iDUVoIPMhVR0TW1sx5S+xdg3n8hqtmbwfoOfRyAItpXWkz4g86yNi/HzJ4=
X-Received: by 2002:a1c:f70e:: with SMTP id v14mr5248986wmh.74.1598268737042;
 Mon, 24 Aug 2020 04:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200822030155.GA414063@google.com>
In-Reply-To: <20200822030155.GA414063@google.com>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Mon, 24 Aug 2020 07:32:05 -0400
Message-ID: <CAOBnfPjG9=XPCYOP6Hau5rZaKAEb4rYHG=5oORJt36X1_nFPOg@mail.gmail.com>
Subject: Re: [RFC] Design proposal for upstream core-scheduling interface
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        JulienDesfossez@google.com,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, Kees Cook <keescook@chromium.org>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        chris hyser <chris.hyser@oracle.com>, dhaval.giani@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>, joshdon@google.com,
        xii@google.com, haoluo@google.com, bsegall@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Let me know your thoughts and looking forward to a good LPC MC discussion=
!
>

Nice write up Joel, thanks for taking time to compile this with great detai=
l!

After going through the details of interface proposal using cgroup v2
controllers,
and based on our discussion offline, would like to note down this idea
about a new
pseudo filesystem interface for core scheduling.  We could include
this also for the
API discussion during core scheduler MC.

coreschedfs: pseudo filesystem interface for Core Scheduling
---------------------------------------------------------------------------=
-------

The basic requirement of core scheduling is simple - we need to group a set
of tasks into a trust group that can share a core. So we don=E2=80=99t real=
ly
need a nested
hierarchy for the trust groups. Cgroups v2 follow a unified nested
hierarchy model
that causes a considerable confusion if the trusted tasks are in
different levels of the
hierarchy and we need to allow them to share the core. Cgroup v2's
single hierarchy
model makes it difficult to regroup tasks in different levels of
nesting for core scheduling.
As noted in this mail, we could use multi-file approach and other
interfaces like prctl to
overcome this limitation.

The idea proposed here to overcome the above limitation is to come up with =
a new
pseudo filesystem - =E2=80=9Ccoreschedfs=E2=80=9D. This filesystem is basic=
ally a flat
filesystem with
maximum nesting level of 1. That means, root directory can have
sub-directories for
sub-groups, but those sub-directories cannot have more sub-directories
representing
trust groups. Root directory is to represent the system wide trust
group and sub-directories
represent trusted groups. Each directory including the root directory
has the following set
of files/directories:

- cookie_id: User exposed id for a cookie. This can be compared to a
file descriptor.
             This could be used in programmatic API to join/leave a group

- properties: This is an interface to specify how child tasks of this
group should behave.
              Can be used for specifying future flag requirements as well.
              Current list of properties include:
              NEW_COOKIE_FOR_CHILD: All fork() for tasks in this group
will result in
                                    creation of a new trust group
              SAME_COOKIE_FOR_CHILD: All fork() for tasks in this
group will end up in
                                     this same group
              ROOT_COOKIE_FOR_CHILD: All fork() for tasks in this
group goes to the root group

- tasks: Lists the tasks in this group. Main interface for adding
removing tasks in a group

- <pid>: A directory per task who is am member of this trust group.
- <pid>/properties: This file is same as the parent properties file
but this is to override
                    the group setting.

This pseudo filesystem can be mounted any where in the root
filesystem, I propose the default
to be in =E2=80=9C/sys/kernel/coresched=E2=80=9D

When coresched is enabled, kernel internally creates the framework for
this filesystem.
The filesystem gets mounted to the default location and admin can
change this if needed.
All tasks by default are in the root group. The admin or programs can
then create trusted
groups on top of this filesystem.

Hooks will be placed in fork() and exit() to make sure that the
filesystem=E2=80=99s view of tasks is
up-to-date with the system. Also, APIs manipulating core scheduling
trusted groups should
also make sure that the filesystem's view is updated.

Note: The above idea is very similar to cgroups v1. Since there is no
unified hierarchy
in cgroup v1, most of the features of coreschedfs could be implemented
as a cgroup v1
controller. As no new v1 controllers are allowed, I feel the best
alternative to have
a simple API is to come up with a new filesystem - coreschedfs.

The advantages of this approach is:

- Detached from cgroup unified hierarchy and hence the very simple requirem=
ent
   of core scheduling can be easily materialized.
- Admin can have fine-grained control of groups using shell and scripting
- Can have programmatic access to this using existing APIs like mkdir,rmdir=
,
   write, read. Or can come up with new APIs using the cookie_id which can =
wrap
  t he above linux apis or use a new systemcall for core scheduling.
- Fine grained permission control using linux filesystem permissions and AC=
Ls

Disadvantages are
- yet another psuedo filesystem.
- very similar to  cgroup v1 and might be re-implementing features
that are already
  provided by cgroups v1.

Use Cases
-----------------

Usecase 1: Google cloud
---------------------------------

Since we no longer depend on cgroup v2 hierarchies, there will not be
any issue of
nesting and sharing. The main daemon can create trusted groups in the
fileystem and
provide required permissions for the group. Then the init processes
for each job can
be added to respective groups for them to create children tasks as
needed. Multiple
jobs under the same customer which needs to share the core can be
housed in one group.


Usecase 2: Chrome browser
------------------------

We start with one group for the first task and then set properties to
NEW_COOKIE_FOR_CHILD.

Usecase 3: chrome VMs
---------------------

Similar to chrome browser, the VM task can make each vcpu on its own group.

Usecase 4: Oracle use case
--------------------------
This is also similar to use case 1 with this interface. All tasks that need=
 to
be in the root group can be easily added by the admin.

Use case 5: General virtualization
----------------------------------

The requirement is each VM should be isolated. This can be easily done
by creating a
new group per VM


Please have a look at the above proposal and let us know your
thoughts. We shall include
this also during the interface discussion at core scheduling MC.


Thanks,
Vineeth
