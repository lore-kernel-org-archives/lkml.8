Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFEEC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD04B20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bw4RN8Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgBKLny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:43:54 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:45374 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgBKLnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:43:53 -0500
Received: by mail-qt1-f175.google.com with SMTP id d9so7628521qte.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=z75+bGdWHvULEy5xQeR/Cnz90mUXwhICSr70HK1Znyg=;
        b=bw4RN8XrMRK5cjD9JA6rYF3oWeOYriApi6IB9fa+DRg9YbKVXwH/0/RgbWKmsbMhwE
         KmvYbu8ChXd/xdm0sMoTueNxKWr3HrKPi6JgWWbzryshkA0Ati+kCsuhm3LCrxvypWlI
         oKslL1LRdEX49X8cqldi3s1MS8TkXUE4GyA+blnP61qqYatLnmGbUosfeEDoOBB5VdS/
         TtSokj25YUDD9dAuJrHg+0lkXYSEl7Oot2Imuxc7iq5fLpMrjWs+6meevfxvdpFu9Wot
         iPZ20wpqVJAZiJEh691i+T1kTdEQ/N9eBsmbMK1sLFoCN50G8RjUltNTfUppyRIT6l1P
         cCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=z75+bGdWHvULEy5xQeR/Cnz90mUXwhICSr70HK1Znyg=;
        b=tIL/b5IjM+6/7bBTRfbUZBFbzd+iu1HEdB2bmMuTZjArgpVssjySGBkas/SgjtnNl0
         n/xVtJ7ww7FXBT5pWClGNdAipwmDOCwNlTVCQJm39Jl6kMGxOZ5uw+HQLKlkjiDO6/IK
         sRVt1DcvaB3o3I36yDoBwzsqRWk4B92VoorHFyWdO1g0PRhnMlgHoCCIKyCW4XQYRJcn
         ORvVUg+IZmlq2ecmhV5jLKUsjHtsnlmChETNgtWl+xgXxl3rCNX8LJSA4tXaSlrd1od1
         9aGnO5UcMIHsJ9BOcCBucDnXdgWYiqIkuwr1PYg/yHR1RHR1ZTvJ004c8fTJdR05rurv
         /5Mw==
X-Gm-Message-State: APjAAAXkrPXnTOGKMmB2tScgFUK+DI9bwdqWEJU03mB9zWLZvPNSmCJC
        lspYNcSGZFY2FZsyasaBU7Edgg==
X-Google-Smtp-Source: APXvYqxC7OlZC3LOOZJu9UhJRV9ovGLGstfCFzDBLvad75qVK9P9fr+e4sdpsH26iJXWZYJsITJTaQ==
X-Received: by 2002:ac8:73c7:: with SMTP id v7mr1976189qtp.269.1581421432153;
        Tue, 11 Feb 2020 03:43:52 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d17sm1848774qkc.9.2020.02.11.03.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 03:43:51 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/util: annotate an intentional data race
Date:   Tue, 11 Feb 2020 06:43:50 -0500
Message-Id: <11DD224B-FDD7-48ED-B205-6C5DBFD61DF1@lca.pw>
References: <20200130200150.GA99121@dennisz-mbp>
Cc:     akpm@linux-foundation.org, tj@kernel.org, cl@linux.com,
        elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200130200150.GA99121@dennisz-mbp>
To:     Dennis Zhou <dennis@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 3:02 PM, Dennis Zhou <dennis@kernel.org> wrote:
> 
> Acked-by: Dennis Zhou <dennis@kernel.org>

Andrew, you might forget to pick up this patch?
