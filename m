Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668D8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F3B3206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgFVIan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:30:43 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15462 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgFVIam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:30:42 -0400
From:   Peter Enderborg <peter.enderborg@sony.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v4 0/2] debugfs: Add access restriction option
Date:   Mon, 22 Jun 2020 10:30:17 +0200
Message-ID: <20200622083019.15479-1-peter.enderborg@sony.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200617133738.6631-1-peter.enderborg@sony.com>
References: <20200617133738.6631-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
X-SEG-SpamProfiler-Analysis: v=2.3 cv=B7jHL9lM c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=nTHF0DUjJn0A:10 a=QyXUC8HyAAAA:8 a=KbOOyE1mfVfSFiGyvBAA:9
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
    Added preparation patch that removes check debugfs is initialised.
    Reported-by: kernel test robot <lkp@intel.com>

