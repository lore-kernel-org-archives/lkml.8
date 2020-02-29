Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A29C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9502082E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 20:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ClhsKX9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgB2Uzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 15:55:47 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53823 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2Uzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 15:55:47 -0500
Received: by mail-pj1-f65.google.com with SMTP id i11so2672371pju.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Feb 2020 12:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LfAey+bVZC63MZcRaKrf1wf+n/7HqfzMlziFP/uZ5DA=;
        b=ClhsKX9DW5hTIMiI6HHZ0GUWCxU6QbmOxwbUME6SC+2H4MgVlbEAMmNzWoVHCxtZz4
         jODg4Y20/kt8t5Hi9NP9dV8oxmZ2Grr06rBhEjhVTLCofOWwzlM35aosLDpdH9p0TRrz
         6y2ZA41P832B+JG3r42ZaWntowDOl24cID7FT913bB+SVyj+BbKUgJ+BGzUC0cPibOb0
         Fe60zjQFVT9K3JoX6WnKmFcQXwGtRsM8IgIXy8FOHwuaWTp06Ai01R9BScmI2EfR3InQ
         EK3K2M6kE9dTDpLZj3jvEScnQimKWv1kHMOimtSd/wFbmHFBsKjBTghpKnbJDLCx2QMg
         sZ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LfAey+bVZC63MZcRaKrf1wf+n/7HqfzMlziFP/uZ5DA=;
        b=q7OtmbSTqC468fffI8fncd5GrhKzy/v5yi/y5lgR1VDkScdD7ULJIOgqCaX/hRDlnH
         1zSZ3fbxeiqFDH0bb3n3Tp46cDZ4fnNlO8rozVqDyaujBgFk2uwXqwNElqgYjNgOXtbp
         qJWMEP1AAwQaqO4skcgQxqgHZglrNRLA17ZgyX0UMJMMUsbjlzHN15/33petupJPFRw1
         YJpKBMoZuUveNB1p711RPPmChdWuhZLSMgCcrvJI28NLly49ZKju16MjFikriiC0dkHR
         y4luCXlR4uDxsuZF8hgxnFUAmIJej74O+sDdiEUnVELuwa5MTvlhz7qwlwbGnLiZHt80
         IlvQ==
X-Gm-Message-State: APjAAAXSOY4tpUBgdbTZHri24LdDpnlIMs/c/MA4s+tM3IyHFHHBRUE+
        1ex0bpLmaPeFJpYxWGARbacXVOMrM4w=
X-Google-Smtp-Source: APXvYqwOVZngKIRetVCWvncT1J21YRIi0aP5gheYzkQNimZI2jAECzbYCrcgakD8LcCfMLaRbWsjuw==
X-Received: by 2002:a17:90a:9ee:: with SMTP id 101mr11994638pjo.74.1583009745793;
        Sat, 29 Feb 2020 12:55:45 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x4sm10554330pgi.76.2020.02.29.12.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Feb 2020 12:55:45 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: remove extra nxt check after punt
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <29e9f945f8aa6646186065469ba00c0a4ef5b210.1583005578.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <08e7732a-4a31-424f-ec3f-eba4d753456a@kernel.dk>
Date:   Sat, 29 Feb 2020 13:55:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <29e9f945f8aa6646186065469ba00c0a4ef5b210.1583005578.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/29/20 12:48 PM, Pavel Begunkov wrote:
> After __io_queue_sqe() ended up in io_queue_async_work(), it's already
> known that there is no @nxt req, so skip the check and return from the
> function.
> 
> Also, @nxt initialisation now can be done just before
> io_put_req_find_next(), as there is no jumping until it's checked.

Applied, thanks.

-- 
Jens Axboe

