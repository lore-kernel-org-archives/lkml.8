Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649F4C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BAD2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RGDqo7t7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgBUKrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:47:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33866 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgBUKrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:47:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id n10so1490128wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 02:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=f7yu7K3JlqyMe87m1GSh91P+I8Cu0Gpj7XsTeWNuw/0=;
        b=RGDqo7t7PQPwtANjW5Ko22b90oJlbS9Mbf6ViJpbXRNCF7YDRSRfcvNmdV/zT3QepT
         HThU/ZP44u6O6LrZKKLyVd+22OjfZ3zbVn9pls+kj3owR3PMIQhitrXFftNz3SitokNR
         T9mPMwW3fNVmP5iOQ7p/HA3l3Lb9CdcHBngtcXO3U2oV+r0IdSKHXiUM1sOKePr8qnea
         qM00U+ZEW0OciRHwoyROaCyh+gPx7YMiHu61+a2gOcvloFrncIu++N35yGAmyMzsdyPd
         AJlP1Ycpd3nkKQbMNXSKVsxgYoPo4JjmEbtslNFQNYDgbTxTqTyI+1Cf0wwACm5gt6AC
         arcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=f7yu7K3JlqyMe87m1GSh91P+I8Cu0Gpj7XsTeWNuw/0=;
        b=SWXKsSfWXkS5JK+FUQ6EkjGYWjSOf5x0IJyoADz7STr7YDCbbxlJckljohdu6FS8IF
         K38sRvEd6dmTRl8isIUhihjNyA9DQcZ3Y7Ijnb45TwtxxCC1W+SEYnwRk9AGugLRkSKT
         xTQXihJ2cLhfPqey3X+j1wWsLNbUSvNqQ+Oxp3t9BIBWtKmE4h/WNtF2W4wIEEAlzCNe
         AcD+ipbxYkKmJtM56pXE4G7pw2vnUpF+wnlklDA3SKh/4txXDWlGfZ77NcA5DrzCj5Sf
         TYW1QSZ8ZVnczbhJU5EvcA6E4O/2u3MsAvbj09ZixCSDE21pG8COx6vpC2VOkeoxuylq
         P+Nw==
X-Gm-Message-State: APjAAAXfJ6bBXhbZdIx5H+Cd2BZlaoFcmbNOTnicd9orIx/frkWDxpa1
        HtNb5VkbZ7H7Phiv6Mp5NoinpdCcAys=
X-Google-Smtp-Source: APXvYqwsELLBhCREi3H11GBspa/fR2fMvBqx3YW0qemlsSfDpaHyhrVRZwlk5hC2zFPbUNrDKhRDaQ==
X-Received: by 2002:adf:f28f:: with SMTP id k15mr47355503wro.230.1582282018874;
        Fri, 21 Feb 2020 02:46:58 -0800 (PST)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q1sm3376647wrw.5.2020.02.21.02.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 02:46:58 -0800 (PST)
References: <20200220204433.67113-1-martin.blumenstingl@googlemail.com> <74a8613c-ba30-5f42-9edd-b5af1d7f330c@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com
Subject: Re: [PATCH] clk: meson: meson8b: set audio output clock hierarchy
In-reply-to: <74a8613c-ba30-5f42-9edd-b5af1d7f330c@baylibre.com>
Date:   Fri, 21 Feb 2020 11:46:57 +0100
Message-ID: <1jpne82p5q.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 21 Feb 2020 at 09:28, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 20/02/2020 21:44, Martin Blumenstingl wrote:
>> The aiu devices peripheral clocks needs the aiu and aiu_glue clocks to
>> operate. Reflect this hierarchy in the clock tree.
>> 
>> Fixes: e31a1900c1ff73 ("meson: clk: Add support for clock gates")
>> Suggested-by: Jerome Brunet <jbrunet@baylibre.com>
>> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied, Thx !
