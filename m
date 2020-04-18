Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98EC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B3120780
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 03:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vDno9PVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgDRDir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 23:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRDiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 23:38:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCFFC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:38:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id hi11so1228598pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 20:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I4TH2XxPoRqCQAiVceMrJ6JF2Ars1jAhN+GkKLq+qBA=;
        b=vDno9PVLultcm6YIs0lgt1nHx8S+GaUz2rUcccr2W+TcwDwEU06i7IFQ6I4FamebXD
         phJTlHBda+hMxHcxYHWBYgZeCPjbDYetGVDyFzosCtx5Kkm0pbH6cNvXYSJtINDqJV+X
         c3L+ZeP2HXsJuA9wEK3GRMWt39segDCz7I8GCMzYBaRUwPwuM3drd4leZiDbOMs3hyiq
         tFFbp+eZEv16CUzpFED47BkVxtMalx9qV1aUp1lkR36Pj3kk6KVt1RR61U/TxSdRwMg1
         GwBhcrimkOAEsQNynzGmMyIZooleRS9aES8XVSbSMmA4LiOS+YOC/AMbyzKHwa59jLLZ
         fgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4TH2XxPoRqCQAiVceMrJ6JF2Ars1jAhN+GkKLq+qBA=;
        b=W4cVZ7pca+LfzlkRl3FeG0m+UmeB0HaXIZ513N4/dbdaBt0Uqs/IwNvcGu7Yf14/NV
         lAnKjo0faeNN0yC68dncidwSLo2T8hsKP0LbSRi/enfzrHmxJQoQl8AjU48NmO4qXQiJ
         MK/KSU+ZI8MG7uxi3ol6UAzt2XBUmhMDTChG1SAW3fSA4lZm4D2r06Y3ACO0Uw8Dx5ZT
         h2UH0x6Q00C27WylLS6+53ZuPccMx9vUe1pOcydcz23NOr+cHrTEr5/MwonrXGaBJiOx
         8HUMzwIVpLSErgRBB38m9Zmz0U0M9UeuLRwcmuncZ4rZmcnXVxYtxckIDD6nalloYU2a
         GNpA==
X-Gm-Message-State: AGi0PubsIn67m1hKkfd+i/bv/qa3kJ5Kud/XtXRyN9BfvnbLPQTGz67z
        GHsRO3OvY5nC/SBgnm3AJtN+nA==
X-Google-Smtp-Source: APiQypLVBWWqIZPFDHrZdz3nEmonR54iAxMsEDZEg3slo2Uc8dj6KskFX3WRuoEZhT7ee8FI9ehJCQ==
X-Received: by 2002:a17:90b:2388:: with SMTP id mr8mr8078215pjb.107.1587181125903;
        Fri, 17 Apr 2020 20:38:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v67sm17068790pfb.83.2020.04.17.20.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 20:38:45 -0700 (PDT)
Subject: Re: [PATCH] buffer: remove useless comment and
 WB_REASON_FREE_MORE_MEM, reason.
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, viro@zeniv.linux.org.uk,
        rostedt@goodmis.org, mingo@redhat.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, tj@kernel.org, bigeasy@linutronix.de,
        linfeilong <linfeilong@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        renxudong <renxudong1@huawei.com>
References: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f8fb1248-3e92-c1da-88c5-bd6220d1f3d4@kernel.dk>
Date:   Fri, 17 Apr 2020 21:38:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5844aa66-de1e-278b-5491-b7e6839640e9@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/20 11:12 PM, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> free_more_memory func has been completely removed in commit bc48f001de12
> ("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")
> 
> So comment and `WB_REASON_FREE_MORE_MEM` reason about free_more_memory
> are no longer needed.

Applied, with:

Fixes: bc48f001de12 ("buffer: eliminate the need to call free_more_memory() in __getblk_slow()")

added.

-- 
Jens Axboe

