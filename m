Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF56C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E3C20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ngP4xCY6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBFRl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:41:56 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45263 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgBFRl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:41:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so8203793wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 09:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U9OXcPG12UwPDGhba8aZ3jjsJVsDnAQO2tciRVW5geM=;
        b=ngP4xCY6wacbOmTHhsdVSF55kYaEkRBzdNC8IfeIIDmlXeTpghQhsdfTcqEOact+Z8
         45/VpoCP29aWKah4DwRmKwNs9rB5TnJQMP3eoL3o/e/NxbxkPEDV2ug2LllijRL7uCt1
         ZrvYPmZ3ZoP9z8eHheKw7Hoz02m5DRcSGZS2iXLBYre6cHLXbEtp5o4XZ9b1qMR6HO4A
         MG97uN8mP70pXGy9OOZwpB2DuXyMPS/xT+MTZKfRygbX/FcMTu+7/1ERA4ugH+WWpkzp
         WpT4m6ifOEQlHgemP3J31mMROxAuru0BVPIT/PNUaWkh/TGJcn2KIMRuD1Z2goXHfkTN
         aYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U9OXcPG12UwPDGhba8aZ3jjsJVsDnAQO2tciRVW5geM=;
        b=O+iPSo/7BbOuhFGUnxFQzMGXSQWVCJTg4EEixgKyYPhMMDlrLTzgbzh/RNzoBMTZZK
         Ph5EPOmUIDkqTetXHHGyqwY1Uk0LvcNNnYjDS+eaGhsPFrOPS12NKTweN7TRVAduQod9
         b5y8stnrldTTkA7/ZxGQjjbs1JAmeSVeDqPwp+LUjth/PrOnjxBsHs1fY9TYJHcLlH2U
         VfpCfqq5i8GVEP+Jsxeq04QW3J89RKhBdthOdsbCPwQ1YM+1ONTsMxxhe8KH6M5IlZoI
         eNAeCbhPC9ZocyIH+gj97vXEQqOAwrrVme/mpPfNR91d+3NQdcWvt1uWUTz8hszNFIj+
         Ub3A==
X-Gm-Message-State: APjAAAWUDQ6Eo66yyTuZTheiaFjsNsuPFUduVdpKb7emDzCYZCnEooj1
        DDQXr47CTcJfw+I9jxuIHtuQPdD53nk41+UjZ08h3g==
X-Google-Smtp-Source: APXvYqzjet/hfRBYfmZFgn0400om2VW1KPBkeTebjwpDzwK/tu31IXYR6QjG29lShPEHGwpObeWmwfJOA7LMKGTzCvE=
X-Received: by 2002:adf:e683:: with SMTP id r3mr5226274wrm.38.1581010912572;
 Thu, 06 Feb 2020 09:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20200206165527.211350-1-smoreland@google.com> <91465612-2fb2-5985-ba45-d4d9fcf0f70c@tycho.nsa.gov>
 <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov>
In-Reply-To: <c61fc8f6-55c2-c717-5090-e535b7bdbb4f@tycho.nsa.gov>
From:   Steven Moreland <smoreland@google.com>
Date:   Thu, 6 Feb 2020 09:41:41 -0800
Message-ID: <CAKLm694DMH0JCpHuT4HgMd4yCNJZPFMpex8iEiRF9kRjPb0d6g@mail.gmail.com>
Subject: Re: [PATCH] security: selinux: allow per-file labeling for bpffs
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     paul@paul-moore.com, eparis@parisplace.org, keescook@chromium.org,
        anton@enomsg.org, Colin Cross <ccross@android.com>,
        tony.luck@intel.com, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        "Connor O'Brien" <connoro@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 9:35 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
>
> On 2/6/20 12:21 PM, Stephen Smalley wrote:
> > On 2/6/20 11:55 AM, Steven Moreland wrote:
> >> From: Connor O'Brien <connoro@google.com>
> >>
> >> Add support for genfscon per-file labeling of bpffs files. This allows
> >> for separate permissions for different pinned bpf objects, which may
> >> be completely unrelated to each other.
> >
> > Do you want bpf fs to also support userspace labeling of files via
> > setxattr()?  If so, you'll want to also add it to
> > selinux_is_genfs_special_handling() as well.
> >

Android doesn't currently have this use case.

> > The only caveat I would note here is that it appears that bpf fs
> > supports rename, link, unlink, rmdir etc by userspace, which means that
> > name-based labeling via genfscon isn't necessarily safe/stable.  See
> > https://github.com/SELinuxProject/selinux-kernel/issues/2
> >

Android restricts ownership of these files to a single process (bpfloader) and
so this isn't a concern in our architecture. Is it a concern in general?

> >> Change-Id: I03ae28d3afea70acd6dc53ebf810b34b357b6eb5
> >
> > Drop Change-Ids from patches submitted upstream please since they aren't
> > meaningful outside of Android.
> >

Yeah, will resubmit, thanks.

> >> Signed-off-by: Connor O'Brien <connoro@google.com>
> >> Signed-off-by: Steven Moreland <smoreland@google.com>
> >> ---
> >>   security/selinux/hooks.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> >> index de4887742d7c..4f9396e6ce8c 100644
> >> --- a/security/selinux/hooks.c
> >> +++ b/security/selinux/hooks.c
> >> @@ -872,6 +872,7 @@ static int selinux_set_mnt_opts(struct super_block
> >> *sb,
> >>           !strcmp(sb->s_type->name, "sysfs") ||
> >>           !strcmp(sb->s_type->name, "pstore") ||
> >>           !strcmp(sb->s_type->name, "binder") ||
> >> +        !strcmp(sb->s_type->name, "bpf") ||
> >>           !strcmp(sb->s_type->name, "cgroup") ||
> >>           !strcmp(sb->s_type->name, "cgroup2"))
> >>           sbsec->flags |= SE_SBGENFS;
> >>
>
> Also, your patch appears to be based on an old kernel and won't apply
> upstream; see
> https://github.com/SELinuxProject/selinux-kernel/blob/master/README.md
>

Will resubmit, thanks.
