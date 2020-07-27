Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E9EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D6020809
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AK2dCcs7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJ3Pkd8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgG0UvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:51:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57994 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgG0UvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:51:19 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595883077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhykwSSEM4P/f4CIPUxEsuotsrwgjKM/44WpLI7BfPI=;
        b=AK2dCcs7xSlaxYkM3uXuNl0xGhiAmK9gvA3IMxs9h0WsNDp0CzcpRyyglDb81EqHBP8D7p
        umBqTgf3vjxF3WiMS9gGoPtKNO/cwB26yVXwhu6ev0FZ0RD0+vYTd0hcPPK5SU6gm7UHLK
        lA1IChVvNlkOpmuVWOjp5nByNG+FMpC1hAuHs5bnuBxy+1iEzjBLpNKjyC1Da1hiKpPspA
        5ttPOf6QdMw0kVK9mJwwRPbV/m1AOwmqYxb/qH/K14IuuX1onhLhiI5XNcIi6CGRJmI0aj
        53a05EIUdl7KcPEhE7UGCkeZrTgAZW3miE48KYy/qZBm842Zc43fk2tw9GERGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595883077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dhykwSSEM4P/f4CIPUxEsuotsrwgjKM/44WpLI7BfPI=;
        b=LJ3Pkd8VDO5Q+V30VSkd15T9XogzrwJnKeoF18D8K5FYeGuhiEKj90knwj+/8sCps5uqc1
        9o2OVD/KweLjpPBg==
To:     Scott Branden <scott.branden@broadcom.com>, bp@alien8.de,
        x86@kernel.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
In-Reply-To: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
Date:   Mon, 27 Jul 2020 22:51:16 +0200
Message-ID: <87h7tsbs1n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Scott,

Scott Branden <scott.branden@broadcom.com> writes:

> Occasionally I get the following Kernel panic on boot.=C2=A0 This is
> running on the latest kernel but have seen it previously as well.
> "Kernel panic - not syncing: IO-APIC + timer doesn't work!=C2=A0 Boot with
> apic=3Ddebug and send a report."
>
> I don't know who I am support to send a report to.=C2=A0 But here is the =
log with apic=3Ddebug

> [=C2=A0=C2=A0=C2=A0 0.006000] ENABLING IO-APIC IRQs
> [=C2=A0=C2=A0=C2=A0 0.007000] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 a=
pic2=3D-1 pin2=3D-1
> [=C2=A0=C2=A0=C2=A0 0.007000] ..MP-BIOS bug: 8254 timer not connected to =
IO-APIC
> [=C2=A0=C2=A0=C2=A0 0.007000] ...trying to set up timer (IRQ0) through th=
e 8259A ...
> [=C2=A0=C2=A0=C2=A0 0.007000] ..... (found apic 0 pin 2) ...
> [=C2=A0=C2=A0=C2=A0 0.007000] ....... failed.
> [=C2=A0=C2=A0=C2=A0 0.007000] ...trying to set up timer as Virtual Wire I=
RQ...
> [=C2=A0=C2=A0=C2=A0 0.007000] ..... failed.
> [=C2=A0=C2=A0=C2=A0 0.007000] ...trying to set up timer as ExtINT IRQ...
> [=C2=A0=C2=A0=C2=A0 0.007000] ..... failed :(.
> [=C2=A0=C2=A0=C2=A0 0.007000] Kernel panic - not syncing: IO-APIC + timer=
 doesn't work!=C2=A0 Boot with apic=3Ddebug and send a report.=C2=A0 Then t=
ry booting with the 'noapic' option.

Nothing which rings a bell. Can you please provide a boot log from a
successful boot with apic=3Ddebug on the command line?

Also you might check whether there are BIOS updates for this board. The
early Ryzen BIOSes had some rough edges.

Thanks,

        tglx

