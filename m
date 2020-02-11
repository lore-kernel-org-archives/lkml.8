Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F40FC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FC52086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9wD+88C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgBKTfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:35:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53507 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgBKTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 14:35:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id n96so1782617pjc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 11:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1zT4iXTmWfkI4wOwmMZ4o18MfCPpAamevZivwdVEg8=;
        b=D9wD+88CtwMSTo6hpt8CWePsexABKBgd3bM2lbSnUnErdTW3pUNzJUdCuGMAzLbOZz
         cDfhYUBxOrCJMOu9ol+HfjPC8DWM1NpgIgakMQcEVRijF9iFb5oyS13p8VGc+Bx5b8Ot
         A7O+sHqutssENyq01UVN0onEWX5QVZFLqdIT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1zT4iXTmWfkI4wOwmMZ4o18MfCPpAamevZivwdVEg8=;
        b=pCfmHVwg4RVFPPNc3leKcOpe8bhok4oDmmTxI7cg4t4tfaiibQSFVfGMCZbec/Ua2D
         emwsTMFo0q+I5HC/zhmueymKMfYpH04kIfPZX01v2Iy5+JnGWMTne1Gzoj/H9unFJI0q
         n+wDhDuFtWy8Y6wzxvx10w+gdo+FxQ3No7vCQLhA8/vmAuXH+7gOI0iOSIBbr2AMlPEu
         a68sqvKcbms915FQBGT4URJozY5O2hbX+y0QkBFZ5m4Gxa7KT7s3M4D7sz/PhAD8+8Vt
         +DxOYKlwRcvD/AVJFXtPgtXDY8qXlT4KYJ30pjCdztNiFBgT3+ENlSXtZqytmP6TC3uf
         WUjQ==
X-Gm-Message-State: APjAAAXo3JMmznCMIEXgC18DQC60KiKIRmz8aYcSQB7XGXCOoxIqaaBk
        H//1jCgInMaaB1GFmD2751R+7g==
X-Google-Smtp-Source: APXvYqyV7C7MX+UFBFOj086mAZSDkpLAhR277H/ITNkZlAITmYHn/RMBUw0+zaF3eCaXvQvEAnLGdw==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr6984510pjc.20.1581449752154;
        Tue, 11 Feb 2020 11:35:52 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 70sm5014226pgd.28.2020.02.11.11.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 11:35:51 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:35:50 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] treewide: Replace zero-length arrays with flexible-array
 member
Message-ID: <202002111132.4A4F073CAF@keescook>
References: <20200211174126.GA29960@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211174126.GA29960@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:41:26AM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> unadvertenly introduced[3] to the codebase from now on.

Is there a compiler warning we can enable to avoid new 0-byte arrays
from entering the kernel source tree? I can only find "-pedantic" which
enables way too many other checks.

-- 
Kees Cook
