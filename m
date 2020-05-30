Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA2C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766DE20723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzvdWBfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgE3VW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgE3VW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:22:28 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F0BC03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:22:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n24so5582435ejd.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 14:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QmoOwPdh/Yl0z/r64VCHCnCtjbrPdNoeXim/FncXpAc=;
        b=NzvdWBfYHs81uoSKig5N1GjDzcPaZ2kmA/RsrJ+LNhPnApVvHVgXKqX4JtRNq7wiZG
         KsS3JM+nMSx1x2v0Zd8Mze/jofq/xzFx57vBwcmqcD76yIb6f2Yi0oHAYrmkeiFlg4Ld
         JnEf8DM6aKJXuhGkEjjdHBP9lblPiWv0yh15zAUjT5k8iVlq0qfI/5hZ3mLvpc4aQVtH
         bpSP/ORJkheDxrHolOsG1xNQI/A2wymwbddq9qJnvIdU9eH9WaqnJZTMo85S2stNrRl6
         bs9y6qI1aajckXZWZBe4gjGixnpTsw8wK6efnWihhnYLa9iurgSWXczjQ9wLdJVrbYBv
         71kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QmoOwPdh/Yl0z/r64VCHCnCtjbrPdNoeXim/FncXpAc=;
        b=dxzAd+R8E0B52PMecJKf+OF13rOJ3z+FiZe0uGx6VDmrvzL8pySu0ni7dvd+nhSyDe
         1F9Qhj45pXBKAdthbuMybH/B+AzIkJOsLblL4ljCKJmAHeg73mqgowR8J3/Xmu9QkUI0
         OIUY/SYVYw7qzxd2tyX+Vjy03lOboO0KQBQhU9PrMALVrcUgUiXL/oWP1/80AgxjGzQA
         oTxtVEgkDryqhSklewKcOoJI/qI5Ws/vs8w+QSmXFRfVNoCOLLg0gXgWGXl75o8wVDfn
         pyw7BxvRv5ztmnseT/05nWDsLuZeToXgYG8RMouWlTEr1n5gU44OXwQ/f6xd1X6/XGTH
         Qn9Q==
X-Gm-Message-State: AOAM530aIj+FHNHwqeP+l9+RGmXvnZPwh1OUZX2W3vc+TyaBCQzPTUIn
        vJZ44A/0mWbVxk2pG1M8prs=
X-Google-Smtp-Source: ABdhPJyPw2InxgF1fnTZ+GsdMSz/djINa9S3RvsHZ+SMI1VXmDF7DPfTo2heWnPYPZ4bhQI+i5t2Aw==
X-Received: by 2002:a17:906:c344:: with SMTP id ci4mr12482495ejb.331.1590873746285;
        Sat, 30 May 2020 14:22:26 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 93sm10950559edy.49.2020.05.30.14.22.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 May 2020 14:22:25 -0700 (PDT)
Date:   Sat, 30 May 2020 21:22:25 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: use the same mechanism for get_count_order[_long]
Message-ID: <20200530212225.l2zbkq5mrvkabxik@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200525215958.21653-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525215958.21653-1-richard.weiyang@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Would you mind picking up this one? The test module doesn't show any warning
after this on applied.

On Mon, May 25, 2020 at 09:59:58PM +0000, Wei Yang wrote:
>These two functions share the same logic.
>
>Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>---
> include/linux/bitops.h | 8 +++-----
> 1 file changed, 3 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/bitops.h b/include/linux/bitops.h
>index 5b5609e81a84..80703ef27aee 100644
>--- a/include/linux/bitops.h
>+++ b/include/linux/bitops.h
>@@ -188,12 +188,10 @@ static inline unsigned fls_long(unsigned long l)
> 
> static inline int get_count_order(unsigned int count)
> {
>-	int order;
>+	if (count == 0)
>+		return -1;
> 
>-	order = fls(count) - 1;
>-	if (count & (count - 1))
>-		order++;
>-	return order;
>+	return fls(--count);
> }
> 
> /**
>-- 
>2.23.0

-- 
Wei Yang
Help you, Help me
