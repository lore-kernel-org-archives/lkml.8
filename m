Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FFCC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33CDA20740
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="1bI5iX83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgCYUPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:15:47 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:45569 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYUPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:15:46 -0400
Received: by mail-yb1-f194.google.com with SMTP id g6so1908344ybh.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=U9D+d1lkDOvY3jeOBPuO7Icj5Xdqu64zCQHeR+0ymMw=;
        b=1bI5iX83n8BVyIBOKwYfKEvPXes98TPrR/QW4i5Fn29deq1p7emf99X6Hb/bc3Qqtw
         JHcZXgl0E2NbaEFIa0HYz/WeQUX8mdBQD8h3MFyHzRx4GUD9EpY7+lSRg/N55W4Xr4OQ
         1KVj+8Y5lF3rYCQaqyPCGC1Xg4SEqYMZsoWHO3GKoy3oD39aESDv4CgtDVV+z3ugy8fp
         BQ2IeOhpwk5GuDmYubtAQ3msYhq7UHta6UHET9Yfbno4zs0ssayAlbFHz/a52PfFnDqP
         KsZeYUyS/z7/wIIKHvST+1J+1V7NfcExSEANpwNJfsFm9sJJ/JZJeIukAgLYzMQUR7wh
         eFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=U9D+d1lkDOvY3jeOBPuO7Icj5Xdqu64zCQHeR+0ymMw=;
        b=aHyo+hq+fFf8EE/qehrPz3cPY3ltLZbkHzxg9IAwGKZhwuR/NtZtbvi2F1i44+MUWd
         3J/YsKlj8oML0Vd4p5z+lKq+FGoPReXwHoG9JyQ9ZDaP6kkIoYSzfVAcvNCwGRxUTAax
         aUr9lNlqizHlRpSa+g9AM3+KTG0lSpFy5jJ/ck2S/1HpdvIPrFqycBmNtjBzzeCbPmW/
         DmwVNeAwgkP9NyR8gCXGtghmRn4yOTpT/n6duZ2mPL0fpTXGKtMB1ndq1kfNQFFqqFoA
         OfU2OJDtHp3MFeQ1vMgD0ikivFnLVxdHhV8HBRAD5hp1Jja6opk1klDc+rkq4o/NOKxd
         3zLQ==
X-Gm-Message-State: ANhLgQ2JjPuAdPcd26DMIYpWn+g6z0XN0v9tmjnuzlylwnEJIC4wnrGu
        NNtzYJi/xE08AMoihP+p1bqKQApYBhc/u2RvicjSYw==
X-Google-Smtp-Source: ADFU+vuM02H6ICaiZc32JwHkwBz3Mc9JSjcdyCVArIFiYz43WnMJm2z4Vf/i1pRiVxLU3WLvh9WOdTZSIGyheL3m46c=
X-Received: by 2002:a25:ba0a:: with SMTP id t10mr8734659ybg.393.1585167345773;
 Wed, 25 Mar 2020 13:15:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1941:0:0:0:0:0 with HTTP; Wed, 25 Mar 2020 13:15:44
 -0700 (PDT)
X-Originating-IP: [216.191.245.228]
In-Reply-To: <20200325191103.GA6495@infradead.org>
References: <20200325002847.2140-1-nbowler@draconx.ca> <20200325191103.GA6495@infradead.org>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 25 Mar 2020 16:15:44 -0400
Message-ID: <CADyTPExA+Ng=QR33ZMA9qffSOEMrMVDsgU3G2nLvA9Zn3DYD+w@mail.gmail.com>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2020, Christoph Hellwig <hch@infradead.org> wrote:
> A couple of comments:
>
> No need for the "." the end of the subject line.
>
> I also think you should just talk of the nvme_user_cmd function,
> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
> is a nvme_user_cmd64 variant that needs the same fix, can you also
> include that?

Fair enough.  I can make the same change there... but I don't know how
to actually test the nvme_user_cmd64 function because I cannot find any
users of the NVME_IOCTL_ADMIN64_CMD or NVME_IOCTL_IO64_CMD ioctls.

>> +	if (in_compat_syscall()) {
>> +		/*
>> +		 * On real 32-bit kernels this implementation ignores the
>> +		 * upper bits of address fields so we must replicate that
>> +		 * behaviour in the compat case.
>
> s/real //g please, there are no fake 32-vit kernels :)

OK.

I shall prepare a v2 patch then with this feedback addressed.

Thanks,
  Nick
