Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65B18208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqDshH4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgGaBKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731079AbgGaBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:10:07 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C982C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:10:07 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j187so27410783qke.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D6NBoB2E2UORS0vxwFp8hCbO3jjocLGEsRaBZ4a3Cu4=;
        b=nqDshH4ZBAcngsPAU2XSpK4c1TSV88FwXn5DlgyeDI8nu7ey04jFVxwnFLkRdjwSXG
         toTR9/WFPA8rxWJzaYI9B3unVGHta9RBT2AMp/Ey5yhPZ8JYEs18saczm2dQE5mYOVM8
         lCqlHDGjmLKaaORk8aO94HGwStmn0pEWkQymZxIKriGc0pUJjdW4jwNve8RUvmH+QKD8
         DnzxDW3/N49NftucOXHqEehPHiDbmFIcNX7kQJpRCxrXpDjbu5gIA23lFumCYJNL19QI
         hv56EMoKJ5rnzG1HGjKk+QRG0KnOS+4VxqcEy4I+i9TjVnoOiaoRSFULBf4y6mz3kAV2
         F0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D6NBoB2E2UORS0vxwFp8hCbO3jjocLGEsRaBZ4a3Cu4=;
        b=QYFijOL3CI5PFRsug+cobGxGZZ4ZscjZZ/FUJ9JcP0d3OZ8n+/7j3kP8/CT434D1jz
         z190mffb0mluLdINAy+7Nr9v6ZMHDuN3D+41x+U1m9D6q2/3WKYm5p2DlqSIv0BZF9EW
         PKhu21A275t5yeWvBgDiWchBE3mXQHo2XZyvRDleH4Uivj9Mq/7w+qFcxK5e2oUBaQl/
         H3arRMsmQEN4F1RLe+kTwk0Ia6+cVSMQ3YvK6pK/+h/8gFOKDfA3eVjDm2HEvJbjbiqp
         k8PFjB/OWCuftJMSzaMrGIrVRA8SefKw6ik480POZ+angNcCekKPjmZ/nlpUR31V1dsY
         FKnA==
X-Gm-Message-State: AOAM531imfXzNFoQPJvzG/PmmLA9xxAZvNmABPV5M4DkCiofTPiQJUvL
        sGerAkCkiknNDUYIcCvUrnE=
X-Google-Smtp-Source: ABdhPJwN6gFxZXDSUFRTCXi75SujGs/2puXt91yJ2XyQrWshXyFhR/atb9neFueWVXKBE85TvpPxeA==
X-Received: by 2002:a37:54a:: with SMTP id 71mr1818899qkf.193.1596157806411;
        Thu, 30 Jul 2020 18:10:06 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id c205sm6137184qkg.98.2020.07.30.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:10:05 -0700 (PDT)
Date:   Thu, 30 Jul 2020 18:10:04 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
Message-ID: <20200731011004.GA729998@ubuntu-n2-xlarge-x86>
References: <CAMi1Hd3C6kh5E49EgytBAQ_2AE_jvnp+eSNsxBYaux+exSvdbg@mail.gmail.com>
 <6db722947546221ed99d3f473f78e1a6de65d7d6.camel@suse.de>
 <CAMi1Hd0Xz6kOJFpA5PEpi6RDDGOcz0RmQ7tTOkuXq4QneOO_vQ@mail.gmail.com>
 <0dc1e922bf87fa73790e7471b3974528dd261486.camel@suse.de>
 <CAMi1Hd3O2HHBsnt=sac7FdcW0-3=4S3g_F9f__2h5gTsudfirA@mail.gmail.com>
 <20200724134114.GA3152@lst.de>
 <a9b811a84ac21c13693e6ffefd2914b911542e18.camel@suse.de>
 <20200728091335.GA23744@lst.de>
 <e39e8f87ed5b4e9da2f08a0651801954e61f4b4e.camel@suse.de>
 <20200728100918.GA26364@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728100918.GA26364@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 12:09:18PM +0200, Christoph Hellwig wrote:
> Ok, I found a slight bug that wasn't intended.  I wanted to make sure
> we can always fall back to a lower pool, but got that wrong.  Should be
> fixed in the next version.

Hi Christoph and Nicolas,

Did a version of that series ever get send out? I am coming into the
conversation late but I am running into an issue with the Raspberry Pi 4
not booting on linux-next, which appears to be due to this patch now in
mainline as commit d9765e41d8e9 ("dma-pool: do not allocate pool memory
from CMA") combined with
https://lore.kernel.org/lkml/20200725014529.1143208-2-jiaxun.yang@flygoat.com/
in -next:

[    1.423163] raspberrypi-firmware soc:firmware: Request 0x00000001 returned status 0x00000000
[    1.431883] raspberrypi-firmware soc:firmware: Request 0x00030046 returned status 0x00000000
[    1.443888] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.452527] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 0 config (-22 80)
[    1.460836] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.469445] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.477735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.486350] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
[    1.494639] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.503246] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 3 config (-22 83)
[    1.511529] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.520131] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.528414] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.537017] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 5 config (-22 85)
[    1.545299] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.553903] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.562184] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.570787] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 7 config (-22 87)
[    1.579897] raspberrypi-firmware soc:firmware: Request 0x00030030 returned status 0x00000000
[    1.589419] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
[    1.599391] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.608018] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.616313] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.624932] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 1 config (-22 81)
[    1.633195] pwrseq_simple: probe of wifi-pwrseq failed with error -22
[    1.643904] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.652544] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 config (-22 82)
[    1.660839] raspberrypi-firmware soc:firmware: Request 0x00030041 returned status 0x00000000
[    1.669446] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 2 state (-22 82)
[    1.677727] leds-gpio: probe of leds failed with error -22
[    1.683735] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.692346] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.700636] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.709240] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 6 config (-22 86)
[    1.717496] reg-fixed-voltage: probe of sd_vcc_reg failed with error -22
[    1.725546] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.734176] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.742465] raspberrypi-firmware soc:firmware: Request 0x00030043 returned status 0x00000000
[    1.751072] raspberrypi-exp-gpio soc:firmware:gpio: Failed to get GPIO 4 config (-22 84)
[    1.759332] gpio-regulator: probe of sd_io_1v8_reg failed with error -22
[    1.768042] raspberrypi-firmware soc:firmware: Request 0x00028001 returned status 0x00000000
[    1.780871] ALSA device list:
[    1.783960]   No soundcards found.
[    1.787633] Waiting for root device PARTUUID=45a8dd8a-02...

I am unsure if it is related to the issue that Amit is having or
if that makes sense at all but I can reliably reproduce it.

v5.8-rc1: OK
v5.8-rc1 + d9765e41d8e9e: OK
v5.8-rc1 + "of_address: Add bus type match for pci ranges parser": OK
v5.8-rc1 + both: BROKEN

I wanted to test the series to see if this fixes anything. If you would
prefer a different thread for this or further information, please let
me know.

Cheers,
Nathan
