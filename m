Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3FEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A6D2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TfaRUWxg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHJHaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJHaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:30:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9710CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:29:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so8318287ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 00:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=43SZmp+vV8Sn7GE9PjnhjxxvuNGsA7FckBZzSlZ2a3A=;
        b=TfaRUWxgqzFbKktIb4Hqt920WExOCG8A/B8G6G3gHeQdfzhyhPlBj3W4n4wmXPXo1h
         H3SXSQKn6gjCRj/BO/qLLXhzfMro01CW6pGmfkXR1hG/J0BdHRaNCAoaEamtlVc5Ix0p
         j6FQdh1QoUTYwtEnyVXcm96qmYLTqaCg0ZJ2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=43SZmp+vV8Sn7GE9PjnhjxxvuNGsA7FckBZzSlZ2a3A=;
        b=m5keCF1Z3F3JUq/Pq6XQWFnzzd+2iQxGkMCZg7THAC7Wy9mCO2vpdmsF3IodMm2VXj
         oaTUeJePJdz5YbAsyBlNWvNV4NYnLYSaHzHAV9XQclR5JjQMrK2L7+IWIE2S9/T/QB8M
         GuqcF9Ud5Xb18JQ1BTeIcMxwV7tlnP7kd0G/X9CmwQPWz0TomZkql7qnzSa7kpaWYHYp
         ywYZKqr+0L6I4iAccj4ZFISqGDamlwaRZnlvpG8QH7o9WEnUV2u5+iKFaq3L8nQqK/4e
         0GaEWP47lZ5d6SANAk3WlNqc0oyXC9ypP91y8SPY9DxUFk24rNbXUafE7q1Hg9hlMk/e
         p2Zw==
X-Gm-Message-State: AOAM533whEUD7mO9K/iNP3NH8aLxHwg6N7H9tggHelF/nYcBQycD7+8E
        iqENN3nv9OCnM0eoM7AkjGlfbpNGs9vk0Ru7jD2L8w==
X-Google-Smtp-Source: ABdhPJyciQYT53K7IaRz/5fZqD7hYIYr+Hh6aU/eSXECWt4BwXLBhbw9V/kG4kM7Be3fj25NOBPcRN9OluwZ2eziDe8=
X-Received: by 2002:a17:906:4e4f:: with SMTP id g15mr5805547ejw.443.1597044598271;
 Mon, 10 Aug 2020 00:29:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200807195526.426056-1-vgoyal@redhat.com>
In-Reply-To: <20200807195526.426056-1-vgoyal@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 10 Aug 2020 09:29:47 +0200
Message-ID: <CAJfpegtboe-XssmqrcvsJm1R0FBP8fYFrTMv5cuBhfmebiGfQw@mail.gmail.com>
Subject: Re: [PATCH v2 00/20] virtiofs: Add DAX support
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 9:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>

> Most of the changes are limited to fuse/virtiofs. There are couple
> of changes needed in generic dax infrastructure and couple of changes
> in virtio to be able to access shared memory region.

So what's the plan for merging the different subsystems?  I can take
all that into the fuse tree, but would need ACKs from the respective
maintainers.

Thanks,
Miklos
