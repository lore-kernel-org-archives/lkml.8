Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E3DC4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C70120768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Y3qHO+96"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgCRXgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:36:25 -0400
Received: from ozlabs.org ([203.11.71.1]:37095 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgCRXgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:36:25 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48jRJ617n2z9sPF;
        Thu, 19 Mar 2020 10:36:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584574582;
        bh=1wPd69g706f1HjFfq9A1c68BcRSf6tB8V7w5oED57sM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y3qHO+96wskzfknqGg/UlEnfIqCdso3oDbRgMS0Dac4PRP15nGV4cX6mlLOSw2rzY
         AysVFPwCCecrESjxP0uFDE36gveIubypVLh6FtB0HfzfLd8yxnFwiPXHkkBjFtKqIn
         bLUHjitp5jZomJ2w709RjolUQ3BUd7a+jJaMWVfdhvlK2KXxTqD0qz4gEMZeR5u19B
         +sDUVcHtt38CupYOthm7diYgSoRJFk/+h78MgrnHIyM0idckC92+y0MaZ8/cntNOoP
         V9dMzkAAGi/04pQxC4UKnXS+iKcuyUvpNUSCqA8qRWCPRpvSjXc1IA9DCZsTfYD1rS
         S8bQh6px1tAkA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>, mikey@neuling.org,
        apopple@linux.ibm.com, peterz@infradead.org, fweisbec@gmail.com,
        oleg@redhat.com, npiggin@gmail.com, linux-kernel@vger.kernel.org,
        paulus@samba.org, jolsa@kernel.org,
        naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        mingo@kernel.org
Subject: Re: [PATCH 12/15] powerpc/watchpoint: Prepare handler to handle more than one watcnhpoint
In-Reply-To: <20200318212726.GN22482@gate.crashing.org>
References: <20200309085806.155823-1-ravi.bangoria@linux.ibm.com> <20200309085806.155823-13-ravi.bangoria@linux.ibm.com> <3ba94856-0d87-5046-eca9-b5c3d99ec654@c-s.fr> <87zhcdevz7.fsf@mpe.ellerman.id.au> <a7829a23-9b4d-0248-415e-85409f17dd77@c-s.fr> <20200318212726.GN22482@gate.crashing.org>
Date:   Thu, 19 Mar 2020 10:36:22 +1100
Message-ID: <87wo7hdymh.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Wed, Mar 18, 2020 at 12:44:52PM +0100, Christophe Leroy wrote:
>> Le 18/03/2020 =C3=A0 12:35, Michael Ellerman a =C3=A9crit=C2=A0:
>> >Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> >>Le 09/03/2020 =C3=A0 09:58, Ravi Bangoria a =C3=A9crit=C2=A0:
>> >>>Currently we assume that we have only one watchpoint supported by hw.
>> >>>Get rid of that assumption and use dynamic loop instead. This should
>> >>>make supporting more watchpoints very easy.
>> >>
>> >>I think using 'we' is to be avoided in commit message.
>> >
>> >Hmm, is it?
>> >
>> >I use 'we' all the time. Which doesn't mean it's correct, but I think it
>> >reads OK.
>> >
>> >cheers
>>=20
>> From=20
>> https://www.kernel.org/doc/html/latest/process/submitting-patches.html :
>>=20
>> Describe your changes in imperative mood, e.g. =E2=80=9Cmake xyzzy do fr=
otz=E2=80=9D=20
>> instead of =E2=80=9C[This patch] makes xyzzy do frotz=E2=80=9D or =E2=80=
=9C[I] changed xyzzy=20
>> to do frotz=E2=80=9D, as if you are giving orders to the codebase to cha=
nge its=20
>> behaviour.
>
> That is what is there already?  "Get rid of ...".
>
> You cannot describe the current situation with an imperative.

Yeah, I think the use of 'we' and the imperative mood are separate
things.

ie. this uses 'we' to describe the current behaviour and then the
imperative mood to describe the change that's being made:

  Currently we assume xyzzy always does bar, which is incorrect.

  Change it to do frotz.


cheers
