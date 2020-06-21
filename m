Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60FFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE159206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="f5VuQDlb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbgFUXx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgFUXx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:53:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB17C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:53:25 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id o38so2750773qtf.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 16:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=29S5n5cFCFjdw48F8E5lF+4uXMo0yMP9nKy7w8wvQ+Y=;
        b=f5VuQDlbvKj8rUOoozDjinBJr+Me79NYFGO4f/Zx/YJn+3axRDQMxfqJ0hrPEi/UeH
         ZQgIQ+v8JOy91rUNwUz/MZM+M+MxW8rcJrafYy0hKCmeTLK23oFsTJ+O9Icu2Mr/PFYw
         B+bw+XzBoqsBn875sIKpZMJncCPv6hQvFKfpEnkNkc6zByGZY3WxrSZE0FQJgM8lg64S
         yOm1DGSkSfgm7dyhBvXdk/GQU0YSxRJ5xQjsju1ZjGz3hdwb0oaLphQYcK3Tf3AsKkzy
         lbGdGaVkCueiQjzXZdFNY0m7P2BmJRlAsdXhsgEENRnj/wUklIetaqBwVKd6xzfti5hs
         HVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=29S5n5cFCFjdw48F8E5lF+4uXMo0yMP9nKy7w8wvQ+Y=;
        b=YsYMgiGOjYstjebugMXLbl398PxW6jVngI9+Och0Vf/70OKECPTsmKieV9Z+g+fELQ
         6AUMTmopTh4Ut3l0r3ZbwKqu+Euol6BtbgJhNaREfP3hdbX18P+LT+V2A+mpGW0Icohc
         Qk9CXR+pLPWbG+0bMdF9IVLFWypsnxek2lBR83+3AYjhE5kcvKUKddO1Jl1Hka3O1QKe
         OHQBIOY7c3Vv+MQ1LL9NYjyvPmGSN5q8zNvnXvEHJCRXXESVqeLIdbOxv7aPZRiz2zO3
         BT39ENzfX69qsCmUxm0rpMWZEL/3CoVwr3fQjJuwurzvc0clrIy2hQpw+PhS3n0Hb3ez
         bbXw==
X-Gm-Message-State: AOAM532j1/ona+uJ4D5WQ44NUqVUIsVFRpGUXaI8/yDhYjP7VuzEtUOy
        3e+72axk+/vsvYb70+W+NpxZFQ==
X-Google-Smtp-Source: ABdhPJy/2v8RAH18A7H3EfkEtd/nOZYIucA9+VJvjde1vrmRGy0ZrAdxCsoHYaAIWQlvH55SM4L6mQ==
X-Received: by 2002:ac8:2914:: with SMTP id y20mr14057953qty.30.1592783604838;
        Sun, 21 Jun 2020 16:53:24 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b4sm13161136qtp.63.2020.06.21.16.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 16:53:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 00/19] The new cgroup slab memory controller
Date:   Sun, 21 Jun 2020 19:53:23 -0400
Message-Id: <7DEA68BC-3B9A-46FA-8103-AE6B72324591@lca.pw>
References: <20200621233429.GA293939@carbon.DHCP.thefacebook.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com
In-Reply-To: <20200621233429.GA293939@carbon.DHCP.thefacebook.com>
To:     Roman Gushchin <guro@fb.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 21, 2020, at 7:34 PM, Roman Gushchin <guro@fb.com> wrote:
>=20
> My wild guess is that kmemleak is getting confused by modifying the lowest=

> bit of page->mem_cgroup/obhj_cgroups pointer:
>=20
> struct page {
>    ...
>    union {
>        struct mem_cgroup *mem_cgroup;
>        struct obj_cgroup **obj_cgroups;
>    };
>    ...
> }
>=20
> We're using the lowest bit to distinguish between a "normal" mem_cgroup
> pointer and a vector of obj_cgroup pointers.
>=20
> This pointer to obj_cgroup vector is saved only here, so if we're modifyin=
g
> the address, I guess it's what makes kmemleak think that there is a leak.
>=20
> Or do you have a real leak?

The point is that we can=E2=80=99t have a patchset in the current form to to=
tally render kmemleak useless with so many even false positives.

Anyway, this is rather easy to reproduce where I am able to reproduce on mul=
tiple bare-metal machines by just booting it.

# echo scan > /sys/kernel/debug/kmemleak
# cat /sys/kernel/debug/kmemleak=
