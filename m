Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F764C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED42C20872
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658525;
	bh=oqZ+NsD3VxSpXbZh521LmVgD1/qZripK/UNHLLtpTDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SGuA2R+3QEZNzDtASxTRINwIhPbNPlcpX787iNKLyOiu8FKXOGcBJ4ue0OCMZyu+5
	 CijC9qtkfFAEnCYNfBIyE/ZrLwGne118geUvcFITUwLz9UQdnQR9ilHOClozB46SnX
	 ubPn9S+UDXbd2P9bAjSDwviZtZvDLuhDbCcz15gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgFHXWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:22:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730476AbgFHXRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A130214F1;
        Mon,  8 Jun 2020 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658253;
        bh=oqZ+NsD3VxSpXbZh521LmVgD1/qZripK/UNHLLtpTDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SS1DYvK7I5MAgJ/mX3WuRQERJ3AjhAvSGoTFrvw0zxudmzJZ27T6mGlXppD03Ntt/
         ukX6KrL3n4NtOlDk5nrcQVGlfL8fwkqcNf6yCWEZlqno5rnpwe+IgJHHBioPAJRgtb
         LmiQ0aXDktdQ7IyTgzui/GY7CeAR7iqWngQQhSzA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 262/606] kselftests: dmabuf-heaps: Fix confused return value on expected error testing
Date:   Mon,  8 Jun 2020 19:06:27 -0400
Message-Id: <20200608231211.3363633-262-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

