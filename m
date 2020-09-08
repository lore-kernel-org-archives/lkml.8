Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E532C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3D52068D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="AKeahh29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgIHTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731235AbgIHTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:00:13 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23AEC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 12:00:12 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so75050pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GV/iqESZ2B/JWCPhKBYdc1HMXEWUP6X/GFX7ukcYRCc=;
        b=AKeahh29FRXDGBXnQjzSIcarVKtmq38CxwAoB6TIwDU1z5eEMqESkkM6AOI3qcWUXI
         QXybrGeceZuWdooQd6Ahhr7FZanmq04jcIgL/NxxY16dTqLalRglfGD5RSGwXJlgHohK
         lQi+Xam2gpoIu02XBhynueixypqoi1xRQaah1Du8lrzaymU1uXk0uO2EXr/QnAYJNtGE
         RIjrrhv2zVCxniSFcfmbBvcG3BYOSnEHVDzLJ2liwgfW3aukQQ6apEaTOcX2iWGqAWCw
         7LuXe2v/HVoJdiX92R3JHlHIatuZJC6rx47wnHvXOTWIRv7mOliX/C2jGR7BNmW0KFwV
         MFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GV/iqESZ2B/JWCPhKBYdc1HMXEWUP6X/GFX7ukcYRCc=;
        b=S5gBxY6xtpzQ95EetQG9NEEYG7TVFZfZho+hdJj9vU6fW8y0erOaPCsgMa8+CQSI8h
         1MF8/uOkm9jikwmvuLm6Kx15GDDWLo4CKsoZLSbym5fHUwO/geOg68CXO+Ngl6LDLon4
         g/NzVHH7FYg2dFSMjI9IUb0nXs8LNC4Ga4BZJ8zh6q+4RXgWLahg6sGnPbDvx23YzeAu
         uNunaB9ACh2zovmTMHu3Nxn2qcApsdhiJbqiTfVfrZFOqTaZILz4WuCfM8rzgdDIrt/Q
         p2epQrtleknUCYKp7e1ZNsxGFxgv9lZVZtxed50W4SO0Xl2fbQ3bjveNrefoKMOiU+90
         vQig==
X-Gm-Message-State: AOAM531VDWtZz/Ba9f57vCT8NxfrKNtLLCaMALj+/T9axFmRny1TTOLv
        J9YNDJw2M1sHP6S8Au1/9zjzsw==
X-Google-Smtp-Source: ABdhPJx5rumcfM7Ht6IyzlNP3RKqgmYM/0YyydX7QIAP1xK9uKQOzi1qgTWBBWjVdlyxgacb07hiEA==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr212478pjr.207.1599591612227;
        Tue, 08 Sep 2020 12:00:12 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:ec83])
        by smtp.gmail.com with ESMTPSA id e125sm159782pfe.154.2020.09.08.12.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:00:11 -0700 (PDT)
Date:   Tue, 8 Sep 2020 12:00:09 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yang Yang <yang.yang@vivo.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, onlyfever@icloud.com
Subject: Re: [PATCH] kyber: Fix crash in kyber_finish_request()
Message-ID: <20200908190009.GA142421@relinquished.localdomain>
References: <20200907074346.5383-1-yang.yang@vivo.com>
 <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b714da7-97b2-f8d2-4be7-c192130c33af@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:41:16AM -0600, Jens Axboe wrote:
> CC Omar
> 
> On 9/7/20 1:43 AM, Yang Yang wrote:
> > Kernel crash when requeue flush request.
> > It can be reproduced as below:
> > 
> > [    2.517297] Unable to handle kernel paging request at virtual address ffffffd8071c0b00
> > ...
> > [    2.517468] pc : clear_bit+0x18/0x2c
> > [    2.517502] lr : sbitmap_queue_clear+0x40/0x228
> > [    2.517503] sp : ffffff800832bc60 pstate : 00c00145
> > ...
> > [    2.517599] Process ksoftirqd/5 (pid: 51, stack limit = 0xffffff8008328000)
> > [    2.517602] Call trace:
> > [    2.517606]  clear_bit+0x18/0x2c
> > [    2.517619]  kyber_finish_request+0x74/0x80
> > [    2.517627]  blk_mq_requeue_request+0x3c/0xc0
> > [    2.517637]  __scsi_queue_insert+0x11c/0x148
> > [    2.517640]  scsi_softirq_done+0x114/0x130
> > [    2.517643]  blk_done_softirq+0x7c/0xb0
> > [    2.517651]  __do_softirq+0x208/0x3bc
> > [    2.517657]  run_ksoftirqd+0x34/0x60
> > [    2.517663]  smpboot_thread_fn+0x1c4/0x2c0
> > [    2.517667]  kthread+0x110/0x120
> > [    2.517669]  ret_from_fork+0x10/0x18
> > 
> > Signed-off-by: Yang Yang <yang.yang@vivo.com>
> > ---
> >  block/kyber-iosched.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
> > index a38c5ab103d1..af73afe7a05c 100644
> > --- a/block/kyber-iosched.c
> > +++ b/block/kyber-iosched.c
> > @@ -611,6 +611,9 @@ static void kyber_finish_request(struct request *rq)
> >  {
> >  	struct kyber_queue_data *kqd = rq->q->elevator->elevator_data;
> >  
> > +	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
> > +		return;
> > +
> >  	rq_clear_domain_token(kqd, rq);
> >  }
> >  
> > 

It looks like BFQ also has this check. Wouldn't it make more sense to
check it in blk-mq, like we do for .finish_request() in
blk_mq_free_request()? Something along these lines:

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c34b090178a9..fa98470df3f0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5895,18 +5895,6 @@ static void bfq_finish_requeue_request(struct request *rq)
 	struct bfq_queue *bfqq = RQ_BFQQ(rq);
 	struct bfq_data *bfqd;
 
-	/*
-	 * Requeue and finish hooks are invoked in blk-mq without
-	 * checking whether the involved request is actually still
-	 * referenced in the scheduler. To handle this fact, the
-	 * following two checks make this function exit in case of
-	 * spurious invocations, for which there is nothing to do.
-	 *
-	 * First, check whether rq has nothing to do with an elevator.
-	 */
-	if (unlikely(!(rq->rq_flags & RQF_ELVPRIV)))
-		return;
-
 	/*
 	 * rq either is not associated with any icq, or is an already
 	 * requeued request that has not (yet) been re-inserted into
diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index 126021fc3a11..e81ca1bf6e10 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -66,7 +66,7 @@ static inline void blk_mq_sched_requeue_request(struct request *rq)
 	struct request_queue *q = rq->q;
 	struct elevator_queue *e = q->elevator;
 
-	if (e && e->type->ops.requeue_request)
+	if ((rq->rq_flags & RQF_ELVPRIV) && e && e->type->ops.requeue_request)
 		e->type->ops.requeue_request(rq);
 }
 
