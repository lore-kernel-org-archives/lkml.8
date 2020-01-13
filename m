Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B4C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6BD20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GeMpERhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgAMKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:44:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAMKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:44:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id d73so9062535wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=nd9zBOJ7DFj/Dtbz3rp6d+0XndVo+gDlgYvFDKYp8+s=;
        b=GeMpERhkvEG3M47S31KSbXI+27ByB7S40b72fz7RfsAQuOTyuaw8yr431i6iJs18ke
         zZgsLTRC1v0aVjdcrATovJ6LKokk/zpnR8gp9B2JZThmh0N6EpPp4mQkvJwyXB50jeey
         ECP4IdxzksWrRVvCHMd3qSCPdRafW0JeyzwDQRFAQ2sPFcdjKkiX7IfPv/Pt9O2U/BGO
         eGQRyEWTqQ6K6eDSFPCYkM5jfVinjqehiEtGXmQAPNDzh090InO0frjvAjZlRkGK4DbW
         /TcreEygUmGt7Ld2aGov6sV/ctIrGXEPvYjRxMA0n/3ppu7jjWIBgqpFLAPV8sXmhemv
         LnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nd9zBOJ7DFj/Dtbz3rp6d+0XndVo+gDlgYvFDKYp8+s=;
        b=fPtyfeiQnBigljaYMEa2+26bgN956XDyX4EHfEB8i1vSYaPQUU++eaSKl/QggtKzJs
         lqU98HdffkG0KgUruakJiV+ShGpqzGUDydhUz5zL8ZiMh68vjMB7/04s1xASTLQFUJTV
         gXkyCK0JNnO6hoh6EsM8J/SRfBlqvoC7AWfeOjHNl0cHqmm5Hn6Qq21z+iVGByr/hLI4
         bxQyj0/wsHPe6lIZFZV4G2B3p6LsfYa7XvF6RyKDUbAf0ThKFlCdA589+k0Uot7Xec6r
         EtC6YvmJemX0ZuHvqGdWEnpkIhDjjzCRzkMhF7lcHPs+719kfuOWTvfIlm4ln89xwM3z
         t04w==
X-Gm-Message-State: APjAAAXraoYcHERxYp0I9qG/pWFUcwAq1SGE/1llncnAWcIJDy0jRiUv
        bMLaef/E7Pl0y8zNA2SBTnXLmw==
X-Google-Smtp-Source: APXvYqzbSS4ol43wiLTvRNFz/aOQQaGCIVNj4PCQ/JFvnFJbo3oKqASF6jPc7L7yw7tahunzIRdGwQ==
X-Received: by 2002:a7b:c4c5:: with SMTP id g5mr19554043wmk.85.1578912245829;
        Mon, 13 Jan 2020 02:44:05 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id 124sm14411631wmc.29.2020.01.13.02.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:44:05 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:44:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] mfd: madera: Wait for boot done before accessing any
 other registers
Message-ID: <20200113104425.GD5414@dell>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
 <20200107142942.GO14821@dell>
 <20200108084220.GH10451@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108084220.GH10451@ediswmail.ad.cirrus.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Charles Keepax wrote:

> On Tue, Jan 07, 2020 at 02:29:42PM +0000, Lee Jones wrote:
> > On Mon, 06 Jan 2020, Charles Keepax wrote:
> > 
> > > It is advised to wait for the boot done bit to be set before reading
> > > any other register, update the driver to respect this.
> > > 
> > > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > > ---
> > >  drivers/mfd/madera-core.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > I'm assuming this patch is orthogonal to the last?
> > 
> > Can I take it on its own?
> > 
> 
> Yeah these can be taken separately to the other series we are
> waiting on Mark to review.

I mean the patch.  Can I take 2/2 without 1/2?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
