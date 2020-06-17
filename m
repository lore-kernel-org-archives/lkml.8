Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0EEC2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="opcJEqdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgFQDFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgFQDFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:05:53 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8921BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:05:52 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c17so974731lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tQx8E/fB3k29lyIQ38d8XnedyxWcLShKOFMHcE8vB1Q=;
        b=opcJEqdqdKrRLwNOEgXE+/VJFQOuvOpk+ey32Q6SBcm876qMXsBjwbTgbhOK5acdSh
         cV5AmOUj1y1k3NmLM4+bqr3wtrh74f8Ac6u6UEBm+8YHixwc8lK6jkr95aN9tAT7XHXg
         R9SN2gzPZO4/abwtjG1aMYs74ftgPXqYbMMqsnDPyWq+W5rxRiYysGIa0gAE7qVNliUo
         2HmEssQz0XgQW+IQeaRqpmePHNjP2fBzFdeGEWkEaFJ0W6SmAXbQdQXF/hOH8uTl/UWk
         Is4oxxrhgYVh5x4iATLKwfDT4K+54sdGm4aUSSudzT46352RORBCv+ay7vG7rvewcK16
         A37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tQx8E/fB3k29lyIQ38d8XnedyxWcLShKOFMHcE8vB1Q=;
        b=KzVFSUKt+8fvNfvrW8e+07ZCgDfZ7a+hy0QOOdiHqa0ahlJ55wGRDA0qy9ZQ+aOWi6
         wo6t+3Y1/ewpLcQvNkwa6Q2HYfkFaL650vLFf9ZZ+tMhxOTM32TiJ1vYxBJHNMXvcfKp
         oMJS/rkpIplNiPynaztF5nhNA3BHg0JvGSI5snXQ4UG7G9/DK47PgJMkta4hmSl4TMjR
         Kx7f6CxGBjvASaXXnZJ7oNyR2sdQvgzx3vUx7/R82hiYTJBEzWkcKih7XJBmfkJkU38E
         9mojDG/e8dQs6wrrQ72XYpF1B/0NUiWgNas9kdiKPSp3H2TF7JKQUEw6LBbG3HfM3jYM
         s6pw==
X-Gm-Message-State: AOAM533FyhK7oUjiiPhzeRc6Hmwb5tpOly3Lv+62Za8YgyBcCbcGvr2y
        x1kE5ge/P3KDax90bJ8YBu/FNlBeV0Ql+wdGQQDoxg==
X-Google-Smtp-Source: ABdhPJzg35tT8uYQ9Br0aeQHkR+wNCa2X7Tul4YFymy+TjNnZEQjHWKVv1JhrHhCDG4J7heNuJY2c9s7DEVWLpkPZiU=
X-Received: by 2002:a2e:960b:: with SMTP id v11mr2874001ljh.77.1592363150545;
 Tue, 16 Jun 2020 20:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <CALvZod7ThL=yMwxzCLvrTtq=+Dr5ooUSX-iFP8AhiAGURByFBA@mail.gmail.com>
 <20200617024147.GA10812@carbon.lan>
In-Reply-To: <20200617024147.GA10812@carbon.lan>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 20:05:39 -0700
Message-ID: <CALvZod4vLQb4kns=ao8btL_g--9axZfcaxhMnj+CoTrCkyWoWQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
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

On Tue, Jun 16, 2020 at 7:41 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jun 16, 2020 at 06:46:56PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
[...]
> >
> > Have you performed any [perf] testing on SLAB with this patchset?
>
> The accounting part is the same for SLAB and SLUB, so there should be no
> significant difference. I've checked that it compiles, boots and passes
> kselftests. And that memory savings are there.
>

What about performance? Also you mentioned that sharing kmem-cache
between accounted and non-accounted can have additional overhead. Any
difference between SLAB and SLUB for such a case?
