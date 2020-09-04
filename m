Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E87C2D0E4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 18:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E72074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 17:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599239048;
	bh=FipX2gXj7DqsPgMIvbGNc5YB06E8+l+c8s3NE55dYVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P87EyXOh6jrS2JXpSAWoPrw+Ew7EDD1ePEwjpmWP5zjeXoYHWjvYyr90ZeUq0A+UW
	 6bQKX8ZzIcfIAVx1D/LIc2/IbfPUydHOhV9ZXS34Qohbv3OUMShVxINkIU8yqpi9pF
	 f78M1HzDTfaKmJkAUsv3Jfw4aItgc521GkiAoFRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgIDREG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgIDREG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 13:04:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47263C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 10:04:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f142so6896452qke.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0PbJyFxZ/ikkr3u6krBAPVcbTwRijRlUkolyKnsIfDc=;
        b=lkQgWlndpkmX01kw2g+/unio85/icYvH7GZAEdq+sk6bll0r4VlcGMKs85WTWapzQR
         ny9TJmJJC9kKDCEOOy4EbE3gMvdiZjJ9jWs9vNjccQP7pzaNyaB3y8HEAmzqonTRaSao
         TVWxR0PfMKD5QwtKoSWB1PHgFsGTNWiCRjiIq/cHUQm7+FG7Ktq7oSW34bgEhLyOMpwv
         nsLigst0P3peCueb2oE2UO1a+nD94jcep8SeVj/N8bgRfw6DjGltHycbsHEOo50Nwnl7
         BJ6/dt68Dr7a9ewNAGmr7lSWx3cvvWmvVjKM0jwz75ixjcg6hbSvvzFvhNTgpPCg3Nsx
         97WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0PbJyFxZ/ikkr3u6krBAPVcbTwRijRlUkolyKnsIfDc=;
        b=ZS4xn8OFeQrC5ePQDakmScxDLnDzYnrJ70j4u+LUDvbbT2d/Qxt8YhW3F0w8yXTsaY
         jAB6WvYMjxUtjhWqZO1Adh5XMTstPzZLQD9/tsJa+7N9SOu8I99/MS1j3Uampsf0KRbt
         jEbDjGYQtE9dHHLEPlmAnmYHvy6UBL/XKlTlk43hTdgq8HtVXkSwJ8atynQHNhCB6y+Y
         UpXGbIYgM8lXyV/CqWrvNiBrLSSQXcIM9GXKsW3CCdCyEEpLf9pHO7pTf2kguNOMQxZX
         qrhPfUJmZki0AbS+V9wyiwcOFOTd+W/WujeR9qB8pHDPQYmkOD9yihb6El74gJv4Jyv+
         iJWQ==
X-Gm-Message-State: AOAM530jephwu/l6dyL8PLftQcxD0q38LhHsonlQCNquWSoR1mw6nBYz
        m3uzf1h5u4duvm6joOxvMWI=
X-Google-Smtp-Source: ABdhPJzfOHrQhWklhy/F2+O99nkRgQiCVZk8uKFmqifyeo7KZfddncbunJqtrOWcHr207Onjr5+lCg==
X-Received: by 2002:a37:5c84:: with SMTP id q126mr8553178qkb.462.1599239043147;
        Fri, 04 Sep 2020 10:04:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f2f5])
        by smtp.gmail.com with ESMTPSA id s5sm5093709qtj.25.2020.09.04.10.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 10:04:02 -0700 (PDT)
Date:   Fri, 4 Sep 2020 13:04:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qianli Zhao <zhaoqianligood@gmail.com>
Cc:     jiangshanlai@gmail.com, dan.carpenter@oracle.com,
        Markus.Elfring@web.de, linux-kernel@vger.kernel.org,
        zhaoqianli@xiaomi.com
Subject: Re: [PATCH v4] workqueue: Warn when work flush own workqueue
Message-ID: <20200904170401.GB4295@mtj.thefacebook.com>
References: <4c1287b0881e780368623314348f704bd43e9bd2.1598507105.git.zhaoqianli@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c1287b0881e780368623314348f704bd43e9bd2.1598507105.git.zhaoqianli@xiaomi.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 02:09:11PM +0800, Qianli Zhao wrote:
> @@ -2594,13 +2595,17 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
>  				   struct work_struct *target_work)
>  {
>  	work_func_t target_func = target_work ? target_work->func : NULL;
> -	struct worker *worker;
> +	struct worker *worker = current_wq_worker();
> +
> +	WARN_ONCE(worker && worker->current_pwq->wq == target_wq &&
> +		  worker->task == current &&
> +		  (target_work ? worker->current_work == target_work : true),
> +		  "workqueue: current work function:%ps is flushing own workqueue:%s",
> +		  worker->current_func, target_wq->name);

So, the idea is that we catch these with lockdeps. Doesn't lockdep trigger
for the same condition?

Thanks.

-- 
tejun
