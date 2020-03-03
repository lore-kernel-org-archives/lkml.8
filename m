Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A844C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B02020828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583247959;
	bh=Yj6h4dssuFF08mHyGZ6Wq8pC3m3TSRR+2Af48gW4S18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pK8AwOMCGFMxng4Mu6nhbqKCXQTOovW62Rp9owBeMwtYiu2S8eNrZsHU8WgitAYSQ
	 waH+eyL5mJ8lmXKtjUijGuTGxBjmDz6FqliTZ51GTxQCGp32T9N7fyhacIrAkqMw8A
	 OQg5qleOyq6OsLcu+/iIWwd0TGN/T0HW4FcU+deI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgCCPF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:05:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51123 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgCCPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:05:58 -0500
Received: by mail-pj1-f68.google.com with SMTP id nm6so1051620pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:05:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EJlk4vseHEZQNTu5RktfpfUYNqbSHALuLxr/byHAa5o=;
        b=AbXcuchxrH/SezOUg01TfDFnCEMP9H2+mUtXqpkviz/UY+1e/wM7VO8+bm2wPF7nD5
         Ty7BexSnGrMTadtmQeFecAjRe7OwsXU3kXU36iQEGzJqw+y6fTzGdGzi0o/x2d02m0wk
         uHC+nMuYlc8SzX6ie+Vyzwdfy4TM2AKlR9o+MbWbaTZIgjClORlnb/6ekezOHFY5LET2
         3gABCM4+0tS47I4e9lThl/ZWzqv+pdWX01E8sRqH3Xu0y+rN8EG515BCBhiSpAuMe5la
         lrGex4HV1SWyIOlcZzMEEjy+1koACHGzvaUxr7jjPfuYayO1Tn2nLuzA5/T5XhMhnk3K
         /JYg==
X-Gm-Message-State: ANhLgQ3T+sOkDO5v5mr/dzcTRB1JtPZDUGJ7d7YF+Y5YDEZAErcKgEtQ
        CBRUL8wPxUBcKp/W9aWIOnY=
X-Google-Smtp-Source: ADFU+vvTxf1NzgWfZYzJ8GbzPeBNam9FqG3QGqSv38U4NELY++fYfkEU+ka9o+pZjh34yS/9HW0yBw==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr4641415pla.17.1583247956836;
        Tue, 03 Mar 2020 07:05:56 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id y15sm1098933pfl.149.2020.03.03.07.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:05:55 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B8C8C4042C; Tue,  3 Mar 2020 15:05:54 +0000 (UTC)
Date:   Tue, 3 Mar 2020 15:05:54 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Junyong Sun <sunjy516@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, sunjunyong@xiaomi.com
Subject: Re: [PATCH v2] firmware: fix a double abort case with
 fw_load_sysfs_fallback
Message-ID: <20200303150554.GI11244@42.do-not-panic.com>
References: <1583202968-28792-1-git-send-email-sunjunyong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583202968-28792-1-git-send-email-sunjunyong@xiaomi.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 10:36:08AM +0800, Junyong Sun wrote:
> fw_sysfs_wait_timeout may return err with -ENOENT
> at fw_load_sysfs_fallback and firmware is already
> in abort status, no need to abort again, so skip it.
> 
> This issue is caused by concurrent situation like below:
> when thread 1# wait firmware loading, thread 2# may write
> -1 to abort loading and wakeup thread 1# before it timeout.
> so wait_for_completion_killable_timeout of thread 1# would
> return remaining time which is != 0 with fw_st->status
> FW_STATUS_ABORTED.And the results would be converted into
> err -ENOENT in __fw_state_wait_common and transfered to
> fw_load_sysfs_fallback in thread 1#.
> The -ENOENT means firmware status is already at ABORTED,
> so fw_load_sysfs_fallback no need to get mutex to abort again.
> -----------------------------
> thread 1#,wait for loading
> fw_load_sysfs_fallback
>  ->fw_sysfs_wait_timeout
>     ->__fw_state_wait_common
>        ->wait_for_completion_killable_timeout
> 
> in __fw_state_wait_common,
> ...
> 93    ret = wait_for_completion_killable_timeout(&fw_st->completion, timeout);
> 94    if (ret != 0 && fw_st->status == FW_STATUS_ABORTED)
> 95       return -ENOENT;
> 96    if (!ret)
> 97	 return -ETIMEDOUT;
> 98
> 99    return ret < 0 ? ret : 0;
> -----------------------------
> thread 2#, write -1 to abort loading
> firmware_loading_store
>  ->fw_load_abort
>    ->__fw_load_abort
>      ->fw_state_aborted
>        ->__fw_state_set
>          ->complete_all
> 
> in __fw_state_set,
> ...
> 111    if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
> 112       complete_all(&fw_st->completion);
> -------------------------------------------
> BTW,the double abort issue would not cause kernel panic or create an issue,
> but slow down it sometimes.The change is just a minor optimization.
> 
> Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
