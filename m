Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1B7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D6E920639
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 09:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiXoJqDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHSJ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 05:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgHSJ1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:27:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD5C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:27:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t14so1430041wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lVH13tdAzC6mW/dwhV6wM3c3cw0w+EwXAkE9fSxw6kk=;
        b=LiXoJqDEZa5lyE4ikb0YCl1GOpEyvF7YoJVZ3kOe+9PbwXYwTgsNunyBrTmnHpcwLS
         AycdLYrvYIpvnEsRb768v0N/KWszt83KWkhoZzXjI3eH1VMUG6mbDoqEFLy1K6QxIMOC
         1hVDWDu2nR1b+z89w6enM8EpzLNUN4QnBB2IY0SBnjvjtVM2P10D5cIoDVZgXGJh4GaL
         j5U8omvfmoAHsNIrqNSuho6gPySbtyWgNfmPBHhew2sO50S7vkaRhIOltkVWhPE00LHW
         0dxpLaSf4HgAo7voQQH0d2vcYfSwwFPXR98OGRdl9b6DxcDSL5Yt1dBGtfj1NMg51NKL
         49Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lVH13tdAzC6mW/dwhV6wM3c3cw0w+EwXAkE9fSxw6kk=;
        b=J+6TSS+ZngdlJFJaWT2bVrK9/ZKBaPAgUwRP8yfPAxHI68k/D8TegszJ+kRCvS2rq9
         aECzUouQ5BeOt6bBrFG9ugUI9gPftVsUL8XK7SmDyjvts/ETam/XCTAEdHGNmIBlxn1C
         uS56rN9WKeuStLDVz0o2BeM9NmNfrumqQckzpxAK9CMAloBnjLYBRiGgP26aReOUdQ5n
         eVsTcW54vrxugSsuDsK2yDnA540d6y1dsdu6Fmy+ZCFtOhfQtB4rhwbPnoiWW/DR5Ypf
         REku43/9gYWMQdNSDG6TbHxr5Y82zetIFX/49ESoT/HukOF/5IUZHgEmVF3bKCUNaXHd
         ZH9Q==
X-Gm-Message-State: AOAM533+ED3LoVPyeWZRsyIbYH3NbYo8tyEQryIZkx+Btj3EXa4YVpyT
        7550qhclTEzA5orszVu/mTa98xCu+No9XplOfW8=
X-Google-Smtp-Source: ABdhPJw+vfNm6gcyC15QGjAi/+l7apLAwW4FOchrK0YZEt7izxf65sSx5B4ycnxIWcXGiEbZh+MIcEEgwnJLJgGiw2I=
X-Received: by 2002:a1c:32c3:: with SMTP id y186mr3986004wmy.15.1597829216005;
 Wed, 19 Aug 2020 02:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200818052936.10995-1-joshi.k@samsung.com> <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
 <20200818052936.10995-2-joshi.k@samsung.com> <20200818071141.GA2544@lst.de>
In-Reply-To: <20200818071141.GA2544@lst.de>
From:   Kanchan Joshi <joshiiitr@gmail.com>
Date:   Wed, 19 Aug 2020 14:56:29 +0530
Message-ID: <CA+1E3rJg0QOX4YgwWJf8Sm=6C-un4TsRX00E31fbFFPT9LYhXg@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kanchan Joshi <joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>, sagi@grimberg.me,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 12:46 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Aug 18, 2020 at 10:59:35AM +0530, Kanchan Joshi wrote:
> > Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.
>
> No, it is not.

Are you saying MQ-Deadline (write-lock) is not needed for writes on ZNS?
I see that null-block zoned and SCSI-ZBC both set this requirement. I
wonder how it became different for NVMe.

-- 
Kanchan
