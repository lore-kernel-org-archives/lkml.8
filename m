Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D1EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6CB20678
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594944;
	bh=P6Ih3ybR3Q0tpfGmAB9O9MzAREGP8DJDgLwT78Y8q/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jnLmzvNOXP22QoP1UTttmhiEcolfaV8QG1fBU0nj1vt1wJCd9Aon6HqXhBsB+6V+H
	 EwvX/kgnH4rto9xXepvTbCHZiirr3JLOTBtXIl3T/Hge7Emax8L4q1P3TYGHIhg7KP
	 dCxrAdCyuHUBn345CLoif5UuTJwTnGlNd8C8f7KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbgIHTzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:55:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbgIHPhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:11 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1483322A83;
        Tue,  8 Sep 2020 14:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599575637;
        bh=P6Ih3ybR3Q0tpfGmAB9O9MzAREGP8DJDgLwT78Y8q/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQbbjUN0w2+++8eS4F2+HqX3/5wupr6MhkPYnfoLTICk9jCZc7nzEsOvAqjGd64Jq
         9Ad0YPtEXzZiVKpCB3n/26cYJsP18mXmLh4+Tk/x+M9q2/nHh2qPK5WREd2qR12Mov
         +FJjTJ+CpN/pXtomNlmzgIVJmiRn+rI0u+dBS5e8=
Date:   Tue, 8 Sep 2020 15:33:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
Message-ID: <20200908143312.GC5551@sirena.org.uk>
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Content-Disposition: inline
In-Reply-To: <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
X-Cookie: Vini, vidi, Linux!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 08, 2020 at 02:28:48PM +0200, Jaroslav Kysela wrote:
> Dne 08. 09. 20 v 14:11 Mark Brown napsal(a):

> > I don't have this patch and since I seem to get copied on quite a lot of
> > soundwire only serieses I just delete them unread mostly.

> It can be fetched from lore (mbox format):

> https://lore.kernel.org/alsa-devel/20200818140656.29014-2-yung-chuan.liao@linux.intel.com/raw

Sure, I can go get stuff from the list archives but my list of things to
go through is in my inbox.

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9XligACgkQJNaLcl1U
h9Bv+gf8DTCBNgYdd/v4aDuaMyXv6CqPVU+U14UjTNqUUDstwuDd15nP/+11+Ovp
cYACg3bu24coO3wH/h4PhoI19PadHctIBRSGojJL6CYzT20jPzzvRWjR6A+fTecU
T6jIGEQMjGypi1MbM2J6f4dty76zSKysy2fW8dlG8+8HqLXQQ8Oh0XKEPUysvL8t
CK5SLnsVK8AHcxLZT6wFcJ0qzBRFoA4FDvEhke0xEiYvXJ96wGc5vCClew+oRCIA
LDw4jwqaQmFEggYz+/7JLqPetUU5D+xE2L3ulkiUzTd+cg9+5k1LqMd6528LlwxJ
aNZtrusstwa3q9udD2R0zKMgM/4NRA==
=ODCF
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
