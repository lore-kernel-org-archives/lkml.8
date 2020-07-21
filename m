Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D329EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A895A2077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="PShVHcuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgGUPUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729647AbgGUPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:20:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE467C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:20:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a21so22010539ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVY6ngE/wUOCAJ5ZXM4RxqaDGgVG+i4hISevEon3J24=;
        b=PShVHcuB5n4LdkFuYUlDfgcU4l08VeViecqRx966bZmdDekCay/647wqbwHHKhJtOA
         PIA/K7ogQS3s25r6G+G+VT8OM8fo1SCTSkTata49MSs/DVqOwyBLqZYY91Va/sy7huBS
         SSp9ickzRl9a5mQOl1C0lxefP8AJ0CY33iNKW1PGZOmgNYsfdwkDCPXcMUzeAWnEpOLG
         XkjAzSXGbgKXIWyZoUtUwOUtftpg8ywhv7PteOJ7SgJ5Qwxh+5UD+wOfs/FGZeqKlnCz
         i+1e6Vu+HDvEMMw/8VMIwRZHMAxTnmrDjjdI3xrrIBk/sOCnnsicY19qC+eKF0bWxy1Y
         5oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVY6ngE/wUOCAJ5ZXM4RxqaDGgVG+i4hISevEon3J24=;
        b=uLSqfXHgKguvjSkON7SIF7V78Lqi5k2w4JSxc4/1JshJWjya/3BfWrMsmOgOZAnlMh
         1qp1RIDxZUMHVooR95o8EenRfhtGl9reumrS+dlFMfooYg817YJInKJjmDX3KZwpltlm
         Yexgcxl+WmXjx7cMH2OEWpWJnvJT9/DvhU8Q175cqy9zZH9gydWu9UVmf7xsuulY4kjp
         84GzfniizRulTRMKjw1pqfnThAvkfNCcBEgbVuLGHA4lgtgcEJEsptGqKKBXW8nMp26P
         cmWWgu7tERms6t8FivrDmRbYoWe8lXWAefszU7PmNE+fgV07XhkC13ASuhTYJzajk1E5
         qNaw==
X-Gm-Message-State: AOAM53182aXW26V/vkb0j0Zrja0SG3bL4vK2yBGvJ2OtQhHUnXolVrSz
        jQC+2SBBeqhpKGEM10ef5sKNDCpPB5MnT3DyieXZ
X-Google-Smtp-Source: ABdhPJyNzk5GLZaq6SyY71ytrhwHNZi9iL0vlh9sSlF2PECzAISmANF5Ujh2IweRLkFCRobwdafunNhRjthEJcQwAWk=
X-Received: by 2002:a17:906:1a59:: with SMTP id j25mr24366780ejf.398.1595344810149;
 Tue, 21 Jul 2020 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <6effbbd4574407d6af21162e57d9102d5f8b02ed.1594664015.git.rgb@redhat.com>
 <CAHC9VhSyq7yKQqwvHL5syU9+TFki6-__WfCrvqewbnU3xpND4Q@mail.gmail.com>
 <20200714174353.ds7lj3iisy67t2zu@madcap2.tricolour.ca> <CAHC9VhQusQsdQc7EfdjdH5mp6qqqYVPHnG9nNhUhf3DS_cdWwA@mail.gmail.com>
 <20200714210027.me2ieywjfcsf4v5r@madcap2.tricolour.ca>
