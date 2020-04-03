Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C86C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A10320737
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sammserver.com header.i=@sammserver.com header.b="Sn9/pzfZ";
	dkim=pass (1024-bit key) header.d=sammserver.com header.i=@sammserver.com header.b="Sn9/pzfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390947AbgDCMWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:22:17 -0400
Received: from 109-230-57-163.dynamic.orange.sk ([109.230.57.163]:50726 "EHLO
        mail.sammserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgDCMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:22:17 -0400
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id D8B88A24F79; Fri,  3 Apr 2020 14:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sammserver.com;
        s=email; t=1585916535;
        bh=NJLwg+ipNHzCf/EBn80JPjLTXnXV4zQy4LLMLOH3QYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn9/pzfZusi98KcRsPrYjkqnXBnkfhGZDC4MGf+rQZEYp2+yEyghz3udKJDN2s1S6
         FspcrzDHsGpVnIW2LG26byYdwEZNTqp3r+vI2S04Fv19Prj/4jdTtepoldnt/Rp2/Q
         KIMPJHxaW1eoFvga9E8AQW4HGLLO+ipXPhIQeiAY=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id A3A65A24F76;
        Fri,  3 Apr 2020 14:22:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sammserver.com;
        s=email; t=1585916535;
        bh=NJLwg+ipNHzCf/EBn80JPjLTXnXV4zQy4LLMLOH3QYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sn9/pzfZusi98KcRsPrYjkqnXBnkfhGZDC4MGf+rQZEYp2+yEyghz3udKJDN2s1S6
         FspcrzDHsGpVnIW2LG26byYdwEZNTqp3r+vI2S04Fv19Prj/4jdTtepoldnt/Rp2/Q
         KIMPJHxaW1eoFvga9E8AQW4HGLLO+ipXPhIQeiAY=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 8FC2B1420F3C; Fri,  3 Apr 2020 14:22:15 +0200 (CEST)
Date:   Fri, 3 Apr 2020 14:22:15 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <sammko@sammserver.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] HID for 5.7
Message-ID: <20200403122215.zsi4etbclm6hljrl@fastboi.localdomain>
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm>
 <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
 <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.2020 12:05, Jiri Kosina wrote:
> On Wed, 1 Apr 2020, Linus Torvalds wrote:
> 
> > Anyway, because I noticed this due to the name, it does strike me that 
> > clearly Windows must be ignoring - or otherwise reacting differently to 
> > - the HID_MAIN_ITEM_CONSTANT flag. Because presumably those mice work 
> > under Windows without special drivers?
> > 
> > In fact, reading that driver, it looks like they report being *both* 
> > constant *and* variable in their report descriptors. Which sounds odd. 
> > Maybe we should do whatever Windows does, and not need a special driver 
> > for this maybe-bot-so-glorious-after-all mouse hardware?
> 
> Adding Samuel to CC.
> 
> From what I understood is that in order to access the buttons reported in 
> report #2 (the one marked with HID_MAIN_ITEM_CONSTANT), you actually *do* 
> need a special software on windows anyway.

The Glorious software is merely used to map the actions to the buttons.
The mouse comes with a common default configuration (forward and back on
the side buttons) but every button can be remapped to any action. I am
used to having a Play/Pause button on my mouse and that's where I
encountered the problem in the first place.

The configuration of the mouse is then stored in the firmware. The
Glorious software is not required to be running or even to be installed
for the mouse to function. The vanilla Windows HID driver is in use.
Sorry if that wasn't clear.

> What we do is that we ignore any changes in reports with 
> HID_MAIN_ITEM_CONSTANT in the HID core.
> 
> It would still be possible to access the report via hidraw, and maybe 
> that's analogy of what the Windows driver/special Glorious software :) 
> does, I don't know. It's hard to believe that Windows would be actually 
> willing to report any changes coming through HID_MAIN_ITEM_CONSTANT 
> reports, but who knows.

It unfortunately appears to be the case. Just for reference, here is the
relevant part of the original descriptor again:
  
  INPUT(2)[INPUT]
    Field(0)
      Flags( Constant Variable Absolute )
    Field(1)
      Flags( Constant Variable Absolute )
    Field(2)
      Flags( Constant Variable Absolute )

Windows accepts the reports just fine. Unless there is something else at
play here, but I don't see anything that could be since the default HID
driver is used on Windows.

I also set the Relative flag instead of Absolute in the driver, in order
to drop repeat events when holding down the button. These are not
desirable in the case of consumer control events, such as 'Next Track'.
This is not a big problem, though.

Regards,
Samuel
