Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EDDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2498720691
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726591;
	bh=G41TtowFXaO/DAZpu0cVYo8z661oriNucxG1XFKHoPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s10XSMzRgzNPXGKP01qyCl8F2QPp0do4WiGUNrlzA2mPqnw2aTTv6DOACrMNfCVY8
	 gcUwWVlHy9UdcN6hXOPBzL/Z7PHHB+steVHfT3ZxXq5Kc0pK5sdpvZRZWcb0bFCmqN
	 /gzpPE0Cas1T/Xmp+zt8Khu5oES2qth2Hddq7aos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbgFISQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388342AbgFISQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:16:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FBA2067B;
        Tue,  9 Jun 2020 18:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591726577;
        bh=G41TtowFXaO/DAZpu0cVYo8z661oriNucxG1XFKHoPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gyw51rIpi+ulSqItNrsmtKb5h+dKcu8gVfAGFvj7KkdeSp8+nHiXuDbW9zYEOdHs5
         ezOBuAZkwbHHeKHQuPDtyD4oc8RAgxLfzL3R5XqyqRlvrIeOruIL2y9KYURGeoWvRU
         nxEvl/QT0JBuEXwKlwDUkyoIQYEA5ypZfUKNs2J0=
Date:   Tue, 9 Jun 2020 19:16:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        robh@kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] TAS2563 DSP Firmware Loader
Message-ID: <20200609181615.GR4583@sirena.org.uk>
References: <20200609172841.22541-1-dmurphy@ti.com>
 <20200609175203.GP4583@sirena.org.uk>
 <6d6aaed3-dac8-e1ec-436c-9b04273df2b3@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Hnpg0BSo5EvPlUVi"
Content-Disposition: inline
In-Reply-To: <6d6aaed3-dac8-e1ec-436c-9b04273df2b3@ti.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Hnpg0BSo5EvPlUVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2020 at 01:07:50PM -0500, Dan Murphy wrote:
> On 6/9/20 12:52 PM, Mark Brown wrote:

> > I think you can just use enums for most of this - what you want to do I
> > think is parse the firmware, build templates for the controls and then
> > add them with snd_soc_add_component_controls().  Userspace *should* cope
> > with controls being hotplugged.

> Yes this was my concern if userspace could cope with dynamic controls.

Things like alsactl definitely do, and obviously anything that starts
after the firmware loads will be fine too.

--Hnpg0BSo5EvPlUVi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7f0e4ACgkQJNaLcl1U
h9BPZQf/QjR//jsXKkphJTsgYAHAiZJBkN3aZllUBbN4UHEukwcGT+6r/86c4C2S
bbRZ6krfhaQSfsFfKOKOlkSc6M4VFbSF8QHPDJgg+QxYNCyxn4YkKu+0PWp8bnYs
wza4rfr4xY3bMxxfeZT9IeNP7FnrV5F6oMxe2cjnZmhK2KsoJQq/WmovNok8s4yp
EzD+jAm38oRvC5pi7e6uqoekZMqJk0/YSz3mq0tqPKHQrobR/CPXbcak3ZbYPETL
TIwy58cQZ4gjzkA5Bc0HLo1J9B+naB/MCsAXIUdwFregMK3xdEVjYoX3Zu2bejuK
6VwccB7gTl9byPZqfVQM/rsUHtanKg==
=TxgD
-----END PGP SIGNATURE-----

--Hnpg0BSo5EvPlUVi--
