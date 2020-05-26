Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E49C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA66120706
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="c7I+JSwB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388591AbgEZDZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388478AbgEZDZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:25:18 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681E4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 20:25:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49WK8n41JWz9sRW;
        Tue, 26 May 2020 13:25:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590463515;
        bh=EuyE1DTbxcWhCkVOvnT3Nye5fIuEnQS303Y4ecOW4aA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=c7I+JSwBWE0cUqbYPa7xs6INyMPaS3afiQUhP1Q8CifNu73WVZJZkdgXYlEpvgf5G
         4oMnFAYK94XPOwaYcNgAn2hZ4PQwEqAxkVi5Or3xztH9tLXdnDiN0auD/x/+SmEPi4
         dmlMdr1Yp1nfgXh4PT7/J4osQZTadbUmReJfdQh331dCHKkji6h63JXkG4ve0WpHKE
         kbr2J4c1Z6khtVD4eAuvfaFify7x78t1cLOlrRgk0iNONukXge0RhDYDrLD6I7MRyq
         gT1Df0FkqzKti0Rr+WXOe8Ksfq3YFvW9VThe+R9godADWqeevOTbxuBRV0h30kkjq1
         pbm687WNakNqA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        ajd@linux.ibm.com,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Axtens <dja@axtens.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] relay: handle alloc_percpu returning NULL in relay_open
In-Reply-To: <87ftbo232s.fsf@dja-thinkpad.axtens.net>
References: <20191219121256.26480-1-dja@axtens.net> <alpine.DEB.2.21.1912201100400.68407@chino.kir.corp.google.com> <20200521152514.GA2868125@eldamar.local> <87ftbo232s.fsf@dja-thinkpad.axtens.net>
Date:   Tue, 26 May 2020 13:25:36 +1000
Message-ID: <878shffkcv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ + akpm ]

Daniel Axtens <dja@axtens.net> writes:
>>> > Check if alloc_percpu returns NULL.
>>> > 
>>> > This was found by syzkaller both on x86 and powerpc, and the reproducer
>>> > it found on powerpc is capable of hitting the issue as an unprivileged
>>> > user.
>>> > 
>>> > Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
>>> > Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
>>> > Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
>>> > Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
>>> > Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
>>> > Cc: Akash Goel <akash.goel@intel.com>
>>> > Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
>>> > Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
>>> > Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
>>> > Cc: stable@vger.kernel.org # v4.10+
>>> > Signed-off-by: Daniel Axtens <dja@axtens.net>
>>> 
>>> Acked-by: David Rientjes <rientjes@google.com>
>>
>> It looks this one was never applied (which relates to CVE-2019-19462,
>> as pointed by Guenter in 20191223163610.GA32267@roeck-us.net).
>>
>> Whas this lost or are there any issues pending?
>
> I'm not aware of any pending issues.
>
> (But, if anyone does have any objections I'm happy to revise the patch.)

It looks like kernel/relay.c is lacking a maintainer?

Andrew are you able to pick this up for v5.8? It's pretty obviously
correct, and has David's ack.

Original is here if that helps:
  https://lore.kernel.org/lkml/20191219121256.26480-1-dja@axtens.net/


cheers
