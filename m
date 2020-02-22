Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F37DC35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 233AC20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRN9rxra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgBVG43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:56:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36426 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgBVG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:56:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so4002726oic.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 22:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IDjdYg8G8YiPVzJqdVxwXkt4r11bvSwv5ZKcIJIa3G0=;
        b=dRN9rxraJC8cADe2vTgmjJNySFYRIp5kY1j+hJX0WQKT5Wp6OevL8izFX51cqBwJlV
         y3ExuH471xTGu5aoGqRqhRghCJjZIGVLK3eBTgKyAc04oBBuGGZB+yT6W5FDHUNVZslE
         B6gVLWDJ1f8HG//eXZsfgfnJi9OehpQ5W/Wjk1RaS+sa5iD6BNqe54X30oszNu8qYQ3O
         Y9EslTD6MVfLyeS7m4LDdFPyaAnmRaJ9u632rgio80CX3yj09keQPSWUR/TX4TztMFND
         bZHc1NEnvpyqIfEZ1yLqtbqEp1ixYAQOYll8GNAZmdqEuju5Hz1mqlNWTz3PBYX0fKY/
         n+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IDjdYg8G8YiPVzJqdVxwXkt4r11bvSwv5ZKcIJIa3G0=;
        b=GjzT9Umdbjqv+PuUxhxQpMoKjh5RfgOYvEp6jE3RQMXTYt2EWjTaniixI0zz7D9vNg
         vPEsdPywjRhEpEUJ4G2OMqqrL1HXRSSztPE78lWamQ4+iaETnVHLK+9DYMNXgz/lBSsD
         VLx67aWZNxmBABwkAyGsBwec/INnxnSAw8RBS71cwwQV9GZwRZyzdfTikh0RA+Bm9u8v
         sDVdMIHQjuDtnTj/hTsXDSALZCbBVB7XO1wt+siij6mQCurrIYuySY902FFiavozNvpi
         iX7kw329nzN6d6oDMbmDXtgKHeEGPkTGNBSlRfhDTqCVhQbEWm5k3IuAja5puASgCGwo
         PspQ==
X-Gm-Message-State: APjAAAVUKapRqawiuN9tcHD+JN98wWPniAaSl1+wLcdYyngb998Rx6ED
        jx7wDvh1OUqbizSb5mx6a1cO7EqcWN6lesxoNYDD/L7H
X-Google-Smtp-Source: APXvYqxxz50l3JKdt93c/tA4iWEoS78ZjHNjfS5gljqNYy2epryAzXWTA2jvA0zdemkUA39IB3ybL6QQBHfOj6DdPcY=
X-Received: by 2002:a05:6808:b29:: with SMTP id t9mr5185325oij.69.1582354588351;
 Fri, 21 Feb 2020 22:56:28 -0800 (PST)
MIME-Version: 1.0
References: <7f7d9b37-3f10-fefb-db23-86c8f83e8885@huawei.com>
In-Reply-To: <7f7d9b37-3f10-fefb-db23-86c8f83e8885@huawei.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 21 Feb 2020 22:55:52 -0800
Message-ID: <CAGETcx_eHbVLmfYy5ggMKgXR1MQosLarrfpJA8j65krbvAzEbg@mail.gmail.com>
Subject: Re: Query on device links
To:     John Garry <john.garry@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 2:32 AM John Garry <john.garry@huawei.com> wrote:
>
> Hi guys,

Sorry it took a while to get back.

>
> According to "Limitations" section @
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/device_link.rst#n110,
> for a managed link, lack of the supplier driver may cause indefinite
> delay in probing of the consumer. Is there any way around this?

Currently, no. There's no way to guarantee ordering AND ignore
supplier failures.

> So I just want the probe order attempt of the supplier and consumer to
> be guaranteed, but the supplier probe may not be successful, i.e. does
> not actually bind.
>
> In my case, I would like to use device_link_add(supplier, consumer,
> DL_FLAG_AUTOPROBE_CONSUMER), but I find the supplier probe may fail (and
> not due to -EPROBE_DEFER), and my consumer remains in limbo.

The requirements seem to contradict each other. If you depend on the
supplier, how can you probe the consumer if the supplier fails?

> You may ask my I want this ordering at all - it is because in
> really_probe(), we do the device DMA configure before the actual device
> driver probe, and I just need that ordering to be ensured between devices.

I'm assuming the supplier in your case is the "dma device" (is it an
iommu?)? So if it fails, how is your consumer probing without the
supplier? I'd think something like a DMA would be fundamental?

Why can't this logic be handled in your consumer driver instead of
using device links? Why can't your consumer driver return
-EPROBE_DEFER if the dma ops are not set up correctly until some point
after which (after late_initcall?) the consumer will continue probing
without returning -EPROBE_DEFER even if the supplier isn't there/dma
ops aren't set up?

Can you give a more concrete example of your devices? Or why the
suggestion above might not work?

-Saravana
