Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D535FC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A488720684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 09:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579513940;
	bh=k02uYv0Egu2auebd7tFbn8jR0+toEaJjaSHAzpakjyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wXHWxEVv4hXNuhgaF0VvvbogNokfZsbh1amAT5pk6pTK4XRtx5CGH/6BEdSLtJ7L
	 6mKM1G3gp6SbO/DuZ3iR5MVSEjGgU2m1kVNrsUFvWo1wFB8glib3EFe+8L7Tyd7Q+4
	 CayQ8wpS5t6AqIEiKGDOgfv3XT+fTlXtujT+Yvt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgATJwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 04:52:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35803 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgATJwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 04:52:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id g17so28766076wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 01:52:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/XDRKRWs/7afQD8wftzTNmMDKMYFRM/TiFXtp/+Eay0=;
        b=IoyB6np2JzZqF3FDlNt57hNmietygkJhcoDZnIRts/GBua5jUMGkKaVsMdtHwG7PiY
         OVEA0nR7mXfIUFZtYSxq6ZHmCjcBdV5LpKL8Yt6sp/mOobbTidgdCPv4tXxocX2EykZV
         ZLbp7IXeDskuTv8VeGHz3cxTEWBmMDL0z/TIYvjIVfxSpOq92rIjnVqMlYewc+RIGWlH
         dBcH8mn0xNWYjKFDxe5buJzGdp0aEbEvK0cHmp3MZHraULadHG8WsWeOPDaGbjbeIGml
         ojRoV64KRjpts3n5rFXbPlbZqZwHMGn7PLUVa+GNQAIf8l5uE6C7XIYkDrnxYuy2ZCWa
         2A4A==
X-Gm-Message-State: APjAAAWjljJ3/JqpnoP3X7cu3OhH8UU7ejvi5vZr/w0UBiQftmHvguCZ
        nxZpd7LuFp5156lR2teesfA=
X-Google-Smtp-Source: APXvYqxcymRyPNKMjpoBPkn7wtt/4tzG9Vd2FIC7TiSSQy4znwuHN2D83WbqjiVME/MbH0fsPNHlEQ==
X-Received: by 2002:adf:fc08:: with SMTP id i8mr16992217wrr.82.1579513937580;
        Mon, 20 Jan 2020 01:52:17 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h2sm47742726wrv.66.2020.01.20.01.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 01:52:16 -0800 (PST)
Date:   Mon, 20 Jan 2020 10:52:16 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 5/8] mm/migrate.c: check pagelist in
 move_pages_and_store_status()
Message-ID: <20200120095216.GP18451@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-6-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200119030636.11899-6-richardw.yang@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 19-01-20 11:06:33, Wei Yang wrote:
> When pagelist is empty, it is not necessary to do the move and store.
> Also it consolidate the empty list check in one place.

OK looks good to me.
 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/migrate.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dec147d3a4dd..46a5697b7fc6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1499,9 +1499,6 @@ static int do_move_pages_to_node(struct mm_struct *mm,
>  {
>  	int err;
>  
> -	if (list_empty(pagelist))
> -		return 0;
> -
>  	err = migrate_pages(pagelist, alloc_new_node_page, NULL, node,
>  			MIGRATE_SYNC, MR_SYSCALL);
>  	if (err)
> @@ -1589,6 +1586,9 @@ static int move_pages_and_store_status(struct mm_struct *mm, int node,
>  {
>  	int err;
>  
> +	if (list_empty(pagelist))
> +		return 0;
> +
>  	err = do_move_pages_to_node(mm, pagelist, node);
>  	if (err)
>  		return err;
> @@ -1679,9 +1679,6 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		current_node = NUMA_NO_NODE;
>  	}
>  out_flush:
> -	if (list_empty(&pagelist))
> -		return err;
> -
>  	/* Make sure we do not overwrite the existing error */
>  	err1 = move_pages_and_store_status(mm, current_node, &pagelist,
>  				status, start, i - start);
> -- 
> 2.17.1
> 

-- 
Michal Hocko
SUSE Labs
