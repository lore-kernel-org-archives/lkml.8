Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B1FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68977205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iaY8oodz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHXVPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXVPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:15:18 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE90C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:15:17 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so5258720pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=MJ8XfWNGGP7wiDdGWRcPF7YeSYjIipUSnFlPxS9I+QI=;
        b=iaY8oodzVk638aaEvZq4/GPPWWhIMSiVq1vxdx7MrV0QYpzha2W9GN88Ye9LZJiQzZ
         7TGVH0AcUf91WylTcbJJgzO5/hiz60LIrawOw0q25XUhN+TXnrccNNLPPgokXalw9Nu3
         XEIrFZi0CnD0ucQgzvoqa6VPn68U6xU9V6VdyYXxNMAnwMxOtGMYNC8xD+l6zAUkPo7p
         wi/9tU0cmDURf8xYpKv90DJgfdNSdA36AhjNVZPr6A5vzxj8uFPJwxX43QtRdDuN8Eof
         bIpcleHXQuYO3ulhdLJuN5+eSddDgtEJsGyI3+e77KuwCANWcwIAS/wyvqvBO0xKGU39
         9b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MJ8XfWNGGP7wiDdGWRcPF7YeSYjIipUSnFlPxS9I+QI=;
        b=M8oEKyWwHu7fbrFNCK5kY/IbvcV8T1c0vwO9Be4tE2t3y+TqCrV+xYNG0MmYQPz+MQ
         O0OPERt3EYh0ZYEFl3I1RQqsYCwN0h4nh4XS7pgFFqtGZ8RTxvCM8I8a87Ui0zJt6E01
         qcGHuE7MmStQIcSmy6jUf2756/xtn9YpkX2r62chkLCL8cmFpvtujOMV5O+Aynl7X3DJ
         GY5C4CGvlzfdsUm6b/KPOIXGh0rOuMyv/653z7c0879Bu1zPULKJ4Tj5L3iHHsRh+iqG
         4siGKhO+Q6TSYy9cPOj00Tl2Gj+fKRdXkiEe2HLkFteqimXyQPdILrPV7tA0pdJgJL6B
         ruZg==
X-Gm-Message-State: AOAM532AZR/Etf7CwBg5KcT7Qzcrd3dU+gJZLsbD7xMu1lB097xijUjc
        qisKPDv5+7UFJwWYANXwG1/nAw==
X-Google-Smtp-Source: ABdhPJwZHuR5OTtw9TTATDnf6mUcMkl8mrdaaHq9gdoGIJi4IGzp/W3a4vARzXQH6bAbPvfGVX1g5g==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr5018879pla.151.1598303717277;
        Mon, 24 Aug 2020 14:15:17 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id v2sm5569888pfn.116.2020.08.24.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:15:16 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] ARM: dts: meson: move the L2 cache-controller inside the SoC node
In-Reply-To: <20200815182223.408965-1-martin.blumenstingl@googlemail.com>
References: <20200815182223.408965-1-martin.blumenstingl@googlemail.com>
Date:   Mon, 24 Aug 2020 14:15:15 -0700
Message-ID: <7hft8bu4nw.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> All IO mapped SoC peripherals should be within the "soc" node. Move the
> L2 cache-controller there as well since it's the only one not following
> this pattern.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Boot tested on meson8b-odroidc1

Tested-by: Kevin Hilman <khilman@baylibre.com>

Queuing for v5.10.

Thanks,

Kevin
