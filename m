Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CE2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C3E206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 22:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hb9eprX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFKWn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKWn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:43:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCA3C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:43:57 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id u26so5971326qtj.21
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 15:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:reposting
         :subject:from:to:cc;
        bh=dX94irw1MxHKi/T+Vqgi6+rzlQqYZ5xffMiSd9HTX8E=;
        b=hb9eprX/NQb0NjfXwDdXL4gdHj9VYwDvcKChF8jRYDq7m8pNcKDVi4BvYTjvJMzwmY
         mWcRP+kD4e+nATgojsvBAxrDvKFs5qgnhbwEZ0NMnfmDQrEGPnnSHho/kRuIsVhX1VcV
         DPwHeGLoUxsWV/ZsedpqgcbPMV1kATmxi6IPSZGQjMLI1mzC/3/IFoRpqA8P9ujwFYES
         EwJvYCZ3QLpktmgmSXm9X4uLj5jQCj6Kc20pPQQstMq5FJmxOmJbfHIbJICrkyX3vIM+
         XYvM+jCZkSo/TYEnPX8FFqaDGwdYbdy8AIkZkSfiLUdN3XlhMZEsLZ6FQTmWaMdhcwJ2
         tjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:reposting:subject:from:to:cc;
        bh=dX94irw1MxHKi/T+Vqgi6+rzlQqYZ5xffMiSd9HTX8E=;
        b=OY1kQRcwj+Le3JgUsRdE51SCGeQZ0Kk5Ow+w5h2nM+jVojsBXj/i0bKRttxSFdXTLL
         BX+cIO3bC3xJGS/0t6EBl9+VxVuO8yAgZFnbjbuWXRXcIQVz0HGn8HzYd9gO2OOo0+eK
         pIahitFf+AJHtBmGYjO8h9IHg+g6ksADD9hN0WPewbn027+PpZ3HnATDovNvZJESDIxd
         7/PUwHkhmGthXOgniUD2JfXd/TD9B4bhgGlynXFEcroFKvuPbhQ0vDNgkC/rB2Wev025
         GDqkPgqBcrgOrBm2gAMNj31BV3Yx96nf/lM9zPBlj2GKIeHQ/4WZBMjXWdEnsftcmZxJ
         mBLQ==
X-Gm-Message-State: AOAM532KhxbkiM7Wv2QzErE9TlQvx8H2T1f7nqkxGq/0Ov1cJfnTlJ6w
        cV85NtER5BD7FOhYjefiDhyqNSdaGG0dPS0KLRw=
X-Google-Smtp-Source: ABdhPJyY2NiOYl3UkCSFzlcFvpmcgCxaRV0h+Tb87x87GdRsIE9XeLhg1e/k47HkNIscElDe6xwLnQ+yGZCFW6DBAb8=
X-Received: by 2002:ad4:43e3:: with SMTP id f3mr9767525qvu.115.1591915436835;
 Thu, 11 Jun 2020 15:43:56 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:43:55 -0700
In-Reply-To: <49YBKY13Szz9sT4@ozlabs.org>
Message-Id: <20200611224355.71174-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <49YBKY13Szz9sT4@ozlabs.org>
Reposting: https://groups.google.com/g/clang-built-linux/c/2dGVKSjE5Es
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     patch-notifications@ellerman.id.au, christophe.leroy@c-s.fr,
        segher@kernel.crashing.org
Cc:     benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com, paulus@samba.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! It seems this patch broke our ppc32 builds, and we had to
disable them [0]. :(

From what I can tell, though Michael mentioned this was merged on May
29, but our CI of -next was green for ppc32 until June 4, then mainline
went red June 6. So this patch only got 2 days of soak time before the
merge window opened.

A general issue with the -next workflow seems to be that patches get
different amounts of soak time. For higher risk patches like this one,
can I please ask that they be help back a release if close to the merge
window?

Segher, Cristophe, I suspect Clang is missing support for the %L and %U
output templates [1]. I've implemented support for some of these before
in Clang via the documentation at [2], but these seem to be machine
specific? Can you please point me to documentation/unit tests/source for
these so that I can figure out what they should be doing, and look into
implementing them in Clang?

[0] https://github.com/ClangBuiltLinux/continuous-integration/pull/279
[1] https://bugs.llvm.org/show_bug.cgi?id=46186
[2]
https://gcc.gnu.org/onlinedocs/gccint/Output-Template.html#Output-Template
