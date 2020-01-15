Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B91C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D12E2467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579059642;
	bh=jQkpwwjW+28FAcx5qKB4T60288Dppvd4H70Y9mp+7Hg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=C3F0VKeKTEWoa6mZpX51GSlc4+cF8kBgnX2prpbwGlZlmVF7hmC6JDGATLXaTIpGI
	 hVFhnTpMjAwZWj6OOa+lSX+P/xgSKx3OcZPS/RV0JoxT3t8ojoL8yxOAY8YlM9llXs
	 Kie6tUS7bdj69GzrtOxOLCECQI31eUpmXXn/yzGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAODkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgAODkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:40:41 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E99220684;
        Wed, 15 Jan 2020 03:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579059640;
        bh=jQkpwwjW+28FAcx5qKB4T60288Dppvd4H70Y9mp+7Hg=;
        h=From:To:Cc:Subject:Date:From;
        b=UBu79P/8GiSHu6VT5/FpwerbSA3tigMRZXKIYq5JAo+GunMN0KSXQOO5LmekDEmcY
         amxYsNX4qWAv1ROcGgtzR/IpEz1oyG+pSqssXFs81zzbshYVb27k/4/7abaJ1DrZnp
         IcQuD3T9zAzny5Nek22yUUqt33VWFbE9w1GQ+F8Q=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH -tip V3 0/2] kprobes: Fix RCU warning and cleanup
Date:   Wed, 15 Jan 2020 12:40:35 +0900
Message-Id: <157905963533.2268.4672153983131918123.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is v3 patches which fix suspicious RCU usage warnings
in kprobes. In this version I just updated the series on top
of the latest -tip and add Joel's reviewed-by tag.

Thank you,

---

Masami Hiramatsu (2):
      kprobes: Suppress the suspicious RCU warning on kprobes
      kprobes: Use non RCU traversal APIs on kprobe_tables if possible


 kernel/kprobes.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
