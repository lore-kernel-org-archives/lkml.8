Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DB3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C21020842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 15:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyFaO127"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgG3Pzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 11:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3Pzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:55:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:55:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id e13so26029227qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4YSjnVp4/9C5q/utLjgMaiZiPxF7B7rOPh2+PO+uGAs=;
        b=qyFaO127E1gs0nyp31TolBs41quQo5WRMF87hn0J1cUrhboBLlt1Hoz8oWHw+9cAku
         /OhbqE9y7B1ia0ZTd0ZV6l/XlCuJAnRI+9l/thDtrr3R+SPdnk2zpop+SCbr3TwRloRb
         xxEjkzR49gfJCAhZ45ojshsYAy1gpEE3am7fhNBCZYz83z/0bY59xec7Al+nDthKqfM1
         HL69s/yjSYU/cwlRefjch08Fv4psrcppwC2bX14JO9fo64/3U53VfJ2uc+htrpNd77OU
         /2iaezyCAZz3TLa1PKnN9SFe2IKL08TZ6+zwpWbm911IK56aXSLTGpBmrDc/fbNvYTmC
         kkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4YSjnVp4/9C5q/utLjgMaiZiPxF7B7rOPh2+PO+uGAs=;
        b=gjv8vS/dMWbwojZ4rot6xppKzLMrI6dYKq1/rkR9Mt+/YOEeJ25cCc7qEJTKpc6m+o
         vVDePTOLbY+oHALIaMW1cuqyLIi+lfbnSVY/xbbPkTCNW0X+zyzHCsS38IvbXaFsyqK9
         a/HtECkFk03Vp/hSYlYHFrZgeAAWJJYtvvbdDGz9GBidpNDe4Dq57NzWaEPVCXi14IHI
         8dlAu7XfoEig1+xHwJnuF/2EptfCUxEhIIdA9yaCSMub7QMaaX/88lDabuu2DrpsEyt0
         ZKAavrqf6md/LOxfKpVlnltFMLHQrHDE/CTjKXIBaq0pH/mSgtxpeuTdIjecRBs9ROo1
         9o3g==
X-Gm-Message-State: AOAM532tKdmbqbhGpmFux/+R0gqddjWO5YOsaSeWQfcMTzZBLBc4KOjE
        0nX2P6vA/001wxVbuvccTRl1QQ1ZMMc=
X-Google-Smtp-Source: ABdhPJzfWUtj5pWPOa3uXrrVgZ3SmoxslpEGm7VPyL/kHXggPXgAAdTILmq/n9X/5e26g1y5v+1z1w==
X-Received: by 2002:a37:bd46:: with SMTP id n67mr1805551qkf.190.1596124530947;
        Thu, 30 Jul 2020 08:55:30 -0700 (PDT)
Received: from supreme ([2804:14c:1a1:217b:9469:41a3:f900:755c])
        by smtp.gmail.com with ESMTPSA id c7sm5188899qta.95.2020.07.30.08.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 08:55:30 -0700 (PDT)
Date:   Thu, 30 Jul 2020 12:55:27 -0300
From:   Rodrigo Madera <rodrigo.madera@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     christian.brauner@ubuntu.com, linux-kernel@vger.kernel.org
Subject: Re: bpfilter logging write errors in dmesg
Message-ID: <20200730155527.GB1829@supreme>
References: <20200727145013.GA2154@lst.de>
 <20200730005902.236086-1-madera@acm.org>
 <20200730060654.GA17803@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730060654.GA17803@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:06:54AM +0200, Christoph Hellwig wrote:
> Ho Rodrigo,
> 
> please try this patch:
> 
> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
> index 1905e01c3aa9a7..4494ea6056cdb8 100644
> --- a/net/bpfilter/bpfilter_kern.c
> +++ b/net/bpfilter/bpfilter_kern.c
> @@ -39,7 +39,7 @@ static int __bpfilter_process_sockopt(struct sock *sk, int optname,
>  {
>  	struct mbox_request req;
>  	struct mbox_reply reply;
> -	loff_t pos;
> +	loff_t pos = 0;
>  	ssize_t n;
>  	int ret = -EFAULT;
>  

Christoph,

This killed the issue!

Can't believe I missed it... The pos numbers were a dead giveaway!

Let me know if you wish to do any other tests on my end.

Best regards,
Madera

