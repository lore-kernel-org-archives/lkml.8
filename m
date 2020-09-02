Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0230020829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DGna4WEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgIBOuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgIBOCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:02:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4874EC061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:02:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m23so5868500iol.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lDkSul+1X+RjRffnEyrjfRLNLhJmksxTsX1AB+/HFZE=;
        b=DGna4WEYAKm+GxbC4EXVOI19nH3MAqxS8oOklLe6cjf0oCUQy3fZdZnuRNDEm2ryHs
         4H5pMhYr4q+E31tMFwXx3mGgCMp5FeiLWVzU4oGfFUdZeAxsZ/yAv2H8hd4Q7MlOv9Ir
         9sVmDlzAp9L7waqE7Mjll9U7E3m7VvNDmcbHGSdv5UBvLlBOUpccX9IobYDxb36t0oBS
         7/2qcWRfI/DMC3rMFxRfBSQl3yUkMyar18BijK6EWrxdNKnPHtEIdnOZSidxFJyUDn5n
         gYbGtwYZSogDRv8CnOeKbnuxJy63+EHDxcoUBqqjeQRLKAdASi+x8Uj9+vOj3bHj6bgx
         qQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lDkSul+1X+RjRffnEyrjfRLNLhJmksxTsX1AB+/HFZE=;
        b=L/iAbfhVaW24Nsf4QWPEFOg0PoHUouFjb2t2LAATNqVSJcLxmcs/7vdd0HXi7cosB4
         y5PubiE4c3VV4ir83dG6Hd7CluAtDIawvqMzCzvh55VkYm3Ri3IDNsu696LG1YpDG5wH
         boHBovdwCkK+ufJSE6A8glDBOOdaUFYEQyCuKhKWv0X++lBflAebkdYZgHRiiWZxRP6M
         2A6twaBbQBDgvhat7F6qdBaRI6yYfYGLYv7HekO/XM1kY0kIbKdcQHL6rSmYf1lKJ5j5
         PicmvGa2Wb0/D0Z4O91ic4L+PCclev4RVhxzHgqI+Gqa27LmZ8JsyvpnXTHzQIeeIgc8
         ljQg==
X-Gm-Message-State: AOAM532J3MecDYfRA5F8TAO3aLvf3zeJ/OK2U5L6ZhSFUDNwFfg45pVO
        kGu9B5e/tU+0JCfOUbZkI8NAVw==
X-Google-Smtp-Source: ABdhPJz2H+GfqNyAOWulkP0kGwX7sZTZpsFflW3DrLwTCen2K0siMO2BGfAyARHIbAQRCHZrx3Ln3A==
X-Received: by 2002:a6b:5804:: with SMTP id m4mr3053243iob.14.1599055352059;
        Wed, 02 Sep 2020 07:02:32 -0700 (PDT)
Received: from [192.168.1.57] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z10sm2037885ioi.13.2020.09.02.07.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:02:31 -0700 (PDT)
Subject: Re: [PATCH V2 0/2] percpu_ref & block: reduce memory footprint of
 percpu_ref in fast path
To:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20200902122643.634143-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ce7b53b-2c42-3814-fa0a-5324aca6aae0@kernel.dk>
Date:   Wed, 2 Sep 2020 08:02:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902122643.634143-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 6:26 AM, Ming Lei wrote:
> Hi,
> 
> The 1st patch removes memory footprint of percpu_ref in fast path
> from 7 words to 2 words, since it is often used in fast path and
> embedded in user struct.
> 
> The 2nd patch moves .q_usage_counter to 1st cacheline of
> 'request_queue'.
> 
> Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
> per core) machine, dual socket/numa.
> 
> V2:
> 	- pass 'gfp' to kzalloc() for fixing block/027 failure reported by
> 	kernel test robot
> 	- protect percpu_ref_is_zero() with destroying percpu-refcount by
> 	spin lock  
> 
> Ming Lei (2):
>   percpu_ref: reduce memory footprint of percpu_ref in fast path
>   block: move 'q_usage_counter' into front of 'request_queue'

Applied, thanks.

-- 
Jens Axboe

