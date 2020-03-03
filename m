Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C79C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E4C20866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ONFZwebO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgCCJwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:52:24 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:34397 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgCCJwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:52:24 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48WskF721yz9sRR;
        Tue,  3 Mar 2020 20:52:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1583229142;
        bh=Vn8yx1vqIZSvptmQMeeChkpykb4Gd+dJ6/ZPDLdhV2Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ONFZwebOWNefVNSTqvVn/BXSyDwOLi7R5m+Sz74TQ9rktEzbSx3jI9Mm1ibrxkyIQ
         kqMYuh9TgzSJlFqOEgos5GKTsol5YPczZGJ2DH8Q5kQw1YXAXUSF162+rXtsx2cBoE
         Essy42eaVAXr9+UM0EOlU7MZAl2uVm70IzYFzbMVywr6+F9l0UBAcJogj7XwrPPIWW
         wJud3siIgP9D8rp3PbUCRVd/qbQf4N3Ip3MXCsZQFr7LNpyVNVN5YxhSKYy6kTs7sw
         gOBKz97zD5t2ld/9tCt4uPEuRGLLlqrsauRnXJlWrA8Ps3SYGXF9Kf1t/8vpg8RB5D
         0emccjJ3WMp6g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Oliver O'Halloran <oohall@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6] powerpc: powernv: no need to check return value of debugfs_create functions
In-Reply-To: <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org> <20200209105901.1620958-6-gregkh@linuxfoundation.org> <CAOSf1CEKwjDkp-=SMjmJfQirxdGCkadougZbdDS6FK1muNNCZw@mail.gmail.com>
Date:   Tue, 03 Mar 2020 20:52:20 +1100
Message-ID: <87a74xsr3f.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Oliver O'Halloran" <oohall@gmail.com> writes:
> On Mon, Feb 10, 2020 at 12:12 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> When calling debugfs functions, there is no need to ever check the
>> return value.  The function can work or not, but the code logic should
>> never do something different based on this.
>
> For memtrace debugfs is the only way to actually use the feature. It'd
> be nice if it still printed out *something* if it failed to create the
> files rather than just being mysteriously absent

That's true, but the current code doesn't actually do that anyway.

>> diff --git a/arch/powerpc/platforms/powernv/memtrace.c b/arch/powerpc/platforms/powernv/memtrace.c
>> index eb2e75dac369..d6d64f8718e6 100644
>> --- a/arch/powerpc/platforms/powernv/memtrace.c
>> +++ b/arch/powerpc/platforms/powernv/memtrace.c
>> @@ -187,11 +187,6 @@ static int memtrace_init_debugfs(void)
>>
>>                 snprintf(ent->name, 16, "%08x", ent->nid);
>>                 dir = debugfs_create_dir(ent->name, memtrace_debugfs_dir);
>> -               if (!dir) {
>> -                       pr_err("Failed to create debugfs directory for node %d\n",
>> -                               ent->nid);
>> -                       return -1;
>> -               }

debugfs_create_dir() doesn't return NULL on error, it returns
ERR_PTR(-ENOMEM), which will not trigger that pr_err().

So I've merged this and if someone wants to they can send a follow-up to
do proper error checking in memtrace.c

cheers
