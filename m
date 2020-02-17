Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FFCC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534FF20725
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728814AbgBQRhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:37:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42954 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgBQRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:37:51 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 326982934B4;
        Mon, 17 Feb 2020 17:37:50 +0000 (GMT)
Date:   Mon, 17 Feb 2020 18:37:47 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     Jose.Abreu@synopsys.com, Joao.Pinto@synopsys.com, arnd@arndb.de,
        wsa@the-dreams.de, gregkh@linuxfoundation.org,
        bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, linux-i3c@lists.infradead.org
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
Message-ID: <20200217183747.6a18d6c4@collabora.com>
In-Reply-To: <20200217155141.08e87b3f@collabora.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <20200217155141.08e87b3f@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Feb 2020 15:51:41 +0100
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> Hello Vitor,
> 
> Sorry for taking so long to reply, and thanks for working on that topic.
> 
> On Wed, 29 Jan 2020 13:17:31 +0100
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> 
> > For today there is no way to use i3c devices from user space and
> > the introduction of such API will help developers during the i3c device
> > or i3c host controllers development.
> > 
> > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > the concerns raised in [1].
> > 
> > NOTES:
> > - The i3cdev dynamically request an unused major number.
> > 
> > - The i3c devices are dynamically exposed/removed from dev/ folder based
> >   on if they have a device driver bound to it.  
> 
> May I ask why you need to automatically bind devices to the i3cdev
> driver when they don't have a driver matching the device id
> loaded/compiled-in? If we get the i3c subsystem to generate proper
> uevents we should be able to load the i3cdev module and bind the device
> to this driver using a udev rule.

Hm, looks like we already send a proper MODALIAS [1], so we can actually
implement this auto-bind to i3cdev in udev (fall back on i3cdev
load+bind if no matching module is found).

[1]https://elixir.bootlin.com/linux/latest/source/drivers/i3c/master.c#L269
