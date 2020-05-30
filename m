Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8734C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2CD2076B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 21:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLYdpQiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgE3VvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 17:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729083AbgE3VvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 17:51:20 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF4AC03E969;
        Sat, 30 May 2020 14:51:20 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id y13so982728ybj.10;
        Sat, 30 May 2020 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIf1R7KNMKly1OunPkFsM3ZN+pn2lCpx2kMTxhypa3E=;
        b=WLYdpQiMtwlWPSQovs1WC63Gy4e5IZopf2DAUhJ1qI5X00+HfOEYFG3SBtkBUfEwyg
         H/8gZizQi5/yGDPcJHsxJmO45n6CihpV5UAi//q1RtteIu3BfwSk5tLqfm6UXNKG7biy
         O/J7ThvY455EaCZNSo6q/kf5nQk50j/3l5bOBBdTQoEVGnfanLuAvuOrqjNTqQ7XnKsM
         kN8yA1vIsDcFy3+F0MJinjd+5+E9kxkoTE2lUJKWZX3ymRlJmFiC7d5g2KWxXPvVxke5
         XSgic2LK/ajzUD5+cYueFK/ML15Dy5xAvQCmLqBWaf0kbaIC0ZhnD5Fwjhr3aOZhc9kr
         UC4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIf1R7KNMKly1OunPkFsM3ZN+pn2lCpx2kMTxhypa3E=;
        b=PGnfMbH8Qz/EMRbqG8sqTKEt/JAkigDHbu4uMm3LJRT50GsXYWGlSclXva52Guxc9D
         Eu6q6CzIgo81vgI7bP3zaDoojfsFhIxP3rVqePer9ex4lbgIiHcazP+p/ezs6Ll42V3W
         8BzSUHQ+53MzvDQC8WgotDPUfD1h0NyS98Q8u8ioaC5bayciUUHbconqrLXZ1wrXy7SN
         zeLU8VyV307eGCOVNCFXpgbHVn1bv4T70lbWLROsbjZJncsnwf6IAQjddAGJMmpcdgIn
         RR/uhHCbn6l95oP38LUis4bjhMOavNfQHGgzL36eqHf7o1UvgCjCxfu9NJO+eNfjsUZp
         OINg==
X-Gm-Message-State: AOAM533wnajGzXgE/1SSNwMf+7ixGEr5yXp3mrRTgu+tybqqMCwW+NA7
        qKAzGpvzYkGCohM8v8753IyAAMoTYab83pUfbOA=
X-Google-Smtp-Source: ABdhPJzRV81zy0SGnPyvaf5BX/MzHkZG2CSFU/UxatIqQqPrx2WZMLa+i9T1CZKHdyMsew8hNd2OqL6NZZHs1nOHcFI=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr25294089ybg.376.1590875477225;
 Sat, 30 May 2020 14:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <f826fa221d6971959118d8e0bc6c294b33c7d7c1.1586929128.git.joe@perches.com>
In-Reply-To: <f826fa221d6971959118d8e0bc6c294b33c7d7c1.1586929128.git.joe@perches.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 30 May 2020 16:51:05 -0500
Message-ID: <CAH2r5msgqE1zEqHZ804MNSHJELZt1z_1R9wDXgH1GCmDTT0+VA@mail.gmail.com>
Subject: Re: [PATCH] cifs: Standardize logging output
To:     Joe Perches <joe@perches.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000b3ccc705a6e48f5d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000b3ccc705a6e48f5d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

tentatively merged into cifs-2.6.git for-next but had to clean it up
to avoid merge conflicts.

Minor followon patch (attached) to add the two remaining ones that Joe
pointed out that.

