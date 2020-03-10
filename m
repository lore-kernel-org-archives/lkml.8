Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC10C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16BB21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 18:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCJSPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:15:40 -0400
Received: from sauhun.de ([88.99.104.3]:51018 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726271AbgCJSPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 14:15:40 -0400
Received: from localhost (p54B33196.dip0.t-ipconnect.de [84.179.49.150])
        by pokefinder.org (Postfix) with ESMTPSA id 730C12C1EB6;
        Tue, 10 Mar 2020 19:15:38 +0100 (CET)
Date:   Tue, 10 Mar 2020 19:15:38 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i2c: tegra: Make timeout error more informative
Message-ID: <20200310181537.GA15874@ninjato>
References: <20200302173512.2743-1-digetx@gmail.com>
 <20200310113706.GW1987@ninjato>
 <017aad72-9872-a4aa-dc99-bd7d08c0db14@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <017aad72-9872-a4aa-dc99-bd7d08c0db14@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> Oh, well. I'll keep this debugging applied locally then, it's quite
> unfortunate when something fails silently :)

I understand. Still, it depends on the I2C client driver to flag it. For
some devices, this is an error. For some, just one possible state.


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl5n2UAACgkQFA3kzBSg
KbZJsA/9ErRQgh321oAvGAVlwLVHFTP4xePY7f0V2hGdPmmSFzgPjn9+Bl96RnUA
KsLYDCl4GUwQ8rsbv6O1ZNITNsWI0E5pJrye/wzjf9UXZ/UjMCMDpfkS8eBSwfKR
+XJb4OsOYz7pR0gWAUaUdEt8CLwzn/vtDH/RFJiCBXY5y7EsjkwLn/UgPrD1GI/0
+4/Q8/uKNqneFCE+L1/HsE77Q/wGwC8ufNLzkv5ngd9nw+FQi+8a6lKibxq4T03S
aKiLCx87kgh0JUronYfjAAiINs6n+9OSrIiIv9JgXSGIvFwIYqQrUrM5IxsD79AL
7qhC5VZ4kVJyBn0C6w3SabnDrmlIuHWJOsGWAU3KU/C44jSG5+uEkPspRXmecrf1
leZ95mWhZlifARo/4rK+EkT8+ReQ4z/bAzcx2o56DJHNvsGs3s/YTQDyZ+pzvNI8
UFkkle6S18B/Um7cuirg3yax7bPpXPQi7Oao1qgDDceNZW9cy5IiI3QwIV7/QB0u
Lyfs020A5cFDgYLSFYIzZ0I9qyeSAtDBWDDzd1PQWYBFNA3TryJu8RFMVS+hbCUH
UlCZd3QijSbTPzDRckoH6d17/hJdGZN84JFW4aY+UPkaxovt/POT5t7mflA2rcjf
1Gfi0u5lgcE7kQnY5Cb9PdaeI4Blv2pM1WtA6kAzC/qBlDHue9E=
=5lp1
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
