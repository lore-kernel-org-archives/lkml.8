Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40DAC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF6C206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="mXw6ltxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgIHRzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731615AbgIHRza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 13:55:30 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1EC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 10:55:29 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so23772395ejr.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TV+cBfgEjWVdVoWjdO7bHOv3j1JRscD3Rid2RHJ0lps=;
        b=mXw6ltxYv094vVJyfjQHwLyMd/gz4JbYYLmPyFYL2epCAoy8RwjhTkYZqVsbcIbHiA
         9NRTBM3UutItGJYkE50cl713yDhTAbsoPROgxlSZvJdZAxVxWL+8+Qa4ntoVN9BmPCGA
         x3JRUW47Q3VFrjDJwQpiTiUSRrmgA1J7e0fTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TV+cBfgEjWVdVoWjdO7bHOv3j1JRscD3Rid2RHJ0lps=;
        b=GwAprPgId/BscvO5VC+4N3m+shrdubjiZJFuvyceR+eX/+pP5zrfswqTaC/PYTy2el
         2URdhn7d1LbTq7h6wXlitUF2hqBMyg61wBmHRC0iq3CYMbIvI2zjxu/j+bHz9gYeKbUx
         DWrohpzoJI16N+LnCwfhg0mHULZoPEq/lqntI218vuu1qgLNZMSanT7V9lJ3yVtF0y3z
         g23iMjl+2wMhUTRHEkkodD4EKiI2fkXfhbDkkMjIyNlVjaen/IEY8PJvjB8iTEeh+u0w
         oreIBNZGe4m9ZcVmF6ZTOOqiT/MvyLxSYsG8IiFaOoR0aM7dILKNQQKes9e0HXUYohJf
         q2yg==
X-Gm-Message-State: AOAM531GDK6kfAsi/7v10eo/QoAafs0Gagtpwj3JBxAsMDvFoy7J0A8c
        RgPkiEuZCo3CO+RI+9lM9rkmPrdSrydnPj/4
X-Google-Smtp-Source: ABdhPJyWsgZ1h969nhhwtClEC/BY/00rQAZgfGlUd6u+VFTLe0qhGDmhTQp4ndVfR7shOT6vOpzU6A==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr26234185ejo.33.1599587728032;
        Tue, 08 Sep 2020 10:55:28 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4614])
        by smtp.gmail.com with ESMTPSA id n7sm18371091eji.13.2020.09.08.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 10:55:27 -0700 (PDT)
Date:   Tue, 8 Sep 2020 18:55:27 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     zangchunxin@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm/vmscan: fix infinite loop in drop_slab_node
Message-ID: <20200908175527.GA1336071@chrisdown.name>
References: <20200908142456.89626-1-zangchunxin@bytedance.com>
 <20200908150945.GA1301981@chrisdown.name>
 <07c6ebf1-e2b3-11a2-538f-4ac542a4373b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <07c6ebf1-e2b3-11a2-538f-4ac542a4373b@suse.cz>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlastimil Babka writes:
>On 9/8/20 5:09 PM, Chris Down wrote:
>> drop_caches by its very nature can be extremely performance intensive -- if
>> someone wants to abort after trying too long, they can just send a
>> TASK_KILLABLE signal, no? If exiting the loop and returning to usermode doesn't
>> reliably work when doing that, then _that's_ something to improve, but this
>> looks premature to me until that's demonstrated not to work.
>
>Hm there might be existings scripts (even though I dislike those) running
>drop_caches periodically, and they are currently not set up to be killed, so one
>day it might surprise someone. Dropping should be a one-time event, not a
>continual reclaim.

Sure, but these scripts can send it to their child themselves instead of using 
WCE, no? As far as I know, that's the already supported way to abort 
drop_caches-induced reclaim.
