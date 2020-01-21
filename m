Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA32C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0466C24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 18:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAUSBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 13:01:50 -0500
Received: from mail.suchdamage.org ([52.9.186.167]:40058 "EHLO
        mail.suchdamage.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAUSBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 13:01:49 -0500
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 13:01:49 EST
Received: from localhost (localhost [127.0.0.1])
        by mail.suchdamage.org (Postfix) with ESMTP id 5E9192F536;
        Tue, 21 Jan 2020 12:54:23 -0500 (EST)
Received: from mail.suchdamage.org ([127.0.0.1])
        by localhost (mail.suchdamage.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WfyCN7mdvcTx; Tue, 21 Jan 2020 12:54:22 -0500 (EST)
Received: from carter-zimmerman.suchdamage.org (c-24-147-244-250.hsd1.ma.comcast.net [24.147.244.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "laptop", Issuer "laptop" (not verified))
        (Authenticated sender: hartmans-laptop)
        by mail.suchdamage.org (Postfix) with ESMTPSA;
        Tue, 21 Jan 2020 12:54:22 -0500 (EST)
Received: by carter-zimmerman.suchdamage.org (Postfix, from userid 8042)
        id 8EB97C3B78; Tue, 21 Jan 2020 12:54:21 -0500 (EST)
From:   Sam Hartman <hartmans@debian.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Sam Hartman <hartmans@debian.org>,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Question about dynamic minor number of misc device
References: <CAFH1YnOad7aVjoX_PR6mLqT=pXQjpBW9ZDHkKYzNkeistFkA4A@mail.gmail.com>
        <CAK8P3a3DwaZnRff7CCrJoSxP_MeVUn1S6nRd+hb5rHnv9dBgLQ@mail.gmail.com>
        <CAFH1YnMDL1gBNT4vr+C=eGGoCYJvkVDnoXUVN8OL9Xs3668Z+Q@mail.gmail.com>
        <CAK8P3a0aFr546fF+=LDm3rwZ-sK-xC8VLYTZjOEn+o6fVixRHg@mail.gmail.com>
        <20200120221323.GJ15860@mit.edu>
        <CAK8P3a2aLxAgjp2_Vb0bKw-0PMVRXKtFw=2giF0MY6hgAQpQRg@mail.gmail.com>
        <20200121163110.GK15860@mit.edu>
Date:   Tue, 21 Jan 2020 12:54:21 -0500
In-Reply-To: <20200121163110.GK15860@mit.edu> (Theodore Y. Ts'o's message of
        "Tue, 21 Jan 2020 11:31:10 -0500")
Message-ID: <tslh80o3dbm.fsf@suchdamage.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Theodore" == Theodore Y Ts'o <tytso@mit.edu> writes:

    Theodore> Sam,

    Theodore> Would you happen to know how commonly used the speakup system would be
    Theodore> --- in particular, on non-udev systems where changing the minor number
    Theodore> of the device node might break some folks?  Does your hardware system
    Theodore> use speakup, or some other interface?

Speakup is used by things like the Debian Installer in speech mode.
I'd assume D-I uses udev.

However Speakup is also likely to be used by blind people who prefer
older environments--no GUI, no pulseaudio, that sort of thing.
No udev is kind of pushing that mindset to the extreme though.
Speakup is not typically used without a keyboard or similar, so you're
not going to see it on embedded systems.





    Theodore> Also, who would be the best people to reach out at the
    Theodore> linux-speakup.org project to verify what the potential impact might be
    Theodore> of making this change.  It looks like some of the web pages are a bit
    Theodore> dated, so I wasn't sure what's up to date.

I might ask on debian-accessibility@lists.debian.org.
My recollection is that the upstream is not very energetic, and that the
distros keep speakup working because it's quite important for some
people.
We broke it on hda_intel for the original Buster release and that
certainly generated lots of user feedback.

debian-accessibility is Debian specific.  There is the more general
blinux-l@lists.redhat.com (blind linux users), but that lists tends to
be so user focused that you might not get good feedback to a question
like this.

--Sam
