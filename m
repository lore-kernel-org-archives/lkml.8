Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8997BC38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D0420CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 19:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LD7UkEVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBXT7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 14:59:52 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33992 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXT7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 14:59:52 -0500
Received: by mail-pg1-f195.google.com with SMTP id j4so5688267pgi.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 11:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8cle6FmbDb89jzrGhTz6Cfv64lMjzYvvlKlpjrjSc90=;
        b=LD7UkEVnWYtjbAEFsWGmA8GKCjrtpc0lyPmTM8VxYWF8oCcYQu2iGetGy/nkiJuCNp
         FiYj7LadGa2h1DpKPJJlxlNmhF761uq+vkok4cx9VYt/IbkgbBh/T1pZF9qVBCG21oZH
         CBtaqrurZ8jrjB/j9OiPFXD8NPnMJZtXSdgtlM6SzEQTo3kp3uTUE6QJnYtZeEtBSkbj
         0FStMzXtcrsgss9eyQ2encwCCVtUITNChpdUWhmkFfbvEJSe1FnRrLr1eOwIOR9TQdAm
         1dBmU+UYLN6FWiPGz26Ci2Mk1SFtxNnygtxiYkC8XgZHfGX8/O6uGPe0UApIA/yplPVU
         ArWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8cle6FmbDb89jzrGhTz6Cfv64lMjzYvvlKlpjrjSc90=;
        b=Zh5Jx3faepm4m1uvYVeTv7iLYEOBAyqgQSclZcbWYQdyg/uhLGL8PeOuiYCS1td/Nw
         BOEX3dV0H34ArXUPAOSyRUnbuxasGevLcSzJz9Vyt8E1K2RMpKwKp8qptpaXnqu+8Bn2
         ylXJbiM4wW6C2ceIAujYLAa9ZQxQ9Wv99sD24uoM8td+NowydwMeIQbdG1f2eChS55jH
         6I6uevPT4tIL59Y5uf1uNgujISxX7lLdwKmwQoujeeBz2ZTgree5nMGQUTs/5iq2Fi1g
         2+dG2u+6BhI4JRmx6aOQ+8hhVqHgnkgVOf6CdcOVzxNENKhUAeJ2QcYpVggTY/AJZ8aG
         7vaQ==
X-Gm-Message-State: APjAAAXyNfHCwDwxvhJBykFBjl0TbYGX0lVdo3XyV1UI+ZfWWDhe2CZT
        wOt48IfKKDoXBYfU1zn45uwWAw==
X-Google-Smtp-Source: APXvYqx6ZBKJM5xOsEMNoHeqwFTTiZsYugC3HTFOB2sN6LRNFH3whHanvzIo4xFKtfkPH8oWIHUgBw==
X-Received: by 2002:a63:ec0c:: with SMTP id j12mr52450477pgh.78.1582574391510;
        Mon, 24 Feb 2020 11:59:51 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id j125sm13845759pfg.160.2020.02.24.11.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 11:59:50 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:59:43 -0800
From:   Benson Leung <bleung@google.com>
To:     sre@kernel.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org,
        sre@kernel.org, sebastian.reichel@collabora.com,
        pmalani@chromium.org
Subject: [GIT PULL] IB between chrome-platform/power_supply for v5.7
Message-ID: <20200224195943.GA30398@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

The immutable branch ib-chrome-platform-power-supply-cros-usbpd-notify
is now ready. Please merge for v5.7.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git i=
b-chrome-platform-power-supply-cros-usbpd-notify

for you to fetch changes up to f2437e48ac7ae0e99b8e76d88aaf24a9b2e6d3e2:

  power: supply: cros-ec-usbpd-charger: Fix host events (2020-02-10 11:01:3=
3 -0800)

----------------------------------------------------------------
Jon Flatley (2):
      platform: chrome: Add cros-usbpd-notify driver
      power: supply: cros-ec-usbpd-charger: Fix host events

 drivers/platform/chrome/Kconfig                 |  14 ++
 drivers/platform/chrome/Makefile                |   1 +
 drivers/platform/chrome/cros_usbpd_notify.c     | 169 ++++++++++++++++++++=
++++
 drivers/power/supply/Kconfig                    |   2 +-
 drivers/power/supply/cros_usbpd-charger.c       |  50 +++----
 include/linux/platform_data/cros_usbpd_notify.h |  17 +++
 6 files changed, 220 insertions(+), 33 deletions(-)
 create mode 100644 drivers/platform/chrome/cros_usbpd_notify.c
 create mode 100644 include/linux/platform_data/cros_usbpd_notify.h

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXlQrLwAKCRBzbaomhzOw
wsW6AQCiQwv3nbMrcYA4r09kSGBHW/FfRYpz99u88LC/vtoNCwEA76winASDD5nJ
floO1hr1/Wgahu7MarUwpSJnjX2GKwE=
=23Ly
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
