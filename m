Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F6BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EC720575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=malat-biz.20150623.gappssmtp.com header.i=@malat-biz.20150623.gappssmtp.com header.b="NH6Mv9eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbgCPOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:35:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40237 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbgCPOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:35:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id z12so9151290wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=malat-biz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7125kSM8GMUB8y9raczD1iv7Q58tZuupwW4N/jfaeU0=;
        b=NH6Mv9eN6z4oBwi+JI9/4E9loJl0Cl1wxjcdEEtVjSATZxVcvAOa8U7kAOn45SMuMe
         wTjwXmmrC63EPg874jpi/Bp5ybDkWeeDJncEZAUkYEjUXIyoVWRec4vc1vM/O9o3hATX
         8wgJBeSk2vZ2JjQpSxxUl4aEQm/Uk9VtivSs4BqQoLWBbAbZ876/JmJ2yuuiWX1vZn1e
         o8/J+M20yVu3vd02oqVw1/0Ge7ru5bnpdukFoO0/X8jUx0zNI1CailqDctHGB+62LU4K
         ba7SVaCzsZYfJmb92ABPYnHvw7qL7xJHrbLFxZZ9LOy6aG1HU2WuLMwHQXTDAFlluIn5
         /OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7125kSM8GMUB8y9raczD1iv7Q58tZuupwW4N/jfaeU0=;
        b=j5illTN1hqK97ZgqCtxXGFN23tViaBQifZVaXZimHSsSVsanq006vPN/FFTs7QFLaW
         IO7CKC4m3HvYBT54+0GVXR8SgbaaO0Omb5nKZUFA6PR6YLcNzEOWH/2arQrKrDcgM/h4
         +Vew39LIgSSgdK51v1z3W9upZvQldqWIpfuKqWFu7xfCerFEOl9t41iRO76lQoBU60c4
         BdpOgtLpKaq88jXcXhRLiOdrb7vURYgR/xhHrqEwgCU3IJlMyNcWzVnYBbNirDUAzfy3
         dVp4ASbVQEQ47O/nmB3q4L0lYqMGF3xHYY9huqzHgPq/1pfelDoEi4S/Esm4D0LM1C51
         cB9g==
X-Gm-Message-State: ANhLgQ2iS7Tmv836w4P2QovHIDf0rKtxdoiZ/hDHFQuXVteY5JvzmMdW
        98X/JlXcv97r+0jamMpTDzALLQBsLYMaV8oc
X-Google-Smtp-Source: ADFU+vsO8sc39CQsOFpLoEzniz7yzWlT7UBqrXKqb0GTUik0+v2y16xLGBzFHS+BX5BwicX5xz0PCw==
X-Received: by 2002:a1c:20c6:: with SMTP id g189mr29420954wmg.163.1584369322464;
        Mon, 16 Mar 2020 07:35:22 -0700 (PDT)
Received: from ntb.petris.klfree.czf (p57AF9474.dip0.t-ipconnect.de. [87.175.148.116])
        by smtp.gmail.com with ESMTPSA id y80sm14361021wmc.45.2020.03.16.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:35:21 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:35:05 +0100
From:   Petr Malat <oss@malat.biz>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        x86@kernel.org, terrelln@fb.com, clm@fb.com, keescook@chromium.org
Subject: Re: [PATCH 1/2] lib: add support for ZSTD-compressed kernel
Message-ID: <20200316143505.GA1449@ntb.petris.klfree.czf>
References: <20200316135025.7579-1-oss@malat.biz>
 <20200316140726.GA4041840@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316140726.GA4041840@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have extended the description, thx.
  Petr

On Mon, Mar 16, 2020 at 03:07:26PM +0100, Greg KH wrote:
> On Mon, Mar 16, 2020 at 02:50:24PM +0100, Petr Malat wrote:
> > Add support for extracting ZSTD-compressed kernel images, as well as
> > ZSTD-compressed initramfs.
> > 
> > Signed-off-by: Petr Malat <oss@malat.biz>
> 
> That says _what_ you did here, but not _why_ you did this, or why anyone
> would even want this.
> 
> thanks,
> 
> greg k-h
