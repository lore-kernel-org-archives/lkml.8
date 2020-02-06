Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D951C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33982218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OEQQuP4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgBFTwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:52:20 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:44305 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFTwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:52:20 -0500
Received: by mail-il1-f195.google.com with SMTP id s85so6241908ill.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/GI0x8aCVNKIMLzA3XY2pv1luDDrx3P+zazrMcLhILc=;
        b=OEQQuP4ZmetlqILLWOGkdeW5LVUmoD2ikmnLCT1X+EvodvWW8eeb1akQEhgIKZJVJV
         sp16BDvSLgPWbMFMhSiAxLzN1xe5Zo9EpTZ2mD4VNz2Xq+2KAhZAHhk3JY2O2ug8313J
         /tvj7MMynUKOSwdvMIWpjIiCK3NeoLNuWVB07VPlalJMJdiJlFEcVk+lxzzFk23MbEqg
         xXkJAW0m0Jrg0yhDjLwOpURuKPw/1PKMzJkh+bc2JEwYLsRkM9Z5TUhJe/to21lcSXuR
         enAoATaO4KHp4ek6aiqzSRAMpMANDVyTbZAuSFqJ3lMTkkp2IvdhvF8hOQrRCPgoEbR1
         QxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/GI0x8aCVNKIMLzA3XY2pv1luDDrx3P+zazrMcLhILc=;
        b=LYKOT5SjUjlohr46JFcQGodODQCbHgRLPxsZVZqjXAz9mXZUr1xpZVL1ySM4iKhYC1
         wTAOcRBXwYX5D7piuWTNAXeev+wHgphG2KiM2uYlUQra19+9jowj6ZonCtU1s3t6pZ7/
         clSrTuZEga/k6ZrGtli7TMTCe4Rs8WEKplCVogZu+o9gCnnDnnzDOSTU1YW8NquIpWhQ
         M0dAmlVjeK1WKQtryGXrM1hPlTlIEauFKtGlyyatigJzz3k7Wcrk2jM+dU5y1nbvYv8G
         kIH+aq2lYNgoV9KDu5Fgc46760LjcwFziS7GGT05Jq5b3IcRmusFwLft9CrnKZiARU3H
         3uqg==
X-Gm-Message-State: APjAAAWJzdgCpXkLGlT2yiU+0Twymou3wLW6XZ6wSU5bmx7Coz7gIUtJ
        0JFIZfEvFI/CW7MLtjE/9+E1QpktijI=
X-Google-Smtp-Source: APXvYqzDdGbbKaFV7gIifpEe7KdoksmmwNedOy6I9rfJNrF9Dy/F0iM/VqsFZM5eEL5iOyV8EjSzQw==
X-Received: by 2002:a92:5acd:: with SMTP id b74mr5654184ilg.240.1581018738798;
        Thu, 06 Feb 2020 11:52:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm274230ilk.4.2020.02.06.11.52.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 11:52:18 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: fix delayed mm check
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <5c7db203bb5aa23c22f16925ac00d50bdbe406e0.1581012158.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8dbd13cd-6e93-b765-ade2-27ba91d8c30d@kernel.dk>
Date:   Thu, 6 Feb 2020 12:52:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <5c7db203bb5aa23c22f16925ac00d50bdbe406e0.1581012158.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 11:16 AM, Pavel Begunkov wrote:
> Fail fast if can't grab mm, so past that requests always have an mm
> when required. This fixes not checking mm fault for
> IORING_OP_{READ,WRITE}, as well allows to remove req->has_user
> altogether.

Looks fine, except that first hunk that I can just delete.

-- 
Jens Axboe

