Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E89FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6545E2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pmUJrk5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbgCRLf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:35:58 -0400
Received: from ozlabs.org ([203.11.71.1]:44249 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgCRLf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:35:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48j7Jq0PMzz9sPF;
        Wed, 18 Mar 2020 22:35:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584531355;
        bh=nZ8h3rQzS7YUxkreuIxZFpLLT3jR0FhsbHFPgoPcdJI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pmUJrk5Xi8xhUIwDPK7RrBSmTM7bfHYLCmcnCkHMDg5Mmcz2XrHOFCHIJu8d2FlsI
         q4MJLY3tFtJRGP3j6muDyAgYj5t4txrvmiLBDKQOHLKJSM/fJqUxMNtMiYVBhjk962
         x/hM9lkekXwoYrv/d1iYTXxMG9voCWP9K+vLLxRB/q32U3+Eo8prhE6BRnptmK4GiD
         2g66VqtlIc+3d59dicdTUduQ1qDnhfzseYMli0JI7mkiTC52390FQPTY2AQ3PGC9EL
         OfC72sdtOYl+P20j8LvGjJaBpOAXWkPkpEEYeOHDBmPC7He/nYbKpLSrEWAbYjyqDh
         KnwmX6AS15LxQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org
Cc:     apopple@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] powerpc/watchpoint: Prepare handler to handle more than one watcnhpoint
In-Reply-To: <3ba94856-0d87-5046-eca9-b5c3d99ec654@c-s.fr>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com> <20200309085806.155823-13-ravi.bangoria@linux.ibm.com> <3ba94856-0d87-5046-eca9-b5c3d99ec654@c-s.fr>
Date:   Wed, 18 Mar 2020 22:35:56 +1100
Message-ID: <87zhcdevz7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 09/03/2020 =C3=A0 09:58, Ravi Bangoria a =C3=A9crit=C2=A0:
>> Currently we assume that we have only one watchpoint supported by hw.
>> Get rid of that assumption and use dynamic loop instead. This should
>> make supporting more watchpoints very easy.
>
> I think using 'we' is to be avoided in commit message.

Hmm, is it?

I use 'we' all the time. Which doesn't mean it's correct, but I think it
reads OK.

cheers
