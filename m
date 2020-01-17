Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE9DC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC9C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UdczXrlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgAQPFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:05:17 -0500
Received: from mail-qk1-f175.google.com ([209.85.222.175]:43526 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgAQPFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:05:15 -0500
Received: by mail-qk1-f175.google.com with SMTP id t129so22926363qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=vEWn2SOFLnhk6DlGp/dtE96pkDjAj01HAVf7nAH98+Y=;
        b=UdczXrlrHa7YI7hXuVCGuYq3iIBXYbq7STlxmX5/IEAtQp12ssQdMaOaEmXiRwLDnO
         aFG08He1ZOznOu+u9WwwmvxBEPi2O9Ops3pGHITFG7sh+sP1/bs42HruOwufQWsEHIi8
         IWfeEymTVvG56MvshgmDAQwmvYpdezVUWJGliYS+1ARlknRvdGKWEIJmlZNmNevnrW0o
         qRmtV4dIeyJz/sjyxQamX4g4nAzELTcBVo8MA1biGJILF703GtWjbGoxinQ7GwYI3MQY
         q0L11M2vOjTJvE22s2zKWDbjkSdn9m5aC98Bkt1cipcz+5hVxG6+F2t9w6rsX2l+qXKn
         IvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=vEWn2SOFLnhk6DlGp/dtE96pkDjAj01HAVf7nAH98+Y=;
        b=Prv5UnnR9sqgPNvFJj1ETJXTRi8c7rSbd/pkgnCHrkuHQFPvj4lr7HcKKbgrDYlgRL
         xO9tvXzHd/cn9E9RpT4o7EoBUgPx5retMvQO89SzJqnbTWYOjlRhg/fSlpwND3JfuWhp
         +3xQaWF638pTdxb/1GLTGFxf4m/F1WKYA2PJRELyJ2ib3VjV3SdxTdH5u2X3wPAqM9D6
         g0nLH/Lms0FjmsEdEIkj1BnHWZzNVlMKg4cfIGeA30aLl77py0armz0lSyoHVV1SO1fc
         5gKcBSvLR5PCNkSCw+DWlFjY+NzuMM7VX3iUG6zI74SD6cY+bPQ19ROvZ4R66iOmdkMd
         ZKOQ==
X-Gm-Message-State: APjAAAXImLF2UfcyFyeu2FvTLmiTA3gpmnGxT633X0C1KK2fdsHNLfL4
        h5gaHg0lTAavWN8n8KVQfMg45VIpDbkOJg==
X-Google-Smtp-Source: APXvYqx6RVwiL9F8OYzKZk4pR48hSdZp3wdMlXTx5STMtgYUyHVc9K4iYn34cah0ksfCUa67Zlvvuw==
X-Received: by 2002:a05:620a:1030:: with SMTP id a16mr37042858qkk.1.1579273513798;
        Fri, 17 Jan 2020 07:05:13 -0800 (PST)
Received: from [172.16.31.141] ([209.104.239.146])
        by smtp.gmail.com with ESMTPSA id d26sm11693722qka.28.2020.01.17.07.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2020 07:05:12 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with printk()
Date:   Fri, 17 Jan 2020 10:05:12 -0500
Message-Id: <3B7490FB-E915-4DC7-8739-01EDC023E22E@lca.pw>
References: <20200117143905.GZ19428@dhcp22.suse.cz>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200117143905.GZ19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 17, 2020, at 9:39 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Thanks a lot. Having it in a separate patch would be great.

I was thinking about removing that WARN together in this v5 patch, so there i=
s less churn to touch the same function again. However, I am fine either way=
, so just shout out if you feel strongly towards a separate patch.=
