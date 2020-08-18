Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F53CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30F8206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:12:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cWzzse+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgHRSMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgHRSMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:12:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B42C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:12:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q19so9606881pll.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B6ZJxFf2Z6gDyFzWzMEu+MxYBenSPrvaZMkOZhCrYpk=;
        b=cWzzse+nzZalDgVtFalfBv5bPc3YtGZGFGJaWtJ3muGOvmJtvkQLCkSZFAc6JuSH71
         hjGDE20kS2S4cKvJWOo/DeQT3FFkaKSKXmSDLLyjPWsx4a2CZQGxGpmhxVWi/QCL6T6A
         ZtkmdiXDq8K3c5dHUpcaBPO9hjRl/4o0+bT55E9sLB8IHOrZN3hrT0ee3fX6VxaviUCF
         UOlHpGLLyp/ULrC9A4dayNcqNhVxRMs6OypRd2yCSKoUKQC/Yj2xw6TYDhtetahAXEBw
         ic6I+wlaeKoOFDOtBZqT7Fv+IbdyT+Lf/fmz4Jj+0Aq4+K7SkvDwPlHqG3yQdhOv3qgN
         bAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B6ZJxFf2Z6gDyFzWzMEu+MxYBenSPrvaZMkOZhCrYpk=;
        b=h2XJeXGKSUAuJiMUXoKqypJCizUY7IkuM3oAB91WpLlx+00YCXo3GHhy52lpftOo08
         ua/s9VTv+IEp5l28Hvh8JCRcQegIPaki9C2R/+votNFeM3cgeSKtptnKlOj9H1TrBw51
         UzdFN8cRx96F7LfYMUiUcs1TPyLHXMRDm3iUinWeSxkhuNSCp1JYVZN0tRYXdogxUNGK
         aPJfS7QFbtJlwNzbpnu3rpoo2vPajv6SoTMdz77LlWNJVG0RPZlzNxASgH8zEsz4cGpd
         r2Lkb1Lx9J8kpPpBkjfgmsBnlDMrpJ3G8uEtby3rJc/fODjF5xsIjob5JAyv9XKXvjvG
         TL7A==
X-Gm-Message-State: AOAM530yVlO3oGonQcX/1UanRx3QRWAg4AqrVEZc8wcAYWmVYcaRsTtI
        hRVJ09HO/01I+V8GlR1gbyda/kwK7sTD12fp
X-Google-Smtp-Source: ABdhPJz6UYz5gqOxPOPAZaRpOrNzyaFiiZ4VQvMnWaHvJSDDyH1OWWmADBZG13GncGmKNIV/Oq8PcQ==
X-Received: by 2002:a17:90a:6843:: with SMTP id e3mr931799pjm.89.1597774373413;
        Tue, 18 Aug 2020 11:12:53 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:9214:36a5:5cec:a06d? ([2605:e000:100e:8c61:9214:36a5:5cec:a06d])
        by smtp.gmail.com with ESMTPSA id r25sm21430047pgv.88.2020.08.18.11.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 11:12:52 -0700 (PDT)
Subject: Re: [PATCH] ext4: flag as supporting buffered async reads
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <fb90cc2d-b12c-738f-21a4-dd7a8ae0556a@kernel.dk>
 <20200818181117.GA34125@mit.edu>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
Date:   Tue, 18 Aug 2020 11:12:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818181117.GA34125@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 11:11 AM, Theodore Y. Ts'o wrote:
> On Mon, Aug 03, 2020 at 05:02:11PM -0600, Jens Axboe wrote:
>> ext4 uses generic_file_read_iter(), which already supports this.
>>
>> Cc: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Resending this one, as I've been carrying it privately since May. The
>> necessary bits are now upstream (and XFS/btrfs equiv changes as well),
>> please consider this one for 5.9. Thanks!
> 
> The necessary commit only hit upstream as of 5.9-rc1, unless I'm
> missing something?  It's on my queue to send to Linus once I get my
> (late) ext4 primary pull request for 5.9.

Right, it went in at the start of the merge window for 5.9. Thanks Ted!

-- 
Jens Axboe

