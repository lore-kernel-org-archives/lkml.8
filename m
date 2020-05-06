Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49094C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CE472076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHI1qGwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730392AbgEFWrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728888AbgEFWrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:47:47 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A45C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:47:46 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a32so1731869pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aF4PxbdYp03qzyU+ACXxxmAi3qTsIewGTvd30HCWUlE=;
        b=uHI1qGwEeFse/Efk8gEP6IBFYisWBKOMhBniVNUSfYk0OCkeSbUQf+CGUh4HmpulKV
         Mc2peMkxEkS+ZLkdQ6OTC5uva2LEuDtPjCTw+Gb1DOQUmOxTHdDkPd9jlB8LaGMs18qg
         RTTremJVpUn1xgCqtoVpMMoJT0Sm40BwhNpLqey7du07abt1giAG0svAZG52Kxp0AW01
         IozF6WsfjhLWfwGJ34GoK1aBPPSo3Mjo8PoLx0HfEJsxGS1BJsXJfbsfahcuHNHv3MiA
         bteKQ5tJdkvS/yzbT+PCgay3Wa6ot54VoV8avUEPMLaOfxqruHmToQN53O1gMIFbLJtm
         epZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aF4PxbdYp03qzyU+ACXxxmAi3qTsIewGTvd30HCWUlE=;
        b=uPAjaJ0WrI2deJiEoXEZBQHVOTRYP10dhHjhG4utRF/q8NiL1VGQGFp8j/U28bDz6e
         oyLUL3OWW3RoAsvpWg5UnCJMpGB29w+0jFr8NglU2d3C20rIJZV+IankTER8MZtSzFUM
         f3PF3fRgOJQ/0v4GAghqBRiJYUN09DymXy/jF+ZDfoLro/tQnvw0lQEfVWSJ7iYMTPvG
         keyr79adGfY1O7HzG3c0MH/FTl6UFrDFozWBFCdE/TQ68BesDPesWQ2nRLzc8dtjAdsT
         CyZYnBV6sMu3dsVD8u2dioFTOE8hPj8L9MJwDAbMcpI5oym6240meXKtcBe/dAQOt/mR
         NhOg==
X-Gm-Message-State: AGi0PuaILm77vK16Sie8aWCZ79ZUvybElgwaQl7Xi5DRZdJuQnHE6363
        WPyepkK2S5MzmXEr43ZfY6B03w==
X-Google-Smtp-Source: APiQypIeyhS/t6BiQdv9RxG/LdfzrdbwQnNrqwul/GVSTyfdZCKyPg2Y0op5moBiRn83mY7j358Dsw==
X-Received: by 2002:a17:902:9882:: with SMTP id s2mr10270305plp.184.1588805265213;
        Wed, 06 May 2020 15:47:45 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id a12sm2434061pgv.14.2020.05.06.15.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:47:43 -0700 (PDT)
Date:   Wed, 6 May 2020 15:47:37 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes for v5.7-rc5
Message-ID: <20200506224737.GA159981@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 538b8471fee89eaf18f6bfbbc0576473f952b83e:

  platform/chrome: cros_ec_sensorhub: Add missing '\n' in log messages (202=
0-04-13 16:31:33 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.7-rc5

for you to fetch changes up to b31d1d2b1c3a8452f425b09ebd374ecd3ddd5179:

  platform/chrome: cros_ec_sensorhub: Allocate sensorhub resource before cl=
aiming sensors (2020-04-29 23:17:45 +0200)

----------------------------------------------------------------
chrome-platform  fixes for v5.7-rc5

Fix a resource allocation issue in cros_ec_sensorhub.c.

----------------------------------------------------------------
Gwendal Grignou (1):
      platform/chrome: cros_ec_sensorhub: Allocate sensorhub resource befor=
e claiming sensors

 drivers/platform/chrome/cros_ec_sensorhub.c      | 80 ++++++++++++++------=
----
 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 73 +++++++++++++--------
 include/linux/platform_data/cros_ec_sensorhub.h  |  1 +
 3 files changed, 93 insertions(+), 61 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXrM+iQAKCRBzbaomhzOw
wnCKAQCxsKN7dd8VizGA7jnEL3xC1ZZHss2vhmpucvfbSa9mdQEA7g32hCHpeNzt
26E8dfEeAfSDZ+b2K+r3RZxuFl1d0AE=
=LNFy
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
