Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959AAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249C220737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UILrWcCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730615AbgCKRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:50:51 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38596 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKRuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:50:51 -0400
Received: by mail-pl1-f194.google.com with SMTP id w3so1436990plz.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7sBNUBd/uoLqeWm3BCjD6JnY8y62ha07uYYhCFjOniA=;
        b=UILrWcCt+jJLJUObxfK2PFzMp/dMmJGV4+2NQ7xTj16PjSTEdTlS56BE4ru99N2qtU
         CM1pSNk6dXLjcx2xS3j/bYT8cjAGzTFuXWJl1oVGmDXY+12OYUsUdrYojJyqzceetHQO
         UTKe47vBrGbsW9Lek1fuubAptu1/VHwv8GVRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sBNUBd/uoLqeWm3BCjD6JnY8y62ha07uYYhCFjOniA=;
        b=UFnPsHqj/V2qyWA6boPgSxe+PX92hHbqHus25aTl2jy2ERCTiYtdOiEya0PYQ6hEyE
         Z8kGz5pn37e3hWy/WXUPNBQs1DKrm7C8Qf6qr7UNRWs1TWu53gui0X/qp7ItRAhwGoZb
         56dS3llQAdJoWdq7wgjGWLbo8acQp6p6ghs1/MoGqKj6Y18XqXvxOUa2VOLhdVYcj/pz
         cB/RUN/Kf8elwB6oQHO5YllSPZShT58B77u90aNAxLWSDdo6U3BafIFp44ICuW3vZ9GZ
         Q3BmTR7/bnkVhlFoIILwIfFbAuldLB9SMMI1ek2Xi9kBCibGdaKWqPkOjuQT0rt9jNUm
         WOMA==
X-Gm-Message-State: ANhLgQ3qRZ6G0zcInBVo8+y8xmpPZcjomsMV1ZpdCJrgDy/MdDlZ0cyp
        jguJ9sU1MEVoaFXsYYc+wmK40A==
X-Google-Smtp-Source: ADFU+vt/BpnZQvSz+Mve380v5k0wH5olyZUjOt2Mxb6oT1WmMXFk4KZPEIrrPJhKS5kRSe9me30HWA==
X-Received: by 2002:a17:90b:3609:: with SMTP id ml9mr4504755pjb.146.1583949050121;
        Wed, 11 Mar 2020 10:50:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b25sm1250829pfp.201.2020.03.11.10.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:50:49 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:50:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] kmod: make request_module() return an error when
 autoloading is disabled
Message-ID: <202003111050.B5D4423DA@keescook>
References: <20200310223731.126894-1-ebiggers@kernel.org>
 <202003111026.2BBE41C@keescook>
 <20200311174134.GB20006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311174134.GB20006@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:41:34AM -0700, Eric Biggers wrote:
> On Wed, Mar 11, 2020 at 10:28:07AM -0700, Kees Cook wrote:
> > On Tue, Mar 10, 2020 at 03:37:31PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > It's long been possible to disable kernel module autoloading completely
> > > by setting /proc/sys/kernel/modprobe to the empty string.  This can be
> > 
> > Hunh. I've never seen that before. :) I've always used;
> > 
> > echo 1 > /proc/sys/kernel/modules_disabled
> > 
> > Regardless,
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> modules_disabled is different because it disables *all* module loading, not just
> autoloading.

Yes, quite true. Some day I'd love to revisit this series to improve
autoloading sanity checking:
https://github.com/KSPP/linux/issues/24

-- 
Kees Cook
