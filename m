Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC81C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BA320838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KC9ZnZhx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atBLvzYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgG1IWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgG1IWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:22:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792B5C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:22:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595924552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LT0z1WTFU4u1Ini4PkAGyn1tHLs7qrzEH8lDSSnkO3A=;
        b=KC9ZnZhxsHIQ29MU+dFo+gVVeCQNIYOODkfr8fe6S5XPydU7fNaQPwiTsyjRfd+OJ7g7KW
        j/ay6u3V4sFm7nyEv/Be40zRbOAsXutC3Ykc6ik7m/G5ui7EjuPjjV2l1VYAdXuv82WXSn
        7bqi9brSYIyboxEBNILttxf6X7BCTvVsr28gaIwh7PBBEz4mHOtjZe8zp66BCpVoL+o7ue
        lQ9aLa0UbyXvqYQYGljWP5U/nHQOcjEfqq2K98L2GsC+Sz8QpNvRhh7RrzSrMvZIX+G2aM
        GqUHkLw4OcnabojGZ3z8BL9Y63revFUpS0GLFayzL+JMTLM5QAEhCJSI5Irx6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595924552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LT0z1WTFU4u1Ini4PkAGyn1tHLs7qrzEH8lDSSnkO3A=;
        b=atBLvzYaBAH3dkI+kws/92J2tJBgr5VpSx6CP1YGsc8eb0wopK1XBCTfzFSqD0WNDxmwLP
        nSGGoc2Tvh2nn1Dg==
To:     Scott Branden <scott.branden@broadcom.com>, bp@alien8.de,
        x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
In-Reply-To: <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com>
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com> <87h7tsbs1n.fsf@nanos.tec.linutronix.de> <e0ce41cd-9149-e43e-f4ca-e75503cb82e3@broadcom.com>
Date:   Tue, 28 Jul 2020 10:22:31 +0200
Message-ID: <87blk0aw1k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott,

Scott Branden <scott.branden@broadcom.com> writes:
> Bios now updated to latest.=C2=A0 Same kernel panic issue.=C2=A0 Log belo=
w.
>
> I think it is related to power cycling quickly.
> Should APIC work if PC power cycled in a few seconds or is that the
> problem?

Yes, emphasis on should. Just to clarify, if you reboot it works and
cold start works as well if power was off long enough?

> [=C2=A0=C2=A0=C2=A0 0.000000] Linux version 5.8.0-rc6 (oe-user@oe-host) (=
x86_64-poky-linux-gcc (GCC) 10.1.0, GNU ld (GNU Binutils) 2.34.0.20200220) =
#1 SMP Sat Jul 25 03:55:25 UTC 2020
> [=C2=A0=C2=A0=C2=A0 0.000000] Command line: BOOT_IMAGE=3D/bzImage ima_pol=
icy=3Dtcb
> apic=3Ddebug ip=3Ddhcp raid=3Dnoautodetect console=3DttyS0,115200
> root=3D/dev/nfs nfsroot=3D192.168.1.100:/nfs/vxc,hard,tcp,intr,v3 rootwait
> nfsrootdebug

The working dmesg and the failing console log are hard to compare
because the latter does not contain debug level printks. Please add
'ignore_loglevel' to the command line parameters.

Thanks,

        tglx
