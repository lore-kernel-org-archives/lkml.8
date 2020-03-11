Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CA8C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7094120828
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583915804;
	bh=rYU9EHkBVJDxzMbRSRnOsF9n9RDZ5qwV7X2D9bTyouA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1pQ+V2zcjVQb+wtRn+ZVqwShKBE0SHfDe6E3u03Z1eia7ySP4ycglF4xkNRKxF55x
	 olit051LSyQW3xdP4s6QkHX18AIH4tacVLLj7muwDeii5I2siGbRvvTzRpPJhY7UNy
	 c7g5r80sbzDG2kW1xhv77lyESpKfevh/DFEJXwWg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgCKIgn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:36:43 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:40457 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgCKIgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:41 -0400
Received: by mail-wr1-f44.google.com with SMTP id p2so1408625wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrLRJuPbYIK7nmotXnXODJV5Yg8CVdNS7eXeA+2dkkE=;
        b=AhRKRh+p8J1KLZ/RUBmaQLcBZS113c0LiiN2RrF6bB2JotwZJdf5YV6l3UaY2x2BUn
         eQas+TiJ1JoSRFubIfkSbi0+mjd23MhAsiMjAgKq1+0izWQpDWYvC7w9gCeWn6p/lKX4
         joPBAsVVcJFbtRihM+xG8593Srr6/dd+7a8wyb5NZeXhrJWmJqlx/VT0YJWLuvDMtKlM
         28EUEZX0vLdo8UVhRB3AaZ9CMKf8bgMIxlpZZTpjNcYrj5GLqBRV5h9S8YzxfUl1yOLD
         gaGRLFG1Kg68ifF+DFhw2Bd+sLcDRzS1SUZdV8sDcY8XMVQJif7e2FSal167PHPaqLtE
         Sbxg==
X-Gm-Message-State: ANhLgQ1P7iMTzqXFvGcCLM+5Iofh1MbM61NAO/uW0LbPE2yf7UO0EvWx
        JjgekRMOWfHlR+KvbIo22HU=
X-Google-Smtp-Source: ADFU+vviEG7Xlq9OoItYp4ZTrXEdCMOzkHBwOCwILT8TQ8h+nJqJpS3kHQSO3J9buSMU9/7gAq0b6Q==
X-Received: by 2002:adf:f047:: with SMTP id t7mr3277675wro.371.1583915800854;
        Wed, 11 Mar 2020 01:36:40 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id m11sm22952260wrn.92.2020.03.11.01.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:36:40 -0700 (PDT)
Date:   Wed, 11 Mar 2020 09:36:39 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200311083639.GB23944@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <20200310171802.128129f6817ef3f77d230ccd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310171802.128129f6817ef3f77d230ccd@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 17:18:02, Andrew Morton wrote:
[...]
> (And why is shrink_node_memcgs compiled in when CONFIG_MEMCG=n?)

Because there won't be anything memcg specific with the config disabled.
mem_cgroup_iter will expand to NULL memcg, mem_cgroup_protected switch
compiled out, mem_cgroup_lruvec will return the lruvec abstraction which
resolves to pgdat and the rest is not memcg dependent. We could have
split up the reclaim protection or the loop out of the line but I
believe it is better to be clearly visible.
-- 
Michal Hocko
SUSE Labs
