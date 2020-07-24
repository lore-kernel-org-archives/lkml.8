Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DEEC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D5C02065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595575709;
	bh=5LCeA93hSIWfL7n2ZJEDmfhNeuNUlcENjgniQTAaN5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dwUu8XP9jDqfKjpNsTW4bwXm8sBBwJRqD24fU3ur3rChXRvj4RVLWrwKxIYPsdwTh
	 pDwchxJWcIMKUJ/uJF+ClehdXeCNKkfzdSLV9VJjFw0j1QsW9qHuGFbkj/a99AD2oA
	 tjbRkvfBUtTkbS1IIbjVsxJ28ZvD16IjOMOQ3Pos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGXH21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:28:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36590 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgGXH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:28:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id dg28so6320230edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xfL/HVhb5CZmwLPp8FrK3Hc1m89ug/giIGTFH3XnKGo=;
        b=tQ3oOED3r+MGbka7TXFwjKJhyVmdFDL9IPo/s88lIz3E0B++9iTDNOsc2lH6OUn1tX
         JatungYiIduaHC2oFWVY3UeXLp85siFJ+gZ7xFCFJw+oDlEASLQxksSxBnLyct+afauq
         nIcyBvu8Ju1kcUuNL+gcVqcXv7de4sLYE+3lW38gDMyhSkOAlNdZn0+HjtU+cihzuU/9
         tUh3ouHyLxK3HIRzgPOqq5SvsZFynVwxc2KwJtKk8jqXIfl2sJnvYfKF8mSi7Vvvg4pQ
         PgcDl12o/K3/GmPf52aKkHKUUnJ3aOgvmyIFnAaHZor3QWK80d15UAOW5GuzKY21e/ta
         s+mg==
X-Gm-Message-State: AOAM531YC7ajiqyG2y3zrYIinQ2qsFPaKZtlTlUSiLxfR30BOVWbDqKc
        Idml9+0QiYksYd3dQn0Z5eg=
X-Google-Smtp-Source: ABdhPJw43GhFTsOZBuTzQhugNO+Sk6Rpj0CrpsDoWTG6p0Jw6ktDtr5TgT1bNjQpFHfxrJ2v5rE5xA==
X-Received: by 2002:a50:cd53:: with SMTP id d19mr7868671edj.300.1595575704271;
        Fri, 24 Jul 2020 00:28:24 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id lc18sm120397ejb.29.2020.07.24.00.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:28:23 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:28:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xen-devel@lists.xenproject.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
Message-ID: <20200724072821.GD4061@dhcp22.suse.cz>
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
 <20200723122300.GD7191@Air-de-Roger>
 <e94d9556-f615-bbe2-07d2-08958969ee5f@redhat.com>
 <20200723135930.GH7191@Air-de-Roger>
 <82b131f4-8f50-cd49-65cf-9a87d51b5555@suse.com>
 <20200723162256.GI7191@Air-de-Roger>
 <4ff380e9-4b16-4cd0-7753-c2b89bd8ac6b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ff380e9-4b16-4cd0-7753-c2b89bd8ac6b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 23-07-20 19:39:54, David Hildenbrand wrote:
[...]
> Yeah, might require some code churn. It just feels wrong to involve
> buddy concepts (e.g., onlining pages, calling memory notifiers, exposing
> memory block devices) and introducing hacks (forced onlining) just to
> get a memmap+identity mapping+iomem resource. I think reserving such a
> region during boot as suggested is the easiest approach, but I am
> *absolutely* not an expert on all these XEN-specific things :)

I am late to the discussion but FTR I completely agree.
-- 
Michal Hocko
SUSE Labs
