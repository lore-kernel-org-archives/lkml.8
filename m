Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099C4C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E4E2137B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ytdkogj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgIGRtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbgIGMgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 08:36:53 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A143C061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 05:36:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o5so15607244wrn.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 05:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cqFMV15+ncKbqbkS4rVaONwxjHJHpxU0h6ADgIa+Z0A=;
        b=Ytdkogj/FxZPspswI944ZPcLbsutNDXJrlYzv30IZRXro+wphhZ7PvwcYfnJRJzjIx
         s75ETcQTuUJ8NNe2sic0iOG3MMMnBSqgF13pBu4txpvZFjikm6UA5tLJLLk+Y8svAkjK
         Z4X/f15mhhpq+73D3DFlce9xxFWpwjW4n7yRPEY3bwEEZeUzDpkPbO4kFFXx0SNzouLC
         kjFo1P0XR8lmeCJnUGGu9Z6Vy5eZl4Mdl6ErHR2gA0m9LDTSuU1zVTowmjnTp8MnJ8vA
         Gg5xzBuDnxiDAPSSl28ZKMla3iXO+DznonLNjF9EF7pCJsG9fh2w9zcNUGySnCHQzMY7
         LtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cqFMV15+ncKbqbkS4rVaONwxjHJHpxU0h6ADgIa+Z0A=;
        b=goVmkMUBu1PAaI0ViKBHLMQJZCIwDaQhv6t2KqZVW3W78E+AaTduPWxL7QgcFwefvm
         PR4RqQHXnz78B75ji0WtZXUF2k7J5bM5zeettu3ox3kfduZcyCaY/+Bj9gw8z3m4qnQO
         mrpkjQT6u8kX6oNfIfMuxvHCg8Ru+eU/TLDVPvt9EW3sc7GxaaXHSUBm1XLHfHsSVt4Q
         V93dqfC5OvG8L0mlM+g3x7VBacM12MYD2IJI3aAXM4zjux7AFnYkiCh934fPwEooTuSJ
         Zss21OLScF6zpHrATXrom6zC58esk7FYToG2UVr+v0eB8gm+oe16YVppfVLSXh/EzCAC
         e6Fg==
X-Gm-Message-State: AOAM531+q+KF02H4V7XKXkWXKM8DjQvnTY4HnF+nerw5vXSZ3S+QSsod
        pvC63awRhexi713qS7EQ8o6h2hCXqx3XjQ==
X-Google-Smtp-Source: ABdhPJzQe5EfAU2q9xGZLtiNTjwaCpqPJTnKV5+qPIuoluAHp8SC/Sa/9E3K2d5sr2tXrTy0rFiyKA==
X-Received: by 2002:adf:e583:: with SMTP id l3mr21112729wrm.72.1599482211454;
        Mon, 07 Sep 2020 05:36:51 -0700 (PDT)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id z13sm28535545wro.97.2020.09.07.05.36.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2020 05:36:50 -0700 (PDT)
Subject: Re: [PATCH] misc: fastrpc: add ioctl for attaching to sensors pd
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200901003300.11985-1-jonathan@marek.ca>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <fa436d55-b986-944f-e90f-b81cb32eeb0e@linaro.org>
Date:   Mon, 7 Sep 2020 13:36:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200901003300.11985-1-jonathan@marek.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2020 01:32, Jonathan Marek wrote:
> -#define FASTRPC_IOCTL_MMAP              _IOWR('R', 6, struct fastrpc_req_mmap)
> -#define FASTRPC_IOCTL_MUNMAP            _IOWR('R', 7, struct fastrpc_req_munmap)
> +#define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
> +#define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)

Looks like changes that do not belong to this patch!

I wanted to try this patch on SM8250.
How do you test attaching fastrpc to sensor core?, I mean which 
userspace lib/tool do you use?

--srini

> +#define FASTRPC_IOCTL_INIT_ATTACH_SNS	_IO('R', 8)
