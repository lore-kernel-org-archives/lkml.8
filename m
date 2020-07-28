Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A8CC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA66020792
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zRqLODBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731282AbgG1QNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbgG1QNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:13:08 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA1C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:13:08 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z3so6432879ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 09:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNCg05tz8T72EfbSHUoOieVHqqb0riUeyvEBdt6ssUM=;
        b=zRqLODBQdmGL+KkPjeEEQSogroxZboQc6kVDb/r8scjUQ6sGp2YTamenSoheM1wlLf
         nA76+rvaUPd7MDUuJ1LHgS+mtm00OI7G3gOCgKPBm1eF3MVGMnl+BbIG0x+OlItmlQu7
         VAilduQlrQNaA6sFrnqTgaw7q0Dgl2sx/uPSKIhTXag0Z68ccFn7crG9fWf1m+JHlIJW
         yWVonxz6q8KBdNxKRLPxp7+315BKGfTxF+dBHu0sHutbBdqivmUxoKbxYU07jReMfkFn
         MOpK1aOnBU7aAzMkod2ic1D0bxeWFBv+l+ul7e0zuIXUOmcoNdpE74V5JhKnUS0rsK1P
         QHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNCg05tz8T72EfbSHUoOieVHqqb0riUeyvEBdt6ssUM=;
        b=YgPYtn6t9qjBNeSDvnVy+6H061qYd2g/VF3V6genDGj8EzlnuiwbCRz+VoYc6uY0qL
         LzSL8Jlklj8FzvlvoDfsRVgi5o76lGpdPClvefjRanFesSpGvAW+4pd80byDdXUwkVh7
         ilBeDqA4rm0PlCxtJaMwJDPBaaHeiYK9l1errPe9eco/rUOJqaq2ZNIahqEe+ZCxBq8r
         wi7BVqXvO12H0Tyg2TmnIWSOWFVAGLnv70hx24WgfXfJSgxmYmI7D4x2iBlM7cAuBVTz
         yWhofDXnWCp/rzMB9OumA/QA+qULM40jlKwmR3VHFYdWsQcG6erVfuWBAQLd/p3MO8Vk
         +w/Q==
X-Gm-Message-State: AOAM531qv3WpWjBbePef7ozmaFLJjZTotiAIEj8weeviQKwNa74gAVx/
        HF93n5z4oh48LaS7qUc01LioYUH7BQc=
X-Google-Smtp-Source: ABdhPJygWd3DZFbqrmNj+NlTJncfFZ4Jk6PoWI5sJWANGD2rMWY5YmMV6WXHLsnjoXhITX9avqgECg==
X-Received: by 2002:a92:b112:: with SMTP id t18mr20855664ilh.172.1595952787893;
        Tue, 28 Jul 2020 09:13:07 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 4sm10149248ilt.6.2020.07.28.09.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 09:13:07 -0700 (PDT)
Subject: Re: [PATCH] block: Remove callback typedefs for blk_mq_ops
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200728160506.92926-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a26c550-934b-a188-b910-3d21d006df41@kernel.dk>
Date:   Tue, 28 Jul 2020 10:13:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728160506.92926-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/20 10:05 AM, Daniel Wagner wrote:
> No need to define typedefs for the callbacks, because there is not a
> single user except blk_mq_ops.

Concept looks fine to me, but you're mixing indentations a bit. Just
remove the indentation bits, we don't need them here.

-- 
Jens Axboe

