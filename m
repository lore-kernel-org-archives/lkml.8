Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56A5C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24242083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599158956;
	bh=O7EOZCmcP37ckIY5s1D18TqEid1+6To2rCpDI0i1dao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NaJFMNB23WvFaAUiL6hczBRaXmTBIDpjvBIRU0hGrWtg7CK9k8PCN3MN2D4/L/WzL
	 C6AuzH/xzpZBuHW4VSvm3gvrfQSmdgk5M0QFsCA80dxtfzAIGNWd0m6+2cm2kn29sW
	 uD09u/7Ree+L+Notk3EXUzGVI3mkDcb5q2Z7FqvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgICStO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:52372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgICStK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:49:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A77D2083B;
        Thu,  3 Sep 2020 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599158949;
        bh=O7EOZCmcP37ckIY5s1D18TqEid1+6To2rCpDI0i1dao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KZqIeQgumDee89I/QcNGP7wCibPJtPiQLdANeKbkR2YQB0FvNVaz+q4k9a/DQxRjp
         DUoL4QAjzeJ6XdXuhgbkfOCfeYEq5HMoUZz9/l1H7PZIyQFXJy7EIgbldG1czC/FrC
         n9gEfXQ4sVG/HLT/fc1zFS2141GezJfddgYUSpdI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC18740D3D; Thu,  3 Sep 2020 15:49:07 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:49:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Turn off summary for interval mode by default
Message-ID: <20200903184907.GD3495158@kernel.org>
References: <20200903010113.32232-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903010113.32232-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 03, 2020 at 09:01:13AM +0800, Jin Yao escreveu:
> There's a risk that outputting interval mode summaries by default
> breaks CSV consumers. It already broke pmu-tools/toplev.
> 
> So now we turn off the summary by default but we create a new
> option '--summary' to enable the summary. This is active even
> when not using CSV mode.
> 
> Before:

Thanks, tested and applied.

- Arnaldo
