Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C00C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 257D021D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AMi6K8LK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHEUu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgHEUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:50:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCCBC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 13:50:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i92so3679191pje.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 13:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IX9XrPUzOcyKkpmBN/wRczSmpUnTjA2wU4ML+y9lkZ8=;
        b=AMi6K8LKX1VQCBDo+8/FHHEO12L0113YiFMtxUoRuvYnMXNOau5IOsAMJBeoHyUPvz
         syaxTLjdh0s5hixSX2+615yeJbMX/icq96mS0El/s59+/3aYS6wjSZ9cpm/gCZWiUtLP
         wCNGlh9BDMAoEeOqKiBE7ODo4wL8f+Cmx1wIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IX9XrPUzOcyKkpmBN/wRczSmpUnTjA2wU4ML+y9lkZ8=;
        b=Fxs347Iz8wFvTrAk+iMYftFmZ/dN0Yp6G3/CeRI/hX7dpYbCuSLx8Q1mCATSJV8yLH
         9JchNjsb338bli/Wdx1d3fkcJOjtmeHjLOlmsDYpqy0gL84Vn9MHA0KqD0HNRomkzdpZ
         KqyU3QAuKYTPejUQOR9AiHdhl2BvUmWLEs/jUVn/pBFjajL1bCCVUO9cadvn5OVf6yEq
         pqbU5x5fujX+uDuimhZwiHzRCA65Vj/jbQGqu/J8hdtObbQHrMWIHfGRTd+nZvXi6/tE
         Tv8N56ifYiMBKoLeFKfaeR9RCl09lw6TgrbZW3FmokMDgU+THLOcRqka5jQ0oac6QHlJ
         96/w==
X-Gm-Message-State: AOAM532ox4KvqMmp9wKNNPD0C8EoWh45BT98Vl/oi15yBo9K5EKuuyLW
        SDhspQuCCGc1QnP44+BQjj3R6A==
X-Google-Smtp-Source: ABdhPJxyidMPujgN2fn9cGhCwYoULrrcvpnTqk0YBB0eSUmdPS1OzUXvCVsfSSkTOPx8c3h7OefOiA==
X-Received: by 2002:a17:90a:f012:: with SMTP id bt18mr4586168pjb.63.1596660625999;
        Wed, 05 Aug 2020 13:50:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y65sm4787621pfb.155.2020.08.05.13.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 13:50:25 -0700 (PDT)
Date:   Wed, 5 Aug 2020 13:50:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] saturate check_*_overflow() output?
Message-ID: <202008051349.553E49E12@keescook>
References: <202008031118.36756FAD04@keescook>
 <f177a821-74a3-e868-81d3-55accfb5b161@rasmusvillemoes.dk>
 <202008041137.02D231B@keescook>
 <6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d190601-68f1-c086-97ac-2ee1c08f5a34@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 01:38:58PM +0200, Rasmus Villemoes wrote:
> Anyway, we don't need to apply it to the last expression inside ({}), we
> can just pass the whole ({}) to must_check_overflow() as in
> 
> -#define check_sub_overflow(a, b, d) ({         \
> +#define check_sub_overflow(a, b, d) must_check_overflow(({             \

Oh! Yes, of course. I was blinded by looking inside the macro and not
wanting to spoil the type magic. Yes, that's perfect. I will spin a
patch...

-- 
Kees Cook
