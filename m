Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 15:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB34923135
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 15:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ML510IxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgHFPRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 11:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgHFOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 10:20:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F2C03460C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:38:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BMnvf1j5rz9sPC;
        Thu,  6 Aug 2020 22:33:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596717182;
        bh=TAjJwS8vlxBW7QvhvZsI4TIjVO26d8rrgTrwu4jH/ds=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ML510IxLqcGl6DYF2mWi34tO+E9wo6FolIaLFXJKWEepZqHA2W9oTRIQ/Vd/1Mpor
         /AOuCO+aNnjrvWlqn8S+y+AXFfRNlFnsgCsoA0At/9ubLlDq+Kf5I1Yo23yIzVcXON
         rXmGnrxfpM/hJdzSDXbzTme+c3Ut4g140pPbS2P7FIpM2Shd2pRZUDlW5OT3+Kv2FM
         +6d73MFgNQk0PHxPQ+cXPEU2egHsRlhMoxVDV4wH3QYD9psG9fS0iqqb86GWkbqbj1
         p3v3vF0hr0gsbbJ/39rvIkgIILwMPPrYo1xFigCsIbVwOQcEROUtT85rLq8FJ6Lqua
         MhSa82/pb2sng==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/uaccess: simplify the get_fs() set_fs() logic
In-Reply-To: <2d0b777d-f1aa-08a1-f287-47ac68efbd99@csgroup.eu>
References: <dd2876b808ea38eb7b7f760ecd6ce06096c61fb5.1580295551.git.christophe.leroy@c-s.fr> <87mu3nyh3w.fsf@mpe.ellerman.id.au> <2d0b777d-f1aa-08a1-f287-47ac68efbd99@csgroup.eu>
Date:   Thu, 06 Aug 2020 22:33:01 +1000
Message-ID: <87a6z8ymwy.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 25/07/2020 =C3=A0 13:22, Michael Ellerman a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>> Unfortunately this would collide messily with "uaccess: remove
>> segment_eq" in linux-next, so I'll ask you to do a respin based on that,
>> some comments below.
>
> Done, sent as v3, together with the 2 patchs from Linux next to get it=20
> build and boot.

Thanks.

>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>> On powerpc, we only have USER_DS and KERNEL_DS
>>>
>>> Today, this is managed as an 'unsigned long' data space limit
>>> which is used to compare the passed address with, plus a bit
>>> in the thread_info flags that is set whenever modifying the limit
>>> to enable the verification in addr_limit_user_check()
>>>
>>> The limit is either the last address of user space when USER_DS is
>>> set, and the last address of address space when KERNEL_DS is set.
>>> In both cases, the limit is a compiletime constant.
>>>
>>> get_fs() returns the limit, which is part of thread_info struct
>>> set_fs() updates the limit then set the TI_FSCHECK flag.
>>> addr_limit_user_check() check the flag, and if it is set it checks
>>> the limit is the user limit, then unsets the TI_FSCHECK flag.
>>>
>>> In addition, when the flag is set the syscall exit work is involved.
>>> This exit work is heavy compared to normal syscall exit as it goes
>>> through normal exception exit instead of the fast syscall exit.
>>>
>>> Rename this TI_FSCHECK flag to TIF_KERNEL_DS flag which tells whether
>>> KERNEL_DS or USER_DS is set. Get mm_segment_t be redifined as a bool
>>> struct that is either false (for USER_DS) or true (for KERNEL_DS).
>>> When TIF_KERNEL_DS is set, the limit is ~0UL. Otherwise it is
>>> TASK_SIZE_USER (resp TASK_SIZE_USER64 on PPC64). When KERNEL_DS is
>>> set, there is no range to check. Define TI_FSCHECK as an alias to
>>> TIF_KERNEL_DS.
>>=20
>> I'd rather avoid the "DS" name any more than we have to. Maybe it means
>> "data space" but that's not a very common term.
>
> I thought it was a reference to the ds/fs/gs ... segment registers in=20
> the 8086 ?

Yes.

In your changelog you used "data space limit", so I thought you were
trying to retrospectively redefine the "DS" acronym to mean that.

cheers
