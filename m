Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1036F2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ApLZTDpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgEZSET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgEZSES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:04:18 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CA5C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:04:18 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so8980590plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xN18P3pXk9ov3jRcuqdGEQKpjL9tqNKMSa/qU3w2Kps=;
        b=ApLZTDpGOEg4R7/2rp5QFVKZE7iFxMEbcqJkKDrxsOipoLnv9LrxngGBL3toqQwBS3
         k/iOjFfSmW5BYbXuZ6S5t8TsDCHTJvle4RUy7BjbbJb19eiSdGpKrWztU5ReBkO7xVwd
         V0Z7R55BsYY9mIZ7kxZvncdiVbaYws8kC8HO2AtG6aC3qVoKsSSrzNkt8unBpMZgFFLd
         L4kRIVrQR/TJnfaFA2xxA4nDQLZNy+xbYk1noHXpDA+U+mKpG+kgPy446qZ45nl6bQW8
         +YYdbwc+xPMQIBujm5KHqIwqrLTKlClQnbS3zrUDECg5x/2j0qN3xcl68JeGWqXcIlZU
         MwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xN18P3pXk9ov3jRcuqdGEQKpjL9tqNKMSa/qU3w2Kps=;
        b=c0ZwTgZCnFtnoOfqPv98smMf6G6Gy64cz3OxFTAA67p2bZTN7bJhC2EMI3omL+CeMn
         ZYieiVlXaW+9jNEllc4Aq1L0DLlXC6CClTBpPErUmIe6UySQvOnujHOpr1GB8quL2a+h
         oF7+aiBFdMs6tuZNJU4L09uI9lPVxTXvPmbPVhvqTtERYJHOIlN/P2t3LMAUwSH4DhCp
         57fTWZLtIISPiFhqSdf8j7p547tiBZI7dPTTY+gHHa8YkU0JP2bAt6+DfQSVlNN1xKaA
         YjU9sSU/Ru5vBEL/ITnXEkGhFFMN4d2fUy7pJxYBl02t/ofhx4XtwIje40SVEGdwc2lu
         qj8Q==
X-Gm-Message-State: AOAM5328cMalZ0CfjlwClSVRwUu1oaJEo+/LEXDWnUevSRZRCpFvwi5+
        igVBKBFtl+Dp2OIT/q/kGIzWuWAg0ZTekg==
X-Google-Smtp-Source: ABdhPJwB+MW5Pz7ukEC/Hy/cHj9Qc1/7Vhtx0AJkxRdqljuvOFbh9c3cmsvxMUa4x8by+v5qqbc0zg==
X-Received: by 2002:a17:90a:4b47:: with SMTP id o7mr389452pjl.205.1590516257560;
        Tue, 26 May 2020 11:04:17 -0700 (PDT)
Received: from ?IPv6:2600:380:495a:792b:6476:7a3a:9257:12c7? ([2600:380:495a:792b:6476:7a3a:9257:12c7])
        by smtp.gmail.com with ESMTPSA id u14sm196285pfc.87.2020.05.26.11.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 11:04:17 -0700 (PDT)
Subject: Re: [PATCH 1/6] io_uring: fix flush req->refs underflow
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1590513806.git.asml.silence@gmail.com>
 <be790e01cf63bc0d04bc4577e15ef50ea2c3ac53.1590513806.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <82761dbe-d0c6-c14d-0898-1bb324d38b9e@kernel.dk>
Date:   Tue, 26 May 2020 12:04:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <be790e01cf63bc0d04bc4577e15ef50ea2c3ac53.1590513806.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 11:34 AM, Pavel Begunkov wrote:
> In io_uring_cancel_files(), after refcount_sub_and_test() leaves 0
> req->refs, it calls io_put_req(), which would also put a ref. Call
> io_free_req() instead.

Needs a:

Fixes: 2ca10259b418 ("io_uring: prune request from overflow list on flush")     

I added it.

-- 
Jens Axboe

