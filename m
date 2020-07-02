Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7780C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD752071A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 04:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vBIn6A3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgGBEHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGBEHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 00:07:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1836FC08C5DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 21:07:43 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f2so10757972plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 21:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GAH6ryWr1XYB1ggxji+dhT1fSzyaM2fT6l3rS9nVfOY=;
        b=vBIn6A3a9VGvi55v0oucV9eBYHiFBsqeb3Faw6QREovl8TYoCO4p7A1Ggr/lHFb+k2
         hTzCEN9Df/pM0NHW5t40UHVsOUsXdbrv+G23qOWugZqZgpQmIZN/mmL1pguPoxjzIG0N
         H8h2dUYUxv+01VsiSNNQB3WVzGI7piLrj/EMJB9dq0q59bkmDIcYPgy2IlHqo61Kcpce
         JZmVrGkZlHwTUNPpgOo6Dn29MGkzRurSMp1yzHLHEDOqV1ktwIMcNPxI5oD5EsFTk9gr
         +/EQPubzBjQ0VMO4O22g17fHI2gtqkLv18NE9frOFoAw1hj4uK+11PQ4YTgOTtHaAJA0
         UY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GAH6ryWr1XYB1ggxji+dhT1fSzyaM2fT6l3rS9nVfOY=;
        b=P4Xos1W2VTy2KbO3eTfZvMyGfyZyFAXr1Pnwq7/YuSC3YmbpAeY0x7sFNnQgoEecGg
         tPg77lLqqg0pOssD2J4HifKNbGO/61mLqY5VKWef8FDo4wUTjGFt5O09IpQNMq3K2QdT
         YiWpYcEkxGv51PgDzgahbzVm6roIUz9MOo2ZU6gCtJvog3E568Z4vuE5mTAbpYJpNFcY
         SS7XlVC7FmmLH08RqC9FV/SKwRg1y/7PhW9ee/NkJ8Xr88SZeM0G1UpQQUEcd9l06Ykx
         zJDApSApx67vUWMW1vGBGF3QKkXavO2cmIxMTYgAyHTU5HlTq+22uubCRwOgpzpbF6lh
         0yMg==
X-Gm-Message-State: AOAM530ckADq5XssknPmJ7b6AVhjSLy2m3r2MCqpkL+2aygme3fAjgaD
        lZ5qvN+9H5MbKlZ71bPXv1as3464hPd2Ug==
X-Google-Smtp-Source: ABdhPJwJTXbS28eFnzRkeoeKnTOqsgZ9d9rqynQb+L2B85/DtTwJZBxinj5ZDG6SLIPXUQaYDnn5JA==
X-Received: by 2002:a17:90a:b25:: with SMTP id 34mr29072875pjq.220.1593662862472;
        Wed, 01 Jul 2020 21:07:42 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b0a2:2229:1cbe:53d2? ([2605:e000:100e:8c61:b0a2:2229:1cbe:53d2])
        by smtp.gmail.com with ESMTPSA id d18sm6448347pjz.11.2020.07.01.21.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 21:07:41 -0700 (PDT)
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20200702112112.04d3f992@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5f9ae650-9e3c-e9c2-3bc5-d7afbdee778d@kernel.dk>
Date:   Wed, 1 Jul 2020 22:07:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702112112.04d3f992@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 7:21 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> drivers/md/dm.c: In function '__map_bio':
> drivers/md/dm.c:1296:24: warning: unused variable 'md' [-Wunused-variable]
>  1296 |  struct mapped_device *md = io->md;
>       |                        ^~
> 
> Introduced by commit
> 
>   5a6c35f9af41 ("block: remove direct_make_request")

Thanks, I did fix this one up, just haven't pushed out the updated tree
yet.

-- 
Jens Axboe

