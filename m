Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D7AC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 337FC222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Gys2M1rU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgBUQNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:13:54 -0500
Received: from mail.efficios.com ([167.114.26.124]:58648 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgBUQNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:13:54 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 34059260BCE;
        Fri, 21 Feb 2020 11:13:53 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id c7vZusTWutJP; Fri, 21 Feb 2020 11:13:52 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C6C87260D14;
        Fri, 21 Feb 2020 11:13:52 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C6C87260D14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582301632;
        bh=i4/JFZqxh7npdYYNKOpTF3g1l9o9iVzv8QM5fojaOrI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Gys2M1rU74CRMa9I8KyccloZP+O06an3jwOZPqUTluNw2w6+o4WyspM9OUPjmLwpQ
         Y3aojss2NXEjuVtHpW71dxAgp2QRL5gdON7VJ3ZxPHnqUXz7fHLKg2GlCmOXIec7Eu
         tOgo2xfMyVtvJzRnoSZE7y7w17RplS2PY/AFPMkZcc0Gm5h8ZK3/11RPOcVX8xFeaC
         8UuLsbSr3eDAGxR5DVuRaTiDfQek1UI2brAe0q/Ns9qlUoseknspPnbNwNtGSUZxFa
         2dJlf+VtN1RlTq/GZrUapPAo0WWt35iGNJCdmON8CqVs0TgqybA3GeIXQbrGFh8kTd
         RGTfvOlB7Z3Rg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rcUUqSBRNBlP; Fri, 21 Feb 2020 11:13:52 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B686C260A45;
        Fri, 21 Feb 2020 11:13:52 -0500 (EST)
Date:   Fri, 21 Feb 2020 11:13:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Message-ID: <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200221154923.GC194360@google.com>
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com> <20200221154923.GC194360@google.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Rseq registration: Google tcmalloc vs glibc
Thread-Index: ZF/e9TUM/XBemxf1rZL3jaL+y7b4Yw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 21, 2020, at 10:49 AM, Joel Fernandes, Google joel@joelfernandes.org wrote:

[...]
>> 
>> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
>> registered.
>> 
>> - Current protocol in the most recent glibc integration patch set.
>> - Not supported yet by Linux kernel rseq selftests,
>> - Not supported yet by tcmalloc,
>> 
>> Use the per-thread state to figure out whether each thread need to register
>> Rseq individually.
>> 
>> Works for integration between a library which exists for the entire lifetime
>> of the executable (e.g. glibc) and other libraries. However, it does not
>> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
>> having a library like glibc handling the registration present.
> 
> Mathieu, could you share more details about why during dlopen/close
> libraries we cannot use the same __rseq_abi TLS to detect that rseq was
> registered?

Sure,

A library which is only loaded and never closed during the execution of the
program can let the kernel implicitly unregister rseq at thread exit. For
the dlopen/dlclose use-case, we need to be able to explicitly unregister
each thread's __rseq_abi which sit in a library which is going to be
dlclose'd. 

The issue is that __rseq_abi.cpu_id does not track any reference counting
of rseq user libraries, which becomes an issue if we have many of those
libraries around with different life-time.

As an example scenario, let's suppose we have a single-threaded application
which does the following:

main()
  dlopen(liba)
    -> liba's constructor observes uninitialized __rseq_abi.cpu_id, thus
       performs rseq registration
  dlopen(libb)
    -> libb's constructor observes that rseq is already registered.

  dlclose(libb)
    -> libb's destructor unregisters rseq.

  -> at this point, liba is still loaded, and would still expect rseq to
     be registered. But unfortunately rseq has been unregistered by libb.

  dlclose(liba)
    -> rseq is already unregistered, which is unexpected.

The TLS __rseq_refcount solves this by tracking the number of users of
rseq for the thread, so rseq is only unregistered when the very last user
decrements the reference count.

As soon as there is at least one library taking care of registering rseq
for the entire thread's duration (e.g. glibc), and that this library
guarantees to never be dlclose'd, the __rseq_refcount becomes unneeded.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
