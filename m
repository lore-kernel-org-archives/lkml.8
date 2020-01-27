Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793F6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4117B24679
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ciJt1rdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgA0XPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:15:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34612 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0XPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:15:10 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so5950213pgf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gD4TaYevHV9sf6z2Ues+OYW8jGYcOMbZOrsCySHlsuE=;
        b=ciJt1rdKVSRDUOioLi40WpjRr7xZIlTV+OKJRIH1QXZwGrsbDAUTmAiDO7wWUjOWkE
         Ec5+nhr69kf73PP6oIk6E2XkffgdUlQGnL/AoShg7ZyexDMRc3x5dkPR2z7Gj7fzCFAi
         AeB9kxv6Gwd0gB/6G28XssGTFRJveeQp1N4cI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gD4TaYevHV9sf6z2Ues+OYW8jGYcOMbZOrsCySHlsuE=;
        b=KRugprUNYRcSRzk17rJoUg205AdaBqydC9zW7D8uqq4boZ0XdG0y9coo/EfBkM4T1y
         4Le8yjDTR+cZKxQBu9qy3dVKYzFSYLgittKXZBNLltRq/FTzE3mO296FzIDrHoUoGqZ1
         Jcj3sNrCFjY6Aw2a8y8LqvIVV/JXrjcbqTnbxoP9FOgUn7LeIDzfAM6vkbByFY+tnhDA
         bkFNMEfV8JZBNawypoiBqGCNU97v9b2pHHLMchr1fVXuZYCKs64VBFv6QrL1WFr4omNN
         MaS+di0D3+/6Xxp6FrT6lAaFyQJF5pUnfE927LWqjMYtSl8BzZtvA5YprbKKQB8f4wgp
         Zh+g==
X-Gm-Message-State: APjAAAWGF6fsYtBlqsXCrAs/ESOUkW08SQhfjEinEz6S5iGR9MRrf23P
        JPZ0tcL3/5DQf6Fp/aCk4VB5Iw==
X-Google-Smtp-Source: APXvYqzQDGSPpI3vAd3/Jp3gfh5zybiEbPF3Pot/ES3NTam8x9CKR7FEvf5GsWJA7oezDX13/mMyLw==
X-Received: by 2002:a63:ed56:: with SMTP id m22mr21385900pgk.261.1580166909751;
        Mon, 27 Jan 2020 15:15:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i6sm1930008pfk.38.2020.01.27.15.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 15:15:08 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:15:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH v2 1/1] lkdtm/stackleak: Make the test more verbose
Message-ID: <202001271514.345A5CC9C@keescook>
References: <20200102234907.585508-1-alex.popov@linux.com>
 <e8f1b3e9-50ae-2482-3e10-32b21cd7ebb4@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f1b3e9-50ae-2482-3e10-32b21cd7ebb4@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 02:58:44PM +0300, Alexander Popov wrote:
> On 03.01.2020 02:49, Alexander Popov wrote:
> > Make the stack erasing test more verbose about the errors that it
> > can detect.
> > 
> > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > ---
> >  drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
> >  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> Hello!
> 
> Pinging about this version of the patch.
> 
> Kees, it uses dump_stack() instead of BUG(), as we negotiated.

Yup, this is in my queue -- I've just gotten back from travelling and
will get to it shortly. :)

Greg, feel free to take this directly if you want, too.

-Kees

-- 
Kees Cook
