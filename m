Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AD4207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCG2wkUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731619AbgGaHUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbgGaHU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:20:29 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F598C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:20:29 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q76so7080874wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M/BQPRp/I/sbPp0G/yBSYfbDdAIYhLKyUo0rJbIKRgQ=;
        b=bCG2wkUz+omQIP9S5n//fxPaNsiFnSP8XYllSV46Ly16xsehp3ECMr8Gf+8qSPt+b+
         ZcmGbLovhBPNbuWZ9gke9W5vbLAt9EOmBXpqz+YNXR3abVLrZiY8XZsWoQvPG3xnJ+zW
         FtrJWaAmMT5Qor4cNE1qv4xX3wKGpBfOYmKnypoplHF7+inYWEEH0gjE/rJUZOvnjMqM
         mEndDkg2HS7uq1VgTEM99jLk0R5RjPVrC3DnEBmwilbq8zEIbzdCIBEYacuN0bTtw2R3
         /ziZKE3k55uibWz79is5PNQcwkVzb7FZ+Oavlx5dhfVJ6u2pFi2ePJZtx3gYSjPR4QZI
         hPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M/BQPRp/I/sbPp0G/yBSYfbDdAIYhLKyUo0rJbIKRgQ=;
        b=DRn+QBj3TocZnwaIOfYrKozL3DpSgFhN/x3X8LMZM92MJK0OigChWJ4gDPyNnA8Q0w
         xyTm2AgYXC6tU/9l4uMGtJ2/s4+fr5AHditS7u04ha7hSJj2mk4+P9VEpTPuvOUezlBj
         +7Ok+wHpa+e96N6v39ZIidYBaVhSgEJSRLzqXsHM8inAsSCXzWkcCnECmsi2CKJ3Z9ls
         qHonhow3Z+HA8LMciE4/OD9CFO5t2uYZVbSOw7xIVMDtNgaiLyQyvErTKLoEEkkxavpd
         KVUXwym3qmdvjPgcFP0AHuD6nKZStsnY7k28VYtJAlqLKJIQGCxXBYHDoBNcGAx1Fk1T
         9v7Q==
X-Gm-Message-State: AOAM530uefhuh9QMPKpHuN22g3tvG0z08vGq5GG2bHe23jScGchC/Hpa
        QblpZikWHCkhF+70M8933KmQpx7NHIJskyHC8vTNvg==
X-Google-Smtp-Source: ABdhPJwZA3g8We2giJUDUafKmdU7lx9J8qF66cxr/eNmiu6F7PfeQbZik1QyrrP9wi3tgy2DxYorVzoXPsRyvX37Rb8=
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr2669888wmb.16.1596180027809;
 Fri, 31 Jul 2020 00:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de> <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de> <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de> <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
 <20200728091335.GA23744@lst.de> <e39e8f87ed5b4e9da2f08a0651801954e61f4b4e.camel@suse.de>
 <20200728100918.GA26364@lst.de> <20200731011004.GA729998@ubuntu-n2-xlarge-x86>
In-Reply-To: <20200731011004.GA729998@ubuntu-n2-xlarge-x86>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Fri, 31 Jul 2020 12:49:51 +0530
Message-ID: <CAMi1Hd0MG-JBADz9cRcg+MgB_1DmCJ3rj4dYUco=UXUQhL5UQw@mail.gmail.com>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jul 2020 at 06:40, Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Jul 28, 2020 at 12:09:18PM +0200, Christoph Hellwig wrote:
> > Ok, I found a slight bug that wasn't intended.  I wanted to make sure
> > we can always fall back to a lower pool, but got that wrong.  Should be
> > fixed in the next version.
>
> Hi Christoph and Nicolas,
>
> Did a version of that series ever get send out? I am coming into the
> conversation late but I am running into an issue with the Raspberry Pi 4
> not booting on linux-next, which appears to be due to this patch now in
> mainline as commit d9765e41d8e9 ("dma-pool: do not allocate pool memory
> from CMA") combined with
> https://lore.kernel.org/lkml/20200725014529.1143208-2-jiaxun.yang@flygoat.com/
> in -next:
>
> [    1.423163] raspberrypi-firmware soc:firmware: Request 0x00000001 returned status 0x00000000
> [    1.431883] raspberrypi-firmware soc:firmware: Request 0x00030046 returned status 0x00000000
> [    1.443888] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.452527] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 0 config (-22 80)
> [    1.460836] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.469445] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
> [    1.477735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.486350] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
> [    1.494639] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.503246] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 3 config (-22 83)
> [    1.511529] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.520131] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
> [    1.528414] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.537017] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 5 config (-22 85)
> [    1.545299] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.553903] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
> [    1.562184] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.570787] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 7 config (-22 87)
> [    1.579897] raspberrypi-firmware soc:firmware: Request 0x00030030 returned status 0x00000000
> [    1.589419] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
> [    1.599391] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.608018] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
> [    1.616313] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.624932] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
> [    1.633195] pwrseq_simple: probe of wifi-pwrseq failed with error -22
> [    1.643904] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.652544] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
> [    1.660839] raspberrypi-firmware soc:firmware: Request 0x00030041 returned status 0x00000000
> [    1.669446] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 state (-22 82)
> [    1.677727] leds-gpio: probe of leds failed with error -22
> [    1.683735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.692346] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
> [    1.700636] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.709240] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
> [    1.717496] reg-fixed-voltage: probe of sd_vcc_reg failed with error -22
> [    1.725546] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.734176] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
> [    1.742465] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
> [    1.751072] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
> [    1.759332] gpio-regulator: probe of sd_io_1v8_reg failed with error -22
> [    1.768042] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
> [    1.780871] ALSA device list:
> [    1.783960]   No soundcards found.
> [    1.787633] Waiting for root device PARTUUID=45a8dd8a-02...
>
> I am unsure if it is related to the issue that Amit is having or
> if that makes sense at all but I can reliably reproduce it.
>
> v5.8-rc1: OK
> v5.8-rc1 + d9765e41d8e9e: OK
> v5.8-rc1 + "of_address: Add bus type match for pci ranges parser": OK
> v5.8-rc1 + both: BROKEN
>
> I wanted to test the series to see if this fixes anything. If you would
> prefer a different thread for this or further information, please let
> me know.

Hi Nathan,

Here is the patch series:
https://lists.linuxfoundation.org/pipermail/iommu/2020-July/047008.html
https://lists.linuxfoundation.org/pipermail/iommu/2020-July/047010.html

I hope it works for you, it didn't work for me. More details in this
thread here:
https://lists.linuxfoundation.org/pipermail/iommu/2020-July/047009.html

Regards,
Amit Pundir

>
> Cheers,
> Nathan
