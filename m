Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78652067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifpo6Kxk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgFDAOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:14:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D7C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:14:51 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id jz3so295636pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xho0EADjNY0GSWzqaxWpJ5gbHyxDY8y3qN5WHNAsmyo=;
        b=ifpo6KxkvKkGm1/rkHVP6kojWXNdPTXF6hU2eU/OXBdq00KMJu31T09K1b5haSuxat
         qmJRgrOciroUtSl+sYEDFLkQlBTNVVYb9b8oIcTU4fK1587mjaCJeJvL4kYT2DpDrOon
         4A7WQ7Rr6gOYWnRiZ31hvsTaih++3UGcmiCs0h7aoSN7TgO6OC690/XRS+sfrMCn6DDY
         +DvOVMBiMRcjRGrn2AUgnR5JUc8cbMBBDXJcpt9H8bi42f8OJfK1103LFaD+3Yppm/Bx
         aBhCHNGRrrWF9Dg7JwzypqGEDtO8kvQQXt1c9Uxmmt84zGyRBo8CoogdB8wQP7mvh8bX
         PXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xho0EADjNY0GSWzqaxWpJ5gbHyxDY8y3qN5WHNAsmyo=;
        b=QZZFPA3uftD13+VT7ZgvhHrR1yu8iTsFr+WC1dBR2JfxNUBK9imC71BlgMYarQavbE
         r2G+phRECRJoYnjMF+Jfg1en4/I1SIDQIy2l9gtVvXfliYpeZ5j22G81X8YXW8Z3E+ke
         ls2ldDU3NMn3kcGXMaUgjwa7cVywbazDZBVtkLGcTY0HfW1hk6Rkl3pl1hMT1gPTciXE
         9KXUyCUsSDXlmkXug+9Pe9HXfdbp6+yI322uvDjSHVV6pHkvXETxG13L40UT+9Ed+K5M
         12VZ/EA22+MRxDLcp9k1PGczs6W/YzyicFBcQvMs40XYiYqMUsDOBXPgAhMxNHyGWDV+
         F4IA==
X-Gm-Message-State: AOAM531CuZw9TeUQhFqjoCoNGtfAjP2mo5THHVxhAeTghO8GFJbS1IFg
        AD3+NiM6KCF+q8JUKt65jQmTqQ==
X-Google-Smtp-Source: ABdhPJzwdv/64RiSyisivOxx8yXWfx6AyLoXxziSwwSRkAldQ0S8fvURXEgtef0TtHTOuEIAi7FdhA==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr2373363pls.154.1591229689601;
        Wed, 03 Jun 2020 17:14:49 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id e143sm2748037pfh.42.2020.06.03.17.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 17:14:47 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:14:41 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.8
Message-ID: <20200604001441.GA257203@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.8

for you to fetch changes up to bbb7ad49b8350b79261ce087c8e101d92f15533d:

  platform/chrome: cros_usbpd_logger: Add __printf annotation to append_str=
() (2020-05-04 14:02:01 -0700)

----------------------------------------------------------------
chrome platform changes for 5.8

* cros_ec_typec
- Add notifier for update, and register port partner

* Sensors/iio:
- Fixes to cros_ec_sensorhub around allocation of resources, and send_sampl=
e.

* Wilco EC
- Fix to output format of h1_gpio

* Misc
- Misc fixes to appease kernel-doc and other warnings.
- Set user space log size in chromeos_pstore

----------------------------------------------------------------
Benson Leung (1):
      Merge remote-tracking branch 'origin/chrome-platform-5.7-fixes' into =
for-kernelci

Bernardo Perez Priego (1):
      platform/chrome: wilco_ec: Provide correct output format to 'h1_gpio'=
 file

Christophe JAILLET (1):
      platform/chrome: cros_ec_sensorhub: Add missing '\n' in log messages

Dan Carpenter (1):
      platform/chrome: cros_ec_sensorhub: Off by one in cros_sensorhub_send=
_sample()

Enric Balletbo i Serra (3):
      Merge remote-tracking branch 'origin/chrome-platform-5.7-fixes' into =
for-kernelci
      platform/chrome: cros_ec_i2c: Appease the kernel-doc deity
      platform/chrome: cros_usbpd_logger: Add __printf annotation to append=
_str()

Gwendal Grignou (1):
      platform/chrome: cros_ec_sensorhub: Allocate sensorhub resource befor=
e claiming sensors

Jett Rink (2):
      platform/chrome: cros_ec_ishtp: skip old cros_ec responses
      platform/chrome: cros_ec_ishtp: free ishtp buffer before sending event

Prashant Malani (4):
      platform/chrome: cros_ec_typec: Use notifier for updates
      platform/chrome: cros_ec_typec: Add struct for port data
      platform/chrome: cros_ec_typec: Register port partner
      platform/chrome: typec: Fix ret value check error

Sarthak Kukreti (1):
      platform/chrome: chromeos_pstore: set user space log size

 drivers/platform/chrome/Kconfig                  |   1 +
 drivers/platform/chrome/chromeos_pstore.c        |   1 +
 drivers/platform/chrome/cros_ec_i2c.c            |   2 +-
 drivers/platform/chrome/cros_ec_ishtp.c          |  45 ++++++---
 drivers/platform/chrome/cros_ec_sensorhub.c      |  80 ++++++++-------
 drivers/platform/chrome/cros_ec_sensorhub_ring.c |  81 +++++++++------
 drivers/platform/chrome/cros_ec_typec.c          | 119 +++++++++++++++++++=
----
 drivers/platform/chrome/cros_usbpd_logger.c      |   1 +
 drivers/platform/chrome/wilco_ec/debugfs.c       |   7 +-
 include/linux/platform_data/cros_ec_sensorhub.h  |   1 +
 10 files changed, 242 insertions(+), 96 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXtg88QAKCRBzbaomhzOw
wjn1AP4izCAv6fVAWowIHIgQrQuw7H6b1MGkexlKIMpBaJiv5AEA6gE8I4ZI4fOj
8rX5ah6YHAvPkEWOyTExyNjgKpwCKAY=
=Kt0R
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
