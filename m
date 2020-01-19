Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ADCC33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A6C620678
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUCtznLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgASWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:14:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgASWOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:14:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so12294780plr.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 14:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Bo0KESN/+oMc2MKezmCpLg4ifpNjJnDe1/TBk2evDpo=;
        b=bUCtznLA6/j1T5gjcFIAJ/ZuMb2KciubPpHzQvVIY48jBehXIICamCp129OskbMcMG
         h3BPTAf3Y5ounKddTHTdboV/chzH3cmlidwO7WFi9Bzi0Rf3AhCxfk0YLJRUbRkCZZ93
         DJ0gol/OfmquqIAi2lhDaZYKyjTYe7YWAhSuzaMPhkV8ULWcbBkUhl71F3g8tjCOgugZ
         OqQuhmJtQrkxA85e3lZ09TBLQT9nGhIp7OT3vknxNETGvYPqvVdCBlck+HdSl+PHsuBV
         9eu6MKr+f66ryY9QEh+rL4btBNPauXw15gjuloAJ3sWG3rmfxc40q5AyCQJ/ugXLVFpQ
         TLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Bo0KESN/+oMc2MKezmCpLg4ifpNjJnDe1/TBk2evDpo=;
        b=CT0zlvLT1SZccI/IY5FY7E7ej4fIM22FVIY6igDL55r+NeIvhSVL3DuN8JfkA8bwTy
         z1fbCnLR36kAhXeAIV4eTUMAo/GpYusErIGyAKQ2uf4d9j5hI3BFvIN2Asc1Pi8bkFVh
         5rRwNDOGlalzOXK6imBEudC+2GiFQ7Mh+ANwmlZ1L+SEMb0BJnpmyu5lYmqIgpeNtTVL
         L8flzDMSs4QGiYg5av/6KGSvH/qIL9H95jTY935iwSXUdvFAyAwAwZIlYkMTIYDfgA61
         hQM7ki3motrHgbNgcmjKFCfeRN2Oyqtwc0ghGXq1x9RT9LmeXyluo8bAzSSV5XiVgDUm
         GRWQ==
X-Gm-Message-State: APjAAAXFZ1O6LOM5IzBeDCSsCsRZKeDwbfgZcG0rtRMnB15uWdUhG1DT
        lzL6DSwc1nxPxWzWzrMfeD4zCg==
X-Google-Smtp-Source: APXvYqzsc1ebgRP87A/33MVeOw0cciLy5LulWI6KoHB0TBKFhM9NxgevSezrm/R48Q+8z8TOgkmtiA==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr19741926pjt.88.1579472069981;
        Sun, 19 Jan 2020 14:14:29 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n4sm34595568pgg.88.2020.01.19.14.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:14:29 -0800 (PST)
Date:   Sun, 19 Jan 2020 14:14:28 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com,
        yang.shi@linux.alibaba.com
Subject: Re: [PATCH 2/8] mm/migrate.c: not necessary to check start and i
In-Reply-To: <20200119030636.11899-3-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001191413360.43388@chino.kir.corp.google.com>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com> <20200119030636.11899-3-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Wei Yang wrote:

> diff --git a/mm/migrate.c b/mm/migrate.c
> index ba7cf4fa43a0..c3ef70de5876 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1664,11 +1664,9 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  		err = do_move_pages_to_node(mm, &pagelist, current_node);
>  		if (err)
>  			goto out;
> -		if (i > start) {
> -			err = store_status(status, start, current_node, i - start);
> -			if (err)
> -				goto out;
> -		}
> +		err = store_status(status, start, current_node, i - start);
> +		if (err)
> +			goto out;
>  		current_node = NUMA_NO_NODE;
>  	}
>  out_flush:

Not sure this is useful, it relies on the implementation of store_status() 
when i == start and the overhead of the function call should actually be 
slower than the simple conditional to avoid it in that case?
