Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E16CC32771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E44A12465A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 01:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579744478;
	bh=58F73HTtJKyGYNR9OPDofGKAIXeYdvCThS6eRtTaz64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DtC5GEDygEBPo/JB7HlLcHiAjafMImH4mgwtCorhr8YqBwbcdDGzxmxtCPzCSt74b
	 pBo+K0SS84srhZFWJasJXL+EbMoJKH6cyVzHPGCkpumVhgVULwwNsza3Rt/q1VV6qX
	 ECXkFZ5UOrMidY+y7n3WKURFH3179GdoGLL+kCro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgAWByd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 20:54:33 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37986 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWByc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 20:54:32 -0500
Received: by mail-pj1-f67.google.com with SMTP id l35so462013pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 17:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fI6Do2E2dQZJaCagfEsOTEVI2vdBKffR8CDGskh1wXA=;
        b=ARJXzJ8RByNXt3wd1tUe42lE2I36FwkzcPEaTWT8pWfyE6p+HwI8DJV4XuYuRlK+GE
         4tFzwDz7G4yGs7GKJooK9o5p7wijrohY7jFc6Uwz7eDBLrVEa/mLE3sda6PMwgyfMgmW
         YWIT0xSQbvdeLK+S8sFjWVBoSV/E3TyJb2spavbSUcU/ggtYrS7ZaLOT7r+KuaYDnM3x
         ltyLDGZswf7KTez5eC5ximtWDMEjzSagSCAhupioKTNO8LVnwbDm3K+fcrE7kvLAduoz
         6A6UDL3wja+To4vW9uUlT1Noxmj10Sh63Ru/mKkH4KfljVEj4bJvKoGDiaqK0K1q+BmY
         n40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fI6Do2E2dQZJaCagfEsOTEVI2vdBKffR8CDGskh1wXA=;
        b=l3fat0WIhE4XrH76ds/wu6VSzjUaDalwEvWYUEnd17NydszhTYGZr0JmqP/TODypZ3
         DhU/5xCwc9rxrKYY8wlWP5SB+Jmfud/wc78sW5kcwfrJwMzaCdwL8a3o1+s/Zyod5JC9
         Ds9MwS/C66bZx9ujrq6QLYI6js+CEVaeGavWjSd6nObACXhuPXMd9SX/Neps6Y76TPfT
         yk9zzdmwgviQMtWS2n5hbsoztfnCiGPM/OMo3LJOQFz/qQyKdOyd5f23cy3Bpwn8ZQBd
         /QEoFGbyH/NSuC2n0+3u3NYik9s2f+omHvGcZVMEO7W307PY05WqDmkbWwpqbPuC6rZC
         4lQQ==
X-Gm-Message-State: APjAAAX0DXH4hws+rrVCaXu92TDKMvmaEnra/AKCFUcxxedoeB7mRWVw
        uy6Rjn4irrcf3wpJear5wiuMeTQh
X-Google-Smtp-Source: APXvYqzxD47H7QNFrr3nWXZJj3FYrICOq6y3hKBU2rpX8UQUw/WL/ApkLcKpgFcFYC3rwRIHzYM3uA==
X-Received: by 2002:a17:902:6ac7:: with SMTP id i7mr13630150plt.66.1579744471928;
        Wed, 22 Jan 2020 17:54:31 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id a15sm197500pfh.169.2020.01.22.17.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 17:54:30 -0800 (PST)
Date:   Wed, 22 Jan 2020 17:54:29 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: Re: [PATCH] zram: move backing_dev under macro CONFIG_ZRAM_WRITEBACK
Message-ID: <20200123015429.GD249784@google.com>
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

On Mon, Jan 20, 2020 at 11:41:55AM +0800, Yue Hu wrote:
> From: Yue Hu <huyue2@yulong.com>
> 
> backing_dev is never used when not enable CONFIG_ZRAM_WRITEBACK and
> it's introduced from writeback feature. So it's needless also affect
> readability in that case.
> 
> Signed-off-by: Yue Hu <huyue2@yulong.com>
Acked-by: Minchan Kim <minchan@kernel.org>
