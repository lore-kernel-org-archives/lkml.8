Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D18C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7EE2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="O1iO/1cI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDGBi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:38:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40513 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:38:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id y25so1538479qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0V84GznQIsN+4SGDl5mAomkomdqcxNUXjTt40LJoI8=;
        b=O1iO/1cIlXZzCWiXB9+N8Z/s/ZDrrhWL5RZHWQNV6RPvFIgdTwhusypEd24N3EvS+u
         CEtSn9Vu6T6XXI7RFnCoJAJgioCjZCIw9yc5hfy0VkDjmt7fnqeDu29cIJJEx104AlNE
         DsMfHbHlgUg2CJcBkCG6W2+eH1mxmqyNfhGIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0V84GznQIsN+4SGDl5mAomkomdqcxNUXjTt40LJoI8=;
        b=WVMjTq6bfiopgr4l3eVLrk3LD1es58xMsrTM0e0Gv448c1KR0Fv1HKPVphwvqyQTEf
         qZsXyDwTv5a35x3epTWzlfqQnPiiuNSAa7XCXKyE/btxnpEjdFvU7G0pAJnUPYwvqVnJ
         8TOWOikXmvwhILogpAqqRtrI1l0i5a8hLB3a+yxfBMEXyX37PnkrIrvJEUPpK5naAvTm
         2EY2umiQiGH3YPotuF8MP6kOmRU4aVfnI5AkocjMFX3A63NqPmYHRibOOKmzpTal6WWe
         Xmu0ONh7lHzZ0NpACtQV6uXhIhlWEejZcQWPlHpxZpqzl6Cr4y1uPsN0uudBF5i+vjY5
         13rA==
X-Gm-Message-State: AGi0PuaB6mprnHpwSDnWeod+GOh8othgAnRyd9Q/0DRqGO3fHTWJagm6
        0qJcW2kaOXhbVTJ0gjF8AnOQdg==
X-Google-Smtp-Source: APiQypJQIpzp8PWp6QS6VwafE9svAdjf9Tl0lNf3REDNclWpyq8GBv9wM3bcDa2wbyix6/gocLEKew==
X-Received: by 2002:ac8:2dae:: with SMTP id p43mr113698qta.341.1586223536644;
        Mon, 06 Apr 2020 18:38:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id h63sm10806252qkd.49.2020.04.06.18.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:38:55 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:38:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Neil Brown <neilb@suse.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] mm: make it clear that gfp reclaim modifiers are
 valid only for sleepable allocations
Message-ID: <20200407013855.GA11326@google.com>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-3-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031241380.230548@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004031241380.230548@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 12:41:51PM -0700, David Rientjes wrote:
> On Fri, 3 Apr 2020, Michal Hocko wrote:
> 
> > From: Michal Hocko <mhocko@suse.com>
> > 
> > While it might be really clear to MM developers that gfp reclaim
> > modifiers are applicable only to sleepable allocations (those with
> > __GFP_DIRECT_RECLAIM) it seems that actual users of the API are not
> > always sure. Make it explicit that they are not applicable for
> > GFP_NOWAIT or GFP_ATOMIC allocations which are the most commonly used
> > non-sleepable allocation masks.
> > 
> > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> 
> Acked-by: David Rientjes <rientjes@google.com>

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel

