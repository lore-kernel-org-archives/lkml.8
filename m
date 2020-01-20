Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92044C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCE1207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579513572;
	bh=OMwORxx383L7Z6fSJ6ZMY/TMZ4koB3zCnhkVRl7UYNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Lh4UCUq4tAjz98Q8aIVCcMPgafBnnInmodyPvRCdHUD13rNFN/a4pxrbUWi8/x5dX
	 U9gxxIOcb3q/R31bMPlnhHU+vrdsOw4rgeMEvbThMXfZIag5nieUt6Wku/ziMEx6in
	 nlMXCIG0UloYGSmV2/wgJsFJI2dZENk7i4j9Oi5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgATJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:46:11 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39167 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:46:11 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so13973480wmj.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7VdZ/NoDHGeQH6szStgVZMI/Om0YjW5KDW+nhhNOKoM=;
        b=TanLV92lg8FrIngV5/ycBIHjFcmhW/qdc2r5BadRlMaaIlztcColGKW37i4MbmESRX
         qWv+B9A4zEpF6KG3Mc+F3Nid9h8afOfN6y9ff2pOWOEcK+VkcLnT7zOtmVF3rBocKz60
         dO3QnwqHrKDVzEj+dKsyyUGJfmmqzzUJcNDVYJ14t6ZN/rBu57XX46adNKfmLYFk98I6
         +xv/w8hbCRIdCrgZMIYEm7pa4LBYXUn42IROOZtc2l9iNRF4Ju8l+T5EjRSVNZT1nc8/
         dU9Nx7V8ktNP9CAa/QeXO9c55p0wTfHWFg1Uh/mrzIxNWY0aL+uRYVbGFX3swTvtz/6X
         C9VA==
X-Gm-Message-State: APjAAAV6ZRwK2zpYwPFHl0dUOY/z73u5SBSunte0ewbkwFh9LDRFnxVo
        IJDEUx0Ofwon3BH8xlk7CaA=
X-Google-Smtp-Source: APXvYqxM7jP8cdx1zoiU5qPY6FvD+Yg/kKa29PNdtbxeY1ZUp9dV3R2HEWwOH0P9oVr8F5kiUj16vg==
X-Received: by 2002:a05:600c:24d1:: with SMTP id 17mr17967184wmu.188.1579513569343;
        Mon, 20 Jan 2020 01:46:09 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j12sm50668940wrw.54.2020.01.20.01.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 01:46:08 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:46:08 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 3/8] mm/migrate.c: reform the last call on
 do_move_pages_to_node()
Message-ID: <20200120094608.GN18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-4-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-4-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:31, Wei Yang wrote:
> No functional change, just reform it to make it as the same shape as
> other calls on do_move_pages_to_node().
> 
> This is a preparation for further cleanup.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  mm/migrate.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index c3ef70de5876..4a63fb8fbb6d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1675,8 +1675,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  
>  	/* Make sure we do not overwrite the existing error */
>  	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
> -	if (!err1)
> -		err1 = store_status(status, start, current_node, i - start);
> +	if (err1) {
> +		if (err >= 0)
> +			err = err1;
> +		goto out;
> +	}
> +	err1 = store_status(status, start, current_node, i - start);

Please don't. This just makes the code harder to follow. The current err
and err1 is already quite ugly so do not make it more so.

>  	if (err >= 0)
>  		err = err1;
>  out:
> -- 
> 2.17.1

-- 
Michal Hocko
SUSE Labs
