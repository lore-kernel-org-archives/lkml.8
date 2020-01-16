Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421BC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B23C2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218067;
	bh=p9B0uT2oHpZTVWWgC2Fc08MdyScnRBmnaT96Qf13I7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HdJz6ODF34wfPDPLxoXWSq6czU9QUk37Lcl6VGSTg68Jllms0GurMjcMILM9K6y7/
	 RLr3IaDtrFIkaTVCTbuh3/Gz56kyr941plYv9DZCc4ZqKILal2q8bQAghoRGOZrR3T
	 q8db1J9Qw1mRGYvMcRAJE7FSFR76vjoSgw/nHZYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390174AbgAPX13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:27:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730992AbgAPX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:27:14 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3544120684;
        Thu, 16 Jan 2020 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217233;
        bh=p9B0uT2oHpZTVWWgC2Fc08MdyScnRBmnaT96Qf13I7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SNftGDSOOH5oKt6mQxaZC563AsXI2ssYZzxY+c2Je9GoxuLXT+wcHVNFL/RS2aeYX
         DJvb8vMTS5q1I0Slm3G3m7kWTIukZv+WTxIJjAzAtyNzEs575Pygj9r5D5aRzXKxdN
         xLnR6lcYz8mMDWa1Fuj/CaKD3DVSHLqy0dNhXpX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 185/203] rseq/selftests: Turn off timeout setting
Date:   Fri, 17 Jan 2020 00:18:22 +0100
Message-Id: <20200116231800.506910692@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

[ Upstream commit af9cb29c5488381083b0b5ccdfb3cd931063384a ]

As the rseq selftests can run for a long period of time, disable the
timeout that the general selftests have.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Paul Turner <pjt@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rseq/settings | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/selftests/rseq/settings

diff --git a/tools/testing/selftests/rseq/settings b/tools/testing/selftests/rseq/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/rseq/settings
@@ -0,0 +1 @@
+timeout=0
-- 
2.20.1



