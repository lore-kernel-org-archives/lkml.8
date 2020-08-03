Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D600C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321652073E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596495062;
	bh=hRhzS0IcZ85osF3F5r8vW04ynVxYX/YFauy9artJ/so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kn9xI0qiwAZEH3wUwzswroX3xehR8+6z7+cDiqSXQHzQvLb6/u4jcodI+DppQuLML
	 Rjn57diHjU/56FPLepA8BDmIuJCo3nrG0eu5EZa148F7F4pIlzV2VXaU4OpyMehXUd
	 RYYGCdY8+Dzj1LuSVflWu4Vdmz4cvwcbxscuoQYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgHCWvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:51:01 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43986 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgHCWvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:51:00 -0400
Received: by mail-il1-f193.google.com with SMTP id y18so24122511ilp.10;
        Mon, 03 Aug 2020 15:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vFjOPpSlF90T2Ir2lWmLxcZyeP2Xbk9TRXdaHOINJzY=;
        b=i9U6hHk3llu8TibnYy11TLnEhzJic2L/8fyKDUaK+AMh0vflmNj3yXxOkrBx7j+9CJ
         385E6sycB2CRkvAXp4X1bmtq987fcq3b65BC59b3hynb1EUDDVtZFYnk5wpSLVgwi1uY
         7NzVcOyP0HZYLjatv0jM9IVNGXBvD9BqFbzI9hgoj3huctH6qHN6LCkOvZbRRuQC6D6l
         kAkLQ2zRKPTFMia9jUmKCjY7I17j8RLUMi5ksA8IxPbZ34CpB5UfDk7/emx958D5YSpc
         brW8uOaT3ldzRMpA/heoWex5HaOcXALCD8EImgpOu3dHKigVzDLmRG5+NeLAfcZ7LS27
         F8EQ==
X-Gm-Message-State: AOAM530bQcFS9c/HOTn4Sml/CnMIvdITHKLPNyE6e0Kc69AMQrCufw3H
        y+YvIUvkWeg8s+/KyQLMLQ==
X-Google-Smtp-Source: ABdhPJxyGb05fd1DxB+6uXj3V1GZAc9T6EKzCDNJB1v2YuEebatwcG2DvnOsv86rRN6bGYchyYNz/A==
X-Received: by 2002:a92:9116:: with SMTP id t22mr1708877ild.305.1596495060014;
        Mon, 03 Aug 2020 15:51:00 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v8sm8921510ile.74.2020.08.03.15.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:50:59 -0700 (PDT)
Received: (nullmailer pid 3280412 invoked by uid 1000);
        Mon, 03 Aug 2020 22:50:58 -0000
Date:   Mon, 3 Aug 2020 16:50:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org, huyue2@yulong.com,
        zbestahu@163.com, frowand.list@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: reserved-memory: remove duplicated call to
 of_get_flat_dt_prop() for no-map node
Message-ID: <20200803225058.GA3280324@bogus>
References: <20200730092353.15644-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730092353.15644-1-zbestahu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 17:23:53 +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> Just use nomap instead of the second call to of_get_flat_dt_prop(). And
> change nomap as a bool type due to != NULL operator. Also, correct comment
> about node of 'align' -> 'alignment'.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
> ---
>  drivers/of/of_reserved_mem.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!
