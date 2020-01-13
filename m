Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196AFC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF830206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="RNzqCJVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387464AbgAMDri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:47:38 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39596 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387415AbgAMDrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:47:37 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so7335141qko.6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 19:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PExcPvgc6/JC2Ar9r1T4zc/h/pcxxQjdKuFy6nmEZXA=;
        b=RNzqCJVXNNXnDMN6b2ESf+l0CbgcBiNVVqy/jcbHWp4q7ss6+YegoHwonWgZVonmJE
         xfxi80gDEphZex+Be31dwvw7XppRkdyV0BKleW0GJzFQwurx7CvVMjjGPuUF1nVebsA9
         NO1g94A6EmTb49KTIKSsx5OlZxw+D6aGe+fNUy9UhbWMx+SROFAHh/SfuVdZnPQ4u+QK
         op2q97Tv3KwEkrQ37cyrMWJupZvcD672iBNR8voCr6PmOOLuu2G2nUU2Zd3zDumFHzpA
         CbLlMm0BljoC+VQ0S9Ts+N1TNp0UEsWRWatnQmg7qHO4GyoffUjVD4H8BPVps1y7wAqA
         GhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PExcPvgc6/JC2Ar9r1T4zc/h/pcxxQjdKuFy6nmEZXA=;
        b=Kr+WoI46bkkfE0+3JD5iXYR6xJln7su7Yc7uIyRTHt/YILNncLEzxkhi8x5coRbiJm
         +W5q0ZSFQZUg5t63OtE/5BYHPjOdndZ1IiJcxvIKL1LwvBOq/V4ZZPXpe3dwhfc6kOH4
         c0T0byW0Oyu0rvdwy6Ji/T900RRYzNMTcn9Y0LcCL6NTE0CtMKOAvWNIe7AE7VcUc26p
         Q2NXWpHNeQESFRQYVLQEIFWI7RvKmoB/Pd96/Rktn3iJCcAFIBmHYosrd45RVbXnPDr4
         Svg2RkxzKQmy8Xtly5RbiWf8pwxbxlfBs9PmH/+lLKWRMLerlACowJYIU88IujiZBAmO
         IFeg==
X-Gm-Message-State: APjAAAWtV+EfP0Gfby4vMSwbYWpaTwQX+1CaAriBjUVjThaEgP4MUnpQ
        aIjpqFE0n5vYgFbp8BcgHo9mE/y+ciY83z8ipCKn2w==
X-Google-Smtp-Source: APXvYqwxW6CiHtKx7wgAErCRRHPqiIgBTAMd69XAKg2ZAirZnO7V/RhS3zO7gBXaEoC5wEj5wU+tEYpD5aTQgQa0ASs=
X-Received: by 2002:a37:9ec2:: with SMTP id h185mr14185032qke.14.1578887256821;
 Sun, 12 Jan 2020 19:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20191230083044.11582-1-jian-hong@endlessm.com> <CAD8Lp45Le=s=1Q9oi0JCJTPepNmX002hK7W6UwKztTq09QBUgw@mail.gmail.com>
In-Reply-To: <CAD8Lp45Le=s=1Q9oi0JCJTPepNmX002hK7W6UwKztTq09QBUgw@mail.gmail.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Mon, 13 Jan 2020 11:47:25 +0800
Message-ID: <CAD8Lp44Vd6Moi+UmbdZDsQx-e_CHoHbgtZHpf8sV_yuHwzRrBA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Fix keyboard brightness cannot be
 set to 0
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        nweibley@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2019 at 2:53 PM Daniel Drake <drake@endlessm.com> wrote:
> Here, writing 0x80 to turn off the keyboard LED will result in an
> additional WRAM(0x9f0, 0) call that was not there before. I think we
> should double check this detail.
>
> Let's see if we can borrow one of the affected models and double check
> this patch there before proceeding. I'll follow up internally.

Asus were unable to find a product sample with the affected behaviour.
They did provide us with one from the list I had made, but with a
newer BIOS version where that behaviour has been eliminated. They also
advised that always setting bit 7 is the way they do it on Windows. So
I don't think we have the opportunity for extra verification, but it
should be safe.

Reviewed-by: Daniel Drake <drake@endlessm.com>
