Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6374FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D8C207FB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 13:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590239866;
	bh=izs3L0GvAzSBH3xQs8FK+24bAZLFRXWMCn2JLVynBlI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Cq63253Y17pZ5ckIkWqqUfRvcVf6b0wi2ujc2qZA4KXUA0a4fOn1EvzAKDd8YU7CC
	 /mUpjA0G+OX/NbnewFCJPMBTt1d+/xtFmrkXT2IhyofT9ezzi0IYT0jxBIAoMcTl2f
	 Z7jJEU3aFVNt9eA+ekza03OyTr8mvMCETxSqXXp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgEWNRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 09:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:55866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387763AbgEWNRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 09:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20D27207F9;
        Sat, 23 May 2020 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590239864;
        bh=izs3L0GvAzSBH3xQs8FK+24bAZLFRXWMCn2JLVynBlI=;
        h=Date:From:To:Cc:Subject:From;
        b=Sc6WsJF0x7sHcNlby8ybfLukghW24Cx8oGlGe55EEspSdrkYVn/YnpdR04m2IFIuQ
         mCpQmpGpNzfXBVG3ONtxNsPzAuL6wpP4RBn9B/hQXfmvvUHl3TpWnfcpjP1ew0cK8e
         O3UdJQfyLE+2jXy5t5tU7WFzP3r90iXCgWP22Ffg=
Date:   Sat, 23 May 2020 15:17:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging/IIO driver fixes for 5.7-rc7
Message-ID: <20200523131742.GA55395@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.7-rc7

for you to fetch changes up to bcb392871813ef9e233645557d6dd85bb1a6f41a:

  Merge tag 'iio-fixes-for-5.7b' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2020-05-15 16:04:24 +0200)

----------------------------------------------------------------
Staging/IIO fixes for 5.7-rc7

Here are some small staging and IIO driver fixes for 5.7-rc7

Nothing major, just a collection of IIO driver fixes for reported
issues, and a few small staging driver fixes that people have found.
Full details are in the shortlog.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christophe JAILLET (2):
      iio: dac: vf610: Fix an error handling path in 'vf610_dac_probe()'
      iio: sca3000: Remove an erroneous 'get_device()'

Dan Carpenter (2):
      iio: imu: st_lsm6dsx: unlock on error in st_lsm6dsx_shub_write_raw()
      staging: wfx: unlock on error path

Dragos Bogdan (1):
      staging: iio: ad2s1210: Fix SPI reading

Fabrice Gasnier (2):
      iio: adc: stm32-adc: fix device used to request dma
      iio: adc: stm32-dfsdm: fix device used to request dma

Greg Kroah-Hartman (1):
      Merge tag 'iio-fixes-for-5.7b' of https://git.kernel.org/.../jic23/iio into staging-linus

Gregory CLEMENT (1):
      iio: adc: ti-ads8344: Fix channel selection

Matt Ranostay (1):
      iio: chemical: atlas-sensor: correct DO-SM channels

Oscar Carter (1):
      staging: greybus: Fix uninitialized scalar variable

Wei Yongjun (1):
      staging: kpc2000: fix error return code in kp2000_pcie_probe()

 drivers/iio/accel/sca3000.c                  |  2 +-
 drivers/iio/adc/stm32-adc.c                  |  8 ++++----
 drivers/iio/adc/stm32-dfsdm-adc.c            | 21 +++++++++++----------
 drivers/iio/adc/ti-ads8344.c                 |  8 +++++---
 drivers/iio/chemical/atlas-sensor.c          | 14 +++++++++++++-
 drivers/iio/dac/vf610_dac.c                  |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  7 +++++--
 drivers/staging/greybus/uart.c               |  4 ++--
 drivers/staging/iio/resolver/ad2s1210.c      | 17 ++++++++++++-----
 drivers/staging/kpc2000/kpc2000/core.c       |  9 ++++-----
 drivers/staging/wfx/scan.c                   |  4 +++-
 11 files changed, 61 insertions(+), 34 deletions(-)
