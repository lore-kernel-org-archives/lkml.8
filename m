Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A99C11D20
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F69222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 21:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="EbqMF2ly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgBTVdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 16:33:33 -0500
Received: from mail.efficios.com ([167.114.26.124]:53214 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBTVdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 16:33:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EC75E259150;
        Thu, 20 Feb 2020 16:33:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id JTPi-6MrkGF1; Thu, 20 Feb 2020 16:33:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 74E4725921E;
        Thu, 20 Feb 2020 16:33:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 74E4725921E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582234410;
        bh=qUvJahEG+Ifsoqa25pPmv+QBKwuV/zZcj9KWXJdnAYA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=EbqMF2lyIv6SRmw4Z75e1iWR0cXEKb7mtL4W+P8cg+h32o9URa/9MLUaVkLOg/p32
         zcuGwy+QiIeWJM7fAu3wxCwM1dG+JuBYvEW2JJxO0LHDTIV/cAdVmsLbmXouWrzOlJ
         tkn0y1Yo5LOk+bV38vxigeHS54LBv09nNAW4BCCbOq0kxrFaGaIp6HPDB6WRX3XaPO
         g3lWD1ooJUO+7QLk0XZQcECxOltTNyMqEUmk4wV8iKtZ+Fz3jyOoHxKbFdW3LoXIm5
         0VVTWIIrnjdQQUcZ9QYqQHi04cr/mlYEDEyJR4eZOrml1qoQ7t5r7m9iYeuurnkPVr
         lz1anhDGhvPkg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j92rGpVRavqm; Thu, 20 Feb 2020 16:33:30 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 64AF82591AC;
        Thu, 20 Feb 2020 16:33:30 -0500 (EST)
Date:   Thu, 20 Feb 2020 16:33:30 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Message-ID: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
Subject: Rseq registration: Google tcmalloc vs glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Index: cKUnKpwYxwNeLX5048w9AFEVK9mHtA==
Thread-Topic: Rseq registration: Google tcmalloc vs glibc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

As one of the maintainers of the Rseq system call in the Linux kernel, I would
like to thank the Google team for open sourcing a tcmalloc implementation based
on Rseq!

I've looked into some critical integration aspects of the tcmalloc implementation,
and would like to bring up a topic which involves both tcmalloc developers and the
glibc community.

I have been discussing aspects of co-existence between early Rseq adopter libraries
and glibc for the past year with the glibc community, and tcmalloc happens to be the
first project to publicly use Rseq outside of prototype branches or selftests code.
Considering that there can only be one Rseq registration per thread (as imposed by
the rseq ABI), there needs to be some kind of protocol between libraries to ensure we
don't introduce regressions when we eventually combine a newer glibc which takes care
of registration of the __rseq_abi TLS along with tcmalloc which also try to perform
that registration within the same thread.

Throughout the various rounds of review of the glibc Rseq integration patch set,
there were a few solutions envisioned. Here is a brief history:

1) Introduce a __rseq_refcount TLS variable.

- Currently used by Linux tools/testing/selftests/rseq/rseq.c,
- Currently used by Google tcmalloc,
- Emitted by glibc as well my the original patchset (but was later removed),

A user incrementing the refcount from 0 -> 1 performs rseq registration.
The last user decrementing from 1 -> 0 performs rseq unregistration.

Works for co-existence of dlopen'd/dlclose'd libraries, for dynamically
linked libraries, and for the main executable.

The refcounting was deemed too complex for glibc's needs (it always
exists for the entire executable's lifetime), so we moved to
__rseq_handled instead.


2) Introduce a __rseq_handled global variable.

- Currently used by Linux tools/testing/selftests/rseq/rseq.c,
- At some point emitted by glibc as well in my patch set (but was later
  removed),

A library may take rseq ownership if it is still 0 when executing the
library constructor. Set to 1 by library constructor when handling rseq.
Set to 0 in destructor if handling rseq.

Not meant to be set by dlopen'd/dlclose'd libraries, only by libraries
existing for the whole lifetime of the executable and/or the main executable.

This __rseq_handled symbol has been identified as being somewhat redundant
with the information provided in the __rseq_abi.cpu_id field (uninitialized
state), which motivated removing this symbol from the glibc integration
entirely. The only reason for having __rseq_handled separate from
__rseq_abi.cpu_id was because it was then impossible to touch TLS data
early in the glibc initialization. This issue was later resolved within
glibc.


3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
registered.

- Current protocol in the most recent glibc integration patch set.
- Not supported yet by Linux kernel rseq selftests,
- Not supported yet by tcmalloc,

Use the per-thread state to figure out whether each thread need to register
Rseq individually.

Works for integration between a library which exists for the entire lifetime
of the executable (e.g. glibc) and other libraries. However, it does not
allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
having a library like glibc handling the registration present.

So overall, I suspect the protocol we want for early adopters is that they
only register Rseq if __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED, which
ensure they do not get -1, errno = EBUSY when linked against a newer glibc
which handles Rseq registration. In order to handle multiple early adopters
dlopen'd/dlclose'd in the same executable, those should synchronize with a
__rseq_refcount TLS reference count, but it does not have to be taken into
account by the main executable or libraries present for the entire executable
lifetime (like glibc).

Based on this, what I think would be missing from the current Google tcmalloc
implementation is a check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED
in InitThreadPerCpu().

Is tcmalloc ever meant to be dlopen'd/dlclose'd (either directly or indirectly),
or is it required to exist for the entire executable lifetime ? The check and
increment of __rseq_refcount is only useful to co-exist with dlopen'd/dlclose'd
libraries, but it would not allow discovering the presence of a glibc which
takes care of the rseq registration with the planned protocol. A dlopen'd
library should then only perform rseq unregistration if if brings the
__rseq_refcount back to 0 (e.g. in a pthread_key destructor).

Adding this check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED is something
I need to do in the Linux rseq selftests, but I refrained from submitting any
further change to those tests until the glibc rseq integration gets finally
merged.

Is it something that could be easily changed at this stage in Google tcmalloc,
or should we reconsider adding back __rseq_refcount within the glibc integration
patch set, even though it is not strictly useful to glibc ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
