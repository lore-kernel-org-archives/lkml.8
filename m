Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9556CC33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EFC2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgATIzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:55:49 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51201 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgATIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:55:44 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqH-0002Vo-QB; Mon, 20 Jan 2020 09:55:29 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itSqE-0006rw-Kz; Mon, 20 Jan 2020 09:55:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 0/2] printf: add support for %de
Date:   Mon, 20 Jan 2020 09:55:06 +0100
Message-Id: <20200120085508.25522-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this is an reiteration of my patch from some time ago that introduced
%dE with the same semantic. Back then this resulted in the support for
%pe which was less contentious.

I still consider %de (now with a small 'e' to match %pe) useful.

One concern back then was that drivers/staging/speakup/speakup_bns.c
uses sprintf with the format string "\x05%dE" to produce binary data
expecting a literal 'E'. This is now addressed: ` can be used to end
parsing a format specifier as explained in the commit log of the first
patch.

Of course the concern to not complicate vsprintf() cannot be addressed
as new code is necessary to support this new ability. I still consider
%de useful enough, even though you could do

	pr_info("blablub: %pe\n", ERR_PTR(ret));

with the same effect as

	pr_info("blablub: %de\n", ret);

.

The second patch converts some strings in the driver core to use this
new format specifier.

Uwe Kleine-König (2):
  printf: add support for printing symbolic error names from numbers
  driver core: convert probe error messages to use %de

 drivers/base/dd.c | 10 +++++-----
 lib/test_printf.c |  8 ++++++++
 lib/vsprintf.c    | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.24.0

