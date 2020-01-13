Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF884C33CAF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929B2207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZkS3aHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbgAMWVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:21:46 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728932AbgAMWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:21:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id h9so10533735otj.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ex3UFTMAEfhKx0guG0nwsJE0zOFUmspUTiiCdQZAYOo=;
        b=AZkS3aHZwBxsqylTsn1eEWpbfT0deg5vrOTs7LiyGB8g1lnK6FH2+UfYXBWvkY6ULv
         L2AahUncm3u08u2KnFq3IkcZNVLL+0q4Df/VS2nMgtdTEfhMV6UmkKoHEo30LFduORFW
         lNtWDDlPGuB18xsIfzirjOzb5FUEr8JVFbQ9lixTPZk9w8y2vYfwtQWfryXPkGPPJmEo
         tw1PmN8C9ibxP8UQDb/8CkVIA+vS9SZrs1AqtZyUwsA44pNP5dS4Vm06VWqn+YiWccoj
         7cM9PqJcK+T1kfuzzQlB+nt4mJ/rZmLAEFfmiWh12bHooq+Vhe2YKTYhcZvmM4l2p4UK
         Lc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ex3UFTMAEfhKx0guG0nwsJE0zOFUmspUTiiCdQZAYOo=;
        b=kPn/72rhW4PL1mX6I2KIh5qGUfDgmg9mFgyYfXiVXD4UaRCVd41eWdfJcfVjfGNZz9
         gDEJpxzIhYPtsjOLz3jAZGAVqa5hxbsx8IXN3Sk+8n+uXGZXfS4arlhOMk7TZapGlllr
         CkF6ykxGJ5U6LFHICs/f0i8qgfeoFVoe62JwIsHgnjR2RKPfuiBMhSWkeLa7lBLw0n2N
         0g8G76FCyTCg31wa+40bzXss95CkNvcOK6SdPOA4jj32w7Rastorh3EMsHzo4NlUftdf
         /CxO40Wz9MCDyYbE7KKu/4VZoTEJuvsQIqQ7Qw2H1EWXIYO3LiyZcHuosKwiMF5StJN7
         cBJg==
X-Gm-Message-State: APjAAAVABgf3mD4OKlzHnvm2q1BVHxACPY+2dH+g9tIdWfS1+lrDvgYk
        G2hz8Ak33A5iiJSL/gBsKsyXblC1oH65l56m4JrnUw==
X-Google-Smtp-Source: APXvYqyrwZQq75+I2BdkZCiafYfDDHWMS1tOXED+Q+CkQ89ZkgEcOJ+i4XsDk7VSWnoOQlqxRkrnw6Hl75zqF784lYs=
X-Received: by 2002:a9d:2c68:: with SMTP id f95mr15033850otb.33.1578954104459;
 Mon, 13 Jan 2020 14:21:44 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <817e2c4b-4c72-09f9-22ea-bbaf97584161@oracle.com> <CAHS8izNs24KOaRuQkVUuZZUh42rvkyBXJEJYrHNf9bLFnZEXCg@mail.gmail.com>
 <a78595a8-448c-14bb-a54b-9be685f36388@oracle.com>
In-Reply-To: <a78595a8-448c-14bb-a54b-9be685f36388@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 13 Jan 2020 14:21:33 -0800
Message-ID: <CAHS8izMT2vNASsR2H+3-4XN=+EkAEpS-LJ_UouaAa7iUfbLBhQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> On 12/17/19 3:16 PM, Mina Almasry wrote:
> >
> > The design we went with based on previous discussions is as follows:
> > hugetlb pages faulted without a prior reservation get accounted at
> > fault time, rather than reservation time, and if the fault causes the
> > counter to cross the limit, the charge fails, hence the fault fails,
> > hence the process gets sigbus'd.
>
> Ok, sorry I did not recall the design discussion.
>

No worries! It has indeed been a while since that discussion.

> > This means that one counter I'm adding here can cover both use cases:
> > if the userspace uses MAP_NORESERVE, then their memory is accounted at
> > fault time and they may get sigbus'd.
>
> Let's make sure this is clearly documented.  Someone could be surprised
> if their application not using reserves gets a SIGBUS because there is a
> reserve limit.

I have some stuff on that already in the docs patch, but I'll beef
that section up to ensure there is no confusion.
