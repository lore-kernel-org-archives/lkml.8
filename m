Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F870C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B54120732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731150AbgDMPyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:54:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:36716 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbgDMPyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:54:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C375AC84;
        Mon, 13 Apr 2020 15:54:15 +0000 (UTC)
Date:   Mon, 13 Apr 2020 17:54:14 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v5.7
Message-ID: <20200413175414.3eebd408@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates/fixes for Linux v5.7 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus

 drivers/firmware/dmi-id.c       |  6 ++++++
 drivers/firmware/dmi_scan.c     | 30 ++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |  2 ++
 scripts/mod/file2alias.c        |  2 ++
 4 files changed, 40 insertions(+)

---------------

Erwan Velu (1):
      firmware/dmi: Report DMI Bios & EC firmware release

PS: I apologize for missing the merge window this time. Thankfully this
is only one commit so hopefully you can still accept it.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
