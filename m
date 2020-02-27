Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B3C35677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597BC246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Bl8A94Ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgB0QBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:01:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41734 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729673AbgB0QBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:01:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id y17so2469846lfe.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 08:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UETZuQYi2wrMYHp0QoHC7GN8cqT8lvt+bieyv66QGUU=;
        b=Bl8A94EdEQ1ElnCEHMc4osN3MaMMJ+G1cm5ILYH3PZyQbtUor0vyFkL6txmeXuh3cC
         aaM7OzJq8fpPHeWu7rbOaHAxTTeL8q49pKyZqsRmjxpWGPse6eGaHSdYTfdCXnZNNKFi
         qgBYAlDE0pAyH+3UlG6/GCmOUEcIlK+IAKIAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UETZuQYi2wrMYHp0QoHC7GN8cqT8lvt+bieyv66QGUU=;
        b=aS1tF+ox6Oz+isF70eATdTkbricFlTQeiSXaf1bxg5IqAtzBwIHKEtvvhfCwdfTj99
         sn48RUne0iFlT8QRW99un1PyrKDX3NTNuer3GTIeXNk3xVnue9kqkeMvhozLtmf7NFi1
         GGEFFGH/7Qvm0OqX6wL3cANiJ07LRcEh6R/Zw8pgbXz8uYzkNz8P+Hhy5cLNzbUpV3uN
         pSsp6OiIbTm9QpR/avIWsDrHMW/CFfx2XhxgaAQd1kiQPo73COFmlHSugh4AflOeIzwp
         G2yUJYMj5Cw7jTEe/F4gWZRM1EQvcegYr0+7+4AiqoCHi4CHpot7+DYxQKBM0ho6ygMf
         H65g==
X-Gm-Message-State: ANhLgQ0yY/4CmbHZGJJAg6IyFG2smePzbjt/5+Ahq7F4TXxX8YkfX1uG
        ioJu3EW0tRnttZaWuS6f6ruuLA==
X-Google-Smtp-Source: ADFU+vvnKHhEw6e4/4kuTUBAcAha0hKfQTm6h2D4dhw2dabCO3syQJYUlM+7leNeBjMbliqri5tqrQ==
X-Received: by 2002:a19:6144:: with SMTP id m4mr55051lfk.192.1582819277516;
        Thu, 27 Feb 2020 08:01:17 -0800 (PST)
Received: from [192.168.1.149] (ip-5-186-115-35.cgn.fibianet.dk. [5.186.115.35])
        by smtp.gmail.com with ESMTPSA id b1sm4019165ljp.72.2020.02.27.08.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 08:01:16 -0800 (PST)
Subject: Re: [PATCH v1] lib/vsprintf: update comment about simple_strto<foo>()
 functions
To:     Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200221085723.42469-1-andriy.shevchenko@linux.intel.com>
 <20200221145141.pchim24oht7nxfir@pengutronix.de>
 <CAHp75VfR+X6Mw8ywKNW5mTomzmuHSM8ecQUhxtM=LUkWaSe9CA@mail.gmail.com>
 <20200221163334.w7pocmbbw4ymimlc@pengutronix.de>
 <d6c3b369-9777-9986-f41f-3f3a4f85d64c@rasmusvillemoes.dk>
 <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
From:   Rasmus Villemoes <mail@rasmusvillemoes.dk>
Message-ID: <7c43342d-bae7-8f52-d856-694264a87a69@rasmusvillemoes.dk>
Date:   Thu, 27 Feb 2020 17:01:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227131428.5nhvslwdmocv6fkb@pathway.suse.cz>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2020 14.14, Petr Mladek wrote:
> 
> Is still anyone against the original patch updating the comments in
> vsprintf.c. Otherwise, I would queue it for 5.7.

Please do.

Rasmus
