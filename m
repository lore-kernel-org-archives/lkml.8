Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32993C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEC0206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:09:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="HSIPxwRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHXPJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgHXPIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:08:40 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35EAC0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:58:59 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so6358629qtp.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3Lg6YN2Ry/B5cxDee3oV4xQ+pmJ7iBF1X2dnFCrvvkA=;
        b=HSIPxwRf2cj+mLRl/bMncRav861xPU7xirpyGDdcZzeGCQ18GX0gjOFJDJUvvBJ01X
         mXn0okC8WSrTDdcdNbb0MmzveDNRAx8zeIeAS7etWrAxP+tjTJZbYGsvNcgocUxSk606
         uVOfgqVIWoz2fUyc8y8GDps5uWnGfp6slUikvhjSwNg1LWij5sQwNLYJYdQVl8VE0alF
         22XLEDv+j4gCu4LCHxWK8rUEbj+WTLYLqSjgWGHfgIzw525qo5KdSgkBx/LKySxvR+Ox
         1wxc9myaGhu2iO2/PnkPVOfLanlgVbfzjVaNrH66qEKz6mWedwWDodSxpmuvsw9rAfNC
         kM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Lg6YN2Ry/B5cxDee3oV4xQ+pmJ7iBF1X2dnFCrvvkA=;
        b=lrUUK+eG2CSVyUACKb3AoSlxeLTC7ADI7gKkTv4TTUIX/qHX5xZ8hirmbGqEegLNNA
         7tQrJDNclvilKWLuerTrNa9md06Tak/J3cqOZqIPlGyLMigZhPEGoeUx3DzLdowXy/FB
         HXip1rOuX2DAKtWMVikid91A9VQ8sRTjnsA+PiHXEUIKekP2LSyxCGotOoXlaThsyxO2
         sEeA3LWrfYDXecwhIofvV0QwLlPCVqNx1atn6vV7GtQ1ewHk3zTrloIJLvCJFZyFcDq5
         AIlZFbm/bfT8pp3W/IC+f/Rhl7q5Dk03bXxjoJrFmXNf48/ctyi3uSF/fSD+ThmHK8sd
         682Q==
X-Gm-Message-State: AOAM530ClUUcHPmED6WC5GYw2NEdVmexWQ4tnTTu5i+ouoaOKsh0CArD
        EbpzuuU7q7lDd8fDwIb5O3I2mQ==
X-Google-Smtp-Source: ABdhPJwmfntPXsJuVNbDUL1LameP8x7EbRZjYAxcwYutvx9sd1nwCRgn3ABmJZFqHMeBqePurct+vA==
X-Received: by 2002:ac8:5685:: with SMTP id h5mr5281977qta.378.1598281139023;
        Mon, 24 Aug 2020 07:58:59 -0700 (PDT)
Received: from kudzu.us ([136.56.1.171])
        by smtp.gmail.com with ESMTPSA id m66sm9472178qkf.86.2020.08.24.07.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 07:58:58 -0700 (PDT)
Date:   Mon, 24 Aug 2020 10:58:38 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] NTB: Use struct_size() helper in devm_kzalloc()
Message-ID: <20200824145837.GC27238@kudzu.us>
References: <20200619172514.GA1074@embeddedor>
 <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 01:10:55PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-06-19 11:25 a.m., Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes. Also, remove unnecessary
> > variable _struct_size_.
> > 
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> > 
> > Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Cool, I didn't know that existed! Thanks!
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Added to the ntb-next branch.

Thanks,
Jon


> 
> > ---
> >  drivers/ntb/test/ntb_msi_test.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> > index 99d826ed9c34..7095ecd6223a 100644
> > --- a/drivers/ntb/test/ntb_msi_test.c
> > +++ b/drivers/ntb/test/ntb_msi_test.c
> > @@ -319,7 +319,6 @@ static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
> >  static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
> >  {
> >  	struct ntb_msit_ctx *nm;
> > -	size_t struct_size;
> >  	int peers;
> >  	int ret;
> >  
> > @@ -352,9 +351,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
> >  		return ret;
> >  	}
> >  
> > -	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
> > -
> > -	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
> > +	nm = devm_kzalloc(&ntb->dev, struct_size(nm, peers, peers), GFP_KERNEL);
> >  	if (!nm)
> >  		return -ENOMEM;
> >  
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/268330b2-e42b-4d62-1ff0-8462d68e498e%40deltatee.com.
