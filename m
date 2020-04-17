Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552ECC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B84A2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDVHEYVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgDQQGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgDQQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:06:53 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCFBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:06:53 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d16so1579808edv.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=27vSJ4rxOXVt//bXSzwM2gE9hxQU8k65hX9qhcsZGTg=;
        b=FDVHEYVd2U51L0wNE01nzXLkKibCgVY7B14xhp/galjgLldz2slwvq1301/o7NpxuB
         lgW8Pb6xYOsLUJZRwuUoO36z/o/OghwrDpkTVV6UEjlQhimiAd58oBQMZr6AU1vtAPVL
         efZKXyZ8M9GNq/mq8fbcypKQ9Jc70L64rNb7vVjzgh2zF47h8fqLUwYVaFt5JqJavrNR
         AIdT5heWa7/DmtAloGsAuwndo7QnLqXBTJjVKTkkhDam6tWZEqf9hbOn08QkyspY3O5l
         7r/x2PSkKkjY/GDds/KxJ87Dc9PyVe1cPVxw+hkh34oR6I8bHSgZERiq49KTTNFe4dKT
         J/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=27vSJ4rxOXVt//bXSzwM2gE9hxQU8k65hX9qhcsZGTg=;
        b=CagnTbrpbltN2PGSJtE6Dkslb1vzTk1u3aSEYHJ6mp/XowRdRs0vQl/6a8QqZe1fGl
         Z/QfugTyel4MazIuooP0ayomfif6x0SjrWXyZeBvzI9XTV6BpEr3KG5zGnUxOcc/PX3A
         F37HhFcNhevHaNn6UqmyT1B3x2lApvUhnnTsSc/1nGCSRfGcXQEcAmT8jXBqPyxtqf7o
         JhJ7J48zi8kT3DUy8s8mQzfY8L2Eji7evDetKuTAL/KAgVGxHjAjxfFT7xb9uRnO5BAc
         aWm40z4NIYd4HieJAlWpbeKCJgJwyS3mlyPz5RZNy28OeKLQXhC6xwhTR48HVeZpic+4
         6H8A==
X-Gm-Message-State: AGi0PuYcY+SDpJPcwkQxEFDZYwfXfJPmG06SxKtyE4SfuVJbXkBy3rrP
        legOZztBTqld4RHu0JyeTP+TqE5wFxMNx/3VhSpl88Gy
X-Google-Smtp-Source: APiQypKMVyp7kppgou3joWELwx5feu+pJVPehJdlmWs5EsoIKdyMM1Aizt1TwiQtlNFXjDCKliyrmwcTSAIyJ+G7J9o=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr3771315edr.288.1587139612155;
 Fri, 17 Apr 2020 09:06:52 -0700 (PDT)
MIME-Version: 1.0
From:   Marc Dionne <marc.c.dionne@gmail.com>
Date:   Fri, 17 Apr 2020 13:06:40 -0300
Message-ID: <CAB9dFdtBqrcmKcV=zxPyV5uNB7WeKOqqC4k5KtY+9vxS9ooKoA@mail.gmail.com>
Subject: FreeNAS VM disk access errors, bisected to commit 6f1a4891a592
To:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Commit 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity
race") causes Linux VMs hosted on FreeNAS (bhyve hypervisor) to lose
access to their disk devices shortly after boot.  The disks are zfs
zvols on the host, presented to each VM.

Background: I recently updated some fedora 31 VMs running under the
bhyve hypervisor (hosted on a FreeNAS mini), and they moved to a
distro 5.5 kernel (5.5.15).  Shortly after reboot, the disks became
inaccessible with any operation getting EIO errors.  Booting back into
a 5.4 kernel, everything was fine.  I built a 5.7-rc1 kernel, which
showed the same symptoms, and was then able to bisect it down to
commit 6f1a4891a592.  Note that the symptoms do not occur on every
boot, but often enough (roughly 80%) to make bisection possible.

Applying a manual revert of 6f1a4891a592 on top of mainline from
yesterday gives me a kernel that works fine.

Not sure which details are useful, but here are some bits that might
be relevant:
- FreeNAS host is running FreeNAS-11.3-U2
- efi/bios details:
    efi: EFI v2.40 by BHYVE
    efi:  SMBIOS=0x7fb5b000  ACPI=0x7fb88000  ACPI 2.0=0x7fb88014
    DMI:  BHYVE, BIOS 1.00 03/14/2014
- A sample disk:
    ata4: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
    ata4.00: ATA-9: BHYVE SATA DISK, 001, max UDMA/133
    ata4.00: 2147483680 sectors, multi 128: LBA48 NCQ (depth 32)
    ata4.00: configured for UDMA/133
    scsi 3:0:0:0: Direct-Access     ATA      BHYVE SATA DISK  001  PQ: 0 ANSI: 5
    scsi 3:0:0:0: Attached scsi generic sg3 type 0
- The first sign of a problem on a "bad" kernel shows up as:
    ata1.00: exception Emask 0x0 SAct 0x78000001 SErr 0x0 action 0x6 frozen

Thanks,
Marc
