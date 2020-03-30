Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34051C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF39320757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585557787;
	bh=VjXYVIE68W/j13WZqrvTDL7MF4Q7OHSn/2q8iCovu8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ga4SHMfAADsVo3IBKqW1KKDmKmHxzDciWIfr5eVHopDdXt3EQOegqUNSJvRyXmfvN
	 /MDr5w3HORiTfWBHHVgz+AVvKjkcz+f7H2ef3JxYx5EgJV7BFHMrShce/7xM9pBqxZ
	 eL4isIXD0+Awj+YdO2Wbkge5FmyX0JxQMTh6/jP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbgC3InG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:43:06 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:51882 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729416AbgC3InF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:43:05 -0400
Received: by mail-wm1-f41.google.com with SMTP id c187so19058807wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ocjz0JW0NGqrN1N1HQX6Y1TDgGsqONxhflCXz8O8z9s=;
        b=LjBGtqlLSit235LPeg+8buSxR1Q3162877TedpgZzqg7ysnHeP63JPtUyZQslK5WhL
         z+5RMdrXsb32YjcIyyst7LSTswk4pyA07Fd1kZ/A5wFSiWamRc5R/usZjcHsMKl+p9Q6
         0SJeNCjdj03XB3HCPht43bKgt5T3y8QGthqSP7pU4artDEycgFicmHWlzUNBmPwwv6Tt
         taLi11EzGpLjxoae2I4K/vIB+w2AlSyRaHIaDTN6oXrZNWnfcqeUrTA+7DwFdEyKNEXe
         cJbn+V9mUqYd5XBnB2PDD6YfvnnDdcoIeUgtXtJ89rNuwwf7eRVY0WMax+J7omN32qAk
         Aa6A==
X-Gm-Message-State: ANhLgQ0THzhoh6jHAJ4VAFBb49JQHYpOlfHzhwCGGLpTXJgW3G/3lHA+
        84YYJ0w/B/LE0nCNgfaWBqc=
X-Google-Smtp-Source: ADFU+vvSsbizGL71GziNxkHgDWksgMBhdi++vDZxuGiIBC+Bc9WUTwsqevNE0FbnjwELwApmuFKUnw==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr11662455wmi.94.1585557784407;
        Mon, 30 Mar 2020 01:43:04 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id c18sm21397292wrx.5.2020.03.30.01.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 01:43:03 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:43:00 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm/page_alloc: Enumerate bad page reasons
Message-ID: <20200330084300.GC14243@dhcp22.suse.cz>
References: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585551097-27283-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-03-20 12:21:37, Anshuman Khandual wrote:
> Enumerate all existing bad page reasons which can be used in bad_page() for
> reporting via __dump_page(). Unfortunately __dump_page() cannot be changed.
> __dump_page() is called from dump_page() that accepts a raw string and is
> also an exported symbol that is currently being used from various generic
> memory functions and other drivers. This reduces code duplication while
> reporting bad pages.

I dunno. It sounds like over engineering something that is an internal
stuff. Besides that I consider string reasons kinda obvious and I am
pretty sure I would have to check them for each numeric alias when want
to read the code. Yeah, yeah, nothing really hard but still...

So I am not really sure this is all worth the code churn. Besides
that I stongly suspect you wanted ...

> -static void bad_page(struct page *page, const char *reason,
> +static void bad_page(struct page *page, int reason,
>  		unsigned long bad_flags)

... enum page_bad_reason reason here, right? What is the point of declaring
an enum when you are not using it?
-- 
Michal Hocko
SUSE Labs
