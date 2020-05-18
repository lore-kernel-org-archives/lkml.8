Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 902CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77223207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgERIqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:46:13 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59587 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgERIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:45:59 -0400
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 889556000B;
        Mon, 18 May 2020 08:45:56 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v2 0/3] TTY improve n_gsm support
Date:   Mon, 18 May 2020 10:45:14 +0200
Message-Id: <20200518084517.2173242-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518084517.2173242-1-gregory.clement@bootlin.com>
References: <20200518084517.2173242-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is the second version of patch improving n_gms support
especially with TELIT LE910. However the fix should benefit to any
modem supporting cmux.

The first patch is just about improving debugging output.

The second one removes a tty optimization which make the LE910 hang.

The last one fixes an issue observed on the LE910 but should benefit
to all the modem. We observed that pretty quickly the transfer done
using the virtual tty were blocked. We found that it was due of a
wakeup to the real tty. Without this fix, the real tty wait for
indefinitely.

Thanks to Jiri Slaby for the review.

Changelog:
 v1 -> v2:
 - don't replace the pr_info by pr_debug
 - remove the superfluous printk("\n");
 - use --follow option with git log to find the original commit to fix
 - use tty_port_tty_wakeup
 - use 'for' loop instead of 'while'

Gregory

Gregory CLEMENT (3):
  tty: n_gsm: Improve debug output
  tty: n_gsm: Fix SOF skipping
  tty: n_gsm: Fix waking up upper tty layer when room available

 drivers/tty/n_gsm.c | 48 +++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

-- 
2.26.2

