Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A156C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E2D206CB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 07:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqLdN9FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbgF3Hm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbgF3Hm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 03:42:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC05C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:42:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so17086839wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 00:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EbxmwuEjQQfl0DLnt0sNJ+F2kmsq43FibPJ5cYs3dqE=;
        b=yqLdN9FSFlc2kfZ0HaUeSh6+xZMoG7a9hzTaXM0IMMK5oWr68ppNQrgeClaW4VtRUD
         rFYlYSf6VHD56zsg9coVkWgeRcWacQzlqPnh/db28TtnLyJ8TpO7cot2Jp6WWPSnqj9V
         VKIQCL8OCCYRTJ21S8wEgG0mnhAkrxCUAdTtuj1Qra7KRs9FwPRqSTIpW1CYXVaMfG46
         Y815eVv61K0j/7D463kGd6fefzG3ZSlikA0ypDPxzl8tWlCufEbnpnlBJhlIs7dwOFA6
         ZD0+aXK4MYWSJmdqYHlONh1MTPhdc2VevfIjQLiHbpnjJrXZfpkUATo6S9GZ/a3axCg3
         jivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbxmwuEjQQfl0DLnt0sNJ+F2kmsq43FibPJ5cYs3dqE=;
        b=SMNTzIiiYcKLBd95PWaMwsN0CJw78yrnsnDTgyWBrU4MOIaQV3znkB6rF7Z5jcIULv
         b4Y6i2cbzz52FV6XQP3V4DRh2gG+38aaOyqZtBKZuWT1OrtHHsOsDPwkI0XHkk5IdTem
         YaLTRpt4Jji/LvdxIF7CNYk5Gm/OCxEujFBv3H9Dmw4g6LzohnaMJxJOzdxQV3u+8NN0
         SKtSdfUWjvIGbAnJ4EPDJzkixj2xtbxPct/lRPHxADI+/4WWPkRZda8NIMOHcb7XVEhi
         ef7wCxBqV24FyvO2WHCQ+qADjaUTBw+NAiv3+jd0Ye/1VnbCcF+Ib5GfoOqOqGVCIgSl
         ii5g==
X-Gm-Message-State: AOAM533vSP39UpQbS4LsPc9R5nxKtqnNJfBh0fn0qg48OMhm13b7QDf2
        ELzYH3dUpHqUMnO7ciFnf7SnzA==
X-Google-Smtp-Source: ABdhPJynBs/c9Tpp0cRBlrxHe3SOKjg30fkelhIJdotq3aQy3/38ta6zFfmNTfQnAoNndEXyGBNB4w==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr19908915wmk.30.1593502947403;
        Tue, 30 Jun 2020 00:42:27 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g3sm2848943wrb.46.2020.06.30.00.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 00:42:26 -0700 (PDT)
Date:   Tue, 30 Jun 2020 08:42:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     haver <haver@linux.vnet.ibm.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 16/20] misc: genwqe: card_base: Remove set but unused
 variable 'rc'
Message-ID: <20200630074224.GH1179328@dell>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-17-lee.jones@linaro.org>
 <fff00e6667c442cac13147ee5095430a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fff00e6667c442cac13147ee5095430a@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, haver wrote:

> On 2020-06-29 16:04, Lee Jones wrote:
> > Variable 'rc' hasn't been checked since the driver's inception
> > in 2013.  If it hasn't caused any issues since then, it's unlikely
> > to in the future.  Let's take it out for now.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/misc/genwqe/card_base.c: In function
> > ‘genwqe_health_check_stop’:
> > 
> > /home/lee/projects/linux/kernel/drivers/misc/genwqe/card_base.c:1046:6:
> > warning: variable ‘rc’ set but not used
> > [-Wunused-but-set-variable]
> >  1046 | int rc;
> >  | ^~
> > 
> > Cc: Michael Jung <mijung@gmx.net>
> > Cc: Michael Ruettger <michael@ibmra.de>
> > Cc: Frank Haverkamp <haver@linux.ibm.com>
> > Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/misc/genwqe/card_base.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/misc/genwqe/card_base.c
> > b/drivers/misc/genwqe/card_base.c
> > index 1dc6c7c5cbce9..bceebf49de2d5 100644
> > --- a/drivers/misc/genwqe/card_base.c
> > +++ b/drivers/misc/genwqe/card_base.c
> > @@ -1043,12 +1043,10 @@ static int genwqe_health_thread_running(struct
> > genwqe_dev *cd)
> > 
> >  static int genwqe_health_check_stop(struct genwqe_dev *cd)
> >  {
> > -	int rc;
> > -
> >  	if (!genwqe_health_thread_running(cd))
> >  		return -EIO;
> > 
> > -	rc = kthread_stop(cd->health_thread);
> > +	kthread_stop(cd->health_thread);
> >  	cd->health_thread = NULL;
> >  	return 0;
> >  }
> 
> Good idea. Let's remove it Thanks for the contribution.

No problem, and you are welcome.

> Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>

Just as an aside, this should be Acked-by, unless you either
contributed to the patch directly or are in the delivery path i.e. you
plan to pick the patch and send it to, say Linus, via a pull-request.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
