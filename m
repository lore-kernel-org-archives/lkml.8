Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C835EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CC92082E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DQO95RbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgB2Uz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:55:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51972 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2Uz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:55:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so2744851pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 12:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NUOQWtXrLqCzsr0Qrm3PTxXVOmbf/Tqg5MQT7aINH/g=;
        b=DQO95RbAXcxBOoIv+87KHdVtXA4+NpRQcqut2b1pdKydJxjGQNSwkSlhcUs/T43oIb
         HpDPX04ChmWT6Su+zIvLPgmO69wcqVPESV8CUTh3GWzcTG/AsIzCLmToA2t1QqafVftC
         Mf2Fw3KtfmXupq1u0zXkxZFid4Xc3WuscHnn45aYqFdeqiqEM8lcr2rTp3bNoXaf2/46
         5vKyZGUwmpiboT+OIiFv/HWaWUvTSZWbfW1e0eWZBTyNYgSM+7XFIgMcktZO4Ee4Yfn0
         LGVQcmRYy8MwauWkgAJMQ8T/gVN20faZO3KmLZrA/oXw4xahVfz59znbsXmzcg3b9FAO
         9QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NUOQWtXrLqCzsr0Qrm3PTxXVOmbf/Tqg5MQT7aINH/g=;
        b=ejeoz7E9KNCL3GEW+8D0T+OdM5w8toi4KrQ0KvgZJ6WgBG91D0CcSbXEAIaqgwcAO2
         DUVDQANcCL3osp6qJwg+OZ7d8UcWh0xGXZrYvlkTDdi+cN/rT2yWZfH5PkTnOZaymN22
         sdvega6d6EmJo8kxJhMCKAHoxSZbpGuF0c8wJJ9vTVlzGNEiR780Pa+15VwcJsum1a4s
         F5nvJ1lA/1zgKVuEvkzgkHnnkXMYrDmYUQZ4FIcCgqsGpqBM4nwxqJWXVI7oJ4sbiJfL
         XBksdepg32iL71MaWCR4MrOUanlOM9b/v2eceOTrGt5qMi26maSUAR1eQ1r8XibDskZ2
         opQA==
X-Gm-Message-State: ANhLgQ35wXXHqNakmyh73gWqMGiWq+FbX80gvsV85Nmg0880XSzypPhs
        sapHmp2xmBuCWH8l+ot1gmN3rMcl1gs=
X-Google-Smtp-Source: ADFU+vtnidGvovu0mQB7x1rQWGUAmmnF18IESC89APPM/k4hR0iTkw2I2i7syLtz30OehBbgxi1V2A==
X-Received: by 2002:a17:902:7c04:: with SMTP id x4mr2856157pll.4.1583009755204;
        Sat, 29 Feb 2020 12:55:55 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i2sm6472969pjs.21.2020.02.29.12.55.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:55:54 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: remove io_prep_next_work()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <d5893319c019695321a357cb1f09e76ed40715d1.1583005556.git.asml.silence@gmail.com>
 <b97698208e565be70ae0afae1851e0964260c3f8.1583006078.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d9c6f63-4031-e622-b44f-8d5bfad232dd@kernel.dk>
Date:   Sat, 29 Feb 2020 13:55:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b97698208e565be70ae0afae1851e0964260c3f8.1583006078.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/29/20 12:56 PM, Pavel Begunkov wrote:
> io-wq cares about IO_WQ_WORK_UNBOUND flag only while enqueueing, so
> it's useless setting it for a next req of a link. Thus, removed it
> from io_prep_linked_timeout(), and inline the function.

Applied, thanks.

-- 
Jens Axboe

