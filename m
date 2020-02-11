Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF42C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2C6208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbgBKORY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:17:24 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:46118 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgBKORY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:17:24 -0500
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Feb 2020 09:17:24 EST
To:     LKML <linux-kernel@vger.kernel.org>
From:   Meelis Roos <mroos@linux.ee>
Subject: 56.rc1+git: kalllsyms aborting
Message-ID: <da71451e-6518-c013-570a-ee8b01633d67@linux.ee>
Date:   Tue, 11 Feb 2020 16:10:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is todays git v5.6-rc1-5-g0a679e13ea30 on 32-bit x86 (Debian unstable), seen on 2 machines, running on 5.5.0 kernel.

   KSYM    .tmp_kallsyms1.o
kallsyms: malloc.c:2393: sysmalloc: Assertion `(old_top == initial_top (av) && old_size == 0) || ((unsigned long) (old_size) >= MINSIZE && prev_inuse (old_top) && ((unsigned long) old_end & (pagesize - 1)) == 0)' failed.
Aborted
make: *** [Makefile:1077: vmlinux] Error 134

-- 
Meelis Roos <mroos@linux.ee>
