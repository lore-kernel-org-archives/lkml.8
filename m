Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73666C47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0D20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 01:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="GTHAsXCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgEFBfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 21:35:47 -0400
Received: from ozlabs.org ([203.11.71.1]:33541 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgEFBfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 21:35:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49Gzgg6gf5z9sSr;
        Wed,  6 May 2020 11:35:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588728944;
        bh=KUYO+PR8+oJRVW9bjsUzpPhTlm5eKF6/oKJKp8Jeo0g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GTHAsXCUiXz5gZz3YepcK5hmp0cRbu6B1DOYuP4H0C577S3a6m8KBhhKu1Gpq/cJn
         DeWjzEeke2mr2CutozGTmoG98bACusrP5pMOowZTpqCxSD06ganBizqL1J2HHKl7rZ
         0OOAfZyx5T+dwBG32Qar+O6gH/1QJ6EXezRf1wCsYbBIIsI5qaAhvKG+b9eXcgjrjs
         RkFBVRebIORbX84qfdQ4Cl3bgJXhiDSuj9XhZW9sIuwCxvWvrFZeGq2PUzqdCjzlLw
         KvjIuVsYvopt8AEH+SWbBipwDB9zPkLnWsQ9htr8IAf7zVJ4QL/q7Vy0bdPoCI0rrW
         h7Y2ZZ7I8E8Sw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
In-Reply-To: <20200505155944.GO31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr> <87sggecv81.fsf@mpe.ellerman.id.au> <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu> <20200505155944.GO31009@gate.crashing.org>
Date:   Wed, 06 May 2020 11:36:00 +1000
Message-ID: <87lfm5dev3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, May 05, 2020 at 05:40:21PM +0200, Christophe Leroy wrote:
>> >>+#define __put_user_asm_goto(x, addr, label, op)			\
>> >>+	asm volatile goto(					\
>> >>+		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
>> >>+		EX_TABLE(1b, %l2)				\
>> >>+		:						\
>> >>+		: "r" (x), "m<>" (*addr)				\
>> >
>> >The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
>> >
>> >Plain "m" works, how much does the "<>" affect code gen in practice?
>> >
>> >A quick diff here shows no difference from removing "<>".
>> 
>> It was recommended by Segher, there has been some discussion about it on 
>> v1 of this patch, see 
>> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr/
>> 
>> As far as I understood that's mandatory on recent gcc to get the 
>> pre-update form of the instruction. With older versions "m" was doing 
>> the same, but not anymore.
>
> Yes.  How much that matters depends on the asm.  On older CPUs (6xx/7xx,
> say) the update form was just as fast as the non-update form.  On newer
> or bigger CPUs it is usually executed just the same as an add followed
> by the memory access, so it just saves a bit of code size.

The update-forms are stdux, sthux etc. right?

I don't see any change in the number of those with or without the
constraint. That's using GCC 9.3.0.

>> Should we ifdef the "m<>" or "m" based on GCC 
>> version ?
>
> That will be a lot of churn.  Just make 4.8 minimum?

As I said in my other mail that's not really up to us. We could mandate
a higher minimum for powerpc, but I'd rather not.

I think for now I'm inclined to just drop the "<>", and we can revisit
in a release or two when hopefully GCC 4.8 has become the minimum.

cheers
