Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2F4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3ECC207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgERIp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:45:56 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49957 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgERIpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:55 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 41C51C000C;
        Mon, 18 May 2020 08:45:53 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 0/2] TTY fix-ups for "TTY improve n_gsm support" series
Date:   Mon, 18 May 2020 10:45:11 +0200
Message-Id: <20200518084517.2173242-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jiri found issues or things to improve in the v2 of the series "TTY
improve n_gsm support". However it was already applied. So this series
implements the needed changes.

For the second patch, as the commit "tty: n_gsm: Fix waking up upper
tty layer when room available" was not yet in mainline, it has no
SHA-1 ID yet. That's why I reference the same commit that the one
fixed by "TTY improve n_gsm support", as they should be applied in the
same order in stable branch than in mainline.

Gregory


Gregory CLEMENT (2):
  tty: n_gsm: Remove unnecessary test in gsm_print_packet()
  tty: n_gsm: Fix bogus i++ in gsm_data_kick

 drivers/tty/n_gsm.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

-- 
2.26.2

