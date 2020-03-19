Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445FCC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A9862076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hz6uZZpR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgCSV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:27:07 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44300 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgCSV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:27:06 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so1593831plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=THkvoVhG3wRH5Rf7Wp+NLGPc1Ncq257BuilCW5dt4i4=;
        b=hz6uZZpRfTVGX8DfGFDVdm31XWrm9xr3K8m5qSo5BlZxmetMgvaWuGSp9CgEX9GWvE
         GRaQRyNmtGGoteYs0Ydo0fxGlNqlpu1EOQ/Zdj1FQ8xLSykfA1nVbezHr62VG9RF1Gj2
         e3w7vVqidC8S/r9gvZiJMNy9lDyog9OPDXJmUElHhx6Dtifn0N2OXGvwuq2xPbdJ2vXU
         4EMtGQhkodb2L0SiCD8K9Ij+7dlfa9gFqbBmmSdEjNkiTTqNkC64qqx1+VwzObhfrLp3
         HBlTRGznVF8zrGDsCZeaZVWNv46FTT+kLKXmUSQsxXozlUs/RNwjP2s2HZmOfdnMPjbj
         wRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=THkvoVhG3wRH5Rf7Wp+NLGPc1Ncq257BuilCW5dt4i4=;
        b=WIxiBAGjwwi1y5UR08VAnoiVfmvn6RhN0ylsyt6w8o3jBe5a6a5df8FOZP47GQYQ8A
         BhMlpL0siVDf1zxtW6dgYql3QYrylg8uChC+Wu1pe4fX1Q+pWm1pQLK/3aMknrWLe0To
         6zY/Xdj6Nk8OGXAqOcEK/hhQWq9Pkf2XPYXczzX2baCT7X4LXsOtONpw/wDQyFnm3TJ9
         mjQU/27I+EtekoGbZ2WcHd1Iu5cAcervRctwygHM/vNEtvRuie4+hmur2cFhCeuUkLJg
         Ena9Z0oSapcjqOoZEgPzczQkaqNIOAkli+rbc6pc2DcVViTb77DhVP/FzQ9C6kUVnT29
         cCMg==
X-Gm-Message-State: ANhLgQ3JHgx9tVk5WAPs5Pnq6m9GU6+0cO+84uCR8wWRjFMKMQDuyc/w
        YEPJzIGG7whlme0kIol7wSYKjingiAQrhA==
X-Google-Smtp-Source: ADFU+vuapxu3N3BXVbZTrztGZTquP5PU+VMr3dwFAObPJklDp8y3LH9oth1K+gS3kFd/DMsdkGef3Q==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr5264448ple.301.1584653223773;
        Thu, 19 Mar 2020 14:27:03 -0700 (PDT)
Received: from ?IPv6:2600:380:7458:e065:880c:d56e:ca2:e7c4? ([2600:380:7458:e065:880c:d56e:ca2:e7c4])
        by smtp.gmail.com with ESMTPSA id j9sm2819739pjz.7.2020.03.19.14.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 14:27:02 -0700 (PDT)
Subject: Re: [PATCH] rsxx: Replace zero-length array with flexible-array
 member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200212194602.GA31712@embeddedor>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <555096e4-4ce7-3769-f998-6e429d20cadf@kernel.dk>
Date:   Thu, 19 Mar 2020 15:27:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200212194602.GA31712@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 12:46 PM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertenly introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Applied for 5.7, thanks.

-- 
Jens Axboe

