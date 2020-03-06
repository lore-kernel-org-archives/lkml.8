Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC27C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC2120656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urjBIsmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:36:46 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38777 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgCFRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:36:46 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so1368333pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0th24Aw7poXV2kDwcH+eb4lyzzSHKTu9OdyFQYJbKkY=;
        b=urjBIsmYRvK1sp8Bv2kbwI4OZeXV5hOijJXEOX5UUfyVmfgn7n76vk1GDm8S56Klct
         AaTMpGvZ5HE4TwifQAa/d0/6Oz5R5P/W17mv+pPW/uOahjODGheCXtDXwSh+8bTTQklL
         39OQbbiYsxrC9XR3fSPlFJEm50zA73I0umb0i+QeJ+vPctKceXvOFv/zMlgD9JkvXCcN
         FaE25ev7o8HC7e+HtWK93b82PcMqTpjHJUAmZuWwu2nhy43aTeN4gi0OOSmap2ksWZIJ
         ydbMol/irvq4q+i1Bb0nmMUKko59rFUKroUkKOiOtPv1CdWDxvSXX1OpGqQ5EkykeszI
         WKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0th24Aw7poXV2kDwcH+eb4lyzzSHKTu9OdyFQYJbKkY=;
        b=SgV6lO2wTei4SGwv5j19a94us4CMIDnQTLT0VQMLKeQt3qOx5WO/LC6vnw+EIougi2
         HV574CSlN0fc+JpElXtLDbMfSG6C0oZZPQSzO02nn8bSq39HkfZ6CqfgU6bMTn7vIPbf
         TvXVQPWh2NSIdxfKkQSpo7vVWdwT5cS8BL6eYb6iAMNMCCJjzsdJD0dGQXPrSIGNpNdR
         ZbpdPWaJpWfwuKC+qrq+34erX4oqrlp5rJu9bccTEA0K6Rpv0fwzbl29x/XbaJFnaL5V
         tOUl9DsxpLWYMZf0gd9P0dV7bXoN8+NLDmb5eP+bxwMVj0fSz/AcMGiRXmZ/A3evuVvi
         Huuw==
X-Gm-Message-State: ANhLgQ27dh4GmjrGG8A9STEsebb2/8ppAtwKDluOcWFegP24Xk4Z5MTN
        wYWdjwIXjyc4l/RwW9F6azA9qCs4enrX+bbHVJWadTT4
X-Google-Smtp-Source: ADFU+vt9a6IY6oRt2STnFrh2CYGkjgjagZGDV8DawLnE5rRIkjzRpQekuW+IE2ZLZ5P/ZYvUs8+Q6nesz6drxHr/5Bs=
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr4795428pja.27.1583516201411;
 Fri, 06 Mar 2020 09:36:41 -0800 (PST)
MIME-Version: 1.0
References: <202003060930.DDCCB6659@keescook>
In-Reply-To: <202003060930.DDCCB6659@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Mar 2020 09:36:30 -0800
Message-ID: <CAKwvOdn4q4OWzvhAMHFf441DNrmO00ye_H_MnoegP7jw3YAWqA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/edid: Distribute switch variables for initialization
To:     Kees Cook <keescook@chromium.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 9:32 AM Kees Cook <keescook@chromium.org> wrote:
>
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=3Dy) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent

That's not good, have you filed a bug against Clang yet?  It should at
least warn when the corresponding stack init flag is set.

> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
>
> To avoid these problems, lift such variables up into the next code
> block.
>
> drivers/gpu/drm/drm_edid.c: In function =E2=80=98drm_edid_to_eld=E2=80=99=
:
> drivers/gpu/drm/drm_edid.c:4395:9: warning: statement will never be
> executed [-Wswitch-unreachable]
>  4395 |     int sad_count;
>       |         ^~~~~~~~~
>
> [1] https://bugs.llvm.org/show_bug.cgi?id=3D44916
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> v2: move into function block instead being switch-local (Ville Syrj=C3=A4=
l=C3=A4)
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 805fb004c8eb..46cee78bc175 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -4381,6 +4381,7 @@ static void drm_edid_to_eld(struct drm_connector *c=
onnector, struct edid *edid)
>
>         if (cea_revision(cea) >=3D 3) {
>                 int i, start, end;
> +               int sad_count;
>
>                 if (cea_db_offsets(cea, &start, &end)) {
>                         start =3D 0;
> @@ -4392,8 +4393,6 @@ static void drm_edid_to_eld(struct drm_connector *c=
onnector, struct edid *edid)
>                         dbl =3D cea_db_payload_len(db);
>
>                         switch (cea_db_tag(db)) {
> -                               int sad_count;
> -
>                         case AUDIO_BLOCK:
>                                 /* Audio Data Block, contains SADs */
>                                 sad_count =3D min(dbl / 3, 15 - total_sad=
_count);
> --
> 2.20.1
>
>
> --
> Kees Cook
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/202003060930.DDCCB6659%40keescook.



--=20
Thanks,
~Nick Desaulniers
