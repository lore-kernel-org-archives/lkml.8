Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8506C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9560B20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PtO/2ydu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgBFJV7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:21:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43677 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727672AbgBFJV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580980918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7vg6/blGqHqErRgjd39RecgnPSBgnnS+bDu7HevfsIE=;
        b=PtO/2ydu3hGWPeKpL5tXvGbsI7SC2YrSJB7DjqXR5RYPZ/kRnMs4U6rkv5pvBiDroXMxB8
        d+ChSrjxc9+/jF5AJb2tLJy9Cdd9eQunay1ih8pjoKPTLo/48em819pdxwOdlce/KOnax0
        68yW7OVNzIG5GO2By11HaVx8qnuajL0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-WlCw4__jMIC6UmAdIE-P4w-1; Thu, 06 Feb 2020 04:21:47 -0500
X-MC-Unique: WlCw4__jMIC6UmAdIE-P4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 768B68010FD;
        Thu,  6 Feb 2020 09:21:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 724571E2B5;
        Thu,  6 Feb 2020 09:21:38 +0000 (UTC)
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200128161948.8524-1-john.ogness@linutronix.de>
From:   lijiang <lijiang@redhat.com>
Message-ID: <0f49d4cc-be61-ed0c-5001-2256416fe2ec@redhat.com>
Date:   Thu, 6 Feb 2020 17:21:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200128161948.8524-1-john.ogness@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2020=E5=B9=B401=E6=9C=8829=E6=97=A5 00:19, John Ogness =E5=86=99=
=E9=81=93:
> Hello,
>=20
> After several RFC series [0][1][2][3][4], here is the first set of
> patches to rework the printk subsystem. This first set of patches
> only replace the existing ringbuffer implementation. No locking is
> removed. No semantics/behavior of printk are changed.
>=20
> The VMCOREINFO is updated, which will require changes to the
> external crash [5] tool. I will be preparing a patch to add support
> for the new VMCOREINFO.
>=20
In addition to changing the crash utility, I would think that the
kexec-tools(such as the vmcore-dmesg and makedumpfile) also need to
be modified accordingly.

Thanks
Lianbo

> This series is in line with the agreements [6] made at the meeting
> during LPC2019 in Lisbon, with 1 exception: support for dictionaries
> will _not_ be discontinued [7]. Dictionaries are stored in a separate
> buffer so that they cannot interfere with the human-readable buffer.
>=20
> John Ogness
>=20
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutr=
onix.de
> [1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutr=
onix.de
> [2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutr=
onix.de
> [3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutro=
nix.de
> [4] https://lkml.kernel.org/r/20191128015235.12940-1-john.ogness@linutr=
onix.de
> [5] https://github.com/crash-utility/crash
> [6] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
> [7] https://lkml.kernel.org/r/20191007120134.ciywr3wale4gxa6v@pathway.s=
use.cz
>=20
> John Ogness (2):
>   printk: add lockless buffer
>   printk: use the lockless ringbuffer
>=20
>  include/linux/kmsg_dump.h         |    2 -
>  kernel/printk/Makefile            |    1 +
>  kernel/printk/printk.c            |  836 +++++++++---------
>  kernel/printk/printk_ringbuffer.c | 1370 +++++++++++++++++++++++++++++
>  kernel/printk/printk_ringbuffer.h |  328 +++++++
>  5 files changed, 2114 insertions(+), 423 deletions(-)
>  create mode 100644 kernel/printk/printk_ringbuffer.c
>  create mode 100644 kernel/printk/printk_ringbuffer.h
>=20

