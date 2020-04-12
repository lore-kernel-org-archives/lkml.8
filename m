Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA61C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 15:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04991206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 15:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O5Ue/2t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgDLPaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLPaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 11:30:05 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 11:30:05 EDT
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE2FC02A1AD
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:23:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so2537687plr.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RTj0VEX5TNqzrqwsQNvi0lYaU3YprHALdXBJBp1u/JI=;
        b=O5Ue/2t4RngZU62hTmQrNo88logu66R+UrpS1WoZBldh2oQE18EqtWNa5URxBY9F6b
         ttLZvyNe+Sedp8nK8f2ytarB/uAtDiKbO5jZ5CZuODbxP532IQlYl5twFsnA7n5qhrBQ
         GxYxBRr67aHmShmrmuyImH67C1swvFPkRqpwQcy5Tmu35pt9AbHOfw6syTaGpW4WBqmM
         T0wQAobQY2U+48OxHck2YqCcZQ4r+1uA+g4NqzvcbMuH/fpdx4bGGSlFSrL9YED9IRpi
         Ppr5+D3+IOhtVGzdC08j0yWYdWOab0tVdy8dB2zjoAhYVkydt7aH3VlCsKmbXeNTVBTS
         Gt3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RTj0VEX5TNqzrqwsQNvi0lYaU3YprHALdXBJBp1u/JI=;
        b=i0L/fF0pWIovP8kNdNhnvn0SXkqnr47O2nbjZPHx1vwxnp+HRROs6med1mNi97FCVH
         OWRaA36LqsXkpG/SFi5ah3D1APIEqlhzh+9lZq1CZVubyCQC/+eraD1tm3xUwG6wccxK
         2GrykjlPPik5R1OaHoXddvSEtq/7trBvFBnZK4AuBVUtBRpyefe//MiH63M4Hd6Wc0pa
         cmCbhMDr3iGwXMeYKJk8svaktr+IjtyywOG0zWNQUGPZxZ+NCQCmnIXj3SB8FMB90dz1
         K3ycsIeoPVZDzF/9DK2bJvAA6v6Mf9BxwdU6sepsUKrdo1peXYrBLmu3/4LJ/Mc/4RgQ
         cptA==
X-Gm-Message-State: AGi0PuZfuZ7Tkqjtuqf0plUAULvkDZbKDzWirkatWYMbWpiwV+iIPKch
        dljMQtZmf21ZYDAwCsJWoPRiNi+iyVNM7g==
X-Google-Smtp-Source: APiQypKB0lpn8rFhNs5oVR4P3kxoprX32HoiM0wISUKUdvUOemY0m4maLN7a6x7QKaVt0V79QuZthA==
X-Received: by 2002:a17:90a:3343:: with SMTP id m61mr17721046pjb.112.1586705001312;
        Sun, 12 Apr 2020 08:23:21 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id n21sm6152771pgf.36.2020.04.12.08.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 08:23:20 -0700 (PDT)
Subject: Re: [PATCH 0/5] submission path refactoring pt.2
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1586645520.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <774f0f44-d6d8-6a5a-4808-090f69781e4c@kernel.dk>
Date:   Sun, 12 Apr 2020 09:23:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1586645520.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/20 5:05 PM, Pavel Begunkov wrote:
> The 2nd and last part of submission path refactoring. This moves
> request initialisation bits into io_init_req(), doing better job
> logically segmenting the code. Keeping negative diffstat as a bonus.
> 
> Pavel Begunkov (5):
>   io_uring: remove obsolete @mm_fault
>   io_uring: track mm through current->mm
>   io_uring: DRY early submission req fail code
>   io_uring: keep all sqe->flags in req->flags
>   io_uring: move all request init code in one place
> 
>  fs/io_uring.c | 196 +++++++++++++++++++++++---------------------------
>  1 file changed, 90 insertions(+), 106 deletions(-)

Looks good, applied. Thanks!

-- 
Jens Axboe

