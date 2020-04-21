Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF9BC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4617D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D5E4GkQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgDUTb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725987AbgDUTb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:31:57 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E9DC03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:31:57 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id nu11so1841950pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=NZNBzPPg39ZyrA+9K1+5SfyJG/p/D3ab1EaiN8kOOpQ=;
        b=D5E4GkQI8kMxBOpuDMOjkCGLYjzhv9SzQx5s04xfcN97rcZAXp10VOjQbSAr2Va2Ep
         xOLMpcHjY6zHeW3ZNP3LQzJ0SI8bn5J7t4sslKU5XoQ8Hh7f/hmV2OTnxPoAF8Ci6nyN
         khM6ZLtn45Nblr0G9fbnMUFmCSjbE687sAfFlBF1OaQI60mi6gjnomTCbesFpqhm3BVV
         RD+IOKedrI/zH7nugKGj5JxvNaJpwHc7iAPT/cZDE2h8z/lyWZ5haQUSHayyaaVJjnis
         3vFRPZc89wAtD42w3NPuMAAgRbODqu8Ixx1ApaoC8jSjx15fAdrO1g+HM4T+YSNo5KeE
         imow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=NZNBzPPg39ZyrA+9K1+5SfyJG/p/D3ab1EaiN8kOOpQ=;
        b=QmG7nGKpi91be4YrszETDbDO0yy6sMnNWy8tTgIhDArN5szUopUbB1vWyPLFKKyiT8
         pvSWbI43f921L1VQKORVD0OA09RFk3iOtuWcye+jgAGzNdelwSZHXs1q9DMBnH8PKqDE
         3ng1FzCwQLqzF8nherTw/aUGTMAo4an6lzBXHyqqpJjGM0261+tL5mrhSILl3yigr50s
         V06sWK9cX04StfJ0bafszEQl/FhOL5dukS72OPuw7nS88DP9gQlZ/GTxjxGFxDzVMhBl
         kIa3I82Dq+kVz8+DQgrI006j3LYHJfybDod8niOkmqYIhJpfDZcZ+xsYQhQEg9osGixq
         iE2w==
X-Gm-Message-State: AGi0PuZQUCgJ7VsNSAzN5nPUtH5XNEowsHjWOWMOFYm28crgVMwmEv6L
        sgnUI0goSpXU8Urzy/rENZqorQ==
X-Google-Smtp-Source: APiQypJFBgqr1TsKQVWWIkIK19DIg+mC/W2jjmH2JPSKGjxUsdqPajleKdFLi5uyE7M2nN3ydVuYqg==
X-Received: by 2002:a17:902:c193:: with SMTP id d19mr21224614pld.184.1587497516540;
        Tue, 21 Apr 2020 12:31:56 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y25sm2998977pgc.36.2020.04.21.12.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:31:55 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:31:54 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/5] mm: remove watermark_boost_factor_sysctl_handler
In-Reply-To: <20200421171539.288622-3-hch@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004211231410.54578@chino.kir.corp.google.com>
References: <20200421171539.288622-1-hch@lst.de> <20200421171539.288622-3-hch@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020, Christoph Hellwig wrote:

> watermark_boost_factor_sysctl_handler is just a pointless wrapper for
> proc_dointvec_minmax, so remove it and use proc_dointvec_minmax
> directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Rientjes <rientjes@google.com>
