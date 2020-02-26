Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC7FC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A8B20637
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="v9g1y9D2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgBZLaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:30:52 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:38915 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgBZLav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:30:51 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8168422EEB;
        Wed, 26 Feb 2020 12:30:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1582716648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=49vbSdUeTzuDFAZGKG9960moA+ZZ59VpBj1mcCy3Iks=;
        b=v9g1y9D2DjSGnHgOFwe/gfIfxqbCUZnb9GGeHyk8oUoqdZ7Zd1Ya5xLA3YZuyaqscKbIEa
        83mVa1jXsSJbWmK9rQzHcjEHHHveei0eiQU2241q6jM2xl6hiAQDnBAFU2Lr3zuww0dr2j
        ZBPz2sx0mw5H6CAvQ/DfbVUfRWRCn9g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 26 Feb 2020 12:30:48 +0100
From:   Michael Walle <michael@walle.cc>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH 0/2] AT8031 PHY timestamping support
In-Reply-To: <20200226025441.GB10271@localhost>
References: <20200225230819.7325-1-michael@walle.cc>
 <20200225235040.GF9749@lunn.ch>
 <9955C44A-8105-4087-8555-BAC5AE4AF25D@walle.cc>
 <20200226025441.GB10271@localhost>
Message-ID: <fa823a08fa6d50c57ca03bdc58bf4921@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 8168422EEB
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.424];
         FREEMAIL_TO(0.00)[gmail.com];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,armlinux.org.uk,davemloft.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-02-26 03:54, schrieb Richard Cochran:
> On Wed, Feb 26, 2020 at 01:07:26AM +0100, Michael Walle wrote:
>> Am 26. Februar 2020 00:50:40 MEZ schrieb Andrew Lunn <andrew@lunn.ch>:
>> >That sounds fundamentally broken.
> 
> Right.  It can't work unless the PHY latches the time stamp.

To make things worse, it only has one slot for RX and one slot for TX
timestamps.

>> This might be the case, but the datasheet (some older revision can
>> be found on the internet, maybe you find something) doesn't mention
>> it. Nor does the PTP "guide" (I don't know the exact name, I'd have
>> to check at work) of this PHY. Besides the timestamp there's also
>> the sequence number and the source port id which would need to be
>> read atomically together with the timestamp.
> 
> Maybe the part is not intended to be used at all in this way?
> 
> AFAICT, PHYs like this are meant to feed a "PTP frame detected" pulse
> into the time stamping unit on the attached MAC.  The interrupt serves
> to allow the SW to gather the matching fields from the frame.

But then there would need to be such a hardware pin, correct? Unless
you'd misuse the INT# for it. Also, why should the PHY then have a PHC
which can be adjusted.

>> That sounds fundamentally broken. Which would be odd. Sometimes there
>> is a way to take a snapshot of the value. Reading the first word could
>> trigger this snapshot. Or the last word, or some status register. One
>> would hope the datasheet would talk about this.
> 
> This might be the case, but the datasheet (some older revision can
> be found on the internet, maybe you find something) doesn't mention
> it. Nor does the PTP "guide" (I don't know the exact name, I'd have
> to check at work).

BTW, the name of the document is "AR8031 1588v2 Precision Time Protocol,
Application Note, 80-Y0618-15 Rev. A", which describes a use case
where the RTC (ie PHC) is in the AR8031. I don't argue that the PHY is
not broken, only that Atheros at least intended to have that use case.

-michael
