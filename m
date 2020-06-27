Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD307C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF020773
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="02bU+Pn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgF0Bql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 21:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgF0Bql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:46:41 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E8C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:46:41 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g67so4864661pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+Fl9/p1pW4eUsRcsYTl5NIgKHt8gl0+TvFzz5VvaK48=;
        b=02bU+Pn/U9ExWgoSYMuYzng1rROORWUAolR7MWBBnPzMdp5OGdRuG5DfpyJATB2ECo
         vFEY0zZK2CX6xhnPWh/iES6RV7WanH4Uvs8bu1NfeHManbNCbzKn1as2nrMhqX0neuzX
         VJDaX9xDPop7GRsA1Z60E9xOekxfiC1UOvSEpJH7OUBUNMpjFggXd3XEQb3YstM4qa1V
         QNzo+wRxiDMVyjE+On/9To5hTVwsf1GVSysy3V2JukU2d8BH+1++OW533NAiMzy8lX3f
         Iwroe38ZLsyuvAp2EbSMF+K5oeYQwvo9sJ5B07VnQLLmwLk1RnIZ7V9pOXDd1v/gmUfJ
         bgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Fl9/p1pW4eUsRcsYTl5NIgKHt8gl0+TvFzz5VvaK48=;
        b=FJtUWIBpBYzXzcrXblWXnVoLevE0BiqzlSqEGnHefI6KqBh0hzlH/neqtoG2ysGQKW
         P+M21oz5622KkxvgWI7W5RYZkhEMDnOimuW9CvZv5qUnzGmSNbsEctjM1UNM1lEvIq7l
         0zryXUUpZqS3Vre3bHqSQrtHc2nFniI3mMRdMneQ0u9XyGPc+JlPHaRFYv+t/XGA+F1V
         RYI5OnWUrJd3wzY7KIMEMUgbE3Iw70fOB94Pdz2vchP7Wlw1gauRzL5flViyQq4Zi9ao
         hWF2AGu4D+r71OImI2GP+hKWnLDBJCdsCGRfahi3hpK0vr4VuR9XSfVtmAAsxKBLeAsr
         3nlA==
X-Gm-Message-State: AOAM5325vbGtucnuW5Z2uPO3gEwuHA8PnFmy8B2QyCfG0HWj8mDxLzvS
        /TLo02pd0qTeJ6OoAveUaU3loA==
X-Google-Smtp-Source: ABdhPJwWUwo1S3UflBqAZv2/EMg+9BAisj8FqREik2ihn9oKFVy2QdvHCEl53TXgSjSli1j/tVIywA==
X-Received: by 2002:a63:3c41:: with SMTP id i1mr1400088pgn.349.1593222400583;
        Fri, 26 Jun 2020 18:46:40 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y136sm27334607pfg.55.2020.06.26.18.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 18:46:40 -0700 (PDT)
Subject: Re: [PATCH] io_uring: fix function args for !CONFIG_NET
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, io-uring@vger.kernel.org
References: <c3db950b-9062-11bd-97e4-afe7c9bf2f27@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bd3919c3-388c-7fd6-e03d-9c1991b089b7@kernel.dk>
Date:   Fri, 26 Jun 2020 19:46:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c3db950b-9062-11bd-97e4-afe7c9bf2f27@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 5:32 PM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors when CONFIG_NET is not set/enabled:
> 
> ../fs/io_uring.c:5472:10: error: too many arguments to function ‘io_sendmsg’
> ../fs/io_uring.c:5474:10: error: too many arguments to function ‘io_send’
> ../fs/io_uring.c:5484:10: error: too many arguments to function ‘io_recvmsg’
> ../fs/io_uring.c:5486:10: error: too many arguments to function ‘io_recv’
> ../fs/io_uring.c:5510:9: error: too many arguments to function ‘io_accept’
> ../fs/io_uring.c:5518:9: error: too many arguments to function ‘io_connect’

Thanks Randy, applied.

-- 
Jens Axboe

