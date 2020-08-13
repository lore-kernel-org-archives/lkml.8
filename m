Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989B8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A50206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597345893;
	bh=cOcfB7nbJyqLQGMFsdsQPv1nXUC5ZTVXWSLeksPc1PA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CpfjmlgW5qNRL0i14YtzQsIf+Y9YMRSPWPmjNgTNgnEo0Y8WCOT+XBdXFRPdM10LW
	 VV2qRsxp923GvSnsbvamhT1yi7cidsNo6lMX3K3RnPpflM/qkDoFAJ9f6uNHCMuleI
	 v7PU3qrT6iSXceIWC8nXGqoEBl/Vb5+VWW0u68LQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMTLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMTLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:11:31 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCEC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:11:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id t10so7351514ejs.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wiZHFOS0p4Wx+TQaA45zMNcXvNKrwq4/dnRev4xFVts=;
        b=eE3P09gOpuf1Pfc6cnMCr14pU51jbhmOAupty5CWyLDn3pHefynyC0603Yz3+DVNjf
         +ndMLHQLnUatue4KdXDDbpiNRm2wtcE1loSbQakgdtJLowrBUkd3wYxoJFSmlycE1JH1
         6ZrLDo7CCOkdKTpTsuSOMw+T1WTCSrDBDbQTiqBqDJH8Ok72rnOk93L/59YJvg0KtHXV
         C5wnpBgal+sZ7tYLt4NK99vUOSGcQpJN6z0ov+kbzKJrGo02IaxjOwKWAYlGMkWpzX+8
         jDlYg1JZrHUu+O+xxZPP0FRk+59Cj6oRe0WHwvgSJpUgdknTpHaHuwycfU2y9D49hgD3
         hN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wiZHFOS0p4Wx+TQaA45zMNcXvNKrwq4/dnRev4xFVts=;
        b=tQzv3WWaGNNZI4eZuJSxOhBlTHYR1sdqHi423ZSsk9B9CQU3djJTn95wlI1XTSu/ui
         l3o29jGtjihICc+DoTsKDTOSozQK4CTDsTeLVlV/tnesm6lSdC6IgL/k0k+SxuigWBpZ
         5bT3YLIhaQaZ3KjIwHZcfH++twwbTp4t+nWhvwCDwzf4XRlULossKjjAomHGy9isiz3Q
         nf4CVYnU+/Ig3s9iYy3bJfKvDQzC3QrDvdj9fE5DpvoTqQsjo72bZYH0mNbTBQYTQnCI
         vNggjEOHoEmPwmrnPQnv9XNxsHiy8JZk5o2Chr0QGRSOuDWLVsZlhQGo9KsGSYURnDHq
         Z01g==
X-Gm-Message-State: AOAM533WsubuQ63oEftFYfHaTvp/K1/ns7RnDHdAaFdRha0dxiBLqwgC
        8swkFTFgu9PxyVxcFS4P9ngPRAFO
X-Google-Smtp-Source: ABdhPJyiTSATemEWQpMRNfJHP48xxFz3JnlSYgp/bFGlsdYB4sd4+d3qkeVl3GLpbsj5cCjnsVTLXw==
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr6341929ejy.353.1597345889560;
        Thu, 13 Aug 2020 12:11:29 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id l7sm4621437edn.45.2020.08.13.12.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 12:11:27 -0700 (PDT)
Date:   Thu, 13 Aug 2020 21:11:25 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Libing Zhou <libing.zhou@nokia-sbell.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de
Subject: Re: [PATCH] sched: print fields name when do sched_show_task
Message-ID: <20200813191125.GA2337490@gmail.com>
References: <20200813104833.17573-1-libing.zhou@nokia-sbell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813104833.17573-1-libing.zhou@nokia-sbell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Libing Zhou <libing.zhou@nokia-sbell.com> wrote:

> Current sysrq(t) output task fields name are not aligned with
> actual task fields value, e.g.:
> 
>         kernel: sysrq: SysRq : Show State
>         kernel:  task                        PC stack   pid father
>         kernel: systemd         S12456     1      0 0x00000000
>         kernel: Call Trace:
>         kernel: ? __schedule+0x240/0x740
> 
> To make it more readable, print fields name together with task fields
> value in same line, remove separate fields name print.

Makes sense in principle, but could you please quote the new format as 
well in the changelog, not just the old format? Makes it much easier 
to compare.

Thanks,

	Ingo
