Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B05C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07D7F208D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgEFOwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbgEFOwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:52:50 -0400
X-Greylist: delayed 404 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 May 2020 07:52:50 PDT
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D52C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:52:50 -0700 (PDT)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 0FEC0976579; Wed,  6 May 2020 16:46:03 +0200 (CEST)
Date:   Wed, 6 May 2020 16:46:02 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
To:     linux-kernel@vger.kernel.org
Cc:     rafael.j.wysocki@intel.com, jroedel@suse.de, tglx@linutronix.de,
        x86@kernel.org
Subject: Failure to shutdown/reboot with intel_iommu=on
Message-ID: <20200506144558.GA4019@taurus.defre.kleine-koenig.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

On my Lenovo T460p I cannot shutdown and reboot when the iommu is
enabled. This is using linux 5.2.7 as provided by Debian, 5.6.4 has the
same problem. Suspend/resume also fails; I suspect this is the same
issue.

When requesting power off the kernel messages just end with:

	sd 0:0:0:0: [sda] Synchronizing SCSI cache
	sd 0:0:0:0: [sda] Stopping disk
	e1000e: EEE TX LPI TIMER: 00000011
	ACPI: Preparing to enter system sleep state S5
	reboot: Power down
	acpi_power_off called

(photo at https://www.kleine-koenig.org/tmp/uklsiommu.jpg in case I
mistyped something. Full dmesg and lspci -vvv at
https://www.kleine-koenig.org/tmp/uklsiommu.tar.gz with and without
iommu enabled.)

With the iommu disabled (CONFIG_INTEL_IOMMU_DEFAULT_ON unset or
intel_iommu=off on cmdline) the machine just works as expected
(including working suspend/resume).

I already talked to tglx on irc but unfortunately no new insights
resulted from that.

Any ideas how to fix or continue debugging the issue?

Best regards
Uwe

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl6yzaMACgkQwfwUeK3K
7AlMdwf5Afr+w0Br3FyVlVy4pC4aUnHefouBHZNIol0+Hm5hb7VVMhoFw34+lR9E
0PHaJD3e39LaNgGDmk+E+zl1hR9Agdc1n0/DzQ5lR3W7N6Eh7b8XCNKt2lJFCq4n
GgGi7k7E8OOOZGJ+mcq+GY6olEa7XX1N1WVC7YSLONvAKbir8ZdBJfiFWBFTa7T7
bR8WPemukFFF5SPcWMnWRQiAA3GTIN4ywxu0gyZgbY2/TbLI5GxiYRnbhn+Ua6L1
uorkIbFMDfpznWC0tMlzQoqw2DmUMVLV36cf9I/jlBjkyGr4MNXa4BfsmT7iP39G
tIVJaVmeE5w5B7Wand11hT6XvsXWGQ==
=Uf1G
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
