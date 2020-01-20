Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D879DC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 05:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEBF2073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 05:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp8IkP8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgATFaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 00:30:39 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40267 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgATFaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 00:30:39 -0500
Received: by mail-pg1-f195.google.com with SMTP id k25so14945093pgt.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 21:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x/Im7bSDMBWAjwjtmvgGmWhWwKPuaRjhZ2CMQESZcJw=;
        b=Rp8IkP8y07rDor5ecGsa7KzPoRtNEX98aWRLdvuJUcVFNptUp2hQNtVzrBu8ogBekl
         nN5pxcMI6hvT5GqP6VIrVaPOYGm0FlD8TOKgua2V/BqOmVaaScA1sw+NquvFElBGqul4
         nSXrvqzyvFVyo76hwyQhejVemPBzNFaRfGcq8JiBdj+MsMmkkQ55gLIE5FI2/B+upV3q
         soifZevzKlSefl5uqh2LMCpkqlVv/+uNGCicBuEZDQf2NhBFLL9djCmGuZD+t8tIcwLm
         snYGdOQBRsKWVya9IKUwooiPySmfw0gAgX43NtOWCYcxscb1FCSUQRGqRjMt0WD++NpX
         R2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x/Im7bSDMBWAjwjtmvgGmWhWwKPuaRjhZ2CMQESZcJw=;
        b=ls/+OFosBaoIwItANzUvR0PX0gizavVSqj/wSTGUtOToFtQp6LaPTd4ZUoG2ckWqoZ
         vUVSyfaqvOnbeMoGNcqvtx/pHBj7I6L5/imaFMFyIBg5O004I4sXVTUWqGsAsmRGuaAy
         7jNTmRCL5HpreTYEKcUhBal+RMj171Hh0Myj2gs1XAqk0wmscIdMUD3OvVI8850+NJH2
         EXCZEj5bl+BM2oNSsyZNNLAEhfO9+xHCk8TfrqX9Nw2E7OJtIiddIsbZOgC+asvJ3gbt
         D0Drwhaeqmyzpch8hsFqBjmT4e5zgysGOhkF+nwvUz3gyc/9U9vIMxDPms9F/Hq2DRvA
         ze3w==
X-Gm-Message-State: APjAAAWENuJFk6S/viO2sPfTjY3QOwQjjitVJh0MmfxeYmxgtdie8ynf
        PJSX44AEBNTWqhMWSpuRaFs=
X-Google-Smtp-Source: APXvYqwIwVXlbM8fPX3rxpvRwKXbkHWLSzcnR6EFZCYWETNJWB7tJ3ZNAscs5b3kVkL68wJoOJiZfg==
X-Received: by 2002:a62:3343:: with SMTP id z64mr14954269pfz.150.1579498239051;
        Sun, 19 Jan 2020 21:30:39 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id u12sm35895493pfm.165.2020.01.19.21.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 21:30:38 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:30:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-kernel@vger.kernel.org,
        huyue2@yulong.com
Subject: Re: [PATCH] zram: move backing_dev under macro CONFIG_ZRAM_WRITEBACK
Message-ID: <20200120053036.GE7372@google.com>
References: <20200120034155.6048-1-zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120034155.6048-1-zbestahu@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/20 11:41), Yue Hu wrote:
> backing_dev is never used when not enable CONFIG_ZRAM_WRITEBACK and
> it's introduced from writeback feature. So it's needless also affect
> readability in that case.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Looks good to me

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
