Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5249EC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2940224673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 03:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="BYJ2qNI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgAWDdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 22:33:20 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34842 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgAWDdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 22:33:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id f8so1904995edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 19:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RxdFDkgAn9D7lbbl4yJylyYxkkQhJf8CMYw3SePBV9o=;
        b=BYJ2qNI+dBv9tMqAzPkNiFA8z9l53d8vo0bg/tFL47LkX+SYG7a2xh0ziiWtuZWBZO
         7l+/irlHAIPylkhRRyb2CWJvZXrzhBhvjKecPZ0Vap+X0mH/k4ZxxE3jITGNBimF17Kh
         Y4rrnRxqYRANwYYsT4Kq6aj9NXFU65B1qvrOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RxdFDkgAn9D7lbbl4yJylyYxkkQhJf8CMYw3SePBV9o=;
        b=MD0I/6IS0DHt/BHDqcFT/3Aa8VsqWUmrIYb7cldUH3tkxtSHxA9+MhokKWgVVfUaGt
         y5eqevzudCoGdM6nCVhooh3YKDbuAA0xD3vLu8aET4H2JJcrlGacVrPFMrwbKZb60obF
         qLPDLVmk7kiamBe1eDC1AdR5J+OEgVFIt55mOW/cPe5K2wp+bl/11WcIuhMrnbFLsIFo
         Kv5R9FBE2wUfeKZBgWXgqM3i+fpSH77nVEOguqHbI6iIK41XZhCSXNfq4h8vHLDchEP9
         S4oTSofGJ7fKvlSh9dCH99i/HNdOmvvvxTe7KTQ63XSo7WTdDbNryT8i/A+WRVtTHOzN
         ohhA==
X-Gm-Message-State: APjAAAU5LkkzCee1yWt5XHWXEGb+usnftoLT8BnfNv+uxDNo9ehE9EcB
        KlmU3U2/btSQdu5rXub5hi53Xzs0CGyAzehpi8GQ
X-Google-Smtp-Source: APXvYqycVOOWGXD+ceqgNbTn/M8d3+G6sfdK5uFfduIwWtpp8ImIQnOEv61nRLthSRKl/bCxoTYSTAPdc1ifUVWhamY=
X-Received: by 2002:a17:906:404:: with SMTP id d4mr5358857eja.326.1579750398495;
 Wed, 22 Jan 2020 19:33:18 -0800 (PST)
MIME-Version: 1.0
References: <DM6PR04MB5754D8E261B4200AA62D442D860D0@DM6PR04MB5754.namprd04.prod.outlook.com>
 <20200121201014.52345-1-muraliraja.muniraju@rubrik.com> <CACVXFVN2QteGv=mWpVimZ9y2yzLZOOthB9muFsxTG3LkWWpwfA@mail.gmail.com>
In-Reply-To: <CACVXFVN2QteGv=mWpVimZ9y2yzLZOOthB9muFsxTG3LkWWpwfA@mail.gmail.com>
From:   Muraliraja Muniraju <muraliraja.muniraju@rubrik.com>
Date:   Wed, 22 Jan 2020 19:33:07 -0800
Message-ID: <CAByjrT-9GZs=zdWaT+_ZhV-q05P27jB16xHJGnP3KC5tNJsY+A@mail.gmail.com>
Subject: Re: Re [PATCH] Adding multiple workers to the loop device.
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I used dd to test
            dd if=/tmp/mount/home/ubuntu/os_disk_partition/genesisTool/4Fz
of=/dev/null bs=1M count=53687091200 skip=0
iflag=skip_bytes,count_bytes,direct &

            dd if=/tmp/mount/home/ubuntu/os_disk_partition/genesisTool/4Fz
of=/dev/null  bs=1M count=53687091200 skip=53687091200
iflag=skip_bytes,count_bytes,direct &

            dd if=/tmp/mount/home/ubuntu/os_disk_partition/genesisTool/4Fz
of=/dev/null  bs=1M count=53687091200 skip=107374182400
iflag=skip_bytes,count_bytes,direct &

            dd if=/tmp/mount/home/ubuntu/os_disk_partition/genesisTool/4Fz
of=/dev/null  bs=1M count=53687091200 skip=161061273600
iflag=skip_bytes,count_bytes,direct &

Here the file /tmp/mount/home/ubuntu/os_disk_partition/genesisTool/4Fz
is a file in the ext4 file system that is accessed via a loop device.

Also in the above change we have the default version to be always 1
worker. One can change the number of workers to handle the performance
to their needs. In our case we saw that we got good performance with 4
threads even for sequential io.

On Wed, Jan 22, 2020 at 5:40 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Wed, Jan 22, 2020 at 4:11 AM muraliraja.muniraju
> <muraliraja.muniraju@rubrik.com> wrote:
> >
> > Below is the dd results that I ran with the worker and without the worker changes.
> > Enhanced Loop has the changes and ran with 1,2,3,4 workers with 4 dds running on the same loop device.
> > Normal Loop is 1 worker(the existing code) with 4 dd's running on the same loop device.
> > Enhanced loop
> > 1 - READ: io=21981MB, aggrb=187558KB/s, minb=187558KB/s, maxb=187558KB/s, mint=120008msec, maxt=120008msec
> > 2 - READ: io=41109MB, aggrb=350785KB/s, minb=350785KB/s, maxb=350785KB/s, mint=120004msec, maxt=120004msec
> > 3 - READ: io=45927MB, aggrb=391802KB/s, minb=391802KB/s, maxb=391802KB/s, mint=120033msec, maxt=120033msec
> > 4 - READ: io=45771MB, aggrb=390543KB/s, minb=390543KB/s, maxb=390543KB/s, mint=120011msec, maxt=120011msec
> > Normal loop
> > 1 - READ: io=18432MB, aggrb=157201KB/s, minb=157201KB/s, maxb=157201KB/s, mint=120065msec, maxt=120065msec
> > 2 - READ: io=18762MB, aggrb=160035KB/s, minb=160035KB/s, maxb=160035KB/s, mint=120050msec, maxt=120050msec
> > 3 - READ: io=18174MB, aggrb=155058KB/s, minb=155058KB/s, maxb=155058KB/s, mint=120020msec, maxt=120020msec
> > 4 - READ: io=20559MB, aggrb=175407KB/s, minb=175407KB/s, maxb=175407KB/s, mint=120020msec, maxt=120020msec
>
> Could you share your exact test command?
>
> Multiple jobs may hurt performance in case of sequential IOs on HDD backend.
> Also the 1st version of the loop dio patch uses normal wq, I remembered that
> random IOperformance isn't improved much, meantime sequential IO perf drops
> with normal wq, whentesting SSD backend.
>
> So I took kthread worker.
>
> Thanks,
> Ming Lei
