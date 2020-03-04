Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 983C4C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB821739
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="M6T8IJrP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgCDQLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:11:11 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40556 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:11:10 -0500
Received: by mail-io1-f68.google.com with SMTP id m22so2997791ioj.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=M6T8IJrP2imFH0Yrd72S712RTyLiBCBZZIWukQqQGCNrzxUDeKQu+PKXQBiP9CDW2H
         mlHwDsX+W9ASgLJqXkUJnHsYp6dMv5PNAIM+ZT80/uVANpT/Tbmh4N59WO3elb0FAsQC
         gfqYvlbSsf1UyETpTERI2GLvpo1mqkHwGPlGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hMEhfSBOuHBIl6yeEV5DUSKkA5QymXhcDODBiotx5S4=;
        b=BtGlYogyNll2fGZV2qHK+YEiIfZnd0YoEhP8D7ByX0oO8E3iH4XU1Lj51ENLqfvsmP
         bdNgsQIpwG4jwGe9QTQXCtKehQDpQDgcH0RIRvlmA1lxkFJHOFq/WbdX8eBE9oiCOS0F
         qr738Gn0zyrDv8SNV7WXI/MCQS0Z0GKavXX1g92Ch8fUIszidajwL5ekbyOsTvc7LSWz
         ibxuTNKi+ySioxwhrHT6fprWYsLRKfuYKNX0nNFJF4l2jNJyHaJyTyq5l/NYG0u+jsoX
         ABMsthTN2HFeeYHOiZRKT4z9Pc+J0a4ADC8y2+0I4yJicKUxplP9OJWScAqtyIxnne2q
         B/3g==
X-Gm-Message-State: ANhLgQ00KWfGMNv7NKobxyAhH1Z7ZfDJ/kYPgX7w9AyFrpFedunruS4t
        h6R/QQ9OuESG++peMxm1JIC/q1s8t1w9c367Zt9jkQ==
X-Google-Smtp-Source: ADFU+vv3dF1eDGfu6HnlNnsm2H3QO09qbn9v3Km2uZitDG2c+ztP3h8bSrNDMa2kQSpJfI9anLFWwxmDff5HPQtsH5U=
X-Received: by 2002:a6b:f409:: with SMTP id i9mr2669177iog.212.1583338269532;
 Wed, 04 Mar 2020 08:11:09 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
In-Reply-To: <158230818859.2185128.8921928947340497977.stgit@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 4 Mar 2020 17:10:58 +0100
Message-ID: <CAJfpeguyyC=E51gJ3EkQjLsqjZ8Mt35Eu7f9cQtBJaTFEcxoRg@mail.gmail.com>
Subject: Re: [PATCH 10/17] fsinfo: Allow mount information to be queried [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 7:03 PM David Howells <dhowells@redhat.com> wrote:
 +
> +/*
> + * Return information about the submounts relative to path.
> + */
> +int fsinfo_generic_mount_children(struct path *path, struct fsinfo_context *ctx)
> +{
> +       struct fsinfo_mount_child record;
> +       struct mount *m, *child;
> +
> +       if (!path->mnt)
> +               return -ENODATA;
> +
> +       m = real_mount(path->mnt);
> +
> +       rcu_read_lock();
> +       list_for_each_entry_rcu(child, &m->mnt_mounts, mnt_child) {

mnt_mounts is not using _rcu primitives, so why is this rcu safe?

Thanks,
Miklos
