Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052FBC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3E420828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 20:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgCIU12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 16:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbgCIU12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 16:27:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC4C120828;
        Mon,  9 Mar 2020 20:27:27 +0000 (UTC)
Date:   Mon, 9 Mar 2020 16:27:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John 'Warthog9' Hawley <warthog9@kernel.org>
Subject: [GIT PULL] ktest: Updates and fixes for 5.6
Message-ID: <20200309162726.71fe6060@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Ktest fixes and clean ups

- Make the default option oldconfig instead of randconfig
  (one too many times I lost my config because I left the build type out)

- Add timeout to ssh sync to sync before reboot (prevents test hangs)

- A couple of spelling fix patches

[ I had a couple of patches I forgot to push before, as this tree
  isn't updated much. But this shouldn't affect the stability of
  the kernel any. ]

Please pull the latest ktest-v5.6 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-ktest.git
ktest-v5.6

Tag SHA1: 72ff3685b8f4346bbb71515e9c4655524523c7d1
Head SHA1: 1091c8fce8aa9c5abe1a73acab4bcaf58a729005


Masanari Iida (2):
      ktest: Fix some typos in sample.conf
      ktest: Fix typos in ktest.pl

Steven Rostedt (VMware) (2):
      ktest: Make default build option oldconfig not randconfig
      ktest: Add timeout for ssh sync testing

----
 tools/testing/ktest/ktest.pl    | 16 ++++++++--------
 tools/testing/ktest/sample.conf | 22 +++++++++++-----------
 2 files changed, 19 insertions(+), 19 deletions(-)
