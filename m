Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0069BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A9C206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nCH6zHj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgHKAsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHKAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:48:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C4C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:48:22 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so6664561pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=52A4xc+/jrmiozXKI+LLTyESLZ7QKwO1hVqCs6brWXc=;
        b=nCH6zHj4AOKIWgZb4Ahvrwv8CD8AaduZoy5T66g7tY5prKUIgU98KPz6SItfK3J67p
         Iq9PSjA8dMIDiZs2KGE2CUChb5bJjd13bnm363gXbJi/9O6Bxt4Hw63W9mpheCdz93/I
         TdGNxE4MKc5nwXlVpDENDiyuBv+xsi2srJgzqh5/1WXDCo41w1RBj1TT2ORdzEWUqrhY
         ed9Da81FAhmeY3FRJPKghFlsGJr4vjY27+Mm1QEFK7Tmdk1xgFb3aME/cziDItiGir+c
         cOfL2CIjcIvPSRN5mjtyS5Ih4ct4UXNNQRXBn0oMlkvnbWgyspgnYemFJiYFbfxbvp1l
         riGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=52A4xc+/jrmiozXKI+LLTyESLZ7QKwO1hVqCs6brWXc=;
        b=FJ/4uLzhnD8NgnBwbF6hdA5dwa2a8qPF2YcAC+IMkl8ZyvwmBNhsw7E7hhNlhax5jS
         +8ole5I+FyeTsrNmSwEkf4KoF314Qd/vla+cIXvIjtdjlfx2Eiqnp+FitsN/Wnoz/g2o
         lCvm2ZS9+p8okZzErdWWE40dIwkZNvOCAClPqwE+TvvU7uIU2vEJhnwXPZOPcbcXRhlk
         tYA2sZovyOlbTbT8J427wnUKIz9j+eF0wLHaXxOMO3lDN/hzRGtKx9X3To32sWXNQR4h
         PrACb6O3pjUZLZMHkJAh3z3OlT4HjQv7lTZzu8b+W4zVF6VGBRxJ83q2aKv+ddcw4CdK
         5sHg==
X-Gm-Message-State: AOAM533PWcd9KKUbna88MwfN9t18PkqeGXsnTzkyb2RNrRRws8RzcoqK
        P+3+Ra7hfPtUULtzjjQGgNk2oPJV4Ow=
X-Google-Smtp-Source: ABdhPJyKg7M1xo0mE5OyggHZYj7FNw5Tnfh7CUnhnpzXIT5tIPdbzw8czS+ti2esIItqfhgkfJVtwg==
X-Received: by 2002:aa7:9390:: with SMTP id t16mr3552357pfe.311.1597106901827;
        Mon, 10 Aug 2020 17:48:21 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x18sm22935914pfc.93.2020.08.10.17.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 17:48:20 -0700 (PDT)
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] fs: RWF_NOWAIT should imply IOCB_NOIO
Message-ID: <e8325bef-7e91-5fd4-fa25-74cfa169ffd2@kernel.dk>
Date:   Mon, 10 Aug 2020 18:48:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the change allowing read-ahead for IOCB_NOWAIT, we changed the
RWF_NOWAIT semantics of only doing cached reads. Since we know have
IOCB_NOIO to manage that specific side of it, just make RWF_NOWAIT
imply IOCB_NOIO as well to restore the previous behavior.

Fixes: 2e85abf053b9 ("mm: allow read-ahead with IOCB_NOWAIT set")
Reported-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This was a known change with the buffered async read change, but we
didn't have IOCB_NOIO until late in 5.8. Now that bases are synced,
make the change to make RWF_NOWAIT behave like past kernels.

diff --git a/include/linux/fs.h b/include/linux/fs.h
index bd7ec3eaeed0..f1cca4bfdd7b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3293,7 +3293,7 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
 	if (flags & RWF_NOWAIT) {
 		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
-		kiocb_flags |= IOCB_NOWAIT;
+		kiocb_flags |= IOCB_NOWAIT | IOCB_NOIO;
 	}
 	if (flags & RWF_HIPRI)
 		kiocb_flags |= IOCB_HIPRI;

-- 
Jens Axboe

