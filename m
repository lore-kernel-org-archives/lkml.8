Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9025DC35246
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D0D206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 20:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Nu1YG3iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAZUCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 15:02:20 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:33621 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgAZUCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 15:02:20 -0500
Received: by mail-pf1-f180.google.com with SMTP id n7so3873803pfn.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 12:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hAj2qkKHbDn4W5gqS8ibjJvnqiiOc0xEaLINRRkxATg=;
        b=Nu1YG3iqUH0dAt8AsWKqFlWxEyW/kqj3FhH3vwJMBAUQyygJG/Txs4TmdYCVZZBGy4
         qkBfLPim/Rxa5XcUn9+3fmirDTRaG6nknZzNiTY138AISAx4iL4G3hapcLSIQY2P7AJ7
         ijHsB/8BaOwmnY8Qm5DQw0UEA7Rx5lTl35kfiKgQrlhj+aXzVnvR+hQR2twiWNDLdqEl
         Ih1ZQUdeE6vAMzl9lY4c6TNrc7ZKZTnf9fXrfslGuwrDlP1zkyM+Xp1PuB9imtGoIWIN
         LZIcz5Dn2HIar9j0YeXvledJ+n5pOVHq2vTPhZ5hEem8PufW2qlNchWVTpOT8Z/sP1+f
         i9gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hAj2qkKHbDn4W5gqS8ibjJvnqiiOc0xEaLINRRkxATg=;
        b=a4w0r9EXRr/zrrjGyVrLJkffYJK1awb9lQSG4D4AgPsMgU0GjkUbB2O5BmYssWDU9P
         J+sGTrLoDbeqrYNp7W9fyjqyrss1kvrbpRjLf86W228UMxElcdB0QivOSBSygalPJuAd
         NswasmMjAlv8PCiEHMSjdX4a1BE0IHrNFHIDY9NZjNOLRF5idMf+Vn8YKDosk3c3Bsuw
         x5MlMM9fbJGxERf9B30t53K70PnL+UMPpbL8JPva6TUOJmHyBlpSpK8+1whcOU/k+fV1
         ntg1D3Oo9smCw/TP8P3FuLeFFjQm7V9iSoOEuAx6dkTt2JrnOo/AAGGnq7Fo2dOOKW2W
         XgwQ==
X-Gm-Message-State: APjAAAUW1KELvKXlKAbqzzAtLvLKwnsX5APTcy43HwrZkFGp6xJY4oq9
        v9NJnbQlnzkUzBa6JLdxGAiwhDSTFvw=
X-Google-Smtp-Source: APXvYqx80UScOhO1FzTCUp1Pb5pqJs7Ahum36LsqCG3g8dSsw7q4jwqzn23HXVSueO6SagG1FxSLhg==
X-Received: by 2002:a62:83c5:: with SMTP id h188mr13177144pfe.0.1580068939147;
        Sun, 26 Jan 2020 12:02:19 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id p5sm13861976pga.69.2020.01.26.12.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 12:02:18 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.5-final
Message-ID: <97fc142a-5f87-57f5-67fd-a146996a7ff1@kernel.dk>
Date:   Sun, 26 Jan 2020 13:02:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Fix for two regressions in this cycle, both reported by the postgresql
use case. One removes the added restriction on who can submit IO, making
it possible for rings shared across forks to do so. The other fixes an
issue for the same kind of use case, where one exiting process would
cancel all IO.

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.5-2020-01-26


----------------------------------------------------------------
Jens Axboe (2):
      Revert "io_uring: only allow submit from owning task"
      io_uring: don't cancel all work on process exit

 fs/io_uring.c | 10 ----------
 1 file changed, 10 deletions(-)

-- 
Jens Axboe

