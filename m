Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA578C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70BFF21924
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 21:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hqt0SSyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgFSV0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 17:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgFSV0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:26:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D09C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:26:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so4986996pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QSzhATSJQqGXU6Y2787gKy3+sN+zFu9Jf8f0g/S1D8Y=;
        b=Hqt0SSySMvMvNZInhOx5cFzCSbqLC1PYFsIfiyXWNdZZNWs0KzmDR2CPLK5VvQhX8V
         KC8aKlcTD2OKiFJHGn54ARCkgomQ4naEa4BKsNBOCADxNZiDNn/QKgacPeU2tWe+XT3Z
         yumzQGs7Eecl/V5fl8DW67M/lYc0tKu5tiXIdDzW2p13iPsyXBDhBWdktepOQ5qzjJSe
         Gv8nvTrZcL5WiTjp+eMBvltY4HOiJYIixGqNZr1MUgt8KbtppPDc+9SZwoSluDIsApgr
         ox1UR5hDoGQ3KgUoWLornB0tkG6204Vdfpf7lWuA+fVsCMY5lzZsVEn1ZSAXyerJWltP
         0p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QSzhATSJQqGXU6Y2787gKy3+sN+zFu9Jf8f0g/S1D8Y=;
        b=Ch7AF3fRaeRNMIoLvfI/7IEJdzvpHcSvmSI/qMZDjjEOBgNPnmJdKAXDQH3z2AYHcv
         avEyQItBn67zQud9lmFlYgJ3m/zvTjUBkEmckBgby7sx0rjdQtHRZ4XLeqz50ymhftia
         484iEli21HDHxINPSQj5MPg3tqPjlIFYQebtNqiHmYOHOtuElceMQtSCsv+vFLxGtd0n
         9rp4pjnAusWTXsJCE6VrGZWklkXwngDwwTevFu3iLRUWYN6a47BTdwO3TwNRofzDo6Y+
         WTN9pe5tVHBT8GgWHPEuYN4sFUpEziEsdqC8RfqcIYJQ6nW71TcCUpM9kpkZ59zig1cD
         iPFA==
X-Gm-Message-State: AOAM531sghJ9E0UtRJQd17/F2NkIcpHS3sictiE9u8RpOwS/0gxQj+Sn
        dfVh+2vlms2+ENMEYeem+q4w2w==
X-Google-Smtp-Source: ABdhPJzKnk//wsXKaR5BlWqfWUV5pAJqs5Q51T/U8j+Q2TEUy5bP8NxGb0Vv684l3gcNfhBUtw6J6Q==
X-Received: by 2002:a62:804d:: with SMTP id j74mr9776645pfd.233.1592602003162;
        Fri, 19 Jun 2020 14:26:43 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id z65sm5718544pgd.79.2020.06.19.14.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 14:26:42 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers: cdrom: fix all errors reported by checkpatch
To:     Simao Gomes Viana <devel@superboring.dev>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
References: <20200619180834.8032-1-devel@superboring.dev>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f1dea27d-9262-f818-20a2-e77098dbb27f@kernel.dk>
Date:   Fri, 19 Jun 2020 15:26:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200619180834.8032-1-devel@superboring.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 12:08 PM, Simao Gomes Viana wrote:
> This fixes all errors that scripts/checkpatch.pl
> reports about drivers/cdrom/*.c and a lot of warnings
> as well. I skipped warnings that I don't know whether
> fixing them will break anything.
> 
> Before:
> drivers/cdrom/cdrom.c:
>     total: 118 errors, 126 warnings, 3794 lines checked
> drivers/cdrom/gdrom.c:
>     total: 0 errors, 16 warnings, 873 lines checked
> 
> After:
> drivers/cdrom/cdrom.c:
>     total: 0 errors, 38 warnings, 3866 lines checked
> drivers/cdrom/gdrom.c:
>     total: 0 errors, 3 warnings, 882 lines checked
> 
> Test: scripts/checkpatch.pl --file drivers/cdrom/*.c
> Test: make drivers/cdrom/cdrom.o
> Test: make CONFIG_GDROM=y drivers/cdrom/gdrom.o # partial
> Test: compiles, boots on 5.7.4
> Test: CD ROM works (tested with Audio CD)

Let's please not do this, it's a lot of churn for zero gain.

-- 
Jens Axboe

