Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79840C81857
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244272072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2ph7yhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgD0XD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgD0XD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:03:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE467C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:03:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h69so9378959pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=cnYx5FSyU75ZOrIsU+CTkq5jI4uN9HVRGnd3oZ84iCs=;
        b=N2ph7yhOcyT0jIuugk3FhGAr8dkhMlazcj0IcIqtbB/vQS05zdvYmIKfs5R5oBEmZN
         yKGTQvvlffThLT7uUPkIbdk5QkAUYnopzMKU7hITi7y4DTLDK927NfktJyTcL2bZ7EiM
         0C4gWZwLh83ZpDugolQL2j+XalPVSMXgq4DKikeb6kj5mw+mnOEvCKoVHoS94MvKo+w1
         +W76ulTNeWs2E7JUwA6qH7PFfGs5hvlPkp1vV9U4oX1wdghUX3RbStUt2mQpdnxvs6+Y
         eMf5GJxQJkG878JrbCID6FnxN8kLdxF3rslnDr3tTVABmgz7Rt54lHy9wzqfMwGgUCTM
         8Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=cnYx5FSyU75ZOrIsU+CTkq5jI4uN9HVRGnd3oZ84iCs=;
        b=G+wbL1Q+L+reaxOtmyaFnQpOeyP7eKgFBKBIrHr3JSZsPmlnTDsrid5qEpE6Gq6YbE
         Inxdv4+bhZu4ZYST9trIbzvA4jFpDV7w6RGPz0AYm5v7rlV/EgyV1EZvE8BMPpZmT0nL
         inZWDpaqhCa0i+YQnyQWsv6Tijx6I3GSaQ1hxSiJHRPr2XotEYeqsZuRdBa1hHnNJwLk
         zhqUT9L7cm3lNAvjfj7lEy0nTQY0PyQ37mp8WYAFuzS1ZRkWCMvd5mxQ5DtgGP56mGYs
         q6x+++5yjINfBC3uAmAdBu45WCz36dVAgpqfeS18xUmlI74q+UtD2E3rBCTmwkKRFrMp
         Lsxg==
X-Gm-Message-State: AGi0PubXs1WwqfopHhCvAshBSz+1gTedndWo4hsd+WbEXfZ3BBVW7rd1
        0vhmgjQ/gCHK8T/a+R1tbI0P/wZAXMY=
X-Google-Smtp-Source: APiQypJjBe4sy6hyaOZsrisOjWXeJmUOriHMUalc09RDGkLyoECKliWmzPHcAzDKIM4EnSRQ2vSamA==
X-Received: by 2002:a63:7252:: with SMTP id c18mr865010pgn.49.1588028637937;
        Mon, 27 Apr 2020 16:03:57 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id c11sm11636534pgl.53.2020.04.27.16.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:03:57 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:03:56 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
In-Reply-To: <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
Message-ID: <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com> <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org> <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Andrew Morton wrote:

> > No - that would actually make the problem worse.
> > 
> > Today, per-zone min watermarks dictate when user allocations will loop or 
> > oom kill.  should_reclaim_retry() currently loops if reclaim has succeeded 
> > in the past few tries and we should be able to allocate if we are able to 
> > reclaim the amount of memory that we think we can.
> > 
> > The issue is that this supposes that looping to reclaim more will result 
> > in more free memory.  That doesn't always happen if there are concurrent 
> > memory allocators.
> > 
> > GFP_ATOMIC allocators can access below these per-zone watermarks.  So the 
> > issue is that per-zone free pages stays between ALLOC_HIGH watermarks 
> > (the watermark that GFP_ATOMIC allocators can allocate to) and min 
> > watermarks.  We never reclaim enough memory to get back to min watermarks 
> > because reclaim cannot keep up with the amount of GFP_ATOMIC allocations.
> 
> But there should be an upper bound upon the total amount of in-flight
> GFP_ATOMIC memory at any point in time?  These aren't like pagecache
> which will take more if we give it more.  Setting the various
> thresholds appropriately should ensure that blockable allocations don't
> get their memory stolen by GPP_ATOMIC allocations?
> 

Certainly if that upper bound is defined and enforced somewhere we would 
not have run into this issue causing all userspace to become completely 
unresponsive.  Do you have links to patches that proposed enforcing this 
upper bound?  It seems like it would have to be generic to 
__alloc_pages_slowpath() because otherwise multiple different GFP_ATOMIC 
allocators, all from different sources, couldn't orchestrate their memory 
allocations amongst themselves to enforce this upper bound.  They would 
need to work together to ensure they don't conspire to cause this 
depletion.  I'd be happy to take a look if there are links to other 
approaches.
