Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E565C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF05120663
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z/LMp3e9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731344AbgG1QZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731318AbgG1QZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:25:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C17C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:25:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d18so21394039ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MYT8/3K7R/c49QbezBV5IoadxtpkYqUZBsW74I/Bodo=;
        b=Z/LMp3e9hgnHv/y2/1uciK3aP6hkPDVj/2+kga+pm4sBvwUogma5yUVi7EjxmSiq0s
         y4mmWN0OT92cwabH8ObN26Eqc6Bvq4m+BI7e4nXCq00b/h9A/gavGlUsmj0sBaFkeHet
         jGUJQBGnWgORdiaHk27mg1Efw6KMWcSzTpzGXgQNinC8/yfKrva8LA6PMI4ntPLz/Md5
         cN1YEYjYhm8TwgrM/N9CVTR7aE7/ZVAEqztrMnlIbc+ASgV9YV9uwPIgI34V40N5zztF
         o47SCW6+KLK/qPdCzDAYMhmiY98BPdbUPhrqwPTfMsErfUcD4V98qs8z2amEXizeHX/k
         s2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MYT8/3K7R/c49QbezBV5IoadxtpkYqUZBsW74I/Bodo=;
        b=MuYlUn8YncSy/wsxKcA3TPgiJcZ2G7djW6eDt7qwRoWWeCdWWBGWFAX5P0QRhFdKJd
         HQuEem0uSHWZJhji3Kk7A+HVWGBM/lFYXV0PtQBI0tZQHWz3kR53CoBKNZu2YrAPIPqg
         qBCkmzSUn+75L9yx4vLYSFAJ2yeHL/sH8FcNJCnrt33+6uqAjlvkVa8KTC1meXX9YlgX
         6r7D6VBbKKsD13PLoz9hZfSL0JA1S7p2SDx3OyECKaoXV8/zeSV70kivxUWXwicbKKVK
         iMKHkQcCe3n/sxYG+OFPHzwg/nMV2jsy3rfP1XtKKh/H4WIW7HOzARLeicTVDsEoQm7x
         dy5w==
X-Gm-Message-State: AOAM533v7zF/0u8L4yXhLAeCWN3AK3wb7kQyjTRwcS+B7hdemymLzbNg
        P8e61B5t3cXdsDwtmOyEpze2KWNU7FU=
X-Google-Smtp-Source: ABdhPJw8sHeo47ArDKOoHMnkgkespNRtWnRKYH0up0DtDleqyzXsk3UPU+IsEQ13pvkIrpXiPvGVIQ==
X-Received: by 2002:a02:a389:: with SMTP id y9mr5185167jak.82.1595953542342;
        Tue, 28 Jul 2020 09:25:42 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m184sm6240904ioa.12.2020.07.28.09.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:25:41 -0700 (PDT)
Subject: Re: [PATCH v1] block: Remove callback typedefs for blk_mq_ops
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200728162036.118211-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <edd5e5ce-f389-3416-0d9a-929f1f7ab110@kernel.dk>
Date:   Tue, 28 Jul 2020 10:25:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728162036.118211-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 10:20 AM, Daniel Wagner wrote:
> No need to define typedefs for the callbacks, because there is not a
> single user except blk_mq_ops.

v2 I guess, but looks good to me, thanks.

-- 
Jens Axboe

