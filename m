Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC3E2053B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hOtuByon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFSVZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgFSVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:25:29 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4B2C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:25:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b16so4951786pfi.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UmwgP8tf1sr1yPrAvUA5OCXwrBJ/VY6zjNh/2Eo5ca8=;
        b=hOtuByon1Yl8BHcDipOgL4w5AtIu6zg02K0tQFPdKHazXmv9G2oKcDimkJRFL+9Mub
         G4SEaJRJQlK3jAhoPwQcPw4dAyDzuiG7hYZlFWR3MPb3pRVAdJoVHxXgwmppzX+82ucA
         0Zit6JjcRh/Xx14I+bDhL8aEH4Cjtn7/htYN3kwvm6cEiB51IFalhErP87kdUbQZdpci
         ybg/FxdYAGrJffcFXueHim+T3xCYO3u85ExtR390802RvNfVpvsRBH9UAqpvSmkDU1m3
         +VxG7+PDRX0rKgWk5dweypk4Wb1KI3I5CspRFmJ2uo57dlWiaoFKPNypsGzTWyyGzNFW
         tR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmwgP8tf1sr1yPrAvUA5OCXwrBJ/VY6zjNh/2Eo5ca8=;
        b=sX/+bUdcuWxWvIrBjeCAX/FPBW2GuHq3Ez/oZCHNf2k3YQy+k0UFlm4kvqjt9Ok0Tw
         2h79xIegXy5fNQy98tF1pY5EWrqt9TfZl+M0TMqNspaTly0+CVzBlTBC5gylE1x7cEuM
         gcfIwx4ZkuJJgfuWVgQvB3uO3D+l6mXvvoxPDR7qk2cEpnzhQoDXlF66txPD+itELxft
         E8pan4jmNDimTWssJB2cPD8BRt5gAQVgk6tO/SLeq0vZ3FBry2LzYTzjdVJhkuJp/z35
         jwc3+PcdbIiAM60OAQRfHUfU7e0R4fYii4LPb1WKMkv5sOIq9Edn6l1htRl3W/Bj+Olv
         8DIQ==
X-Gm-Message-State: AOAM530zvUNDXjzDL+AmYwxFmd8znOiiznVcMMsQYUwevIUAkigFaHin
        VBoQdq6JCo4zb4XxBvxdYxrm6GzXKeJnyA==
X-Google-Smtp-Source: ABdhPJwvAFo0z9Gp8uH8UKjXkX927jR9YFNqBK0dkiKHmf8YvV+zQ3YC/c6tZwUmMbIxkYOck5GNvw==
X-Received: by 2002:a62:76c5:: with SMTP id r188mr10058873pfc.60.1592601927413;
        Fri, 19 Jun 2020 14:25:27 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c9sm6769330pfr.72.2020.06.19.14.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 14:25:26 -0700 (PDT)
Subject: Re: [PATCH] gdrom: Block comments use a trailing */ on a separate
 line
To:     Sudhip Nashi <sudhip@nashi.us>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        Adam Williamson <awilliam@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20200619211819.50910-1-sudhip@nashi.us>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a34c328-3672-899a-4b54-f64daea9f132@kernel.dk>
Date:   Fri, 19 Jun 2020 15:25:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619211819.50910-1-sudhip@nashi.us>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 3:18 PM, Sudhip Nashi wrote:
> Fix code style to conform with linux coding standards

Let's please just leave these old things alone, not worth the trouble.

-- 
Jens Axboe

