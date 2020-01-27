Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0208222527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580161429;
	bh=/J5HvjZvtVETpb0WRJuuNiAFRr3/QMUvz10LmsBegsM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=G1XAOGo2HTfc5a1ZL4P4z3ht1V4olQ9eP8bHrtAQ2VMsoyH3oaT4VRZW5PaG+wjhi
	 LhbtTGCru8J397Ip4cXNf/DpS8cmQtbDX+H6s8Kpgj3Mu90/ZpX6JY5nvD/HAvamRY
	 SpfljUq2si7zy9iZlHz6qGeEWFkbWTiM1HpFSy5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0Vns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:43:48 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46173 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0Vns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:43:48 -0500
Received: by mail-qk1-f194.google.com with SMTP id g195so11213874qke.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NzXG/7+t4gU9Sf61zMQ5YpD603YCkykS7cDqssBMxGY=;
        b=AI87KH1fVC8eU4sMwpBbVdNJCOcTKRKvR3Wvd8Y5h21oyWcMkviHKVZU0DVCra35l2
         2Z2lcMM+VtRi6I7k74FGzqzcr7jz9iHuSeMMdKtsaUXrvSAYVsjZpKjM41yKoQ3cCjpV
         vFoj1q4B1zhGA4u7lMHLNzOyHNtxE/uXVEENIFkr/hswVYGD1rDis6sc6gjrZFdsBAl3
         zBABE8rbeXtYxegxuWIFjELCzFdiGJBrT04ZB8V1RB++8KwR5lQtrJXpXePBkaC68yg/
         y0d+cyjENukTnTpHPYPUHDeBRLbdBtZK+xiFwNoLwiwJqjtQZ8lqJyrJklR52FRTehtd
         IfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=NzXG/7+t4gU9Sf61zMQ5YpD603YCkykS7cDqssBMxGY=;
        b=E9bvkNutc/+cA/1V/Vo6ZTBRgzRHsD2uH+kQuih5yMW5cNFwda30H5eT5BrDc6l0u9
         c6IUKtbWBjnyoBcd9xktPDNGIhh/EFuZaKVKUK5+FiNpjIdN/jJ01Ol8K25cakChZkX8
         GfgPk1ANE+tsRDdcyTVERQHt28gojbrzShV6v2tvD7X9CT/s0mgy8mB+vugXaARs0peR
         bwMYDipf0FjefiJo3EL/nSNwVlRiTCcyEeqwb0r7atX1PHlEzlv3pACK17aq+rqIYEB2
         vn3S7sIP1YiAQjUG7lKt8n120a/mKhpHptB+0vXgxACQBnjwI15sRFMb4yVxE1jUXske
         s4kA==
X-Gm-Message-State: APjAAAVZBUem7031b+RO5DFwLS84bvX6cets2R7NxRh9QP8edlse7gG4
        e6GbEkrNHw6EV1FaSVDbPMM=
X-Google-Smtp-Source: APXvYqwX1s9+uT86YADD+arAvKSWs/ixLP18yeAECd1XZxMBaYXLJoLNsgYCiCuxp2i2pi16dXzaPQ==
X-Received: by 2002:a05:620a:a10:: with SMTP id i16mr18361361qka.205.1580161426874;
        Mon, 27 Jan 2020 13:43:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::19d])
        by smtp.gmail.com with ESMTPSA id v2sm11229378qto.73.2020.01.27.13.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 13:43:46 -0800 (PST)
Date:   Mon, 27 Jan 2020 16:43:45 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [GIT PULL] workqueue changes for v5.6-rc1
Message-ID: <20200127214345.GB180576@mtj.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

Just a couple tracepoint patches.

Thanks.

The following changes since commit 95e20af9fb9ce572129b930967dcb762a318c588:

  Merge tag 'nfs-for-5.5-2' of git://git.linux-nfs.org/projects/anna/linux-nfs (2020-01-14 13:33:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.6

for you to fetch changes up to e8ab20d9bcb3e98b3e205396a56799b276951b64:

  workqueue: remove workqueue_work event class (2020-01-15 08:02:59 -0800)

----------------------------------------------------------------
Daniel Jordan (2):
      workqueue: add worker function to workqueue_execute_end tracepoint
      workqueue: remove workqueue_work event class

 include/trace/events/workqueue.h | 50 ++++++++++++++++++++++------------------
 kernel/workqueue.c               |  2 +-
 2 files changed, 29 insertions(+), 23 deletions(-)

-- 
tejun
