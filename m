Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C394C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2059520721
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB+untp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgEFHNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:13:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34586 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725882AbgEFHNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588749198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DoCIDqCuiWoGHXnE50qM2xoXLIrmM3bQHiMLGkhcZ2o=;
        b=GB+untp1wjWr039HBjScMFehXKVedckTglRUeOLPLUZZNWJNtRank5mDyus5btffdjHKTK
        Laj76J7WEZVEaDI6oOJaEOF+D0sIfzYi69eaCMpA2SM/2Sm4XpJ/iRY4NotJMt+QQBceRh
        wiDA9ChgAOnoTJMR7lAnbg5FSZdYvK8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-XhPyNKgTMu6rk0SFrB4HTg-1; Wed, 06 May 2020 03:13:16 -0400
X-MC-Unique: XhPyNKgTMu6rk0SFrB4HTg-1
Received: by mail-qv1-f69.google.com with SMTP id dh14so1273961qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoCIDqCuiWoGHXnE50qM2xoXLIrmM3bQHiMLGkhcZ2o=;
        b=qI53pDEnOtMk4A6o65lqXAS2uqzR/JFkbAKERDL5OGGhOIhc5pshEobAEs/l5/VExC
         wj77WsfKR1bJ+9/uR4keZOFr/8LBRERocSY1oMMQLnXgoqxtF/wR+2il3Uqri+uMlwW3
         sSW1wsMG1545x3+PdOJEwA/ZZ95tfaHcia0zV7kf/wv/gHS943Menkv7jBSkLE1+7bTr
         o1eL+SXhoN0noDeKLysbTGWvCcdT1GxeMu5UcZlOtJ9PpKdiCTu0QyWreXBSCJnB2zVn
         f8bHfq6WJ6UARHyVHieYQl8E7MwOb/6PPEE0tt9/2958xDPNezMVt2nSfCpuULNEsOb9
         QamQ==
X-Gm-Message-State: AGi0PuZ0Y9gMsuUvsQBSG7Kml6BIdRdy8PkicM6oeezIlcz+qKWmO2nM
        nepnTidCECCFS9mKcgs6JhksloXWWae2YXekd4Fil+G7ZX90D54/QHzOAo4w24v3NyLbojP+nXE
        xqXUc9nFfY/QsM/YUwh3YpQDMNfSVYFlF0DdCFG9O
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr6503368qvv.198.1588749196491;
        Wed, 06 May 2020 00:13:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEbWxJJMg9xFDO1XjXY3rIXhjPS6TWqbI6djgDFo8c2hH5M4mqWN3Uc5hKHaslYKwpo74PZ0fFlIxHP58AJlA=
X-Received: by 2002:a05:6214:1242:: with SMTP id q2mr6503348qvv.198.1588749196212;
 Wed, 06 May 2020 00:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
 <1588705481-18385-2-git-send-email-bhsharma@redhat.com> <5ddc169b-f837-e478-43d9-4d6cf587aa05@marvell.com>
In-Reply-To: <5ddc169b-f837-e478-43d9-4d6cf587aa05@marvell.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 6 May 2020 12:43:03 +0530
Message-ID: <CACi5LpNCHipB-bU52JcWBj6bPhW5ZqfG+J7QPq-m5-xf2mqdSQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH 1/2] net: qed*: Reduce RX and TX default ring count
 when running inside kdump kernel
To:     Igor Russkikh <irusskikh@marvell.com>
Cc:     netdev@vger.kernel.org, Bhupesh SHARMA <bhupesh.linux@gmail.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2 <GR-everest-linux-l2@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alok Prasad <palok@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Igor,

On Wed, May 6, 2020 at 12:21 PM Igor Russkikh <irusskikh@marvell.com> wrote:
>
>
>
> >  #include <linux/compiler.h>
> > +#include <linux/crash_dump.h>
> >  #include <linux/version.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/netdevice.h>
> > @@ -574,13 +575,13 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev,
> > __be16 proto,
> >  #define RX_RING_SIZE         ((u16)BIT(RX_RING_SIZE_POW))
> >  #define NUM_RX_BDS_MAX               (RX_RING_SIZE - 1)
> >  #define NUM_RX_BDS_MIN               128
> > -#define NUM_RX_BDS_DEF               ((u16)BIT(10) - 1)
> > +#define NUM_RX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) :
> > ((u16)BIT(10) - 1))
> >
> >  #define TX_RING_SIZE_POW     13
> >  #define TX_RING_SIZE         ((u16)BIT(TX_RING_SIZE_POW))
> >  #define NUM_TX_BDS_MAX               (TX_RING_SIZE - 1)
> >  #define NUM_TX_BDS_MIN               128
> > -#define NUM_TX_BDS_DEF               NUM_TX_BDS_MAX
> > +#define NUM_TX_BDS_DEF               ((is_kdump_kernel()) ? ((u16)BIT(6) - 1) :
> > NUM_TX_BDS_MAX)
> >
>
> Hi Bhupesh,
>
> Thanks for looking into this. We are also analyzing how to reduce qed* memory
> usage even more.
>
> Patch is good, but may I suggest not to introduce conditional logic into the
> defines but instead just add two new defines like NUM_[RT]X_BDS_MIN and check
> for is_kdump_kernel() in the code explicitly?
>
> if (is_kdump_kernel()) {
>         edev->q_num_rx_buffers = NUM_RX_BDS_MIN;
>         edev->q_num_tx_buffers = NUM_TX_BDS_MIN;
> } else {
>         edev->q_num_rx_buffers = NUM_RX_BDS_DEF;
>         edev->q_num_tx_buffers = NUM_TX_BDS_DEF;
> }
>
> This may make configuration logic more explicit. If future we may want adding
> more specific configs under this `if`.

Thanks for the review comments.
The suggestions seem fine to me. I will incorporate them in v2.

Regards,
Bhupesh

