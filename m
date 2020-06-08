Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8234B2067B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 00:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KPqyMWHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgFHAMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 20:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgFHAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 20:12:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12473C08C5C4
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 17:12:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ga6so5013784pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 17:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2bBx3oE3gryLWooYTH15H8cxF9VXrlwb1RvtH9y7Z+s=;
        b=KPqyMWHkfciBDZTgSEXOHpGN3LCkrHlf/M3HDNSBBRW/GLUfunaR1hDRMwFOw381M9
         Ig2i5htWvMU606ThPuPrTdPIBInX8ZPKk0AXMIt1odNlHb32R6caKpvlh47wjFpwy+mi
         LHgrMEWMEopcrpqKYTf8QolWI5cnAZLp6Fx+aJ/G4CiPyq8TWzn9NLlT8lfzQV80poQ5
         aC7tWIn1ZvThmRNeUOF64xBBRgRuEYsCbpKGLucUnBmgiT7hKq7rAJe3wm2SKnt9FcaA
         OMgC4sqCdyvw8mWPReRTKnF3SFgOtHYBgROoQM0+Pt935pAFMPOADRUjc1TMe8fDPQzC
         17og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2bBx3oE3gryLWooYTH15H8cxF9VXrlwb1RvtH9y7Z+s=;
        b=BwitzpxA/epzyxLiQVPeIBahHQD9wWfPrciczy8md6IRXSwfXpSnkmr70/QU7V5Urr
         T6b+9bYIyjiA+HaehzudwHKSHRL6fXn+rYldy5clPtLt3mSWDru/hHRuMxXIB2igSRIK
         oiP9qdYgkc4LrouiaZ7+CmrIlub9NeO+sxokpX0dRtcgqhwYtepv7PgkkkQ31ZwOrFkJ
         m3Yr2p0/k5f9sfR9ukwOOpUF0pVaBgmFf45TNKt93Um5TsViAee5LIgFklxasZUG3kQK
         K8+SpnyB1JWxxMbCpqNueGE/S1m4p/SJ08AP4JZJBLgLQNjNFJD0F4Uw8sjVdCeMLV6E
         jsgw==
X-Gm-Message-State: AOAM5326SJs1qsxIXVpReFEMQYvYXpEnRGP4ykbJuCjDJUunXFS/9TaW
        1w1iGBURS5YwXbW1b/nz46UNUvij9opJcg==
X-Google-Smtp-Source: ABdhPJzW69he1vfY4B5YhoTgmVyQ0cgXOhFVX/CZU/4m+uzWaEQJ1RUd5JpbdG0VfkZKhGMsfP2Idg==
X-Received: by 2002:a17:90b:e05:: with SMTP id ge5mr14523293pjb.49.1591575140157;
        Sun, 07 Jun 2020 17:12:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id k126sm5293462pfd.129.2020.06.07.17.12.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 17:12:19 -0700 (PDT)
Subject: Re: [PATCH 0/4] cancel all reqs of an exiting task
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1591541128.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3924c8b4-fb37-0d85-b8ce-4183e6fff317@kernel.dk>
Date:   Sun, 7 Jun 2020 18:12:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1591541128.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/20 9:32 AM, Pavel Begunkov wrote:
> io_uring_flush() {
>         ...
>         if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
>                 io_wq_cancel_pid(ctx->io_wq, task_pid_vnr(current));
> }
> 
> This cancels only the first matched request. The pathset is mainly
> about fixing that. [1,2] are preps, [3/4] is the fix.
> 
> The [4/4] tries to improve the worst case for io_uring_cancel_files(),
> that's when they are a lot of inflights with ->files. Instead of doing
> {kill(); wait();} one by one, it cancels all of them at once.
> 
> Pavel Begunkov (4):
>   io-wq: reorder cancellation pending -> running
>   io-wq: add an option to cancel all matched reqs
>   io_uring: cancel all task's requests on exit
>   io_uring: batch cancel in io_uring_cancel_files()
> 
>  fs/io-wq.c    | 108 ++++++++++++++++++++++++++------------------------
>  fs/io-wq.h    |   3 +-
>  fs/io_uring.c |  29 ++++++++++++--
>  3 files changed, 83 insertions(+), 57 deletions(-)

Can you rebase this to include the changing of using ->task_pid to
->task instead? See:

https://lore.kernel.org/io-uring/87a71jjbzr.fsf@x220.int.ebiederm.org/T/#u

Might as well do it at the same time, imho, since the cancel-by-task is
being reworked anyway.

-- 
Jens Axboe

