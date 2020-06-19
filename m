Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C165C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68139207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bF/KL5lL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbgFSBcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgFSBcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:32:01 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EABC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:32:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so4631306lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRNqswcDD+7gU99eajO2uAdW0qLUELxTADFfqedXHc0=;
        b=bF/KL5lLdnHf/s7iJT80JuKJRDQcYtt7xPZ9sx9O49I5AiG4oJtqkhIvIg0WmhFY0N
         In50ikw30tfIpXqwcFiuSCyiz3Mw545oRB0022NjuqwLUdjP1p3V0oItWtblZeiRcrrQ
         H3/P6XaaZ+A3QFfkraICyjmqmyuw58xqWBYkLII4VuWyZjtKSHPoOCEwXWL+tVHNBcgQ
         uCj0bmxEUA6On/3hivi1s4q78VSM1624m4GzEAHWvW7MNBBAot5QpKSs+i8q1GNvaO2H
         YIpP7YEPPrdx4foQw2LDBqbE9VEufglIpAlA8AJhtmwrfu8sSNpiJC5H7L6yMC2X0jiN
         hdLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRNqswcDD+7gU99eajO2uAdW0qLUELxTADFfqedXHc0=;
        b=Hq/SV8YTWPk1eGdo3TC4Jg7P58j9HGQIMTp4FbmOTavfXGfCh3hjnKEkAmAMqQ0zBN
         1Fo5HPuoUXgSziOjXAOYyncUVxVOusWiTbb8EIzVGLfNJCkTQhRM5vrSZQZpkLciUgfR
         kgaXrsd3nuLBpp7WZBSSbBZL3uuxymv6eu3yUWNHYUWpgkY6oQm629dVCBxOMmV+c2ad
         2NWSLybpILOIKJvl+TvqN61ArMCADZpztSRgecArfbCE5WyJz9D/YwDjb4BkQTP0jOV4
         2HkNePJGcWkV9Y+mBWdJpacYrwoa97fN7rLoVhoWusmykTW5wutqMuCon4JTHkm783kb
         GAzA==
X-Gm-Message-State: AOAM532WS9MXMV7XKthf9Pvh1QJCQj2yEyVHr4WgrxmSGmiv7I32FypW
        9WER708imu1+6LmRKK7cCl/b9xj9giWsbnjyPn3dyw==
X-Google-Smtp-Source: ABdhPJxd/k2n5PiFiQPd1NPow/mTdHCH7OcWv89FNWviXu1HPDOyEDJxtsQwjndapO916JRvoqeTPjYiI80AV8vrpIs=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr532247lfq.3.1592530319205;
 Thu, 18 Jun 2020 18:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-6-guro@fb.com>
In-Reply-To: <20200608230654.828134-6-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Jun 2020 18:31:48 -0700
Message-ID: <CALvZod7VyHngBLd+og-DVJ=9zFFN8fT3r1UN=sO47_Ay9QBEYw@mail.gmail.com>
Subject: Re: [PATCH v6 05/19] mm: memcontrol: decouple reference counting from
 page accounting
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> From: Johannes Weiner <hannes@cmpxchg.org>
>
> The reference counting of a memcg is currently coupled directly to how
> many 4k pages are charged to it. This doesn't work well with Roman's
> new slab controller, which maintains pools of objects and doesn't want
> to keep an extra balance sheet for the pages backing those objects.
>
> This unusual refcounting design (reference counts usually track
> pointers to an object) is only for historical reasons: memcg used to
> not take any css references and simply stalled offlining until all
> charges had been reparented and the page counters had dropped to
> zero. When we got rid of the reparenting requirement, the simple
> mechanical translation was to take a reference for every charge.
>
> More historical context can be found in commit e8ea14cc6ead ("mm:
> memcontrol: take a css reference for each charged page"),
> commit 64f219938941 ("mm: memcontrol: remove obsolete kmemcg pinning
> tricks") and commit b2052564e66d ("mm: memcontrol: continue cache
> reclaim from offlined groups").
>
> The new slab controller exposes the limitations in this scheme, so
> let's switch it to a more idiomatic reference counting model based on
> actual kernel pointers to the memcg:
>
> - The per-cpu stock holds a reference to the memcg its caching
>
> - User pages hold a reference for their page->mem_cgroup. Transparent
>   huge pages will no longer acquire tail references in advance, we'll
>   get them if needed during the split.
>
> - Kernel pages hold a reference for their page->mem_cgroup
>
> - Pages allocated in the root cgroup will acquire and release css
>   references for simplicity. css_get() and css_put() optimize that.
>
> - The current memcg_charge_slab() already hacked around the per-charge
>   references; this change gets rid of that as well.
>
> Roman:
> 1) Rebased on top of the current mm tree: added css_get() in
>    mem_cgroup_charge(), dropped mem_cgroup_try_charge() part
> 2) I've reformatted commit references in the commit log to make
>    checkpatch.pl happy.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
