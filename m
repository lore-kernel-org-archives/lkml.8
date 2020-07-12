Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F950C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F28BD20720
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 23:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="dgarWx6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgGLXSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 19:18:44 -0400
Received: from mail.nic.cz ([217.31.204.67]:34040 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727785AbgGLXSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 19:18:43 -0400
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id 1C496140637;
        Mon, 13 Jul 2020 01:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594595922; bh=oWEGZNZzPfZSyReuwO/r4sDrMA3Ym1alNAfm/HZaDUE=;
        h=Date:From:To;
        b=dgarWx6WIlF5MziAb8hhRGF0jJpKwHv1ukVGYMshFaJ0BLFHVaS8AdZqUmwhGKiSX
         TIGAe3AjNYw36p8Iw4ZKT/60tRNhn2hHflEqIfi0hpAviHIOBJVodrF7tYQBIbD3bV
         d0rmZU6noMPs44fDiolwpvRhhT9L2OTiTvTeMdgw=
Date:   Mon, 13 Jul 2020 01:18:41 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     =?UTF-8?B?T25kxZllag==?= Jirman <megous@megous.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH RFC] leds: Add support for per-LED device triggers
Message-ID: <20200713011841.25904273@nic.cz>
In-Reply-To: <20200713011544.0adc51f1@nic.cz>
References: <20200702144712.1994685-1-megous@megous.com>
        <20200711100409.GA18901@amd>
        <20200711210111.5ysijhexgyzyr7u7@core.my.home>
        <20200712072554.GC4721@duo.ucw.cz>
        <20200712134911.r3lig4hgyqhmslth@core.my.home>
        <20200712191111.GA20592@amd>
        <20200712223821.742ljr4qxdrx3aqv@core.my.home>
        <20200713011544.0adc51f1@nic.cz>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 01:15:44 +0200
Marek Behun <marek.behun@nic.cz> wrote:

> On Mon, 13 Jul 2020 00:38:21 +0200
> Ond=C5=99ej Jirman <megous@megous.com> wrote:
>=20
> > So after trying to use this, this seems to disallow the use of multiple=
 HW
> > triggers per LED. That's fine by me, because using one HW sysfs configu=
red
> > trigger per LED that use case is my proposal, but is it desireable in g=
eneral? =20
>=20
> Why? If you register one LED and several triggers, all sharing the same
> trigger_type pointer, I think it should work.
>=20
> Marek

The problem arises when I have two LEDs and two HW triggers, and the
hardware allows setting one HW trigger on both LEDs and other HW
trigger only on one LED. But this could simply be ignored - the
set_trigger function could simply return -ENOTSUPP or something.

Marek
