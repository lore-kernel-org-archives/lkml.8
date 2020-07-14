Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02953C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D186D20739
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUNXTRCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgGNNA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:00:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbgGNNA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594731627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aMkXnOTuFZ2jMVFd+eEKpMBPsCP+t2ST7hOj6unA51o=;
        b=cUNXTRCiKMc5dy87VN+Eg2oRxAnNuADtqcLm0vS9QLkpLC6qqOYMHazyjQlmlv5y6b3Epz
        sWDgzds4qxfvIW9bG5awZ5Nk2XVqPVzYb2vvvZdWQLGg826WNVvTNp/AHMdkwSUnD2YbK1
        kg0GP0e0MHbMLnj72nKU2WYS0b1APuY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-8KGSR5ANOEOnQed3gXCn-g-1; Tue, 14 Jul 2020 09:00:22 -0400
X-MC-Unique: 8KGSR5ANOEOnQed3gXCn-g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E3E19057A1;
        Tue, 14 Jul 2020 13:00:20 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-246.ams2.redhat.com [10.36.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C749E10098A4;
        Tue, 14 Jul 2020 13:00:14 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos <carlos@redhat.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
        <87mu42bepq.fsf@oldenburg2.str.redhat.com>
        <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
Date:   Tue, 14 Jul 2020 15:00:13 +0200
In-Reply-To: <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 14 Jul 2020 08:50:35 -0400
        (EDT)")
Message-ID: <87a7028d5u.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

>> How are extensions going to affect the definition of struct rseq,
>> including its alignment?
>
> The alignment will never decrease. If the structure becomes large enough
> its alignment could theoretically increase. Would that be an issue ?

Telling the compiler that struct is larger than it actually is, or that
it has more alignment than in memory, results in undefined behavior,
even if only fields are accessed in the smaller struct region.

An increase in alignment from 32 to 64 is perhaps not likely to have
this effect.  But the undefined behavior is still there, and has been
observed for mismatches like 8 vs 16.

>> As things stand now, glibc 2.32 will make the size and alignment of
>> struct rseq part of its ABI, so it can't really change after that.
>
> Can the size and alignment of a structure be defined as minimum alignment
> and size values ? For instance, those would be invariant for a given glibc
> version (if we always use the internal struct rseq declaration), but could
> be increased in future versions.

Not if we are talking about a global (TLS) data symbol.  No such changes
are possible there.  We have some workarounds for symbols that live
exclusively within glibc, but they don't work if there are libraries out
there which interpose the symbol.

>> With a different approach, we can avoid making the symbol size part of
>> the ABI, but then we cannot use the __rseq_abi TLS symbol.  As a result,
>> interoperability with early adopters would be lost.
>
> Do you mean with a function "getter", and then keeping that pointer around
> in a per-user TLS ? I would prefer to avoid that because it adds an extra
> pointer dereference on a fast path.

My choice would have been a function that returns the offset from the
thread pointer (which has to be unchanged regarding all threads).

Thanks,
Florian

