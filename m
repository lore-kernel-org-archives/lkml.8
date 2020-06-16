Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A5FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5777B207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mzlz8vzf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgFPSjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgFPSjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:39:04 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF5FC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:39:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so9918277pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8RJK2syfb1UPJfcE04G7USvWkMzpU9ggu2GVyOrhih8=;
        b=mzlz8vzfLovPNfG+Ed5YF/HIguRWsjR3QNuf01Zt+vV/LN6FrwR9kRkYU4zOF2pH/K
         zVimmlH2LI3ykQvPr7+k3xzXnVNo/jxThzz7hStN49Y8UFXZ5EW7t76l3wmrQYe24sXF
         TGgQ8LRyLduDA4Jt1oAm5/gpCPEJ9z0DhTS+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8RJK2syfb1UPJfcE04G7USvWkMzpU9ggu2GVyOrhih8=;
        b=dyNyaEIMd9FybtXo1VUdPLnKLy1J6trH8K59OOKWFE7PanPm5laVwN9Eg8uWrCXtAY
         1fLW7OcF4LsENncxD/ksrKAEW9xDnpSQMPpvtT0EYVnEoMjHrNxd63T1IWl7bbV3ErEe
         rjQ0fHfcwcnMlN6VNlrLajsO9fDOh1+LH2cZWgTCOTqAtDWFbhr4y3TVg7n9xjiKxguG
         8aLGDhvi+fdEElNs4gqpPpnVXkfB0IacZBisV1C/pP3a3ZweQZ+F5tbraEiQfibqmkAS
         M6dJJ9jLemvlm5EVL4sAn8VKqRcHBgO67JPB+5+hOa/2Fs+4mCwhv6dSaZ3Lhzm/DWXG
         9oXg==
X-Gm-Message-State: AOAM533HMgmTnZhwsCEdvlFG2buyfMjRB+QrA4ki0MyX+lJWup+pZS0V
        NgL5RF6j4fgnPdCOa1kk6cvwIw==
X-Google-Smtp-Source: ABdhPJzVzp7zqZA1PABD5+AMJmR2gC3GBlpl79fqxJ6mOA0ZmwS2QyqUlNxqXfXfGuMCMwwilwbhOQ==
X-Received: by 2002:a63:371d:: with SMTP id e29mr3125826pga.153.1592332743713;
        Tue, 16 Jun 2020 11:39:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm3067312pjn.42.2020.06.16.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:39:02 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:39:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] reiserfs: bitmap: Assign array_size() to a variable
Message-ID: <202006161139.1F50D42FB@keescook>
References: <20200616184118.GA1917@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616184118.GA1917@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:41:18PM -0500, Gustavo A. R. Silva wrote:
> Assign array_size() to variable _size_ and use it in both vmalloc()
> and memset(). These sorts of multiplication factors need to be wrapped
> in array_size().
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
