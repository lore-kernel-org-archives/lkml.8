Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907DDCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BDC7206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDh8SqPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgELQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELQdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:33:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0706BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:33:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g11so2352593plp.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ctZuzP0mrOdvFXnnYs/2o1wzWdulhTSUbqXer0Ilo18=;
        b=fDh8SqPU60lI6TPXL0xB06mkxX6puiXsebxoJlaAKLmVB07HrYfUXhD8E99vO8NQwE
         gMd9eoSlJWTSue3RRnvY+pNo05ZAe5a1kCVy+1xCJMcZ08G2nqCxsmEj3J1UtO3Cx3xz
         SAZmraUZVuIR7nL0opNunUuuqkj9JxON+OMVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ctZuzP0mrOdvFXnnYs/2o1wzWdulhTSUbqXer0Ilo18=;
        b=NouVhZFWXsdBe4DivyO2swr7v6KK46ggWOdlMt4nmmhGWjZ9Jzr0gGw+iYxN+pYXbi
         rpvC5DaNLjdkmvKSgXZQP5KECPmaePIXAbkkVjXpYTqeJHF3yXmsVJXhc58Z/8uoArXd
         lv+y2yVSEewYIl/5hSi5Xfqbr/2k8iWt+LRSTXfCETmAeagH6DNWyVm6ugCZoDMPHVVe
         yF0JUf0uNwUSeb1tFJCo3E+J1O5t+VEJZC72UTX0x1PfkVGXMUJGxRJC50VSNt1DZtz0
         vhfKQQ+16SIsmjhUoduECNTKdc4+Myiw4k3CYdJ4pNHuh98JvaPrCveRO3e+tPcge3lo
         EZVg==
X-Gm-Message-State: AOAM531rq68ugjaA3h59SJ39tHSGR++mOxCS6KtoyAz280sRSm9SpJvp
        PjXkPIOKUrKiTbYTp1KujqcVFQ==
X-Google-Smtp-Source: ABdhPJzVIpIBCQXJuEzutGDFzp+Vae8wcRS4XKqjUGTYDPhU9pydk6Fv13BBb3AfSRYnbNfslp36ng==
X-Received: by 2002:a17:90b:86:: with SMTP id bb6mr154524pjb.138.1589301186185;
        Tue, 12 May 2020 09:33:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 207sm10732620pgh.34.2020.05.12.09.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 09:33:05 -0700 (PDT)
Date:   Tue, 12 May 2020 09:33:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: offset align to block size bofore block operation
Message-ID: <202005120932.96313EB605@keescook>
References: <1589266715-4168-1-git-send-email-liaoweixiong@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589266715-4168-1-git-send-email-liaoweixiong@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 02:58:35PM +0800, WeiXiong Liao wrote:
> The off parameter on mtdpsore_block_*() does not align to block size,
> which makes some bugs. For example, a block contains dmesg zones
> with number 0 to 3. When user remove all these files, mapped to
> these zones, mtdpstore is expected to check whether No.0 to No.3 is
> unused then erase this block. However it check No.3 to No.6 because
> it get wrongly beginning zonenum from misaligned off.
> 
> Signed-off-by: WeiXiong Liao <liaoweixiong@allwinnertech.com>

Thanks! I've squashed this and will send a v8 of the mtdpstore
separately.

-Kees

-- 
Kees Cook
