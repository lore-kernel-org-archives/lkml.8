Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F130C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645182076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yc4RnboI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgGPPpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgGPPpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:45:44 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DEBC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:45:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id d18so6514769ion.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Tx/hUhqJAjXkev40Jb9OVrKXoukmWH1wNBtfngv1/sY=;
        b=yc4RnboIQMLq3CDak3WwAyj7ppF1bGUno0SLnNg2VBzMUR9N4zOyzuxgsml+LgwHoB
         ysEFbrig6lXnRPbp533Tb+2k1nMKJrfIx1OUfd+oBRKa/8cP/GeP7DtVM7wMXX59oZrc
         TMue8U4xfvt7ytA8XcknosKvaaf6GdgTFhbs7p2K8FpODu6xMN9CGDVCt3BXy9EUhQ5j
         V6iAhQEao2CXGAXmTiXhk2h2q855hsUwCVbsh7bSpY7E6LiVll7mwDp3ZKnKGWcm1/Mp
         ZzFkeelBmFZu+9P9/m/nKK8yQkS3BZeCfNGqtwIyCsqtZX8rKhmmm5/pRjzId4qU6Gp1
         C3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tx/hUhqJAjXkev40Jb9OVrKXoukmWH1wNBtfngv1/sY=;
        b=OmY2GDOFb+a/EPGgNkjL+6PVftncEOaSyl/MqHXUpTxm75EtxM3tyV0/m+mIrXuuBz
         5+pG/aZQF9d/CQ5DYQGjabY3hUnYxCudzXDkcABfVZw8CR3eRCjQ7F7zXqZ4CVePVlKm
         rpZVTqXyNzWaEGGcMJESDVqWmseToSfytl2FEsaGjeirPvB2oc7/VQLqdFF1d/lFxVU/
         m0NK92e65puprRxwa1DKGxaU5jCmBZbZB4zGATKR/NvP9MWoORM/46jPssKxal5ZtQqU
         RhaZxXIVSl27eNyBwMVUvycpjR2BhoJ6COl4adyo9cBoBcYAfJmSrF3LZeNg0KNkbec7
         WDBA==
X-Gm-Message-State: AOAM533Hcgb8NQAK5bnyYdBcvuL8YO6a7YBTvbRB9OId2wtIeVsMDb62
        YMLyXikrWMF6zQZebnyZ4kJUUJCf5/ivDQ==
X-Google-Smtp-Source: ABdhPJxF850bmoBLpclUx2eq04KON8mHvr6Ay/QHFbo24vQEXQSggVEJ5YQYda0SUwxpCWYnpoSWlA==
X-Received: by 2002:a05:6602:5c3:: with SMTP id w3mr820159iox.3.1594914342258;
        Thu, 16 Jul 2020 08:45:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w16sm3209054iom.27.2020.07.16.08.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 08:45:41 -0700 (PDT)
Subject: Re: [PATCH -next] rsxx: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200716090432.13691-1-miaoqinglang@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e4caa1de-db2c-c2f4-d1e8-fef7073a52ea@kernel.dk>
Date:   Thu, 16 Jul 2020 09:45:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716090432.13691-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 3:04 AM, Qinglang Miao wrote:
> From: Liu Shixin <liushixin2@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

None of these apply against the 5.9 block tree, looks like some
read -> read_iter conversion has happened in another branch that
I'm not privy to.

-- 
Jens Axboe

