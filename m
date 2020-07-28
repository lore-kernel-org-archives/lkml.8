Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B29EC433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A07B20786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 15:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eOS9kCUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgG1Plc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 11:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730821AbgG1Plb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:41:31 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 336E8C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:41:31 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id z17so1457838ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vSWx1/Sr/gJvV92Fd2QuTQjvx6hegEt2EdSzZRTJZXM=;
        b=eOS9kCUGWozMEgHSZJcSVDFO0AHLhz5u13Hzr4euy1SfrsO3wctZ6YAEcFh81LUEFe
         qKEx883RdFNlnU/ciLWMOG+Vj2O3UtdPLRGu3wVgO4m2BQ37DnVzwEQRW6UlEXPC6X4+
         6qy3MKLhkiUeg2Gj1Hl5rFfX2WIKMSYf+TvHUXJLRYjJhA2RqWzGfAYi3i7oAIMDIOGN
         kWmCj7CoLh5z5B/OHRT7/QrMunwFyL57wmiHBTZtYJy1FwxdlHKoWKtw+zsNgVUo2ZHx
         EpjXSF+5KBb5kwwDmys2D0JqmY/qrmWuFn2WVlWcfsS5xNRgrwNQRXJP5bi8Bs1TigZW
         btwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vSWx1/Sr/gJvV92Fd2QuTQjvx6hegEt2EdSzZRTJZXM=;
        b=PcnX2B/1B0m+FPbMQ5x/4W8ndAsdU8WRoD28y4KDxjVcPtAeN0L0AkDWwNTteV467z
         VanVXnv4iQMh3VXHFYJypgt69FAYlxH9dkVkFwJzbNxMDGlJjPAQ+SfTyfQP8QgqkGr5
         DRPMoD33ZKHikTw5dL8X7czMgoQDNvUMb4NshNj22Hfi9avlwUDgmOuWOvToo6beoJG9
         T1CGPyfrNRTg4itJFMT1ipo90AaHuRdtikjEMG3JCR8fgUUz7ycb8Iz0j1hi+ryyhzIa
         EwKp5oyW8Sw7PBFjjkyWvLDmajVlwFUcuhwNgBXIM61xEptXTdG3eao8D4RUhA8Fjvo/
         SNRg==
X-Gm-Message-State: AOAM533nqOuiGiDxa3WqdXhAM0DXPG6dwsU8FwypgZDhXUPD5lO7+z/C
        p+5keLqagKCfe9uJk7OPxG6I9A==
X-Google-Smtp-Source: ABdhPJyDr3/VSL/Sd0AZTRTnDaDXbKtAPJuxtlG2XtO6yQjepAU3x+9xL+YVZgu/NKlxbtyZpuHMhw==
X-Received: by 2002:a05:6e02:c6b:: with SMTP id f11mr411495ilj.272.1595950890232;
        Tue, 28 Jul 2020 08:41:30 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm2827959ilk.13.2020.07.28.08.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 08:41:29 -0700 (PDT)
Subject: Re: bdi cleanups v3
To:     Christoph Hellwig <hch@lst.de>
Cc:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        linux-mtd@lists.infradead.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        cgroups@vger.kernel.org
References: <20200724073313.138789-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b2b59d4-da4c-33df-82b4-0d4935b91e6e@kernel.dk>
Date:   Tue, 28 Jul 2020 09:41:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724073313.138789-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 1:32 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series contains a bunch of different BDI cleanups.  The biggest item
> is to isolate block drivers from the BDI in preparation of changing the
> lifetime of the block device BDI in a follow up series.

Applied, thanks.

-- 
Jens Axboe

