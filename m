Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F2DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1C42070E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGPHPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:15:18 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:14494 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgGPHPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:15:18 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v8 0/2] debugfs: Add access restriction option
Date:   Thu, 16 Jul 2020 09:15:09 +0200
Message-ID: <20200716071511.26864-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617133738.6631-1-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=CszBjUwD c=1 sm=1 tr=0 a=Jtaq2Av1iV2Yg7i8w6AGMw==:117 a=_RQrkK6FrEwA:10 a=QyXUC8HyAAAA:8 a=rwTvC7ucDngX97v92ZIA:9
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since debugfs include sensitive information it need to be treated
carefully. But it also has many very useful debug functions for userspace.
With this option we can have same configuration for system with
need of debugfs and a way to turn it off. This gives a extra protection
for exposure on systems where user-space services with system
access are attacked.

v2. Removed MOUNT as part of restrictions. Added API's restrictions as
    separate restriction.
v3  Updated Documentation after Randy Dunlap reviews and suggestions.
v4  Removed #ifdefs from inode.c and using internal.h for configuration
    and now using BIT() for that. Function is now always on, and are
    instead selected by a built in default or command line parameter.
    Changed return value on debug_mount
    Reported-by: kernel test robot <lkp@intel.com>
    Im not sure about that it is right
v5  Added notes to config help suggested by GregKH.
    Removed _BIT from names, white-space and tab.
    (checkpatch did not complain).
v6  Using ALLOW instead of ACCESS as name on BIT's. Change the fs to
    mount to make it clear and easy to understand.
v7  Updated Kconfig.debug with Randy Dunlap corrections.
v8  Spell fixes from Randy and using else-if for command argument
    parser.
    

