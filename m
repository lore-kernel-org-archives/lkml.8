Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0CDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A00820679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BIdRz1p8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732129AbgCPQVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:21:31 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:39321 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbgCPQVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:21:30 -0400
Received: by mail-qv1-f65.google.com with SMTP id v38so5125262qvf.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9klmvsCDbXb5UYRZlQllkDdUD0lGfzdSvUkSWWRacQo=;
        b=BIdRz1p8gE7zQuk9C9oV2HUNArw5x43uMFazoWlkrlXCvsSeUsivCaSdXGEbbFTYjy
         nVHA9sJZ7eETinHItrBU4wkyITu/QJh0Hk7+Zg4PL5xep7s0jQVsZRD4ZWsnd5ipJD9v
         sapWytPkQe7cpFo/rwKJ+7zg+T6UXo8doO5npkHb/HZMK7ZCgLKDLWa4AJ94FFjM+cx2
         RbztSybf9OHQoAu+GbPdpNc0d7bgoYECl7ZfwdX1uisQIF3JKgd5exWrQzIH8FwYxLvK
         7LoFUX9bkY1j/teBAy37KVGtZTsTa3q/X6cjYnD7zY79l6KnHy70ahkT8I/rVjcAcc1z
         pwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9klmvsCDbXb5UYRZlQllkDdUD0lGfzdSvUkSWWRacQo=;
        b=gHEjUGRhH87+V0Fru79SeXXXBn9E+Fv0z0q1XkQ6YX/CHVhFNUPM54tEdLcaBMMv5O
         OJO2c+RUOuoFjQM/pQX10X/nXhLz0pBlKUt/XIMTtvVtn0rcLS97Vyn/Oc2iJG9Ocvgb
         TYWiIIJxeT0IEistXpmx7QJfZuLcxnXGbqMlOMCTqcbxr0EkWfj4dFENajvD+eyQhy47
         6CRO6NpbliBRSMO/PV9IdeswPlIt6/ZJvy998ml/wTpUd6BLuZa24kwr/pTQazd/2wsm
         WHPZnOWzXH82IlfXNYV1KM4MT7otaotM7+9YU0zjFIWkm49yc3tOF3hSWrL/GbyW0gzY
         RMEA==
X-Gm-Message-State: ANhLgQ13UrfmCE/0NqJKkwCtH90PjGdsmZW62TaV9qgq32CBxlXSFkhu
        CSBdzKMttkvc1j47PoUoT92b/A==
X-Google-Smtp-Source: ADFU+vt/P7ZURa36l2KZQ/dCMCuB9sP/P1NIhNUnoYuUrITCwV6n9U2JPEM6tTD4GaQXZXYkNktwxw==
X-Received: by 2002:ad4:57a8:: with SMTP id g8mr584591qvx.78.1584375689499;
        Mon, 16 Mar 2020 09:21:29 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id z19sm85599qts.86.2020.03.16.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:21:28 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:21:28 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm, memcg: Throttle allocators based on ancestral
 memory.high
Message-ID: <20200316162128.GF67986@cmpxchg.org>
References: <80780887060514967d414b3cd91f9a316a16ab98.1584036142.git.chris@chrisdown.name>
 <8cd132f84bd7e16cdb8fde3378cdbf05ba00d387.1584036142.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd132f84bd7e16cdb8fde3378cdbf05ba00d387.1584036142.git.chris@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 06:03:04PM +0000, Chris Down wrote:
> Prior to this commit, we only directly check the affected cgroup's
> memory.high against its usage. However, it's possible that we are being
> reclaimed as a result of hitting an ancestor memory.high and should be
> penalised based on that, instead.
> 
> This patch changes memory.high overage throttling to use the largest
> overage in its ancestors when considering how many penalty jiffies to
> charge. This makes sure that we penalise poorly behaving cgroups in the
> same way regardless of at what level of the hierarchy memory.high was
> breached.
> 
> Fixes: 0e4b01df8659 ("mm, memcg: throttle allocators when failing reclaim over memory.high")
> Reported-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: kernel-team@fb.com
> Cc: stable@vger.kernel.org # 5.4.x

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
