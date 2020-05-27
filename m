Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D09C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2FD8205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2tgfMBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388268AbgE0LUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbgE0LUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:20:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D87C061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:20:36 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so28451140ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=qgCGl4i5KYXHBvhHs2r1weIGYhLtBTtsyUQbZCl+rHo=;
        b=K2tgfMBXHrZgwofl/ex6u5ZgziYRGBRCGGcRUfqcYex+YEHbT9GKRYSIsNvE/R5B/j
         YVfbcUv6RVln+3IZImO9xa6To3xxHhH6GdG+7+t8AU8SZOty2qkENQEMWdGpItZD+Xc7
         aml188awxXDgYRS1xZyP2IeRJwPqOhdRDVZz02HmarZWKyeVpW9hmd40uRUxRhwnyqa9
         550suo6va/wwMoM6kjUe+W1yqmdh2ZMPerlNaDwaQFrOmXlUZUzwShPIPouYR043tj9z
         fGTM7FsXHQQxoDc9uxj/lMc1ciPx6eJi3YB6o/cY6a9mzG0oAJo4CWTmuUqYy0ya1LrN
         hXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=qgCGl4i5KYXHBvhHs2r1weIGYhLtBTtsyUQbZCl+rHo=;
        b=ejof74SbycKyd0d4vy4XNWnawTXcmOe9aZnPnicTsNSXhEhZqzhTt/CnUf1ypo2O/n
         sJ07XyIXshApvLcicEDP9prZcCFwr8QLVfRnp+pMZ8gCJs8IM7hyVAZ8xULDxBHDGg7U
         wB8JVjX3/OafwG89ha9yCtFl3gqWNSNv2U9YcX0537yGq0pocAfeXWl9mhzJiCG0KJ9t
         y8aOYd8znIIHwO6SY6bcJjFITDZckett+o7Td9RE8ZUvRRTx9PNnSlKrasA/pEr88r5E
         5jNzZmSqXMV5Jz0jxnYVQKcx4Clt+xHXiSklWD/8wlerOiccMg64sOUx/kIoZIyDn7zf
         ELDA==
X-Gm-Message-State: AOAM531nYN933rmJBBL/wkaX0CPdDaUZj22+JhoiZqjzyvL06f8Z0bWL
        1HGhad+acZA6OD2mQ3yT5ZOySwRQi/9/Rg==
X-Google-Smtp-Source: ABdhPJwDYpERhOAMP58LMzjpMRKU7sh59Al2X9/mW5LDEhyFQv4SMVJHf6XRCdHZA3YqpJMJsXWqLQ==
X-Received: by 2002:a2e:b8cd:: with SMTP id s13mr2889264ljp.83.1590578434840;
        Wed, 27 May 2020 04:20:34 -0700 (PDT)
Received: from a-barsegyan ([85.249.97.232])
        by smtp.gmail.com with ESMTPSA id s13sm833982lfp.81.2020.05.27.04.20.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 04:20:34 -0700 (PDT)
Date:   Wed, 27 May 2020 14:20:32 +0300
From:   Artur Barsegyan <a.barsegyan96@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipc/msg.c: wake up senders until there is a queue empty
 capacity
Message-ID: <20200527112032.GB12093@a-barsegyan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

About your case:

The new receiver puts at the end of the receivers list.
pipelined_send() starts from the beginning of the list and iterates until the end.

If our queue is always full, each receiver should get a message because new receivers appends at the end.
In my vision: we waste some time in that loop but in general should increase the throughout. But it should be tested.

Yes, I'm gonna implement it and make a benchmark. But maybe it should be done in another patch thread?
