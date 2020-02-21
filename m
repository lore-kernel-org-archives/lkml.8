Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77983C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A18A2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="igvfD2fJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBUQRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:17:24 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42085 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbgBUQRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:17:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id w21so1194436pgl.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQGcVDwZYQWBOtAXil8SzgdiYPVSaSGZOeGTzRnc5aE=;
        b=igvfD2fJPKAX9ygqtJrrPalny2QTmYWCBA5aUcmDkKSmfijQRdypWy+AHX5MU5kLH5
         DKHxoGL1quqgjN8moD1oc+a7VeyYhurpgFd+P9B4kC2GHDHA/8shUcIpsC38TgwVals0
         xpDPT+Tvx/csZKZCHbBcq1s5ffaqFNU135vHx9669aK32fSDxBzBM96qb+YQKYlIgtk1
         KLC6F+x0A7d0NqLDbkrgxTdJTYnGSQtt3uH3UySe3cF7Q6CHbyzVlz3NuNJTTIY0P76A
         Z0q5MxJVZUKyXXIf1aXuISrJnJw9ux9nvLlrM/9G3qHIDTIbUGYQtRpLjM/+wn55mAQA
         B63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQGcVDwZYQWBOtAXil8SzgdiYPVSaSGZOeGTzRnc5aE=;
        b=OGgHrUHjgDFrpJQ+45RyNIolC5JI2FnSPmujYQ99n0w3G5yT3PTHQfejMyFCdwE+un
         xNFPjmuFrMyr1N0xJM9uxni4l0wOzxtRWQCqKh7tu5hSTAGXVxIedVdW6whoDulMdGKH
         5WOIm6CIKAzop5m+Vy2eTcEulYTlNM27EagfQP1dgI3czquUKGB9H4drHQsJ111LFI7/
         MjwJ6pe8BTsufta1zipnmdLCDGg/me/YIfLJIbGPfdSh4NnOCzSoASFYRYeLlQo/W7xz
         BIqQIilX6PM0dsyMkciJKhLsXc/am4pPgM+TO+Xg2kE4SRig3w9mu0m903FMcVtCftb+
         pTcw==
X-Gm-Message-State: APjAAAXJVtQjhHkpikRG8UFML/vy3M5Guiopbq69F56mA6JtbwqxbNjq
        k72NLxmhng8Xqq3xWFd414RapMYCUik=
X-Google-Smtp-Source: APXvYqwUA11U5oDvifmSn/+wBEXU6Z5cSGYf+l+J+XGmsYkQFGr5FQgzrVuTtm9KseVvsIoREIbjdQ==
X-Received: by 2002:a65:424d:: with SMTP id d13mr40361290pgq.128.1582301842730;
        Fri, 21 Feb 2020 08:17:22 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:91ff:e31e:f68d:32a9? ([2605:e000:100e:8c61:91ff:e31e:f68d:32a9])
        by smtp.gmail.com with ESMTPSA id p16sm2944701pgi.50.2020.02.21.08.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:17:22 -0800 (PST)
Subject: Re: [PATCH liburing] test: add sq-poll-kthread test case
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200221154400.207213-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0f04c1d4-0688-41be-8889-9b18838053a1@kernel.dk>
Date:   Fri, 21 Feb 2020 08:17:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221154400.207213-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/20 8:44 AM, Stefano Garzarella wrote:
> sq-poll-kthread tests if the 'io_uring-sq' kthread is stopped
> when the userspace process ended with or without closing the
> io_uring fd.

Applied, thanks.

-- 
Jens Axboe

