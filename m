Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30841C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5CF207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:27:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="EovH3Vlz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732884AbgGVP1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgGVP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:27:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC095C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:27:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so1450015pfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BU5kao+UrN6qaCFLRvgX1CCWwHi4WqVglmjspXYq5Sk=;
        b=EovH3VlzCQtsuc+av4WNCxJUcxJwP7B12FigkxGwdbpkWBJSa3nFzmdyDHewZBUgf9
         n9XAAbimkyD6gzI4ZP5yddnLgDay1H3s8JWoHuKzSxSnwrCDbkxcwIVY/juKY/c9O6eu
         /OJSCysVhxcaeiqedSqEFceKVfg/12GZLPjr8pz1XHtNHTXpeFGbtjZFu3+roMJb796i
         BBnMW3Am+YU+1yDNm3kWRfcRFBtPlDgDBFvjGBggj1IU6U2AeUKKCFIvvGVB0VJDmGAM
         OReaUOEwz/0BPPxzQZFG4OMdZ6z6W9/XcwI4LsFf0nnHHUL9iPyaLIxuLhiXMi9xOuXE
         S9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BU5kao+UrN6qaCFLRvgX1CCWwHi4WqVglmjspXYq5Sk=;
        b=AOnauNt4oTdYkaeO7F3BdKBZ/411rhuaYQjA7H9Ho4V0Pu2pKlQcSaj6Oh8REgFfKm
         f3x03capdz0tVytwOr6N5DSOf1dTagiegL96x1iujXNrp2+IFk1enEWYPbds0KwT90jk
         4L9R4V5HPrO5QW1BJs3dqElwPqSC1yc7FddWjbYfuXWZcWhRHau11BpIPcViOXLpBqlf
         9hl50HrYkzUr0Ldc3KfPytb6nCFszyhDiq6B6pMUURAUpo4US/qpVYsspbYkHTWBM1mR
         2d5PECqhxrfrgE661Yw8vcthw/6qAk2e9aGlWupJ45C35Z52JjSX+cGRlxDFoKDmNZro
         VTFw==
X-Gm-Message-State: AOAM530bf7Q95k0gYBKHbcnzzlFYWnMtbupilQE6swmfNeufNfg3kXcf
        5V3bPfciCUUWhGYr/ksOCvlI6+lo2o16PA==
X-Google-Smtp-Source: ABdhPJz7gxZddqXP9qDdhZYE/mLuRzLNI5tYgqcLfKtMO+PIAiD+BS9SLWN/x3TbHpXr660AUHbyWg==
X-Received: by 2002:a63:8c4f:: with SMTP id q15mr317114pgn.373.1595431670305;
        Wed, 22 Jul 2020 08:27:50 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id h23sm173554pfo.166.2020.07.22.08.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 08:27:49 -0700 (PDT)
Date:   Wed, 22 Jul 2020 08:27:41 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     David Miller <davem@davemloft.net>
Cc:     wangxiongfeng2@huawei.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net-sysfs: add a newline when printing 'tx_timeout'
 by sysfs
Message-ID: <20200722082741.1675d611@hermes.lan>
In-Reply-To: <20200721.153632.1416164807029507588.davem@davemloft.net>
References: <1595314977-57991-1-git-send-email-wangxiongfeng2@huawei.com>
        <20200721.153632.1416164807029507588.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jul 2020 15:36:32 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Date: Tue, 21 Jul 2020 15:02:57 +0800
> 
> > When I cat 'tx_timeout' by sysfs, it displays as follows. It's better to
> > add a newline for easy reading.
> > 
> > root@syzkaller:~# cat /sys/devices/virtual/net/lo/queues/tx-0/tx_timeout
> > 0root@syzkaller:~#
> > 
> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>  
> 
> Applied, thank you.

Could you add


Fixes: ccf5ff69fbbd ("net: new counter for tx_timeout errors in sysfs")
Cc: david.decotigny@google.com
