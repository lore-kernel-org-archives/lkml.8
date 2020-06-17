Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B659EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9097C208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 00:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OmVIWap5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFQA2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 20:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQA2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 20:28:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16F2C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:28:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so333867ejr.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 17:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ziVCI/eO3kCJ8TB1gX2Qg46EOg54vbaPgpwUxa978JU=;
        b=OmVIWap5i+4SGm+FtwM/QVGRj7ZG2ei8ffEyfYQ9GenyOQpwe7B2tEHHIR9Qyz0V0f
         vBV6q2PDEFCkozuQkszlA4poE6V3RbBuGe5/8/ly+oZeck/mFttDXtnRyH2WWBsJCbCe
         6E0xRubdSEs5Ab+N97Rcw2OEuAqPd51OGE1s3EDCcxIFDIVwHFnmqsG430/VBcoEExJH
         KEHZ6/xVMDtOBWnnYZj0D2Fl2mMULPkeWOLueUrzYofurw0QI3DdfDNSx9CHVnn3HJ1H
         pFmZzJAM05selS91Z/75CmTztuJpeNcpZBCNmtjZW7pX7bCwqDtP/GHS9E/eUSOVmW+w
         13Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ziVCI/eO3kCJ8TB1gX2Qg46EOg54vbaPgpwUxa978JU=;
        b=e1dG108FZkkoA7UfPH2NTczR5EzmYCATD8Qt4IqGHPMB9kJtvCLJeYtKWiUYljO8GV
         O+v8PIT0DIBJ18N5Zw7Mqna+HwYCAD8kbMGxre7Wh2V/zTj/JpB1TQ4kgG8cpbWzqNzX
         AIjkUuPqU1A0SJ7+hiUauPqwF1QyOPIBKuaEy3DmMBd5pUIpQ5e8NZ5rTxQT9UyBZs3h
         G4NFgsEEVhNPmzklLoV78tLNOZROIfU4G+InrpXWQp4j2ioifSy3hdUD4zJTandBwcCQ
         mXruZj7AEZ3KLa49RmE9FfjhQTnEEqOpfjUOjOZOhSpid61fJ38h0exziA0ZYFzXprQW
         sHPA==
X-Gm-Message-State: AOAM531F2BgfGZ++DTRI/++VESk08ibCrRCGLORFFwd6Q9KNHtRslDwt
        ltu5CjSW8gNRlNaTYygKmc/yeI7ZdRZK+bVSraHD
X-Google-Smtp-Source: ABdhPJwcqOzEEo3njX2aqW7aHntYyqFAw0P80lO03RqOPVnL9R0w1Jw9roM8xSWUxmuaM4fg2wlnJVBtkGHMY5vyxmQ=
X-Received: by 2002:a17:906:ecef:: with SMTP id qt15mr4971301ejb.91.1592353685375;
 Tue, 16 Jun 2020 17:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200615204548.9230-1-trix@redhat.com>
In-Reply-To: <20200615204548.9230-1-trix@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 16 Jun 2020 20:27:54 -0400
Message-ID: <CAHC9VhQeo6_mie65AH5bzV9484UWsPQA6kz67ZR7_WSfBQ-3cQ@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: fix another double free
To:     trix@redhat.com
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>, weiyongjun1@huawei.com,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 4:45 PM <trix@redhat.com> wrote:
> From: Tom Rix <trix@redhat.com>
>
> Clang static analysis reports this double free error
>
> security/selinux/ss/conditional.c:139:2: warning: Attempt to free released memory [unix.Malloc]
>         kfree(node->expr.nodes);
>         ^~~~~~~~~~~~~~~~~~~~~~~
>
> When cond_read_node fails, it calls cond_node_destroy which frees the
> node but does not poison the entry in the node list.  So when it
> returns to its caller cond_read_list, cond_read_list deletes the
> partial list.  The latest entry in the list will be deleted twice.
>
> So instead of freeing the node in cond_read_node, let list freeing in
> code_read_list handle the freeing the problem node along with all of the
> earlier nodes.
>
> Because cond_read_node no longer does any error handling, the goto's
> the error case are redundant.  Instead just return the error code.
>
> Fixes: 60abd3181db2 ("selinux: convert cond_list to array")
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v3: simplify returns
>
>  security/selinux/ss/conditional.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)

Merged into selinux/stable-5.8 with a better subject line.  Thanks for
catching this and submitting the fix.  Assuming everything goes well
I'll send this up to Linus later this week.

It might be nice to do a follow-up patch for selinux/next which folds
cond_node_destroy() into cond_list_destroy() as there is no longer a
need for that code to be in a separate function.

-- 
paul moore
www.paul-moore.com
