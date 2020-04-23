Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30523C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0054220784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587675270;
	bh=Z2kbebwq8Q0QlBboMLPWtnkVj9pDsV4a9O/CCn91B7M=;
	h=From:To:Subject:Date:List-ID:From;
	b=ex5SNZ1g+sZ/Wu3OrMPh1BMl7sj82dPjvEExipeNtK+He2TRxjhrBgJA9vSKAUJgD
	 3RXrS2vHiR/dREfzZu6l+RiJrOUrTtwq/pziOIOpGS4QM9nruA4mFYv0YTBsJP6kt7
	 wk966RX9hJdwnA1jvN/8Na4L9LqnB8a4VD/rRHnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgDWUy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:47544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbgDWUy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:54:28 -0400
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B0F2073A;
        Thu, 23 Apr 2020 20:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587675268;
        bh=Z2kbebwq8Q0QlBboMLPWtnkVj9pDsV4a9O/CCn91B7M=;
        h=From:To:Subject:Date:From;
        b=mXfSuoHrfrz1NeFYSE6i39ry/uDNoLTbiiYfz81+dWa4svz1yOa551SJ+fIJlq1Sm
         2uUHT3zEQ6n1yd4x2R/Q14PA5PAzgj5vIo7/8r/yM4tgD45vWUQtUNFbt9Bw8s8OkZ
         Na2RW07AWH60lvbbKkEfcnFT15kROMAd+DGPzOIc=
From:   zanussi@kernel.org
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH RT 0/2] Linux v4.19.115-rt49-rc1
Date:   Thu, 23 Apr 2020 15:54:24 -0500
Message-Id: <cover.1587675252.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Dear RT Folks,

This is the RT stable review cycle of patch 4.19.115-rt49-rc1.

Please scream at me if I messed something up. Please test the patches
too.

The -rc release will be uploaded to kernel.org and will be deleted
when the final release is out. This is just a review release (or
release candidate).

The pre-releases will not be pushed to the git repository, only the
final release is.

If all goes well, this patch will be converted to the next main
release on 2020-04-27.

To build 4.19.115-rt49-rc1 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.115.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.115-rt49-rc1.patch.xz

You can also build from 4.19.115-rt48 by applying the incremental patch:

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/incr/patch-4.19.115-rt48-rt49-rc1.patch.xz


Enjoy,

-- Tom


Tom Zanussi (1):
  Linux 4.19.115-rt49-rc1

Zhang Xiao (1):
  tasklet: Address a race resulting in double-enqueue

 include/linux/interrupt.h | 5 ++++-
 kernel/softirq.c          | 6 +++++-
 localversion-rt           | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.17.1

