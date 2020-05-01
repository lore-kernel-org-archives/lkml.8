Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A778FC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D46420857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vxEfLCTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730088AbgEAOta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730591AbgEAOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:49:22 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A122C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 07:49:21 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id c16so4645282ilr.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=x8PLshh029JFfraDINPFYaqpVRTVLoh0xA2vag76VgU=;
        b=vxEfLCTH7Nfxiz/d41M22feQyHk4l3tlyaCNLOv6T1fKQdSeNDrbCLS6eNnGqHVhbh
         6ApTEFX3Wz8cNujDJ4T3JDlFpqKvn55GEy0NwGKXU2oXvAVoLr6rYtX83gJTQNEOXysP
         GcUsze7xAEmat3U1O2mU14fW4buR0xIeUS2pH3KNwqCI5aLmZ4c+vHNpK5fOCQHOQ4ni
         4vB/IsXHNGfcSJUCqwwXmdkbT3Yhis8V3NVRu4I2T8YkVdIP+Co/YOEwU2XdlfuO0dgv
         5lCprRhSsRv3vuPsX45tP2XmfOHQxFtLj28e2dqatilMymm5DlkAmHZtrhFB8Map2qZD
         w4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x8PLshh029JFfraDINPFYaqpVRTVLoh0xA2vag76VgU=;
        b=gjSudwqsLjmOAz5ivTxGVBlr7bT0svZodWBbuSXsI1aPbOO4DxEmJmGcpyj+sHX25O
         +1hYHpVPLIlKZsr63rbcS7YGzKfYj5C8qOWJezz2TXKwO6TaXgUNk0wRjYPMHHa+Pqek
         ehG2PJVD/2kwYe1XHcrjVXftQauK41ElBh0H6ZX0IDWZBSc3N7/YImhbEOiweGZlUBfT
         wp9AfqoZtZT4CM7kbxZEtfzY6Dw59FltjZfcBzAPPsSS002FshkXd0jgqAzlrID8DDVE
         dYjWDJEO/XEpQ2jNVzqCQPU+nq1FCRVn7RL6/AXuYC41aLVjZ4BtHZI+pBhMJoVUEjTl
         aghw==
X-Gm-Message-State: AGi0PuaBQIAm2h+YDQXw9vuYanEbkVEtpU2x/Abqm4UuEvEkRnhCJ7xH
        24fr66eI+Zo8HhGzU5k53HTLCAuynlchVg==
X-Google-Smtp-Source: APiQypKn+TEanh98F99uq96FudsPyLXSW6MEPEmMn6erLQrIwYFY6+FIDdMf1z5efsEtucHKAzzGKQ==
X-Received: by 2002:a92:c6ca:: with SMTP id v10mr3870302ilm.181.1588344560532;
        Fri, 01 May 2020 07:49:20 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u21sm1018966iot.5.2020.05.01.07.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 07:49:19 -0700 (PDT)
Subject: Re: [PATCH liburing] test/sfr: basic test for sync_file_range
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <9a85a351b8a06108260fee1dfcbd901b8055b9a8.1588343872.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6fdbccd8-80ed-1e5a-cbe8-2785967fd210@kernel.dk>
Date:   Fri, 1 May 2020 08:49:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9a85a351b8a06108260fee1dfcbd901b8055b9a8.1588343872.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/20 8:38 AM, Pavel Begunkov wrote:
> Just call it and check that it doesn't hang and returns success.

Applied, thanks.

-- 
Jens Axboe

