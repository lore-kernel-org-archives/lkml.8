Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7170EC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B22220684
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 19:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OFKiEK9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgCGTQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 14:16:38 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:42563 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgCGTQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 14:16:37 -0500
Received: by mail-pf1-f180.google.com with SMTP id f5so2826311pfk.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 11:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=eGcbbDGmdFPg+blpFgNt5fk4FJZSVRnYmpe1I78QzBg=;
        b=OFKiEK9rXwwl0CHY2j3FkIsqxYczJLl5px2s/tJAAAX8dFUu314yr5/3NOOAqz+bD0
         sBgj0hc5+Lq851u8a0oPMrs+VbZNO6/KW4OUwP4TZHlQep5qeOTVoYfdugbDlJoMLCDC
         GsjalZc7eFw9dtwYqs0ykj4QWAXazDJLjFkppHkPLWRRzZ0fMNLyVZI9pI9SA/87siGM
         e9BerHP9tQ6Jy1xNvNbh29FGp4N+mf/JpPRtpKo2iQaVwTKe5A5Pc6p2wPN/wlD+wU40
         7VbC7se+VMkc7ZWLdSbUjwlp0VrIMMioNiQ0ZKaJh9Zo2d4eBbeRI8J5qytsHDwJDe/z
         X0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=eGcbbDGmdFPg+blpFgNt5fk4FJZSVRnYmpe1I78QzBg=;
        b=fWY4e1sHCm+BJQWltVToMtZi342RY6cHJjMEXunMgsw6TY6alnqRDD2TWIe13r17f8
         d3KkvUkIewKsffMABiiPoRVXm318NYzRhbkqVLIDV0iPZqHocsl1LUDV/7/c+pHG0J8t
         06FFP/2aC7l1Lir4lAv/dP/hK/sQGZSfl6E49xVnhA5iYV/1Hsm+TNwHBVtua7SxaFlb
         VahZWNkl1r2oxaUM85mDLZG5dLIb/4+UVIVHpXeKOew6vTb0YFtOYJRwBscZThE64ben
         ACThuDI59jzwUzQuDwnHW+mKR3BUoqb6BMr3BO9EWOuDqw6LTwaFWAiWeGxW33xffu4e
         aQzA==
X-Gm-Message-State: ANhLgQ3nI2Wg6GwntTUu+b4umef2FkdALVfm/Yb+yBXfpC88Yrr75api
        AEMGsj1tQ0k3624qVogE+CEX3OvdwBQ=
X-Google-Smtp-Source: ADFU+vuhccMaJUQFPMqIN8WhD2HFX3Gl3ECYINAPWasV4myFyKWg48nV0wD9WOuO/TWVjynZIVgnkA==
X-Received: by 2002:a63:8343:: with SMTP id h64mr8751590pge.73.1583608596284;
        Sat, 07 Mar 2020 11:16:36 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id h12sm23741951pfk.124.2020.03.07.11.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 11:16:35 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.6-rc
Message-ID: <b8c32cfe-9bf8-ee8c-a91b-565583a44a8c@kernel.dk>
Date:   Sat, 7 Mar 2020 12:16:34 -0700
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

Here are a few io_uring fixes that should go into this release. This
pull request contains:

- Removal of (now) unused io_wq_flush() and associated flag (Pavel)

- Fix cancelation lockup with linked timeouts (Pavel)

- Fix for potential use-after-free when freeing percpu ref for fixed
  file sets

- io-wq cancelation fixups (Pavel)

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.6-2020-03-07


----------------------------------------------------------------
Jens Axboe (1):
      io_uring: free fixed_file_data after RCU grace period

Pavel Begunkov (3):
      io-wq: fix IO_WQ_WORK_NO_CANCEL cancellation
      io-wq: remove io_wq_flush and IO_WQ_WORK_INTERNAL
      io_uring: fix lockup with timeouts

 fs/io-wq.c    | 58 +++++++++++++++-------------------------------------------
 fs/io-wq.h    |  2 --
 fs/io_uring.c | 25 +++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 47 deletions(-)

-- 
Jens Axboe

