Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4834AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2306F20722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnwxLbPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHCJpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbgHCJpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:45:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0455C06174A;
        Mon,  3 Aug 2020 02:45:28 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so24121210ejc.9;
        Mon, 03 Aug 2020 02:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1ZnojWWtbX7Hsvm8m9p8ifqLILqAnwXafdNH2bdwNA=;
        b=PnwxLbPjFisoVT0dxi+3/mq7Ky7HfWL/GrlZ7I1jfFJt4kC2e6c5mIXWoz2IPems/W
         u1vfk2P6rdugfp9nxrbHvq50mpJBPP9fPhoVBnQw/j5I3TPPyynWMhGuibgLR6b5nC/c
         32JQTweUYlSd9dBHjb6zZDFfi+WY+zRh720pH0PB4VKT7q3X58Qr6EHbi5A1fnStaTJI
         ZllcOs7qTKsjz9keTD84Nlpi1EaXJVpdX6DYStyD/C0Fq4JrbrYSgsVeen5wh/cMxNv0
         Wr/UgrZnigOVljKAYYF2Uj/hE1PeBauAIOuCc2o1zidJLkc2V+XKOvKb+xVlPFCPS9jg
         hC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1ZnojWWtbX7Hsvm8m9p8ifqLILqAnwXafdNH2bdwNA=;
        b=YeqTMoF9FRfAg4Y6xYLgn+NjenKAF40yhg9DUeLCAz6sP425CI/i368+z9lAjuvxEh
         3DJWPGFq7rHilIaMz3VCev9kpgrGWm51tmmGYEn+NjB2+fvxzet/daSiUOyHWw180dad
         2ocmfyvh2JA7KJFPP9UGHm8KPnh18NP/XpPY3iKLV0ef1zvlWVrWAdDqdG0n0Pc2cK/Q
         e9YWySpveF0o/fUCXe7yACiWZoVNwYH7xtQtrSGeuC/1ulAXddC3eU8D7KmK7ZT8cLx+
         ORElS4ZzUglE3oYj6+tVpTHLH2857mx6Y1Z6WND9CsfO9FOSDNZr7v5lNU60tczAh8eZ
         VjAQ==
X-Gm-Message-State: AOAM53325Xqm6NMrqclcq1SC5HM+O9n2nx+WldVtAqI/4GoS/wVLA2t4
        5yalkG06m4f3R5SdMauKbbCyj4lcytviKjKOe19L2TJM
X-Google-Smtp-Source: ABdhPJywRwadecMebw5QYkOvggkGLAGwblyf5eIzReiJ0GjPSCThWqvJsWKqcZYJKoiGfq/Y3N+inI6lwV1tzGNF334=
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr15742401ejh.59.1596447927112;
 Mon, 03 Aug 2020 02:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADxRZqzyxzN9yC79kjhtdpL9QT6ybgTsSCb3G1U8zJHZy-W_9w@mail.gmail.com>
 <de07ba39-4cd4-0174-3331-92cb7148a653@physik.fu-berlin.de>
In-Reply-To: <de07ba39-4cd4-0174-3331-92cb7148a653@physik.fu-berlin.de>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 3 Aug 2020 12:45:16 +0300
Message-ID: <CADxRZqzd1qGV17Q1QuQAb4O7Yu5HP1Aa_DE1wGqfOt4hSy5hOg@mail.gmail.com>
Subject: Re: [sparc64] unable to build v5.8 / master on sparc64 , bisect attached
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Sparc kernel list <sparclinux@vger.kernel.org>,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 12:24 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> Hi Anatoly!
>
> On 8/3/20 11:18 AM, Anatoly Pugachev wrote:
> > # bad: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
> > git bisect bad bcf876870b95592b52519ed4aafcf9d95999bc9c
> > # good: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
> > git bisect good 92ed301919932f777713b9172e525674157e983d
> > # bad: [0ae3495b6502cf93634cbd027cb2f6f9f83a406f] Merge tag
> > 'for-linus-2020-08-01' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
> > git bisect bad 0ae3495b6502cf93634cbd027cb2f6f9f83a406f
> > # bad: [aa54ea903abb02303bf55855fb51e3fcee135d70] ARM: percpu.h: fix build error
> > git bisect bad aa54ea903abb02303bf55855fb51e3fcee135d70
> > # good: [c2f3850df7f95537e79c561f7be49df2e4ad8060] Merge tag
> > 'drm-fixes-2020-07-29' of git://anongit.freedesktop.org/drm/drm into
> > master
> > git bisect good c2f3850df7f95537e79c561f7be49df2e4ad8060
> > # bad: [0513b9d75c07cbcdfda3778b636d3d131d679eb1] Merge tag
> > 'io_uring-5.8-2020-07-30' of git://git.kernel.dk/linux-block
> > git bisect bad 0513b9d75c07cbcdfda3778b636d3d131d679eb1
> > # good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag
> > 'audit-pr-20200729' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
> > git bisect good d3590ebf6f91350192737dd1d1b219c05277f067
> > # good: [4ae6dbd683860b9edc254ea8acf5e04b5ae242e5] io_uring: fix
> > lockup in io_fail_links()
> > git bisect good 4ae6dbd683860b9edc254ea8acf5e04b5ae242e5
> > # bad: [1c9df907da83812e4f33b59d3d142c864d9da57f] random: fix circular
> > include dependency on arm64 after addition of percpu.h
> > git bisect bad 1c9df907da83812e4f33b59d3d142c864d9da57f
>
> Did you find the offending commit?

the last one v5.8-rc7-41-g1c9df907da83 ? In commit log it tells about
"x86_64, arm64, arm, and mips" and nothing about sparc,
probably forgotten, i'm not an expert , but the following code change
fixes kernel compilation for me:

linux-2.6$ git diff
diff --git a/arch/sparc/include/asm/percpu.h b/arch/sparc/include/asm/percpu.h
index 0cd704ef5ff9..fe284c508f01 100644
--- a/arch/sparc/include/asm/percpu.h
+++ b/arch/sparc/include/asm/percpu.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PERCPU_H
 #define ___ASM_SPARC_PERCPU_H
+
+#include <linux/threads.h>
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/percpu_64.h>
 #else
