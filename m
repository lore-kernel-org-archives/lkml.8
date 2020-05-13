Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A8AC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE35B206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Xr8CCr30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgEMCaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgEMCaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:30:04 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36234C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:30:03 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id a4so7103737pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dRl4YBE3TMl0SsiV0tZC4Iqnfxs3bO+Y25NzUvxt45A=;
        b=Xr8CCr30EpIbBzcUFmUdyJWqPcgRkkyRgJ8EuNa0FB0nt4+zA1favzlpTbLpHBYluj
         0/tj98qvnGqD/m6l/2oGIJwAffNk9yJA2BSCxn5LEmEWplcJ+dgJlXrpxRH8DRfcpcYA
         wS4eohtPzs81f4zWnLjkt0emvJ/qDc7ig6TaFCP3NwmZ7/3sZaN8dgm1FezAXzmmOjQI
         ApPtLtHQ7JZgaLDQnQwvgal1A8fGW8ejl+PqS9hpr5JUOw/pc/EWAF1PvYOmacb5uWWR
         pjZ8957+0ACJvt8MyHypjm/HHd0BEubrKizI9BTOATq0bJLhD7Zfgzd13UKC2FouaNPT
         B5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dRl4YBE3TMl0SsiV0tZC4Iqnfxs3bO+Y25NzUvxt45A=;
        b=CNumOuoXQKukMVDsOh1W+73dmxi76nmG75MAVLas0TkrYyjvf/joAWFMxWt7EpTF77
         FhzpgTPdWrYLMHzKgxSeQuAUnlkUp7/t1qnE0UQ//eidA+IuANoZa5BY16iiJu6zcJ4o
         P9TKYcaEAhCRHbF+BkCTztv+8Lo2NkLAjYUolhLSh9Br3NaJyKBaMucxiiqxnZZA+4P5
         G7iJs4T0SH6RnDAeL7NbpbiAewnw8vTQLgPLaSQ9Sq/+hxw9uWFQfPECIngX6ro0SDSS
         o93bm/PeNanFqgZk5scOUi8SozkDZXw++r7phM9WjrYqGJrh2sUJVRjDe2eq6JuSdtzo
         x2Tw==
X-Gm-Message-State: AOAM532FMBw16X8Sd6LslfKhuCs0qaZA+OlAbhsqNDaXLrLDtdbRKH8v
        LVXLuIhPrbUpUNbUto81MXB2fZV8614=
X-Google-Smtp-Source: ABdhPJwgw+y9MRoDkNWNDGa5d1jKOUxGsSXi+rxOaTsYZXTBVkbDWUxv6H3GSNMHgnPDg+ecwsEaOQ==
X-Received: by 2002:aa7:8c0a:: with SMTP id c10mr13866827pfd.177.1589337002687;
        Tue, 12 May 2020 19:30:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:1d8:eb9:1d84:211c? ([2605:e000:100e:8c61:1d8:eb9:1d84:211c])
        by smtp.gmail.com with ESMTPSA id g17sm2797521pgg.43.2020.05.12.19.30.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 19:30:02 -0700 (PDT)
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Martijn Coenen <maco@android.com>
Cc:     Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
References: <20200429140341.13294-1-maco@android.com>
 <20200429140341.13294-11-maco@android.com>
 <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1f3064a9-105f-02bb-6a1a-eb9875d292e3@kernel.dk>
Date:   Tue, 12 May 2020 20:29:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYHwor85-fWKu+OMT-1ys2L7OSqVoReJRzNOMAE0xK+yzg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/20 12:46 AM, Martijn Coenen wrote:
> Hi Jens,
> 
> What do you think of this series?

Looks acceptable to me, but I'm getting a failure applying it to
for-5.8/drivers on this patch:

Applying: loop: Refactor loop_set_status() size calculation

So you'll probably want to respin on the right branch.

-- 
Jens Axboe

