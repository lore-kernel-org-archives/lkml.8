Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7747C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894D720776
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 06:18:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0Ar/6PC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgCaGSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 02:18:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36121 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgCaGSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 02:18:38 -0400
Received: by mail-ot1-f65.google.com with SMTP id l23so20908048otf.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 23:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Iu81HSTxG1SsZBfktJlKYDr0G43NFWh9lv1Sy96MTe0=;
        b=a0Ar/6PCVDRJTYGp5BgsxcQoxam3GgkocoDAXQubdXGQ6NtX0/aIx2wOHmf9decGva
         jAPxd8r4hcXJ45OeAX67fhMVBvhmuMiShCyQtvZR2HA7U0dYciXVKNU6ItBwS3WoPp5y
         FRaxvLl3IrYIVsF9aYu4cgoUe9dUVxtkLIDytUmpIh0tkjpPZSY1loGoUcg7Ypy/1sAC
         nnwyRYxqVMLH4CnUpNcy70JlHPnZ6OQTxB/NH0PK9Fy9W3pK712ozQ48LatVWntuRG4L
         Bn+P/CS26/In6VTVDdq+G0rOLVysTD1tg4ORInr1dfgRzZlF82GXrmCrjYW5idSVE92D
         y5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Iu81HSTxG1SsZBfktJlKYDr0G43NFWh9lv1Sy96MTe0=;
        b=c7RzPIMVjbY1YPyLXgLmUS0ed1jEI/eSpV/fhGzyXOn6+Sc4UYuH0q0HGRxahpMpnj
         z9hvSsBkYVotQHy27MFhD7EVplyGpjEDY95vkfRp4SsjhOlYoR0H2DpI8hlLbi0C2+2p
         RU4/apWr6wf/fffa9uw3TOROJqPuUb1rsW5/V5HEXZI95xeT931kHGEYdiq6OCiR78i0
         5p6PAnYzmg2QFzGYnbI9mL3qL8odTevZUpLQoWtaJqr/WbFXI56iakdM7X0sIUh9yfrL
         fYWKb6gWSkit+g5LHSMZNmHj5BAws4mWuksjj6UtYa8sXhqWVwfNLlSoCtA9JEXoSS35
         e0UA==
X-Gm-Message-State: ANhLgQ0Vi/DUutH/0IzsP+X7akh3EaVmK0cKBKiNmThcAY4S+8ubF9xk
        TJkW+nKpp9X2Iwgd/Zk/pJPhNHJyfZSghW5VAEqfgA==
X-Google-Smtp-Source: ADFU+vtScDbWfxcXrlQiDNSf9Zu5Rp8qqQ07o0adXyVaf1yzKHkbw9nt9WgLgkqSObFqUGA+Qld8EgZADD5GO3dqwiY=
X-Received: by 2002:a9d:5ad:: with SMTP id 42mr12688911otd.231.1585635517814;
 Mon, 30 Mar 2020 23:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
 <20200331022832.209618-1-saravanak@google.com> <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
In-Reply-To: <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 30 Mar 2020 23:18:01 -0700
Message-ID: <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi,
>
> On 2020-03-31 04:28, Saravana Kannan wrote:
> > When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> > commandline option") added fw_devlink, it didn't implement "permissive"
> > mode correctly.
> >
> > That commit got the device links flags correct to make sure unprobed
> > suppliers don't block the probing of a consumer. However, if a consumer
> > is waiting for mandatory suppliers to register, that could still block a
> > consumer from probing.
> >
> > This commit fixes that by making sure in permissive mode, all suppliers
> > to a consumer are treated as a optional suppliers. So, even if a
> > consumer is waiting for suppliers to register and link itself (using the
> > DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> > blocked from probing.
> >
> > Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> > Hi Marek,
> >
> > If you pull in this patch and then add back in my patch that created the
> > boot problem for you, can you see if that fixes the boot issue for you?
>
> Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
> next-20200327. Thanks! :)

Hi Marek,

Thanks for testing, but I'm not able to find the tag next-20200327. I
can only find next-20200326 and next-20200330. I was just trying to
make sure that next-20200327 doesn't have the revert Greg did. I'm
guessing you meant next-20200326?

> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

Greg,

Can you pull in my fix and then revert the revert?

Thanks,
Saravana
