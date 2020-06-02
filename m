Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D190C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D45AB2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1HXvkSvf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgFBTuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:50:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21AEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:50:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so20215pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 12:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Mzflbrhvko6ep9R8wCU2OJXZtq8oTTi/5tkZ4gQS+KU=;
        b=1HXvkSvfGPWZsFf9KXSa+UGDDH/KpDwMQ1AEANLUWLtLYCMadcW2V+7jbK5siUkQzD
         aCr1WhbBlE0ZPeriCj1qZcieohUrQffr92IKQ5DsXah7wZg7XH0x4atSqMdRIxOu+4up
         G58TXs1tA4TrGk+5zlRp4NvXNZNylyw0tLeQ8TJ/XACrEMV2iznvydyGcG0XDoXuevQi
         2YocTCBoSWrTGpmskMxpiQE3vYB5t5tw+2U29okyWjEJua0JVxYDaFxC1yLbhYhk+lD/
         2yAcm2hKSJ/rw4u1Oxo8DBN6gHjAzm9D8bs68A1EPQbZr5sprsq3PoOU/vyNEZvW1Mgt
         iGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Mzflbrhvko6ep9R8wCU2OJXZtq8oTTi/5tkZ4gQS+KU=;
        b=cKGoTso/8VF61puyKZFaejTiq5y3ggxYT7Pg6bMbZqXiZpbuHWFgzr2ZFkZkGY1Yl1
         SmPZsNG1NAT0Bc0NwN5hmS0u3dVqBmhDqObWIvKfLuEtqEruOgZBHUE9O0lmUKweyX/7
         7tXh6fNo5rSLvTCgSFZ0apg4/1eDqU/9fNyzydEQ4Wt45ZY1YUUb9e4hjybQ80Zndyk6
         FHJc5nujrAIfLqGVZp3fd6zPVn3I9u931w8KfuvNaEH6WGvkSAeAKvT7dPQjFzsi5fRG
         kQ3tapPFZBzq0r8JxDKE7K8GyrtWOmg1Mc4elvR6TTWQK7Le8fz/QYt4q37bgdDDyam0
         MyCw==
X-Gm-Message-State: AOAM531roR29vttUVPBmeB09dD1vgsMB6MLwtrMKDO7AVAF13cM4AvhG
        LUPiEx9O2oXh667op6wag/Wiug==
X-Google-Smtp-Source: ABdhPJxlr3NaxlIvKmBsKz+yOh9jZdQ2fh6/hxF4Qy88GQazKgYAnQRroYSTPEuTjdmxlCgzgN9SQQ==
X-Received: by 2002:a62:7e95:: with SMTP id z143mr9750440pfc.108.1591127445044;
        Tue, 02 Jun 2020 12:50:45 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:64fc:8253:a1dc:f79c? ([2601:646:c200:1ef2:64fc:8253:a1dc:f79c])
        by smtp.gmail.com with ESMTPSA id h3sm3083148pfr.2.2020.06.02.12.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 12:50:44 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] arch/x86: reset MXCSR to default in kernel_fpu_begin()
Date:   Tue, 2 Jun 2020 12:50:42 -0700
Message-Id: <C6F6F6E4-CBD8-4E72-812B-99F008ECAA4F@amacapital.net>
References: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Shuah Khan <shuah@kernel.org>,
        Petteri Aimonen <jpa@git.mail.kapsi.fi>,
        Dave Hansen <dave.hansen@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <8b1f0bfa-79b0-74e4-0241-8b2a94491807@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 2, 2020, at 10:27 AM, Shuah Khan <skhan@linuxfoundation.org> wrote:=

>=20
> =EF=BB=BFOn 6/2/20 11:03 AM, Andy Lutomirski wrote:
>>> On Tue, Jun 2, 2020 at 3:56 AM Borislav Petkov <bp@alien8.de> wrote:
>>>=20
>>> Hi,
>>>=20
>>> On Tue, Jun 02, 2020 at 01:29:51PM +0300, Petteri Aimonen wrote:
>>>> The kernel module is not actually x86-specific, even though it is
>>>> currently only enabled for x86. amdgpu driver already does kernel mode
>>>> floating point operations on PPC64 also, and the same module could be
>>>> used to test the same thing there.
>>>=20
>>> Then make it generic please and put the user portion in, say,
>>> tools/testing/selftests/fpu/ and we can ask ppc people to test it too.
>>> People might wanna add more stuff to it in the future, which would be
>>> good.
>>>=20
>>>> To deterministically trigger the bug, the syscall has to come from the
>>>> same thread that has modified MXCSR. Going through /usr/sbin/modprobe
>>>> won't work, and manually doing the necessary syscalls for module loadin=
g
>>>> seems too complicated.
>>>=20
>>> Ok, fair enough. But put that file in debugfs pls.
>> I think I agree.  While it would be delightful to have general
>> selftest tooling for kernel modules, we don't have that right now, and
>> having the test just work with an appropriately configured kernel
>> would be nice.
>=20
> Let's extend it to do what we want it to do. I will happy to take
> patches. If you have some concrete ideas on what we can add, please
> do a short summary of what is missing. I will find a way to get this
> done.
>=20
>> How about putting the file you frob in
>> /sys/kernel/debug/selftest_helpers/something_or_other.  The idea would
>> be that /sys/kernel/debug/selftest_helpers would be a general place
>> for kernel helpers needed to make selftests work.
>=20
> Is this a workaround for the lack of selftest tooling for kernel
> modules? In which case, let's us focus on fix selftest tooling.

The goal here is to have a selftest that runs kernel code as part of its ope=
ration. That is, the selftest is, logically, starting in userspace:

setup_evil_state();
ret =3D call_kernel_helper();
check_some_other_stuff();
undo_evil_state();

And the call_kernel_helper() could be moderately specific to the test.

>=20
> thanks,
> -- Shuah
