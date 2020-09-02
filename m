Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A8C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625CE20773
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="I2Psemck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIBO2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727907AbgIBOVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:21:07 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D54C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:21:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a15so4241244ejf.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u3Brl6sICZlzc94xToldZguqfFAj/4hEX+7tdenJFrc=;
        b=I2PsemckSsLgoHVt1Xg0x2wQ7e0ID3DBNr3ryKwjK/fgtFGGtX/ir5WKeeB9+bcGW4
         gsNX0NPdP6WwLb2mZAZBlTrqY3ZR4ny6DfQ/9yM9BqxEYOjZo437d+dMpJPOm3MLIbWt
         H0FTN+N++tBXTlSCoZ5nkMWVtR/JPUY74MoElKzak/aYuwsJsRNbo7hokZ91BxPrbJl+
         f50sSJRQZsVOM4FUkxtO638SLf0hsHk84p08CyINiAMwJwOXr4q3Ln1fHkVa/Yi8ngX/
         zrmlJXRvkI717b/aX3ezQ8wsM4tzGejW/x3/P/mho2WIj4zQ/XGfNwxA2sug1+DFe/Wl
         3j8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u3Brl6sICZlzc94xToldZguqfFAj/4hEX+7tdenJFrc=;
        b=LuVoaInGHwB/9VGc24bZGFQ14Dt6Z8phOuafTI1UHJ8r6/oS2PXa+GuuCgcP8v+o7X
         d3cJbxEBecZQmvkgeJ/AxJSvzR1eXtZC2KdjzJSfkqcDhGIynJUxEqRncqL4D5K7KFAi
         Vg4G420RPfI47yTv4vr4o03vAwijTcf4lAcquwUc5rYO2vn3kVta9ebICoOEdp6O/hel
         lBFfE+9Kcs5xLdp9OywI/Bh3+gLme1cfL56/k9Jt6PM20NyXfWWWsxTxHfteDdr0isYB
         uOpCg4ZU+qlHUttWLi8o75+swqbfXz6k/8hjl60VSg1+97EdRTJo86tqBQEbYRJUcy+f
         bcKw==
X-Gm-Message-State: AOAM5307BX8/qW9Ulu3Yjxidx/r9RqAqws7ohTNM3oyvadK4RJ9Eqgyh
        eVGLekT2iFFEO85pRnCG7aQzKKhUNxxFgxsCmWcoGA==
X-Google-Smtp-Source: ABdhPJxs0qbJ6aOqCzbe3EB4Dw0NbwWddnfvRTMs6+4M+nQtohmf6QygqNzuiI7dfM7eV+eWJ2h0PmjojXc6QTboPNA=
X-Received: by 2002:a17:906:a116:: with SMTP id t22mr220123ejy.353.1599056460668;
 Wed, 02 Sep 2020 07:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <6469324e-afa2-18b4-81fb-9e96466c1bf3@suse.cz> <A8A8D5FE-86C3-40B4-919C-5FF2A134F366@redhat.com>
 <CA+CK2bAebg4PALh3_-49MXGJ-FNP3hE98wHZd5uEC-q7wG6Vmg@mail.gmail.com> <20200902135018.GF4617@dhcp22.suse.cz>
In-Reply-To: <20200902135018.GF4617@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 2 Sep 2020 10:20:24 -0400
Message-ID: <CA+CK2bDAjykqdMrrOEp=NJ28Z4CALXWkHixNMc5tmRYVk75Eig@mail.gmail.com>
Subject: Re: [PATCH v2 00/28] The new cgroup slab memory controller
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <dhildenb@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is how we are using it at Microsoft: there is  a very large
> > number of small memory machines (8G each) with low downtime
> > requirements (reboot must be under a second). There is also a large
> > state ~2G of memory that we need to transfer during reboot, otherwise
> > it is very expensive to recreate the state. We have 2G of system
> > memory memory reserved as a pmem in the device tree, and use it to
> > pass information across reboots. Once the information is not needed we
> > hot-add that memory and use it during runtime, before shutdown we
> > hot-remove the 2G, save the program state on it, and do the reboot.
>
> I still do not get it. So what does guarantee that the memory is
> offlineable in the first place?

It is in a movable zone, and we have more than 2G of free memory for
successful migrations.

> Also what is the difference between
> offlining and simply shutting the system down so that the memory is not
> used in the first place. In other words what kind of difference
> hotremove makes?

For performance reasons during system updates/reboots we do not erase
memory content. The memory content is erased only on power cycle,
which we do not do in production.

Once we hot-remove the memory, we convert it back into DAXFS PMEM
device, format it into EXT4, mount it as DAX file system, and allow
programs to serialize their states to it so they can read it back
after the reboot.

During startup we mount pmem, programs read the state back, and after
that we hotplug the PMEM DAX as a movable zone. This way during normal
runtime we have 8G available to programs.

Pasha
