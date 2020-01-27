Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423CAC33CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CA3207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgA0Klr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:41:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48332 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgA0Klr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:41:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6B7CDAFDF;
        Mon, 27 Jan 2020 10:41:45 +0000 (UTC)
Date:   Mon, 27 Jan 2020 11:41:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 5.6
Message-ID: <20200127104139.GB24228@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull our totally boring branch this time around.

Thx.

---

The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:

  Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.6

for you to fetch changes up to 7e5d6cf35329c8b232a1e97114545c1745d79083:

  EDAC/amd64: Do not warn when removing instances (2020-01-17 13:00:06 +0100)

----------------------------------------------------------------
A garden variety of small fixes all over the place.

----------------------------------------------------------------
Aristeu Rozanski (1):
      EDAC: skx_common: downgrade message importance on missing PCI device

Borislav Petkov (1):
      EDAC/amd64: Do not warn when removing instances

Krzysztof Kozlowski (1):
      EDAC/Kconfig: Fix Kconfig indentation

Wei Yongjun (1):
      EDAC/sifive: Fix return value check in ecc_register()

Xu Wang (1):
      EDAC/aspeed: Remove unneeded semicolon

yu kuai (1):
      EDAC: remove set but not used variable 'ecc_loc'

 drivers/edac/Kconfig       | 3 +--
 drivers/edac/amd64_edac.c  | 3 ---
 drivers/edac/aspeed_edac.c | 4 ++--
 drivers/edac/i5100_edac.c  | 7 -------
 drivers/edac/sifive_edac.c | 4 ++--
 drivers/edac/skx_common.c  | 2 +-
 6 files changed, 6 insertions(+), 17 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
