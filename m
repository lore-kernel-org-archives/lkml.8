Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D22C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73F4208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nbnxXUsV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgFPSa7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgFPSa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:30:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7209C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:30:58 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n2so8745221pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5S0R5KOS0eVN5ffWyi3JgOwmOTFEGE7HvsnOVejhXYI=;
        b=nbnxXUsVX4hRs3R+cqDAYMRsOMWQabw2UMHVtUu5x9oGKGYQcg5mTa7n6TUx2yH/+n
         DWdgFgGIoyg4sQN2DYqPfZM7ed2n+TWlWhZI5qfkbNQJWwZb7xE7TWYMHx8nWl6CbgCj
         GuR5kAfN5a9UxvJKAvTLqLWVhG3eNaM0QykDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5S0R5KOS0eVN5ffWyi3JgOwmOTFEGE7HvsnOVejhXYI=;
        b=EdYIK9m2UGFALiebTaYJEpRpvl7XfkJ+XWE44YyHDRmMgLqPfVTdfcUzgspWaAZwcT
         rL9Oekjo1s07dwBcxH7T0QkUth6w/1eAtwXAyJappmhZuy/SwN7i4EJbF4etGIoPM4hj
         ++773PSsxudCSX6/Zfhg0cVzAkEzSIjYJGJ0652S7ezqA58cTfd3qw4zaV8uyMLLa8Em
         H0gAQxv3BtYnTxtVvzlLB8BMOYlU0cqYfUzoyzNjrHXtbKa+xuAhowWu9v6ryz/A5HjH
         P5iNzlSLwVJJHNrvkOxIiaRnPpwFFu9Li0VX7EQYquX1Ee2/WlsEINB1LOZZzHJlYXF7
         gGBQ==
X-Gm-Message-State: AOAM531gvHux0ErbSVkS7PHMi5NB9GPyYz/8q2S06tiTt7f/uqWQLW7M
        8SzuTMGaPi9QsWC1K1PrpMAdlQ==
X-Google-Smtp-Source: ABdhPJz0FYxqlT+0euPfvBnZUEAlLlzaqSSM9z3K/QSiRItP3jo19QdrhS4x6degcXQvMqcU6F689A==
X-Received: by 2002:a17:902:8681:: with SMTP id g1mr3100674plo.161.1592332258204;
        Tue, 16 Jun 2020 11:30:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n69sm3722022pjc.25.2020.06.16.11.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:30:57 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:30:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] kexec_file: Use array_size() helper in memcpy()
Message-ID: <202006161130.EC036806@keescook>
References: <20200616182041.GA30841@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616182041.GA30841@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:20:41PM -0500, Gustavo A. R. Silva wrote:
> Use array_size() instead of the open-coded version in memcpy(). These
> sorts of multiplication factors need to be wrapped in array_size().
> 
> Also, while there, use the preferred form for passing a size of a struct.
> The alternative form where struct name is spelled out hurts readability
> and introduces an opportunity for a bug when the pointer variable type is
> changed but the corresponding sizeof that is passed as argument is not.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> manually.
> 
> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
