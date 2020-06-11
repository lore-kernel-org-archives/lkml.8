Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE8A20835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="mVD8qanY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgFKX11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFKX10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:27:26 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFCDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:27:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id o26so5148620edq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 16:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyFEm4+7Wbt8Mmq80/X+KHS7uI1Dwb9CNGXNsovM9X4=;
        b=mVD8qanYyMWIlYlfuy6lWtTm4E5npt5kmjQ7FrPCuEFjbKUttZOLTTonm5aQ7js1Nx
         E01R9KCCSEfNzJ/05sNHKihBxNE4bgxmMZppuqrm6ITsIVzQrcqHSNxRXH7AbNv06Rao
         3vaJqHTvLResTQA48BiqmPtD4+Qan31jcg3qTjxpEuBlZgy4xlnmxxv4/5v1Oj2/R3KU
         DRWrKbzKG8d9HiZm3eCLg1y9s7nJ2OCu3xGAm2lMkVFVcTEihWZUrrq66cl59NTBgcy1
         myqBg78ntowatx1QDfmv4qHiFWhNmFZR66+gUqqkI1Dfzntka0XR9Pjzk0fw55HDfByl
         r1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyFEm4+7Wbt8Mmq80/X+KHS7uI1Dwb9CNGXNsovM9X4=;
        b=Xd5PJm+ruo7Eq29KeZIwVi5Vwo7eWemd8SCQl+7o+iM2plGTSHcxK1wsQN1TButPC7
         4cs/mzX7pvrF5pNNAGNOrZbUc5BPL1klOD4C/GJnrnHSGEy8jNItoIgYMGoAefmuEchT
         ilqPqItuQVgWe5oyzQNUtCOhNFJcmdqOqoHm5LdbrPMhXXUeMdVwaPzvq0KdB034NBvw
         eATrcE28W+TV3+66O6qzmw+dWGbZcNuJs0bn3RppiO9kkkzYUnLXpGUzqj/Kv4j12Ni7
         vlLW9G25DDOcLkAkjVxWEBj0z1A2F3BT4EybrtYIoHD+rLTqwWMc3W6O2UhQkg0wZSnO
         cvBA==
X-Gm-Message-State: AOAM5315wV6Ku9/5wGylSH1mLh5XndJRn4I7huioLGnqb8rEFut9ywy5
        NfgyXqB95dxyOfFMa89nDrwmK+oVpNCxu592SbBT
X-Google-Smtp-Source: ABdhPJzakvGIvVBniD6JSqwchh1ay5vYYMD1PJ1sD7COF2jiYZWnwOCoqJaWPBArP4fOKRUGf6nYV36IaKy33V0JIh0=
X-Received: by 2002:aa7:de08:: with SMTP id h8mr8876666edv.164.1591918043429;
 Thu, 11 Jun 2020 16:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200611204746.6370-1-trix@redhat.com> <20200611204746.6370-2-trix@redhat.com>
 <CAHC9VhSyo9GZKVZ04w3d3bLV9-_61W0KznATZPmqZBYXT2J=xw@mail.gmail.com> <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com>
In-Reply-To: <d8cee44a-316f-d1be-9893-428598ada2d8@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Jun 2020 19:27:12 -0400
Message-ID: <CAHC9VhSPygyQAiWuaAWViuraCP6A9KTqmQeEt2_Rxta_WFsu5Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] selinux: fix another double free
To:     Tom Rix <trix@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 6:41 PM Tom Rix <trix@redhat.com> wrote:
> On 6/11/20 3:30 PM, Paul Moore wrote:
> > On Thu, Jun 11, 2020 at 4:48 PM <trix@redhat.com> wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> Clang static analysis reports this double free error
> >>
> >> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
> >>         kfree(node->expr.nodes);
> >>         ^~~~~~~~~~~~~~~~~~~~~~~
> >>
> >> When cond_read_node fails, it calls cond_node_destroy which frees the
> >> node but does not poison the entry in the node list.  So when it
> >> returns to its caller cond_read_list, cond_read_list deletes the
> >> partial list.  The latest entry in the list will be deleted twice.
> >>
> >> So instead of freeing the node in cond_read_node, let list freeing in
> >> code_read_list handle the freeing the problem node along with all of the
> >> earlier nodes.
> >>
> >> Because cond_read_node no longer does any error handling, the goto's
> >> the error case are redundant.  Instead just return the error code.
> >>
> >> Fixes a problem was introduced by commit
> >>
> >>   selinux: convert cond_list to array
> >>
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >> ---
> >>  security/selinux/ss/conditional.c | 11 +++--------
> >>  1 file changed, 3 insertions(+), 8 deletions(-)
> > Hi Tom,
> >
> > Thanks for the patch!  A few more notes, in no particular order:
> >
> > * There is no need to send a cover letter for just a single patch.
> > Typically cover letters are reserved for large patchsets that require
> > some additional explanation and/or instructions beyond the individual
> > commit descriptions.
>
> I was doing this to carry the repo name and tag info.
>
> So how do folks know which repo and commit the change applies to ?

We read your mind ;)

Generally it's pretty obvious, and in the rare occasion when it isn't,
we ask.  Most of the time you can deduce the destination repo by the
files changed and the mailing lists on the To/CC line.  From there it
is then just a matter of -next vs -stable and that is something that
is usually sorted out based on the context of the patch, and if
needed, a discussion on-list.

-- 
paul moore
www.paul-moore.com
