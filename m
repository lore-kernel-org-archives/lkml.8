Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C77208C7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599073100;
	bh=jZpDF9NPKu9cn/SUdzlY3qKfPGe/l8VUeZcIKi8NeZs=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=gHvi5JFUxip3gU47UHF5YImOQHtHfpuhPWkNawC980kqsacNnduLHqSAXYSBTSmZl
	 FWzhwL0dFcpP+YYStGWq9ZamrUs9of8DBXmDc0LlZcjDKQ8e2yJuwfxTm8WwTwQmcL
	 dq86oDogyxzHMrZZSgxhmPp18wSzaoaE57RCPpcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIBS6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBS6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:58:17 -0400
Received: from pobox.suse.cz (nat1.prg.suse.com [195.250.132.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2986208C7;
        Wed,  2 Sep 2020 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599073096;
        bh=jZpDF9NPKu9cn/SUdzlY3qKfPGe/l8VUeZcIKi8NeZs=;
        h=Date:From:To:cc:Subject:From;
        b=bP+p3D9AhDjjeUFMCkbX7XbTTWP6Ldq6jsdijeCra+sh1NwzyMfITP9D134cyFDbN
         f81OCPP7KtWjMB1gS7u3a1PLAX0nm1KYIrwhU8V7FG747e5uQnRDUL+OVr7ywegw8+
         +1BWM5rpnSmN1wz7fEfpTzK6imkkFT/kImVV3lAg=
Date:   Wed, 2 Sep 2020 20:58:13 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2009022051130.4671@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID subsystem fixes. Most importantly:

=====
- Data sanitization and validtion fixes for report descriptor parser from 
  Marc Zyngier
- memory leak fix for hid-elan driver from Dinghao Liu
- two device-specific quirks
=====

Thanks.

----------------------------------------------------------------
Dinghao Liu (1):
      HID: elan: Fix memleak in elan_input_configured

Marc Zyngier (2):
      HID: core: Correctly handle ReportSize being zero
      HID: core: Sanitize event code and type when mapping input

Nicholas Miell (1):
      HID: microsoft: Add rumble support for the 8bitdo SN30 Pro+ controller

Nirenjan Krishnan (1):
      HID: quirks: Set INCREMENT_USAGE_ON_DUPLICATE for all Saitek X52 devices

 drivers/hid/hid-core.c       | 15 +++++++++++++--
 drivers/hid/hid-elan.c       |  2 ++
 drivers/hid/hid-ids.h        |  3 +++
 drivers/hid/hid-input.c      |  4 ++++
 drivers/hid/hid-microsoft.c  |  2 ++
 drivers/hid/hid-multitouch.c |  2 ++
 drivers/hid/hid-quirks.c     |  2 ++
 include/linux/hid.h          | 42 +++++++++++++++++++++++++++++-------------
 8 files changed, 57 insertions(+), 15 deletions(-)

-- 
Jiri Kosina
SUSE Labs

