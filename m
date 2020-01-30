Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC55C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422DB206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 04:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IQp2EKT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbgA3EK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 23:10:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42848 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgA3EK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 23:10:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so782524pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 20:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H6a2hAcBNDf50jLsz7qbTfJE2hD85xCfgqwWgNuwHEg=;
        b=IQp2EKT6PqPbYC5WCstwLn2iWq0lAFgOEbp/wtS+FythiqN9JOZl1HPaYFxCGVkYWF
         z8KrjO5eD4RcqQKM9sZdNJ2npJ0pm6fGkKKpyBGanxml8u597u1G/efZt9I/kC+FWngQ
         GzuSOXh1rOt820nqqF3DjZ+UX0tCLfTbUrwwnfk1L9PPREH7kumvPJK2eAzwrp2mioOO
         2cxLi/6iRVd1LZIDB+TqPqytIcMYL9GUmdawbxtbcq48eDqHifSaLogkWLqN1iMWJNSF
         OqaTvX6Phl1vbNv6bl5frh9F58ZSpJOsqOYRq49PCUMIC971gxdbRn/ztlxaT/5pR3V3
         eVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H6a2hAcBNDf50jLsz7qbTfJE2hD85xCfgqwWgNuwHEg=;
        b=fSeFUil2oWzgqPVTWMN0j1S1cS+Cg2QkyZIwwNpGIv6EiOy4f3iz6+PzFgfM5jko7z
         UdLwyHG4lw3XH1oPUipgvAdIq5Rq4jxE1pBa91k6VBxPrlftH8TQw43F6iAAK606BJPb
         KaNTg0hvER8/obtHPIejTc3bawRG+nk1R2TicLLzVjDq/fHKECYqf0qHqQ/LoW1LsxQG
         Brg9A//lwIEtKjszgTzPd+0DlFQ8YIgjy+YZJTWcvq9HITcWlbZEHLKIFCqG+TEmvXLn
         hqEwppJ4UNuzpD2xLm7v7lUb4Budo6qgAhzKk2zt+gxCh5CY/Sk5hZueSCb6BN/FsSSP
         RWgg==
X-Gm-Message-State: APjAAAVlI8V1T2nrHWjhxmvSpA40D32a0BWQweqyNw8J4Xrarqna2Xbj
        1Ahh5gcWcFtzGIya+81nDKdtgg/9Fs8=
X-Google-Smtp-Source: APXvYqwlUl5uxiApMFafYxJAjhL0wBYgSra/Q0x2WTBFZLd9fgFhIoeBqLP7wN/unBxVdXHPxO60jg==
X-Received: by 2002:a63:214f:: with SMTP id s15mr2810698pgm.238.1580357423987;
        Wed, 29 Jan 2020 20:10:23 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id t30sm4216769pgl.75.2020.01.29.20.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 20:10:23 -0800 (PST)
Subject: Re: [PATCH v2] ata: pata_arasan_cf: Use dma_request_chan() instead
 dma_request_slave_channel()
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, vireshk@kernel.org,
        b.zolnierkie@samsung.com
Cc:     vkoul@kernel.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200113142747.15240-1-peter.ujfalusi@ti.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6bd30916-0c35-b1c1-d08f-b7dd9e181dba@kernel.dk>
Date:   Wed, 29 Jan 2020 21:10:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200113142747.15240-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 7:27 AM, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> The dma_request_chan() is the standard API to request slave channel,
> clients should be moved away from the legacy API to allow us to retire
> them.

Applied, thanks.

-- 
Jens Axboe

