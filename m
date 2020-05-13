Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F9C2D0FB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299A2206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 01:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cSolVG+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732106AbgEMBEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 21:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgEMBEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 21:04:43 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B38C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 18:04:42 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x1so12671946ejd.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 18:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fj4opsPMDblqFUFIej0/iRtaonK5CbR7vEqqPMW7suo=;
        b=cSolVG+V9TjCt0pigpGPrE2bDc55Y6SIA4M75EFxVCrmdwd45jUcJbiolGStxazqhO
         +LQ51n2r3619oSKe9EcqrtPHPPt3znHrE9XerOH6JeIDMGK+ErRmON4h9mJCw7klbtxz
         a7bPNo07JX5zFIw1+UsZdaEGS2Krvd30LkEm27qpRH5edqWqiGjbsaFjfmjYADUN3P3F
         dcnEABd6N3fR2NUREBHRQcWr23xSP3J2eqCpNaRYVIk6sDSRKwafzAEDe4cKh0XhXdJR
         LH7dgPKz83m9mmDIyxvenlfPq/2IQ1SU6eNP2879YvGr2FR+xiZrWm6nazmbYubgpeST
         3qUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fj4opsPMDblqFUFIej0/iRtaonK5CbR7vEqqPMW7suo=;
        b=h1xi4HIJgnonHiN2ymuXJrimscQ9DOEL1zTcXdKaS1nQ2GXOIYdrIWqR3rkBaG6nwA
         DwY4imrsjKtdZkg69Sh29a+zEX6ybX/vGRFNWJEY5WhYJHzkewl/vVKyATWpEin3Q+Lp
         iKKCN+6pL4QvfSmiHKPiwvwNUAeBzTbg0ZHg4h03NDXAL7gwAYiVdmXy5kCKaXkNNe29
         iamqNd7GrDMa5hyFR9mZ9nsX3kDo8F1W752pdN9J0yyQXMBM1W8Hs3lyOBD190vaHf2I
         wp4TeygQGQEi1aNFARCf8/sVCiyxV2MJSICSJM40lcCVzpH/Zrl6vO0+fyYHK4Q1VJhS
         Dzmg==
X-Gm-Message-State: AGi0Pub8IfUQyznSWJ6mMKBuk9FDmx0kTFhYQvsvl/U9/6mU4xAIgcNs
        eBdW68H3Ys7qtUDzv8VLsSHbML4xfCpotnHh0RP1Is/7kQ==
X-Google-Smtp-Source: APiQypLPMo6NpS/jVOE7h4tTgOx35FR4dSq5IjzFg7m9DKJ6aj2r5nCeoldQwIvFU7wkrFX1ByHhJgYGQABp8XHSSHA=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr17037312ejf.308.1589331880824;
 Tue, 12 May 2020 18:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAEjxPJ6pFdDfm55pv9bT3CV5DTFF9VqzRmG_Xi5bKNxPaGuOLg@mail.gmail.com>
 <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
In-Reply-To: <158932282880.2885325.2688622278854566047.stgit@warthog.procyon.org.uk>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 May 2020 21:04:29 -0400
Message-ID: <CAHC9VhQhYz8xZ6MGv0S9q2D-gReb0Pqqb=2+oX=NVuxb_F5WfA@mail.gmail.com>
Subject: Re: [PATCH] keys: Make the KEY_NEED_* perms an enum rather than a mask
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 6:33 PM David Howells <dhowells@redhat.com> wrote:
> Since the meaning of combining the KEY_NEED_* constants is undefined, make
> it so that you can't do that by turning them into an enum.
>
> The enum is also given some extra values to represent special
> circumstances, such as:
>
>  (1) The '0' value is reserved and causes a warning to trap the parameter
>      being unset.
>
>  (2) The key is to be unlinked and we require no permissions on it, only
>      the keyring, (this replaces the KEY_LOOKUP_FOR_UNLINK flag).
>
>  (3) An override due to CAP_SYS_ADMIN.
>
>  (4) An override due to an instantiation token being present.
>
>  (5) The permissions check is being deferred to later key_permission()
>      calls.
>
> The extra values give the opportunity for LSMs to audit these situations.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> cc: Paul Moore <paul@paul-moore.com>
> cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> cc: Casey Schaufler <casey@schaufler-ca.com>
> cc: keyrings@vger.kernel.org
> cc: selinux@vger.kernel.org
> ---
>
>  include/linux/key.h          |   30 ++++++++++++++++-----------
>  include/linux/security.h     |    6 +++--
>  security/keys/internal.h     |    8 ++++---
>  security/keys/keyctl.c       |   16 ++++++++-------
>  security/keys/permission.c   |   31 ++++++++++++++++++++++------
>  security/keys/process_keys.c |   46 ++++++++++++++++++++----------------------
>  security/security.c          |    6 +++--
>  security/selinux/hooks.c     |   25 ++++++++++++++++-------
>  security/smack/smack_lsm.c   |   31 +++++++++++++++++++++-------
>  9 files changed, 124 insertions(+), 75 deletions(-)

Thanks for clarifying this, it helps a lot.

My comments below are nitpicky, but take them into account, the style
of the SELinux code changes makes my eyes hurt.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 0b4e32161b77..3ff6b6dfc5ca 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6541,20 +6541,31 @@ static void selinux_key_free(struct key *k)
>
>  static int selinux_key_permission(key_ref_t key_ref,
>                                   const struct cred *cred,
> -                                 unsigned perm)
> +                                 enum key_need_perm need_perm)
>  {
>         struct key *key;
>         struct key_security_struct *ksec;
> -       u32 sid;
> +       u32 perm, sid;
>
> -       /* if no specific permissions are requested, we skip the
> -          permission check. No serious, additional covert channels
> -          appear to be created. */
> -       if (perm == 0)
> +       switch (need_perm) {
> +       case KEY_NEED_UNLINK:
> +       case KEY_SYSADMIN_OVERRIDE:
> +       case KEY_AUTHTOKEN_OVERRIDE:
> +       case KEY_DEFER_PERM_CHECK:
>                 return 0;
> +       default:
> +               WARN_ON(1);
> +               return -EPERM;

Please move the default case to the bottom of the switch statement.

> -       sid = cred_sid(cred);
> +       case KEY_NEED_VIEW:     perm = KEY__VIEW;       break;
> +       case KEY_NEED_READ:     perm = KEY__READ;       break;
> +       case KEY_NEED_WRITE:    perm = KEY__WRITE;      break;
> +       case KEY_NEED_SEARCH:   perm = KEY__SEARCH;     break;
> +       case KEY_NEED_LINK:     perm = KEY__LINK;       break;
> +       case KEY_NEED_SETATTR:  perm = KEY__SETATTR;    break;

Please don't put the case statements all on one line, use the more
traditional multi-line format.  For example:

  case KEY_NEED_SETATTR:
          perm = KEY__SETATTR;
          break;

> +       }
>
> +       sid = cred_sid(cred);
>         key = key_ref_to_ptr(key_ref);
>         ksec = key->security;

-- 
paul moore
www.paul-moore.com
