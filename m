Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB41C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FBE21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="lYOXpY5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIIJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgIIJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:59:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0798BC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:59:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c8so2023213edv.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uPMqruMk4SDQT+ALFW5dQCv1EhNC+IuTKTg7lA6BnvM=;
        b=lYOXpY5kw+Jaz8EcIZLaUttGOkcZ+TNm+J6dq6gap07GPQqkhvQ442c7nS82t8GwY+
         apOlHsi8vjhganiPUWzmxHBuW4ZMWhuyrp6o78A9NR+JHNUtVNNSizWDF8cDnnER7YnV
         j7DMC9w0lntF64fafUMvso7BzzPMi5ePTbEWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uPMqruMk4SDQT+ALFW5dQCv1EhNC+IuTKTg7lA6BnvM=;
        b=MAjD4Hz2s0LUI/0d6QRT33UrF4FG2ikCckIfmk0TkIUyDRdK9WbjaIw912Kat5b9in
         7B5xiyjM4rUXHDATMObTXzK/EK2KkZAPA/H7S7gWS1jcmFJedTH76941JFVlDK5fxkDa
         aXsPNrmTAJLwpSCPvoYCQsDCbmtnE5J3+vi6E4mLRBxDTk2Bjsx8xxGhGQ6Et5TNs/Hk
         8FbhQyC0TeiCXlAOX58qocEY8ffPllbJMSUwMwYw3Hyfqv1mthCHCdAqEkpSWvaZK7S6
         kWx+yCxV7MQc30BBTfVE0+AVcX19BxPdIbmKdlZDN/U9+L73omYiN8gE18zNgJSNUWf/
         QWeA==
X-Gm-Message-State: AOAM532BXDMKlLN7r+QW02bAB4GFO2jrSsU1oxcSCPseU/38rB/bunf4
        QVwUnWbJHD+Zd3dnFYrqJJO62A==
X-Google-Smtp-Source: ABdhPJymF5qS6Ccow3hQ6AumA7SQr7+QCaXLRwptH1Hv/AQWQo0GwjJQZyDvsOIlVWzEi0Ahhs5GHg==
X-Received: by 2002:a05:6402:50f:: with SMTP id m15mr3406910edv.41.1599645556723;
        Wed, 09 Sep 2020 02:59:16 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4614])
        by smtp.gmail.com with ESMTPSA id r16sm1617107edc.57.2020.09.09.02.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:59:16 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:59:15 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     zangchunxin@bytedance.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH] mm/vmscan: fix infinite loop in
 drop_slab_node
Message-ID: <20200909095915.GA1412646@chrisdown.name>
References: <20200908142456.89626-1-zangchunxin@bytedance.com>
 <20200908150945.GA1301981@chrisdown.name>
 <CAMZfGtXDXzv8FEZa7cw6v+jV4ODnVuA3_UGEGWm7eTtZWCU+Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMZfGtXDXzv8FEZa7cw6v+jV4ODnVuA3_UGEGWm7eTtZWCU+Bw@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Muchun Song writes:
>1. Double the threshold currently hard coded as "10" with each iteration
>    suggested by Vlastimil. It is also a good idea.

I think this sounds reasonable, although I'd like to see what the difference in 
reclaim looks like in practice.

>2. In the while loop, we can check whether the TASK_KILLABLE
>    signal is set, if so, we should break the loop. like the following code
>    snippe. Thanks.
>
>@@ -704,6 +704,9 @@ void drop_slab_node(int nid)
>  do {
>  struct mem_cgroup *memcg = NULL;
>
>+ if (fatal_signal_pending(current))
>+ return;
>+
>  freed = 0;
>  memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  do {

Regardless of anything, I think this is probably a good idea. Could you send it 
as a patch? :-)

Thanks,

Chris
