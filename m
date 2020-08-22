Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7811DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4606B207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIBOX/3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHVKMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbgHVKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 06:12:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88241C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:12:54 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u18so3991073wmc.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sKQX7+QPM8TCkmUA+73lNsGtd5xyce1g0GepBIdvk64=;
        b=rIBOX/3CpjYKIN51xKf+zx02Oyx+INbrByNl31mS6zenmY6u1yK1fvH3ERNMTUE2vE
         PH7Xy480NosOyergwJKMDHmFKjGCh9iTzK3bmNyEO70pRJZQIa/WcOn57KyCTqPcs8Sq
         uPREcXafH0u3tAJCeVwGhncsPbnwibxoXERSzdv/li764kSAV487D0rhDo/zFVR9tf4E
         Z3z7Ndnq1c/tjyXittRmwrMM3uDuUY0ksFJalpZt3dOx6fDAXA/+Nz00N+US2yfeX43x
         /QfWY/zGdn+RjgiwtkpnaydK17p8hNfVz755fBHsJINyln+vzeYz+6MijQL6zEG7JjwZ
         20pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sKQX7+QPM8TCkmUA+73lNsGtd5xyce1g0GepBIdvk64=;
        b=jPyoncKuMX7yjJ6fK3PGOqUTSUKQ728Pk+gcPUdQ6I5xQ8MiQXXb6eyvAEex7jsSy3
         ZyDaGT0MtEewdTOO780GUoRWkmcPWwv+Ozp+rGuTWmk39K+6SMiSD2bmiuqS2PrQNyK+
         KmtyRi/lBlaneg5kxZrAV3AhmG/kEU/gavZae8+Mwl1nIdxToxbOe0vB219yYMSt8o9Y
         ZASb+41LCobpKb9Ii7tWPxpkqCGrVNgd6uq3Nr6Uq/kEixs7QNZjE1eOfWx+dC++EH4r
         W3fcKKy0rQG3MQpLe/nKTUGcP1vpL6iOrG8k1FazqeRYibif1PAbT2x4Pjq07XyK650Z
         vE1A==
X-Gm-Message-State: AOAM531PRdLzH7FCFcAzR40RK7LGOJyephYHP5EHcT+PR2wJ1NWKVnKA
        VVXG3f27+RczEQ6cQSQGu4jE/Q3l/h8=
X-Google-Smtp-Source: ABdhPJzK5fE5wIic0HWGpYPZRyf7qrksQ4cQO4rmzb6yJT3eYh8bPthobhCrXSWRxSV2xXPMnYg31w==
X-Received: by 2002:a1c:1b17:: with SMTP id b23mr2363635wmb.152.1598091173039;
        Sat, 22 Aug 2020 03:12:53 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id v20sm10732193wrd.6.2020.08.22.03.12.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 03:12:52 -0700 (PDT)
Date:   Sat, 22 Aug 2020 13:12:50 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes pull request for kernel 5.9-rc2/3
Message-ID: <20200822101250.GA16935@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver fixes for 5.9-rc2/3.
Mostly security fixes but also some functionality fixes. More details are
in the tag.

Thanks,
Oded

The following changes since commit 51072c0f5b5e98a035c6f63b83ba2afedbb7accd:

  mei: hdcp: fix mei_hdcp_verify_mprime() input parameter (2020-08-18 15:39:38 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-08-22

for you to fetch changes up to 5aba368893c0d9e275f4b823e053fd16155f63b9:

  habanalabs: correctly report inbound pci region cfg error (2020-08-22 12:47:58 +0300)

----------------------------------------------------------------
This tag contains the following bug fixes for 5.9-rc2/3:

- Correct cleanup of PCI bar mapping in case of failure during
  initialization.

- Several security fixes:
  - Validating user addresses before mapping them
  - Validating packet id (from user) before using it as index for array.
  - Validating F/W file size before coping it.
  - Prevent possible overflow when validating address from user in
    profiler.
  - Validate queue index (from user) before using it as index for array.
  - Check for correct vmalloc return code

- Fix memory corruption in debugfs entry

- Fix a loop in gaudi_extract_ecc_info()

- Fix the set clock gating function in gaudi code

- Set maximum power to F/W according to the card type

- Cix incorrect check on failed workqueue create

- Correctly report error when configuring the PCI controller

----------------------------------------------------------------
Colin Ian King (1):
      habanalabs: fix incorrect check on failed workqueue create

Dan Carpenter (2):
      habanalabs: Fix memory corruption in debugfs
      habanalabs: Fix a loop in gaudi_extract_ecc_info()

Oded Gabbay (1):
      habanalabs: set max power according to card type

Ofir Bitton (9):
      habanalabs: unmap PCI bars upon iATU failure
      habanalabs: Validate user address before mapping
      habanalabs: validate packet id during CB parse
      habanalabs: verify user input in cs_ioctl_signal_wait
      habanalabs: set clock gating according to mask
      habanalabs: proper handling of alloc size in coresight
      habanalabs: validate FW file size
      habanalabs: check correct vmalloc return code
      habanalabs: correctly report inbound pci region cfg error

 drivers/misc/habanalabs/common/command_buffer.c    | 16 +++-
 .../misc/habanalabs/common/command_submission.c    |  8 ++
 drivers/misc/habanalabs/common/debugfs.c           |  8 +-
 drivers/misc/habanalabs/common/device.c            |  9 ++-
 drivers/misc/habanalabs/common/firmware_if.c       |  9 +++
 drivers/misc/habanalabs/common/habanalabs.h        |  7 +-
 drivers/misc/habanalabs/common/memory.c            |  9 ++-
 drivers/misc/habanalabs/common/mmu.c               |  2 +-
 drivers/misc/habanalabs/common/pci.c               |  8 +-
 drivers/misc/habanalabs/common/sysfs.c             |  7 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 92 ++++++++++++++++------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  3 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  8 +-
 drivers/misc/habanalabs/goya/goya.c                | 31 ++++++++
 drivers/misc/habanalabs/goya/goya_coresight.c      |  8 +-
 15 files changed, 178 insertions(+), 47 deletions(-)
