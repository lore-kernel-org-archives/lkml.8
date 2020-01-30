Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828BFC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F152083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 11:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bS9Rk2UG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgA3Lq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 06:46:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41941 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3Lq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 06:46:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so1248239plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 03:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mHao4L7Q0say/yc3EdBS2/qgIAGpyMl6zHoPJFWmk+c=;
        b=bS9Rk2UG0HVFPtXwL1Yv4Zwi5H3ZxA3xW54L3VGdpWZrDfwN8d27Y/iWSTx+C/yYOz
         gKU8iQRF/pTxvXuIhxnq/5GNQ35mT/MYk1iigVTf545BkdH3VkgJNTKCa1RpoGUtIOkC
         DjxtOpaxG+s5iqEzqHX5f8v+CrQzGtSAkRmgG9s131/uDLa+fkNoVONLWGuvJgMjaR60
         PV93+kuLSgtp8PNfv3fBqeeiRP6g1c41GCGsGSUeGEdDwvqQ55vUKeoParHllMVwpKru
         zlxgfKgk7g6Qzq9y94rYhnUY5pjC6pX4q92/BZmeCalmzhEPhF6qfxldRxZrovI8FBVD
         Ez9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mHao4L7Q0say/yc3EdBS2/qgIAGpyMl6zHoPJFWmk+c=;
        b=meLBQT+QzxgWhWoMwOTnAuI4atHTbZUPE1OPAfvNBUR5QEGHF3uFBzRlthu5/CNqqQ
         ZqgBe9W0sNwIwvnV8uUvftWrIHlBGgVPGv78yZkY1uhNzJD0WwGpzrWPqfz7Hzyl/tvN
         OhITdQamwc9d4JI4rAGIk+4/RaL//g2WzDP/NvHXxvEGwe+BH14jM3Gb//I1dB+rPqcR
         sVyvS7YUUJZU8305Gmt/Vjgcvg/8VHTirvWZ6dnC3DUairWtJmSvwGVt2NA4WR84UMq8
         Cj9Wvjr1HsFLCggNdkTg+G6z80pWKJGm1XN8e8UGOxHcXOdb/TMksWQK3VD5uz5TTIqH
         LpFg==
X-Gm-Message-State: APjAAAVzNPrLU1y/y3ZQt/H6dqIxFq3E4Ce4S4fF5tLL+iWQbQdDBiF/
        NkvNrMi/ygOj+Kxo4z9SiGY=
X-Google-Smtp-Source: APXvYqyvDdryt+qtPTjYS7ZGrvIstLr6juyWwbAChzdEyYVSmf75ACaxLHP0qn9eVBL4Wff2B3uLcg==
X-Received: by 2002:a17:902:ba8a:: with SMTP id k10mr4502251pls.333.1580384786626;
        Thu, 30 Jan 2020 03:46:26 -0800 (PST)
Received: from localhost (167.117.30.125.dy.iij4u.or.jp. [125.30.117.167])
        by smtp.gmail.com with ESMTPSA id u11sm6270705pjn.2.2020.01.30.03.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 03:46:25 -0800 (PST)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 30 Jan 2020 20:46:23 +0900
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: fix kaslr-enabled build
Message-ID: <20200130114623.GA179090@jagdpanzerIV.localdomain>
References: <20200129162926.1006-1-sergey.senozhatsky@gmail.com>
 <20200130110008.GD6656@zn.tnic>
 <20200130113134.GA498@jagdpanzerIV.localdomain>
 <20200130113619.GE6656@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130113619.GE6656@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/30 12:36), Borislav Petkov wrote:
> On Thu, Jan 30, 2020 at 08:31:34PM +0900, Sergey Senozhatsky wrote:
> > Oh, didn't occur to me that this can be compiler specific.
> > But yes, apparently it is. gcc-9.2 is fine, but not gcc-10
> > release-candidate.
> 
> Ah ok, that makes more sense. That's being discussed ATM but it is merge
> window so it'll take a while:
> 
> https://lkml.kernel.org/r/20200124181811.4780-1-hjl.tools@gmail.com
>

Cool. Sorry for the noise then.

	-ss
