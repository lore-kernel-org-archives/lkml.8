Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FC5C352BE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9820E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="laMZ5Nan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392578AbgDOBaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392569AbgDOBaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:30:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BC5C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:30:00 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e16so5783923pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 18:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=tw1ol9hIySF4SEjxnV31z4ZCVunCJuhUBUf/qto1qDk=;
        b=laMZ5Nan8iiNRpSb5q9KzmAhNq0103cgg0P5iWhae9Qsi/x3SVW2rFTff9y7AW73lo
         8F4fnFznO5VZOoCeCsX0mzLIUv89kNsfmOe9fYYqAub8BAo8aK4+XqBPPmYJOc9kBVPh
         3qYGgpDN5IPje/dughVgunhVwLRxi5cPfgL4ff8qxCYQK2icVh3o0oKs6ZpmyKDmgXWY
         ++NWG2mxot8LQD6vDjumovPtdoI88EPTBUCqMvZvDJ/VEzK/I6HiPd20caCi1hWE5/PI
         Et69wH51qCxh34ySRwZ8ziSniRw9A/3r80jRSi8eHvjhRM0V0bdMKH9DWKVZLUwk9rrm
         dytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tw1ol9hIySF4SEjxnV31z4ZCVunCJuhUBUf/qto1qDk=;
        b=FWf0hKg7acdUnvcgSySIBr3IY+kxeESFTKgCQqyQktRRSU+PHnivV3fJ21OkXlEwxP
         mN216MEnlzN5kRuWYb1X5I3+Aqppc0q2e4QbULHzLuQathLhW6RISEYAfkFp88J19xZM
         QIafGtYx6YtpLAoMUGhVwLIt8QwpJNlAbUiK9onav3OuZ+vQ/bPHy0EZfU/Zhnev3u5+
         BR2LhDzXW7JeRfWWYYWSZxUHPzsWJLpKpsyV6QatIqPr19N5KByHfdNmB4f9zOUNggT3
         z866yaWnFvi9KN2CF7OU1Y62unXwz9zjXgql3zb19aAbKoNifFnurNoEQSFJPTiQ2R34
         t/xQ==
X-Gm-Message-State: AGi0PuZYO99iILH2paDw27YwblcoGzC8QoG8VrFVlw4egG/YYEr1jquG
        wetZV1GmCIZ5Tw2fkak5sE4zDdwO6CTkZQ==
X-Google-Smtp-Source: APiQypKse0Vw4MTAK2eIDz+rkZLvUptgDnRhmyWoFDYLfNVx8BAvRbQCsJSge6k3bnsrPrr5WcPaSA==
X-Received: by 2002:a17:902:8487:: with SMTP id c7mr2378462plo.251.1586914199821;
        Tue, 14 Apr 2020 18:29:59 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id y9sm12551095pfo.135.2020.04.14.18.29.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 18:29:59 -0700 (PDT)
Subject: Re: [PATCH 0/4] timeout and sequence fixes
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1586899625.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ddcd1626-83bd-3d25-32b9-d2308ba9b3ed@kernel.dk>
Date:   Tue, 14 Apr 2020 19:29:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cover.1586899625.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 3:39 PM, Pavel Begunkov wrote:
> [4/4] is dirty, but fixes the issue. And there is still "SQ vs CQ"
> problem, solving which can effectively revert it, so I suggest to
> postpone the last patch for a while. I'll rebase if it'd be necessary.
> 

Thanks, I've applied 1-3 for now. Looks good to me, and also tests out
fine.

-- 
Jens Axboe

