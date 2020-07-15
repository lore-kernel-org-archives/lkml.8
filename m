Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB648C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22EF2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849914;
	bh=aRa3VL5u8arzc6LALiYWvtGvSgOWPpe8CTkOzlAM4Qw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BJ/7eG05LQM9DQ2pfsUqLE+EVn/N1Te90/33NeU2yRE5UoDExJ7U7kBoKGc8Mu4dv
	 TnDvEP52Uauu8mLMgJB5VN9ddTvIYq4qnvtD/bpO1oTFZbOZpA1dFWOOS3GXXZNV9/
	 5LkIAHzDWU6bbQmpSPYXSGN5Bu0NRmY0J6+qS4Bc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGOVvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:51:52 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64615C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:51:52 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r19so4390710ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8AjJ4NG7P1yWy8SlP4js79iK2iKrNRy2ZziSmkJNFXQ=;
        b=OG0kQhfBPYEyUw0yJ9j5yT0Iw8J8CrFTwdqsi1TDyzZzBJ0jKykE9iLafUNbgfPuEH
         MWkuCZnhLXw6/3otSLvbNTBlv8ZsX6BrbyLWeK4abhOyka7uMxYPd5efT0C/gxTTxfcB
         k1ObZrn04w//qu4pwKCnb8okeBApNAmAiI+Mk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8AjJ4NG7P1yWy8SlP4js79iK2iKrNRy2ZziSmkJNFXQ=;
        b=neWw0OXi+Ac+d0qFcXyOoHRw5o/W6nREQxIyhwzXvtRF3PuD2xyKhvZVNHWVE0ECZu
         lMi+F5zcB6Y3FEr//7os6xVPvB/ytzpiv+TjWqJJdIPpLGSqVbo7ar2MY/XKY29+LdLS
         HlxDHgBf4TXBmmM7sVo2JlbWGAh6SGxWNxkV9qvNv5cjhXP05KxcbEk3p4zuzJyuTCVF
         BF9rCLvd/Ekj+uxtOTDOpRpMKhZm3jWISplKgSltz7jAS/b26Rg5D4XX+JMpKGGolrSt
         tsrQwiWan2UTWkoCmSjvrRPcvhzJPVAFQqx3IoBUviiiMU/q9XcZAR0GDlOpSd3jx/+h
         AyNw==
X-Gm-Message-State: AOAM530ay2vUpWC31Z9dLA4okU2O4pMVmZ4JJf1L6HITsR+oQ7g5K4GT
        OzE8wEwAA4BCJNACoDb4lieDiHwCnAY=
X-Google-Smtp-Source: ABdhPJy8XJ1MKrGWn0yz/gl99d7eEP2jXBIsgeF5Xf6VX3+N8j87jT+pzG9Sbtl2W2sdJC/f0wzqnw==
X-Received: by 2002:a2e:9dcc:: with SMTP id x12mr553450ljj.261.1594849910200;
        Wed, 15 Jul 2020 14:51:50 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id r19sm667666ljm.32.2020.07.15.14.51.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 14:51:49 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id r19so4390605ljn.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 14:51:49 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr509216ljj.102.1594849908727;
 Wed, 15 Jul 2020 14:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200715135011.42743-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wh4pB-jRngOjcGxpc8=NPds3jWqJwDMUWC3-OEo4dRiKg@mail.gmail.com>
 <20200715205508.3rzrkhulruzpy6iv@box> <CAHk-=wgOgH1AYiCXS7hNqqS0FnxbjJMkbxZ0Ep6vp6QF8BUBjw@mail.gmail.com>
In-Reply-To: <CAHk-=wgOgH1AYiCXS7hNqqS0FnxbjJMkbxZ0Ep6vp6QF8BUBjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jul 2020 14:51:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whonY2feAuw4sZaRbm97Myt47_eRepd+bnc449miUvrow@mail.gmail.com>
Message-ID: <CAHk-=whonY2feAuw4sZaRbm97Myt47_eRepd+bnc449miUvrow@mail.gmail.com>
Subject: Re: [PATCHv2] mm: Fix warning in move_normal_pmd()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        William Kucharski <william.kucharski@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The stack relocation only moves down.

.. and that may not be true on a grow-up stack. Christ, that code is
hard to read. But I think Kirill is right, and I'm wrong.

So that "try to expand" code is only ok when non-overlapping, or when
moving down.

Naresh - from a testing standpoint, that doesn't make any difference:
I'd still like you to test on x86. We always shift the stack down
there.

          Linus
