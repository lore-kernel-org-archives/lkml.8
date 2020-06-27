Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6910DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC7320724
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 16:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NFwcnfh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgF0QVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgF0QVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 12:21:49 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64992C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:21:49 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so2758142ilk.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 09:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2nGKnDNsfGo+T6bDiJUevR3z7PJsbSGEM8ozMY3Q1c=;
        b=NFwcnfh/hEGQUYaebr5ifTcevv4BMj/OUSW0MFghU+HbUWf6KpGale9QHb5RwDiaBx
         aJAMQm43iK9a0We+F+fOwGtm09RZi99VihP6XW8Vt7QCFtXFA3WqRg2S4p5M2jHdUTBr
         tCwv0tvLARFVswsztggS3t1TgS7+ic/u0PK8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2nGKnDNsfGo+T6bDiJUevR3z7PJsbSGEM8ozMY3Q1c=;
        b=GNp9xJrg8MdEP/R0JVdUtYNsP4vRrJE76AZcZExVmq89HItnLhnuMQZXSVvPWRubcQ
         TtcDnvlVqN1DIAY2pSrhALirauSs72B+p0tY0biOIyFMwtCpsIMSbIga/zuTQEFc+OGk
         PAqCdPtXGF3995BVIY4HDbY88gVGadSKrGth/XCGo8M/ck2FnsnwbeyJc4U5ReYjn39D
         3qONoIypLBCH3AbGLyEpUarGxPmc8Rj9N4FRi4BmrUGiSN8cE/8Q19Tkn+S1d7P2575/
         Vxe2nPf6d+VrbGcvzQGck60bxNeiOK7Tlv1ELftS93h4qhoaRvQozKPNS3Jm4Ngyl/ZK
         5HOg==
X-Gm-Message-State: AOAM533ytOFkfh9H+vX2JZXDc7QIBDlDEiDkHCVqPWBGtwjvSE8cvqDP
        YL09viBcWB8hps6qjz8wct2QWhYW7ttmLGxnj0GWpw==
X-Google-Smtp-Source: ABdhPJxaWQLg4tRKtkxU81Tpb7DsYNug/vR/dvA/QKhF6vaTkhjoouSApXIBfA+R3SUWPzgTTuRolvI1CkoS2seTfQc=
X-Received: by 2002:a92:c0c8:: with SMTP id t8mr8832465ilf.176.1593274908687;
 Sat, 27 Jun 2020 09:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <CANaguZBQMarzMb-iXBEx8wJqkTYtRskTL+xQnShuAW7hP9UdqA@mail.gmail.com>
 <CAEXW_YSU5=ZUf-4j55av9Q8b+PRiM2DCKydM9Bv__mzL2MWx4g@mail.gmail.com>
 <CANaguZCi7Gj5TSUfU5AZ5w1v=EEz23rdgUsSg1NVb3DBM+F6bA@mail.gmail.com> <20200626151028.GA538235@google.com>
In-Reply-To: <20200626151028.GA538235@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 27 Jun 2020 12:21:36 -0400
Message-ID: <CAEXW_YTv4fuBAoUdMiUCHz2aCSfRSd__Ri1x8jdhD3m+=m4P-w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul Turner <pjt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:10 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> [..]
> > What do you think about having a separate cgroup for coresched?
> > Both coresched cgroup and prctl() could co-exist where prctl could
> > be used to isolate individual process or task and coresched cgroup
> > to group trusted processes.
>
> This sounds like a fine idea to me. I wonder how Tejun and Peter feel about
> having a new attribute-less CGroup controller for core-scheduling and just
> use that for tagging. (No need to even have a tag file, just adding/removing
> to/from CGroup will tag).

Unless there are any major objections to this idea, or better ideas
for CGroup users, we will consider proposing a new CGroup controller
for this. The issue with CPU controller CGroups being they may be
configured in a way that is incompatible with tagging.

And I was also thinking of a new clone flag CLONE_CORE (which allows a
child to share a parent's core). This is because the fork-semantics
are not clear and it may be better to leave the behavior of fork to
userspace IMHO than hard-coding policy in the kernel.

Perhaps we can also discuss this at the scheduler MC at Plumbers.

Any other thoughts?

 - Joel
