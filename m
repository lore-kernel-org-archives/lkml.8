Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B286DC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838292080C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rkkuqk+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgBCQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:05:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39013 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgBCQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:05:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id w15so14694085qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xac4z+kG6ArFscWeRKYKZoGo960QSwcJzeCpon9xiZU=;
        b=rkkuqk+TP7TBMTzKraV2XbzaWdxz1n6c3srYOQBY22YsyYFVbWlQt6OkgNv7k+8ctf
         KgwZEhi6f54kRTjERln1rNfyGEapu/cpTCidoZ8psVYge/pI/fAApIhFBkA3ZrzRNnXq
         cRzvTThQ0GprU+Lv4TwYWipU7nEFIBCfK3GMPRD39LP5nmJjFPLp+aje+q4rcLN677aH
         6qZUgKzlyapKpR7czcHlCWWjXS7N/MYLF2kIGFQPRAVcZmfaEOO/19oasCItvXAJtn7q
         VOiakTJuYlg9Q3jnxjhp+7TJxaZGuN34UxMltimvmaD/mqRkYnloufSkLNIkr1VscGee
         +3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xac4z+kG6ArFscWeRKYKZoGo960QSwcJzeCpon9xiZU=;
        b=miy1+/8Czl+Ia9mdOoxq+itJgv/gcJpZjzrdCatA/wJmb3SMM970ugM2MztgSdkkJI
         4JCTbcGyWTwHJ6ngIae2+R198FIWtinx1+pdeYfl6IcRGQRAm1hHp4y8BoyOzcO/UK1u
         8tH/cc6AvhXRMtazE23bsMp+SBnC9+dGF2aKuOHdkoo1chEdvEsk6+GfHqvfmmfdVcn8
         pCu4Sq2BFYvFQoCH6FwxrHCBA95ioDmsc9r2tL7tcnp4dgAQox9bx6cFf7RVd8qihjQz
         RjF7KpRxRO06KBzuq3A7/xDz4D982U1KWsEQ7yWLFzmFOLi3jfirvNLPLv0rTe3qo7qm
         Z4Cg==
X-Gm-Message-State: APjAAAWN7RXEAuJnlYpWTGqllTFy3Kzl0+yCfvaXCtXQd6P4E1AgaGil
        CcywywZWECwe+duMTeojMvCSYA==
X-Google-Smtp-Source: APXvYqzGv7LR57b8flPPNml+d75/be696mcXaxXuAeBDC2jdMoHwj0g5JC7ma5fGwKJx6p6yMJsAuw==
X-Received: by 2002:a37:68a:: with SMTP id 132mr23231359qkg.139.1580745907969;
        Mon, 03 Feb 2020 08:05:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:c810])
        by smtp.gmail.com with ESMTPSA id i4sm2350466qkf.111.2020.02.03.08.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 08:05:07 -0800 (PST)
Date:   Mon, 3 Feb 2020 11:05:06 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 07/28] mm: memcg/slab: introduce mem_cgroup_from_obj()
Message-ID: <20200203160506.GA1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-8-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-8-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:32AM -0800, Roman Gushchin wrote:
> @@ -757,13 +757,12 @@ void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>  
>  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val)
>  {
> -	struct page *page = virt_to_head_page(p);
> -	pg_data_t *pgdat = page_pgdat(page);
> +	pg_data_t *pgdat = page_pgdat(virt_to_page(p));
>  	struct mem_cgroup *memcg;
>  	struct lruvec *lruvec;
>  
>  	rcu_read_lock();
> -	memcg = memcg_from_slab_page(page);
> +	memcg = mem_cgroup_from_obj(p);
>  
>  	/* Untracked pages have no memcg, no lruvec. Update only the node */
>  	if (!memcg || memcg == root_mem_cgroup) {

This function is specifically for slab objects. Why does it need the
indirection and additional branch here?

If memcg_from_slab_page() is going away later, I think the conversion
to this new helper should happen at that point in the series, not now.
