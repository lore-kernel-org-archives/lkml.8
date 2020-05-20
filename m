Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC82C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE65C207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WnNmS2VB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgETOrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgETOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:47:39 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD8C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:47:39 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w19so1411277ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kArQ+7y4L6frg88ICtlSJa9zVlyeVvUtuDGqusIcsBk=;
        b=WnNmS2VBKjBI77hVvKte2NJr2utSHOxsd68MFTv7UPPkqqjByh4JvmD+jk+s79+RN2
         bPgfEc19G9eaqjZe3NK8v4whqk0JP3eKYu8zdFCguqv3sV7ZehXtS8NyQTltFjx1Mlac
         CQUVxU6sLNo6k90DkqRPu4DU1V/CKLjkyaWvRhzYd4Hdq+jIygmgR/Bh6pC/uyWu3kdk
         x9f/ehyF4kFW7/6ffqCVlxU6TI2zyv+OpKq2Zl3WCpW5BVB6+/rsE8Uo8ChJ0cZtfNMA
         tO+zASgkMfIUOc5JURKjuLT8EilupPcd0QCNLmMlp72oodOzoH2d0M36VohaTisvvvPm
         STZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kArQ+7y4L6frg88ICtlSJa9zVlyeVvUtuDGqusIcsBk=;
        b=CHCjfO0VBJTCZjZjdKCqFvxFvtezbbQjggDaUit8XjFhSNz6NlTcnf/hHrMLSHLpvW
         LoHDdd7oVUbmp2JQgiRIJTKupXdjaWUAUE1QskiK1nzmdblcmUmOuchBcZvEoThAQjI6
         bWieCLJSytJnjIs32cq7r7K6OtgT9lj+ZsxUCTsBCxLIteBqeCOqHn84Li57iL23A0op
         4AJ4THVJRSt1fV1KYX+7vBZVxA3iH2W96OFP+01kwVaz1dJbfNpYSTxbfq28GTikkbCf
         rMT6HtaitXMX7zyZ5PXRtYkKoWLZHIKpcmSxNsXcwNVvG6OQFTOIXDodBAAA7vjgky/3
         IU/A==
X-Gm-Message-State: AOAM533iPvfNEFEtFl2yKmn4hpfM9GvrSKdIobzSdxpfcGfg22Ccgzvr
        6kmgjeerBCD+Zb2GwRCA5PAlTA==
X-Google-Smtp-Source: ABdhPJxNP8jNR/AeDMvtQX+mgoEcBr8O0kpb7Aq9uRE7lSIIlhtfMvDn1adZ2FD9SnGCkGedpejq5Q==
X-Received: by 2002:a17:902:8ec5:: with SMTP id x5mr4948289plo.149.1589986058525;
        Wed, 20 May 2020 07:47:38 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id q201sm2398914pfq.40.2020.05.20.07.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 07:47:37 -0700 (PDT)
Subject: Re: io_uring vs CPU hotplug, was Re: [PATCH 5/9] blk-mq: don't set
 data->ctx and data->hctx in blk_mq_alloc_request_hctx
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-block@vger.kernel.org, John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>, io-uring@vger.kernel.org
References: <20200518093155.GB35380@T590>
 <87imgty15d.fsf@nanos.tec.linutronix.de> <20200518115454.GA46364@T590>
 <20200518131634.GA645@lst.de> <20200518141107.GA50374@T590>
 <20200518165619.GA17465@lst.de> <20200519015420.GA70957@T590>
 <20200519153000.GB22286@lst.de> <20200520011823.GA415158@T590>
 <20200520030424.GI416136@T590> <20200520080357.GA4197@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8f893bb8-66a9-d311-ebd8-d5ccd8302a0d@kernel.dk>
Date:   Wed, 20 May 2020 08:45:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520080357.GA4197@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 2:03 AM, Christoph Hellwig wrote:
> On Wed, May 20, 2020 at 11:04:24AM +0800, Ming Lei wrote:
>> On Wed, May 20, 2020 at 09:18:23AM +0800, Ming Lei wrote:
>>> On Tue, May 19, 2020 at 05:30:00PM +0200, Christoph Hellwig wrote:
>>>> On Tue, May 19, 2020 at 09:54:20AM +0800, Ming Lei wrote:
>>>>> As Thomas clarified, workqueue hasn't such issue any more, and only other
>>>>> per CPU kthreads can run until the CPU clears the online bit.
>>>>>
>>>>> So the question is if IO can be submitted from such kernel context?
>>>>
>>>> What other per-CPU kthreads even exist?
>>>
>>> I don't know, so expose to wider audiences.
>>
>> One user is io uring with IORING_SETUP_SQPOLL & IORING_SETUP_SQ_AFF, see
>> io_sq_offload_start(), and it is a IO submission kthread.
> 
> As far as I can tell that code is buggy, as it still needs to migrate
> the thread away when the cpu is offlined.  This isn't a per-cpu kthread
> in the sene of having one for each CPU.
> 
> Jens?

It just uses kthread_create_on_cpu(), nothing home grown. Pretty sure
they just break affinity if that CPU goes offline.

-- 
Jens Axboe

