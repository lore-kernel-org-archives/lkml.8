Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BADEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 773862082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LRTeCTU2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bARa/ogU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgG3HX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:23:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48370 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgG3HX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:23:57 -0400
From:   Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596093835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6k5wcIDB8jyeA7vb5CSqa7UkewlAIcmM7jaipNVY1C4=;
        b=LRTeCTU2LhZQa64jTJqs0aj6W4nCipJPBRMPumklEE4Mneyq3G2yhOvxHHLbNh5jaTSvAm
        H6qkwMURc/ZnA4rogRqaMHDPeAhf2s0ExJApSjVKHD2axQXMsvOUQyjuLLXB1ev7vlVHHO
        6fwbTCTyvt5nYDcNQCl3scGJN2BMB93qF9vlFn3og1kmlpN3DwTf3wMFWd7KXLelYKL05Z
        kM9zRkcVYRdWVX2NkS9WzBfvqT9isyHTJ/U6dSZcAwcViZiclG9MZ/KCfy/mYG2rGS0Bbe
        jHxwm1AitkFiJ8OcTYRbyie3xzm+LeLuR7OFBofRF2Pab+ldzwrj2nuFZwbG6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596093835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6k5wcIDB8jyeA7vb5CSqa7UkewlAIcmM7jaipNVY1C4=;
        b=bARa/ogUj6Y440sYrSdJ4Sz4Ax5ocVXmV4x3b+thqHzs6WxGFsVU/mGYF0sh0L60DgpLJ1
        yj6ZvlwM6PcbxEDg==
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, paulmck@kernel.org, mw@semihalf.com,
        leoyang.li@nxp.com, vladimir.oltean@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt> <20200729094943.lsmhsqlnl7rlnl6f@skbuf>
Date:   Thu, 30 Jul 2020 09:23:44 +0200
Message-ID: <87mu3ho48v.fsf@kurt>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Vladimir,

On Wed Jul 29 2020, Vladimir Oltean wrote:
> For more context, here is my original report of the issue:
> https://lkml.org/lkml/2020/6/4/1062
>
> Just like you, I could not reproduce the RCU stalls and system hang on a
> 5.6-rt kernel, just on mainline and derivatives, using the plain
> defconfig.
>
> The issue is not specific to Layerscape or i.MX8, but rather I was able
> to see the same behavior on Marvell Armada 37xx as well as Qualcomm
> MSM8976.
>
> So, while of course I agree that disabling IRQ time accounting for arm64
> isn't a real solution, it isn't by far an exaggerated proposal either.
> Nonetheless, the patch is just a RFC and should be treated as such. We
> are at a loss when it comes to debugging this any further and we would
> appreciate some pointers.

Yeah, sure. I'll try to reproduce this issue first. So it triggers with:

 * arm64
 * mainline, not -rt kernel
 * opened serial console
 * irq accounting enabled

Anything else?

Thanks,
Kurt

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEooWgvezyxHPhdEojeSpbgcuY8KYFAl8idYAACgkQeSpbgcuY
8KZnIw//VNg3MMucjsLvyBMbCL7IWmaRtFoCE1rWIq+82xzvJpY65Ol2gNnz4g/y
tcpjERid0FARJRAFLtC6UyL4jI6TjMubEapfBwLa/Pto9Ptg0xjMcYS75h+AbPf3
Wfwx85h+aHJR+3BTakzcDPK+6tCK6FTXWXijyn4XXE2T5yrLF1vgvF2fbpYd/Z5U
tKFz/H7DDJcPdzRuiWr0rvh/TaRvb4k8HPqyaQEONK4tdoo2mj+SnU4xCrOaFq+h
NNZZ59JAZZqLv40895nUpO+0rCp77Q4YBLC2fkECo8cHNgBzs+NQB6HdSsS4lkoU
uAHpAn2sFTb+xLqUI642PsuNyl1D4wBTf6WkamGw2XFXnO/qgkCs2aXZqOnEaawH
4jpNO7dIZ8MN0mXUz7nLKRS494DvzCju6VVG7kta2glzA251qgIU9sHmFj59Na8A
BwXle5NKdq/UItvJHiasjHWDWJ4dKfpHZwsFqtPGoeZexAJswpGnogj4/WlzkYZs
HqI9f716oJjVdyOXZjGddupVUX1xgjaSG2RCO3oeXDcjO81cQ9Q5/j3iKZc37aUH
Dgjm+GPjGLD9NOFk7yjKshBqwyDp2iVlGYe6TzuRB64rLjY1cKCaRVWoseJGTDhn
ZHjEBIXZKnRxU2VGueSgMT09rm56mHMkH0e2JtbwyukHsBnhT84=
=miKF
-----END PGP SIGNATURE-----
--=-=-=--
