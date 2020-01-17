Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA50C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275B21D56
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 22:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jUTxxjoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgAQWuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:50:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36793 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQWuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 17:50:55 -0500
Received: by mail-pf1-f195.google.com with SMTP id x184so12609838pfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 14:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FLv2ZspmtqwV150G96rF061vfchfrzmz1i+ZdELex5I=;
        b=jUTxxjoN9jxxAGky9QPAtlkhKfjJdSN0eX88usA1girItO518AlegdysipQKmKs2td
         0Mc2Dl31yrUS3Gg2FUuKqBvAv6xgRLYrnvYcrk/qec0Z3qxhktOUJ69JcwpGfMhO/rz+
         hHSzIEZy9S/XhZ9WdFzu8kqHkAMKvNIdY3hFCv3hBzAGURg58s17qfurCfXONAbxFicH
         RWwqOH42l7zV5ozTOY0mykRT2lbWswyq8cxIv9Lz+6FwPThf9ve4UR/t0fwCWrGBRQh6
         dn/ooZjo6QxHXxgsTH7iydAjdEyOLfuK0707huw80XZXE3P//cvSzTW0sirPqRk4pApK
         2skw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLv2ZspmtqwV150G96rF061vfchfrzmz1i+ZdELex5I=;
        b=Nyh2aG+JpKzzzv9T/HT1H/L1nWL03yAd8X1kc2elm4RPfOkjmMk6y5B9xxDuVORI2h
         WCk8Rr54fWJcDvrgCCeOURLtIx079bif6aR4b7ssx+XSsIjX1phvy/4Uwl2hB2MAYWJr
         aftYaomUZKAdUwh2sVK/SOrLIiCf6xCHvXMj21Qb1kIY6Nkk/Wjz7gGfJ2sZ6Q4CszqV
         6xKnRsR3UMOX5BA9IL2zw021Y49tLCgLT6079eUu5Z44N0Gvq8LTmKU5NT2ZFrFDBytz
         cIehrpo0q/QOXi0OQAzQfRWgXLpG68DOP3afdep6IcVZCJAnIYtrf1CpqaQhorMZYlXY
         WC5Q==
X-Gm-Message-State: APjAAAXXt5eP9eVEtYg/Ijub3wom0jblTWNzgKTe06KcWm+3vjdCLH1H
        9nM6OPArHH4EeFL7mZVLV77kWFOcnnc=
X-Google-Smtp-Source: APXvYqyLbHa29ExwxlYeQgQQ5kJdJHWOTl/fbP1w9Af9NS/b86mmk0Allegw/taWsqzBnhqvNw5A9w==
X-Received: by 2002:a62:e512:: with SMTP id n18mr5320769pff.50.1579301454363;
        Fri, 17 Jan 2020 14:50:54 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id iq22sm8774088pjb.9.2020.01.17.14.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 14:50:53 -0800 (PST)
Subject: Re: [PATCH 1/2] io_uring: remove REQ_F_IO_DRAINED
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <37a04c11e980f49cb17a4fd071d2d71a291a8fd5.1579299684.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ba5eff5-891c-a02b-7c8f-62cc3365c710@kernel.dk>
Date:   Fri, 17 Jan 2020 15:50:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <37a04c11e980f49cb17a4fd071d2d71a291a8fd5.1579299684.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/20 3:22 PM, Pavel Begunkov wrote:
> A request can get into the defer list only once, there is no need for
> marking it as drained, so remove it. This probably was left after
> extracting __need_defer() for use in timeouts.

Applied - waiting with 2/2 until we're done discussing the approach
there.

-- 
Jens Axboe

