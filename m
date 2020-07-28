Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9181FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C49621775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 05:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XhO/SGS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgG1FGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 01:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG1FF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 01:05:59 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615FEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:05:58 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id l1so19429685ioh.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5goD+3ukuceyveBM5Qmp+xUfwXY64ez7WeUX2kpr76A=;
        b=XhO/SGS6T1W1KprpM6TEDp6v5rEsFtuo9nUz3RFtVUEqqO6qIXd/Tx6vQOuZnelElE
         /zNKxhx0r1aHCmfRMBa5uqobl9L81oNfmuZcPY7vSPUF5ZRIbJWM/7lWslT1a2TtjhAx
         EbBfzaAvndP3qDzdvibSO5MK7sdgkpXp9Z7aI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5goD+3ukuceyveBM5Qmp+xUfwXY64ez7WeUX2kpr76A=;
        b=Jr8fMIbWjoLb2VIFltBNEKqc3s2Gw5k4NFsxeAElIqWVN7RpuIPBBzNxPFGOM3ntXa
         5QVnntbNMO6FTnUWD6UXW6zuObEKk+y9DPVILTVzNnmOEGbx7LlRHe9FQfFqkZf0rURm
         DgHLwggjP1sXAvqD4M68AChLAAucnzzkpq5T3zLZ4SklJm/PK/k8Uqw1BteA++mndNye
         l1/XojX+hv04zVufVFFeklxF5cwn/NwNE9oTb38PIkfXQmwFs40BLugGV9eVoE1Dd4aj
         n5LUV2xJ+f3bxaHEUTbpY/veFIVvZXFliTIliVXW91bwjgltsOXhimGhh4wHw6Cv5PCO
         CZgA==
X-Gm-Message-State: AOAM531xBOmeYhtuP4b2XPxsLGKsAMlZTh0Fp/rKQiu/j+TncNXgDzKF
        aRV7yYmskGwa+Pm4tRLyKksDRkEvpAA=
X-Google-Smtp-Source: ABdhPJyYPh3b+G+mWucP/CAD4yDvSIA2wULT0+ibh19KEfhV+E6rdyT97EyZCcgGB/qSPJoW3vkfVQ==
X-Received: by 2002:a6b:e006:: with SMTP id z6mr23186122iog.118.1595912757452;
        Mon, 27 Jul 2020 22:05:57 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id x5sm9990670iol.36.2020.07.27.22.05.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 22:05:56 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id a5so4210074ioa.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:05:55 -0700 (PDT)
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr13430058iom.27.1595912755484;
 Mon, 27 Jul 2020 22:05:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200713091211.2183368-1-tientzu@chromium.org>
 <20200713091211.2183368-2-tientzu@chromium.org> <4a2451f9-57d8-2e83-e1d6-f144f37173c0@arm.com>
 <20200714110141.GD16178@lst.de> <CALiNf2-9b5LMjv+KCqFJ9oz2FocT6oQ1zVY_MBaFgNG1DQxZ=Q@mail.gmail.com>
 <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
In-Reply-To: <CALiNf28LVobHKLuXAf7P7Avi6n1oU+tbbFJ55ZPanJuq8Q1Ysg@mail.gmail.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Tue, 28 Jul 2020 13:05:44 +0800
X-Gmail-Original-Message-ID: <CALiNf2_rrS8Kv+kps5kxHZaQG5PxxPOvo-ubm7FLCx_ZkouwHQ@mail.gmail.com>
Message-ID: <CALiNf2_rrS8Kv+kps5kxHZaQG5PxxPOvo-ubm7FLCx_ZkouwHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dma-mapping: Add bounced DMA ops
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>, frowand.list@gmail.com,
        m.szyprowski@samsung.com, treding@nvidia.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>, suzuki.poulose@arm.com,
        dan.j.williams@intel.com, heikki.krogerus@linux.intel.com,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, tfiga@chromium.org,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 that reuses SWIOTLB here: https://lore.kernel.org/patchwork/cover/1280705/

Thanks,
Claire
