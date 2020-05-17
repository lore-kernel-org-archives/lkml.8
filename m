Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8A8C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36489207C3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 01:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mTuyBRur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEQBqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 21:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgEQBqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 21:46:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F6C05BD09
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 18:46:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id z80so6800785qka.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 18:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=v8/1I95wcTj1mWlxsoep0Hvc73TKsH79uHMoZbzZUWA=;
        b=mTuyBRurXQZEK9utptTiC11aN2pRP5dmNcE3mS9JBiWGvq+XHi1IprBG0ma5RZ8d1B
         mq/y+wqaSGx+FRZ55wJjSWJknBkFCrIAqsYJSJG+IJNbVLUiZY0PjS65iNMYjH5poapJ
         ano66ITpWYc7rAQifzLH5VBHZaDrUFXLp87bcqJILV29+PDGdX7D8K7W9M26JKqOX6FC
         aQiPnMJf1SdeDID06QRXlqxWkRGX8BJvxwE8AUiQJvRghyyLv3dtN/xklxayHY2TAiOW
         QudmNWPFzxw7MllH6ftOp0wvqb3tMAV8Mda48M/0Wy7idJzc4TBrjXekP9QxEtS5uGvd
         wtyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=v8/1I95wcTj1mWlxsoep0Hvc73TKsH79uHMoZbzZUWA=;
        b=R3dtu+NwRDydQRRgfuKGGp8f5Qw1K966j+JviOGwKqP/VaaNEKMIX5uCNlG+tVzmmY
         t5zYwEI6cZV6yU2JWflpIdC2PJLa6b4Hshhn8TCkikTCebIGUv0PuVdWvSibFzqS980B
         LNJbdy15enTbwQQZ3sjFaeb1CzJ9m5P5y6tPNFs6u51o+SrDTuO2ca7s1y1Q4/qj3olh
         SmdnyyLYMOKhLRubmFzvAyC8bsYWtemZcRw+o4oP8eUcugRwbgPIjTKIodmPeFeUtkuK
         J/dFtIEHef4LPgJM8xGq9DsbP8RekJD5DSafcGQyRZx4+WmtRNiziq3kujiLbIcohf67
         fY5Q==
X-Gm-Message-State: AOAM530WgIrvPDwzE+s3NS8qS3xsHKeiXPbtpVj0aBSxGOESwqU0ngfb
        3hgAPPNWTU079tGRXIv4DNPq4MpzNn/uZQ==
X-Google-Smtp-Source: ABdhPJzStOu9xj05KLKxunZry1UUBpBOKseoEyDnnEQBwPMBKvyZuLowmwoxKqJL+Hq9l1aoJW48+Q==
X-Received: by 2002:ae9:e858:: with SMTP id a85mr10042251qkg.478.1589679967192;
        Sat, 16 May 2020 18:46:07 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g66sm5186785qkb.122.2020.05.16.18.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2020 18:46:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 4/4] mm/slub: Fix sysfs shrink circular locking dependency
Date:   Sat, 16 May 2020 21:46:05 -0400
Message-Id: <62C1A69E-A14F-42EE-970F-ABAEA2782256@lca.pw>
References: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>
In-Reply-To: <56327de0-fa44-d5f3-2409-69cf2b97a209@redhat.com>
To:     Waiman Long <longman@redhat.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2020, at 10:07 AM, Waiman Long <longman@redhat.com> wrote:
>=20
> Trylock is handled differently from lockdep's perspective as trylock can f=
ailed. When trylock succeeds, the critical section is executed. As long as i=
t doesn't try to acquire another lock in the circular chain, the execution w=
ill finish at some point and release the lock. On the other hand, if another=
 task has already held all those locks, the trylock will fail and held locks=
 should be released. Again, no deadlock will happen.

Ok, I can see that in validate_chain() especially mentioned,

=E2=80=9CTrylock needs to maintain the stack of held locks, but it does not a=
dd new dependencies, because trylock can be done in any order.=E2=80=9D

So, I agree this trylock trick could really work. Especially, I don=E2=80=99=
t know any other better way to fix this.=
