Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E479C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CB8221F7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ju5myjo5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgGNJ6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53750 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725997AbgGNJ6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594720715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tevPa9X+MuCxM/DtuuMw5c+0nqEV5by4X2ZM7PHae8=;
        b=Ju5myjo51qkzBX9hN1cE/Lk3dVa6H3xz+eIZ0qicPCjYeHlA385FiXC+kq/S/Kz9shmlh3
        +vY3IrsStOw4z/ssfrmlutUZVMPtEnZR8ixb27tIvPA9/bkZwgyMpE3+2IToLJMUu2koNE
        IpRN3Se5zacEEMLxJ5TXXhinYK69cVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-GXHhLnlKMqCVeKX5-K7ZOw-1; Tue, 14 Jul 2020 05:58:33 -0400
X-MC-Unique: GXHhLnlKMqCVeKX5-K7ZOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263021009440;
        Tue, 14 Jul 2020 09:58:32 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-246.ams2.redhat.com [10.36.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA93D72E54;
        Tue, 14 Jul 2020 09:58:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos@redhat.com
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
Date:   Tue, 14 Jul 2020 11:58:25 +0200
In-Reply-To: <20200714030348.6214-3-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 13 Jul 2020 23:03:46 -0400")
Message-ID: <87mu42bepq.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> +	/*
> +	 * Very last field of the structure, to calculate size excluding padding
> +	 * with offsetof().
> +	 */
> +	char end[];
>  } __attribute__((aligned(4 * sizeof(__u64))));

This makes the header incompatible with standard C++.

How are extensions going to affect the definition of struct rseq,
including its alignment?

As things stand now, glibc 2.32 will make the size and alignment of
struct rseq part of its ABI, so it can't really change after that.

With a different approach, we can avoid making the symbol size part of
the ABI, but then we cannot use the __rseq_abi TLS symbol.  As a result,
interoperability with early adopters would be lost.

One way to avoid this problem would be for every library to register its
own rseq area, of the appropriate size.  Then process-wide coordination
in userspace would not be needed.

Thanks,
Florian

