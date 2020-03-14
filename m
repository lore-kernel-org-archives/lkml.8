Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A31C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3022071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UB05glch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgCOCJq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:09:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37699 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgCOCJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:09:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id a141so14272951wme.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ccS1Io8/tHjBzzXmHi5hIITMhMP463waFk/FT4O6b9c=;
        b=UB05glchFZAl8zn/zEVTCAbaSZjJAoMX616sX7k12GQs0VQpsJ23m8fe05YmrSK4II
         h+EmU+omPYHmSXBFhkdYXLmd9F/2scxD+cOuVYS+Afi/ZsrYjWX96/922LspJ6cRyU1O
         SGJPq8h1/oB/zJ2KQMrbdORZEgem+cuz3tHUwfFz6OML+1dt0yXkUtIdwqEB2ZhdF/HT
         pltvYCSwsNMLqAnHPvI4u9ez4ktI1SULwImMlz2GC0Cyt7gCG7ay5Uo2R3Oj33gyDoTz
         ttV4ZlTieQaiTieNb5m4RcG/Nxs2b2C670tnZlsPkfNXezf58dJy5tExAEiWOLmg0LVa
         RoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ccS1Io8/tHjBzzXmHi5hIITMhMP463waFk/FT4O6b9c=;
        b=ABJBFbqMCnqj790/oBX5NH2mGwhZ6uwUOEHPLkuRAZ9ywXt+MrINaeZ8+OLVsrSPAv
         if3fOBQn09UG9W3kt+DrYx2XDwya9b9b1EAaMYwthSHnhjseOeNBZuxjp1ESAkf7Zmbb
         wb10aLkuU/EcYXaGAnz4W+PGew62O9C9IosbKXCD7iGKxTULv/uMIlFQUkYVduIfsR+S
         WLHY15pIBbJN8gb85yNDQ5W8Uc+s7A6f0vPEswljDYehuV3CcnQlXUSU1ckxA4pNHBUu
         O1VGa/NuPiuvlflMVznoMH8gd7y0JEFv8YkSgcSL1XgTfjVqfIGPD1KVswXqRWOiYhON
         lqNw==
X-Gm-Message-State: ANhLgQ3Pb8W+8pDysmIWSRwYBmpRJIBi7oQNMYXOa86iNOL4QUroJ3jv
        Mvas9uIiY6FonpskHaJ/5JJ9kv4S
X-Google-Smtp-Source: ADFU+vtyoSycP4u50lg2zaM0POhefKJvMpVU3xwj1ZCN1pfGM8WTTr+uq/9CJATpEVxH+hoBMmnT6w==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr16906246wmc.30.1584198608562;
        Sat, 14 Mar 2020 08:10:08 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s22sm20213613wmc.16.2020.03.14.08.10.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 08:10:07 -0700 (PDT)
Date:   Sat, 14 Mar 2020 15:10:06 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        mhocko@suse.com, akpm@linux-foundation.org
Subject: Re: [PATCH v2] x86/mm: Remove the redundant conditional check
Message-ID: <20200314151006.gnkyf4xpqve6b3wx@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200311011823.27740-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311011823.27740-1-bhe@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:18:23AM +0800, Baoquan He wrote:
>In commit f70029bbaacb ("mm, memory_hotplug: drop CONFIG_MOVABLE_NODE"),
>the dependency on CONFIG_MOVABLE_NODE was removed for N_MEMORY. Before
>commit f70029bbaacb, CONFIG_HIGHMEM && !CONFIG_MOVABLE_NODE could make
>(N_MEMORY == N_NORMAL_MEMORY) be true. After commit f70029bbaacb, N_MEMORY
>doesn't have any chance to be equal to N_NORMAL_MEMORY. So the conditional
>check in paging_init() doesn't make sense any more. Let's remove it.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>

The change looks good. While I have one question, we set default value for
N_HIGH_MEMORY. Why we don't clear this too?

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

>---
>v1->v2:
>  Update patch log to make the description clearer per Michal's
>  suggestion.
>
> arch/x86/mm/init_64.c | 3 +--
> 1 file changed, 1 insertion(+), 2 deletions(-)
>
>diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
>index abbdecb75fad..0a14711d3a93 100644
>--- a/arch/x86/mm/init_64.c
>+++ b/arch/x86/mm/init_64.c
>@@ -818,8 +818,7 @@ void __init paging_init(void)
> 	 *	 will not set it back.
> 	 */
> 	node_clear_state(0, N_MEMORY);
>-	if (N_MEMORY != N_NORMAL_MEMORY)
>-		node_clear_state(0, N_NORMAL_MEMORY);
>+	node_clear_state(0, N_NORMAL_MEMORY);
> 
> 	zone_sizes_init();
> }
>-- 
>2.17.2

-- 
Wei Yang
Help you, Help me
