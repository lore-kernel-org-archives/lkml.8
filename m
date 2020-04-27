Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7FC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24782078C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="YX8ypOO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgD0RNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD0RNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:13:16 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B817C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:13:16 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so14871833qtd.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gq/hVuTwOmQSMneMygkOLzC97YbR5RTxhmWsHHCtD2U=;
        b=YX8ypOO5b3tqqWT49nZ/opdp0TWXhSm4SpC9rLf3j2MuHZVTVu9xpLe/99HQIdUHVr
         +MFb16vHQE26XQKzi/a5aJfpBDkiG1X5aUcKedCgu6D/P/XhHUyijIVppLxLc6owMgnf
         cV7xqZcYntn+8iNsFBDtMCcE10OkYNEYcUJGECO7UzgY54qfKODT5wLfRyvq7hnYcQHL
         Sk6Srv+koNou2ywjtFQyPVANIj3QNBhgftnawQ7doap3zL7+6OVhNd1cJ1tLrFGEDP+0
         Nqlp8ZsKOChhhmdP8KLTWIQUgp+Z/kEkcnqfJgiY0AItXA50NYRbNE+tcQEX9UHFdETd
         5nSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gq/hVuTwOmQSMneMygkOLzC97YbR5RTxhmWsHHCtD2U=;
        b=kgEjXJuIR4BNAlwG4uf7IAQE8TxUWMPj1HnXNqJNlH3EL1OtBvET4UGH+dXhNNuXLu
         o2G/k5OtQYZEFNV8g738T5bnVkpj0kzPDI2JBvdhixsblb0S5Q3xqB9wJmC29wPEhpUC
         dKGgsp4a7yKrwp10PV0kV07JMY3tu/wcHpcCOz9ehHQNgtCNYO2rw3+ykcHrfgqJqadR
         /nca6vst2uy/PtZx1l89fQtOMkRkuh3YX+bTIlqPdjkokm3bzUT+K0AsvvNFqfvHLMy0
         SePL02zNyf7IW7UHhAmZqkNcPYpwee/buXEj2S98IVoU6yRDPj4XbvxaUkO+cpArHcN+
         uouw==
X-Gm-Message-State: AGi0Pualw5cIA5+bXJn6ebbs9JpNSvEHPj4uMslX/0n+V7nar07evzyD
        nAHz5Go3/1HJbowyLqC7T5BnQjsS66o=
X-Google-Smtp-Source: APiQypKqt4zdReKZ3Ag1CmWU628rZfgL4oF5Z3XdCebXQsb5Bj8YA2x6ppVzXUH3AI/cRq75E8QZ+g==
X-Received: by 2002:ac8:44d6:: with SMTP id b22mr24395973qto.366.1588007595342;
        Mon, 27 Apr 2020 10:13:15 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id q57sm11571007qtj.55.2020.04.27.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:13:14 -0700 (PDT)
Date:   Mon, 27 Apr 2020 13:13:04 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     tj@kernel.org, lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com,
        linux-mm@kvack.org, guro@cmpxchg.org
Subject: Re: memleak in cgroup
Message-ID: <20200427171304.GC29022@cmpxchg.org>
References: <6e4d5208-ba26-93ed-c600-4776fc620456@huawei.com>
 <34dfdb52-6efd-7b11-07c8-9461a13b3aa4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34dfdb52-6efd-7b11-07c8-9461a13b3aa4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+cc Roman who has been looking the most at this area

On Mon, Apr 27, 2020 at 03:48:13PM +0800, Yang Yingliang wrote:
> +cc linux-mm@kvack.org <mailto:linux-mm@kvack.org>
> 
> On 2020/4/26 19:21, Yang Yingliang wrote:
> > Hi,
> > 
> > When I doing the follow test in kernel-5.7-rc2, I found mem-free is
> > decreased
> > 
> > #!/bin/sh
> > cd /sys/fs/cgroup/memory/
> > 
> > for((i=0;i<45;i++))
> > do
> >         for((j=0;j<60000;j++))
> >         do
> >                 mkdir /sys/fs/cgroup/memory/yyl-cg$j
> >         done
> >         sleep 1
> >         ls /sys/fs/cgroup/memory/ | grep yyl | xargs rmdir
> > done

Should be easy enough to reproduce, thanks for the report. I'll try to
take a look later this week, unless Roman beats me to it.

Is this a new observation in 5.7-rc2?

Can you provide /sys/fs/cgroup/unified/cgroup.stat after the test?
