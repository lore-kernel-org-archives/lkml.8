Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1FBC3B1BE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D27322314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A01RKV0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbgBNTMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:12:38 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38086 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388768AbgBNTMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:12:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id z9so10169810oth.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6uqzI/vJCb+lytMRQLBtmGBNvQ3CBGyQ4CHe99juhWw=;
        b=A01RKV0yUncA2zmUFntZswW/86rIj8tLC2M+AhXaShqxWykJDCkRYD43cXW50sXU39
         MAa7XyeI7GLjetxuKiKl6Z+csq3oWb/Ynl+99TLWkIoJSkpYl2aCL7j/cGo8BHzrvsd2
         8aySaepz0fQ2TgDbNN875+eReDdnjC93cTHaog9V5AwTUQwx8yb1iHjXkm3WNamm65pV
         hGFAn/wkc14F1h7uUo5Lzol4RTLd0WtY2Xogo92Ly7NncWyYlAwKRiui1jUZR5WcYhIt
         FXIzTf3dg9PluaRNFM74ih0l8HABOHZ+yTWC3VapgIcDQ1btBJ0IDtlJKNucSnOnbLig
         c0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6uqzI/vJCb+lytMRQLBtmGBNvQ3CBGyQ4CHe99juhWw=;
        b=e+fa00TW40u+NpCes3nKR1S80AC00T5eSu42GhS7lYnRGV4N3I/OI4IBiEMvh2fOqe
         oXdy5/+zgfZ52Yz6VnSSywAhN38Rt2OoHGOib5lzBwAgV17MM96tOlQp+A+89RnOG9zD
         ErEXyse7WBDlDwbfk7TfJkW8LaVFY9lIj3JVL1Itt1sG+nWzYE8/7hk8U+mccSfedGnH
         QgDKbaKuYFGtHjsdvYXI0BgHN4jddrxPs/9T00CNwImRr35z5DSUtqVyVM/ddRNwKiPu
         WqNUD3TbC064eA2TS+/M448NmcpSuXaHhN4kzKRqHT0bb1ZA48mLT7L/ma3INemtJld1
         W8dA==
X-Gm-Message-State: APjAAAVUsScjbG4gndlwQQYOTE0uBkY91GQHb80kylUEOr3OQ2KkdUrV
        fVYEbJLHu8txauAhGwN8foeotQZ3FqFFl3evOhkaFA==
X-Google-Smtp-Source: APXvYqw9Sh4U5QH4PzNP9ZbTWhW45tXHy/W8ePIQAS0ykZLvuNQTIJlI1t1RupZqm8jvXOKMHeZWx2pyg/XWkHVOixM=
X-Received: by 2002:a05:6830:1d6e:: with SMTP id l14mr3411629oti.32.1581707524096;
 Fri, 14 Feb 2020 11:12:04 -0800 (PST)
MIME-Version: 1.0
References: <20200214183554.1133805-1-christian.brauner@ubuntu.com> <20200214183554.1133805-5-christian.brauner@ubuntu.com>
In-Reply-To: <20200214183554.1133805-5-christian.brauner@ubuntu.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 14 Feb 2020 20:11:36 +0100
Message-ID: <CAG48ez2o81ZwwL9muYyheN9vY69vJR5sB9LsLh=nk6wB4iuUgw@mail.gmail.com>
Subject: Re: [PATCH v2 04/28] fsuidgid: add fsid mapping helpers
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

