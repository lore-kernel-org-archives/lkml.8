Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6148C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD76E20829
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZrXEjqM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHNLxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgHNLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:53:27 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E68EC061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:53:27 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g19so10454832ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RJj+TkYMzHiac1xq1Tf3lQ5iLBSeYwuZiB6gfgnwbY=;
        b=kZrXEjqMlHaOP2Jvq3YGRQ4GTNlXxHsusr71weGy/oFdmmSRzXfR3o4wkjIRXQiIZ/
         6t2FmVkzYveIYXX0fnxAdmZgZhq/VX+bIiZqTQHYr8FIDkvkx6T4vyAXpFlFfmj0Y6Dx
         XHRjn3Agg4TDT3zEe8+OjI+yJw4FrE3xhzk29qa2r5Xw0SxvrPnd7+7UzK3oY9uM30Pg
         O6Q78vHKCkfRnwPQygOuWpBQI9stVRTDDMpU7btgIQ5capgMNBK6BGKNJ7LPa+cl9ccN
         cbJGcwYjd0/uYXrO9BRullrXjFURQD0zsWiL7XSSg7Spemlq63Ff+Uqh58l1q7G06SMm
         IvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RJj+TkYMzHiac1xq1Tf3lQ5iLBSeYwuZiB6gfgnwbY=;
        b=ODzl4S6R8giUso6/yLv7q639CaL36ZHAqCnGZwleNi+ZqQjSkVDYFSqLsMYPqDsWjI
         dLYV4K0Gxlbxik10rULTFDFtOEGRofM4MhVC1BVOzYldhbjIoIotAy99OyO2CWESoIzE
         wkEZU3+/bS8kI07Ea7gh3VbOV3iIQprIjUeX77IQN4fhoDFFLr8dogticEzt5/hElmx4
         rmKIYxnzfDmrWqOLV/ilT3XPBqT22fz43MD51ssvRDdNex75VPH2oXRO3rI62zD/P4aB
         81o2tyYfBIaJJx6U6QF/TBwx+y/Yk/WNh7QQSzabRZUgAw/Q2Ww54EzW5b0bn2oZMVnM
         vWDQ==
X-Gm-Message-State: AOAM531rUrLGcm6KcPc9YRdXiCHZ1I1cdNzZFyPGvZuF8LFtZ8+Zsb/L
        ey/fT9p//nHyHGIVAAM4kOX7dt1zNwp9SBKZ9SNyE/aVT05UYZ1G
X-Google-Smtp-Source: ABdhPJwgpaBwFKnfbf8yPBtOw/1ZjX5D1yc5qFmBupXbTSR6wYkAeXzqmRCEIW7DAftD4q0gZBywXbirls+TkmKO4bY=
X-Received: by 2002:a05:6638:214d:: with SMTP id z13mr2518690jaj.7.1597406006482;
 Fri, 14 Aug 2020 04:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200814071431.201400-1-ztong0001@gmail.com> <20200814081647.GA10347@lst.de>
In-Reply-To: <20200814081647.GA10347@lst.de>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Fri, 14 Aug 2020 07:53:15 -0400
Message-ID: <CAA5qM4BSMiFGe=N9H_YCK79Y2jSurUEbPmdTcaPnVu8cFgmGEA@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: cancel nvme device request before disabling
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oops sorry for the duplicated email -- I forgot to turn off HTML when
sending the previous one.

Thanks Christoph,
I did a couple of fixes on the commit log, please see v2 patch.
Thanks!
-- Tong


On Fri, Aug 14, 2020 at 4:16 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Aug 14, 2020 at 03:14:31AM -0400, Tong Zhang wrote:
> >   This patch addresses an irq free warning and null pointer dereference
> >   error problem when nvme devices got timeout error during initialization.
> >   This problem happens when nvme_timeout() function is called while
> >   nvme_reset_work() is still in execution. This patch fixed the problem by
> >   setting flag of the problematic request to NVME_REQ_CANCELLED before
> >   calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
> >   an error code and let nvme_submit_sync_cmd() fail gracefully.
> >   The following is console output.
>
> The commit log looks a little weird due to the extra indentation.
>
> The patch itself looks good, though:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
