Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB45DC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8FB2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cQIH8N+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgAKAZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:25:46 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37961 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbgAKAZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:25:46 -0500
Received: by mail-oi1-f195.google.com with SMTP id l9so3491412oii.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxcaaY2Ke+Y4K42xMdZnlgLPDpsSzCqwnxKiJt3NP5k=;
        b=cQIH8N+ywBxIddBxvZs+WWxAty36Gs4wW7iMq4oORsYC2kzPJMYX5M2z/Rz2R4MJQU
         zRFpxqSKmsnGmfNaGHv5bNvoeJ16VLgXRLMzQX64/7Jqvwquv0fArDs+RefOp1UhUNJH
         mUrB/M5hAT+SOR3/G9qf8niSCFptFVUjN0PJgPzWzPoVNYyMgLHDMIm372iPTNxiZSDD
         awTRGdOChHnBnTec34VteGJ6RYjJh6iZf6xksgzWMA10mIebD7PrqSyRnCXR2TDGsIIM
         HDGQdsyZWMoSRyWtbVO/KS/G9/CnA/FFJD6KaYa2T+58s9Fo+tBYIS/Sk7sK47486Unt
         b8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxcaaY2Ke+Y4K42xMdZnlgLPDpsSzCqwnxKiJt3NP5k=;
        b=G/dJbhMvrRoKl2csIGoyXgeAU3Ar/vAM/cH7dDqtsj7kKWhRMkN+p5JeKStmNV7v7k
         DgksXB1AEaXRvAw6Tklb8HHEm3b3ViDY2J+VmM30vq5IqeFobWc9yITnzhZGj/FwYlo1
         lWxiIf6C5Unqb1CUBTiD638d4zZFDc4yo3Gyy0rNlTocg5yVQzzGXaGnOKalM5wgTtHw
         CIpHn0mh65wEN9m4e+A16FeDwdytwG6/Av8rc+qIBiah8j9XJ+Wc+hlo9gBLatzSfnPY
         C4FCS5sDoGPTUvq9SZAPFMqlKEiHjfQsbxdYpV+Zoupy4+53Dm+tjIbtduw81kxlMD3n
         79FQ==
X-Gm-Message-State: APjAAAVFEtz615BzyhiqzMeksoDsFWTHtKKN2u/pfbdxnj4GFyzQ/j9k
        +iqPmMbTCz2xo1i6wXT6R2V8hnXL2nxG0YoY9AvCgg==
X-Google-Smtp-Source: APXvYqyUUSZ5uz/PGjaz46HTFBfDGGJ0PyhSvPLjx3ZMafS7jG2aTfn/SmFNmEG5ootwrHUedBxqO5KnbeM54xY1lpA=
X-Received: by 2002:a05:6808:10d:: with SMTP id b13mr4623826oie.69.1578702345240;
 Fri, 10 Jan 2020 16:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-4-guro@fb.com>
In-Reply-To: <20200109202659.752357-4-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:25:33 -0800
Message-ID: <CALvZod752NodBzTCW6bUPgasri6deQ6kHAtxx7eaKWb_sEmW6w@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mm: kmem: rename memcg_kmem_(un)charge() into memcg_kmem_(un)charge_page()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> Rename (__)memcg_kmem_(un)charge() into (__)memcg_kmem_(un)charge_page()
> to better reflect what they are actually doing:
> 1) call __memcg_kmem_(un)charge_memcg() to actually charge or
> uncharge the current memcg
> 2) set or clear the PageKmemcg flag
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
