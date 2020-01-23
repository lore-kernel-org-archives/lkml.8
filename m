Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E39C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC95521734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aPstyVF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgAWQ4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:56:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35449 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729308AbgAWQ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579798613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VW2N0Bse+73xvjtjmBHPORHR2HewenieAWNfa1s0ggE=;
        b=aPstyVF3ZjvuExGh8MZ1/YL05PI3YVoOugcXNMrZkDQEIjLCtlstm8+nrVIsw08hHhF8Vs
        xjGk0yArrJG6OyGMCdZNt65k7XAh4TKaojIJZth9+AgLirKKp/FBk93/q3Y4Cy/JL22uLl
        ryk/hpm432bbXXaHWhemCBA9ClTIMVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-UqeH6kvXPyaNl8L5QTASpg-1; Thu, 23 Jan 2020 11:56:50 -0500
X-MC-Unique: UqeH6kvXPyaNl8L5QTASpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D8A010054E3;
        Thu, 23 Jan 2020 16:56:49 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-20.ams2.redhat.com [10.36.116.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E9660BF3;
        Thu, 23 Jan 2020 16:56:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] x86: Select HARDIRQS_SW_RESEND on x86
Date:   Thu, 23 Jan 2020 17:56:46 +0100
Message-Id: <20200123165646.43901-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern x86 laptops are starting to use GPIO pins as interrupts more
and more, e.g. touchpads and touchscreens have almost all moved away
from PS/2 and USB to using I2C with a GPIO pin as interrupt.
Modern x86 laptops also have almost all moved to using s2idle instead
of using the system S3 ACPI power state to suspend.

The Intel and AMD pinctrl drivers do not define an irq_retrigger handlers
for the irqchips they register, this is causing edge triggered interrupts
which happen while suspended using s2idle to get lost.

One specific example of this is the lid switch on some devices, lid
switches used to be handled by the embedded-controller, but now the
lid open/closed sensor is often directly connected to a GPIO pin. On
most devices the ACPI code for this looks like this:

Method (_E00, ...) {
	Notify (LID0, 0x80) // Status Change
}

Where _E00 is an ACPI event handler for changes on both edges of the GPIO
connected to the lid sensor, this event handler is then combined with an
_LID method which directly reads the pin. When the device is resumed by
opening the lid, the GPIO interrupt will wake the system, but because the
pinctrl irqchip don't have an irq_retrigger handler, the Notify() will no=
t
happen. This is not a problem in the case the _LID method directly reads
the GPIO, because the drivers/acpi/button.c code will call _LID on resume
anyways.

But some devices have an event handler for the GPIO connected to the
lid sensor which looks like this:

Method (_E00, ...) {
	if (LID_GPIO =3D=3D One)
		LIDS =3D One
	else
		LIDS =3D Zero
	Notify (LID0, 0x80) // Status Change
}

And the _LID method returns the cached LIDS value, since on open we
do not re-run the edge-interrupt handler when we re-enable IRQS on resume
(because of the missing irq_retrigger handler), _LID now will keep
reporting closed, as LIDS was never changed to reflect the open status,
this causes userspace to re-resume the laptop again shortly after opening
the lid.

The Intel GPIO controllers do not allow implementing irq_retrigger withou=
t
emulating it in software, at which point we are better of just using the
generic HARDIRQS_SW_RESEND mechanism rather then re-implementing software
emulation for this separately in aprox. 14 different pinctrl drivers.

This commit selects HARDIRQS_SW_RESEND solving the problem of
edge-triggered GPIO interrupts not being re-triggered on resume when they
were triggered during suspend (s2idle) and/or when they were the cause of
the wakeup.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
I'm sending this out as a RFC since I'm not %100 sure this is the best
solution and it seems like a somewhat big change to make.

Also maybe we should add a Cc: stable@vger.kernel.org ??? This seems like
somewhat a big change for that but it does solve some real issues...
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1cbfc7b3ae8..8f8128047b49 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,6 +118,7 @@ config X86
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_RESERVATION_MODE
 	select GENERIC_IRQ_SHOW
+	select HARDIRQS_SW_RESEND
 	select GENERIC_PENDING_IRQ		if SMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_STRNCPY_FROM_USER
--=20
2.24.1

