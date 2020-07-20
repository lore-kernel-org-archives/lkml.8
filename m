Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E9392070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595246601;
	bh=G9Go/h/TN87jUJHBbkQ7/aM1p1Ah9QACNvcCV5mAehw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g6v22/3lIqjpuxfKOhE9K6vzt6rEXgMKww2YpUY1EctoVtiGnJh3U+Q3+3T59c/BE
	 B+pcQxQPrhW6mfuMamZqiChEUAajzkFj9IWfElkAdcZ3HC32fzNgdgVU0K+V39cztv
	 Vk7SJWxcip2tacyyKLH8mJWsiRm8PNai3ydLVyU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGTMDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbgGTMDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:03:19 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B95E2070A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 12:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595246598;
        bh=G9Go/h/TN87jUJHBbkQ7/aM1p1Ah9QACNvcCV5mAehw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NW8s8qye5v+UBECClmFRA5LNt4VVJCRRnlo14fRyn45CMucG0DuHKylq1gtfM7anf
         457Imq4UjfdFd9pRoK0fgSLgXgNEvzkSTd0fmyI9wfr1zKPGSPQOg/mQHPKEOeMvM4
         xa0iAwY1MqCNr7CKYATdbmBZlL3QC2EcFJMWivSY=
Received: by mail-lj1-f178.google.com with SMTP id q4so20001545lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 05:03:18 -0700 (PDT)
X-Gm-Message-State: AOAM533bfF+7Zqi5QC+gYdSmDcsHetw3lNId1H6ROwqgzlp1lx/uY4+6
        4QOq8h3P02pHzdSensaoAdxF1Yi5CXODq2ZUTPo=
X-Google-Smtp-Source: ABdhPJw9rUEELsOQ4urbK5iR4R2KAP7EfM7/dGOeeJPzwwVPtxv4q34bpXByMXPMyskhaV72gYWJtePoHuNHjR9Ilx8=
X-Received: by 2002:a2e:8684:: with SMTP id l4mr10714566lji.75.1595246596992;
 Mon, 20 Jul 2020 05:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200720100113.6481-1-wens@kernel.org> <20200720110610.GA4601@sirena.org.uk>
In-Reply-To: <20200720110610.GA4601@sirena.org.uk>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 20 Jul 2020 20:03:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v65zdCfOP-vGzrVXuzRyUC1ejG5CX=dfrh9MGTuV00VgPQ@mail.gmail.com>
Message-ID: <CAGb2v65zdCfOP-vGzrVXuzRyUC1ejG5CX=dfrh9MGTuV00VgPQ@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: gpio: Honor regulator-boot-on property
To:     Mark Brown <broonie@kernel.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 7:06 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jul 20, 2020 at 06:01:13PM +0800, Chen-Yu Tsai wrote:
>
> > Also drop support for the undocumented enable-at-boot property. This
> > property was not documented in the original commit introducing DT
> > support, nor is it now, and there are no in-tree device trees that use
> > this property.
>
> There may still be out of tree users, an ABI is an ABI.

Ok. Should I add a comment stating this should not be used in new files?
Or just leave it as it?

ChenYu
