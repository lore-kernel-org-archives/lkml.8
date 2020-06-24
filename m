Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0C1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0758820706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 11:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="N8tklI08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgFXLmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 07:42:50 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44132 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388360AbgFXLmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 07:42:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592998969; h=Content-Type: Cc: To: Subject: Message-ID:
 Date: From: MIME-Version: Sender;
 bh=9LfcwCs2gMYTXx7sFuykUefGcgaFT5AdWe1eKC67wtM=; b=N8tklI082hHeOgdxalypTvS+k4QkWWgEWKjtLd3C2w0qLDVJ2kTH3eR2q806rHkw4VR1JQhn
 tZ3FToEelapw70zKqNjvnxlrmsM83Pdz9fGDQwwJ0ldXKAzCDsrYLtwUZKv3LdRvlZ74R1AM
 Zx2E3l/gPdWtMkCKDn0f61raPIQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n20.prod.us-east-1.postgun.com with SMTP id
 5ef33c37a6e154319ff49876 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 11:42:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0602BC433CA; Wed, 24 Jun 2020 11:42:47 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82E97C433C6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82E97C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Received: by mail-ej1-f43.google.com with SMTP id dr13so2139698ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 04:42:46 -0700 (PDT)
X-Gm-Message-State: AOAM5301WBr+IiY/+rJ5EEHYcG7TN0xuIBhbIRl6PpQZemRpkdvVxd5k
        yAh9ixq86JT97RDClTYN3+MgA7W9XNqPmve+nSk=
X-Google-Smtp-Source: ABdhPJzJ9MXmI7AxB7p9dEnZdXmLM/XOXdtYb7R28KWD2APpjMTM3oXWt2iEyd2iRjTcP/7T+nqEl8aIgT+ql+1kVpY=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr24116691ejx.479.1592998965202;
 Wed, 24 Jun 2020 04:42:45 -0700 (PDT)
MIME-Version: 1.0
From:   Pavan Kondeti <pkondeti@codeaurora.org>
Date:   Wed, 24 Jun 2020 17:12:33 +0530
X-Gmail-Original-Message-ID: <CAEU1=PkNtyznCms3jjp-oZHW=UAinnNKqG144VuzO5M7MLkO3Q@mail.gmail.com>
Message-ID: <CAEU1=PkNtyznCms3jjp-oZHW=UAinnNKqG144VuzO5M7MLkO3Q@mail.gmail.com>
Subject: Looping more in detach_tasks() when RT and CFS tasks are present
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, leiwen@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent/Peter,

in load_balance(), we derive env->loop_max based on rq->nr_running.
When the busiest rq has both RT and CFS tasks, we do more loops in
detach_tasks(). Is there any reason for not using
rq->cfs.h_nr_running?

Lei Wen attempted to fix this before.
https://lore.kernel.org/lkml/1376814322-7320-2-git-send-email-leiwen@marvell.com/

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
Linux Foundation Collaborative Project
