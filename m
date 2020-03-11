Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A82C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20AB8205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgCKICO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:02:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:57536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgCKICO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:02:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 912C2B019;
        Wed, 11 Mar 2020 08:02:13 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] drivers/base/cpu: s*nprintf() usage fixes / cleanups
Date:   Wed, 11 Mar 2020 09:02:05 +0100
Message-Id: <20200311080207.12046-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is a respin of my previous patch [*].
Now the scnprintf() conversion is done only in the needed places,
and the second patch cleans up the superfluous s*nprintf() usages.

Takashi

[*] https://lore.kernel.org/r/20200311071200.4024-1-tiwai@suse.de

===
Takashi Iwai (2):
  drivers/base/cpu: Use scnprintf() for avoiding potential buffer
    overflow
  drivers/base/cpu: Simplify s*nprintf() usages

 drivers/base/cpu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

-- 
2.16.4

