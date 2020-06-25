Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67063C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4432420709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cmep0gkE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407416AbgFYVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407397AbgFYVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:44:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFC8C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:44:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bh7so3380428plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 14:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=74rAvOM4C+wfdNBI3YIbIOX1N2TdkWayq5hI6CuUM2Y=;
        b=cmep0gkEMN/m40ArYj9fJh9v7AM04pBxjDZcWc39mvVwSw0trmaCLYmXMcDeiyzkcc
         czyZPHpA/Aw0/DlfkeI57wNsrK2aN3nP/SiY4ohXB9e7dKccF3dBhRs5O21gqDSfWqup
         GArG8mszuLd3mBPjgcyJl6bAqdHlQg8l/ENOd35nbtg138p0j+IPDaEvzk9xBUpCvByM
         nhU86h33wpkVV5ehKhOgpNJgj09AERitLuF6Xg0v6akISqsN+nDNQmiI5ysmHvXLQgHl
         X3fvoYNOlir1uiJdhz8IS2viJYCrpotjHErPpZR4TEyqAEO8EybD9ZkS3gnddvAsg4W2
         RRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=74rAvOM4C+wfdNBI3YIbIOX1N2TdkWayq5hI6CuUM2Y=;
        b=VTaAz/XFltDKC+CR/Bzk0w1LznaFMTeVBg0gZWu6wXfJM0NK6UACZ631AsMNaqlVr4
         Qk8EL22ivCPP3HJ/2lLz6wOnNuSyFti6OpdzX8DwcRmwHYoCBW30EtrAR1+bKq98yS9k
         RASdHNv/mSFRxboYUzr1AAfPsTmFMqPjvJShZoUCEal3oZhG8sjmyT1HMOwi9sN/caJX
         TsMyH+SL157AhrIElP3t8LQ/CieZvHmqO/av7VNby2Qnfl6P0cui39pMlXEZ8bmt2DlF
         rBAQ4dt3m1apNHL7H+XWIe3OtOOc6AW2nW/+HE9Nx82yDwAv8SfmIdzCMeNYWgtDwYi5
         IiQQ==
X-Gm-Message-State: AOAM532pg+VwnYrl6qeFidEx+t/oimSPMgyPnL2JsJSWksZ057BPEwLB
        gS/9I4ai0r10acrd4aBxjD7dr+dmCRVEuQ==
X-Google-Smtp-Source: ABdhPJx6E/D/8Yhp8Sp3AaHh/xulaBOHcDcxcXdWEp2Jen0Fg+GN5OeUVmVQ/6p0H6n4RdhMLs76pQ==
X-Received: by 2002:a17:90a:218c:: with SMTP id q12mr22138pjc.116.1593121472435;
        Thu, 25 Jun 2020 14:44:32 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id j17sm20263449pgn.87.2020.06.25.14.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 14:44:31 -0700 (PDT)
Subject: Re: [PATCH for-5.9 0/2] clean io_wq->do_work()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1593095572.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a8f4695f-9c80-2577-e48f-b3316d6b5f9d@kernel.dk>
Date:   Thu, 25 Jun 2020 15:44:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1593095572.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/20 9:20 AM, Pavel Begunkov wrote:
> Small io-wq cleanups after getting rid of per-work callbacks.
> 
> Pavel Begunkov (2):
>   io-wq: compact io-wq flags numbers
>   io-wq: return next work from ->do_work() directly
> 
>  fs/io-wq.c    |  8 +++-----
>  fs/io-wq.h    | 10 +++++-----
>  fs/io_uring.c | 53 ++++++++++++++++++++-------------------------------
>  3 files changed, 29 insertions(+), 42 deletions(-)

Applied, thanks.

-- 
Jens Axboe

