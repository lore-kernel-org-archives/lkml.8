Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD14C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B68EB20885
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgFDR1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:27:37 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:44781 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730094AbgFDR1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:27:33 -0400
Received: by mail-pl1-f176.google.com with SMTP id bh7so2449364plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:27:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oYETd5pTvMjyrqMMeca4qBiA8fLq81fGMtTiMQ5fNGnlk/LMCZyh0bXw15U3VN16nQ
         Z7VvNIjHXYiO/RedWSG4bOp7yxLB7PvMdTLPcFBxhTlp9zfCrGvkpq6/f0M7ZSgPQl1b
         xtfamPpOzT0kjoUocTt1KETZ3Jkp6ntnVGNXdSr+Zti0OAPRiEONRDQX5KIjS54mPlUP
         F3yFPh7XU2UlCDsIgC2MU/KAWGx95mTffkml1P4XLjiEwygnbthRM0w73YrXnFbtwjHo
         SEwFNrl3QvPiyiHQs24d11EG612zc+ThCpp+5I6WuebT7ig5csZEqkIGSUcbpJO5qM/8
         3j1g==
X-Gm-Message-State: AOAM532Suu21/bs+m8jYxMKeVtcb6ZKq7n8D1Pap1AEkIIBvXtNl+av0
        Qj3OhkwB3ICeAVWW7eRYOjbqduseUHI=
X-Google-Smtp-Source: ABdhPJyL1tI+b1vr9SFtcOlyLvpUW6La/YS1cbA4aTDXYI3JZ9EphShAM8mb/RuISC4PsFwWDGsrZw==
X-Received: by 2002:a17:90a:9f8b:: with SMTP id o11mr7195069pjp.179.1591291652516;
        Thu, 04 Jun 2020 10:27:32 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:35c9:507c:6c7a:323b? ([2601:647:4802:9070:35c9:507c:6c7a:323b])
        by smtp.gmail.com with ESMTPSA id n189sm3102183pfn.108.2020.06.04.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:27:31 -0700 (PDT)
Subject: Re: [PATCH 1/1] nvme-fcloop: verify wwnn and wwpn format
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        linux-nvme@lists.infradead.org
Cc:     james.smart@broadcom.com, hch@lst.de, chaitanya.kulkarni@wdc.com,
        linux-kernel@vger.kernel.org
References: <20200526042118.17836-1-dongli.zhang@oracle.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c4ec2d9e-b08c-19b2-16a5-93520ca13c2e@grimberg.me>
Date:   Thu, 4 Jun 2020 10:27:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526042118.17836-1-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
