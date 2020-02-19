Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49F5C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD8E2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582138926;
	bh=ehY/IcmJlLWkLBLWPNZNlsP4wL/peyqF3cY50YkTKfI=;
	h=Date:From:To:CC:CC:CC:Subject:References:In-Reply-To:List-ID:
	 From;
	b=LHxIc20anN7BOsULc+69bap75OpM7ErLV8HTgSEx7JExQ8L5jA5iO9jfZ4/BJ9Cdf
	 iAKb9OKAF6Kv9Imteh2rxdkV9rC/I0GW051yUAZqDBE/4hLNzFicl7zcUmcYtiLKsW
	 HOKkHKJgHv1od+IbRcgpiSts7yS0xk37Tl5rxx1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgBSTCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:02:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35983 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgBSTCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:02:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id 185so533021pfv.3;
        Wed, 19 Feb 2020 11:02:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:cc:cc:subject
         :references:in-reply-to;
        bh=DQ+8e/HKGBnHq6nvydGmkDGoz7qP42z+/5Gl8Bp1vXM=;
        b=b6wsWYzz0dLWKsiIXsKzMSA8s/F1kQZcnl/azBTP3uXFetqwGwxg0zi2hINxAlbGG5
         AGoGLGmbDDClNOR6h7xL7NuwrYNnP5hptLfCsinZ5TjnmsWvrfZR7MZ4S9dgkfZopV4g
         uoK7rWn/ypObWivR/uuhDmWQJ2g24SMRt6LJoEAWKA60MBDJ6/BFzlIF1Farkf/PNNd+
         6Rg1reTdDpnRNf6fPPhHrbS8EH36em39rbsNd5bE3zRmmoyUfA8SglrXNhRXYCG9+bv2
         KVUDpxhrBVf1NXlCISkG2fPm0LSzTxxvmIvW1JqNSCfxkRo4fx5J4P8uh3i5+ciXxjVo
         L74A==
X-Gm-Message-State: APjAAAU/Ef9dre8PCrisnp+l7Eu6CReMAdJaxShl/5Cl7yNwTCLwQckb
        tLrpPVYkYOuZIJuYQRDvzuA=
X-Google-Smtp-Source: APXvYqz0zbVTnwXcEGrqgq+dh98mjID4Fk0tQbXlrqghd7SgO5JOQTS9S8t1iQSJu7hDmNsvT/X62g==
X-Received: by 2002:a63:2254:: with SMTP id t20mr29921645pgm.423.1582138923106;
        Wed, 19 Feb 2020 11:02:03 -0800 (PST)
Received: from localhost ([2601:646:8a00:9810:5af3:56d9:f882:39d4])
        by smtp.gmail.com with ESMTPSA id o16sm437367pgl.58.2020.02.19.11.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:02:02 -0800 (PST)
Message-ID: <5e4d862a.1c69fb81.5dc73.17b5@mx.google.com>
Date:   Wed, 19 Feb 2020 11:01:56 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     =?utf-8?b?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>
CC:     linux-mips@vger.kernel.org
CC:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, robh+dt@kernel.org, mark.rutland@arm.com,
        ralf@linux-mips.org, paulburton@kernel.org,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com,
        dongsheng.qiu@ingenic.com
CC:     linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: X1000: Fix clock of watchdog node.
References:  <1581855028-25552-3-git-send-email-zhouyanjie@wanyeetech.com>
In-Reply-To:  <1581855028-25552-3-git-send-email-zhouyanjie@wanyeetech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

周琰杰 (Zhou Yanjie) wrote:
> The devicetree ABI was broken on purpose by commit 6d532143c915
> ("watchdog: jz4740: Use regmap provided by TCU driver"), and
> commit 1d9c30745455 ("watchdog: jz4740: Use WDT clock provided
> by TCU driver"). The commit message of the latter explains why the ABI
> was broken.
> 
> However, the current devicetree files were not updated to the new ABI
> described in Documentation/devicetree/bindings/timer/ingenic,tcu.txt,
> so the watchdog driver would not probe.
> 
> Fix this problem by updating the clock of watchdog node from
> "&cgu X1000_CLK_RTCLK" to "&tcu TCU_CLK_WDT" to comply with the new
> ABI.
> 
> Fixes: 7a16ccd300c2 ("[v8,1/4] MIPS: Ingenic: Add Ingenic X1000
> support.").

Applied to mips-fixes.

> commit eb41113870c9
> https://git.kernel.org/mips/c/eb41113870c9
> 
> Fixes: 7a16ccd300c2 ("[v8,1/4] MIPS: Ingenic: Add Ingenic X1000 support.").
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> Signed-off-by: Paul Burton <paulburton@kernel.org>

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paulburton@kernel.org to report it. ]
