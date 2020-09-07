Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25799C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE64F215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0oIyF9lg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgIGQlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbgIGQkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:40:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FCFC061574
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:40:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j34so2863313pgi.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6vHcZZanU3rAkmAGGDrYACgZASD38A91RFONlbR7rWU=;
        b=0oIyF9lg3hdey6DU4s6xnkQ66QbEgpXYGczJDsxGnhsac/QQ9G9HKdqxZdB1I6kC7Q
         P3M5JLFz2UFybQWxDr3EbonIO8i+RpFXmks9Uhd6vBgEfezjLB1oB/TJt9vL6VDSoul8
         aLG8X9T3080fCaQY3QZ6OSnQDAgT012eyMXBQVSEXMJLtY7Ru5NDq8lJY5juAXx9mxTr
         7noINJt/NsbaGkuhV5xLpiP86qSdQUhUwc+4UIu27uNdGCL5jQY/Mss9g89iU94lQeXQ
         m7Sq06oW44KU5vQz67ZRGPAEqZuMFdb7yZRs+xHIEj+xWOGtBteYpvpkzi9lS4acIPqe
         T2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6vHcZZanU3rAkmAGGDrYACgZASD38A91RFONlbR7rWU=;
        b=E5noqdVFPNl4yRnub3v/tn+A3t4syguAxTs6sCbek0wBeXkB1CPQICc7+xg5p1yRKe
         tPPGq4+hBmAnMl7jzxbd+7zdQf0XPk2TVRoHuSGtdyPyaeFYN3/shHIYOIZXWeROlg4A
         wgSvYS0GN7DCzCDaGthFy1LIc5ORrrSXnkCIAK9Cfsg2bDyALsI9JLpmiW2VVIkQWcNy
         3lAzDyRHMPd9dflBcUHtDjARnNFnIBvQSQPDPHvLvL0gJbWt9E34E/v1Mcms6xLdnZiP
         Y1vdQPHBYZcDO8ffZSf5ogYLPdqvDIge75PQACjRRmmm8TUqFretORK4meS5c232eyff
         7B+g==
X-Gm-Message-State: AOAM530+Sas+V8YO32CL4e3Qr4hwMrEB0Gh2QJgfnFzQZPnF9LW2Iag7
        1OY6a2fdlbdB9CEaGv9PGP/vCgNK0dKJvvbC
X-Google-Smtp-Source: ABdhPJw5h0jlKb7DuDqBJNrm9qpQKwJDEVMdJVF2jgaFvPBoYcM70TZzsoQzznZ3s0d3GUxC/OCzkg==
X-Received: by 2002:a63:4c11:: with SMTP id z17mr17026781pga.152.1599496840635;
        Mon, 07 Sep 2020 09:40:40 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id s23sm12706228pjr.7.2020.09.07.09.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 09:40:39 -0700 (PDT)
Subject: Re: [PATCH] block: Remove unused blk_mq_sched_free_hctx_data()
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, hch@lst.de, baolin.wang7@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0b736d64c0546c292ae8f1bcbe9d801c28e12583.1599467604.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7d40447c-f30d-a977-92d8-f82d1789a91a@kernel.dk>
Date:   Mon, 7 Sep 2020 10:40:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b736d64c0546c292ae8f1bcbe9d801c28e12583.1599467604.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/20 2:36 AM, Baolin Wang wrote:
> Now we usually free the hctx->sched_data by e->type->ops.exit_hctx(),
> and no users will use blk_mq_sched_free_hctx_data() function.
> Remove it.

Applied, thanks.

-- 
Jens Axboe

