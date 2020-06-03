Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B3320674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oJcs/F68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFCRGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFCRGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:06:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8FEC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:06:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z64so2021219pfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dcjd3z0GmWTId+8RhXAnhNDgkHnMz76QFDUaBk4C+gc=;
        b=oJcs/F68JWyKbQDpBviTFBK6RCcQliPrvSrwouy53SrB9f4gxn7iMIpheqpj78PKkX
         3lDMjRaawuuYOiOEeb9PgdbxqH/vN5jpkF7DA1kd2TIDEK8RiE0dbdS5qY6cUt6ZM4BM
         EbvrWC3rU1co2Li5JASA6fJm0yTSvTclUYT8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dcjd3z0GmWTId+8RhXAnhNDgkHnMz76QFDUaBk4C+gc=;
        b=I9Z9oIjC9iplp0hthYrpZf4ifMQuw/kDTeVzAi4r7fQEtxxRepBsso2ycNvd+7sIDW
         8tc/BsKeM4+a7H/ZhndVQEOemfF9fctBYa4IAm6NP65O5sdMCxz5xVaTs2lwE6gtmoWX
         tJLt/9z9r/1iiNY3HeEYy6ivzEN/hHQAf9ywDYwGigZnQdAHDUS3rITizWIoUMsyhmbM
         GZn8k5xFG7RqeZc9I4Ut7/z2Ovlp2sPOaCSApqxaASf7ATenL81kxtAqqo0mIteXesYj
         3HYD5U0SRmMUq4wrXdXb2KQ8v0Aoawowh2CVS2VsyyHTeew87uXb9dNAPXMXiv+zejZK
         h6jA==
X-Gm-Message-State: AOAM530c6Wg40BvYIZ2ql58sHMUHRNDy4CIJQma7rG7MHoAxEqmVc+Im
        BXLVz4on3EP/JlCG5mCkUcz12g==
X-Google-Smtp-Source: ABdhPJw47yUopho2Z/amXOjl2Q1vEHBBmJzz59z4nkcmI0TLl/J3eMFiMSS2WG7CnMbs+FG/RLsevQ==
X-Received: by 2002:a17:90b:252:: with SMTP id fz18mr824835pjb.96.1591203975696;
        Wed, 03 Jun 2020 10:06:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nl8sm3700507pjb.13.2020.06.03.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:06:14 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:06:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] scs: Report SCS usage in bytes rather than number of
 entries
Message-ID: <202006031006.2E6B4367@keescook>
References: <20200603151218.11659-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603151218.11659-1-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:12:17PM +0100, Will Deacon wrote:
> Fix the SCS debug usage check so that we report the number of bytes
> usedm, rather than the number of entries.

typo: used

> 
> Fixes: 5bbaf9d1fcb9 ("scs: Add support for stack usage debugging")
> Reported-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>


-- 
Kees Cook