On Fri, Feb 14, 2020 at 7:37 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> This adds a set of helpers to translate between kfsuid/kfsgid and their
> userspace fsuid/fsgid counter parts relative to a given user namespace.
>
> - kuid_t make_kfsuid(struct user_namespace *from, uid_t fsuid)
>   Maps a user-namespace fsuid pair into a kfsuid.
>   If no fsuid mappings have been written it behaves identical to calling
>   make_kuid(). This ensures backwards compatibility for workloads unaware
>   or not in need of fsid mappings.
[...]
> +#ifdef CONFIG_USER_NS_FSID
> +/**
> + *     make_kfsuid - Map a user-namespace fsuid pair into a kuid.
> + *     @ns:  User namespace that the fsuid is in
> + *     @fsuid: User identifier
> + *
> + *     Maps a user-namespace fsuid pair into a kernel internal kfsuid,
> + *     and returns that kfsuid.
> + *
> + *     When there is no mapping defined for the user-namespace kfsuid
> + *     pair INVALID_UID is returned.  Callers are expected to test
> + *     for and handle INVALID_UID being returned.  INVALID_UID
> + *     may be tested for using uid_valid().
> + */
> +kuid_t make_kfsuid(struct user_namespace *ns, uid_t fsuid)
> +{
> +       unsigned extents = ns->fsuid_map.nr_extents;
> +       smp_rmb();
> +
> +       /* Map the fsuid to a global kernel fsuid */
> +       if (extents == 0)
> +               return KUIDT_INIT(map_id_down(&ns->uid_map, fsuid));
> +
> +       return KUIDT_INIT(map_id_down(&ns->fsuid_map, fsuid));
> +}
> +EXPORT_SYMBOL(make_kfsuid);

What effect is this fallback going to have for nested namespaces?

Let's say we have an outer namespace N1 with this uid_map:

    0 100000 65535

and with this fsuid_map:

    0 300000 65535

Now from in there, a process that is not aware of the existence of
fsuid mappings creates a new user namespace N2 with the following
uid_map:

    0 1000 1

At this point, if a process in N2 does chown("foo", 0, 0), is that
going to make "foo" owned by kuid 101000, which isn't even mapped in
N1?

> @@ -1215,11 +1376,13 @@ static bool new_idmap_permitted(const struct file *file,
>             uid_eq(ns->owner, cred->euid)) {
>                 u32 id = new_map->extent[0].lower_first;
>                 if (cap_setid == CAP_SETUID) {
> -                       kuid_t uid = make_kuid(ns->parent, id);
> +                       kuid_t uid = map_fsid ? make_kfsuid(ns->parent, id) :
> +                                               make_kuid(ns->parent, id);
>                         if (uid_eq(uid, cred->euid))
>                                 return true;

Let's say we have an outer user namespace N1 with this uid_map:

    0 1000 3000

and this fsuid_map:

    0 2000 3000

and in that namespace, a process is running as UID 1000 (which means
kernel-euid=2000, kernel-fsuid=3000). Now this process unshares its
user namespace and from this nested user namespace N2, tries to write
the following fsuid_map:

    0 1000 1

This should work, since the only ID it maps is the one the process had
in N1; but the code is AFAICS going to run as follows:

        if ((new_map->nr_extents == 1) && (new_map->extent[0].count == 1) &&
            uid_eq(ns->owner, cred->euid)) { // branch taken
                u32 id = new_map->extent[0].lower_first;
                if (cap_setid == CAP_SETUID) { // branch taken
                        // uid = make_kfsuid(ns->parent, 1000) = 3000
                        kuid_t uid = map_fsid ? make_kfsuid(ns->parent, id) :
                                                make_kuid(ns->parent, id);
                        // uid_eq(3000, 2000)
                        if (uid_eq(uid, cred->euid)) // not taken
                                return true;
                } else [...]
        }

Instead, I think what would succeed is this, which shouldn't be allowed:

    0 0 1

which AFAICS will evaluate as follows:

        if ((new_map->nr_extents == 1) && (new_map->extent[0].count == 1) &&
            uid_eq(ns->owner, cred->euid)) { // branch taken
                u32 id = new_map->extent[0].lower_first;
                if (cap_setid == CAP_SETUID) { // branch taken
                        // uid = make_kfsuid(ns->parent, 0) = 2000
                        kuid_t uid = map_fsid ? make_kfsuid(ns->parent, id) :
                                                make_kuid(ns->parent, id);
                        // uid_eq(2000, 2000)
                        if (uid_eq(uid, cred->euid)) // taken
                                return true;
                } else [...]
        }

>                 } else if (cap_setid == CAP_SETGID) {
> -                       kgid_t gid = make_kgid(ns->parent, id);
> +                       kgid_t gid = map_fsid ? make_kfsgid(ns->parent, id) :
> +                                               make_kgid(ns->parent, id);
>                         if (!(ns->flags & USERNS_SETGROUPS_ALLOWED) &&
>                             gid_eq(gid, cred->egid))
>                                 return true;
> --
> 2.25.0
>