On Wed, Apr 15, 2020 at 12:46 AM Joe Perches via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> Use pr_fmt to standardize all logging for fs/cifs.
>
> Some logging output had no CIFS: specific prefix.
>
> Now all output has one of three prefixes:
>
> o CIFS:
> o CIFS: VFS:
> o Root-CIFS:
>
> Miscellanea:
>
> o Convert printks to pr_<level>
> o Neaten macro definitions
> o Remove embedded CIFS: prefixes from formats
> o Convert "illegal" to "invalid"
> o Coalesce formats
> o Add missing '\n' format terminations
> o Consolidate multiple cifs_dbg continuations into single calls
> o More consistent use of upper case first word output logging
> o Multiline statement argument alignment and wrapping
>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  fs/cifs/cifs_debug.h  | 145 ++++++++++++++++++-------------------
>  fs/cifs/cifsencrypt.c |   8 +-
>  fs/cifs/cifsproto.h   |  26 +++----
>  fs/cifs/cifsroot.c    |   6 +-
>  fs/cifs/cifssmb.c     |  26 +++----
>  fs/cifs/connect.c     |  77 ++++++++------------
>  fs/cifs/dfs_cache.c   |  14 ++--
>  fs/cifs/file.c        |  24 +++---
>  fs/cifs/inode.c       |   4 +-
>  fs/cifs/misc.c        |  12 +--
>  fs/cifs/netmisc.c     |   6 +-
>  fs/cifs/readdir.c     |  10 +--
>  fs/cifs/sess.c        |  28 +++----
>  fs/cifs/smb1ops.c     |   2 +-
>  fs/cifs/smb2inode.c   |   3 +-
>  fs/cifs/smb2misc.c    |  20 ++---
>  fs/cifs/smb2ops.c     |  31 ++++----
>  fs/cifs/smb2pdu.c     |  72 +++++++++---------
>  fs/cifs/smbdirect.c   | 165 +++++++++++++++++-------------------------
>  fs/cifs/transport.c   |  25 +++----
>  20 files changed, 321 insertions(+), 383 deletions(-)
>
> diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
> index 100b00..5e66da 100644
> --- a/fs/cifs/cifs_debug.h
> +++ b/fs/cifs/cifs_debug.h
> @@ -8,6 +8,12 @@
>  #ifndef _H_CIFS_DEBUG
>  #define _H_CIFS_DEBUG
>
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +
> +#define pr_fmt(fmt) "CIFS: " fmt
> +
>  void cifs_dump_mem(char *label, void *data, int length);
>  void cifs_dump_detail(void *buf, struct TCP_Server_Info *ptcp_info);
>  void cifs_dump_mids(struct TCP_Server_Info *);
> @@ -46,92 +52,81 @@ extern int cifsFYI;
>   */
>
>  /* Information level messages, minor events */
> -#define cifs_info_func(ratefunc, fmt, ...)                     \
> -do {                                                           \
> -       pr_info_ ## ratefunc("CIFS: " fmt, ##__VA_ARGS__);      \
> -} while (0)
> +#define cifs_info_func(ratefunc, fmt, ...)                             \
> +       pr_info_ ## ratefunc(fmt, ##__VA_ARGS__)
>
> -#define cifs_info(fmt, ...)                                    \
> -do {                                                           \
> -       cifs_info_func(ratelimited, fmt, ##__VA_ARGS__);        \
> -} while (0)
> +#define cifs_info(fmt, ...)                                            \
> +       cifs_info_func(ratelimited, fmt, ##__VA_ARGS__)
>
>  /* information message: e.g., configuration, major event */
> -#define cifs_dbg_func(ratefunc, type, fmt, ...)                        \
> -do {                                                           \
> -       if ((type) & FYI && cifsFYI & CIFS_INFO) {              \
> -               pr_debug_ ## ratefunc("%s: "                    \
> -                               fmt, __FILE__, ##__VA_ARGS__);  \
> -       } else if ((type) & VFS) {                              \
> -               pr_err_ ## ratefunc("CIFS VFS: "                \
> -                                fmt, ##__VA_ARGS__);           \
> -       } else if ((type) & NOISY && (NOISY !=3D 0)) {            \
> -               pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);      \
> -       }                                                       \
> +#define cifs_dbg_func(ratefunc, type, fmt, ...)                         =
       \
> +do {                                                                   \
> +       if ((type) & FYI && cifsFYI & CIFS_INFO) {                      \
> +               pr_debug_ ## ratefunc("%s: " fmt,                       \
> +                                     __FILE__, ##__VA_ARGS__);         \
> +       } else if ((type) & VFS) {                                      \
> +               pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
> +       } else if ((type) & NOISY && (NOISY !=3D 0)) {                   =
 \
> +               pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
> +       }                                                               \
>  } while (0)
>
> -#define cifs_dbg(type, fmt, ...) \
> -do {                                                   \
> -       if ((type) & ONCE)                              \
> -               cifs_dbg_func(once,                     \
> -                        type, fmt, ##__VA_ARGS__);     \
> -       else                                            \
> -               cifs_dbg_func(ratelimited,              \
> -                       type, fmt, ##__VA_ARGS__);      \
> +#define cifs_dbg(type, fmt, ...)                                       \
> +do {                                                                   \
> +       if ((type) & ONCE)                                              \
> +               cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
> +       else                                                            \
> +               cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
>  } while (0)
>
> -#define cifs_server_dbg_func(ratefunc, type, fmt, ...)         \
> -do {                                                           \
> -       const char *sn =3D "";                                    \
> -       if (server && server->hostname)                         \
> -               sn =3D server->hostname;                          \
> -       if ((type) & FYI && cifsFYI & CIFS_INFO) {              \
> -               pr_debug_ ## ratefunc("%s: \\\\%s "     fmt,    \
> -                       __FILE__, sn, ##__VA_ARGS__);           \
> -       } else if ((type) & VFS) {                              \
> -               pr_err_ ## ratefunc("CIFS VFS: \\\\%s " fmt,    \
> -                       sn, ##__VA_ARGS__);                     \
> -       } else if ((type) & NOISY && (NOISY !=3D 0)) {            \
> -               pr_debug_ ## ratefunc("\\\\%s " fmt,            \
> -                       sn, ##__VA_ARGS__);                     \
> -       }                                                       \
> +#define cifs_server_dbg_func(ratefunc, type, fmt, ...)                 \
> +do {                                                                   \
> +       const char *sn =3D "";                                           =
 \
> +       if (server && server->hostname)                                 \
> +               sn =3D server->hostname;                                 =
 \
> +       if ((type) & FYI && cifsFYI & CIFS_INFO) {                      \
> +               pr_debug_ ## ratefunc("%s: \\\\%s " fmt,                \
> +                                     __FILE__, sn, ##__VA_ARGS__);     \
> +       } else if ((type) & VFS) {                                      \
> +               pr_err_ ## ratefunc("VFS: \\\\%s " fmt,                 \
> +                                   sn, ##__VA_ARGS__);                 \
> +       } else if ((type) & NOISY && (NOISY !=3D 0)) {                   =
 \
> +               pr_debug_ ## ratefunc("\\\\%s " fmt,                    \
> +                                     sn, ##__VA_ARGS__);               \
> +       }                                                               \
>  } while (0)
>
> -#define cifs_server_dbg(type, fmt, ...)                        \
> -do {                                                   \
> -       if ((type) & ONCE)                              \
> -               cifs_server_dbg_func(once,              \
> -                       type, fmt, ##__VA_ARGS__);      \
> -       else                                            \
> -               cifs_server_dbg_func(ratelimited,       \
> -                       type, fmt, ##__VA_ARGS__);      \
> +#define cifs_server_dbg(type, fmt, ...)                                 =
       \
> +do {                                                                   \
> +       if ((type) & ONCE)                                              \
> +               cifs_server_dbg_func(once, type, fmt, ##__VA_ARGS__);   \
> +       else                                                            \
> +               cifs_server_dbg_func(ratelimited, type, fmt,            \
> +                                    ##__VA_ARGS__);                    \
>  } while (0)
>
> -#define cifs_tcon_dbg_func(ratefunc, type, fmt, ...)           \
> -do {                                                           \
> -       const char *tn =3D "";                                    \
> -       if (tcon && tcon->treeName)                             \
> -               tn =3D tcon->treeName;                            \
> -       if ((type) & FYI && cifsFYI & CIFS_INFO) {              \
> -               pr_debug_ ## ratefunc("%s: %s " fmt,            \
> -                       __FILE__, tn, ##__VA_ARGS__);           \
> -       } else if ((type) & VFS) {                              \
> -               pr_err_ ## ratefunc("CIFS VFS: %s " fmt,        \
> -                       tn, ##__VA_ARGS__);                     \
> -       } else if ((type) & NOISY && (NOISY !=3D 0)) {            \
> -               pr_debug_ ## ratefunc("%s " fmt,                \
> -                       tn, ##__VA_ARGS__);                     \
> -       }                                                       \
> +#define cifs_tcon_dbg_func(ratefunc, type, fmt, ...)                   \
> +do {                                                                   \
> +       const char *tn =3D "";                                           =
 \
> +       if (tcon && tcon->treeName)                                     \
> +               tn =3D tcon->treeName;                                   =
 \
> +       if ((type) & FYI && cifsFYI & CIFS_INFO) {                      \
> +               pr_debug_ ## ratefunc("%s: %s " fmt,                    \
> +                                     __FILE__, tn, ##__VA_ARGS__);     \
> +       } else if ((type) & VFS) {                                      \
> +               pr_err_ ## ratefunc("VFS: %s " fmt, tn, ##__VA_ARGS__); \
> +       } else if ((type) & NOISY && (NOISY !=3D 0)) {                   =
 \
> +               pr_debug_ ## ratefunc("%s " fmt, tn, ##__VA_ARGS__);    \
> +       }                                                               \
>  } while (0)
>
> -#define cifs_tcon_dbg(type, fmt, ...)                  \
> -do {                                                   \
> -       if ((type) & ONCE)                              \
> -               cifs_tcon_dbg_func(once,                \
> -                       type, fmt, ##__VA_ARGS__);      \
> -       else                                            \
> -               cifs_tcon_dbg_func(ratelimited, \
> -                       type, fmt, ##__VA_ARGS__);      \
> +#define cifs_tcon_dbg(type, fmt, ...)                                  \
> +do {                                                                   \
> +       if ((type) & ONCE)                                              \
> +               cifs_tcon_dbg_func(once, type, fmt, ##__VA_ARGS__);     \
> +       else                                                            \
> +               cifs_tcon_dbg_func(ratelimited, type, fmt,              \
> +                                  ##__VA_ARGS__);                      \
>  } while (0)
>
>  /*
> @@ -159,9 +154,7 @@ do {                                                 =
                       \
>  } while (0)
>
>  #define cifs_info(fmt, ...)                                            \
> -do {                                                                   \
> -       pr_info("CIFS: "fmt, ##__VA_ARGS__);                            \
> -} while (0)
> +       pr_info(fmt, ##__VA_ARGS__)
>  #endif
>
>  #endif                         /* _H_CIFS_DEBUG */
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index 97b749..874a55 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -520,7 +520,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, cha=
r *ntlmv2_hash,
>
>         rc =3D crypto_shash_init(&ses->server->secmech.sdeschmacmd5->shas=
h);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: could not init hmacmd5\n", __func__);
> +               cifs_dbg(VFS, "%s: Could not init hmacmd5\n", __func__);
>                 return rc;
>         }
>
> @@ -624,7 +624,7 @@ CalcNTLMv2_response(const struct cifs_ses *ses, char =
*ntlmv2_hash)
>
>         rc =3D crypto_shash_init(&ses->server->secmech.sdeschmacmd5->shas=
h);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: could not init hmacmd5\n", __func__);
> +               cifs_dbg(VFS, "%s: Could not init hmacmd5\n", __func__);
>                 return rc;
>         }
>
> @@ -723,7 +723,7 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct n=
ls_table *nls_cp)
>         /* calculate ntlmv2_hash */
>         rc =3D calc_ntlmv2_hash(ses, ntlmv2_hash, nls_cp);
>         if (rc) {
> -               cifs_dbg(VFS, "could not get v2 hash rc %d\n", rc);
> +               cifs_dbg(VFS, "Could not get v2 hash rc %d\n", rc);
>                 goto unlock;
>         }
>
> @@ -783,7 +783,7 @@ calc_seckey(struct cifs_ses *ses)
>
>         ctx_arc4 =3D kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
>         if (!ctx_arc4) {
> -               cifs_dbg(VFS, "could not allocate arc4 context\n");
> +               cifs_dbg(VFS, "Could not allocate arc4 context\n");
>                 return -ENOMEM;
>         }
>
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index 12a895..530d0b 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -45,25 +45,25 @@ extern int smb_send(struct TCP_Server_Info *, struct =
smb_hdr *,
>                         unsigned int /* length */);
>  extern unsigned int _get_xid(void);
>  extern void _free_xid(unsigned int);
> -#define get_xid()                                              \
> -({                                                             \
> +#define get_xid()                                                      \
> +({                                                                     \
>         unsigned int __xid =3D _get_xid();                               =
 \
> -       cifs_dbg(FYI, "CIFS VFS: in %s as Xid: %u with uid: %d\n",      \
> +       cifs_dbg(FYI, "VFS: in %s as Xid: %u with uid: %d\n",           \
>                  __func__, __xid,                                       \
>                  from_kuid(&init_user_ns, current_fsuid()));            \
> -       trace_smb3_enter(__xid, __func__);                      \
> -       __xid;                                                  \
> +       trace_smb3_enter(__xid, __func__);                              \
> +       __xid;                                                          \
>  })
>
> -#define free_xid(curr_xid)                                     \
> -do {                                                           \
> -       _free_xid(curr_xid);                                    \
> -       cifs_dbg(FYI, "CIFS VFS: leaving %s (xid =3D %u) rc =3D %d\n",   =
   \
> -                __func__, curr_xid, (int)rc);                  \
> -       if (rc)                                                 \
> +#define free_xid(curr_xid)                                             \
> +do {                                                                   \
> +       _free_xid(curr_xid);                                            \
> +       cifs_dbg(FYI, "VFS: leaving %s (xid =3D %u) rc =3D %d\n",        =
   \
> +                __func__, curr_xid, (int)rc);                          \
> +       if (rc)                                                         \
>                 trace_smb3_exit_err(curr_xid, __func__, (int)rc);       \
> -       else                                                    \
> -               trace_smb3_exit_done(curr_xid, __func__);       \
> +       else                                                            \
> +               trace_smb3_exit_done(curr_xid, __func__);               \
>  } while (0)
>  extern int init_cifs_idmap(void);
>  extern void exit_cifs_idmap(void);
> diff --git a/fs/cifs/cifsroot.c b/fs/cifs/cifsroot.c
> index 37edbfb..9e91a5 100644
> --- a/fs/cifs/cifsroot.c
> +++ b/fs/cifs/cifsroot.c
> @@ -56,7 +56,7 @@ static int __init cifs_root_setup(char *line)
>                 /* len is strlen(unc) + '\0' */
>                 len =3D s - line + 1;
>                 if (len > sizeof(root_dev)) {
> -                       printk(KERN_ERR "Root-CIFS: UNC path too long\n")=
;
> +                       pr_err("Root-CIFS: UNC path too long\n");
>                         return 1;
>                 }
>                 strlcpy(root_dev, line, len);
> @@ -66,7 +66,7 @@ static int __init cifs_root_setup(char *line)
>                                          sizeof(root_opts), "%s,%s",
>                                          DEFAULT_MNT_OPTS, s + 1);
>                         if (n >=3D sizeof(root_opts)) {
> -                               printk(KERN_ERR "Root-CIFS: mount options=
 string too long\n");
> +                               pr_err("Root-CIFS: mount options string t=
oo long\n");
>                                 root_opts[sizeof(root_opts)-1] =3D '\0';
>                                 return 1;
>                         }
> @@ -83,7 +83,7 @@ __setup("cifsroot=3D", cifs_root_setup);
>  int __init cifs_root_data(char **dev, char **opts)
>  {
>         if (!root_dev[0] || root_server_addr =3D=3D htonl(INADDR_NONE)) {
> -               printk(KERN_ERR "Root-CIFS: no SMB server address\n");
> +               pr_err("Root-CIFS: no SMB server address\n");
>                 return -1;
>         }
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 140efc..9d193d2 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -177,7 +177,7 @@ static int __cifs_reconnect_tcon(const struct nls_tab=
le *nlsc,
>
>                 if (dfs_host_len !=3D tcp_host_len
>                     || strncasecmp(dfs_host, tcp_host, dfs_host_len) !=3D=
 0) {
> -                       cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %=
.*s",
> +                       cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %=
.*s\n",
>                                  __func__,
>                                  (int)dfs_host_len, dfs_host,
>                                  (int)tcp_host_len, tcp_host);
> @@ -262,8 +262,8 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_c=
ommand)
>                                                       (server->tcpStatus =
!=3D CifsNeedReconnect),
>                                                       10 * HZ);
>                 if (rc < 0) {
> -                       cifs_dbg(FYI, "%s: aborting reconnect due to a re=
ceived"
> -                                " signal by the process\n", __func__);
> +                       cifs_dbg(FYI, "%s: aborting reconnect due to a re=
ceived signal by the process\n",
> +                                __func__);
>                         return -ERESTARTSYS;
>                 }
>
> @@ -324,7 +324,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_c=
ommand)
>         cifs_dbg(FYI, "reconnect tcon rc =3D %d\n", rc);
>
>         if (rc) {
> -               printk_once(KERN_WARNING "reconnect tcon failed rc =3D %d=
\n", rc);
> +               pr_warn_once("reconnect tcon failed rc =3D %d\n", rc);
>                 goto out;
>         }
>
> @@ -557,7 +557,7 @@ cifs_enable_signing(struct TCP_Server_Info *server, b=
ool mnt_sign_required)
>         /* If server requires signing, does client allow it? */
>         if (srv_sign_required) {
>                 if (!mnt_sign_enabled) {
> -                       cifs_dbg(VFS, "Server requires signing, but it's =
disabled in SecurityFlags!");
> +                       cifs_dbg(VFS, "Server requires signing, but it's =
disabled in SecurityFlags!\n");
>                         return -ENOTSUPP;
>                 }
>                 server->sign =3D true;
> @@ -566,14 +566,14 @@ cifs_enable_signing(struct TCP_Server_Info *server,=
 bool mnt_sign_required)
>         /* If client requires signing, does server allow it? */
>         if (mnt_sign_required) {
>                 if (!srv_sign_enabled) {
> -                       cifs_dbg(VFS, "Server does not support signing!")=
;
> +                       cifs_dbg(VFS, "Server does not support signing!\n=
");
>                         return -ENOTSUPP;
>                 }
>                 server->sign =3D true;
>         }
>
>         if (cifs_rdma_enabled(server) && server->sign)
> -               cifs_dbg(VFS, "Signing is enabled, and RDMA read/write wi=
ll be disabled");
> +               cifs_dbg(VFS, "Signing is enabled, and RDMA read/write wi=
ll be disabled\n");
>
>         return 0;
>  }
> @@ -701,7 +701,7 @@ CIFSSMBNegotiate(const unsigned int xid, struct cifs_=
ses *ses)
>         pSMB->hdr.Flags2 |=3D (SMBFLG2_UNICODE | SMBFLG2_ERR_STATUS);
>
>         if (should_set_ext_sec_flag(ses->sectype)) {
> -               cifs_dbg(FYI, "Requesting extended security.");
> +               cifs_dbg(FYI, "Requesting extended security\n");
>                 pSMB->hdr.Flags2 |=3D SMBFLG2_EXT_SEC;
>         }
>
> @@ -3864,7 +3864,7 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_=
tcon *tcon,
>                         struct file_chattr_info *pfinfo;
>                         /* BB Do we need a cast or hash here ? */
>                         if (count !=3D 16) {
> -                               cifs_dbg(FYI, "Illegal size ret in GetExt=
Attr\n");
> +                               cifs_dbg(FYI, "Invalid size ret in GetExt=
Attr\n");
>                                 rc =3D -EIO;
>                                 goto GetExtAttrOut;
>                         }
> @@ -4240,7 +4240,7 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cif=
s_tcon *tcon,
>         rc =3D SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
>                          (struct smb_hdr *) pSMBr, &bytes_returned, 0);
>         if (rc) {
> -               cifs_dbg(FYI, "Send error in QFileInfo =3D %d", rc);
> +               cifs_dbg(FYI, "Send error in QFileInfo =3D %d\n", rc);
>         } else {                /* decode response */
>                 rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
>
> @@ -4407,7 +4407,7 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct=
 cifs_tcon *tcon,
>         rc =3D SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
>                          (struct smb_hdr *) pSMBr, &bytes_returned, 0);
>         if (rc) {
> -               cifs_dbg(FYI, "Send error in UnixQFileInfo =3D %d", rc);
> +               cifs_dbg(FYI, "Send error in UnixQFileInfo =3D %d\n", rc)=
;
>         } else {                /* decode response */
>                 rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
>
> @@ -4489,7 +4489,7 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct=
 cifs_tcon *tcon,
>         rc =3D SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
>                          (struct smb_hdr *) pSMBr, &bytes_returned, 0);
>         if (rc) {
> -               cifs_dbg(FYI, "Send error in UnixQPathInfo =3D %d", rc);
> +               cifs_dbg(FYI, "Send error in UnixQPathInfo =3D %d\n", rc)=
;
>         } else {                /* decode response */
>                 rc =3D validate_t2((struct smb_t2_rsp *)pSMBr);
>
> @@ -4909,7 +4909,7 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struc=
t cifs_tcon *tcon,
>                         struct file_internal_info *pfinfo;
>                         /* BB Do we need a cast or hash here ? */
>                         if (count < 8) {
> -                               cifs_dbg(FYI, "Illegal size ret in QryInt=
rnlInf\n");
> +                               cifs_dbg(FYI, "Invalid size ret in QryInt=
rnlInf\n");
>                                 rc =3D -EIO;
>                                 goto GetInodeNumOut;
>                         }
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 95b3ab0..869c3b 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -877,8 +877,7 @@ dequeue_mid(struct mid_q_entry *mid, bool malformed)
>          * function has finished processing it is a bug.
>          */
>         if (mid->mid_flags & MID_DELETED)
> -               printk_once(KERN_WARNING
> -                           "trying to dequeue a deleted mid\n");
> +               pr_warn_once("trying to dequeue a deleted mid\n");
>         else {
>                 list_del_init(&mid->qhead);
>                 mid->mid_flags |=3D MID_DELETED;
> @@ -1227,9 +1226,8 @@ cifs_demultiplex_thread(void *p)
>                                 smb2_add_credits_from_hdr(bufs[i], server=
);
>                                 cifs_dbg(FYI, "Received oplock break\n");
>                         } else {
> -                               cifs_server_dbg(VFS, "No task to wake, un=
known frame "
> -                                        "received! NumMids %d\n",
> -                                        atomic_read(&midCount));
> +                               cifs_server_dbg(VFS, "No task to wake, un=
known frame received! NumMids %d\n",
> +                                               atomic_read(&midCount));
>                                 cifs_dump_mem("Received Data is: ", bufs[=
i],
>                                               HEADER_SIZE(server));
>                                 smb2_add_credits_from_hdr(bufs[i], server=
);
> @@ -1474,9 +1472,7 @@ cifs_parse_smb_version(char *value, struct smb_vol =
*vol, bool is_smb3)
>                         cifs_dbg(VFS, "vers=3D1.0 (cifs) not permitted wh=
en mounting with smb3\n");
>                         return 1;
>                 }
> -               cifs_dbg(VFS, "Use of the less secure dialect vers=3D1.0 =
"
> -                          "is not recommended unless required for "
> -                          "access to very old servers\n");
> +               cifs_dbg(VFS, "Use of the less secure dialect vers=3D1.0 =
is not recommended unless required for access to very old servers\n");
>                 vol->ops =3D &smb1_operations;
>                 vol->vals =3D &smb1_values;
>                 break;
> @@ -1543,7 +1539,7 @@ cifs_parse_devname(const char *devname, struct smb_=
vol *vol)
>         size_t len;
>
>         if (unlikely(!devname || !*devname)) {
> -               cifs_dbg(VFS, "Device name not specified.\n");
> +               cifs_dbg(VFS, "Device name not specified\n");
>                 return -EINVAL;
>         }
>
> @@ -1693,13 +1689,13 @@ cifs_parse_mount_options(const char *mountdata, c=
onst char *devname,
>         case 0:
>                 break;
>         case -ENOMEM:
> -               cifs_dbg(VFS, "Unable to allocate memory for devname.\n")=
;
> +               cifs_dbg(VFS, "Unable to allocate memory for devname\n");
>                 goto cifs_parse_mount_err;
>         case -EINVAL:
> -               cifs_dbg(VFS, "Malformed UNC in devname.\n");
> +               cifs_dbg(VFS, "Malformed UNC in devname\n");
>                 goto cifs_parse_mount_err;
>         default:
> -               cifs_dbg(VFS, "Unknown error parsing devname.\n");
> +               cifs_dbg(VFS, "Unknown error parsing devname\n");
>                 goto cifs_parse_mount_err;
>         }
>
> @@ -1907,7 +1903,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                         vol->seal =3D 1;
>                         break;
>                 case Opt_noac:
> -                       pr_warn("CIFS: Mount option noac not supported. I=
nstead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
> +                       pr_warn("Mount option noac not supported. Instead=
 set /proc/fs/cifs/LookupCacheEnabled to 0\n");
>                         break;
>                 case Opt_fsc:
>  #ifndef CONFIG_CIFS_FSCACHE
> @@ -2154,7 +2150,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>
>                         if (strnlen(string, CIFS_MAX_USERNAME_LEN) >
>                                                         CIFS_MAX_USERNAME=
_LEN) {
> -                               pr_warn("CIFS: username too long\n");
> +                               pr_warn("username too long\n");
>                                 goto cifs_parse_mount_err;
>                         }
>
> @@ -2220,7 +2216,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                         temp_len =3D strlen(value);
>                         vol->password =3D kzalloc(temp_len+1, GFP_KERNEL)=
;
>                         if (vol->password =3D=3D NULL) {
> -                               pr_warn("CIFS: no memory for password\n")=
;
> +                               pr_warn("no memory for password\n");
>                                 goto cifs_parse_mount_err;
>                         }
>
> @@ -2244,7 +2240,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>
>                         if (!cifs_convert_address(dstaddr, string,
>                                         strlen(string))) {
> -                               pr_err("CIFS: bad ip=3D option (%s).\n", =
string);
> +                               pr_err("bad ip=3D option (%s)\n", string)=
;
>                                 goto cifs_parse_mount_err;
>                         }
>                         got_ip =3D true;
> @@ -2256,14 +2252,14 @@ cifs_parse_mount_options(const char *mountdata, c=
onst char *devname,
>
>                         if (strnlen(string, CIFS_MAX_DOMAINNAME_LEN)
>                                         =3D=3D CIFS_MAX_DOMAINNAME_LEN) {
> -                               pr_warn("CIFS: domain name too long\n");
> +                               pr_warn("domain name too long\n");
>                                 goto cifs_parse_mount_err;
>                         }
>
>                         kfree(vol->domainname);
>                         vol->domainname =3D kstrdup(string, GFP_KERNEL);
>                         if (!vol->domainname) {
> -                               pr_warn("CIFS: no memory for domainname\n=
");
> +                               pr_warn("no memory for domainname\n");
>                                 goto cifs_parse_mount_err;
>                         }
>                         cifs_dbg(FYI, "Domain name set\n");
> @@ -2276,7 +2272,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                         if (!cifs_convert_address(
>                                         (struct sockaddr *)&vol->srcaddr,
>                                         string, strlen(string))) {
> -                               pr_warn("CIFS: Could not parse srcaddr: %=
s\n",
> +                               pr_warn("Could not parse srcaddr: %s\n",
>                                         string);
>                                 goto cifs_parse_mount_err;
>                         }
> @@ -2287,7 +2283,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                                 goto out_nomem;
>
>                         if (strnlen(string, 1024) >=3D 65) {
> -                               pr_warn("CIFS: iocharset name too long.\n=
");
> +                               pr_warn("iocharset name too long\n");
>                                 goto cifs_parse_mount_err;
>                         }
>
> @@ -2296,7 +2292,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                                 vol->iocharset =3D kstrdup(string,
>                                                          GFP_KERNEL);
>                                 if (!vol->iocharset) {
> -                                       pr_warn("CIFS: no memory for char=
set\n");
> +                                       pr_warn("no memory for charset\n"=
);
>                                         goto cifs_parse_mount_err;
>                                 }
>                         }
> @@ -2327,7 +2323,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                          * set at top of the function
>                          */
>                         if (i =3D=3D RFC1001_NAME_LEN && string[i] !=3D 0=
)
> -                               pr_warn("CIFS: netbiosname longer than 15=
 truncated.\n");
> +                               pr_warn("netbiosname longer than 15 trunc=
ated\n");
>                         break;
>                 case Opt_servern:
>                         /* servernetbiosname specified override *SMBSERVE=
R */
> @@ -2353,7 +2349,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                         /* The string has 16th byte zero still from
>                            set at top of the function  */
>                         if (i =3D=3D RFC1001_NAME_LEN && string[i] !=3D 0=
)
> -                               pr_warn("CIFS: server netbiosname longer =
than 15 truncated.\n");
> +                               pr_warn("server netbiosname longer than 1=
5 truncated\n");
>                         break;
>                 case Opt_ver:
>                         /* version of mount userspace tools, not dialect =
*/
> @@ -2364,17 +2360,15 @@ cifs_parse_mount_options(const char *mountdata, c=
onst char *devname,
>                         /* If interface changes in mount.cifs bump to new=
 ver */
>                         if (strncasecmp(string, "1", 1) =3D=3D 0) {
>                                 if (strlen(string) > 1) {
> -                                       pr_warn("Bad mount helper ver=3D%=
s. Did "
> -                                               "you want SMB1 (CIFS) dia=
lect "
> -                                               "and mean to type vers=3D=
1.0 "
> -                                               "instead?\n", string);
> +                                       pr_warn("Bad mount helper ver=3D%=
s. Did you want SMB1 (CIFS) dialect and mean to type vers=3D1.0 instead?\n"=
,
> +                                               string);
>                                         goto cifs_parse_mount_err;
>                                 }
>                                 /* This is the default */
>                                 break;
>                         }
>                         /* For all other value, error */
> -                       pr_warn("CIFS: Invalid mount helper version speci=
fied\n");
> +                       pr_warn("Invalid mount helper version specified\n=
");
>                         goto cifs_parse_mount_err;
>                 case Opt_vers:
>                         /* protocol version (dialect) */
> @@ -2417,7 +2411,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>         }
>
>         if (!sloppy && invalid) {
> -               pr_err("CIFS: Unknown mount option \"%s\"\n", invalid);
> +               pr_err("Unknown mount option \"%s\"\n", invalid);
>                 goto cifs_parse_mount_err;
>         }
>
> @@ -2453,7 +2447,7 @@ cifs_parse_mount_options(const char *mountdata, con=
st char *devname,
>                 slash =3D strchr(&vol->UNC[2], '\\');
>                 len =3D slash - &vol->UNC[2];
>                 if (!cifs_convert_address(dstaddr, &vol->UNC[2], len)) {
> -                       pr_err("Unable to determine destination address.\=
n");
> +                       pr_err("Unable to determine destination address\n=
");
>                         goto cifs_parse_mount_err;
>                 }
>         }
> @@ -2464,20 +2458,15 @@ cifs_parse_mount_options(const char *mountdata, c=
onst char *devname,
>         if (uid_specified)
>                 vol->override_uid =3D override_uid;
>         else if (override_uid =3D=3D 1)
> -               pr_notice("CIFS: ignoring forceuid mount option specified=
 with no uid=3D option.\n");
> +               pr_notice("ignoring forceuid mount option specified with =
no uid=3D option\n");
>
>         if (gid_specified)
>                 vol->override_gid =3D override_gid;
>         else if (override_gid =3D=3D 1)
> -               pr_notice("CIFS: ignoring forcegid mount option specified=
 with no gid=3D option.\n");
> +               pr_notice("ignoring forcegid mount option specified with =
no gid=3D option\n");
>
>         if (got_version =3D=3D false)
> -               pr_warn_once("No dialect specified on mount. Default has =
changed"
> -                       " to a more secure dialect, SMB2.1 or later (e.g.=
 "
> -                       "SMB3.1.1), from CIFS (SMB1). To use the less sec=
ure "
> -                       "SMB1 dialect to access old servers which do not =
"
> -                       "support SMB3.1.1 (or even SMB3 or SMB2.1) specif=
y "
> -                       "vers=3D1.0 on mount.\n");
> +               pr_warn_once("No dialect specified on mount. Default has =
changed to a more secure dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIF=
S (SMB1). To use the less secure SMB1 dialect to access old servers which d=
o not support SMB3.1.1 (or even SMB3 or SMB2.1) specify vers=3D1.0 on mount=
.\n");
>
>         kfree(mountdata_copy);
>         return 0;
> @@ -3195,8 +3184,8 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs=
_ses *ses)
>                                            strlen(ses->domainName),
>                                            GFP_KERNEL);
>                 if (!vol->domainname) {
> -                       cifs_dbg(FYI, "Unable to allocate %zd bytes for "
> -                                "domain\n", len);
> +                       cifs_dbg(FYI, "Unable to allocate %zd bytes for d=
omain\n",
> +                                len);
>                         rc =3D -ENOMEM;
>                         kfree(vol->username);
>                         vol->username =3D NULL;
> @@ -3513,10 +3502,9 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb_vol=
 *volume_info)
>         if (volume_info->linux_ext) {
>                 if (ses->server->posix_ext_supported) {
>                         tcon->posix_extensions =3D true;
> -                       printk_once(KERN_WARNING
> -                               "SMB3.11 POSIX Extensions are experimenta=
l\n");
> +                       pr_warn_once("SMB3.11 POSIX Extensions are experi=
mental\n");
>                 } else {
> -                       cifs_dbg(VFS, "Server does not support mounting w=
ith posix SMB3.11 extensions.\n");
> +                       cifs_dbg(VFS, "Server does not support mounting w=
ith posix SMB3.11 extensions\n");
>                         rc =3D -EOPNOTSUPP;
>                         goto out_fail;
>                 }
> @@ -4736,8 +4724,7 @@ static int is_path_remote(struct cifs_sb_info *cifs=
_sb, struct smb_vol *vol,
>                 rc =3D cifs_are_all_path_components_accessible(server, xi=
d, tcon,
>                         cifs_sb, full_path, tcon->Flags & SMB_SHARE_IS_IN=
_DFS);
>                 if (rc !=3D 0) {
> -                       cifs_server_dbg(VFS, "cannot query dirs between r=
oot and final path, "
> -                                "enabling CIFS_MOUNT_USE_PREFIX_PATH\n")=
;
> +                       cifs_server_dbg(VFS, "cannot query dirs between r=
oot and final path, enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
>                         cifs_sb->mnt_cifs_flags |=3D CIFS_MOUNT_USE_PREFI=
X_PATH;
>                         rc =3D 0;
>                 }
> diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
> index a67f88bf..df81c7 100644
> --- a/fs/cifs/dfs_cache.c
> +++ b/fs/cifs/dfs_cache.c
> @@ -198,7 +198,7 @@ static ssize_t dfscache_proc_write(struct file *file,=
 const char __user *buffer,
>         if (c !=3D '0')
>                 return -EINVAL;
>
> -       cifs_dbg(FYI, "clearing dfs cache");
> +       cifs_dbg(FYI, "clearing dfs cache\n");
>
>         down_write(&htable_rw_lock);
>         flush_cache_ents();
> @@ -234,8 +234,8 @@ static inline void dump_tgts(const struct cache_entry=
 *ce)
>
>  static inline void dump_ce(const struct cache_entry *ce)
>  {
> -       cifs_dbg(FYI, "cache entry: path=3D%s,type=3D%s,ttl=3D%d,etime=3D=
%ld,"
> -                "interlink=3D%s,path_consumed=3D%d,expired=3D%s\n", ce->=
path,
> +       cifs_dbg(FYI, "cache entry: path=3D%s,type=3D%s,ttl=3D%d,etime=3D=
%ld,interlink=3D%s,path_consumed=3D%d,expired=3D%s\n",
> +                ce->path,
>                  ce->srvtype =3D=3D DFS_TYPE_ROOT ? "root" : "link", ce->=
ttl,
>                  ce->etime.tv_nsec,
>                  IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
> @@ -453,11 +453,11 @@ static void remove_oldest_entry(void)
>         }
>
>         if (!to_del) {
> -               cifs_dbg(FYI, "%s: no entry to remove", __func__);
> +               cifs_dbg(FYI, "%s: no entry to remove\n", __func__);
>                 return;
>         }
>
> -       cifs_dbg(FYI, "%s: removing entry", __func__);
> +       cifs_dbg(FYI, "%s: removing entry\n", __func__);
>         dump_ce(to_del);
>         flush_cache_ent(to_del);
>  }
> @@ -696,8 +696,8 @@ static int __dfs_cache_find(const unsigned int xid, s=
truct cifs_ses *ses,
>         }
>
>         if (atomic_read(&cache_count) >=3D CACHE_MAX_ENTRIES) {
> -               cifs_dbg(FYI, "%s: reached max cache size (%d)", __func__=
,
> -                        CACHE_MAX_ENTRIES);
> +               cifs_dbg(FYI, "%s: reached max cache size (%d)\n",
> +                        __func__, CACHE_MAX_ENTRIES);
>                 down_write(&htable_rw_lock);
>                 remove_oldest_entry();
>                 up_write(&htable_rw_lock);
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 0b1528..6abc4d 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -857,7 +857,7 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon=
)
>
>         tcon->need_reopen_files =3D false;
>
> -       cifs_dbg(FYI, "Reopen persistent handles");
> +       cifs_dbg(FYI, "Reopen persistent handles\n");
>         INIT_LIST_HEAD(&tmp_list);
>
>         /* list all files open on tree connection, reopen resilient handl=
es  */
> @@ -2056,7 +2056,7 @@ find_writable_file(struct cifsInodeInfo *cifs_inode=
, int flags)
>
>         rc =3D cifs_get_writable_file(cifs_inode, flags, &cfile);
>         if (rc)
> -               cifs_dbg(FYI, "couldn't find writable handle rc=3D%d", rc=
);
> +               cifs_dbg(FYI, "Couldn't find writable handle rc=3D%d\n", =
rc);
>
>         return cfile;
>  }
> @@ -2923,11 +2923,9 @@ cifs_write_from_iter(loff_t offset, size_t len, st=
ruct iov_iter *from,
>                                 from, &pagevec, cur_len, &start);
>                         if (result < 0) {
>                                 cifs_dbg(VFS,
> -                                       "direct_writev couldn't get user =
pages "
> -                                       "(rc=3D%zd) iter type %d iov_offs=
et %zd "
> -                                       "count %zd\n",
> -                                       result, iov_iter_type(from),
> -                                       from->iov_offset, from->count);
> +                                        "direct_writev couldn't get user=
 pages (rc=3D%zd) iter type %d iov_offset %zd count %zd\n",
> +                                        result, iov_iter_type(from),
> +                                        from->iov_offset, from->count);
>                                 dump_stack();
>
>                                 rc =3D result;
> @@ -3654,12 +3652,10 @@ cifs_send_async_read(loff_t offset, size_t len, s=
truct cifsFileInfo *open_file,
>                                         cur_len, &start);
>                         if (result < 0) {
>                                 cifs_dbg(VFS,
> -                                       "couldn't get user pages (rc=3D%z=
d)"
> -                                       " iter type %d"
> -                                       " iov_offset %zd count %zd\n",
> -                                       result, iov_iter_type(&direct_iov=
),
> -                                       direct_iov.iov_offset,
> -                                       direct_iov.count);
> +                                        "Couldn't get user pages (rc=3D%=
zd) iter type %d iov_offset %zd count %zd\n",
> +                                        result, iov_iter_type(&direct_io=
v),
> +                                        direct_iov.iov_offset,
> +                                        direct_iov.count);
>                                 dump_stack();
>
>                                 rc =3D result;
> @@ -4828,7 +4824,7 @@ static int cifs_swap_activate(struct swap_info_stru=
ct *sis,
>         }
>         *span =3D sis->pages;
>
> -       printk_once(KERN_WARNING "Swap support over SMB3 is experimental\=
n");
> +       pr_warn_once("Swap support over SMB3 is experimental\n");
>
>         /*
>          * TODO: consider adding ACL (or documenting how) to prevent othe=
r
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index 8fbbdcd..224486 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -1155,7 +1155,7 @@ struct inode *cifs_root_iget(struct super_block *sb=
)
>                 /* some servers mistakenly claim POSIX support */
>                 if (rc !=3D -EOPNOTSUPP)
>                         goto iget_no_retry;
> -               cifs_dbg(VFS, "server does not support POSIX extensions")=
;
> +               cifs_dbg(VFS, "server does not support POSIX extensions\n=
");
>                 tcon->unix_ext =3D false;
>         }
>
> @@ -1999,7 +1999,7 @@ cifs_invalidate_mapping(struct inode *inode)
>         if (inode->i_mapping && inode->i_mapping->nrpages !=3D 0) {
>                 rc =3D invalidate_inode_pages2(inode->i_mapping);
>                 if (rc)
> -                       cifs_dbg(VFS, "%s: could not invalidate inode %p\=
n",
> +                       cifs_dbg(VFS, "%s: Could not invalidate inode %p\=
n",
>                                  __func__, inode);
>         }
>
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index a456feb..9d9b90 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -421,7 +421,7 @@ is_valid_oplock_break(char *buffer, struct TCP_Server=
_Info *srv)
>
>                         if (data_offset >
>                             len - sizeof(struct file_notify_information))=
 {
> -                               cifs_dbg(FYI, "invalid data_offset %u\n",
> +                               cifs_dbg(FYI, "Invalid data_offset %u\n",
>                                          data_offset);
>                                 return true;
>                         }
> @@ -449,7 +449,7 @@ is_valid_oplock_break(char *buffer, struct TCP_Server=
_Info *srv)
>                    large dirty files cached on the client */
>                 if ((NT_STATUS_INVALID_HANDLE) =3D=3D
>                    le32_to_cpu(pSMB->hdr.Status.CifsError)) {
> -                       cifs_dbg(FYI, "invalid handle on oplock break\n")=
;
> +                       cifs_dbg(FYI, "Invalid handle on oplock break\n")=
;
>                         return true;
>                 } else if (ERRbadfid =3D=3D
>                    le16_to_cpu(pSMB->hdr.Status.DosError.Error)) {
> @@ -530,9 +530,9 @@ cifs_autodisable_serverino(struct cifs_sb_info *cifs_=
sb)
>
>                 cifs_sb->mnt_cifs_flags &=3D ~CIFS_MOUNT_SERVER_INUM;
>                 cifs_sb->mnt_cifs_serverino_autodisabled =3D true;
> -               cifs_dbg(VFS, "Autodisabling the use of server inode numb=
ers on %s.\n",
> +               cifs_dbg(VFS, "Autodisabling the use of server inode numb=
ers on %s\n",
>                          tcon ? tcon->treeName : "new server");
> -               cifs_dbg(VFS, "The server doesn't seem to support them pr=
operly or the files might be on different servers (DFS).\n");
> +               cifs_dbg(VFS, "The server doesn't seem to support them pr=
operly or the files might be on different servers (DFS)\n");
>                 cifs_dbg(VFS, "Hardlinks will not be recognized on this m=
ount. Consider mounting with the \"noserverino\" option to silence this mes=
sage.\n");
>
>         }
> @@ -874,7 +874,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct i=
ov_iter *iter, int rw)
>         while (count && npages < max_pages) {
>                 rc =3D iov_iter_get_pages(iter, pages, count, max_pages, =
&start);
>                 if (rc < 0) {
> -                       cifs_dbg(VFS, "couldn't get user pages (rc=3D%zd)=
\n", rc);
> +                       cifs_dbg(VFS, "Couldn't get user pages (rc=3D%zd)=
\n", rc);
>                         break;
>                 }
>
> @@ -933,7 +933,7 @@ cifs_alloc_hash(const char *name,
>
>         *shash =3D crypto_alloc_shash(name, 0, 0);
>         if (IS_ERR(*shash)) {
> -               cifs_dbg(VFS, "could not allocate crypto %s\n", name);
> +               cifs_dbg(VFS, "Could not allocate crypto %s\n", name);
>                 rc =3D PTR_ERR(*shash);
>                 *shash =3D NULL;
>                 *sdesc =3D NULL;
> diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
> index 9b41436..b7ca49 100644
> --- a/fs/cifs/netmisc.c
> +++ b/fs/cifs/netmisc.c
> @@ -957,15 +957,15 @@ struct timespec64 cnvrtDosUnixTm(__le16 le_date, __=
le16 le_time, int offset)
>         sec =3D 2 * st->TwoSeconds;
>         min =3D st->Minutes;
>         if ((sec > 59) || (min > 59))
> -               cifs_dbg(VFS, "illegal time min %d sec %lld\n", min, sec)=
;
> +               cifs_dbg(VFS, "Invalid time min %d sec %lld\n", min, sec)=
;
>         sec +=3D (min * 60);
>         sec +=3D 60 * 60 * st->Hours;
>         if (st->Hours > 24)
> -               cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
> +               cifs_dbg(VFS, "Invalid hours %d\n", st->Hours);
>         day =3D sd->Day;
>         month =3D sd->Month;
>         if (day < 1 || day > 31 || month < 1 || month > 12) {
> -               cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, =
day);
> +               cifs_dbg(VFS, "Invalid date, month %d day: %d\n", month, =
day);
>                 day =3D clamp(day, 1, 31);
>                 month =3D clamp(month, 1, 12);
>         }
> diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
> index 50f776a..6df0922 100644
> --- a/fs/cifs/readdir.c
> +++ b/fs/cifs/readdir.c
> @@ -53,7 +53,7 @@ static void dump_cifs_file_struct(struct file *file, ch=
ar *label)
>                         return;
>                 }
>                 if (cf->invalidHandle)
> -                       cifs_dbg(FYI, "invalid handle\n");
> +                       cifs_dbg(FYI, "Invalid handle\n");
>                 if (cf->srch_inf.endOfSearch)
>                         cifs_dbg(FYI, "end of search\n");
>                 if (cf->srch_inf.emptyDir)
> @@ -246,7 +246,7 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct =
smb2_posix_info *info,
>          */
>         fattr->cf_mode =3D le32_to_cpu(info->Mode) & ~S_IFMT;
>
> -       cifs_dbg(FYI, "posix fattr: dev %d, reparse %d, mode %o",
> +       cifs_dbg(FYI, "posix fattr: dev %d, reparse %d, mode %o\n",
>                  le32_to_cpu(info->DeviceId),
>                  le32_to_cpu(info->ReparseTag),
>                  le32_to_cpu(info->Mode));
> @@ -478,7 +478,7 @@ static char *nxt_dir_entry(char *old_entry, char *end=
_of_smb, int level)
>                 u32 next_offset =3D le32_to_cpu(pDirInfo->NextEntryOffset=
);
>
>                 if (old_entry + next_offset < old_entry) {
> -                       cifs_dbg(VFS, "invalid offset %u\n", next_offset)=
;
> +                       cifs_dbg(VFS, "Invalid offset %u\n", next_offset)=
;
>                         return NULL;
>                 }
>                 new_entry =3D old_entry + next_offset;
> @@ -515,7 +515,7 @@ static void cifs_fill_dirent_posix(struct cifs_dirent=
 *de,
>
>         /* payload should have already been checked at this point */
>         if (posix_info_parse(info, NULL, &parsed) < 0) {
> -               cifs_dbg(VFS, "invalid POSIX info payload");
> +               cifs_dbg(VFS, "Invalid POSIX info payload\n");
>                 return;
>         }
>
> @@ -968,7 +968,7 @@ int cifs_readdir(struct file *file, struct dir_contex=
t *ctx)
>         } else if (current_entry !=3D NULL) {
>                 cifs_dbg(FYI, "entry %lld found\n", ctx->pos);
>         } else {
> -               cifs_dbg(FYI, "could not find entry\n");
> +               cifs_dbg(FYI, "Could not find entry\n");
>                 goto rddir2_exit;
>         }
>         cifs_dbg(FYI, "loop through %d times filling dir for net buf %p\n=
",
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index 43a88e2..3f8b43 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -162,12 +162,14 @@ cifs_ses_add_channel(struct cifs_ses *ses, struct c=
ifs_server_iface *iface)
>         int rc;
>         unsigned int xid =3D get_xid();
>
> -       cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ",
> -                ses, iface->speed, iface->rdma_capable ? "yes" : "no");
>         if (iface->sockaddr.ss_family =3D=3D AF_INET)
> -               cifs_dbg(FYI, "ip:%pI4)\n", &ipv4->sin_addr);
> +               cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rd=
ma:%s ip:%pI4)\n",
> +                        ses, iface->speed, iface->rdma_capable ? "yes" :=
 "no",
> +                        &ipv4->sin_addr);
>         else
> -               cifs_dbg(FYI, "ip:%pI6)\n", &ipv6->sin6_addr);
> +               cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rd=
ma:%s ip:%pI4)\n",
> +                        ses, iface->speed, iface->rdma_capable ? "yes" :=
 "no",
> +                        &ipv6->sin6_addr);
>
>         /*
>          * Setup a smb_vol with mostly the same info as the existing
> @@ -569,15 +571,15 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blo=
b_len,
>         tioffset =3D le32_to_cpu(pblob->TargetInfoArray.BufferOffset);
>         tilen =3D le16_to_cpu(pblob->TargetInfoArray.Length);
>         if (tioffset > blob_len || tioffset + tilen > blob_len) {
> -               cifs_dbg(VFS, "tioffset + tilen too high %u + %u",
> -                       tioffset, tilen);
> +               cifs_dbg(VFS, "tioffset + tilen too high %u + %u\n",
> +                        tioffset, tilen);
>                 return -EINVAL;
>         }
>         if (tilen) {
>                 ses->auth_key.response =3D kmemdup(bcc_ptr + tioffset, ti=
len,
>                                                  GFP_KERNEL);
>                 if (!ses->auth_key.response) {
> -                       cifs_dbg(VFS, "Challenge target info alloc failur=
e");
> +                       cifs_dbg(VFS, "Challenge target info alloc failur=
e\n");
>                         return -ENOMEM;
>                 }
>                 ses->auth_key.len =3D tilen;
> @@ -1303,9 +1305,8 @@ sess_auth_kerberos(struct sess_data *sess_data)
>          * sending us a response in an expected form
>          */
>         if (msg->version !=3D CIFS_SPNEGO_UPCALL_VERSION) {
> -               cifs_dbg(VFS,
> -                 "incorrect version of cifs.upcall (expected %d but got =
%d)",
> -                             CIFS_SPNEGO_UPCALL_VERSION, msg->version);
> +               cifs_dbg(VFS, "incorrect version of cifs.upcall (expected=
 %d but got %d)\n",
> +                        CIFS_SPNEGO_UPCALL_VERSION, msg->version);
>                 rc =3D -EKEYREJECTED;
>                 goto out_put_spnego_key;
>         }
> @@ -1313,8 +1314,8 @@ sess_auth_kerberos(struct sess_data *sess_data)
>         ses->auth_key.response =3D kmemdup(msg->data, msg->sesskey_len,
>                                          GFP_KERNEL);
>         if (!ses->auth_key.response) {
> -               cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory"=
,
> -                               msg->sesskey_len);
> +               cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\=
n",
> +                        msg->sesskey_len);
>                 rc =3D -ENOMEM;
>                 goto out_put_spnego_key;
>         }
> @@ -1657,8 +1658,7 @@ static int select_sec(struct cifs_ses *ses, struct =
sess_data *sess_data)
>         type =3D cifs_select_sectype(ses->server, ses->sectype);
>         cifs_dbg(FYI, "sess setup type %d\n", type);
>         if (type =3D=3D Unspecified) {
> -               cifs_dbg(VFS,
> -                       "Unable to select appropriate authentication meth=
od!");
> +               cifs_dbg(VFS, "Unable to select appropriate authenticatio=
n method!\n");
>                 return -EINVAL;
>         }
>
> diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
> index b130efa..197ed45 100644
> --- a/fs/cifs/smb1ops.c
> +++ b/fs/cifs/smb1ops.c
> @@ -247,7 +247,7 @@ check2ndT2(char *buf)
>         /* check for plausible wct, bcc and t2 data and parm sizes */
>         /* check for parm and data offset going beyond end of smb */
>         if (pSMB->WordCount !=3D 10) { /* coalesce_t2 depends on this */
> -               cifs_dbg(FYI, "invalid transact2 word count\n");
> +               cifs_dbg(FYI, "Invalid transact2 word count\n");
>                 return -EINVAL;
>         }
>
> diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
> index a8c301a..0e58398 100644
> --- a/fs/cifs/smb2inode.c
> +++ b/fs/cifs/smb2inode.c
> @@ -336,8 +336,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_=
tcon *tcon,
>
>         SMB2_open_free(&rqst[0]);
>         if (rc =3D=3D -EREMCHG) {
> -               printk_once(KERN_WARNING "server share %s deleted\n",
> -                           tcon->treeName);
> +               pr_warn_once("server share %s deleted\n", tcon->treeName)=
;
>                 tcon->need_reconnect =3D true;
>         }
>
> diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
> index 497afb..6a39451 100644
> --- a/fs/cifs/smb2misc.c
> +++ b/fs/cifs/smb2misc.c
> @@ -110,14 +110,14 @@ static __u32 get_neg_ctxt_len(struct smb2_sync_hdr =
*hdr, __u32 len,
>         /* Make sure that negotiate contexts start after gss security blo=
b */
>         nc_offset =3D le32_to_cpu(pneg_rsp->NegotiateContextOffset);
>         if (nc_offset < non_ctxlen) {
> -               printk_once(KERN_WARNING "invalid negotiate context offse=
t\n");
> +               pr_warn_once("Invalid negotiate context offset\n");
>                 return 0;
>         }
>         size_of_pad_before_neg_ctxts =3D nc_offset - non_ctxlen;
>
>         /* Verify that at least minimal negotiate contexts fit within fra=
me */
>         if (len < nc_offset + (neg_count * sizeof(struct smb2_neg_context=
))) {
> -               printk_once(KERN_WARNING "negotiate context goes beyond e=
nd\n");
> +               pr_warn_once("negotiate context goes beyond end\n");
>                 return 0;
>         }
>
> @@ -190,14 +190,14 @@ smb2_check_message(char *buf, unsigned int len, str=
uct TCP_Server_Info *srvr)
>                 return 1;
>
>         if (shdr->StructureSize !=3D SMB2_HEADER_STRUCTURE_SIZE) {
> -               cifs_dbg(VFS, "Illegal structure size %u\n",
> +               cifs_dbg(VFS, "Invalid structure size %u\n",
>                          le16_to_cpu(shdr->StructureSize));
>                 return 1;
>         }
>
>         command =3D le16_to_cpu(shdr->Command);
>         if (command >=3D NUMBER_OF_SMB2_COMMANDS) {
> -               cifs_dbg(VFS, "Illegal SMB2 command %d\n", command);
> +               cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
>                 return 1;
>         }
>
> @@ -205,7 +205,7 @@ smb2_check_message(char *buf, unsigned int len, struc=
t TCP_Server_Info *srvr)
>                 if (command !=3D SMB2_OPLOCK_BREAK_HE && (shdr->Status =
=3D=3D 0 ||
>                     pdu->StructureSize2 !=3D SMB2_ERROR_STRUCTURE_SIZE2))=
 {
>                         /* error packets have 9 byte structure size */
> -                       cifs_dbg(VFS, "Illegal response size %u for comma=
nd %d\n",
> +                       cifs_dbg(VFS, "Invalid response size %u for comma=
nd %d\n",
>                                  le16_to_cpu(pdu->StructureSize2), comman=
d);
>                         return 1;
>                 } else if (command =3D=3D SMB2_OPLOCK_BREAK_HE
> @@ -213,7 +213,7 @@ smb2_check_message(char *buf, unsigned int len, struc=
t TCP_Server_Info *srvr)
>                            && (le16_to_cpu(pdu->StructureSize2) !=3D 44)
>                            && (le16_to_cpu(pdu->StructureSize2) !=3D 36))=
 {
>                         /* special case for SMB2.1 lease break message */
> -                       cifs_dbg(VFS, "Illegal response size %d for oploc=
k break\n",
> +                       cifs_dbg(VFS, "Invalid response size %d for oploc=
k break\n",
>                                  le16_to_cpu(pdu->StructureSize2));
>                         return 1;
>                 }
> @@ -864,14 +864,14 @@ smb311_update_preauth_hash(struct cifs_ses *ses, st=
ruct kvec *iov, int nvec)
>         d =3D server->secmech.sdescsha512;
>         rc =3D crypto_shash_init(&d->shash);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: could not init sha512 shash\n", __func=
__);
> +               cifs_dbg(VFS, "%s: Could not init sha512 shash\n", __func=
__);
>                 return rc;
>         }
>
>         rc =3D crypto_shash_update(&d->shash, ses->preauth_sha_hash,
>                                  SMB2_PREAUTH_HASH_SIZE);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: could not update sha512 shash\n", __fu=
nc__);
> +               cifs_dbg(VFS, "%s: Could not update sha512 shash\n", __fu=
nc__);
>                 return rc;
>         }
>
> @@ -879,7 +879,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, stru=
ct kvec *iov, int nvec)
>                 rc =3D crypto_shash_update(&d->shash,
>                                          iov[i].iov_base, iov[i].iov_len)=
;
>                 if (rc) {
> -                       cifs_dbg(VFS, "%s: could not update sha512 shash\=
n",
> +                       cifs_dbg(VFS, "%s: Could not update sha512 shash\=
n",
>                                  __func__);
>                         return rc;
>                 }
> @@ -887,7 +887,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, stru=
ct kvec *iov, int nvec)
>
>         rc =3D crypto_shash_final(&d->shash, ses->preauth_sha_hash);
>         if (rc) {
> -               cifs_dbg(VFS, "%s: could not finalize sha512 shash\n",
> +               cifs_dbg(VFS, "%s: Could not finalize sha512 shash\n",
>                          __func__);
>                 return rc;
>         }
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index b36c46..661419 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -79,7 +79,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
>
>         if (*val > 65000) {
>                 *val =3D 65000; /* Don't get near 64K credits, avoid srv =
bugs */
> -               printk_once(KERN_WARNING "server overflowed SMB3 credits\=
n");
> +               pr_warn_once("server overflowed SMB3 credits\n");
>         }
>         server->in_flight--;
>         if (server->in_flight =3D=3D 0 && (optype & CIFS_OP_MASK) !=3D CI=
FS_NEG_OP)
> @@ -762,8 +762,8 @@ int open_shroot(unsigned int xid, struct cifs_tcon *t=
con,
>         if (rc) {
>                 if (rc =3D=3D -EREMCHG) {
>                         tcon->need_reconnect =3D true;
> -                       printk_once(KERN_WARNING "server share %s deleted=
\n",
> -                                   tcon->treeName);
> +                       pr_warn_once("server share %s deleted\n",
> +                                    tcon->treeName);
>                 }
>                 goto oshr_exit;
>         }
> @@ -1584,7 +1584,8 @@ smb2_ioctl_query_info(const unsigned int xid,
>                                   qi.input_buffer_length,
>                                   qi.output_buffer_length, buffer);
>         } else { /* unknown flags */
> -               cifs_tcon_dbg(VFS, "invalid passthru query flags: 0x%x\n"=
, qi.flags);
> +               cifs_tcon_dbg(VFS, "Invalid passthru query flags: 0x%x\n"=
,
> +                             qi.flags);
>                 rc =3D -EINVAL;
>         }
>
> @@ -1714,7 +1715,7 @@ smb2_copychunk_range(const unsigned int xid,
>                 if (rc =3D=3D 0) {
>                         if (ret_data_len !=3D
>                                         sizeof(struct copychunk_ioctl_rsp=
)) {
> -                               cifs_tcon_dbg(VFS, "invalid cchunk respon=
se size\n");
> +                               cifs_tcon_dbg(VFS, "Invalid cchunk respon=
se size\n");
>                                 rc =3D -EIO;
>                                 goto cchunk_out;
>                         }
> @@ -1728,12 +1729,12 @@ smb2_copychunk_range(const unsigned int xid,
>                          */
>                         if (le32_to_cpu(retbuf->TotalBytesWritten) >
>                             le32_to_cpu(pcchunk->Length)) {
> -                               cifs_tcon_dbg(VFS, "invalid copy chunk re=
sponse\n");
> +                               cifs_tcon_dbg(VFS, "Invalid copy chunk re=
sponse\n");
>                                 rc =3D -EIO;
>                                 goto cchunk_out;
>                         }
>                         if (le32_to_cpu(retbuf->ChunksWritten) !=3D 1) {
> -                               cifs_tcon_dbg(VFS, "invalid num chunks wr=
itten\n");
> +                               cifs_tcon_dbg(VFS, "Invalid num chunks wr=
itten\n");
>                                 rc =3D -EIO;
>                                 goto cchunk_out;
>                         }
> @@ -2467,8 +2468,8 @@ smb2_query_info_compound(const unsigned int xid, st=
ruct cifs_tcon *tcon,
>                 free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
>                 if (rc =3D=3D -EREMCHG) {
>                         tcon->need_reconnect =3D true;
> -                       printk_once(KERN_WARNING "server share %s deleted=
\n",
> -                                   tcon->treeName);
> +                       pr_warn_once("server share %s deleted\n",
> +                                    tcon->treeName);
>                 }
>                 goto qic_exit;
>         }
> @@ -2748,15 +2749,15 @@ parse_reparse_point(struct reparse_data_buffer *b=
uf,
>                     struct cifs_sb_info *cifs_sb)
>  {
>         if (plen < sizeof(struct reparse_data_buffer)) {
> -               cifs_dbg(VFS, "reparse buffer is too small. Must be "
> -                        "at least 8 bytes but was %d\n", plen);
> +               cifs_dbg(VFS, "reparse buffer is too small. Must be at le=
ast 8 bytes but was %d\n",
> +                        plen);
>                 return -EIO;
>         }
>
>         if (plen < le16_to_cpu(buf->ReparseDataLength) +
>             sizeof(struct reparse_data_buffer)) {
> -               cifs_dbg(VFS, "srv returned invalid reparse buf "
> -                        "length: %d\n", plen);
> +               cifs_dbg(VFS, "srv returned invalid reparse buf length: %=
d\n",
> +                        plen);
>                 return -EIO;
>         }
>
> @@ -2771,8 +2772,8 @@ parse_reparse_point(struct reparse_data_buffer *buf=
,
>                         (struct reparse_symlink_data_buffer *)buf,
>                         plen, target_path, cifs_sb);
>         default:
> -               cifs_dbg(VFS, "srv returned unknown symlink buffer "
> -                        "tag:0x%08x\n", le32_to_cpu(buf->ReparseTag));
> +               cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x=
%08x\n",
> +                        le32_to_cpu(buf->ReparseTag));
>                 return -EOPNOTSUPP;
>         }
>  }
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index b30aa3c..fc3517 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -208,7 +208,7 @@ static int __smb2_reconnect(const struct nls_table *n=
lsc,
>
>                 if (dfs_host_len !=3D tcp_host_len
>                     || strncasecmp(dfs_host, tcp_host, dfs_host_len) !=3D=
 0) {
> -                       cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %=
.*s",
> +                       cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %=
.*s\n",
>                                  __func__,
>                                  (int)dfs_host_len, dfs_host,
>                                  (int)tcp_host_len, tcp_host);
> @@ -314,8 +314,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon =
*tcon)
>                                                       (server->tcpStatus =
!=3D CifsNeedReconnect),
>                                                       10 * HZ);
>                 if (rc < 0) {
> -                       cifs_dbg(FYI, "%s: aborting reconnect due to a re=
ceived"
> -                                " signal by the process\n", __func__);
> +                       cifs_dbg(FYI, "%s: aborting reconnect due to a re=
ceived signal by the process\n",
> +                                __func__);
>                         return -ERESTARTSYS;
>                 }
>
> @@ -384,7 +384,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon =
*tcon)
>         cifs_dbg(FYI, "reconnect tcon rc =3D %d\n", rc);
>         if (rc) {
>                 /* If sess reconnected but tcon didn't, something strange=
 ... */
> -               printk_once(KERN_WARNING "reconnect tcon failed rc =3D %d=
\n", rc);
> +               pr_warn_once("reconnect tcon failed rc =3D %d\n", rc);
>                 goto out;
>         }
>
> @@ -626,13 +626,13 @@ static void decode_preauth_context(struct smb2_prea=
uth_neg_context *ctxt)
>
>         /* If invalid preauth context warn but use what we requested, SHA=
-512 */
>         if (len < MIN_PREAUTH_CTXT_DATA_LEN) {
> -               printk_once(KERN_WARNING "server sent bad preauth context=
\n");
> +               pr_warn_once("server sent bad preauth context\n");
>                 return;
>         }
>         if (le16_to_cpu(ctxt->HashAlgorithmCount) !=3D 1)
> -               printk_once(KERN_WARNING "illegal SMB3 hash algorithm cou=
nt\n");
> +               pr_warn_once("Invalid SMB3 hash algorithm count\n");
>         if (ctxt->HashAlgorithms !=3D SMB2_PREAUTH_INTEGRITY_SHA512)
> -               printk_once(KERN_WARNING "unknown SMB3 hash algorithm\n")=
;
> +               pr_warn_once("unknown SMB3 hash algorithm\n");
>  }
>
>  static void decode_compress_ctx(struct TCP_Server_Info *server,
> @@ -642,15 +642,15 @@ static void decode_compress_ctx(struct TCP_Server_I=
nfo *server,
>
>         /* sizeof compress context is a one element compression capbility=
 struct */
>         if (len < 10) {
> -               printk_once(KERN_WARNING "server sent bad compression cnt=
xt\n");
> +               pr_warn_once("server sent bad compression cntxt\n");
>                 return;
>         }
>         if (le16_to_cpu(ctxt->CompressionAlgorithmCount) !=3D 1) {
> -               printk_once(KERN_WARNING "illegal SMB3 compress algorithm=
 count\n");
> +               pr_warn_once("Invalid SMB3 compress algorithm count\n");
>                 return;
>         }
>         if (le16_to_cpu(ctxt->CompressionAlgorithms[0]) > 3) {
> -               printk_once(KERN_WARNING "unknown compression algorithm\n=
");
> +               pr_warn_once("unknown compression algorithm\n");
>                 return;
>         }
>         server->compress_algorithm =3D ctxt->CompressionAlgorithms[0];
> @@ -663,18 +663,18 @@ static int decode_encrypt_ctx(struct TCP_Server_Inf=
o *server,
>
>         cifs_dbg(FYI, "decode SMB3.11 encryption neg context of len %d\n"=
, len);
>         if (len < MIN_ENCRYPT_CTXT_DATA_LEN) {
> -               printk_once(KERN_WARNING "server sent bad crypto ctxt len=
\n");
> +               pr_warn_once("server sent bad crypto ctxt len\n");
>                 return -EINVAL;
>         }
>
>         if (le16_to_cpu(ctxt->CipherCount) !=3D 1) {
> -               printk_once(KERN_WARNING "illegal SMB3.11 cipher count\n"=
);
> +               pr_warn_once("Invalid SMB3.11 cipher count\n");
>                 return -EINVAL;
>         }
>         cifs_dbg(FYI, "SMB311 cipher type:%d\n", le16_to_cpu(ctxt->Cipher=
s[0]));
>         if ((ctxt->Ciphers[0] !=3D SMB2_ENCRYPTION_AES128_CCM) &&
>             (ctxt->Ciphers[0] !=3D SMB2_ENCRYPTION_AES128_GCM)) {
> -               printk_once(KERN_WARNING "invalid SMB3.11 cipher returned=
\n");
> +               pr_warn_once("Invalid SMB3.11 cipher returned\n");
>                 return -EINVAL;
>         }
>         server->cipher_type =3D ctxt->Ciphers[0];
> @@ -774,7 +774,7 @@ create_posix_buf(umode_t mode)
>         buf->Name[14] =3D 0xCD;
>         buf->Name[15] =3D 0x7C;
>         buf->Mode =3D cpu_to_le32(mode);
> -       cifs_dbg(FYI, "mode on posix create 0%o", mode);
> +       cifs_dbg(FYI, "mode on posix create 0%o\n", mode);
>         return buf;
>  }
>
> @@ -786,7 +786,7 @@ add_posix_context(struct kvec *iov, unsigned int *num=
_iovec, umode_t mode)
>
>         iov[num].iov_base =3D create_posix_buf(mode);
>         if (mode =3D=3D ACL_NO_MODE)
> -               cifs_dbg(FYI, "illegal mode\n");
> +               cifs_dbg(FYI, "Invalid mode\n");
>         if (iov[num].iov_base =3D=3D NULL)
>                 return -ENOMEM;
>         iov[num].iov_len =3D sizeof(struct create_posix);
> @@ -904,9 +904,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s *ses)
>          * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...])=
;
>          */
>         if (rc =3D=3D -EOPNOTSUPP) {
> -               cifs_server_dbg(VFS, "Dialect not supported by server. Co=
nsider "
> -                       "specifying vers=3D1.0 or vers=3D2.0 on mount for=
 accessing"
> -                       " older servers\n");
> +               cifs_server_dbg(VFS, "Dialect not supported by server. Co=
nsider  specifying vers=3D1.0 or vers=3D2.0 on mount for accessing older se=
rvers\n");
>                 goto neg_exit;
>         } else if (rc !=3D 0)
>                 goto neg_exit;
> @@ -939,8 +937,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s *ses)
>         } else if (le16_to_cpu(rsp->DialectRevision) !=3D
>                                 server->vals->protocol_id) {
>                 /* if requested single dialect ensure returned dialect ma=
tched */
> -               cifs_server_dbg(VFS, "Illegal 0x%x dialect returned: not =
requested\n",
> -                       le16_to_cpu(rsp->DialectRevision));
> +               cifs_server_dbg(VFS, "Invalid 0x%x dialect returned: not =
requested\n",
> +                               le16_to_cpu(rsp->DialectRevision));
>                 return -EIO;
>         }
>
> @@ -957,8 +955,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_se=
s *ses)
>         else if (rsp->DialectRevision =3D=3D cpu_to_le16(SMB311_PROT_ID))
>                 cifs_dbg(FYI, "negotiated smb3.1.1 dialect\n");
>         else {
> -               cifs_server_dbg(VFS, "Illegal dialect returned by server =
0x%x\n",
> -                        le16_to_cpu(rsp->DialectRevision));
> +               cifs_server_dbg(VFS, "Invalid dialect returned by server =
0x%x\n",
> +                               le16_to_cpu(rsp->DialectRevision));
>                 rc =3D -EIO;
>                 goto neg_exit;
>         }
> @@ -1116,15 +1114,16 @@ int smb3_validate_negotiate(const unsigned int xi=
d, struct cifs_tcon *tcon)
>                 rc =3D 0;
>                 goto out_free_inbuf;
>         } else if (rc !=3D 0) {
> -               cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %=
d\n", rc);
> +               cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %=
d\n",
> +                             rc);
>                 rc =3D -EIO;
>                 goto out_free_inbuf;
>         }
>
>         rc =3D -EIO;
>         if (rsplen !=3D sizeof(*pneg_rsp)) {
> -               cifs_tcon_dbg(VFS, "invalid protocol negotiate response s=
ize: %d\n",
> -                        rsplen);
> +               cifs_tcon_dbg(VFS, "Invalid protocol negotiate response s=
ize: %d\n",
> +                             rsplen);
>
>                 /* relax check since Mac returns max bufsize allowed on i=
octl */
>                 if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp)=
)
> @@ -1357,9 +1356,8 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data=
)
>          * sending us a response in an expected form
>          */
>         if (msg->version !=3D CIFS_SPNEGO_UPCALL_VERSION) {
> -               cifs_dbg(VFS,
> -                         "bad cifs.upcall version. Expected %d got %d",
> -                         CIFS_SPNEGO_UPCALL_VERSION, msg->version);
> +               cifs_dbg(VFS, "bad cifs.upcall version. Expected %d got %=
d\n",
> +                        CIFS_SPNEGO_UPCALL_VERSION, msg->version);
>                 rc =3D -EKEYREJECTED;
>                 goto out_put_spnego_key;
>         }
> @@ -1369,8 +1367,7 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data=
)
>                 ses->auth_key.response =3D kmemdup(msg->data, msg->sesske=
y_len,
>                                                  GFP_KERNEL);
>                 if (!ses->auth_key.response) {
> -                       cifs_dbg(VFS,
> -                                "Kerberos can't allocate (%u bytes) memo=
ry",
> +                       cifs_dbg(VFS, "Kerberos can't allocate (%u bytes)=
 memory\n",
>                                  msg->sesskey_len);
>                         rc =3D -ENOMEM;
>                         goto out_put_spnego_key;
> @@ -1584,8 +1581,7 @@ SMB2_select_sec(struct cifs_ses *ses, struct SMB2_s=
ess_data *sess_data)
>         type =3D smb2_select_sectype(cifs_ses_server(ses), ses->sectype);
>         cifs_dbg(FYI, "sess setup type %d\n", type);
>         if (type =3D=3D Unspecified) {
> -               cifs_dbg(VFS,
> -                       "Unable to select appropriate authentication meth=
od!");
> +               cifs_dbg(VFS, "Unable to select appropriate authenticatio=
n method!\n");
>                 return -EINVAL;
>         }
>
> @@ -2812,8 +2808,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_=
parms *oparms, __le16 *path,
>                 trace_smb3_open_err(xid, tcon->tid, ses->Suid,
>                                     oparms->create_options, oparms->desir=
ed_access, rc);
>                 if (rc =3D=3D -EREMCHG) {
> -                       printk_once(KERN_WARNING "server share %s deleted=
\n",
> -                                   tcon->treeName);
> +                       pr_warn_once("server share %s deleted\n",
> +                                    tcon->treeName);
>                         tcon->need_reconnect =3D true;
>                 }
>                 goto creat_exit;
> @@ -3225,7 +3221,7 @@ smb2_validate_iov(unsigned int offset, unsigned int=
 buffer_length,
>         }
>
>         if ((begin_of_buf > end_of_smb) || (end_of_buf > end_of_smb)) {
> -               cifs_dbg(VFS, "illegal server response, bad offset to dat=
a\n");
> +               cifs_dbg(VFS, "Invalid server response, bad offset to dat=
a\n");
>                 return -EINVAL;
>         }
>
> @@ -4108,8 +4104,8 @@ smb2_writev_callback(struct mid_q_entry *mid)
>                                      tcon->tid, tcon->ses->Suid, wdata->o=
ffset,
>                                      wdata->bytes, wdata->result);
>                 if (wdata->result =3D=3D -ENOSPC)
> -                       printk_once(KERN_WARNING "Out of space writing to=
 %s\n",
> -                                   tcon->treeName);
> +                       pr_warn_once("Out of space writing to %s\n",
> +                                    tcon->treeName);
>         } else
>                 trace_smb3_write_done(0 /* no xid */,
>                                       wdata->cfile->fid.persistent_fid,
> @@ -4632,7 +4628,7 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
>         else if (resp_buftype =3D=3D CIFS_SMALL_BUFFER)
>                 srch_inf->smallBuf =3D true;
>         else
> -               cifs_tcon_dbg(VFS, "illegal search buffer type\n");
> +               cifs_tcon_dbg(VFS, "Invalid search buffer type\n");
>
>         return 0;
>  }
> diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
> index 1a5834..b029ed3 100644
> --- a/fs/cifs/smbdirect.c
> +++ b/fs/cifs/smbdirect.c
> @@ -294,15 +294,12 @@ static void send_done(struct ib_cq *cq, struct ib_w=
c *wc)
>
>  static void dump_smbd_negotiate_resp(struct smbd_negotiate_resp *resp)
>  {
> -       log_rdma_event(INFO, "resp message min_version %u max_version %u =
"
> -               "negotiated_version %u credits_requested %u "
> -               "credits_granted %u status %u max_readwrite_size %u "
> -               "preferred_send_size %u max_receive_size %u "
> -               "max_fragmented_size %u\n",
> -               resp->min_version, resp->max_version, resp->negotiated_ve=
rsion,
> -               resp->credits_requested, resp->credits_granted, resp->sta=
tus,
> -               resp->max_readwrite_size, resp->preferred_send_size,
> -               resp->max_receive_size, resp->max_fragmented_size);
> +       log_rdma_event(INFO, "resp message min_version %u max_version %u =
negotiated_version %u credits_requested %u credits_granted %u status %u max=
_readwrite_size %u preferred_send_size %u max_receive_size %u max_fragmente=
d_size %u\n",
> +                      resp->min_version, resp->max_version,
> +                      resp->negotiated_version, resp->credits_requested,
> +                      resp->credits_granted, resp->status,
> +                      resp->max_readwrite_size, resp->preferred_send_siz=
e,
> +                      resp->max_receive_size, resp->max_fragmented_size)=
;
>  }
>
>  /*
> @@ -450,10 +447,9 @@ static void recv_done(struct ib_cq *cq, struct ib_wc=
 *wc)
>         struct smbd_connection *info =3D response->info;
>         int data_length =3D 0;
>
> -       log_rdma_recv(INFO, "response=3D%p type=3D%d wc status=3D%d wc op=
code %d "
> -                     "byte_len=3D%d pkey_index=3D%x\n",
> -               response, response->type, wc->status, wc->opcode,
> -               wc->byte_len, wc->pkey_index);
> +       log_rdma_recv(INFO, "response=3D%p type=3D%d wc status=3D%d wc op=
code %d byte_len=3D%d pkey_index=3D%x\n",
> +                     response, response->type, wc->status, wc->opcode,
> +                     wc->byte_len, wc->pkey_index);
>
>         if (wc->status !=3D IB_WC_SUCCESS || wc->opcode !=3D IB_WC_RECV) =
{
>                 log_rdma_recv(INFO, "wc->status=3D%d opcode=3D%d\n",
> @@ -519,12 +515,11 @@ static void recv_done(struct ib_cq *cq, struct ib_w=
c *wc)
>                         wake_up_interruptible(&info->wait_send_queue);
>                 }
>
> -               log_incoming(INFO, "data flags %d data_offset %d "
> -                       "data_length %d remaining_data_length %d\n",
> -                       le16_to_cpu(data_transfer->flags),
> -                       le32_to_cpu(data_transfer->data_offset),
> -                       le32_to_cpu(data_transfer->data_length),
> -                       le32_to_cpu(data_transfer->remaining_data_length)=
);
> +               log_incoming(INFO, "data flags %d data_offset %d data_len=
gth %d remaining_data_length %d\n",
> +                            le16_to_cpu(data_transfer->flags),
> +                            le32_to_cpu(data_transfer->data_offset),
> +                            le32_to_cpu(data_transfer->data_length),
> +                            le32_to_cpu(data_transfer->remaining_data_le=
ngth));
>
>                 /* Send a KEEP_ALIVE response right away if requested */
>                 info->keep_alive_requested =3D KEEP_ALIVE_NONE;
> @@ -632,14 +627,10 @@ static int smbd_ia_open(
>         }
>
>         if (!frwr_is_supported(&info->id->device->attrs)) {
> -               log_rdma_event(ERR,
> -                       "Fast Registration Work Requests "
> -                       "(FRWR) is not supported\n");
> -               log_rdma_event(ERR,
> -                       "Device capability flags =3D %llx "
> -                       "max_fast_reg_page_list_len =3D %u\n",
> -                       info->id->device->attrs.device_cap_flags,
> -                       info->id->device->attrs.max_fast_reg_page_list_le=
n);
> +               log_rdma_event(ERR, "Fast Registration Work Requests (FRW=
R) is not supported\n");
> +               log_rdma_event(ERR, "Device capability flags =3D %llx max=
_fast_reg_page_list_len =3D %u\n",
> +                              info->id->device->attrs.device_cap_flags,
> +                              info->id->device->attrs.max_fast_reg_page_=
list_len);
>                 rc =3D -EPROTONOSUPPORT;
>                 goto out2;
>         }
> @@ -898,13 +889,12 @@ static int smbd_post_send_sgl(struct smbd_connectio=
n *info,
>         packet->remaining_data_length =3D cpu_to_le32(remaining_data_leng=
th);
>         packet->padding =3D 0;
>
> -       log_outgoing(INFO, "credits_requested=3D%d credits_granted=3D%d "
> -               "data_offset=3D%d data_length=3D%d remaining_data_length=
=3D%d\n",
> -               le16_to_cpu(packet->credits_requested),
> -               le16_to_cpu(packet->credits_granted),
> -               le32_to_cpu(packet->data_offset),
> -               le32_to_cpu(packet->data_length),
> -               le32_to_cpu(packet->remaining_data_length));
> +       log_outgoing(INFO, "credits_requested=3D%d credits_granted=3D%d d=
ata_offset=3D%d data_length=3D%d remaining_data_length=3D%d\n",
> +                    le16_to_cpu(packet->credits_requested),
> +                    le16_to_cpu(packet->credits_granted),
> +                    le32_to_cpu(packet->data_offset),
> +                    le32_to_cpu(packet->data_length),
> +                    le32_to_cpu(packet->remaining_data_length));
>
>         /* Map the packet to DMA */
>         header_length =3D sizeof(struct smbd_data_transfer);
> @@ -1078,11 +1068,9 @@ static int smbd_negotiate(struct smbd_connection *=
info)
>
>         response->type =3D SMBD_NEGOTIATE_RESP;
>         rc =3D smbd_post_recv(info, response);
> -       log_rdma_event(INFO,
> -               "smbd_post_recv rc=3D%d iov.addr=3D%llx iov.length=3D%x "
> -               "iov.lkey=3D%x\n",
> -               rc, response->sge.addr,
> -               response->sge.length, response->sge.lkey);
> +       log_rdma_event(INFO, "smbd_post_recv rc=3D%d iov.addr=3D%llx iov.=
length=3D%x iov.lkey=3D%x\n",
> +                      rc, response->sge.addr,
> +                      response->sge.length, response->sge.lkey);
>         if (rc)
>                 return rc;
>
> @@ -1540,25 +1528,19 @@ static struct smbd_connection *_smbd_get_connecti=
on(
>
>         if (smbd_send_credit_target > info->id->device->attrs.max_cqe ||
>             smbd_send_credit_target > info->id->device->attrs.max_qp_wr) =
{
> -               log_rdma_event(ERR,
> -                       "consider lowering send_credit_target =3D %d. "
> -                       "Possible CQE overrun, device "
> -                       "reporting max_cpe %d max_qp_wr %d\n",
> -                       smbd_send_credit_target,
> -                       info->id->device->attrs.max_cqe,
> -                       info->id->device->attrs.max_qp_wr);
> +               log_rdma_event(ERR, "consider lowering send_credit_target=
 =3D %d. Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
> +                              smbd_send_credit_target,
> +                              info->id->device->attrs.max_cqe,
> +                              info->id->device->attrs.max_qp_wr);
>                 goto config_failed;
>         }
>
>         if (smbd_receive_credit_max > info->id->device->attrs.max_cqe ||
>             smbd_receive_credit_max > info->id->device->attrs.max_qp_wr) =
{
> -               log_rdma_event(ERR,
> -                       "consider lowering receive_credit_max =3D %d. "
> -                       "Possible CQE overrun, device "
> -                       "reporting max_cpe %d max_qp_wr %d\n",
> -                       smbd_receive_credit_max,
> -                       info->id->device->attrs.max_cqe,
> -                       info->id->device->attrs.max_qp_wr);
> +               log_rdma_event(ERR, "consider lowering receive_credit_max=
 =3D %d. Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
> +                              smbd_receive_credit_max,
> +                              info->id->device->attrs.max_cqe,
> +                              info->id->device->attrs.max_qp_wr);
>                 goto config_failed;
>         }
>
> @@ -1865,11 +1847,9 @@ static int smbd_recv_buf(struct smbd_connection *i=
nfo, char *buf,
>                         to_read -=3D to_copy;
>                         data_read +=3D to_copy;
>
> -                       log_read(INFO, "_get_first_reassembly memcpy %d b=
ytes "
> -                               "data_transfer_length-offset=3D%d after t=
hat "
> -                               "to_read=3D%d data_read=3D%d offset=3D%d\=
n",
> -                               to_copy, data_length - offset,
> -                               to_read, data_read, offset);
> +                       log_read(INFO, "_get_first_reassembly memcpy %d b=
ytes data_transfer_length-offset=3D%d after that to_read=3D%d data_read=3D%=
d offset=3D%d\n",
> +                                to_copy, data_length - offset,
> +                                to_read, data_read, offset);
>                 }
>
>                 spin_lock_irq(&info->reassembly_queue_lock);
> @@ -1878,10 +1858,9 @@ static int smbd_recv_buf(struct smbd_connection *i=
nfo, char *buf,
>                 spin_unlock_irq(&info->reassembly_queue_lock);
>
>                 info->first_entry_offset =3D offset;
> -               log_read(INFO, "returning to thread data_read=3D%d "
> -                       "reassembly_data_length=3D%d first_entry_offset=
=3D%d\n",
> -                       data_read, info->reassembly_data_length,
> -                       info->first_entry_offset);
> +               log_read(INFO, "returning to thread data_read=3D%d reasse=
mbly_data_length=3D%d first_entry_offset=3D%d\n",
> +                        data_read, info->reassembly_data_length,
> +                        info->first_entry_offset);
>  read_rfc1002_done:
>                 return data_read;
>         }
> @@ -1952,7 +1931,7 @@ int smbd_recv(struct smbd_connection *info, struct =
msghdr *msg)
>
>         if (iov_iter_rw(&msg->msg_iter) =3D=3D WRITE) {
>                 /* It's a bug in upper layer to get there */
> -               cifs_dbg(VFS, "CIFS: invalid msg iter dir %u\n",
> +               cifs_dbg(VFS, "Invalid msg iter dir %u\n",
>                          iov_iter_rw(&msg->msg_iter));
>                 rc =3D -EINVAL;
>                 goto out;
> @@ -1974,7 +1953,7 @@ int smbd_recv(struct smbd_connection *info, struct =
msghdr *msg)
>
>         default:
>                 /* It's a bug in upper layer to get there */
> -               cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
> +               cifs_dbg(VFS, "Invalid msg type %d\n",
>                          iov_iter_type(&msg->msg_iter));
>                 rc =3D -EINVAL;
>         }
> @@ -2043,10 +2022,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                 dump_smb(iov[i].iov_base, iov[i].iov_len);
>
>
> -       log_write(INFO, "rqst_idx=3D%d nvec=3D%d rqst->rq_npages=3D%d rq_=
pagesz=3D%d "
> -               "rq_tailsz=3D%d buflen=3D%lu\n",
> -               rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz=
,
> -               rqst->rq_tailsz, smb_rqst_len(server, rqst));
> +       log_write(INFO, "rqst_idx=3D%d nvec=3D%d rqst->rq_npages=3D%d rq_=
pagesz=3D%d rq_tailsz=3D%d buflen=3D%lu\n",
> +                 rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_page=
sz,
> +                 rqst->rq_tailsz, smb_rqst_len(server, rqst));
>
>         start =3D i =3D 0;
>         buflen =3D 0;
> @@ -2056,11 +2034,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                         if (i > start) {
>                                 remaining_data_length -=3D
>                                         (buflen-iov[i].iov_len);
> -                               log_write(INFO, "sending iov[] from start=
=3D%d "
> -                                       "i=3D%d nvecs=3D%d "
> -                                       "remaining_data_length=3D%d\n",
> -                                       start, i, i-start,
> -                                       remaining_data_length);
> +                               log_write(INFO, "sending iov[] from start=
=3D%d i=3D%d nvecs=3D%d remaining_data_length=3D%d\n",
> +                                         start, i, i - start,
> +                                         remaining_data_length);
>                                 rc =3D smbd_post_send_data(
>                                         info, &iov[start], i-start,
>                                         remaining_data_length);
> @@ -2069,10 +2045,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                         } else {
>                                 /* iov[start] is too big, break it */
>                                 nvecs =3D (buflen+max_iov_size-1)/max_iov=
_size;
> -                               log_write(INFO, "iov[%d] iov_base=3D%p bu=
flen=3D%d"
> -                                       " break to %d vectors\n",
> -                                       start, iov[start].iov_base,
> -                                       buflen, nvecs);
> +                               log_write(INFO, "iov[%d] iov_base=3D%p bu=
flen=3D%d break to %d vectors\n",
> +                                         start, iov[start].iov_base,
> +                                         buflen, nvecs);
>                                 for (j =3D 0; j < nvecs; j++) {
>                                         vec.iov_base =3D
>                                                 (char *)iov[start].iov_ba=
se +
> @@ -2084,11 +2059,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                                                         max_iov_size*(nve=
cs-1);
>                                         remaining_data_length -=3D vec.io=
v_len;
>                                         log_write(INFO,
> -                                               "sending vec j=3D%d iov_b=
ase=3D%p"
> -                                               " iov_len=3D%zu "
> -                                               "remaining_data_length=3D=
%d\n",
> -                                               j, vec.iov_base, vec.iov_=
len,
> -                                               remaining_data_length);
> +                                               "sending vec j=3D%d iov_b=
ase=3D%p iov_len=3D%zu remaining_data_length=3D%d\n",
> +                                                 j, vec.iov_base, vec.io=
v_len,
> +                                                 remaining_data_length);
>                                         rc =3D smbd_post_send_data(
>                                                 info, &vec, 1,
>                                                 remaining_data_length);
> @@ -2106,11 +2079,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                         if (i =3D=3D rqst->rq_nvec) {
>                                 /* send out all remaining vecs */
>                                 remaining_data_length -=3D buflen;
> -                               log_write(INFO,
> -                                       "sending iov[] from start=3D%d i=
=3D%d "
> -                                       "nvecs=3D%d remaining_data_length=
=3D%d\n",
> -                                       start, i, i-start,
> -                                       remaining_data_length);
> +                               log_write(INFO, "sending iov[] from start=
=3D%d i=3D%d nvecs=3D%d remaining_data_length=3D%d\n",
> +                                         start, i, i - start,
> +                                         remaining_data_length);
>                                 rc =3D smbd_post_send_data(info, &iov[sta=
rt],
>                                         i-start, remaining_data_length);
>                                 if (rc)
> @@ -2134,10 +2105,9 @@ int smbd_send(struct TCP_Server_Info *server,
>                         if (j =3D=3D nvecs-1)
>                                 size =3D buflen - j*max_iov_size;
>                         remaining_data_length -=3D size;
> -                       log_write(INFO, "sending pages i=3D%d offset=3D%d=
 size=3D%d"
> -                               " remaining_data_length=3D%d\n",
> -                               i, j*max_iov_size+offset, size,
> -                               remaining_data_length);
> +                       log_write(INFO, "sending pages i=3D%d offset=3D%d=
 size=3D%d remaining_data_length=3D%d\n",
> +                                 i, j * max_iov_size + offset, size,
> +                                 remaining_data_length);
>                         rc =3D smbd_post_send_page(
>                                 info, rqst->rq_pages[i],
>                                 j*max_iov_size + offset,
> @@ -2211,11 +2181,9 @@ static void smbd_mr_recovery_work(struct work_stru=
ct *work)
>                                 info->pd, info->mr_type,
>                                 info->max_frmr_depth);
>                         if (IS_ERR(smbdirect_mr->mr)) {
> -                               log_rdma_mr(ERR,
> -                                       "ib_alloc_mr failed mr_type=3D%x =
"
> -                                       "max_frmr_depth=3D%x\n",
> -                                       info->mr_type,
> -                                       info->max_frmr_depth);
> +                               log_rdma_mr(ERR, "ib_alloc_mr failed mr_t=
ype=3D%x max_frmr_depth=3D%x\n",
> +                                           info->mr_type,
> +                                           info->max_frmr_depth);
>                                 smbd_disconnect_rdma_connection(info);
>                                 continue;
>                         }
> @@ -2278,9 +2246,8 @@ static int allocate_mr_list(struct smbd_connection =
*info)
>                 smbdirect_mr->mr =3D ib_alloc_mr(info->pd, info->mr_type,
>                                         info->max_frmr_depth);
>                 if (IS_ERR(smbdirect_mr->mr)) {
> -                       log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=3D%x=
 "
> -                               "max_frmr_depth=3D%x\n",
> -                               info->mr_type, info->max_frmr_depth);
> +                       log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=3D%x=
 max_frmr_depth=3D%x\n",
> +                                   info->mr_type, info->max_frmr_depth);
>                         goto out;
>                 }
>                 smbdirect_mr->sgl =3D kcalloc(
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index c97570..c359221 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -112,7 +112,7 @@ static void _cifs_mid_q_entry_release(struct kref *re=
fcount)
>  #ifdef CONFIG_CIFS_STATS2
>         now =3D jiffies;
>         if (now < midEntry->when_alloc)
> -               cifs_server_dbg(VFS, "invalid mid allocation time\n");
> +               cifs_server_dbg(VFS, "Invalid mid allocation time\n");
>         roundtrip_time =3D now - midEntry->when_alloc;
>
>         if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
> @@ -151,12 +151,12 @@ static void _cifs_mid_q_entry_release(struct kref *=
refcount)
>                 trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid=
,
>                                midEntry->when_sent, midEntry->when_receiv=
ed);
>                 if (cifsFYI & CIFS_TIMER) {
> -                       pr_debug(" CIFS slow rsp: cmd %d mid %llu",
> -                              midEntry->command, midEntry->mid);
> -                       cifs_info(" A: 0x%lx S: 0x%lx R: 0x%lx\n",
> -                              now - midEntry->when_alloc,
> -                              now - midEntry->when_sent,
> -                              now - midEntry->when_received);
> +                       pr_debug("slow rsp: cmd %d mid %llu",
> +                                midEntry->command, midEntry->mid);
> +                       cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
> +                                 now - midEntry->when_alloc,
> +                                 now - midEntry->when_sent,
> +                                 now - midEntry->when_received);
>                 }
>         }
>  #endif
> @@ -477,8 +477,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num=
_rqst,
>                 return -ENOMEM;
>
>         if (!server->ops->init_transform_rq) {
> -               cifs_server_dbg(VFS, "Encryption requested but transform =
"
> -                               "callback is missing\n");
> +               cifs_server_dbg(VFS, "Encryption requested but transform =
callback is missing\n");
>                 return -EIO;
>         }
>
> @@ -1300,8 +1299,8 @@ SendReceive(const unsigned int xid, struct cifs_ses=
 *ses,
>            use ses->maxReq */
>
>         if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
> -               cifs_server_dbg(VFS, "Illegal length, greater than maximu=
m frame, %d\n",
> -                        len);
> +               cifs_server_dbg(VFS, "Invalid length, greater than maximu=
m frame, %d\n",
> +                               len);
>                 return -EIO;
>         }
>
> @@ -1441,8 +1440,8 @@ SendReceiveBlockingLock(const unsigned int xid, str=
uct cifs_tcon *tcon,
>            use ses->maxReq */
>
>         if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
> -               cifs_tcon_dbg(VFS, "Illegal length, greater than maximum =
frame, %d\n",
> -                        len);
> +               cifs_tcon_dbg(VFS, "Invalid length, greater than maximum =
frame, %d\n",
> +                             len);
>                 return -EIO;
>         }
>
> --
> 2.26.0
>
>


--=20
Thanks,

Steve

--000000000000b3ccc705a6e48f5d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-minor-fix-to-two-debug-messages.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-minor-fix-to-two-debug-messages.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kau65y5s2>
X-Attachment-Id: f_kau65y5s2

RnJvbSBiOGUzN2ZiNjdhNTA1N2MxYmFkNDg2ZjAzYzRhNDU5MjhiYWUxYmEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFNhdCwgMzAgTWF5IDIwMjAgMTY6NDU6MTEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBtaW5vciBmaXggdG8gdHdvIGRlYnVnIG1lc3NhZ2VzCgpKb2UgUGVyY2hlcyBwb2ludGVk
IG91dCB0aGF0IHdlIHdlcmUgbWlzc2luZyBhIG5ld2xpbmUKYXQgdGhlIGVuZCBvZiB0d28gZGVi
dWcgbWVzc2FnZXMKClJlcG9ydGVkLWJ5OiBKb2UgUGVyY2hlcyA8am9lQHBlcmNoZXMuY29tPgpT
aWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQog
ZnMvY2lmcy9jaWZzc21iLmMgfCAyICstCiBmcy9jaWZzL3NtYjJwZHUuYyB8IDIgKy0KIDIgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2ZzL2NpZnMvY2lmc3NtYi5jIGIvZnMvY2lmcy9jaWZzc21iLmMKaW5kZXggNTgyMGY5NTY5Yjdm
Li5iZjQxZWUwNDgzOTYgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc3NtYi5jCisrKyBiL2ZzL2Np
ZnMvY2lmc3NtYi5jCkBAIC0xNzcsNyArMTc3LDcgQEAgc3RhdGljIGludCBfX2NpZnNfcmVjb25u
ZWN0X3Rjb24oY29uc3Qgc3RydWN0IG5sc190YWJsZSAqbmxzYywKIAogCQlpZiAoZGZzX2hvc3Rf
bGVuICE9IHRjcF9ob3N0X2xlbgogCQkgICAgfHwgc3RybmNhc2VjbXAoZGZzX2hvc3QsIHRjcF9o
b3N0LCBkZnNfaG9zdF9sZW4pICE9IDApIHsKLQkJCWNpZnNfZGJnKEZZSSwgIiVzOiAlLipzIGRv
ZXNuJ3QgbWF0Y2ggJS4qcyIsCisJCQljaWZzX2RiZyhGWUksICIlczogJS4qcyBkb2Vzbid0IG1h
dGNoICUuKnNcbiIsCiAJCQkJIF9fZnVuY19fLAogCQkJCSAoaW50KWRmc19ob3N0X2xlbiwgZGZz
X2hvc3QsCiAJCQkJIChpbnQpdGNwX2hvc3RfbGVuLCB0Y3BfaG9zdCk7CmRpZmYgLS1naXQgYS9m
cy9jaWZzL3NtYjJwZHUuYyBiL2ZzL2NpZnMvc21iMnBkdS5jCmluZGV4IDRiNzkxODFmZjg3Mi4u
MDY0NjNmMzg2YTYwIDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJwZHUuYworKysgYi9mcy9jaWZz
L3NtYjJwZHUuYwpAQCAtMjA5LDcgKzIwOSw3IEBAIHN0YXRpYyBpbnQgX19zbWIyX3JlY29ubmVj
dChjb25zdCBzdHJ1Y3QgbmxzX3RhYmxlICpubHNjLAogCiAJCWlmIChkZnNfaG9zdF9sZW4gIT0g
dGNwX2hvc3RfbGVuCiAJCSAgICB8fCBzdHJuY2FzZWNtcChkZnNfaG9zdCwgdGNwX2hvc3QsIGRm
c19ob3N0X2xlbikgIT0gMCkgewotCQkJY2lmc19kYmcoRllJLCAiJXM6ICUuKnMgZG9lc24ndCBt
YXRjaCAlLipzIiwKKwkJCWNpZnNfZGJnKEZZSSwgIiVzOiAlLipzIGRvZXNuJ3QgbWF0Y2ggJS4q
c1xuIiwKIAkJCQkgX19mdW5jX18sCiAJCQkJIChpbnQpZGZzX2hvc3RfbGVuLCBkZnNfaG9zdCwK
IAkJCQkgKGludCl0Y3BfaG9zdF9sZW4sIHRjcF9ob3N0KTsKLS0gCjIuMjUuMQoK
--000000000000b3ccc705a6e48f5d--
