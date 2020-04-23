Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3773CC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 177DB20CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 22:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUYiU6Ce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgDWWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 18:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbgDWWmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 18:42:51 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821DFC09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:42:51 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d74so2225806vka.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LJ6/10OQi+IjRoROw1bmmwZkTPHiPo4CeITaSJNBJxE=;
        b=lUYiU6CeDZLAwgfkrnPClfL9mW4Mccm3WgHBgOyJm3Ce+xg7lS02F8RLKC12vsJ7kl
         VaUzf3INAB4d7QhmeUNBWEZKfokkpuhEy9WQMrxDINFnlAD4RmaDOCx2fpGw5h+Ro1AT
         Xpnf7jZMZa1SZfYaLwydYhfmGM70QXxDKJwJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LJ6/10OQi+IjRoROw1bmmwZkTPHiPo4CeITaSJNBJxE=;
        b=NQY1slS4qifuN7Oiz5XC1REZtktJADX0eReoolidqOL89ntXCTpunsymYvYSQYzA9h
         qobiMtuXwvI6MmaoktLjwjJndNINVYNocqbuXwqvOv6daExEJAI732nRCH5FawwDmv0f
         8ZCroOO0o+luEqUB03r3KXKP3n9h2LS1LRA9lkF3EoOiVHYFBGG9mPoDhIo8W+RnZIvK
         UbQkrcmZDon8VoMVXKaKyBP97P8rg23g1lVhhQTlJdTzgE9TzCF+i2PxkSRzsFKRtxBL
         58fNu0nLLcjIRQihSQM06/uxMGZQn6dZElh1SrwEHKuibb9pBm8rvjSyZkSyYk6YECz6
         MlmQ==
X-Gm-Message-State: AGi0PuamoXdoetRsc73hVrk7l3ViApCmWF0HZAb8dFbbwE9+fwPF67XV
        6zXHPIelBiHLfgQPxKd9ZeW+3XLTuEA=
X-Google-Smtp-Source: APiQypKPe1kIL0tPp54jReW3pJCtTG/5DjrzgCChmiMBlWjY8Bt3DTbJfgyq53OW2/68o7mAmGf0hw==
X-Received: by 2002:a1f:eb81:: with SMTP id j123mr5652310vkh.16.1587681770187;
        Thu, 23 Apr 2020 15:42:50 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 204sm1088966vka.32.2020.04.23.15.42.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 15:42:49 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id 36so3490062uaf.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 15:42:48 -0700 (PDT)
X-Received: by 2002:a05:6102:4d:: with SMTP id k13mr5446791vsp.198.1587681768455;
 Thu, 23 Apr 2020 15:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <1587035931-125028-1-git-send-email-john.garry@huawei.com>
 <e5416179-2ba0-c9a8-1b86-d52eae29e146@acm.org> <663d472a-5bde-4b89-3137-c7bfdf4d7b97@huawei.com>
In-Reply-To: <663d472a-5bde-4b89-3137-c7bfdf4d7b97@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 23 Apr 2020 15:42:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XBrKgng+vYzJx+qsOEZ-cZ10A0t+pRh=FcbQMop2ht4Q@mail.gmail.com>
Message-ID: <CAD=FV=XBrKgng+vYzJx+qsOEZ-cZ10A0t+pRh=FcbQMop2ht4Q@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: Put driver tag in blk_mq_dispatch_rq_list() when
 no budget
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 20, 2020 at 1:23 AM John Garry <john.garry@huawei.com> wrote:
>
> On 18/04/2020 03:43, Bart Van Assche wrote:
> > On 2020-04-16 04:18, John Garry wrote:
> >> If in blk_mq_dispatch_rq_list() we find no budget, then we break of the
> >> dispatch loop, but the request may keep the driver tag, evaulated
> >> in 'nxt' in the previous loop iteration.
> >>
> >> Fix by putting the driver tag for that request.
> >>
> >> Signed-off-by: John Garry <john.garry@huawei.com>
> >>
> >> diff --git a/block/blk-mq.c b/block/blk-mq.c
> >> index 8e56884fd2e9..a7785df2c944 100644
> >> --- a/block/blk-mq.c
> >> +++ b/block/blk-mq.c
> >> @@ -1222,8 +1222,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
> >>              rq = list_first_entry(list, struct request, queuelist);
> >>
> >>              hctx = rq->mq_hctx;
> >> -            if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
> >> +            if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
> >> +                    blk_mq_put_driver_tag(rq);
> >>                      break;
> >> +            }
> >>
> >>              if (!blk_mq_get_driver_tag(rq)) {
> >>                      /*
> >
> > Is this something that can only happen if q->mq_ops->queue_rq(hctx, &bd)
> > returns another value than BLK_STS_OK, BLK_STS_RESOURCE and
> > BLK_STS_DEV_RESOURCE?
>
> Right, as that case is handled in blk_mq_handle_dev_resource()
>
> If so, please add a comment in the source code
> > that explains this.
>
> So important that we should now do this in an extra patch?
>
> >
> > Is this perhaps a bug fix for 0bca799b9280 ("blk-mq: order getting
> > budget and driver tag")? If so, please mention this and add Cc tags for
> > the people who were Cc-ed on that patch.
>
> So it looks like 0bca799b9280 had a flaw, but I am not sure if anything
> got broken there and worthy of stable backport.
>
> I found this issue while debugging Ming's blk-mq cpu hotplug patchset,
> which I feel is ready to merge.
>
> Having said that, this nasty issue did take > 1 day for me to debug...
> so let me know.

As per the above conversation, presumably this should go to stable
then for any kernel that has commit 0bca799b9280 ("blk-mq: order
getting budget and driver tag")?  For instance, I think 4.19 would be
affected?  When I picked it there I got a conflict due to not having
commit ea4f995ee8b8 ("blk-mq: cache request hardware queue mapping")
but I think it's just a context collision and easy to resolve.

I'm no expert in the block code, but I posted my backport to 4.19 at
<https://crrev.com/c/2163313>.  I'm happy to send an email as a patch
to the list too or double-check that someone else's conflict
resolution matches mine.

-Doug
