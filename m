Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEC7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14E2222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581658330;
	bh=0XCC6PWPF29FcnHFcnUyn1Gnz3NxA69HtzrTAmk3D+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=hVjcx3mtivwJnqErVhc2hWB0KAx2kFXIkC6Q57XLFITNTGpzamtJpj/s/hp+s+FmU
	 X8FZ0xIlt+srMvoyaLvAFXX+uGKnh1wWStXPmNeBeyAz0Fnf1dTt6uW8ZLGJoS3PGS
	 TO6wsupbAQ7SgCRZG52wGSpsNd8gU46nhOYz1gd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgBNFcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 00:32:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:49986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgBNFcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 00:32:09 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B902222C2;
        Fri, 14 Feb 2020 05:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581658329;
        bh=0XCC6PWPF29FcnHFcnUyn1Gnz3NxA69HtzrTAmk3D+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WTL36L26p8iakIvjdn7YExA/A2xLToewosQxcZjWjc8+304bSzejHJFrprHkHuTp7
         +YANGa1YqM1s14vDlE30Q/WcFCVG3YUaXF461bmDM4rZaSbN3+ZFkcvMpDEumrLcVH
         jsfY/yokVh7NpjBSj2VtuQzaZLy9UGpInS61G3xo=
Date:   Thu, 13 Feb 2020 21:32:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-Id: <20200213213207.34b2aa0e0c2c92a09b700e96@linux-foundation.org>
In-Reply-To: <20200128003942.GC20624@richard>
References: <20200126132052.11921-1-richardw.yang@linux.intel.com>
        <alpine.DEB.2.21.2001261443020.164983@chino.kir.corp.google.com>
        <20200128003942.GC20624@richard>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020 08:39:42 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:

> >Is there ever a situation where the cpu to be onlined would have appeared 
> >in the cpumask of another node and so a different kswapd's cpumask would 
> >now include an off-node cpu?
> 
> No, I don't think so.
> 
> Per my understanding, kswapd_cpu_online() will be invoked when a cpu is
> onlined. And the particular cpu belongs to a particular numa node. So it is
> not necessary to iterate on every nodes.
> 
> And current code use cpumask_and_any() to do the check. If my understanding is
> correct, the check would return true if this node has any online cpu. This is
> likely to be true.
> 
> This is why I want to make the logic clear.

Please resend with a changelog which explains the above?
