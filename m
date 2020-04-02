Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDBEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C26206F5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbgDBNlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:41:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388789AbgDBNli (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:41:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE25B30E;
        Thu,  2 Apr 2020 06:41:37 -0700 (PDT)
Received: from e121896.arm.com (unknown [10.57.29.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BDB133F52E;
        Thu,  2 Apr 2020 06:41:36 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     arnaldo.melo@gmail.com, shikemeng@huawei.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Clark <james.clark@arm.com>
Subject: [PATCH 0/1] perf tools: fix compilation on Arm
Date:   Thu,  2 Apr 2020 14:41:27 +0100
Message-Id: <20200402134128.14493-1-james.clark@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200330131810.GC31702@kernel.org>
References: <20200330131810.GC31702@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

This patch seems to break the build for me on your
perf/core branch but adding the header fixes it.


Thanks
James

James Clark (1):
  perf tools: fix compilation on Arm

 tools/perf/arch/arm64/util/machine.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.17.1

