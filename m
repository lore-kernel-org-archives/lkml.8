Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE7C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F2F20885
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 22:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="0PeI6Z1e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgHPWqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbgHPWqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 18:46:17 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4D9C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:46:17 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id d4so6772182pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bdd6W0wjQY4twkrWmtbJVXisCwlRs5bWGrujUBo8Nwk=;
        b=0PeI6Z1ecW8efJzLFC+P8s1OAkzNy/oopjAlpwdzDP3uBqFkzuM0LC7h2EtUvfrtXA
         H+KPQMbotMmqQMr8P1MNXZgncjh6panXS2zxueg/UQK8u55yimqp19q2O1qmJlMboUES
         wLW9x5yYq18B2w7E+DUwjH6CG1fyL99VmUoHlERhAv6vJWsbsCoT7gU0ueR+003bhM/9
         6BxU2M/y03cfgbvMrygaTCwgmXWcO/G1oRsWk6wGeZnbQEYF1aoqZUxh36DXDIGlGGkp
         xE8zJPR6Qzexcme83X93JWu1z7YWUiNLMlNDemL2M7hWnVysRVEhUhC1johnNvKiSW/P
         G34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bdd6W0wjQY4twkrWmtbJVXisCwlRs5bWGrujUBo8Nwk=;
        b=SbTgxPjkRb1zHkU6Xa4RIXLpZ4QesljFJ1HTCRFGWrWlxZXsSC5WDsum38St1n5E32
         5RGBv19rE3XFgeWaympcx7v4a9puekSTQzaC4DTjS66aRVTk0eymoZkTdVscrsqOMbYF
         3uDCZpvgbaSsLcECJcdCVmgLwiwiAF7fm9DrsNapbm4zDOiULi5JWhe0e4t4DtDSlimv
         Lss0QfwMJ5l70Riug1UlfdNfRVGxbmCzB84fkGWxNH5pd3LyjtKfPa+5yf9FF082L6gd
         jdw94K+U36qYo1/J4R03RosBXNLHPi6dSgC3iPILA/OGAb9PN3dmHyzXnToBiNLfuJgk
         WvJQ==
X-Gm-Message-State: AOAM531GBV03r+Ld6EaOivEqiipEh2QtWq+MnrseMYSPbqs5KBPLsSpz
        5/rXFu+sIo2IhFjN/5XOfwJR/w==
X-Google-Smtp-Source: ABdhPJx2RyitijhpB8HyHg+v11L1TWUQym0dBB5Ie1aetMyyLQqZUL93SvmgA77M5oT0IrbM+Urt/w==
X-Received: by 2002:a17:90a:24e9:: with SMTP id i96mr10393612pje.148.1597617977195;
        Sun, 16 Aug 2020 15:46:17 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id a24sm16311197pfg.113.2020.08.16.15.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 15:46:16 -0700 (PDT)
Date:   Sun, 16 Aug 2020 15:46:08 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Murali Karicheri <m-karicheri2@ti.com>
Cc:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <nsekhar@ti.com>, <vinicius.gomes@intel.com>,
        <kuznet@ms2.inr.ac.ru>
Subject: Re: [net-next iproute2 PATCH v4 1/2] iplink: hsr: add support for
 creating PRP device similar to HSR
Message-ID: <20200816154608.0fe0917b@hermes.lan>
In-Reply-To: <20200806203712.2712-2-m-karicheri2@ti.com>
References: <20200806203712.2712-1-m-karicheri2@ti.com>
        <20200806203712.2712-2-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 16:37:11 -0400
Murali Karicheri <m-karicheri2@ti.com> wrote:

> +	

> +		print_int(PRINT_ANY,
> +			  "proto",
> +			  "proto %d ",
> +			  rta_getattr_u8(tb[IFLA_HSR_PROTOCOL]));

Since this unsigned value, you probably want to use print_uint, or print_hhu.
Also please put as many arguments on one line that will fit in 80 (to 90) characters.

	if (tb[IFLA_HSR_PROTOCOL])
		print_hhu(PRINT_ANY, "proto", "proto %hhu ", 
			  rta_getattr_u8(tb[IFLA_HSR_PROTOCOL]));
