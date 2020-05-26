Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB770208A9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mZ/cPRrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgEZNrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEZNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:47:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F002C03E96F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:47:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so1364651pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8XSa/siiC+feubaj5cYdBKsmqas472F78cogYFY2nU=;
        b=mZ/cPRrL9yBe+FyDGZekgAH3ygoSEQvZ+n0ICNF3QM2IGlEMhCRK8GwJiVcGZ4DFUt
         v0jgCZtojqxrOo6zEPHsBVvhZWM1f8J9y/IaM18rB2g+sbCtFruY3Yl7Y5uPKVdfGgY7
         owWMRJaufKT+QUBkjrk92VJl+CnB00cbvsrcye57H4QqYhdypFBFQR72b3/QCYyQpGVr
         ttMLTaXdJ20NlBg+QHGJdMxMmHJlak3F/7olf9GnGxN6Tz25bepZwElnNhQEYqN4hOQ4
         B3vAo8YFtRTU3QPuhab/dKF3n5aX2i4T8QAeShp9ly0EJiAc7fo/sxeyQJfQMJ9vt3NH
         q28Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8XSa/siiC+feubaj5cYdBKsmqas472F78cogYFY2nU=;
        b=K+21wpryMRsbKQ/DM0T7HnDty1AVTPVPsWgXqyQ+AJUBZYEMC4NcTAZNvecaZ8RwOy
         olNLAJuQXLog0uRukMsPmfSDm/NDzfoVn9fB1siy3BYwWmHhd07NwSDktddzlMwPLmU8
         KrxnixR7j0H7T5dv81kkqN0SQH7jvFekPGCR2rPK2atCRa+8NWLIQW0GKA6lfai3r/vg
         0q+1Rv4lKSIq4BCmDv7fiInsCzzEGis5zowrwmSFY4RkCoa90qgDrofumuVS3j3SPBtJ
         OCMaiEzD3/KBI5qJWv8jnFw1LF+OpZYluU5VkEPI5w/AqKoA2cVW+XcQlKWJyEIDteSk
         hBnw==
X-Gm-Message-State: AOAM532S5Qfmklp2CrSWpvhNfmSwZtzffZBtPMdMAxdnkRyevUrHJ5NL
        owEv2h9Rm4RlS/X96OKOb73GTg==
X-Google-Smtp-Source: ABdhPJyFr6HoXe28+9kfuFiHevoxeAadV85o31fPsOqpWPAWa0zZoXCjI1ao9HS9V1lk2CtFLKryIA==
X-Received: by 2002:a17:902:b289:: with SMTP id u9mr1211767plr.138.1590500842958;
        Tue, 26 May 2020 06:47:22 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:a9e6:df54:e55e:4c47? ([2605:e000:100e:8c61:a9e6:df54:e55e:4c47])
        by smtp.gmail.com with ESMTPSA id 128sm15158827pfd.114.2020.05.26.06.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 06:47:22 -0700 (PDT)
Subject: Re: [PATCH 12/12] io_uring: support true async buffered reads, if
 file provides it
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200523185755.8494-1-axboe@kernel.dk>
 <20200523185755.8494-13-axboe@kernel.dk>
 <9c2cc031-e4ce-4c5f-5e14-21ea48c327f6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fe94b8ba-410e-8a14-5382-463e42dabf5f@kernel.dk>
Date:   Tue, 26 May 2020 07:47:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9c2cc031-e4ce-4c5f-5e14-21ea48c327f6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 1:38 AM, Pavel Begunkov wrote:
> On 23/05/2020 21:57, Jens Axboe wrote:
>> If the file is flagged with FMODE_BUF_RASYNC, then we don't have to punt
>> the buffered read to an io-wq worker. Instead we can rely on page
>> unlocking callbacks to support retry based async IO. This is a lot more
>> efficient than doing async thread offload.
>>
>> The retry is done similarly to how we handle poll based retry. From
>> the unlock callback, we simply queue the retry to a task_work based
>> handler.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/io_uring.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 99 insertions(+)
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index e95481c552ff..dd532d2634c2 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -498,6 +498,8 @@ struct io_async_rw {
>>  	struct iovec			*iov;
>>  	ssize_t				nr_segs;
>>  	ssize_t				size;
>> +	struct wait_page_queue		wpq;
>> +	struct callback_head		task_work;
>>  };
>>  
>>  struct io_async_ctx {
>> @@ -2568,6 +2570,99 @@ static int io_read_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>  	return 0;
>>  }
>>  
>> +static void io_async_buf_cancel(struct callback_head *cb)
>> +{
>> +	struct io_async_rw *rw;
>> +	struct io_ring_ctx *ctx;
>> +	struct io_kiocb *req;
>> +
>> +	rw = container_of(cb, struct io_async_rw, task_work);
>> +	req = rw->wpq.wait.private;
>> +	ctx = req->ctx;
>> +
>> +	spin_lock_irq(&ctx->completion_lock);
>> +	io_cqring_fill_event(req, -ECANCELED);
> 
> It seems like it should go through kiocb_done()/io_complete_rw_common().
> My concern is missing io_put_kbuf().

Yeah, I noticed that too after sending it out. If you look at the
current one that I updated yesterday, it does add that (and also
renames the iter read helper):

https://git.kernel.dk/cgit/linux-block/commit/?h=async-buffered.5&id=6f4e3a4066d0db3e3478e58cc250afb16d8d4d91

-- 
Jens Axboe

