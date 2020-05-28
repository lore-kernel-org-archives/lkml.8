Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7626AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537C0207F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590680898;
	bh=BwCgi9J7KWU/nLXt2W99vuMsB2y9C+n74rVufwGNt/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xXaR3SPguE8TbOqEcaFbVDBQeAIt8pEljrNf+UlUyDH3Bw8sF5Lbz7hhPlEG+45xV
	 xue2Cc4c/C9tabgqb4MO8eTpTDanifRU7rZuMB+ADHQwU85okJF+K+Vqg5llzqS+SY
	 QP3g6jdW9kqDuAzvW9TWvv7XotMmyC1XaFnFBJzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404754AbgE1PsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:48:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43943 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404544AbgE1PsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:48:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id l10so5708996wrr.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ouG0vTXmGAj+06x++6dy4/bSuy/A+T+LxvF64Ruzwmg=;
        b=VBYBiLp7C7HubQQmFr+S3joJsOU0ByoSvYGPxzBF+mbm/6OgTTxX1hE9GwpMtedl2b
         GQ2UlOqmwGEvDbT5Qzrqe/GCE5zaHGk6eF9nwQlh2LwkkCjsRUngefBRM8uPjeaPRwrz
         uREzmW4GW0i4japiAFC30JDFVWjHkkhnO/rj3/Q4HE8peUYa9Yu2Jp9D84iY9ZLowV9M
         DrLAWjTK0GUBcnXzwhQ91CiIkCdPHjPGrGwpfsoghBTUgfHLRkjJWfCtU7DzvfPRYI1V
         NaDwtzg9OteaQ47bOWWHDKvS9lIErKvAMLvZUf6AOhbLTdUXoAJB3Gk65hUuQ36GUFNM
         Cr2Q==
X-Gm-Message-State: AOAM531+JsV/w0brzDJ/MKHFyZ8O0SFVju0HMu0LliSpchdioTeKHg85
        iYGqizqogwiQOANhUxgLCPw=
X-Google-Smtp-Source: ABdhPJzQcHNKp5TZkGwD+fTTqSoVUWoSoJEjD9qq+DSxu9ct6RREji7n8yMuueaiovMAPJl5iqNKcg==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr4216876wru.252.1590680891902;
        Thu, 28 May 2020 08:48:11 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id l5sm6381630wml.27.2020.05.28.08.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:48:10 -0700 (PDT)
Date:   Thu, 28 May 2020 17:48:09 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] make vm_committed_as_batch aware of vm overcommit
 policy
Message-ID: <20200528154809.GH27484@dhcp22.suse.cz>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <20200521212726.GC6367@ovpn-112-192.phx2.redhat.com>
 <20200526181459.GD991@lca.pw>
 <20200527014647.GB93879@shbuild999.sh.intel.com>
 <20200527022539.GK991@lca.pw>
 <20200527104606.GE93879@shbuild999.sh.intel.com>
 <20200528141802.GB1810@lca.pw>
 <20200528151020.GF93879@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528151020.GF93879@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28-05-20 23:10:20, Feng Tang wrote:
[...]
> If it's true, then there could be 2 solutions, one is to
> skip the WARN_ONCE as it has no practical value, as the real
> check is the following code, the other is to rectify the
> percpu counter when the policy is changing to OVERCOMMIT_NEVER. 

I would simply drop the WARN_ONCE. Looking at the history this has been
added by 82f71ae4a2b8 ("mm: catch memory commitment underflow") to have
a safety check for issues which have been fixed. There doesn't seem to
be any bug reports mentioning this splat since then so it is likely just
spending cycles for a hot path (yes many people run with DEBUG_VM)
without a strong reason.
-- 
Michal Hocko
SUSE Labs
