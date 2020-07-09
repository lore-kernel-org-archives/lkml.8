Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AA0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 615B320774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fl75ul74"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgGIVrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgGIVrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:47:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620CFC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 14:47:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so1576679pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 14:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3ZVIY3Uh21PSHby7uDQirlJmyVi+sT/V+eGSfwDSnig=;
        b=Fl75ul74qjFTiw8HF8Zdsg0x9BeA1yYTtFUlTB3tyfIxzsbiAqppQhDl78MrHtBk+u
         ib3sE81iaCMvr4RPhmlfQUj+oKBiwBHDKHHfFNcCWHo7zISurmMlPoEoP8SGas0EVl0j
         6i+35yqlwGI+jSeF/u9Jr5hAGTFwbHBXw6+5epFxk1kFf24a4MzaNbm96aH+cVszf1Sp
         t2xPn4prKDvcz80pcdupK3Z2cJbsaK2l8LUwvet1XwzqIzAvr18k4PjhkQEfvfYffwGB
         lekYmJ67+Ik2fuPvPmv3PqhUvjupnMJjTjZoiSxxKohngfWv4Jz5/ie/kW2q0rGqC4CJ
         QqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3ZVIY3Uh21PSHby7uDQirlJmyVi+sT/V+eGSfwDSnig=;
        b=eFOVPnmZguk6/w46qXwh3cCTaYUNr37BNwRH+Wk63pd7l7bxqGXfimMnaL4HrZWcJE
         XPhVeWY83lh23kmGVX1Vx6dR9CXO7uaEQI0Th8xbJu+26wZAek+scrW45UYP+W4blBTf
         TdSPZ6so+8mBdQdhygXf9fp1hzvpcvD5NWeW9da3Ih/fM0Oht0/aBClpVw/yW5NBCe1E
         q+UQwQoauWhsYv3mhB08GPxaEIunKmSeiYkv2xgsMhA+B6fJqG6/5+tYOSpVcXzgux6c
         bbSfUrVATeld9t6UqVWbDotgwx2DAUcoXDe//piwxQXgXXz+AmshnlxueeOH6ZpogKdj
         lf/Q==
X-Gm-Message-State: AOAM532tcKRb4DwbukQI4f3XQb8PpVU+wbD+lqssNfP6jsHvw0dMLLCu
        cGmLcYVZOk1T8j5daUsN9eXc5A==
X-Google-Smtp-Source: ABdhPJyZtlWIYvpC/I5htgEiy2+tQZ1xz65j289wDj7iN+c23npcW1nofGWxPnNkteDa+fctbj/YxQ==
X-Received: by 2002:a63:8c4a:: with SMTP id q10mr56412758pgn.431.1594331259707;
        Thu, 09 Jul 2020 14:47:39 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id e16sm3720025pff.180.2020.07.09.14.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 14:47:39 -0700 (PDT)
Date:   Thu, 9 Jul 2020 14:47:38 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-pool: Do not allocate pool memory from CMA
In-Reply-To: <20200708164936.9340-1-nsaenzjulienne@suse.de>
Message-ID: <alpine.DEB.2.23.453.2007091447240.972523@chino.kir.corp.google.com>
References: <20200708164936.9340-1-nsaenzjulienne@suse.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020, Nicolas Saenz Julienne wrote:

> There is no guarantee to CMA's placement, so allocating a zone specific
> atomic pool from CMA might return memory from a completely different
> memory zone. So stop using it.
> 
> Fixes: c84dc6e68a1d ("dma-pool: add additional coherent pools to map to gfp mask")
> Reported-by: Jeremy Linton <jeremy.linton@arm.com>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Acked-by: David Rientjes <rientjes@google.com>

Thanks Nicolas!
