Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE298C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDD320753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="AGeMCB2R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgDIRis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:38:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35608 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDIRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:38:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id g3so12902498wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 10:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cB5yBSX4XmqsF1ppUkd5OJUCXOdbq3LIDZ0hfF3NUgw=;
        b=AGeMCB2RRpgTqU0NyD8K0PMZxZc9+wdj85illkNZBFhXaDT9YCV/M4sHa4D+5pqg2O
         xcFqG9jDLQZo3duKjJI2k43wS7IYfPKRw+rB0EmR0stDi++HHUpZETn74dUlqeETl/DK
         2ldu2cXbWe1c/D5YBxpd4VpeItFyYoIF+U+tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cB5yBSX4XmqsF1ppUkd5OJUCXOdbq3LIDZ0hfF3NUgw=;
        b=sTXA9qQ8BsIoajKp/CYlKYnDimPHi/8Jn4cYxnD0VjypL/x+i1biCLA4aZAlnY7Kd4
         yt9EFLYOyFdcwr7aX8lIiSTo3+/y/6i9UBUrTpzKSscc5z+TvXFvCkfTzxy3rFzgmhd4
         k4LtLakS0ZEQzij/jm0wiDgzNS9/L0fWhLKUu8zySKmhddJz/jRBdogDmh7dJ4/S7H0G
         RKAeR6gg7Dxp1kdy5CwIWFGi+LXRplGDL3IMlc7axmIVxnY8ybbmCP5nKevxiXJH8jLB
         xIIwbZHeFm+jIQhfHWIfQsyPMzJ5Kz4reA7TKzL08Tdp/TlGh7cbEMRuZMZOyBBLrkfr
         vOYQ==
X-Gm-Message-State: AGi0PuY4CuzhqfVkeAyhZ2AsCgZHE1dpMKFGYkV+WNTF5sSOC1n3vOJE
        Ej5PlSWtsnduw3WegSk+4rNgPv8crndfgJ7xVvMlgA==
X-Google-Smtp-Source: APiQypKHuqryJeoz1PSWp+rhiE3ZzkNIIf6gabELUM2oO0fS6yQjNadMGyH6yBef5R2sSWoP37RfT6f3UF604jlXS8I=
X-Received: by 2002:adf:fc4f:: with SMTP id e15mr219309wrs.415.1586453926274;
 Thu, 09 Apr 2020 10:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200409150210.15488-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <20200409.101844.1655988786538703860.davem@davemloft.net>
In-Reply-To: <20200409.101844.1655988786538703860.davem@davemloft.net>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 10 Apr 2020 02:38:35 +0900
Message-ID: <CAEYrHjkjYESXHG1x0Obnz+T5xv00vyZKHzUg=ZC70f0JymSU=g@mail.gmail.com>
Subject: Re: [PATCH] nfp: Fix memory leak in nfp_resource_acquire()
To:     David Miller <davem@davemloft.net>
Cc:     Kubota Takafumi <takafumi.kubota1012@sslab.ics.keio.ac.jp>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So sorry about this. It seems like I accidentally touched the patch
file after generating / testing the patch.
I will resend the new patch immediately.

I have tested the patch using kmemleak.

Thanks.

2020=E5=B9=B44=E6=9C=8810=E6=97=A5(=E9=87=91) 2:18 David Miller <davem@dave=
mloft.net>:
>
> From: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> Date: Thu,  9 Apr 2020 15:02:07 +0000
>
> > This patch fixes a memory leak in nfp_resource_acquire(). res->mutex is
> > alllocated in nfp_resource_try_acquire(). However, when
> > msleep_interruptible() or time_is_before_eq_jiffies() fails, it falls
> > into err_fails path where res is freed, but res->mutex is not.
> >
> > Fix this by changing call to free to nfp_resource_release().
> >
> > Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
>
> Did you test compile this?
>
> drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c: In function =
=E2=80=98nfp_resource_acquire=E2=80=99:
> drivers/net/ethernet/netronome/nfp/nfpcore/nfp_resource.c:203:2: error: i=
mplicit declaration of function =E2=80=98nfp_resource_relase=E2=80=99; did =
you mean =E2=80=98nfp_resource_release=E2=80=99? [-Werror=3Dimplicit-functi=
on-declaration]
>   nfp_resource_relase(res);
>   ^~~~~~~~~~~~~~~~~~~
>   nfp_resource_release
>
> And this makes me feel like the test was not runtime tested either.
