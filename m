Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD1AC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE5B720731
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YongsVUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgEHE4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgEHE4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:56:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66259C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 21:56:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f6so327001pgm.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 21:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4CNZy247ICcFx3HCeAu3lFAco0E9gMG+0QdnsbzPiRo=;
        b=YongsVUNpHD9pyODgLUWb/61UgHn39x8OVioXsqsF8t1wwG89KBDqSL6gSxorgd9k/
         g5T8jWEiH3DSGv7acmuQXIGGzN7sTXF3NStQ2YTee6G0PEbK67HSSVAtPAHU9XybTN1M
         aQ49zkZht+DgamSC1QAGbZEfnNrfzBGWhEB/FJGNrkzwzZtGdLWQFuz02wCT9TT6IvwC
         JdFrTlS8NmCdS1cvcoyFmjapEa4vx4HKpdpKrw8Z0ql2EQG1ZMEzABuFIgLN6U99b9Ta
         gUYdOvR0cOs+31NukcL5XHWI8vGgztzelE+KIPZ0szEB++UYVvFk1gbHMIiKxJMQQh+u
         GA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4CNZy247ICcFx3HCeAu3lFAco0E9gMG+0QdnsbzPiRo=;
        b=D8/+8zMZs9kia+YpCXsCNGzPiI5AH5HaGRrhn+0W/cTjYaVAFw0l7nXGTKXQNSnsUM
         V4d0AKlYd6X4OshhFNb+SxfR1mOp8RlcwO4YkhAIf0QSDRTc6uhzaoFkzz2lnBamKHpz
         X0A6QHXqOzgJJ472qg+JzVz0Onmcn3SJwIZ7VJ8blY2n8rptmNi2JB/2Gf/nckUVT0RL
         42ll2Ptt0wfUqxJVtVXPlNRkY5QLuo7Xim51h/6NUJPtlObzxxyFt+QbrwKYGTDR+Ib2
         I4839FXWObJaGh6h7sy1j+3bBMI4dr8WBWFVORftaebPLcEQYxsQuDCHRSxMpFeprozU
         Hi+A==
X-Gm-Message-State: AGi0PuYGIAVogzArwA2pL7i4lCdTGp0RYBEiXjhhcl2dUhh1aK5rqBXX
        /yhT69RFm5qkUGmdf25tbWXFjKCsxR4=
X-Google-Smtp-Source: APiQypKH7PmGUi/XHWEExL2pZ4ExfPw8tZVjceK5ZGdxg/94ViJwHsuu88DxdsCvzqKaPIiI68ArGA==
X-Received: by 2002:a63:5824:: with SMTP id m36mr588890pgb.439.1588913775577;
        Thu, 07 May 2020 21:56:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id d124sm426812pfa.98.2020.05.07.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 21:56:14 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH] kselftests: dmabuf-heaps: Fix confused return value on expected error testing
Date:   Fri,  8 May 2020 04:56:10 +0000
Message-Id: <20200508045610.80522-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.17.1

