Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328E8C33CB7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033A024685
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yGh81KlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgA1AkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:40:18 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37354 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA1AkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:40:17 -0500
Received: by mail-pg1-f194.google.com with SMTP id q127so6044954pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 16:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+On2tA/f8+YdYPWTvyMv08OUAQi3vZn4p7ABbJv61Bs=;
        b=yGh81KlDw0d7lEqifSeG0JkuzitPcS3k3L8txM1JudaN1u5W977obyNTj4DSzVkQAV
         d8veFrIhKya6w37e79V5fegku6Rz2ivJV7KA8ZCCY4cy3aQSA0tOtCvukKddz97RSqP5
         otrQb66lp5X97kb9xUipxQQvtLO2qE8UG30eH5M+nnOQeGcqMxHvjl0zgMik6EbwCGDo
         imz9wO3N5v7MhqMzvRYRdU5TSmlkCwj1tJyIRzrvW+0jO0mbUImx1rYbf1/ljS5m0X5c
         jeFvtTy3mc06oNvQIX4Q5oyf67ekNQ30DI2eJ8c1Ru5b66FjN+1rqRIjRldKOUKSZyMg
         36cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+On2tA/f8+YdYPWTvyMv08OUAQi3vZn4p7ABbJv61Bs=;
        b=CNquV1Ny0UI0uPDg6zAX00TusceSP1QbzJBI1XOtnbyRrzJ8poFKAbr7EDm9VVs4VK
         r/ZH3g8HI/DabSdMdOl0Wsb6Y4eEGcTxpcSlM8FCjakYVfGQttDS/BhQ5J2MjJxGGcz4
         RG07hTkbcV/fMNhy/DxVyXofLSm7myeKWEbyndqmsd+Do/fwnD2laU/i871NprZ2Ndyx
         YM2FJFpc79snWH0Io0piuYVEKb2lSANIloiXj44NDkif7rTWG4QMzE7PxN9WlHPJDcJC
         T1sDwucYMEh9EXpqJMVIUVkfBgNSbtZX0eIkMmlpnp/FtTSmWUkruG/v1YNfrjq/yE9w
         gnXg==
X-Gm-Message-State: APjAAAUyR5b7/uthgMjKTTzFVsQ99/7+fwWIA/eMo6+de2Yz1e5OVhKE
        sD0NV3/eZtCAW5cmz8NT+CdKig==
X-Google-Smtp-Source: APXvYqw/DMu1v7VrWyJz1LLZdBZ0TeXl4k1M2PToZKF1Y53WiM9U9r5NXJ6Qk/ekjAP74F9ERPfSAQ==
X-Received: by 2002:a63:1346:: with SMTP id 6mr22263434pgt.111.1580172017306;
        Mon, 27 Jan 2020 16:40:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a19sm266073pju.11.2020.01.27.16.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 16:40:16 -0800 (PST)
Subject: Re: linux-next: manual merge of the block tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
References: <20200128113851.50161614@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c8ab123b-b984-0024-2727-53d900a0f5ed@kernel.dk>
Date:   Mon, 27 Jan 2020 17:40:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128113851.50161614@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/20 5:38 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the block tree got a conflict in:
> 
>   fs/io_uring.c
> 
> between commit:
> 
>   73e08e711d9c ("Revert "io_uring: only allow submit from owning task"")
> 
> from Linus' tree and commit:
> 
>   9ef4f124894b ("io_uring: clamp to_submit in io_submit_sqes()")
> 
> from the block tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, looks good to me. I'll try cooperating better with myself ;-)

-- 
Jens Axboe

