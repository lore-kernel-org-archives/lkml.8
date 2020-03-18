Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF470C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B5720754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUOxGx3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgCRTIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:08:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39593 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRTIg (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:08:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id f20so1801334qtq.6
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wQ0V/XZLLcou+uD8fYPYOhijMSClpXn10llGIoHAg9o=;
        b=OUOxGx3Zt+nLUll5pRvGTXRjsG+EgQzvP9+uvdCxvTJGCGd2laUoWo/yXPFkLfEq1i
         OcsvRYOu2vv144Yey6mq3N7mmQGh8uddz7XCkuRPQDz5/aH+hsH1pDVWJOJq9IzF1bSe
         LOc7w3mfafmlQ17awY6WxXUF+ORTPWDxBE5tEeLXm/s8zKiq1X0Srz2/l2J8n9/cH7J4
         +bODedbO2xaDPmOCKBn6wg3RX4+SM6QcdMEjNkzTfmVPQzsoXYPH1y+JFllUQWKzKXUI
         htO9WfY7PY3LqG4w5x9p4+u5LoO+RBqvb/zeahqFqWvoF9o4kEaUB8HOa+TgeO5gFCCL
         IVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wQ0V/XZLLcou+uD8fYPYOhijMSClpXn10llGIoHAg9o=;
        b=KH4fTABk67poopiYUBKUh/x7j9gSOkTzaMc40PNUetzsZhvw+c3CPMLhJd5lxG2jsM
         6zt6XNjvUtC2BN1j/Wrfh9jyFAix/upBsd0gbqH2pCDtuV1gvFub6Z8oR5xokVNPV7zS
         WFWuKPc9Jgfa2cwG/51Ib9w+ngAUsD7sN2MxoeYgiSockaSGT42fTHtMUx6eN4MLrVC0
         N3ln7xgxoaltuMsCtNm0CXQ5k/xu4JC4mZNMvpXuEIAvnaFcjdvdMrhgcFjNYCP1BNty
         +kYUUXinHgklTTOGO0bGXm01UtPtTKC3bQZj/ZNj2LSb3JxDZqrdqfZOoJanPNqmfUl4
         hnLg==
X-Gm-Message-State: ANhLgQ1X0Wi5T0cAKKyWa6NeYUFlX73fHQVEpZtvd2B1EGpSYZ1qH/ZZ
        rm6tTX/nFCyBv6g6oS43n88=
X-Google-Smtp-Source: ADFU+vtHF4Abnl+Zw5CIfLcJcZFEp0DohCfCPP2Ihs90+fn//Cz9hNEJA4WJ/AX9uPT9cQNZPE44Fw==
X-Received: by 2002:ac8:312e:: with SMTP id g43mr6268390qtb.360.1584558515195;
        Wed, 18 Mar 2020 12:08:35 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id g7sm4996263qtu.38.2020.03.18.12.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 12:08:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B72D404E4; Wed, 18 Mar 2020 16:08:32 -0300 (-03)
Date:   Wed, 18 Mar 2020 16:08:32 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 0/3] perf report: Support sorting by a given event in
 group
Message-ID: <20200318190832.GP11531@kernel.org>
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200318190116.GN11531@kernel.org>
 <20200318190325.GO11531@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318190325.GO11531@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 18, 2020 at 04:03:25PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 18, 2020 at 04:01:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Thu, Feb 20, 2020 at 09:36:13AM +0800, Jin Yao escreveu:
> > > When performing "perf report --group", it shows the event group information
> > > together. By default, the output is sorted by the first event in group.
> > > It would be nice for user to select any event for sorting.
> > > 
> > > The patch 1/3 introduces a new option "--group-sort-idx" to sort the
> > > output by the event at the index n in event group.
> > > 
> > > The patch 2/3 creates a new key K_RELOAD to reload the browser.
> > > 
> > > The patch 3/3 supports hotkeys in browser to select a event to
> > > sort.
> > 
> > Thanks, applied.
> 
> Doesn't work with 'perf top', should, investigating,

So needs a bit of work, but is doable and would be a great addition,
since we do support:

  # perf top --group -e instructions,cycles,cache-misses

And we should strive to make 'perf top' to be a perf.data-less, dynamic
version of 'perf record + perf report'.

Can you please take a look at supporting this? And that --group-sort-idx
too,

I'll push my perf/core branch after a few tests,

Thanks,

- Arnaldo
