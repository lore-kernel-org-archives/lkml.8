Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA942C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBBB20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 14:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyDGk1Qh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCXOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 10:06:46 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:52710 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgCXOGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 10:06:46 -0400
Received: by mail-wr1-f74.google.com with SMTP id d17so9293499wrw.19
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=HBdtxiA4456RzmVM1qUhdnGD6aL9Y+FSjlt2D4+kbQs=;
        b=nyDGk1QhgGJP6JXVdgaZp480a9DwV4Kskd/e1Sx5LQJYHVpsMYpLrW8zWyfy753to1
         qWclQhv0rsC3MFp3Jn6CYCcRMo0XhPSjtH+Vsnf+vpqMYWe4pekvq7MSl1kw3jeR0w8W
         N1yS009CdCui87ZV/h3KmStNu5WCzWIyH82Eu8IDlZNLXxnw1ymubHZLGJfYCGkhotHY
         GG/xqbTXHHxYl3uM8yl6QGokbFKvxvrUo+AI7rNb9VK0xL+37UYvD70rO6ZiCens/g+1
         OuNug82g1e6/IzY+oJBEbswAucS5iDGrqos2TBQGUmpZWaLBP+PcC2Zwzqk3xBsp011i
         31Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=HBdtxiA4456RzmVM1qUhdnGD6aL9Y+FSjlt2D4+kbQs=;
        b=bhUpug6xowCVTlWS1G9UE3AxtJ3ftsIxTYLgVQg5HkgpVbRml2xBXnVLt9bKlLgSBH
         kGfcyPgD93PwVEEqM5ZCaR0MCExeEtQtMSZWNAcoIiHPZRoLPbFz6aEGpUHbCBg0DaSV
         4xKVC2hakZEIBY0WfP9aJRITqEeEA11TjUEOfXU5J4cERRM4Ddb5QvFrPvf8Wy5RuaSL
         g/8Jn0SyUne8cw0pkWaQ3Bc765bC8m1StQltHU2bWVo9MsTuDxeZ0f9IglWtJYQ0JQbL
         TW5kIhDypYI8/7SnO83KHSxvqgUaR6u7koi6c7jxdZFrQoTrn73viVIzTy8kTXhQ7s2J
         aeew==
X-Gm-Message-State: ANhLgQ3W25U8NrCphFewghfue8wYvynce0gZBRNnYjgfDOMtD6L3j+9u
        9w3S8X7ZYXfwYrMpFnGiJbROwRtCGTnG
X-Google-Smtp-Source: ADFU+vskI0jexMsS1DvDsEq2T1w3Ggok81GOT3ryS1YifqC7IxK92rpG4H3ZEUBolmiIT8TbfzKCPBDpYA/p
X-Received: by 2002:a5d:4ac8:: with SMTP id y8mr36558140wrs.272.1585058804297;
 Tue, 24 Mar 2020 07:06:44 -0700 (PDT)
Date:   Tue, 24 Mar 2020 15:06:38 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200324140639.70079-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Clement Courbet <courbet@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments. Answers below.

> This ifdef is unnecessary
> This needs to be within #ifndef CONFIG_FORTIFY_SOURCE

Thanks, fixed.

> shouldn't this just be done universally ?

It looks like every architecture does its own magic with memory
functions. I'm not very familiar with how the linux kernel is
organized, do you have a pointer for where this would go if enabled
globally ?

> Who's adding it for 64b?
> Any idea where it's coming from in your
> build? Maybe a local modification to be removed?

Actually this is from our local build configuration. Apparently this
is needed to build on some architectures that redefine common
symbols, but the authors seemed to feel strongly that this should be
on for all architectures. I've reached out to the authors for an
extended rationale.
On the other hand I think that there is no reason to prevent people
from building with freestanding if we can easily allow them to.



