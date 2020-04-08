Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E0AC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD01420771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 10:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgDHKE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 06:04:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49870 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHKE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 06:04:26 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4960528E176;
        Wed,  8 Apr 2020 11:04:24 +0100 (BST)
Date:   Wed, 8 Apr 2020 12:04:18 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        mparab@cadence.com, pgaj@cadence.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] I3C mastership handover support
Message-ID: <20200408120418.0d5235a6@collabora.com>
In-Reply-To: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
References: <1586211645-8065-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Parshuram,

On Tue, 7 Apr 2020 00:20:45 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> Hi,
> 
> This patch series is to enable mastership handover feature in I3C
> master subsystem and Cadence's I3C controller driver.

It's definitely not the first version (as implied in the subject), and
I'd like a proper changelog detailing what has changed since the last
version (the one sent by Przemek).

Thanks,

Boris

> 
> 
> [PATCH 1/3]
> i3c: master: split bus_init callback into bus_init and master_set_info
> There are 2 reasons for this split
> Currently bus_init callback is involved in
> a. Controller specific settings such as clock prescalar, enabling
>    different functionalities and finally enabling the controller.
> b. Allocating address to the main master and calling 
>    i3c_master_set_info, which basically create a I3C device for master
>    and add it to system. This is fine for main master, but for
>    secondary master this should be deferred until controller actually
>    owns the bus/mastership.
>    
> Another reason is, to support secondary master initialization without
> board info, controller specific bus mode setting need to be done twice
> First with pure bus mode and second time when actual bus mode is known
> based on data received through DEFSLVS, whereas master set info is
> supposed to be done only once.
> 	      
> [PATCH 2/3]
> i3c: add mastership handover support to i3c master subsystem
> This patch add mastership handover support as per MIPI I3C
> spec v1.0. Main master and secondary masters starts in pure
> bus mode to allow enumeration (DAA) to happen in same bus mode.
> Secondary masters are not required to have information about
> other devices connected on the bus through board info, this
> information is derived from DEFSLVS received from main
> master. While acquiring mastership, requesting master always
> make sure that it has active dynamic address, and received
> DEFSLVS at least once. Mastership request state machine
> make sure that any pending DEFSLVS is processed, so that
> when device become master it always have correct view
> of the bus.
> 
> [PATCH 3/3]
> i3c: master: add mastership handover support to cdns i3c master driver
> This patch adds mastership handover support to the Cadence
> I3C controller driver. Basically, this include necessary
> callbacks for mastership request.
> 
> Regards,
> Parshuram Thombare
> 
> Parshuram Thombare (3):
>   i3c: master: split bus_init callback into bus_init and master_set_info
>   i3c: add mastership handover support to i3c master subsystem
>   i3c: master: add mastership handover support to cdns i3c master driver
> 
>  drivers/i3c/master.c                 | 490 ++++++++++++++++++++++++---
>  drivers/i3c/master/dw-i3c-master.c   |  29 +-
>  drivers/i3c/master/i3c-master-cdns.c | 385 ++++++++++++++++++---
>  include/linux/i3c/master.h           |  47 ++-
>  4 files changed, 854 insertions(+), 97 deletions(-)
> 

