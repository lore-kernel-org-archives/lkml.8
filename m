Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170A1C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69DA20773
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 20:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20150623.gappssmtp.com header.i=@draconx-ca.20150623.gappssmtp.com header.b="T368gTjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgCYUrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 16:47:37 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36977 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 16:47:34 -0400
Received: by mail-yb1-f196.google.com with SMTP id n2so640366ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AWwQ/MdaFzRK4+oXN2BrrbghUCKIcq6WVRGHgMwSMoQ=;
        b=T368gTjF0aOe98QD4dHhs2rTWG344V2Rf/iyJgNKx9THKEYXDkjl02/dGNDLFtM7nj
         04M2gV8pQJGD25wSdx29quKI7fxZR9fUUKbpW27ht+0gBDDe0BIeegT9DIUVnzvFKq+f
         TK7HereiGXj+g+xSgBISbCOFKRPOoqQGgv0mN1Bnl+DwR+4x3JUA4SbzhYHLPIqMZr3n
         YqHroq+UvejoVIWB9Hjk4hVnRHq+3gDFm1YUUr/936N2tqcTYb9+aDrA+N+W8hKLasE5
         xkAu6agUKCXW/GEnFUbu8Q6Y0lZN1NOvF68kQevsg/Oda31qEY8rO/vKj9QFb9zzFIf+
         Sbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AWwQ/MdaFzRK4+oXN2BrrbghUCKIcq6WVRGHgMwSMoQ=;
        b=DRjJvrm518JJDFx6RcdZafBewb4oeyvInym2V8hi7H3AhR5pbqP2aapzjntKWvwawg
         /Qg77mVVRcM8/3HeyBnGfaF+qAp//Hcir7tuSgPZ2x2mlH2asnF+dEaIq8OJAtYUm9y8
         MWhZtu40vguwdBsGMCDsqNh/TTBkxR1km0RvlgBlfJmAGI1IKMFhiLLIyiAukj1wu9hY
         IWNREwb03HkzKpw5gzaHv9IVn92M3mZpuR6NjjjPF4rrdG4dCGT0dYXvlRkQCkkfhC+5
         8JuUxuM4qQq5qH7Fo4lcUs4D7etX3Tdpqvpkz1oF+GwUb5HVnhNl87d2qlL7hjmzsjCf
         DXag==
X-Gm-Message-State: ANhLgQ2oFLvraiPZcZBOE7kFfkXl0vpTZeZJ3cwJr64NRjT+TahghV00
        GRIIC5Ryb2NA1w1ZmTsTleoELYQQuYq9QrCABJnZddbIasbiiBM1mr8=
X-Google-Smtp-Source: ADFU+vs1XgkR9lF2quFpA7PJRkEYrsc6qyGubhJKxmGaZZzqqGv+ibNMhD1nbGqx2C3wRh2J97JIomt72sdIrlmtTZA=
X-Received: by 2002:a25:bbcd:: with SMTP id c13mr8893628ybk.9.1585169253378;
 Wed, 25 Mar 2020 13:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1941:0:0:0:0:0 with HTTP; Wed, 25 Mar 2020 13:47:32
 -0700 (PDT)
X-Originating-IP: [216.191.245.228]
In-Reply-To: <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
References: <20200325002847.2140-1-nbowler@draconx.ca> <20200325191103.GA6495@infradead.org>
 <20200325204343.GB4960@redsun51.ssa.fujisawa.hgst.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 25 Mar 2020 16:47:32 -0400
Message-ID: <CADyTPEyKyEc1fx6wRGJAT_QctgMcrB1SWP_9-QdewXU3xYGumw@mail.gmail.com>
Subject: Re: [PATCH] nvme: Fix NVME_IOCTL_ADMIN_CMD compat address handling.
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-25, Keith Busch <kbusch@kernel.org> wrote:
> On Wed, Mar 25, 2020 at 12:11:03PM -0700, Christoph Hellwig wrote:
>> A couple of comments:
>>
>> No need for the "." the end of the subject line.
>>
>> I also think you should just talk of the nvme_user_cmd function,
>> as that also is used for the NVME_IOCTL_IO_CMD ioctl.  Also there now
>> is a nvme_user_cmd64 variant that needs the same fix, can you also
>> include that?
>
> Yes, this patch should get those cases too.
>
> I unstaged this patch for now, could you send a v2 with the suggestions?

Will do.

Cheers,
  Nick
