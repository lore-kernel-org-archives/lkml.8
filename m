Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C36C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAEC24679
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fk11+hP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBZVvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:51:11 -0500
Received: from mail.efficios.com ([167.114.26.124]:60174 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBZVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:51:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C7CEC26FE33;
        Wed, 26 Feb 2020 16:51:09 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2DUpseTh9KQD; Wed, 26 Feb 2020 16:51:09 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4496626FE32;
        Wed, 26 Feb 2020 16:51:09 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4496626FE32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582753869;
        bh=6AP9OFhSnVvA6ZnNHSvbswS/0fzySU+X9J3de0/Oe4A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=fk11+hP2FH+Ihqkt/VjoFS5qumyTe54AHCC2d505OAeW9K/nw6b0nHrJqOiSMRU1W
         MD4kXG66P3C2nq+UR4XiL8m73VvFjPkgATEvvZx2MIrvQ18zl0es15gFLQ2KYtGmJW
         A8n4Mzc6PUnN+uXtmNevoug3FTJ8uAilMotD+53dcz9V/pK2cgB8WY58v5Uni0udrs
         Z/T/sHfH0c2yxpRMu1fS1BF/n+aeBPKYtnjxPW6hoCVXRx/3CFzdJyKH9SSRtCITvx
         xy1CxYe1YB9hRvunlsZQlbK9EPS3/K7zVw8Xjb2NCBjB4yhrUEQ6vHMnZrruyDhrmc
         Bn3sgAYju1UDw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jZ2sG3XOck3Y; Wed, 26 Feb 2020 16:51:09 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 349C326FF94;
        Wed, 26 Feb 2020 16:51:09 -0500 (EST)
Date:   Wed, 26 Feb 2020 16:51:09 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Chris Kennelly <ckennelly@google.com>
Cc:     Paul Turner <pjt@google.com>, Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Message-ID: <416869220.9190.1582753869096.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com> <20200221154923.GC194360@google.com> <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com> <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Rseq registration: Google tcmalloc vs glibc
Thread-Index: Qr0rErGoWa9ebOi0Qh/dm4u4h5997w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 25, 2020, at 10:24 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
[..]
> 
> Chris, Brian, is there any other concern to upgrading of tcmalloc
> version in ChromeOS? I believe there was some concern about detection
> of rseq kernel support. A quick look at tcmalloc shows it does not do
> such detection, but I can stand corrected. One more thing, currently
> tcmalloc does not use rseq on ARM. If I recall, ARM does have rseq
> support as well. So we ought to enable it for that arch as well if
> possible. Why not enable it on all arches and then dynamically detect
> at runtime if needed support is available?

Please allow me to raise a concern with respect to the implementation
of the SlowFence() function in tcmalloc/internal/percpu.cc. It uses
sched_setaffinity to move the thread around to each CPU part of the
cpu mask.

There are a couple of corner-cases where I think it can malfunction:

- Interaction with concurrent sched_setaffinity invoked by an external
  manager process: If an external manager process attempts to limit this
  thread's ability to run onto specific CPUs, either before the thread
  starts or concurrently while the thread executes, I suspect the
  SlowFence() algorithm will simply handle errors while trying to set
  affinity by skipping CPUs, which results in a skipped rseq fence,
  which in turn can cause corruption.

  The comments in this function state:

    // If we can't pin ourselves there, then no one else can run there, so
    // that's fine.

  But AFAIU the thread's cpu affinity is a per-thread attribute, so saying
  that no other thread from the same process can run there seems wrong. What
  am I missing ? Maybe it is a difference between cpusets and sched_setaffinity ?

  The code below opens /proc/self/cpuset to deal with concurrent affinity
  updates by cpuset seems to rely on CONFIG_CPUSETS=y, and does not seem to
  take into account CPU affinity changes through sched_setaffinity.

  Moreover, reading through the comments there, depending on internal kernel
  synchronization implementation details for dealing with concurrent cpuset
  updates seems very fragile. Those details about internal locking of
  cpuset.cpus within the kernel should not be expected to be ABI.

- Interaction with CPU hotplug. If a target CPU is unplugged and plugged
  again (offline, then online) concurrently, this algorithm may skip that
  CPU and thus skip a rseq fence, which can also cause corruption.

Those limitations of sched_setaffinity() are the reasons why I have
proposed a new "pin_on_cpu()" system call [1]. Feedback in that area
is very welcome.

Thanks,

Mathieu

[1] https://lore.kernel.org/r/20200121160312.26545-1-mathieu.desnoyers@efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
