Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0B2C33CB6
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5392B24683
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 20:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B2jmbkHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgARUqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 15:46:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36769 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgARUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 15:46:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so11387584plm.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 12:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9nGxRoRYyJbnnwOrpQGmTmHPjg5LAsfCWJ/kF5ALD1c=;
        b=B2jmbkHRX/6OAJ3J9TuDRJDwLJP9i+J0xOs/l8MaJ6yLbqPtg+H3sPVxzDvmJfsvk1
         G3gjA2wSOd93b04nIHXqvTZj7lZklbDxngWulRlMu0TY2MrLURgiXzSPZDvbPL5B5kk5
         nbm6SZVXnQJd5+RS9i4fDb77UKUSE0TsP/gH1IJQ8aNVfLHN6Xp3iWgAiDO/fqDhIg5p
         4aoPdYv7lka7KDH9U6RclFBtLoR6DkkxGv/AqcyHgPmY4yx8xhlEop735ZtN70Gfejvb
         RKfuaPutAy+00ct3U2y2okMI9F+dLr9qA99rWvb4TyR/h3eNp8tu5BXl7sv1l7wWx5AI
         ptTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9nGxRoRYyJbnnwOrpQGmTmHPjg5LAsfCWJ/kF5ALD1c=;
        b=EFZSCqZvYAn4/DbLfqtBfLcve1t4QEEWCEcGYD5fY2WFOjzK0mT1+PlGpFhaL0CQxt
         TvtfvWaQ7oTMYiHd3XXvt2XWOZycoZVMDweOMAsHb5Ae7b0lIW+PuTZkSLCHWzuswD7Y
         iCLG/5XLsm49ts394lAjS4/r4pq8+gwW9/okn0mKfaB9rYZyLue7NG5PiuyQdFm7k/+E
         AXHOgz+rCleXZ5nx53vCAXWJlLeq5qPPuDGt3okeVlI5Ti3nirFafU1b7exzxxKirPg7
         mBKMppXRI+W46k1deF8DDaka6v15+gIrZnxFHa3ybX1Ws4UhmCPpehF4UWqeEFSNYLQE
         kdfg==
X-Gm-Message-State: APjAAAVV2gw0CssSVD1IXtjz3ycu5LaUT9Iu80+sVyTpmBk4r85TcuIq
        2Z6fsLAHoYpUwPO8elRl7fANQsvmZr8=
X-Google-Smtp-Source: APXvYqyBGKSzq8EJexVFGiEYgwUBYmAdWpzBit4G++aNEoxZ3QyJwCMlQAsDrYDdeEXAAiq0s4UnAQ==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr14244745pjf.120.1579380377239;
        Sat, 18 Jan 2020 12:46:17 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id m19sm2528305pjv.10.2020.01.18.12.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 12:46:16 -0800 (PST)
Subject: Re: [PATCH v3 1/1] io_uring: optimise sqe-to-req flags translation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <ad7c75c3-b660-9814-e3fe-ef5a3acd7e8f@gmail.com>
 <648dbd08d8acb9c959acdd0fc76e8482d83635dd.1579368079.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7197ccc8-6fe2-3405-c88d-95bcb909d55a@kernel.dk>
Date:   Sat, 18 Jan 2020 13:46:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <648dbd08d8acb9c959acdd0fc76e8482d83635dd.1579368079.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/20 10:22 AM, Pavel Begunkov wrote:
> For each IOSQE_* flag there is a corresponding REQ_F_* flag. And there
> is a repetitive pattern of their translation:
> e.g. if (sqe->flags & SQE_FLAG*) req->flags |= REQ_F_FLAG*
> 
> Use same numeric values/bits for them and copy instead of manual
> handling.

Thanks, applied.

-- 
Jens Axboe

