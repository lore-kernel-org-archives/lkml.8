Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F639C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F14B9207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AhwvEZTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFDEfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgFDEfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:35:07 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16EC05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 21:35:07 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b5so4796330iln.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 21:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=g+64I7JZp1JXS80n8G4BLUDcZzIS9BkuQYkabG+zwps=;
        b=AhwvEZTgFuvltvPU8KBCKvxVuGI0BR7fYtPWZvsfPhapBV6dbvgPl0k9VcIcG5U7WO
         ITwqw0rXEPIg0WAJ/I1z7J8ih3dlvz9wWcm2Lmc2NX4mHjFwO0xN8iZ3bSWyH+f4XGj3
         waL/8DTQJ9A5pSnXJLcJdVPBohzSQVkde58DeBk6HxMV2jM62Bez7XEsFenQXcrFXDBz
         scQ7HaAGgXYD0DYQGq6Ly4m9ZOCiLjqtG85+39MmB/+5vSpQJ6+KA4cU00F/oiRue8TU
         eYGzYLLXyTQdJrUE3I8qGms2BQADyObokXNkoU0zMsqo3mANxayQPQdQvdgCCaZNdREe
         9uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=g+64I7JZp1JXS80n8G4BLUDcZzIS9BkuQYkabG+zwps=;
        b=S7yiYrAcz6C87L88Y5WSvWGvGQses3mFQJ7qMmRAJB5TkrhNMvac+RkAQSpaiVx3K8
         xpm8+Pj4jXKfBmQEGVaZ0QePLoGAaWJcRKn6UWzbiiG280Kv39QVWTiim8j5b8hV+8SD
         MO6zKj/ttflLBSePo72YJei7JeT+hKyWUME8vEC6mvk4Ow3lFZ5NUve8yJnstOyh6753
         z/L7V/tOJDkPtUOj/yZUIc7WcTAonDernMxO6TZcKLLiwd6ij4cCgTo4VvSBkuJ9vtln
         phGQTXosGkwRYagbaeohYala2F285wfm4LH+LEKFa5Oe7RFlrc/BEvHuryAq3ehx0Uv3
         5wiw==
X-Gm-Message-State: AOAM533FnVX3OJjcoqvTbtNXCafItJpnlnOm2IZC9c1CVoGoZe3xAQ1D
        b3GYAwBQ/xbXUPzrocbHJGi1nvsyVxnTJps5HbQ=
X-Google-Smtp-Source: ABdhPJwqtGQ0Huvfnt9AjzvUGB7RCsJHSwB61wTKamI8d0uPbjkflX/+h8yjUR6HrSrd6SSwRsXU4LDXrXdyGFkKZi0=
X-Received: by 2002:a92:5dd2:: with SMTP id e79mr2331818ilg.94.1591245306792;
 Wed, 03 Jun 2020 21:35:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac0:d54a:0:0:0:0:0 with HTTP; Wed, 3 Jun 2020 21:35:06 -0700 (PDT)
From:   youling 257 <youling257@gmail.com>
Date:   Thu, 4 Jun 2020 12:35:06 +0800
Message-ID: <CAOzgRdZQjuDfA1wa9AGYjRa-mNWbTNQNCOS60eHzDLeW9WCXpg@mail.gmail.com>
Subject: Re: [PATCH v6 10/12] mmap locking API: rename mmap_sem to mmap_lock
To:     walken@google.com
Cc:     Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        daniel.m.jordan@oracle.com, dave@stgolabs.net, hughd@google.com,
        jgg@ziepe.ca, jglisse@redhat.com, jhubbard@nvidia.com,
        ldufour@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, peterz@infradead.org, rientjes@google.com,
        vbabka@suse.cz, willy@infradead.org, yinghan@google.com,
        youling257 <youling257@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have build error about kernel/sys.c,


kernel/sys.c: In function =E2=80=98prctl_set_vma=E2=80=99:

kernel/sys.c:2392:18: error:

=E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=E2=
=80=99; did you mean

=E2=80=98mmap_base=E2=80=99?

  2392 |  down_write(&mm->mmap_sem);

       |                  ^~~~~~~~

       |                  mmap_base

kernel/sys.c:2402:16: error:

=E2=80=98struct mm_struct=E2=80=99 has no member named =E2=80=98mmap_sem=E2=
=80=99; did you mean

=E2=80=98mmap_base=E2=80=99?

  2402 |  up_write(&mm->mmap_sem);

       |                ^~~~~~~~

       |                mmap_base



why not rename kernel/sys.c mmap_sem to mmap_lock?


diff --git a/kernel/sys.c b/kernel/sys.c

index 113955fe1c6b..043c04a745a9 100644

--- a/kernel/sys.c

+++ b/kernel/sys.c

@@ -2389,7 +2389,7 @@ static int prctl_set_vma(unsigned long opt,
unsigned long start,

      if (end =3D=3D start)

          return 0;

-    down_write(&mm->mmap_sem);

+    down_write(&mm->mmap_lock);

      switch (opt) {

      case PR_SET_VMA_ANON_NAME:

@@ -2399,7 +2399,7 @@ static int prctl_set_vma(unsigned long opt,
unsigned long start,

          error =3D -EINVAL;

      }

-    up_write(&mm->mmap_sem);

+    up_write(&mm->mmap_lock);

      return error;

  }
