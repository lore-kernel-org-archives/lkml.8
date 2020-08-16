Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB58C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87593207FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq6LFZ5z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgHPMzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgHPMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:55:42 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDFC061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 05:55:42 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a79so6819880pfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=sDGQ93NiwHzJrn/lqtCtEGPMp8B6V2SOTm6YrBIt+Fk=;
        b=iq6LFZ5zdRg801OrUH+ohFD7GMbKf8QxMyUAa/Z5qBeEDwA4mYGRm/k5nBNsU81x5w
         Uo4sRYwDcuYypd4Y72VXey7AB9+JqPAPBwR01jwG6FH6XzVM0149Kn1CsA1BYqoQv5XL
         QMpenmQ1nvnfcfCHKDvNZVkRkzmdFkgJO/9IhD7d9GHNt2x7Ts6uI9u+4+cjVpv7DJzk
         HHNkFc6wZevEWHXFGqHOVxNG1QBmUGGgBa9JvpAQuPDte2qvX0eIOin8CEI43+p/1+Wh
         0oTgN5gxw6T8Chd9YyO04KOJQjiP2Ta88pgAQAX7Ixynyzt9b7B7qL/eySLqTQvpwNQB
         bp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=sDGQ93NiwHzJrn/lqtCtEGPMp8B6V2SOTm6YrBIt+Fk=;
        b=RJKxza1i1EpwYBdAJHvLTzfUQx9/ilzQmWe8zfOdutUjNqNrdx5UOHOoi9mP0/StHO
         Ytg368ny239Gjv+3jW0w2YIt99rYRm0eKKcjPYjX8HfltnN8lr+1K7wAa0WtyUOOzb10
         rCoxzMz+/7akTjYiIKwLFy0vXx7pL9B4ypDqVU9CpHeXBTfEbY+7ioemCG7+P7izhf23
         0QbKkbuctPYRMk7VmS/kMSb4QNIwMjeZ4nM9hgOaD37BWKYogTpWp6DX7hfZ7ExkV2Pg
         qx33LAwT4T7cLZqd/WPtTjdwPqAgBf08M5rf/gkQUUhTg5DtDB33DQ7Y0kx6UrSSSGQS
         8KtQ==
X-Gm-Message-State: AOAM5336GpKmxLd9jEfOPJgqLb1gV+JE7eiEmEkwDbOfGzCLZInT/vN9
        O2hUsfoZI5YYkrrQByytElcunNKIIjQ4sL4a/V8=
X-Google-Smtp-Source: ABdhPJyHWxEQqk0SM+ZAQ9yDbci+X9h57REknSaD+6Pu/gz5M2C7NAdwMRRw04vbPh0hDK63L6oQKg==
X-Received: by 2002:a63:1a51:: with SMTP id a17mr6871619pgm.309.1597582541512;
        Sun, 16 Aug 2020 05:55:41 -0700 (PDT)
Received: from [192.168.43.159] ([49.35.121.224])
        by smtp.gmail.com with ESMTPSA id t4sm8961517pgu.60.2020.08.16.05.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Aug 2020 05:55:41 -0700 (PDT)
To:     apw@canonical.com, joe@perches.com, linux-kernel@vger.kernel.org
From:   Piyush Thange <pthange19@gmail.com>
Subject: checkpatch.pl- Cleared some white spaces which generated warnings and
 errors.
Message-ID: <d9f3bbf1-0912-1955-ae1f-a499d5b0b11b@gmail.com>
Date:   Sun, 16 Aug 2020 18:25:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


commit eb027935d819a3160404f05633ae47f8b8a061c8
Author:     Piyush Thange <pthange19@gmail.com>
AuthorDate: Sun Aug 16 17:52:26 2020 +0530
Commit:     Piyush Thange <pthange19@gmail.com>
CommitDate: Sun Aug 16 17:52:26 2020 +0530

     scripts:checkpatch.pl:Cleared the white spaces and errors occured 
due to them.

     I've removed the white spaced on the line 498, which generated 
warning and
     errors presented by checkpatch.pl.
     Please provide review.

     Signed-off-by: Piyush Thange <pthange19@gmail.com>

Signed-off-by: Piyush Thange <pthange19@gmail.com>
---
  scripts/checkpatch.pl | 12 +-----------
  1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2cbeae6d9aee..fa991a912d9b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -488,17 +488,7 @@ our $allocFunctions = qr{(?x:
      dma_alloc_coherent
  )};

-our $signature_tags = qr{(?xi:
-    Signed-off-by:|
-    Co-developed-by:|
-    Acked-by:|
-    Tested-by:|
-    Reviewed-by:|
-    Reported-by:|
-    Suggested-by:|
-    To:|
-    Cc:
-)};
+our $signature_tags = 
qr{(?xi:Signed-off-by:|Co-developed-by:|Acked-by:|Tested-by:|Reviewed-by:|Reported-by:|Suggested-by:|To:|Cc:)};

  our @typeListMisordered = (
      qr{char\s+(?:un)?signed},
-- 
2.25.1

