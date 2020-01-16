Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D46C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0A32464B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bg8TrOBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393908AbgAPR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:58:13 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35135 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406471AbgAPR6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:58:09 -0500
Received: by mail-pg1-f195.google.com with SMTP id l24so10276277pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Dxc/6KX/S9brz/lHW4Hzhowhi5VkBu+IFXygBkuYd8g=;
        b=Bg8TrOBUqAVuyOSQls8qBNh2ejX9OIzuFNauOlz/jWXocE2eWXE+EU+BCWRs7QKInX
         RwNdGjRmxJkcV1kyRxdEVLocROgfCywVsA+YlgwU8PgOVrz9bP7FXWtZ4EureVqFSaxB
         Yv425m6JCXFiTy4bTXdEFHx8CE2o7RCPS0Lm61Di9hzdRGHlx4AadjmG7/xM19Z9I/BF
         puFBfz3pe5ZNwFcqV+njed742NSap1IEcQuGKKCUDca5E7FxQZ7hHYkXM8mL74T/JAu/
         OD6rzCuwToZSB/BspsDGMzC4xZpg4DCeess3Iwtw57S8Udn0BrsVdNvsj8sTdWDv9JTE
         n5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Dxc/6KX/S9brz/lHW4Hzhowhi5VkBu+IFXygBkuYd8g=;
        b=TEuz4LY7rKe19bDUxqNO82gDD75xDHzEArsGKIirh/93HUPK3EFVG+SnUS4VYwkjd+
         eovVapIkljDlHJ2oVLQseeczDVXG5rJx3Ni9niV0t46MsXONYjy4eJOjl+yeywWgsm90
         ejNCurepspv+K61AdygOOcWbrwkJuQLMHcUh7DjTEz+Sz5kVLOmN/aR82PiV8fVKq48M
         BqkJDERhODLidvKSWcC77SgW7yIMoh4RfPM6GxkT3QAKQRwuftaM8qZvGRs7z+hmB9IF
         i4woFn4IPbgU1JatXlylWiQrVQ9PEWNouuPHZC3HEe2DKJWQDucX/pJewAqWIOz7mlzP
         6Pjg==
X-Gm-Message-State: APjAAAV/NtTvGc3OzysVICaOe9gTyNrpbn0lsDAFCenhrDyvjoJrbXUA
        55TfQlIJSliQxjMkYDAryUbN+Q==
X-Google-Smtp-Source: APXvYqz4MeG42gziTyNm2fAxWERKAJtQ+esEwOyM+kujl8hEbsltijSLF76QgD3pJJPciz/w8q3aCg==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr39382628pfn.245.1579197488202;
        Thu, 16 Jan 2020 09:58:08 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id a23sm27909031pfg.82.2020.01.16.09.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:58:07 -0800 (PST)
Date:   Thu, 16 Jan 2020 09:58:02 -0800
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes for v5.5-rc7
Message-ID: <20200116175802.GA147875@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 856a0a6e2d09d31fd8f00cc1fc6645196a509d56:

  platform/chrome: wilco_ec: fix use after free issue (2019-12-02 12:14:42 =
+0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.5-rc7

for you to fetch changes up to dfb9a8857f4decbba8c2206e8877e1d741ee1b47:

  platform/chrome: wilco_ec: Fix keyboard backlight probing (2020-01-10 14:=
57:58 -0800)

----------------------------------------------------------------
platform/chrome fixes for v5.5-rc7.

One fix in the wilco_ec keyboard backlight driver
to allow the EC driver to continue loading in the absence
of a backlight module.

----------------------------------------------------------------
Daniel Campello (1):
      platform/chrome: wilco_ec: Fix keyboard backlight probing

 drivers/platform/chrome/wilco_ec/keyboard_leds.c | 28 +++++++++++++++++---=
----
 1 file changed, 20 insertions(+), 8 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXiCkKgAKCRBzbaomhzOw
wl4AAP0fSaN/j6rxaGifUC52ynlL7W6prsoxIgUktxkN9z96rwEA+dOUC4XVyMZE
RGN9zYSEp9J4ueAYQVoWRq3klHt5bAU=
=rGzL
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
