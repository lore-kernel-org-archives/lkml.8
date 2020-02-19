Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB42C169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5BBE20801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582139180;
	bh=dJ5Jp5M2ZripkZLxmjhbH9IB6dSwM7CiJClk7XNCuwE=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=kV68MWyRU8ZQ8t9HUQg+t+Adu7VifbAMbTZrqSKN64QTxO9hCosQo1wZKy0jxnich
	 0SQ3W+55WDPb7n/odWMpoRfVI2NrCqSV8dAJvCfQ/v7ur0z+RJdH95h0N2au7ozPiD
	 FPfcow4D44uHfPcLAo1YJtXMAIgoelBULaBNdrjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgBSTGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:06:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35852 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgBSTGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:06:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv17so465980pjb.1;
        Wed, 19 Feb 2020 11:06:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=Li69D96UynYkf8JlXUUJ5Eri/Si/2jqwsMBbn3qmZS4=;
        b=c2pkXgvmisK98DUswluhTx/FWGUz0fV8YpkjWQtb3+nV8xD9zL2MUF26OiL0pZIkK0
         yyOJcxQJtint+8n5+/3mM2tWvmepc86GiYbYyGZ7t1wX6h7gvc1cXHZTz7wHR9uBD2nd
         pzy0/Hbj/euXkDbKJmtIQ/z5laUKSG6TexHz5x+WVlEw9+n601hL8EeH1axHbFqVfqMT
         ZgCf51SswB325UMZ08J6dJb1diVJPgppRtqzZqpXjJPGM99gjTncYEGjJ7Kk6HvxwoDF
         3I1e11VSrJ0fQnJp2tPJl7S2vtdlzf78Ghr0DjmWReoqYNWCuw+7+peNqCp9NhrbtIFo
         Nx8w==
X-Gm-Message-State: APjAAAXuIolOBufMRwWIGeLAjOdcwBYb4VGe+V9k/rkKRskNAo7EGFGo
        mANnZwKpBmERf5Q+tg7eb70=
X-Google-Smtp-Source: APXvYqxEWtnBUAbhG3oyDrpABKMoy4uPAfK1vDTH8uFSy42bySZvvzQ185jRsvkELv1wDoR5r/7gOQ==
X-Received: by 2002:a17:902:8546:: with SMTP id d6mr27599050plo.193.1582139177825;
        Wed, 19 Feb 2020 11:06:17 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id v5sm467463pgc.11.2020.02.19.11.06.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:06:17 -0800 (PST)
Message-ID: <5e4d8729.1c69fb81.a8fdb.15ed@mx.google.com>
Date:   Wed, 19 Feb 2020 11:06:11 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?q?Philippe_Mathieu-Daud?= =?utf-8?q?=C3=A9?= 
        <f4bug@amsat.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
CC:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: configs: Cleanup old Kconfig options
References:  <20200217165634.5362-1-krzk@kernel.org>
In-Reply-To:  <20200217165634.5362-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Krzysztof Kozlowski wrote:
> CONFIG_MTD_NAND_IDS is gone and not needed (part of CONFIG_MTD_NAND)
> since commit f16bd7ca0457 ("mtd: nand: Kill the MTD_NAND_IDS Kconfig
> option").
> 
> CONFIG_IOSCHED_DEADLINE, CONFIG_IOSCHED_CFQ and CONFIG_DEFAULT_NOOP are
> gone since commit f382fb0bcef4 ("block: remove legacy IO schedulers").
> 
> The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
> now enabled by default (along with MQ_IOSCHED_KYBER).
> 
> The BFQ_GROUP_IOSCHED is the only multiqueue scheduler which comes with
> group scheduling so select it in configs previously choosing
> CFQ_GROUP_IOSCHED.

Applied to mips-next.

> commit f6541f347bba
> https://git.kernel.org/mips/c/f6541f347bba
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
