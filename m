Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73380C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DA9207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DW38DBkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIBBjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgIBBja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:39:30 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2791C061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 18:39:29 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m5so1695998pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 18:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xac0up/E+0dt+kqvaJFEykC0qib3GWqZnuHU1zuntaQ=;
        b=DW38DBkIyDXDIC1LfOSyJndXvgCNtBDf480T6W9zRSykRYiuGpi5ax0WKr6XdQR4OS
         SCW8aP1BCO2jmi7ye/8AW7amm70var1nMzTU4C4gJS7I8Csi9CyNUz4tgcClFxDMv4EN
         VW8gvPtr//38CNX1uDn0s2Xn7lRD8GuogjTzf3P7wTcEbiTBsdQjHcRzT7XKt6XED23r
         RpaW8i9oVGw+SLUbtTnXUkjuTEkopU/UE4FimcH/LZgRenCOwOF84IKHHkxMANV2iBjt
         KTageWCVt1O4DTOFLY3DFRw6auUcDCF1rbX9wX5tmr4x7C/x7QNqikbkKdDKx7+MnouL
         pdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xac0up/E+0dt+kqvaJFEykC0qib3GWqZnuHU1zuntaQ=;
        b=gtBAnbcrLiuB18bfYTbbPoQtMrv1+EWTgNz3O0uZAlrd9CvsIkrrsYY0BXFdxxSXvQ
         M8Ml4gptOixK/hjrSIW8Lx9oUtHE7YSFrBSLXVEm8V54pYymiqGG1VHcwvJUdtXB1c5m
         yL/4ZkDnbMlMZbW8HO3tYE/OsCzHa/qWRgfjk5wfmhY7S8i+WtLq48Y0In3QJvphMydI
         y1S5E22VfKvUowjjULpYasOXwa/1RU3eRBeX5ccKSaAP8lzSqeGJqtBUq4avLO/I8dQD
         onfegCqJqOk+/fyUyrDABJQjcXIqvJIiylh0wYNq5H92xwFW34AEwF+qN4QuxaffsxUl
         eouw==
X-Gm-Message-State: AOAM532t15fh849r76WciMyKtFi06hKMnTV5QipYjMUvSLtdIL13jix7
        ZCaa0EchHQ29aWuuREcNN1MNxEhMiGL5KG8o
X-Google-Smtp-Source: ABdhPJzRReyKRlFMDVO+CKfJQstUA8ZxyxM4fg+VgfeARmLkMvnW1ZFERkgXTvcJL6c92Uueg5Qz9A==
X-Received: by 2002:a63:f00a:: with SMTP id k10mr43881pgh.76.1599010769179;
        Tue, 01 Sep 2020 18:39:29 -0700 (PDT)
Received: from [192.168.1.187] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y65sm3225600pfb.155.2020.09.01.18.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 18:39:28 -0700 (PDT)
Subject: Re: [PATCH] block: Fix building error
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <b5d0ed52eeeac60906d36cb17b5344063cfa4197.1599010452.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <60a9cdca-e752-15db-9b7c-f25be14b0ddf@kernel.dk>
Date:   Tue, 1 Sep 2020 19:39:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b5d0ed52eeeac60906d36cb17b5344063cfa4197.1599010452.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 7:36 PM, Baolin Wang wrote:
> The disk argument has been removed by commit 3b843c0bda28
> ("block: remove the disk argument to delete_partition"), thus
> fix a building error caused by an incorrect argument.

That's my fault, after shuffling things around a bit. I've fixed it up,
thanks for letting me know!

-- 
Jens Axboe

