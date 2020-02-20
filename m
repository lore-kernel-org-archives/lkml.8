Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D0C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85549207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 00:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgBTAH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 19:07:58 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45575 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBTAH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 19:07:57 -0500
Received: by mail-oi1-f193.google.com with SMTP id v19so25718514oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:07:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fs7aFUGuQDQwKtAq2jogalwziBPX7+a0D4piqySvYe0=;
        b=nccKca0BA6gPOXJUkgcj1h4wqX3gcmTSPfuCBZMuHrpdrGyCm4lMcdDeNyqRbUKo+p
         wS/O54VYw2gzU1cY6bsW5iG8h0P0UE2QpKUCWR/QsfelA94FmkTHJTmHRtLgSBHm025v
         MW9uFSDfNqBnv0RnEVZ/RePG8eAzo8PL6L9eZb5bvoXJaYNEuwsabFQlejsGHkB1Jjnw
         jM2MX+5jBIJp1+ycdAhJ5sszCUdJYjkfBV8NGTHFDKOiVYgx1xypgj9CIRRI9cbZlrVv
         01b6aYC3bWEa6ibEw0ruIGL1x1OtRXv0+TDMPf8hFiBVsyqCwjQ/2y3NC00uGHifNj2H
         R7mQ==
X-Gm-Message-State: APjAAAXPSpr8EHRmTi5Q60O+2XLM3ldAhamo7Qm1z8ttunRfayIYjFvY
        URp2qZzoLAbwbvr/b9JIuvP4a+/b
X-Google-Smtp-Source: APXvYqzU24KU9Q+9lbKFFJ0VptiFrV9y25e9V2+lLB8kBGyKKFCe/tmZcozC+gItGnYMJnlE31zvKw==
X-Received: by 2002:aca:5303:: with SMTP id h3mr175058oib.109.1582157276613;
        Wed, 19 Feb 2020 16:07:56 -0800 (PST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id c21sm512612oiy.11.2020.02.19.16.07.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 16:07:56 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id i6so1997283otr.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 16:07:55 -0800 (PST)
X-Received: by 2002:a05:6830:1c8:: with SMTP id r8mr8886101ota.63.1582157275705;
 Wed, 19 Feb 2020 16:07:55 -0800 (PST)
MIME-Version: 1.0
References: <1576170032-3124-1-git-send-email-youri.querry_1@nxp.com> <a46accbc-becf-ad23-8504-70ce619e2b11@oss.nxp.com>
In-Reply-To: <a46accbc-becf-ad23-8504-70ce619e2b11@oss.nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Wed, 19 Feb 2020 18:07:44 -0600
X-Gmail-Original-Message-ID: <CADRPPNQ4UK6EvYG6ffdU=dvO-tD7crWJ==diq8ueBBAyCvEdLw@mail.gmail.com>
Message-ID: <CADRPPNQ4UK6EvYG6ffdU=dvO-tD7crWJ==diq8ueBBAyCvEdLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] soc: fsl: dpio: Enable QMAN batch enqueuing
To:     Roy Pledge <roy.pledge@oss.nxp.com>
Cc:     Youri Querry <youri.querry_1@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 2:41 PM Roy Pledge <roy.pledge@oss.nxp.com> wrote:
>
> On 12/12/2019 12:01 PM, Youri Querry wrote:
> > This patch set consists of:
> > - We added an interface to enqueue several packets at a time and
> >    improve performance.
> > - Make the algorithm decisions once at initialization and use
> >    function pointers to improve performance.
> > - Replaced the QMAN enqueue array mode algorithm with a ring
> >    mode algorithm. This is to make the enqueue of several frames
> >    at a time more effective.
> >
> > Youri Querry (3):
> >    soc: fsl: dpio: Adding QMAN multiple enqueue interface.
> >    soc: fsl: dpio: QMAN performance improvement. Function pointer
> >      indirection.
> >    soc: fsl: dpio: Replace QMAN array mode by ring mode enqueue.
> >
> >   drivers/soc/fsl/dpio/dpio-service.c |  69 +++-
> >   drivers/soc/fsl/dpio/qbman-portal.c | 766 ++++++++++++++++++++++++++++++++----
> >   drivers/soc/fsl/dpio/qbman-portal.h | 158 +++++++-
> >   include/soc/fsl/dpaa2-io.h          |   6 +-
> >   4 files changed, 907 insertions(+), 92 deletions(-)
> >
> Acked-by: Roy Pledge <roy.pledge@nxp.com>

Series applied with some clean up and typo fix in the title/commit message.

Regards,
Leo
