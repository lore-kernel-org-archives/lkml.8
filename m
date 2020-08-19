Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE37C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6C4207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3gXik2Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHSVGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgHSVGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:06:51 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3184C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:06:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g15so704plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1fpazQzH5RzZYR8qQqnmyk9zH8WRFTB4V0IGSi9KdM=;
        b=n3gXik2Qgwut2dnhopHSM0ZTpUHIi6gVTF4XJRmDIngPNixlUNtHw0BoOxGRErlh+A
         NEUpm5nS07FYpoIukKItm8njOq+7W7HIDGDyeNyMu9V6y77m0BVMDgF60gWCiJ/yhILr
         rNBZhONTRkFZP0avtwKAX2L2fx7u95liCYCVGJy1fUyFFO6kG470mjAaO9JnjSrhlg4E
         LOqr5LEaNL9zO47CAFdHNfn0m79qaXwsCP0VcKQpsHDPRQN34/mBhVJpm+X+wCPQM7fE
         H/4G3VkM0prcDUokq+cvOa2llDTOpuWhWTPHey8eqP0ZulPhWDigdy6rWy4IJigjzjUo
         OeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1fpazQzH5RzZYR8qQqnmyk9zH8WRFTB4V0IGSi9KdM=;
        b=p5n/FY46i3I3p5rjuu8tEfrA8Zgljrz02VDR/6qtMxnI1WG+GsJY5gfQfCEuJbh3Er
         OSzpQ2Ck0fxBUgr8WolB7IoY0rN48QvUXf2q1enqrqleVoPKKrS9g60lap27OyAivxhw
         8NxUZjqP4S4pjPuGFh8VYFdnDiLbHgt6ekfwBq2urEPnwbb4HJpU31qgCbCr9F0H8UWz
         P2C0Uz8imdU5mdsg8iXThTQJZeLawzCmnKvsYBrj3JtBYiOFlkpOKRiriD6tvRTa5qPQ
         p2szvEMkaH/XLNP+5VykNSi1AuL6UtYgOBBgQnTw171rPQFkUxmfrmycyB1sAp0z1jts
         Lu6g==
X-Gm-Message-State: AOAM531ujiHSK9tglyXHxPhEYBnPn3H6z+ojVBsOLeFI+VGZCh8LxlvW
        CsHZsZzWQKwRJsHOnIAnpGErO013XvAtSS0peENxAg==
X-Google-Smtp-Source: ABdhPJzzCiHuuzGcxULeosyTXBOlK4ZIt+/tGPvNknk5TvX+B4AW7O4jdcVufduouBXWPpOhHI87w0ZcR36cvNaGFFs=
X-Received: by 2002:a17:902:7405:: with SMTP id g5mr305146pll.325.1597871210318;
 Wed, 19 Aug 2020 14:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200718005141.440405-1-vitor@massaru.org>
In-Reply-To: <20200718005141.440405-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 19 Aug 2020 14:06:39 -0700
Message-ID: <CAFd5g47orvwzPOnFepDCjkv0nd08Ad2mmVp+XZgVmpGr5C2HwA@mail.gmail.com>
Subject: Re: [PATCH v2] lib: Convert test_user_copy to KUnit test
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 5:51 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> This adds the conversion of the runtime tests of test_user_copy fuctions,
> from `lib/test_user_copy.c` to KUnit tests.
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
