Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CFDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE86720787
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585908345;
	bh=k0PQmd3iXUTMGiYkwUr2y9dxKec9kgHgmU4r74w6+UY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=baNywZQWV7A6IVk+Aany2kXnJ/bTnzTD8gDQBqORgvVHuS8GHayJjfCkifhmTh3bD
	 55WH6e/6RuruEoNh3xn7dm0VZWfPQb/qrxiI5fZTi7L0thOidtTUaspBjtzy+JurEX
	 QesdfPgMZ0VbkvzJH69KVMw4RInK+En7UBnTYzXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgDCKFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:54014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgDCKFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:05:43 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D2220757;
        Fri,  3 Apr 2020 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585908342;
        bh=k0PQmd3iXUTMGiYkwUr2y9dxKec9kgHgmU4r74w6+UY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=U8V9XB1UfP4VvZKwx/hKUXXy0kcP8fSEGWQZyTKg7eFIqKmziuyf0bJ6NXn3OqjX8
         BD72I1XCacH6vineVuG2YmzC69yGAjur2a9BvVPa1xRYgfEG7CbVZZZ0whG5wLBjZc
         kevOzZC365aO6IEO2h8+KKQ1qCNPj12qCdsr31WE=
Date:   Fri, 3 Apr 2020 12:05:27 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?ISO-8859-2?Q?Samuel_=C8avoj?= <sammko@sammserver.com>
Subject: Re: [GIT PULL] HID for 5.7
In-Reply-To: <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2004031158280.19713@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004011353080.19500@cbobk.fhfr.pm> <CAHk-=wgy8AM+BOt4jhnoQ+wa=YVyXT4ARg=qEYC=S-OW4ZjZzw@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Apr 2020, Linus Torvalds wrote:

> > Samuel Čavoj (1):
> >       HID: Add driver fixing Glorious PC Gaming Race mouse report descriptor
> 
> What a glorious name for a piece of hardware. Even if it's apparently
> buggy and needs help to work right.

Yeah, the vendor apparently was not of the humble kind :)

> I felt bad saying I don't need that glorious driver when doing my 
> oldconfig.

:))

> Anyway, because I noticed this due to the name, it does strike me that 
> clearly Windows must be ignoring - or otherwise reacting differently to 
> - the HID_MAIN_ITEM_CONSTANT flag. Because presumably those mice work 
> under Windows without special drivers?
> 
> In fact, reading that driver, it looks like they report being *both* 
> constant *and* variable in their report descriptors. Which sounds odd. 
> Maybe we should do whatever Windows does, and not need a special driver 
> for this maybe-bot-so-glorious-after-all mouse hardware?

Adding Samuel to CC.

From what I understood is that in order to access the buttons reported in 
report #2 (the one marked with HID_MAIN_ITEM_CONSTANT), you actually *do* 
need a special software on windows anyway.

What we do is that we ignore any changes in reports with 
HID_MAIN_ITEM_CONSTANT in the HID core.

It would still be possible to access the report via hidraw, and maybe 
that's analogy of what the Windows driver/special Glorious software :) 
does, I don't know. It's hard to believe that Windows would be actually 
willing to report any changes coming through HID_MAIN_ITEM_CONSTANT 
reports, but who knows.

-- 
Jiri Kosina
SUSE Labs

