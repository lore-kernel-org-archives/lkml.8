Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8D0C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9DA20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579850493;
	bh=a6W7URZF8I4W+rbTe34cfSoCmt8LIAivkMvBUuS062I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JBansx3Pl/m+3AtlHtFSRSpzUK7VmJLOOyHI2LWSuiL896hx+H9MS7ihp9gNT3lWm
	 swHOz0JYJWzR3S0W9ic81MA7ALASQbMbZ/GcEIV4p2ZP+Omwd2hEWHretUuBKok3xc
	 axl8WmvPbAQWwK0jJiSW3Tcr3ySSHno6TX6JJE2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgAXHVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:21:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38380 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbgAXHVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:21:31 -0500
Received: by mail-wm1-f65.google.com with SMTP id u2so669201wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 23:21:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p8GGZGknnfG7tWMIgP6ZXfED0+y7Mb/Mp5pjgGPqFBI=;
        b=qyvDK+lcW3RMOT/vuP80DLXtbFLFMn6xdnMG0vV/Iznhpjw6EaiSc4HaafaZn5Y1QO
         wwc8qxKb8xuVcxpdopaAL136vC5eCTdk7AGzJz1BIELh+5xHFZcY8yiniDkxmPpvh93I
         c7rjWT+uBC1WGQ0OJzLTJc1CNFccMRI6ynqVboP0dgcPS0nPVF8zZnF/la/zySQ7Akkg
         xqxYDn3mt7to8gRK49WQtpmAa1eMuXzNiWctB4A8kHaOi4QzEf+Cv1dbczGqI03cZktu
         b9kKp/iMVdNxQdkTs1I6EtoKFXG6ddgNQFg99ekRB2mlGj6xjMz+tCb1DCC9ssBEpHnI
         q2rA==
X-Gm-Message-State: APjAAAWIgyHDBABE0dFuJzhnFOiWf3VAwNB7lMNeUayY5F4e9wwdC7U2
        lXt8SulUMTQiOdK517TmwzCv9fth
X-Google-Smtp-Source: APXvYqxZA/sxsm8auIKrVRbVBr6COTkmGT+oQd+RxOnmNrKTN486dIZDxPoq6au0E/2YrqPhKbLTOg==
X-Received: by 2002:a05:600c:2187:: with SMTP id e7mr737753wme.11.1579850489739;
        Thu, 23 Jan 2020 23:21:29 -0800 (PST)
Received: from localhost (ip-37-188-162-110.eurotel.cz. [37.188.162.110])
        by smtp.gmail.com with ESMTPSA id v14sm6322363wrm.28.2020.01.23.23.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 23:21:29 -0800 (PST)
Date:   Fri, 24 Jan 2020 08:21:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, yang.shi@linux.alibaba.com,
        jhubbard@nvidia.com, vbabka@suse.cz, cl@linux.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] mm/migrate.c: also overwrite error when it is bigger
 than zero
Message-ID: <20200124072127.GO29276@dhcp22.suse.cz>
References: <20200119065753.21694-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119065753.21694-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry I have missed this patch previously]

On Sun 19-01-20 14:57:53, Wei Yang wrote:
> If we get here after successfully adding page to list, err would be
> 1 to indicate the page is queued in the list.
> 
> Current code has two problems:
> 
>   * on success, 0 is not returned
>   * on error, if add_page_for_migratioin() return 1, and the following err1
>     from do_move_pages_to_node() is set, the err1 is not returned since err
>     is 1

This made my really scratch my head to grasp. So essentially err > 0
will happen when we reach the end of the loop and rely on the
out_flush flushing to migrate the batch. Then err contains the
add_page_for_migratioin return value. And that would leak to the
userspace.

What would you say about the following wording instead?
"
out_flush part of do_pages_move is responsible for migrating the last
batch that accumulated while processing the input in the loop.
do_move_pages_to_node return value is supposed to override any
preexisting error (e.g. when the user input is garbage) but the current
logic is wrong because add_page_for_migration returns 1 when
successfully adding a page into the batch and therefore this will be the
last err value after the loop is processed without any actual error.
We want to override that value of course because do_pages_move would
return 1 to the userspace even without any errors.
"

> And these behaviors break the user interface.
> 
> Fixes: e0153fc2c760 ("mm: move_pages: return valid node id in status if the
> page is already on the target node").
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> 
> ---
> v2:
>   * put more words to explain the error case
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 86873b6f38a7..430fdccc733e 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1676,7 +1676,7 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  	err1 = do_move_pages_to_node(mm, &pagelist, current_node);
>  	if (!err1)
>  		err1 = store_status(status, start, current_node, i - start);
> -	if (!err)
> +	if (err >= 0)
>  		err = err1;
>  out:
>  	return err;
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
