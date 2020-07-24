Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A246CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3B0206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595618081;
	bh=mTNy4KGrVM+aIgZL67PxvnR4jqHaeUoAL14mxcqNmCk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qomIoD+KjmObpWZxum3bt45g84SHBTAXzo3OyWkMTboa297w9REVaxySFikmQRDNi
	 tzgre2PcNBksFnUrT6IPFvTRhv5N+XkA3ROOH+QjCrTy/exU7r36qUte4PFF+cFpOD
	 ME6bwIL/FWtN3AxpClsxF41+pm1kRKWArkYDSuiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXTOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXTOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:14:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3011CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so11085024lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=BmStlzF53IfQFR9lW1QEwB6WtPaCTo8kB/5l2ZVbvkNCRtpkKknR7R7gwnINKZMYbo
         9roTE/qL7vaPo+Cyso47Tup2l6wwhF0x/6bkHDYtEfCuAEAXNXPJrsNboG8KVxzjNeDZ
         VsPfwtpzBsiG/8I7JDAyVredl46a3Ru8+ROxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=td+POTQLbLYOoIxNCct7GsW10BBA9n/4Q5dVUic9E/Y=;
        b=BJ270DP3vTCYkckJSINSiByIHedpKERRN9X6Ma4DhZA1mlUrQvFuTo6ziHW2tTbv/I
         jRxHtYSIpgdLPjFUttRm+fcOFR1XUM3iiHY9ajQhPZ1dy5H+V3eSMWtkF3j4QJwosFkV
         KrTDZWS/xzc4Ey8G9xx3TDqC6EYu+IOhPYiQqlIoEtqmSi86rgmSl9fhUNKHOspi4aRf
         5qdU513+iw8t/4Y+FebEqGqoDpuaHt7oycPRg59F9jV5zPfTQuCPoRkIsK2Yz+4ZAH6O
         GLSBmbEryIaNts2mpcwpt6MrXCwmJOytVe8hhevPA5abdmHOdxzDNxYR9BEx9oNZFAF/
         jSfw==
X-Gm-Message-State: AOAM532n1AsD9pPnnvtSByyvDdGC4iWX7OYbO18fGfswVcQZscXKlJMK
        12HW2H9whRSk3HQCtVFef9bD4WwYGaE=
X-Google-Smtp-Source: ABdhPJycmn3m4TRX4VhgzRN3z1I1qA7oURPNAWFeQ8lXNss+9cVjruiHuWq+wxdzxI+TdQyR19ucsw==
X-Received: by 2002:a2e:8157:: with SMTP id t23mr5223007ljg.417.1595618077138;
        Fri, 24 Jul 2020 12:14:37 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id m1sm513676lfa.22.2020.07.24.12.14.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 12:14:36 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 185so845547ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr5228146ljj.312.1595618075547;
 Fri, 24 Jul 2020 12:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <159559628247.2141315.2107013106060144287.stgit@warthog.procyon.org.uk>
 <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
In-Reply-To: <159559630912.2141315.16186899692832741137.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Jul 2020 12:14:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Message-ID: <CAHk-=wjnQArU_BewVKQgYHy2mQD6LNKC5kkKXOm7GpNkJCapQg@mail.gmail.com>
Subject: Re: [PATCH 3/4] watch_queue: Implement mount topology and attribute
 change notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        Jeff Layton <jlayton@redhat.com>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just can't be right.

On Fri, Jul 24, 2020 at 6:12 AM David Howells <dhowells@redhat.com> wrote:
>
> +
> +/**
> + * sys_watch_mount - Watch for mount topology/attribute changes
> + * @dfd: Base directory to pathwalk from or fd referring to mount.
> + * @filename: Path to mount to place the watch upon
> + * @at_flags: Pathwalk control flags
> + * @watch_fd: The watch queue to send notifications to.
> + * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
> + */
> +SYSCALL_DEFINE5(watch_mount, [...]
> +               int, watch_id)
...
> +       if (watch_id < -1 || watch_id > 0xff)
> +               return -EINVAL;
...
> +       ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
> +       if (ret)
> +               goto err_path;
...
> +       if (watch_id >= 0) {
...
> +               watch = kzalloc(sizeof(*watch), GFP_KERNEL);
> +               if (!watch)
> +                       goto err_wlist;

So now you can basically allocate as much kernel memory as you want as
a regular user, as long as you have a mounted directory you can walk
(ie everybody).

Is there any limiting of watches anywhere? I don't see it.

I notice we already have this pattern elsewhere. I think we need to
fix this before we add more watch types.

Watch allocation shouldn't just be a kzalloc(). I think you should
have a "watch_allocate()" that does the initialization of id etc, but
also does some basic per-user watch resource tracking or something.

              Linus
