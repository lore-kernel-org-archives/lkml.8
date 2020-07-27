Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4658BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F868206D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgG0NFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:05:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41355 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728141AbgG0NFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:05:22 -0400
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1k02oi-0003FB-Fg
        for linux-kernel@vger.kernel.org; Mon, 27 Jul 2020 13:05:20 +0000
Received: by mail-wr1-f72.google.com with SMTP id b18so867615wrn.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 06:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bzR3LoEEn8WdPuh8casfIRu7IDrLfMDc4V7KUL0jgCY=;
        b=WyFec+AtynmvCz/RmYDvceHXG9u7IFYFGIOu3Gzm5Dv51q40cDQhtEL52bQepmtlpO
         kTEo/PO/H7myJzsycM40RFxWwUBG408MSxSbKGjIicl/ftYDtmM3Tq1Zoq7SR9Xkkwjx
         JyDyaYWrKCFdf+fWKoulbOtVrow568UReIzz9jQF3GC2+ODCaMiFJic565V3FP51Rwxo
         VQ1VSZVf+2Sc/lJoK3geyHHCq7wjIrWTqoXIfRt0XPI5nwhu0Ogr9yxqNiuP1Weta5Nu
         ShMTo+hzXC4rWyR9vbAh9WbOYxEUl73Cn3NkuuI6ihxGNsU15ngZZ+Y5YQocCGwKFpjU
         JJsA==
X-Gm-Message-State: AOAM530rAeYqmlb3C3kQjYwWasizzL0rIWZmtedlAzjRwOLxOyMcPsMK
        fwSG8txXsVM0lawV4VvVT1jlx9+Hv7dGaRH3DRChR61ZL036qil+Sl4SfkFjEi8PQ4j5gYVttC4
        ylwCuMFzbaqN4JfG2DsSPDGXI2pP9viPjFqUW/Ne8Og==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr19357064wml.7.1595855120062;
        Mon, 27 Jul 2020 06:05:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxS8vOBlTBGfZagOx/7xHoe4Q1rRXmLkgmZv9m4Qk0aKPHSDg7YFGtdOTXCeisZv+go7aB/NA==
X-Received: by 2002:a7b:c92b:: with SMTP id h11mr19357045wml.7.1595855119761;
        Mon, 27 Jul 2020 06:05:19 -0700 (PDT)
Received: from localhost (host-87-11-131-192.retail.telecomitalia.it. [87.11.131.192])
        by smtp.gmail.com with ESMTPSA id h6sm12969636wrv.40.2020.07.27.06.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:05:19 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:05:17 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: crypto: aegis128: error: incompatible types when initializing type
 'unsigned char' using type 'uint8x16_t'
Message-ID: <20200727130517.GA1222569@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing this build error on arm64 after updating to gcc 10:

crypto/aegis128-neon-inner.c: In function 'crypto_aegis128_init_neon':
crypto/aegis128-neon-inner.c:151:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
  151 |   k ^ vld1q_u8(const0),
      |   ^
crypto/aegis128-neon-inner.c:152:3: error: incompatible types when initializing type 'unsigned char' using type 'uint8x16_t'
  152 |   k ^ vld1q_u8(const1),
      |   ^

Anybody knows if there's a fix for this already? Otherwise I'll take a look at it.

Thanks,
-Andrea
