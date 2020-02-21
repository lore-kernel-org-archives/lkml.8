Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEACC35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4C24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DK3kcGZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgBUNIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:08:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727039AbgBUNIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582290491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXU/eN98n1hMdjILQBnf3oZaoQApR1TvpqWcSosuqZE=;
        b=DK3kcGZS4Fk8SXaem8M+w6dFPyb2Htf6TsnL+MTQ3zdJtuEfPpIKKKAHP7JZjAGhLUsZki
        AW9I2tnQADJ3cEsGXxXUk3pNv+F+IKLvm4fmfOZGA8hZ0UNo/U5upOgwcfdEehHUWBhSbS
        l4Lzyze43jdQCH0CYhOXHxZVqJNAzj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Y-5cfoQhPMux-hiRI-H9yg-1; Fri, 21 Feb 2020 08:08:05 -0500
X-MC-Unique: Y-5cfoQhPMux-hiRI-H9yg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33DE8184B127;
        Fri, 21 Feb 2020 13:08:03 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-104.ams2.redhat.com [10.36.116.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3192B90F71;
        Fri, 21 Feb 2020 13:07:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Chris Kennelly <ckennelly@google.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        "Carlos O'Donell" <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
        <CAEE+ybmTzNoBc9YmK2j48MKtSoPHC_1Mgr+ojPpiOTTc+4E=9g@mail.gmail.com>
Date:   Fri, 21 Feb 2020 14:07:58 +0100
In-Reply-To: <CAEE+ybmTzNoBc9YmK2j48MKtSoPHC_1Mgr+ojPpiOTTc+4E=9g@mail.gmail.com>
        (Chris Kennelly's message of "Thu, 20 Feb 2020 23:23:39 -0500")
Message-ID: <87a75cgkb5.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting in full to get this message to libc-alpha, past the text/html
filter.  I wish we had a different list configuration =E2=80=A6

Please Note that we have integration patches for glibc which need
review.  A fair number of them have been written by me, so I can't help
with that.

* Chris Kennelly:

> On Thu, Feb 20, 2020 at 4:33 PM Mathieu Desnoyers <mathieu.desnoyers@effi=
cios.com>
> wrote:
>
>  Hi Chris,
>
>  As one of the maintainers of the Rseq system call in the Linux kernel, I=
 would
>  like to thank the Google team for open sourcing a tcmalloc implementatio=
n based
>  on Rseq!
>
>  I've looked into some critical integration aspects of the tcmalloc imple=
mentation,
>  and would like to bring up a topic which involves both tcmalloc develope=
rs and the
>  glibc community.
>
> Thanks.  To answer the later questions first:
> * I implemented TCMalloc's upstream rseq based on the conventions I could=
 find from
> (mostly) the kernel self tests.  This is probably why it looks like #1 :)
>
> This is less of an intentional preference and more of "it's important tha=
t early adopters follow
> a convention" for future glibc upgrades.  Initializing __rseq_abi is the =
most important, but
> there are some other ones, mostly for debugging/tracing
> (https://github.com/compudj/librseq/issues/1), that I'd like to get right=
 too.
>
> * The TCMalloc project does not provide ABI stability, so TCMalloc can ch=
ange the convention
> it follows.
>=20=20
>  I have been discussing aspects of co-existence between early Rseq adopte=
r libraries
>  and glibc for the past year with the glibc community, and tcmalloc happe=
ns to be the
>  first project to publicly use Rseq outside of prototype branches or self=
tests code.
>  Considering that there can only be one Rseq registration per thread (as =
imposed by
>  the rseq ABI), there needs to be some kind of protocol between libraries=
 to ensure we
>  don't introduce regressions when we eventually combine a newer glibc whi=
ch takes care
>  of registration of the __rseq_abi TLS along with tcmalloc which also try=
 to perform
>  that registration within the same thread.
>
>  Throughout the various rounds of review of the glibc Rseq integration pa=
tch set,
>  there were a few solutions envisioned. Here is a brief history:
>
>  1) Introduce a __rseq_refcount TLS variable.
>
>  - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
>  - Currently used by Google tcmalloc,
>  - Emitted by glibc as well my the original patchset (but was later remov=
ed),
>
>  A user incrementing the refcount from 0 -> 1 performs rseq registration.
>  The last user decrementing from 1 -> 0 performs rseq unregistration.
>
>  Works for co-existence of dlopen'd/dlclose'd libraries, for dynamically
>  linked libraries, and for the main executable.
>
>  The refcounting was deemed too complex for glibc's needs (it always
>  exists for the entire executable's lifetime), so we moved to
>  __rseq_handled instead.
>
>  2) Introduce a __rseq_handled global variable.
>
>  - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
>  - At some point emitted by glibc as well in my patch set (but was later
>    removed),
>
>  A library may take rseq ownership if it is still 0 when executing the
>  library constructor. Set to 1 by library constructor when handling rseq.
>  Set to 0 in destructor if handling rseq.
>
>  Not meant to be set by dlopen'd/dlclose'd libraries, only by libraries
>  existing for the whole lifetime of the executable and/or the main execut=
able.
>
>  This __rseq_handled symbol has been identified as being somewhat redunda=
nt
>  with the information provided in the __rseq_abi.cpu_id field (uninitiali=
zed
>  state), which motivated removing this symbol from the glibc integration
>  entirely. The only reason for having __rseq_handled separate from
>  __rseq_abi.cpu_id was because it was then impossible to touch TLS data
>  early in the glibc initialization. This issue was later resolved within
>  glibc.
>
>  3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
>  registered.
>
>  - Current protocol in the most recent glibc integration patch set.
>  - Not supported yet by Linux kernel rseq selftests,
>  - Not supported yet by tcmalloc,
>
>  Use the per-thread state to figure out whether each thread need to regis=
ter
>  Rseq individually.
>
>  Works for integration between a library which exists for the entire life=
time
>  of the executable (e.g. glibc) and other libraries. However, it does not
>  allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
>  having a library like glibc handling the registration present.
>
> Overall, I like #3 the most due to its simplicity, but I also do not need=
 to support the
> dlopen/dlclose use case (below).
>=20=20
>  So overall, I suspect the protocol we want for early adopters is that th=
ey
>  only register Rseq if __rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_UNINITIALIZED=
, which
>  ensure they do not get -1, errno =3D EBUSY when linked against a newer g=
libc
>  which handles Rseq registration. In order to handle multiple early adopt=
ers
>  dlopen'd/dlclose'd in the same executable, those should synchronize with=
 a
>  __rseq_refcount TLS reference count, but it does not have to be taken in=
to
>  account by the main executable or libraries present for the entire execu=
table
>  lifetime (like glibc).=20
>
>  Based on this, what I think would be missing from the current Google tcm=
alloc
>  implementation is a check for __rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_UNINI=
TIALIZED
>  in InitThreadPerCpu().
>
> TCMalloc does not get to InitThreadPerCpu without that check.
>
> Before initialization happens, we
> * end up on a slow path
> https://github.com/google/tcmalloc/blob/master/tcmalloc/tcmalloc.cc#L1486
> * which checks UsePerCpuCache
> https://github.com/google/tcmalloc/blob/master/tcmalloc/cpu_cache.h#L222
> * and inspects the TLS variable in IsFast
> https://github.com/google/tcmalloc/blob/master/tcmalloc/internal/percpu.h=
#L171
> ...which triggers per-thread rseq registration if __rseq_abi.cpu_id is un=
initialized.
>
> Otherwise, the IsOnFastPath() call checks also inspects __rseq_abi.cpu_id=
 via IsFastNoInit
> (same thing, but no registration triggered).
>
>  Is tcmalloc ever meant to be dlopen'd/dlclose'd (either directly or indi=
rectly),
>  or is it required to exist for the entire executable lifetime ? The chec=
k and
>  increment of __rseq_refcount is only useful to co-exist with dlopen'd/dl=
close'd
>  libraries, but it would not allow discovering the presence of a glibc wh=
ich
>  takes care of the rseq registration with the planned protocol. A dlopen'd
>  library should then only perform rseq unregistration if if brings the
>  __rseq_refcount back to 0 (e.g. in a pthread_key destructor).
>
> TCMalloc cannot practically be dlopen'd or dlclose'd.
> * Once memory is allocated with one instance of malloc (or operator new),=
 it needs to be
> free'd to the same heap.
> * dlclose is explicitly not supported by our dependencies ("do not rely o=
n dynamic
> unloading" https://abseil.io/about/compatibility)
>
> Thanks,
> Chris
>
>  Adding this check for __rseq_abi.cpu_id =3D=3D RSEQ_CPU_ID_UNINITIALIZED=
 is something
>  I need to do in the Linux rseq selftests, but I refrained from submittin=
g any
>  further change to those tests until the glibc rseq integration gets fina=
lly
>  merged.
>
>  Is it something that could be easily changed at this stage in Google tcm=
alloc,
>  or should we reconsider adding back __rseq_refcount within the glibc int=
egration
>  patch set, even though it is not strictly useful to glibc ?
>
>  Thanks,
>
>  Mathieu
>
>  --=20
>  Mathieu Desnoyers
>  EfficiOS Inc.
>  http://www.efficios.com

