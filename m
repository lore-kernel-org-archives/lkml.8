Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F5FC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E4482082F
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 23:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGAXR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 19:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:59620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgGAXR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 19:17:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A491E2082F;
        Wed,  1 Jul 2020 23:17:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jqlzH-0048xR-KG; Wed, 01 Jul 2020 19:17:55 -0400
Message-ID: <20200701231717.757834010@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 01 Jul 2020 19:17:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     "John Warthog9 Hawley" <warthog9@kernel.org>
Subject: [for-next][PATCH 0/8] ktest.pl: Various updates and including more content in email on failures
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Steven Rostedt (VMware) (8):
      ktest.pl: Have config-bisect save each config used in the bisect
      ktest.pl: Always show log file location if defined even on success
      ktest.pl: Define PRE_TEST_DIE to kill the test if the PRE_TEST fails
      ktest.pl: Add a NOT operator
      ktest.pl: Just open up the log file once
      ktest.pl: Turn off buffering to the log file
      ktest.pl: Add the log of last test in email on failure
      ktest.pl: Add MAIL_MAX_SIZE to limit the amount of log emailed

----
 tools/testing/ktest/ktest.pl    | 100 ++++++++++++++++++++++++++++++++++------
 tools/testing/ktest/sample.conf |  18 ++++++++
 2 files changed, 103 insertions(+), 15 deletions(-)
