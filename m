Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285B0C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22FC20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sruLBKDX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgCDSsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 13:48:07 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:42373 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:48:06 -0500
Received: by mail-il1-f194.google.com with SMTP id x2so2708624ila.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 10:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=S9W7e0eEucLRc1ffg2OOLPtWfKH/j6fIgfCoT9zkmQ4=;
        b=sruLBKDXI+8Re66Y+pWX8pNUETxHXEbhvy5dnTtswbvWs5f5SR9ZMgjcV+MVofdwr4
         gg1Ju2kOUjY/nPmXMSVmqkWPj5FGdh7PApD6CKl+lkoUtYVmrrgnJQQVv///uq4KOHAT
         Xgd5tSc7aXzPQxIleSo8JgEQ594fi0l4XuCUwuiD5rBTPeyy3eg7E9u/w49YqJR+kp+C
         0TAUTXW+Bq/tq56HcXrlOzF5lTs0WVcOhyxOI7EHlsa2dQbZDrMN36EQCzyL4PkV9GF5
         chkQjw0uKaBgcIRpMKYUsTvwM4BVn8qts5lJEuLQoa+O1y7SBQS0wExrI6wJXChvJemH
         OvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9W7e0eEucLRc1ffg2OOLPtWfKH/j6fIgfCoT9zkmQ4=;
        b=nAsdFPRPdz8srCUPQE5jjdDHVGmT4pwkrKaBHgFP/Nr9rnBsu285HDWXDZ5c4D9NKX
         MzTnT0KmZzYginHWWNtsFmJzdMfjemaTgt7BHMdgqf27HGd9kGNsHCZq1E7NyW3snsyX
         EU3oxxlE1G8dfNc6DSs6gTNIvhKLYCJyT7tgCBZNLEP+aC0ppqg9+RyMfz9aZB6C5MWO
         r/zG5QHg/tFYZAqKnxszaf7ebO9tfBmAqjvErVAnzWlDS+cAWmHbyJe4L1/nKYgYIOrp
         2AJq/GZQjORNTi7VQ//m756mfhsTkCIqndHf6Q4kqlPRifVUhlzU055TkFFshwJcALkz
         Pj+Q==
X-Gm-Message-State: ANhLgQ2imItXUHXZsDyH/BrkSf7uhnLf5+Xd3WaHq8Rhg67GBOR0h5d/
        OuJtuAZCMZfE6eFxbcc3biLHuRbF3ns=
X-Google-Smtp-Source: ADFU+vuZeP7g1drPgTEgVEd4czUpvJueOeRQ2BqyKlM1IT4mE7yQ2PMNjMvQCiGedR/5pUsb+nBRtw==
X-Received: by 2002:a92:d782:: with SMTP id d2mr4233240iln.42.1583347684414;
        Wed, 04 Mar 2020 10:48:04 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c12sm9381900ile.12.2020.03.04.10.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:48:03 -0800 (PST)
Subject: Re: [PATCH 0/4] io-wq/io_uring locking optimisation
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1583314087.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9aeadaac-b225-7988-cd43-d0db565961e6@kernel.dk>
Date:   Wed, 4 Mar 2020 11:48:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <cover.1583314087.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 6:14 AM, Pavel Begunkov wrote:
> [1-3] are shedding excessive locking of @wqe's and @worker's spinlocks
> from io_worker_handle_work().
> 
> [4] removes an extra pair of refcount get/put by making former io_put_work()
> to own the submission reference. It also changes io-wq get/put API
> and renames io_put_work() into io_free_work() to reflect it.

LGTM, and tests out fine so far - applied, thanks.

-- 
Jens Axboe

