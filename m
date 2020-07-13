Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A555C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7B820722
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="cy5PcgTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGMB4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 21:56:17 -0400
Received: from vps.xff.cz ([195.181.215.36]:34152 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMB4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 21:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1594605374; bh=gdZ3L0fVux68kDxio9119EDiHzxmA4TjQjhbhQ4czvE=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=cy5PcgTQu8i9lsZhTxxDX+7Yv+rsSYFKlkTIirreGfpV9uAyTkhiiIkolj7GXzsX3
         jHkLjZ0dIFAa6PkPG7qz1ARepmtzP5oq1OMMh+rRNax93tVC4ZSVPdl1nkUKXNX4Si
         XqwzwGfdBhhgi2ZNPWU5HqbStXj6Zl63leIr3hEc=
Date:   Mon, 13 Jul 2020 03:56:13 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        marek.behun@nic.cz
Subject: Re: [PATCH RFC] leds: Add support for per-LED device triggers
Message-ID: <20200713015613.tr6l5svn6ddkktbo@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        marek.behun@nic.cz
References: <20200702144712.1994685-1-megous@megous.com>
 <20200711100409.GA18901@amd>
 <20200711210111.5ysijhexgyzyr7u7@core.my.home>
 <20200712072554.GC4721@duo.ucw.cz>
 <20200712134911.r3lig4hgyqhmslth@core.my.home>
 <20200712191111.GA20592@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200712191111.GA20592@amd>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pavel,

On Sun, Jul 12, 2020 at 09:11:11PM +0200, Pavel Machek wrote:
> > > So.. 48 triggers on Marek's systems means I'll not apply your patch.
> > > 
> > > Please take a look at my version, it is as simple and avoids that
> > > problem.
> > 
> > I would, but I don't see your version linked or mentioned in this
> > thread.
> 
> Ah! Sorry about that. Here it is. (I verified it compiles in the
> meantime).

I tried implementing a driver using this API:

https://megous.com/git/linux/commit/?h=tbs-a711-5.8&id=adda29f57685155ac35bd810b51befbfb266da48

and it works pretty nicely for me.

thank you and regards,
	o.
