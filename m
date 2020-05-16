Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5822C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 868EC206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 04:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="A/I2/DYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgEPEsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 00:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725275AbgEPEsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 00:48:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBCC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:48:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id u35so1999235pgk.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 21:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=guKS4svsfOSzH3GIgrQQGTmdt6cJna8n+F/7p89vkqo=;
        b=A/I2/DYW5hFAEcjSWR7cIaR28I6oMZGI3H9YdK1D9bwujvkU3QHqrQ9nP7HsEcLXHD
         /Dp5w+ocz253iQQBPZm9g4db/MnF8rkO1fWW2+1KxPcXHjrHGJUWpUbRwPUZiDYp+mqg
         wDBAh8C761OITQGGFWQR7L2TbK7ji1WrmlzihKYMyyt3YW65uHQykv5GIAmZ5wavxFA/
         Nv6NVavm4CuZba7oVUXNRJS14KoScKnPLxEJUhc0zKvR7pGJM7PVBisLfDSME+z3UPJ4
         DjInHymfuH87Gkt+nRKsjpTgAb+vYn8mtdTDMmDBFPXscK3Up7aj54FJLTHeQ9VJfz3U
         2DnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=guKS4svsfOSzH3GIgrQQGTmdt6cJna8n+F/7p89vkqo=;
        b=CINucAGuigVK3H2DwltE3bm4DRBaVulGstg+XTkYpHGtEqVsmTLCtFZSXagiGeHEtI
         9K4V3ks+4UhRY1QJtqicpGyOD0yElYskpzxw8IX6v7qSAAxIrmbPV2IO/elj1fW7FEYM
         Y2e13oMVywoGiZi6aNdNrZDF4mxY8Z8A+cm2AcGt8EuYQcrnNahSN7ZN8n5t4YHb5Suo
         yzj8buLkfuRXw+SZFObGgnBpctGzXYR8UsS6ShmX7qQBUzEu2oT0FQG3+8tp6I/TC2oo
         OGYdaHP+L0InSvf43GIveZt6rWxkviV7GuoVtK2dL05kObGrBxl/yPlPgZrZaKlcIVhZ
         2ctw==
X-Gm-Message-State: AOAM530SgfEXBNvipucxQZz6U44BYiQBgVAWazShRyLswdSSkb5zzFzY
        lejbpf/R8phnnt+aYsT/BsX2J1c8vxk=
X-Google-Smtp-Source: ABdhPJzVs7mPufisWaF6ZkAfm30do+cBbq2NDDIcYml+2V/qpPw+6T8fw+WjFekCn1/E4JzsBcwXZw==
X-Received: by 2002:a63:b604:: with SMTP id j4mr6186694pgf.124.1589604529284;
        Fri, 15 May 2020 21:48:49 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:7441:cda2:9ab4:7ee0? ([2605:e000:100e:8c61:7441:cda2:9ab4:7ee0])
        by smtp.gmail.com with ESMTPSA id j5sm3246387pfh.58.2020.05.15.21.48.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 21:48:48 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring fixes for 5.7-rc6
Message-ID: <670c6caa-5c66-a172-f61c-b5398f4e1d4c@kernel.dk>
Date:   Fri, 15 May 2020 22:48:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Two small fixes that should go into this release:

- Check and handle zero length splice (Pavel)

- Fix a regression in this merge window for fixed files used with polled
  block IO.

Please pull!


  git://git.kernel.dk/linux-block.git tags/io_uring-5.7-2020-05-15


----------------------------------------------------------------
Jens Axboe (1):
      io_uring: polled fixed file must go through free iteration

Pavel Begunkov (1):
      io_uring: fix zero len do_splice()

 fs/io_uring.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
Jens Axboe

