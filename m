Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061BAC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0703206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 23:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="WaKIVp88"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCLXlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:41:07 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40862 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgCLXlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 19:41:07 -0400
Received: by mail-qt1-f194.google.com with SMTP id n5so6024427qtv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 16:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IR1ZGYQ7bBis3tQYz0/gm378y+F3aklMnCupK17WvA8=;
        b=WaKIVp88NiOqv0ilYSmUwBKi6fMK4LOMBn81twnVSSYPYD12WgN28NGHS0KaM5YSlo
         rqThZtRnxfYQWbwenUXBX91DXJVzakOVuiolcKv62jOyhi35W6vpVj13RKkCJo3Dls/4
         Qxb4bZe7rLj072eloFRQ04FT8/C+HEhzGS8RlGR7QTRuTvA9zRuxb5+7JowepoB6pVp7
         2LyKrwcyYaItpWKGPQIDpTp5wD0hm7v2y0PeoHXZ+rwUToivy1TeG81bCoGeq2eBhF5Q
         IY/KhYKT1IhJ+0lADZK7SsKGZsMQvtc5/bBKxrn1Zr+Zet1widbur8kmBT5Z1TzHgCrz
         cY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IR1ZGYQ7bBis3tQYz0/gm378y+F3aklMnCupK17WvA8=;
        b=pjm3ol4FyrtmKw03S1e02vijDXHjObe4atWVTNZQk5ykFKeYk3UcEaMddi1GcvYvDa
         H1ujHs3RCoJzCNsKTKFIw/iKDbt/FGDEIx9a0TGtN/DRlVWqBlFpjh0Tz/p7Hdnn8vzR
         n1BPsf2Gi7bL3LKXm7LB5it3SD8MPwjW3aX1trxnxMlybA/qJmsCMTtee1NTAHWVSXV+
         BOeiw4IytAUu+RQ949IPCYBi5qbMabvThk7Cck7Mi4Ftp1Hvez2G1bIkqtfq1mI7S15+
         JEP6uams5od6PKuCHwuiCUEpW+6xKXHXe1KzQW0nErf8DGVX76GOSrLVFq1k0PZo9+lv
         ud8A==
X-Gm-Message-State: ANhLgQ0L0pgj9nk+AJPNCtY7GmjT3IBElE0eOJOBChCTXXPZcv4pjalJ
        OwsDJJlaoGPkykwbfT5wJUJxoQ==
X-Google-Smtp-Source: ADFU+vsQXcJZ1HIhv6R3fPyYJLLbPdA44qisgNAp62occ/HIctFe/nItPB9pMx+2+OtArorB78XD/w==
X-Received: by 2002:ac8:714b:: with SMTP id h11mr6194033qtp.21.1584056466073;
        Thu, 12 Mar 2020 16:41:06 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a664:2e00:38a9:cfd2:746b:b1f5])
        by smtp.gmail.com with ESMTPSA id 199sm10037112qkm.7.2020.03.12.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:41:05 -0700 (PDT)
Date:   Thu, 12 Mar 2020 19:41:04 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     Helge Deller <deller@gmx.de>
Cc:     Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        linux-ntb@googlegroups.com, Serge Semin <fancer.lancer@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ntb_tool: Fix printk format
Message-ID: <20200312234103.GA13046@kudzu.us>
References: <20200114192247.GA30840@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114192247.GA30840@ls3530.fritz.box>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:22:47PM +0100, Helge Deller wrote:
> The correct printk format is %pa or %pap, but not %pa[p].

Thanks, pulled into my ntb branch

> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Fixes: 7f46c8b3a5523 ("NTB: ntb_tool: Add full multi-port NTB API support")
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index d592c0ffbd19..69da758fe64c 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -678,19 +678,19 @@ static ssize_t tool_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 &inmw->dma_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Window Size    \t%pa[p]\n",
> +			 "Window Size    \t%pap\n",
>  			 &inmw->size);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Alignment      \t%pa[p]\n",
> +			 "Alignment      \t%pap\n",
>  			 &addr_align);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Size Alignment \t%pa[p]\n",
> +			 "Size Alignment \t%pap\n",
>  			 &size_align);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Size Max       \t%pa[p]\n",
> +			 "Size Max       \t%pap\n",
>  			 &size_max);
> 
>  	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
> @@ -907,16 +907,16 @@ static ssize_t tool_peer_mw_trans_read(struct file *filep, char __user *ubuf,
>  			 "Virtual address     \t0x%pK\n", outmw->io_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Phys Address        \t%pa[p]\n", &map_base);
> +			 "Phys Address        \t%pap\n", &map_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Mapping Size        \t%pa[p]\n", &map_size);
> +			 "Mapping Size        \t%pap\n", &map_size);
> 
>  	off += scnprintf(buf + off, buf_size - off,
>  			 "Translation Address \t0x%016llx\n", outmw->tr_base);
> 
>  	off += scnprintf(buf + off, buf_size - off,
> -			 "Window Size         \t%pa[p]\n", &outmw->size);
> +			 "Window Size         \t%pap\n", &outmw->size);
> 
>  	ret = simple_read_from_buffer(ubuf, size, offp, buf, off);
>  	kfree(buf);
