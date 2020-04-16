Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC407C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E597221F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 21:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TUeRiIpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgDPVkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 17:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgDPVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 17:40:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F3C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:40:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id c23so35563pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=8aG+D1bxFs40qRNz6VZ0aSOapi3D49e6jMSTWw1lJbM=;
        b=TUeRiIpMwOYF4qXOuU/7ZgGvCKqQJUuyAMWEyYYFql0jF9GHVRhw/J9/Sn/V3khDdX
         N/SEvbMBH3dsUszDG4Tt11G76QQV+/Ve95dV3PmnU5B5COyceRtt6EriAa1DS5TpDqR4
         TBVqoa6aSKqhO3GMfSHVgvjxpeHxVT1648Q5qKVTNKmrQQhu/pELZz1XNaIZBzOPcIYE
         0u27bc/BPDfjMz4mDGAgMyqrwmwLVPbj13RNpB0IYTAtSpJhwa3cLVLHGE+baAWb6g8T
         e9ZuCIgKnAr8ueh18YkmVEycuuMOzPfuLrmeEzhBBnRIQiK72oS2epiBoh4H1W8vGnUt
         OmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=8aG+D1bxFs40qRNz6VZ0aSOapi3D49e6jMSTWw1lJbM=;
        b=cRqtgUCo49b1P89wqY/5nyC9L8iIUUJwCaM27F9GHHS9+H6zmjNXAgGOpbCjrTRR4x
         ATlflbLBdK5SJQYFDjawmT8/P9gsYpuoxaL3WfuhjjaEhDuyry+VU/UVuf7U7AymaVfW
         P2A/V9QGNETwa3AElkCWOHsXLYv80gRSvx0KZZfiBxUbLargLw9m7G/nyqbbVxASTnQQ
         8F3WYOE5QmoacI4cPAvnGO+irSzcjvFuS3mIjq7+Nef/Za6He4CvkEh6E/+KNXw/86rU
         JrTFgxON80dGJ8TRWVgiECHtp2/WSck+IvybdW8Y+N/q4hygSvdWME7A+6bi+rmuMvDo
         sAjA==
X-Gm-Message-State: AGi0PuaEE0+D+nFmQVgS6XJ0X74ZadqZOaj1U2bcJuh+bEDOJmUb4Jlr
        Nb4jbkuLxS1vPy6utqCjUtSwTA==
X-Google-Smtp-Source: APiQypL4M6ez4cFXmXy05xoKGpxnJPamoEwq0HN08Szo77mThr/M/YKShIqnfUd03a7EXe74dtN03A==
X-Received: by 2002:a62:ce84:: with SMTP id y126mr28521665pfg.244.1587073240829;
        Thu, 16 Apr 2020 14:40:40 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:bc61:d85d:eb16:9036])
        by smtp.gmail.com with ESMTPSA id g14sm12358852pfh.49.2020.04.16.14.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 14:40:39 -0700 (PDT)
Date:   Thu, 16 Apr 2020 14:40:35 -0700
From:   Benson Leung <bleung@google.com>
To:     torvalds@linux-foundation.org
Cc:     bleung@kernel.org, bleung@chromium.org, bleung@google.com,
        enric.balletbo@collabora.com, linux-kernel@vger.kernel.org
Subject: [GIT PULL] chrome-platform fixes for v5.7-rc2
Message-ID: <20200416214035.GA1586@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit a46387712da12b61bf1ce1a3f63b60a17b098960:

  platform/chrome: cros_ec_spi: Wait for USECS, not NSECS (2020-04-07 14:42=
:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git t=
ags/tag-chrome-platform-fixes-for-v5.7-rc2

for you to fetch changes up to 538b8471fee89eaf18f6bfbbc0576473f952b83e:

  platform/chrome: cros_ec_sensorhub: Add missing '\n' in log messages (202=
0-04-13 16:31:33 +0200)

----------------------------------------------------------------
chrome-platform  fixes for v5.7-rc2

Two small fixes for cros_ec_sensorhub_ring.c, addressing issues
introduced in the cros_ec_sensorhub FIFO support commit.

----------------------------------------------------------------
Christophe JAILLET (1):
      platform/chrome: cros_ec_sensorhub: Add missing '\n' in log messages

Dan Carpenter (1):
      platform/chrome: cros_ec_sensorhub: Off by one in cros_sensorhub_send=
_sample()

 drivers/platform/chrome/cros_ec_sensorhub_ring.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCXpjQ0wAKCRBzbaomhzOw
wiflAP9NBjweJ+bXa0T7QPbvajU/5qTNdF286ZsX7XbAepT6QgEAuKGfhyYP7lbW
I6kfGxbHvlRh9G0GfAq7qNb0oec+CwI=
=rlo1
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
