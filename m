Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2837EC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0168220CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="aSZjpZyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBCRmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:42:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33105 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbgBCRmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:42:09 -0500
Received: by mail-qt1-f194.google.com with SMTP id d5so12130099qto.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DnqDfzZOP8Wk1acgjZzz1PM0k7XDfNwpc8E6dw5Xd/A=;
        b=aSZjpZyxvhUaYrerYRx7KTmQ+HXipJMmxMVJCuMZp0/ySh0wMOW3RcN4S5843cbgJ4
         KXmvCMexX3j7dPqPK759dur6NCW66uaZpnz+mZN8hL3Nc/45XqCE4fgeOiUVTjJMfatU
         +GhNJxHYApLaL4HU98JgJ2B+Sgy5OyPIGFhaQAz81ZZyGBTGRTGwuul0jEhZZ4ampBlg
         zBPg3dFLHkdXvXM4VegKWWtVz0TgxCVfjQk82AoveKA7ImBJX6OaBLKENbZ3NQ3xM/46
         gNCxhEfTnTq2er2cAibUoOL35v+elnwQW+37UDyIb8jArmjmQ1PMnLdjXLEn8cE6gDAV
         kGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DnqDfzZOP8Wk1acgjZzz1PM0k7XDfNwpc8E6dw5Xd/A=;
        b=IlWqpJstF+toNYjLGeMCcstpvCqm9S0gar+eLDYY7VMKi/KbLL8cPua24riEzPUEK1
         hVw2VRcXH88smS0yoQM45Q4MVARL4Z0NyvmNXhs6vGne6h/aRq7hmXr/bMnfTiHbeujG
         X9BMhSNkdRRc9R4Zfx6NNQLWSygLdWZ2JI//qSykdL1W1A3Pm3WYUkqzHiHXLwVaMxDZ
         e2waGLiXpcIgGGGmbVOhbbNNMA7EQd7sObxD6/fynInUifh+ICq8xzRmiVPnbfNHz5N1
         4uTUOd0+shatJmnbDigT5IMtJ34adULxowXQTqsBp3eX99sU/OkerS/adJ/xMWW7V6MH
         I2UA==
X-Gm-Message-State: APjAAAVTz07raToWXg27fpXcaZZNtaZlgQ/TRQq1YD71DeZtpsqNpu06
        q6TQFE9yqmeemYI07IPOuHUm3aB2Yt4=
X-Google-Smtp-Source: APXvYqwl5D1MXNbncdMUPHKAVOZnY2rUJ0roHkqHVdSeIwO+B1VEe2ZgHLlLh6w/C4SMmNThe/Cnsg==
X-Received: by 2002:ac8:47cc:: with SMTP id d12mr24999145qtr.246.1580751728806;
        Mon, 03 Feb 2020 09:42:08 -0800 (PST)
Received: from localhost ([163.114.130.128])
        by smtp.gmail.com with ESMTPSA id o17sm10136378qtq.93.2020.02.03.09.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:42:08 -0800 (PST)
Date:   Mon, 3 Feb 2020 12:39:58 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 10/28] mm: memcg: introduce mod_lruvec_memcg_state()
Message-ID: <20200203173958.GD1697@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-11-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-11-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:35AM -0800, Roman Gushchin wrote:
> To prepare for per-object accounting of slab objects, let's introduce
> __mod_lruvec_memcg_state() and mod_lruvec_memcg_state() helpers,
> which are similar to mod_lruvec_state(), but do not update global
> node counters, only lruvec and per-cgroup.
> 
> It's necessary because soon node slab counters will be used for
> accounting of all memory used by slab pages, however on memcg level
> only the actually used memory will be counted. The free space will be
> shared between all cgroups, so it can't be accounted to any
> specific cgroup.

Makes perfect sense. However, I think the existing mod_lruvec_state()
has a bad and misleading name, and adding to it in the same style
makes things worse.

Can we instead rename lruvec_state to node_memcg_state to capture that
it changes all levels. And then do the following, clean API?

- node_state for node only

- memcg_state for memcg only

- lruvec_state for lruvec only

- node_memcg_state convenience wrapper to change node, memcg, lruvec counters

You can then open-code the disjunct node and memcg+lruvec counters.

[ Granted, lruvec counters are never modified on their own - always in
  conjunction with the memcg counters. And frankly, the only memcg
  counters that are modified *without* the lruvec counter-part are the
  special-case MEMCG_ counters.

  It would be nice to have 1) a completely separate API for the MEMCG_
  counters; and then 2) the node API for node and 3) a cgroup API for
  memcg+lruvec VM stat counters that allow you to easily do the
  disjunct accounting for slab memory.

  But I can't think of poignant names for these. At least nothing that
  would be better than separate memcg_state and lruvec_state calls. ]
