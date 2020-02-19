Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA68C34055
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0297F2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tomtrQl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgBSQTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:19:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34842 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgBSQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 11:19:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id r16so689056otd.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 08:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hp2F1W8Z5yebZP9iufYiJ6AFdgufj77efxtq6/ay/Xk=;
        b=tomtrQl6RpRKwmUBNbEgTtGWBJAVFohcLwCx61e0sXqs18M/AgUvPtmuBlbrrp9sm6
         Cx4c+PZ9e6CScmNlnOQW5gtFueeSeC8Hc6p+g/1gIhGQ9lVCAbwIuIOqjoHnLnXPwRku
         xSebol9/Gmjyy+/e/vbkNu8YUIfWe/J8Rz7VSLVE1AFbfIJdLIeg952I7c2yErtlYLgz
         XAL/LOqi8T1ir1RiVzN/oVLRg05wAI2UMHlKTP+P7plTzBMiWi69f9TVNbJllvQBBlhv
         i+gb7uspY5LoxEnKPYeE44naIzvgRJW+nhqkOfQeZGZ5MlhhEkMGw5g9WHx/uvAdi2Pz
         BzzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hp2F1W8Z5yebZP9iufYiJ6AFdgufj77efxtq6/ay/Xk=;
        b=PZNzTyWlnZV6G/AZfWiz7Oeo6RsN8tBPObcYLiwkRNQWpXu1P6uLZ2fNxedbrorBso
         r3c5ynO8/QF1ywXphe8K4Sxq1d6KSQNlQgTaS+Qv6jI4YOy57/KMVvP+E+JOiHUPQvTV
         ndOwMbpjiylEVT6YnxcvWMmV1jMqCLfYjWGPry5LeQf5mw4ZN81KiPzgFwC8Nk3od0Zc
         H9duKvctY4BEY1AShAE/j8AgxxbTyONNbJLXDn5nOhukmcaZbtqYlZ5zNYq4byNRqXHW
         qMe+tOjeq6mBTwGyGfgdqjh5Dr+L00GGgEPf/Wt+v2ieWek184/MQsitgEqDokPp6OGL
         zNEg==
X-Gm-Message-State: APjAAAUgVyojWBvKbWl16iG45dgVe8/V/1/NhF8CLNS1pEHOsLTyJ/ab
        EpZKVaYOuCw7w8kPYmyix4JMd9ELHnhe6fFEJtjItg==
X-Google-Smtp-Source: APXvYqz9j+Ney28+R+WNTvikN6AJwjjyrG5NaFmWCBeChGSg04X/81XzMz5ZTyls3WnVMRPFjijYbLd7xZIoXgTGLDI=
X-Received: by 2002:a9d:5e8b:: with SMTP id f11mr6589632otl.110.1582129160469;
 Wed, 19 Feb 2020 08:19:20 -0800 (PST)
MIME-Version: 1.0
References: <20200218143411.2389182-1-christian.brauner@ubuntu.com> <20200218143411.2389182-7-christian.brauner@ubuntu.com>
In-Reply-To: <20200218143411.2389182-7-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 19 Feb 2020 17:18:54 +0100
Message-ID: <CAG48ez28VjU7+c_yrz6fLij+o9mS-psK-5s_zdGpJJ+3S=R3Tg@mail.gmail.com>
Subject: Re: [PATCH v3 06/25] user_namespace: make map_write() support fsid mappings
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Stephen Barber <smbarber@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Phil Estes <estesp@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 3:35 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> Based on discussions with Jann we decided in order to cleanly handle nested
> user namespaces that fsid mappings can only be written before the corresponding
> id mappings have been written. Writing id mappings before writing the
> corresponding fsid mappings causes fsid mappings to mirror id mappings.
>
> Consider creating a user namespace NS1 with the initial user namespace as
> parent. Assume NS1 receives id mapping 0 100000 100000 and fsid mappings 0
> 300000 100000. Files that root in NS1 will create will map to kfsuid=300000 and
> kfsgid=300000 and will hence be owned by uid=300000 and gid 300000 on-disk in
> the initial user namespace.
> Now assume user namespace NS2 is created in user namespace NS1. Assume that NS2
> receives id mapping 0 10000 65536 and an fsid mapping of 0 10000 65536. Files
> that root in NS2 will create will map to kfsuid=10000 and kfsgid=10000 in NS1.
> hence, files created by NS2 will hence be appear to be be owned by uid=10000
> and gid=10000 on-disk in NS1. Looking at the initial user namespace, files
> created by NS2 will map to kfsuid=310000 and kfsgid=310000 and hence will be
> owned by uid=310000 and gid=310000 on-disk.
[...]
>  static bool new_idmap_permitted(const struct file *file,
>                                 struct user_namespace *ns, int cap_setid,
> -                               struct uid_gid_map *new_map)
> +                               struct uid_gid_map *new_map,
> +                               enum idmap_type idmap_type)
>  {
>         const struct cred *cred = file->f_cred;
> +
> +       /* Don't allow writing fsuid maps when uid maps have been written. */
> +       if (idmap_type == FSUID_MAP && idmap_exists(&ns->uid_map))
> +               return false;
> +
> +       /* Don't allow writing fsgid maps when gid maps have been written. */
> +       if (idmap_type == FSGID_MAP && idmap_exists(&ns->gid_map))
> +               return false;

Why are these checks necessary? Shouldn't an fs*id map have already
been implicitly created?