In-Reply-To: <20200714210027.me2ieywjfcsf4v5r@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 21 Jul 2020 11:19:59 -0400
Message-ID: <CAHC9VhQgDGPutYxQawMPmezm1a+i1nXO5KSn9_7KPDZsRBJ4pw@mail.gmail.com>
Subject: Re: [PATCH ghak84 v4] audit: purge audit_log_string from the
 intra-kernel audit API
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     john.johansen@canonical.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 5:00 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-14 16:29, Paul Moore wrote:
> > On Tue, Jul 14, 2020 at 1:44 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2020-07-14 12:21, Paul Moore wrote:
> > > > On Mon, Jul 13, 2020 at 3:52 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > >
> > > > > audit_log_string() was inteded to be an internal audit function and
> > > > > since there are only two internal uses, remove them.  Purge all external
> > > > > uses of it by restructuring code to use an existing audit_log_format()
> > > > > or using audit_log_format().
> > > > >
> > > > > Please see the upstream issue
> > > > > https://github.com/linux-audit/audit-kernel/issues/84
> > > > >
> > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > ---
> > > > > Passes audit-testsuite.
> > > > >
> > > > > Changelog:
> > > > > v4
> > > > > - use double quotes in all replaced audit_log_string() calls
> > > > >
> > > > > v3
> > > > > - fix two warning: non-void function does not return a value in all control paths
> > > > >         Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > v2
> > > > > - restructure to piggyback on existing audit_log_format() calls, checking quoting needs for each.
> > > > >
> > > > > v1 Vlad Dronov
> > > > > - https://github.com/nefigtut/audit-kernel/commit/dbbcba46335a002f44b05874153a85b9cc18aebf
> > > > >
> > > > >  include/linux/audit.h     |  5 -----
> > > > >  kernel/audit.c            |  4 ++--
> > > > >  security/apparmor/audit.c | 10 ++++------
> > > > >  security/apparmor/file.c  | 25 +++++++------------------
> > > > >  security/apparmor/ipc.c   | 46 +++++++++++++++++++++++-----------------------
> > > > >  security/apparmor/net.c   | 14 ++++++++------
> > > > >  security/lsm_audit.c      |  4 ++--
> > > > >  7 files changed, 46 insertions(+), 62 deletions(-)
> > > >
> > > > Thanks for restoring the quotes, just one question below ...
> > > >
> > > > > diff --git a/security/apparmor/ipc.c b/security/apparmor/ipc.c
> > > > > index 4ecedffbdd33..fe36d112aad9 100644
> > > > > --- a/security/apparmor/ipc.c
> > > > > +++ b/security/apparmor/ipc.c
> > > > > @@ -20,25 +20,23 @@
> > > > >
> > > > >  /**
> > > > >   * audit_ptrace_mask - convert mask to permission string
> > > > > - * @buffer: buffer to write string to (NOT NULL)
> > > > >   * @mask: permission mask to convert
> > > > > + *
> > > > > + * Returns: pointer to static string
> > > > >   */
> > > > > -static void audit_ptrace_mask(struct audit_buffer *ab, u32 mask)
> > > > > +static const char *audit_ptrace_mask(u32 mask)
> > > > >  {
> > > > >         switch (mask) {
> > > > >         case MAY_READ:
> > > > > -               audit_log_string(ab, "read");
> > > > > -               break;
> > > > > +               return "read";
> > > > >         case MAY_WRITE:
> > > > > -               audit_log_string(ab, "trace");
> > > > > -               break;
> > > > > +               return "trace";
> > > > >         case AA_MAY_BE_READ:
> > > > > -               audit_log_string(ab, "readby");
> > > > > -               break;
> > > > > +               return "readby";
> > > > >         case AA_MAY_BE_TRACED:
> > > > > -               audit_log_string(ab, "tracedby");
> > > > > -               break;
> > > > > +               return "tracedby";
> > > > >         }
> > > > > +       return "";
> > > >
> > > > Are we okay with this returning an empty string ("") in this case?
> > > > Should it be a question mark ("?")?
> > > >
> > > > My guess is that userspace parsing should be okay since it still has
> > > > quotes, I'm just not sure if we wanted to use a question mark as we do
> > > > in other cases where the field value is empty/unknown.
> > >
> > > Previously, it would have been an empty value, not even double quotes.
> > > "?" might be an improvement.
> >
> > Did you want to fix that now in this patch, or leave it to later?  As
> > I said above, I'm not too bothered by it with the quotes so either way
> > is fine by me.
>
> I'd defer to Steve, otherwise I'd say leave it, since there wasn't
> anything there before and this makes that more evident.
>
> > John, I'm assuming you are okay with this patch?

With no comments from John or Steve in the past week, I've gone ahead
and merged the patch into audit/next.

-- 
paul moore
www.paul-moore.com
