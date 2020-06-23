Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E1AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F2A720679
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Evc8ix1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgFWJkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:40:33 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:58649 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731786AbgFWJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:40:32 -0400
Date:   Tue, 23 Jun 2020 09:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1592905229; bh=2sIgFEwV1kjT3n4KqKUXB4646azzs2rD9aj/h+vDyGQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=Evc8ix1C0H/cqxo6teO2XriavSrJpZvUoJTJW63PcR/5zctBY/+uZu14CUxNOPt5i
         Mi+Mn5e4Oqtwt8dAn3dkhg+557/lBZhBpTYQPHEUbN7KdTzh4KWtqD0cMaAAASQ8O7
         NlCldCL309qwknziTf3C5CtMtPxM/tzhQ0ovBxHrqNiYSQLAyhU7pP7dxQyCePPwQR
         ioqfVOJwksYafD6WdLrhoKzJHxKJbPL/FQ9At3Z5CO3sO8pyenmeAH2eTN13Mia7Lo
         GhOJ2T/C+MIP0SOSA2yNDeNUteYKb1qB6X9d5QGl4JTf9GfkyUXAo3DBdTz81Z6KZB
         tkjE8z9p+c5CA==
To:     David Miller <davem@davemloft.net>
From:   Alexander Lobakin <alobakin@pm.me>
Cc:     "kuba@kernel.org" <kuba@kernel.org>,
        "mkubecek@suse.cz" <mkubecek@suse.cz>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "jiri@mellanox.com" <jiri@mellanox.com>,
        "antoine.tenart@bootlin.com" <antoine.tenart@bootlin.com>,
        "steffen.klassert@secunet.com" <steffen.klassert@secunet.com>,
        "ayal@mellanox.com" <ayal@mellanox.com>,
        "therbert@google.com" <therbert@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Alexander Lobakin <alobakin@pm.me>
Subject: Re: [PATCH v2 net 0/3] net: ethtool: netdev_features_strings[] cleanup
Message-ID: <JsL7L8OuXUs86d8IwlgSkHKgxaymF4ys_7cUQTMgPptaPdog6471ed5_BpUYUvoGNuSaHMs0ayvZ-P6-NQ0TvMGSyvu45J6NhuvJEHPxGsE=@pm.me>
In-Reply-To: <20200622.163406.1755086886045118386.davem@davemloft.net>
References: <HPTrw9hrtm3e5151oH8oQfbr0HWTlzQ1n68bZn1hfd6yag38Tem57b4eTH-bhlaJgBxyhZb9U-qFFOafJoQqxcY-VX5fh5ZktTrnWhYeNB0=@pm.me> <20200622.163406.1755086886045118386.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave, Michal,

On Tuesday, 23 June 2020, 2:34, David Miller <davem@davemloft.net> wrote:

> From: Alexander Lobakin <alobakin@pm.me>
> Date: Sun, 21 Jun 2020 09:55:50 +0000

> > This little series adds the last forgotten feature string for
> > NETIF_F_GSO_TUNNEL_REMCSUM and attempts to prevent such losses
> > in future.
> >
> > Patches 2-3 seem more like net-next candidates rather than net-fixes,
> > but for me it seems a bit more suitable to pull it during "quiet" RC
> > windows, so any new related code could start from this base.
> >
> > I was thinking about some kind of static assertion to have an early
> > prevention mechanism for this, but the existing of 2 intended holes
> > (former NO_CSUM and UFO) makes this problematic, at least at first
> > sight.
> >
> > v2:
> >  - fix the "Fixes:" tag in the first patch;
> >  - no functional changes.
>
> Please do not mix bug fixes (missing netdev feature strings, etc.) with
> cleanups (indentation changes).

You both are right, I should've thought better about that.
I'll split the series into two and resend, sorry.

> Thank you.

Thanks,
Al
