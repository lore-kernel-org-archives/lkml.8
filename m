Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9619C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D3E205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nM3uzpU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHQOMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbgHQOM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:12:29 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D21C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:12:29 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so8172308pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wOYrYDva8jy68+Dm5u/UVVy7tRdDUGLfDfrn2aQGQkA=;
        b=nM3uzpU5k4+7INekb0Ll8AyIsmiU7MLmm9Le7ENeK8DBnJLMTfwNVb2YxI9T3blkqw
         OcDH1xczqRRPsccE2oiqG4XfMVcrqh5UedMbTeb0cXQIwG8KdLlZtsZ4MhF97RAE2HzP
         JgHcpR3CsvPwQ+256Vj5X2QMf3BR/uSrb6brajQZYHXED22vQ7npaP33ioJznwUOahQI
         wavuc9ZINhECvfmZwDXML8psGCkVCKgupp3Xm4cggmnP/uArzea+sv/pDF7JrCxRUywd
         hl1iXOJdbtV27lsNpL1+Vb9hN/W78vz0LD/ERCSNSyHdBKHh1y/AYDVeAVyMfeWTKYJa
         tLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wOYrYDva8jy68+Dm5u/UVVy7tRdDUGLfDfrn2aQGQkA=;
        b=b3Vg9DnWHRaTsgRGAB75JW1tmySAPaPZgBsRQqW/n/6SQ+6CMvdwbL1njfsVzw6jRU
         uDPBq3TYxuROE8UvhCwtZQ6aktwBzTRDzJ+I+NAYsANfCdPkQ90Rxj7/2JqfHDr60MI2
         5f7D/G8o1AiV/mC2giZU18Wg99DzN7FyDBE6vUBzuZB/IfrQeMvlikv7IJt/Eu1vytrb
         rH9ozZKbFXpSfu3kIrA4rN03UmH57iXP+kSik2vKnDC63q29x4K2cdbPYnejGnfGmwho
         XR9DU7EOpy4++8LCcdP89dtYq49f11SpRvcDJVFS2d83zpa4vn8nLSmyEgS/cXEMdZau
         Mtag==
X-Gm-Message-State: AOAM531CVv4uTdC+nymOgBmyvRbCtxh5qzBpl5RqxPubAVID1tx4nrgx
        tJESulqlUkxKR+W9ApBM+koNAg==
X-Google-Smtp-Source: ABdhPJz5CI6yy4OAkfcNJdiaUfF/ltcEc/+9zpkC4/nmJmAkSThVlxgtuSmoDX4gXwLU0BjOkpjpZA==
X-Received: by 2002:a63:8f08:: with SMTP id n8mr10519826pgd.9.1597673548863;
        Mon, 17 Aug 2020 07:12:28 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ff2c:a74f:a461:daa2? ([2605:e000:100e:8c61:ff2c:a74f:a461:daa2])
        by smtp.gmail.com with ESMTPSA id fv23sm17465333pjb.35.2020.08.17.07.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 07:12:28 -0700 (PDT)
Subject: Re: [PATCH 2/2] block: fix ioprio_get/set(IOPRIO_WHO_PGRP) vs
 setuid(2)
To:     Davidlohr Bueso <dave@stgolabs.net>, akpm@linux-foundation.org
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
References: <20200817003148.23691-1-dave@stgolabs.net>
 <20200817003148.23691-3-dave@stgolabs.net>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2741d70f-31a9-3f8f-d74d-ce3de4c1bd3d@kernel.dk>
Date:   Mon, 17 Aug 2020 07:12:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817003148.23691-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/16/20 5:31 PM, Davidlohr Bueso wrote:
> do_each_pid_thread(PIDTYPE_PGID) can race with a concurrent
> change_pid(PIDTYPE_PGID) that can move the task from one hlist
> to another while iterating. Serialize ioprio_get/set to take
> the tasklist_lock in this case.

LGTM:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

