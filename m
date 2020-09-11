Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA1CC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 193CF21D92
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 12:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599827263;
	bh=TsJlJXLOn6eC1f0QnzLEss3twLn7+LoEFTB+YfdI7SU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1zsPrZREpshm6Q7jh/EMcIZTGorbiqp3I/LBDB7p2DzgBrVX7nF7oexN3jIv3pW5p
	 ml26kS/fKs0vJGRxhXK8e8MNJD6/36T7LEpXl3vtHd9AfkKqp/eHhud2uEbNTYhdED
	 snzStPQKEPCLSrtFF4XXxYyj3SC4PRPE1bsZ1bWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgIKM1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 08:27:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgIKMXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:23:20 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E34421D40;
        Fri, 11 Sep 2020 12:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599826997;
        bh=TsJlJXLOn6eC1f0QnzLEss3twLn7+LoEFTB+YfdI7SU=;
        h=From:To:Cc:Subject:Date:From;
        b=EvlW+mhm5KorQ50qVeSIiqTFJHHvbwI8I1g9K+N5cA+m7Id2cuADYU71hK9XyInnm
         b6eXIb6aUw0519g2Btr6bTyPgKi1WQszD+Kh+1VfuNobCr5SBkuWG284YHFF0ZkcLs
         UNLrwxv5rrSrr6dixrKGqBrUBXT7TAqcrKdKkoL0=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.9-rc4
Date:   Fri, 11 Sep 2020 13:22:23 +0100
Message-Id: <20200911122317.2E34421D40@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc4

for you to fetch changes up to 59ae97a7a9e1499c2070e29841d1c4be4ae2994a:

  regulator: pwm: Fix machine constraints application (2020-09-02 19:13:29 +0100)

----------------------------------------------------------------
regulator: Fixes for v5.9

The biggest set of fixes here is those from Michał Mirosław fixing some
locking issues with coupled regulators that are triggered in cases where
a coupled regulator is used by a device involved in fs_reclaim like eMMC
storage.  These are relatively serious for the affected systems, though
the circumstances where they trigger are very rare.

----------------------------------------------------------------
Axel Lin (1):
      regulator: cros-ec-regulator: Add NULL test for devm_kmemdup call

Colin Ian King (1):
      regulator: fix spelling mistake "Cant" -> "Can't"

Dmitry Osipenko (1):
      regulator: core: Fix slab-out-of-bounds in regulator_unlock_recursive()

Mark Brown (1):
      Merge tag 'v5.9-rc2' into regulator-5.9

Michał Mirosław (7):
      regulator: push allocation in regulator_init_coupling() outside of lock
      regulator: push allocation in regulator_ena_gpio_request() out of lock
      regulator: push allocations in create_regulator() outside of lock
      regulator: push allocation in set_consumer_device_supply() out of lock
      regulator: plug of_node leak in regulator_register()'s error path
      regulator: cleanup regulator_ena_gpio_free()
      regulator: remove superfluous lock in regulator_resolve_coupling()

Vincent Whitchurch (1):
      regulator: pwm: Fix machine constraints application

 drivers/regulator/core.c              | 179 ++++++++++++++++++----------------
 drivers/regulator/cros-ec-regulator.c |   3 +
 drivers/regulator/fixed.c             |   2 +-
 drivers/regulator/pwm-regulator.c     |   2 +-
 4 files changed, 101 insertions(+), 85 deletions(-)
