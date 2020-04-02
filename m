Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00F4C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22702077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgDBANO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:13:14 -0400
Received: from a3.inai.de ([88.198.85.195]:45924 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732137AbgDBANO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:13:14 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id 872F158730CF4; Thu,  2 Apr 2020 02:13:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 7F1FA60D9EBE3;
        Thu,  2 Apr 2020 02:13:12 +0200 (CEST)
Date:   Thu, 2 Apr 2020 02:13:12 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] acpica: clear global_lock bits at FACS initialization
In-Reply-To: <CY4PR11MB171939B742CF12CD476E6BCEF0C90@CY4PR11MB1719.namprd11.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2004020156480.16288@n3.vanv.qr>
References: <20200330085852.31328-1-jengelh@inai.de> <CAJZ5v0iMJYG1ptdoeiHVo21NqhWBVPw691LJ5=3oRMA7OMQ91Q@mail.gmail.com> <CY4PR11MB171939B742CF12CD476E6BCEF0C90@CY4PR11MB1719.namprd11.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wednesday 2020-04-01 23:55, Kaneda, Erik wrote:
>
>I've been reading the ACPI spec and there's nothing stated about what the
>initial state of the lock should be... This patch is assuming that the lock should
>be free when the FACS is being initialized and I don't think this is a safe
>assumption to make.
>
>What if this is a legitimate acquisition by an SMI handler very early in OS boot?

Before the OS has initialized ACPI (which, to me, is best recognized by what
action the power button will cause - either instant-off or ACPI event),
I would imagine that there are no SMI handlers that try to make use of ACPI
features like the FACS lock.

Furthermore, if the OS has taken the FACS lock and an SMI happens,
what would the SMI do if it cannot obtain the lock? It certainly can't 
busywait for the OS, because that's interrupted..

>> > When the firmware ROM supplies a FACS table with garbage, and the
>> > firmware code does not clear the global_lock field before booting to a
>> > loader/OS, the garbage bytes in that field (like 0xffffffff) can
>> > indicate that the lock is taken when it is not, thereby preventing
>> > obtaining said lock even though it is otherwise perfectly usable if
>> > the field were not prepopulated with garbage.
>
>How do we know that the lock is taken when it is not?

We don't. ACPI does not make itself look good in this instance I am afraid.
