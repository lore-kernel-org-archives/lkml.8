Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B48FC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71AE222D9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3nvp3iV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727525AbgCKFI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:08:57 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39370 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgCKFI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:08:57 -0400
Received: by mail-pj1-f65.google.com with SMTP id d8so365018pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=upcYox+hR0ff8PbXC/tjXbgIwJyTE9zI/gU5bKsBrcE=;
        b=G3nvp3iVpVC+yHQkmM1FUvj/OVrYCTe+/dsoBxZEEtfC1hTuasXwqna9yAt1P/K0nE
         0ki9mJaOhcAhhTHguCjns0Wm6eO+AxFLXS+Khmi3iBUY27t+SCI8cOoDxJfy7Isd6fvX
         Mu/DS3uKKOBVRg7kWVV94+e+N2lKLD2uSlV/Zme8Gbpl/6C7QV1QrhNN41ylEOoRmBMS
         KVUowSNqsYyS9rRl4wDU2xUuVSWErgbs8GtxYB3DCQ6wTFvodblK0mEVkLf/TnNXM8Bo
         GnRLy/4G0dZ10SiSmYK7fQ8dkobJaCEEy62h0tlVic2Vlf3D2iB9CrdrPW4NKHlRaePG
         PCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=upcYox+hR0ff8PbXC/tjXbgIwJyTE9zI/gU5bKsBrcE=;
        b=QNT2SyalOGrH1ViGtq7K5lSmqJ59YGMllYYAZTzfWbM0kl15MNUl3WFHM7fOzZYJ8+
         yVOmNJh7IScDp9cjCw4cBg70rS+uEIY7oLWEDhLhj2yc54iJKZj32JsUT8daQnPUwl3E
         a21Btu+JGtGRpZOMbazeDm2UrK6gL1BGRghqFlV+Kr9FtFSBYSmzJk+fVFZbjLHkY5Cq
         Gaq/xAhGpn8718GgGvFj5FbwtyIHqI13YZCGLiwSw3kBGv7mscqOO9UpGHzfCt9Rv28k
         Rojr8rUR1hESJE5PaxWQCVlfB2Q3bfeoOJjJlsPb+tjreJdLlASpHVRjXyyQsFkPKPqT
         jlyQ==
X-Gm-Message-State: ANhLgQ3QaWXmW2K2JO6vbq1vQqnDlzj/+jP5AW2ZvX+6yRFBohtodpCp
        FNBJIP0ku3ZQe0d3zLMrZTeFng==
X-Google-Smtp-Source: ADFU+vuBKgQ7tqeX6Y2sfHE73I7Iho4eW+dmedne9Rn6L6zY1FrbOYgVjkUbkDyv3fB7rHslN4KxSg==
X-Received: by 2002:a17:902:7794:: with SMTP id o20mr1418285pll.312.1583903335973;
        Tue, 10 Mar 2020 22:08:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o128sm16053078pfg.5.2020.03.10.22.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 22:08:55 -0700 (PDT)
Date:   Tue, 10 Mar 2020 22:08:54 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: Add more comments for MADV_FREE
In-Reply-To: <20200311011117.1656744-1-ying.huang@intel.com>
Message-ID: <alpine.DEB.2.21.2003102204450.255869@chino.kir.corp.google.com>
References: <20200311011117.1656744-1-ying.huang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Huang, Ying wrote:

> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6f2fef7b0784..01144dd02a5f 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -9,10 +9,11 @@
>   * page_is_file_cache - should the page be on a file LRU or anon LRU?
>   * @page: the page to test
>   *
> - * Returns 1 if @page is page cache page backed by a regular filesystem,
> - * or 0 if @page is anonymous, tmpfs or otherwise ram or swap backed.
> - * Used by functions that manipulate the LRU lists, to sort a page
> - * onto the right LRU list.
> + * Returns 1 if @page is page cache page backed by a regular filesystem or
> + * anonymous page lazily freed (e.g. via MADV_FREE).  Returns 0 if @page is
> + * normal anonymous page, tmpfs or otherwise ram or swap backed.  Used by
> + * functions that manipulate the LRU lists, to sort a page onto the right LRU
> + * list.

The function name is misleading: anonymous pages that can be lazily freed 
are not file cache.  This returns 1 because of the question it is asking: 
anonymous lazily freeable pages should be on the file lru, not the anon 
lru.  So before adjusting the comment I'd suggest renaming the function to 
something like page_is_file_lru().

The rest looks fine.
