Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C482087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bITux9EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgIJP6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbgIJP5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:57:07 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEA6C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:56:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d18so7591824iop.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=bITux9EFWpfNdlM5j2+5LAzN74905Ih29yvwShF2RYD0rdrq4WVzARSbVJuvSmQPWY
         j+to5gM/LtwviynJuV6Xw/wsJke0MBYGFTvqAsfHMn62ENDQNHKZLFd0IqeGy/YXQAkv
         VzQea9i8kja5dzDE6N1RmEiA7mq7G6VZefYJanQOq9PYYyXW+7SVTKtT7DLY3JQQ6Yaf
         +LznXIrys7f2IeFYvBnmS1Ki0TO452S54+EFTgcsHoySCF2Om2MslpGe1shaUybTvJ4Z
         NYXD4pbGxmghN4rFbQnUMh+SSZHjhXFnidMaDDjLyfrIe/7fFBBzJAix6vpXnIjh1sFh
         cB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lw00I39tMMHoHHOPSgKttYErvt005RuGUQAb9q20a8A=;
        b=OdCIXzsbPbRezNCCnN8ctjvlpsjGjli8vFpvW5Sm0z4RS0WFwf1PiQ9Muzo4VH+WZG
         qg+jd46+s4IEU3LLn8BUtfAahclTTjNvgkDpWlPIC3EPcoN2XmUcL/GzAUiwzCALPb1o
         yrYHYvviZHja3Q4br/PVMGV5xpga4V8XcVQONPF9wZ5Qk9Q7swiUi1jTaTyu0SzbUXtm
         5bA8OOmcO+lBAEMT+0nxaBBOohT+MyjOFwaycGAAcH4IaFZ8ahMoMopbbbqMX/Fw42ew
         /Ego1RLk/LkDFBMLviDUrHGHnCDEphyn3ckU0zrazf5MZquovcuIGen5YpRsFOoxkZeE
         f2/w==
X-Gm-Message-State: AOAM532tUTRVjbpwijEed7stbvJ3w/lFqMjo22teq+ZMl8dHGD74JzAB
        7CW7ms/JTU+llrj0l7lgdNSj8FWj/krl0Hyk
X-Google-Smtp-Source: ABdhPJwLFvlr74/NHaaMQeIpR+L/bjIZVmaEteWtsH6Bm9x6kvp/ngajFsz8dvwqEASUe60lfJ+Ljw==
X-Received: by 2002:a05:6638:1448:: with SMTP id l8mr9177707jad.83.1599753418617;
        Thu, 10 Sep 2020 08:56:58 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m12sm3225470ilg.55.2020.09.10.08.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 08:56:58 -0700 (PDT)
Subject: Re: [PATCH] [v2] blkcg: add plugging support for punt bio
To:     Xianting Tian <tian.xianting@h3c.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200910061506.45704-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2bf5a5c3-1f1f-6ed1-8871-6e9d3e7b80d4@kernel.dk>
Date:   Thu, 10 Sep 2020 09:56:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910061506.45704-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

-- 
Jens Axboe

