Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD6FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53597206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595761909;
	bh=EnfNSdYMUMK62A383HLp5OkhBkrnPkamPGpDWRWYDAc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bM3jDHgTd20b298g15IgMSTuzlLRuBMYaGXBo3G7o4ayiuMNaBWDOpY7silkXZpL1
	 pIQHGXRuAab+n+Apkx/YBfIC7PCUnAws9Sj47QLLfgSS4gmv+j0Z2osdD5Hti9MSF7
	 YwZcYv08YgbJnXl3ktaPX+RhZAsEXWSLCJWAuTBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgGZLLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:11:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgGZLLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:11:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C352065C;
        Sun, 26 Jul 2020 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595761905;
        bh=EnfNSdYMUMK62A383HLp5OkhBkrnPkamPGpDWRWYDAc=;
        h=Date:From:To:Cc:Subject:From;
        b=IfWVZG/CXgF8nKLgpKC8iuq/3UUtuLOBkTONfoCmkhXpN+Ee7TGWdIGqbMYqEpRA1
         ZItbcwSuy3J5mNBM1eaA/dw+ANjZRun7r4e2kdQQIxr26lmEu7JBVL2NkNf6S5rywB
         QK0lc5Ubw81RjGaPg6kSTfHXyvEUxhuloBLYQKaI=
Date:   Sun, 26 Jul 2020 13:11:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.8-rc7
Message-ID: <20200726111143.GA1283454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ba47d845d715a010f7b51f6f89bae32845e6acb7:

  Linux 5.8-rc6 (2020-07-19 15:41:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.8-rc7

for you to fetch changes up to 0b987032f8b58ef51cc8a042f46cc0cf1f277172:

  usb: tegra: Fix allocation for the FPCI context (2020-07-23 13:21:01 +0200)

----------------------------------------------------------------
USB fixes for 5.8-rc7

Here are 3 small USB XHCI driver fixes for 5.8-rc7.

They all resolve some minor issues that have been reported on some
different platforms.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chunfeng Yun (1):
      usb: xhci-mtk: fix the failure of bandwidth allocation

Forest Crossman (1):
      usb: xhci: Fix ASM2142/ASM3142 DMA addressing

Jon Hunter (1):
      usb: tegra: Fix allocation for the FPCI context

 drivers/usb/host/xhci-mtk-sch.c | 4 ++++
 drivers/usb/host/xhci-pci.c     | 3 +++
 drivers/usb/host/xhci-tegra.c   | 2 +-
 3 files changed, 8 insertions(+), 1 deletion(-)
