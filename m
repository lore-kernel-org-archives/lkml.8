Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EFA7206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036814;
	bh=oqZ+NsD3VxSpXbZh521LmVgD1/qZripK/UNHLLtpTDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f/Y2t22DRp3pi4fZQHPkGeY9h0yT/xHzenwef+qChhG9+Y/3bYcSLJWXyze2lS4z6
	 oDrWXjpa5fLCoMZ84gqaFBcdutr0HZzaCdxd45TvUqLOdt911c0e9kO5u3eo1Oi8cm
	 pRf3gSkbXzjlozlDgVQxRh2Ymnt19AVZTBAM5nZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgFASNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:32910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729979AbgFASNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:13:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D223F2065C;
        Mon,  1 Jun 2020 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035204;
        bh=oqZ+NsD3VxSpXbZh521LmVgD1/qZripK/UNHLLtpTDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LArHRnFLTKcGwWn2k/QhrvnBkIYL5W24MY6bHz+t80ucuglBYYvA0z4ws++9Z85tA
         HpyhsnoJIuxfzZ0doQKduc7jcgpGO2ZDmI3jDbcimImKT0+WE0uSJsI0TBwmtPy2mA
         pfbyDrvziyRUipz7G/5dw6ZEBzwaJDr4sL4NT+xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-kselftest@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 056/177] kselftests: dmabuf-heaps: Fix confused return value on expected error testing
Date:   Mon,  1 Jun 2020 19:53:14 +0200
Message-Id: <20200601174053.677670993@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Stultz <john.stultz@linaro.org>

[ Upstream commit 4bb9d46d47b105a774f9dca642f5271375bca4b2 ]

When I added the expected error testing, I forgot I need to set
the return to zero when we successfully see an error.

Without this change we only end up testing a single heap
before the test quits.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: "Andrew F. Davis" <afd@ti.com>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index cd5e1f602ac9..909da9cdda97 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -351,6 +351,7 @@ static int test_alloc_errors(char *heap_name)
 	}
 
 	printf("Expected error checking passed\n");
+	ret = 0;
 out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
-- 
2.25.1



