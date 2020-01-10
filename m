Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A95C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37EEF20838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578691952;
	bh=x7ehtRUt6vDp/rZ2bCs9Z7prWxJZUh/0btn3hnEns9E=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=MJdFQ8HpEX9+Wv3CnRCVgl1KJ2G3jU0VLJ+9yYUdcfFHNBNqxE1SGmsXMUFr6uMR8
	 /nvmINF8KblakdzqfUeBzGDu4OtIGRYEckthj3tnxBzmevj7Vwc2YZ7t4Omtp1wYng
	 LQRCU8y4E2OSF0NPm8Rm9wt1ARfzpY7s1OuAjS7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgAJVcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:45842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726836AbgAJVcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:32:31 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 869B92082E;
        Fri, 10 Jan 2020 21:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578691950;
        bh=x7ehtRUt6vDp/rZ2bCs9Z7prWxJZUh/0btn3hnEns9E=;
        h=Date:From:To:cc:Subject:From;
        b=Et77zTJIe9B9c+l0Rj7M4nW5BGpg9rUVDxbE4WXo1OsMfFUK3dspFpJg1jBelK9Ab
         +q4UoOY0srwci7pE39sb6OlEvt11K8gtDx54p3bIspgZSZ4MhReTfUxWbRnksC2xOF
         B55ggwbL8b0i7utBokeLKmF8H+9pxVUaawbHOkBs=
Date:   Fri, 10 Jan 2020 22:32:27 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fix
Message-ID: <nycvar.YFH.7.76.2001102231160.31058@cbobk.fhfr.pm>
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

to receive regression fix for EPOLLOUT handling in hidraw and uhid.

Thanks.

----------------------------------------------------------------
Jiri Kosina (1):
      HID: hidraw, uhid: Always report EPOLLOUT

 drivers/hid/hidraw.c | 7 ++++---
 drivers/hid/uhid.c   | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

-- 
Jiri Kosina
SUSE Labs

