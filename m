Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A02C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9972076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puMhAhRk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgHKWmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgHKWmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:42:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C5DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:42:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a79so5434pfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=2BJ7I12bcuBi/nQVsmM4slWNJ3pB0ZokvkQzgE6npaM=;
        b=puMhAhRkzYer5B5qkblEyPSGcE5LY3iKFUuO8/A0/uKKiTsdt81za0NRPjIWT0bPz1
         k4LWzono2Gn2fSrc0UB9Gcx2ePgLXeRkbHQzxjNHDL/2NBkdSafoDjZ6z80cM9X0p61Y
         TtHtLZWe/Hy8w4uckExuRDZ/ApEfN7NdBRQ217jeDFY0tmKqfU25m0aVI2zpOMcHoDCF
         7ffzxN6rbgOMSQhljqSkt7MnldLQDODZV6WvJMCj9skolN1jYQEx1iYtQxyNlyap8x+1
         euq0hwNV3aQAHsyU+dJ459PIbfDE6CQow2Bcyfs/BO+CQ6P3PdAR0+Nxq8Hs8RzLTb0r
         GeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2BJ7I12bcuBi/nQVsmM4slWNJ3pB0ZokvkQzgE6npaM=;
        b=T2u9F/S/KvzK00W+HYvCc5kducgudHa9XtF9Pk7zcRXR9sCbEdtZjRXkH8QTAKN654
         SdjFhc5FkT5HvWk47z3z3n0MtxjDItARruCWinZovX2ogvG867DXI0c4o1jLf2C+8pMS
         4Qb9amsyXDbkZDf22LWMSDpDIb7MKrmMVT2I9ugugcxlVSXcOxZKHklFQDgezYii3YWy
         73mpe0Capl104SY6x6VQAYOs3Gm7586OE9teCdjrNE5oWh0sYBnZ+CnWBPOHysSetoci
         JtbVEdFb3wG1aWAIW5U1KLJKF03Q0Q6MYxQWVlHnLvHLnAuLHYUJvmMORBq16K8doIx3
         0PvA==
X-Gm-Message-State: AOAM533Bsy/l9W/tylH6Laydy8zjizJtwQU8dLG9VfCyCGD9Zm5WyxzE
        Y1daNg0Oqoz9Yc4qHeMBXLPLag==
X-Google-Smtp-Source: ABdhPJxcxIQB984BWW3+QfaAt883kdvFUqv7SEjziSoT8ax59ADOzg+8vogyjgRJgc7tExaKmEiIPw==
X-Received: by 2002:a63:1062:: with SMTP id 34mr2588570pgq.412.1597185727639;
        Tue, 11 Aug 2020 15:42:07 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4a0f:cfff:fe66:e92e])
        by smtp.gmail.com with ESMTPSA id n1sm124659pfu.2.2020.08.11.15.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 15:42:05 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:42:01 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@chromium.org, bleung@google.com, bleung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform changes for v5.9
Message-ID: <20200811224201.GA4099603@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-for-v5.9

for you to fetch changes up to fc8cacf3fc68664e30a6df2b361ae05b9769585e:

  platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_GET_W=
AKE_MASK (2020-07-31 12:56:36 +0200)

----------------------------------------------------------------
chrome platform changes for 5.9

* cros_ec_typec
- Add support for switch control and alternate modes to the Chrome EC Type C
  port driver
- Add basic suspend/resume support

* sensorhub:
- Fix timestamp overflow issue
- Fix legacy timestamp spreading on Nami systems

* cros_ec_proto:
- After removing all users of, stop exporting cros_ec_cmd_xfer
- Check for missing EC_CMD_HOST_EVENT_GET_WAKE_MASK and ignore wakeups on o=
ld
  ECs

* misc:
- Documentation warning cleanup.
- Fix double unlock issue in ishtp

----------------------------------------------------------------
Brian Norris (2):
      platform/chrome: cros_ec_proto: ignore unnecessary wakeups on old ECs
      platform/chrome: cros_ec_proto: check for missing EC_CMD_HOST_EVENT_G=
ET_WAKE_MASK

Enric Balletbo i Serra (4):
      platform/chrome: cros_ec_spi: Document missing function parameters
      platform/chrome: cros_ec_rpmsg: Document missing struct parameters
      platform/chrome: cros_ec_typec: Add a dependency on USB_ROLE_SWITCH
      platform/chrome: cros_ec_proto: Do not export cros_ec_cmd_xfer()

Gwendal Grignou (3):
      platform/chrome: cros_ec_debugfs: Control uptime information request
      platform/chrome: cros_ec_sensorhub: Fix EC timestamp overflow
      platform/chrome: cros_ec_sensorhub: Simplify legacy timestamp spreadi=
ng

Prashant Malani (11):
      platform/chrome: cros_ec_typec: Register Type C switches
      platform/chrome: cros_ec: Update mux state bits
      platform/chrome: cros_ec_typec: Register PD CTRL cmd v2
      platform/chrome: cros_ec_typec: Add USB mux control
      platform/chrome: cros_ec_typec: Support DP alt mode
      platform/chrome: cros_ec_typec: Make configure_mux static
      platform/chrome: cros_ec: Add TBT pd_ctrl fields
      platform/chrome: cros_ec_typec: Add TBT compat support
      platform/chrome: cros_ec_typec: Use workqueue for port update
      platform/chrome: cros_ec_typec: Add PM support
      platform/chrome: cros_ec_typec: Unregister partner on error

Qiushi Wu (1):
      platform/chrome: cros_ec_ishtp: Fix a double-unlock issue

 drivers/platform/chrome/Kconfig                  |   1 +
 drivers/platform/chrome/cros_ec_debugfs.c        |  24 +-
 drivers/platform/chrome/cros_ec_ishtp.c          |   4 +-
 drivers/platform/chrome/cros_ec_proto.c          |  42 ++-
 drivers/platform/chrome/cros_ec_rpmsg.c          |   3 +
 drivers/platform/chrome/cros_ec_sensorhub_ring.c |  98 ++----
 drivers/platform/chrome/cros_ec_spi.c            |   4 +
 drivers/platform/chrome/cros_ec_typec.c          | 399 +++++++++++++++++++=
+---
 include/linux/platform_data/cros_ec_commands.h   |  33 +-
 include/linux/platform_data/cros_ec_proto.h      |   3 -
 10 files changed, 483 insertions(+), 128 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXzMeuQAKCRBzbaomhzOw
wixwAQCR6SJtBwaiHUPJDEqU4spR+wk56RNX07ltjVHUnpxrFAEA7mUtr9KHSTxm
XS6jw39xuyNPCCDvF+Cpp1YCR42Igw8=
=lu4l
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
