Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3D52064B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596559350;
	bh=d3uaiTv0Ga0UKUyb/DBtTQ3erGKWoEO0Ny8JGoOpI2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zoiHvqPT1jxIhmzlKQOP5h1aApR3ziyOiyEtaEwCpmAeknfj8ax1Y7svkq67NqzD
	 ArzRRjUAwljSydyRg6SCk17l8E/K5QrigkGLpBcD8sJvdBXhV0XTS609Z0Y1FVyVBB
	 AEuoU1WbAf9OsnhD7VDWl75dmkukJcSZIbZOROSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgHDQm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgHDQm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 12:42:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A222064B;
        Tue,  4 Aug 2020 16:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596559346;
        bh=d3uaiTv0Ga0UKUyb/DBtTQ3erGKWoEO0Ny8JGoOpI2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HDegcDZ7nagJV+SMTFAJ1bgoiG6iWF2OiUhEiTH6b0vq2i0EZAgTPYy/yESW9liEo
         7PWsHc9KwOblEb5l0LrWJJiXI7mrhy1vqS6cc5vriB8+Z7c9AoOBhpQZLa7VlbQi7i
         kdpJzcbn0UioADmv/A+8sMdXMwkwy/YHILLc51g0=
Date:   Tue, 4 Aug 2020 18:42:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Subject: Re: [PATCH] Platform lockdown information in SYSFS
Message-ID: <20200804164246.GA502540@kroah.com>
References: <20200730214136.5534-1-daniel.gutson@eclypsium.com>
 <20200731070053.GC1518178@kroah.com>
 <CAFmMkTGdzjjrvitY8fT+RcXFqHG1JGMB-3w1hi1c8CD0FH34Tw@mail.gmail.com>
 <20200731141503.GA1717752@kroah.com>
 <CAFmMkTG7tkFzwwo_WNe2EFFRVijvGm+NLaeN3qX6CVzTViWBag@mail.gmail.com>
 <20200804064154.GE696690@kroah.com>
 <CAFmMkTE1PHPrZwnH7DKFW145dn01LhydTbL7HPTO+_zKA+P61Q@mail.gmail.com>
 <20200804142250.GA247448@kroah.com>
 <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFmMkTFEWrMsigabvE2HtmpFXMe0qb8QZJHzMzQ=wZXE1G3fbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 11:37:02AM -0300, Daniel Gutson wrote:
> static void mypci_remove(struct pci_dev *pdev)
> {
>         /*
>     I tried enabling and disabling this
>         if (child_device != NULL) {
>                 put_device(child_device);
>                 device_unregister(child_device);
>         }
>         */

You can just call device_destroy() here, but this should be the same.

But, if you have it commented out, that's not good, you have to clean
this up.

>         class_remove_file(&my_class, &class_attr_howareyou);

You don't always have to remove files you create, but it doesn't hurt.

>         class_unregister(&my_class);

class_destroy()?  But this is the same as well, so all is good.

Try running without the above code commented out.

greg k-h
