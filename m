Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D042C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 695952070B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bMT1cl0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgBRSWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:22:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgBRSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:22:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so732859pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OA/leHKYo8E0m/uN7yH7vLY6aAq5W71bNQ4zaVt1YAQ=;
        b=bMT1cl0A50XBAxT6a4EXDbABdH5yjYLfCj2oSh7ERqVMjMGte8z6xGFRiPmZnReT6f
         mY8lke2SPH9v2LPaUsqOYhqcrQUHbvIOFcGjopFiJRCkkwSh0log+Yw+t6ruk+iKeQ0t
         8V6KqTYhrXPnOCi25MDgfNoCKSf9QlNxpgrhxYW0SFA5ZFqforuH6tfDQylWzP2CWx5A
         gkLsyVItL1ue5rZpakLGyVuHT8IcVioc4BG7rKmEtRB/b2LmkmeWuttDFCSE5kYypbSo
         g7FcmHE9xLvfxBairPHO+KXf5j0/XeqVwhPgSRlqlfNYVgEewcZWfQWtGnU1TMAgOSN1
         7hMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OA/leHKYo8E0m/uN7yH7vLY6aAq5W71bNQ4zaVt1YAQ=;
        b=GwjtSp4yNjLi8CVGYFzK75QoffCA1fyV8YJPnx/QATffbZrsTXojXcmgb8G+Cv8GZ8
         H8679Y5FbgDsQ3poUWv5WYRkGLz15cLO/y05q8KBrzW9prKs8EpGXDRSGXrd4sNbhWjn
         8hsnfZhYcfQxhl2dkFX+KAa8lOt+vHts37Tld8+ojhEmclP3utxCig9H7caV8eSmX4Rt
         INlxZx6r9TVQJYp3E4WUITdF6N41lJdfIWqN7RAwKYyzpgvp+z6MUDUa1j0fNqRuFdmN
         pANKQlLkuOm0vYvrCYltWJuPQ4mnf0K7h+qC4uU4sMd4i4kx9+CwSSAOyM23rkWt+Zi5
         e20A==
X-Gm-Message-State: APjAAAVX2hA4bqZ8xI3W159ED8UYEB/8t+5KPIlN/jeiWswxGnmbaY3N
        Ih+utUII92o7DhAboQXy0SMn2w==
X-Google-Smtp-Source: APXvYqwhzCvUjtjFn8vnB6Tn1FwjdTQfQa6cEYagqG9JJopOzh3ICxi7iYA/N5vmbOSxF30bjSHJbw==
X-Received: by 2002:aa7:8502:: with SMTP id v2mr21735685pfn.232.1582050150169;
        Tue, 18 Feb 2020 10:22:30 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:e155:33dd:95af:8080? ([2605:e000:100e:8c61:e155:33dd:95af:8080])
        by smtp.gmail.com with ESMTPSA id l26sm5389586pgn.46.2020.02.18.10.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:22:29 -0800 (PST)
Subject: Re: [PATCH] io_uring: remove unnecessary NULL checks
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <93921160-d063-83d3-1064-a70247def2ac@kernel.dk>
Date:   Tue, 18 Feb 2020 10:22:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217143945.ua4lawkg22ggfihr@kili.mountain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/20 7:39 AM, Dan Carpenter wrote:
> The "kmsg" pointer can't be NULL and we have already dereferenced it so
> a check here would be useless.

Applied, thanks Dan.

-- 
Jens Axboe

