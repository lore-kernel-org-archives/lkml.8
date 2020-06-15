Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B689FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853D8206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WC0+Uclu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgFOOe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgFOOe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:34:58 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972A7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:58 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id a127so7883998pfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0fmpVHgGx4khjreuKTold8vL5cDN0j8b4e7HVpyhRN0=;
        b=WC0+Uclub+ASTuwfAlokUI2c9x3YNPa+EttIB2ARu24xCucxisa+JdPUtqfVRPAweL
         l1r0Bz8QA97tQB0SswvZAYJGw7GtGI5K35SN0B8dkeYzLcEwfw7bI6NR9BjQ2WEUyhIG
         EYLPNLzznGZg9auQtb/sI0ARq6rG1jMSj96o6PnA2UgkWjYuy85HeKwGLGyUYem32TIx
         m7mXZrsHAIbTG3+/o+flYK1dkLwsEN2dJY/frUPn8fbQl2lM1yymzYOxzpXhbXViN7Qg
         evt+Y6Av2PBfmH5ri/9T4/Vd06YMpdmwbDmYj5xD4NtmKicPKthTTygxWEPhz/4c3BkL
         S4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0fmpVHgGx4khjreuKTold8vL5cDN0j8b4e7HVpyhRN0=;
        b=LDgPe2esW+nhdGzj1rWPJ/93EOfa/i4+tGoSfYh5sfJRw6hOxF9c0JePFNpeGI9Dm6
         ToRC1GYV+sAO3VJUR3/xzoRv0wozLHCYt+aHb7ZldiQSuNc8v84Vmlg/FBfqiThAm/Yn
         J2rL/b5Fwwle9Y/ZxJG2cbAUK5IikX9QoS9G/ECa89f5Q388v/zh9/39XTFRSvueVJ7F
         TGTWyUSnQXJQHVajSP+RPE6joV9hpel7gHUVp/NRv8aILJ4Mptj6dLkD/yr1bVUu97BF
         UHmDjaF7NHre0cHlDk+MiCeE5OfqvFnq5pHuwyGwtcMnsvpjwgK2V1EwY/0hqh985OXS
         F8Ag==
X-Gm-Message-State: AOAM533qj8/CQt/dynJSpzXGLkI7CAbc/BETZKde774fQilTH4AXVIQk
        WHmjbxZuwwUFVVw98h61lfsdhiCTvrImDA==
X-Google-Smtp-Source: ABdhPJwACsBHHkrY5qNGKynezRmPxPaGv63Bn3SUAcJoXsEg5GeA8nKBqqacn9WdUXyThbDaSow0IA==
X-Received: by 2002:a63:40a:: with SMTP id 10mr22101615pge.310.1592231697971;
        Mon, 15 Jun 2020 07:34:57 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id gt22sm124472pjb.2.2020.06.15.07.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:34:57 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: Remove redundant 'return' statement
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <a93d3ae2b37c01bc1d30b0eb229241b81405e6ad.1592212094.git.baolin.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1fc24b5e-984e-a779-942e-74e61b51f95c@kernel.dk>
Date:   Mon, 15 Jun 2020 08:34:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <a93d3ae2b37c01bc1d30b0eb229241b81405e6ad.1592212094.git.baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 3:12 AM, Baolin Wang wrote:
> The blk_mq_all_tag_iter() is a void function, thus remove
> the redundant 'return' statement in this function.

Applied, thanks.

-- 
Jens Axboe

