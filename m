Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D3CC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657F2207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ei5Ui1IQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgEGRHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725949AbgEGRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:07:03 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D69AC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:07:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id ev8so6509355qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ct3BK4gm/q86QmYuR5ZR/29gFnmZjaUluf46gNZVNR8=;
        b=ei5Ui1IQ46onwaK7Bz8wzqZph0b2kZo3Jfy1QFsaPnPpn0mCG0eqN07k6ZtOyl8GyG
         E2MHJcP1StTby58wMTkL0SYVrvqwC3GhlqQg4Vsar+Qtad8Vuh3AeliiD7Ga91u2N6Dg
         XGruAipCZoeohg+0+jMdHVv7kNtdJyEF7uEnlVtLeqI6bLtWuvFJkHXYJbDRDT+9DKzD
         RMW6ljhi4ckEjA6HuV1g+LVchwCu/cITcJ9zIMXWVzrkHWEzuco+IGtE5Jot+C55rvL8
         OtI0mEyzD4PHrCaQK/vvOU3IcS6Ze03TkJmic8EOrDXcZtMP1d4VgceQxTxHZof6Rcdo
         gT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ct3BK4gm/q86QmYuR5ZR/29gFnmZjaUluf46gNZVNR8=;
        b=j5sLm7MQiA//C9bqZPsYvHbFOOJOfGFvfC36z73BBjmI0wS/o391d7bOyolwGVFGDo
         Hlw7wsEdV7zCjOb58Qj112+oAPR8jAeynq+i9C3I6aZxvulIhwQQDfyNqPEHIVn5EBE5
         g3aYPk8gLjfjeZOt3dHNsy5v8IZ0cJahOXKXhQGefeP/TRrXnrh/7ITDVjEXJV0ta5Za
         fbiI0fLR1ULVmhYISC0V8W2MRB0VGwVZVeCDwNKRbc75Y5CJ6xqQ4Px4Pt61erwOIzcM
         Fkw87VLcOrS+hhzyV6XvMb2M/l6i67g59IeEKvFvxXCDeWEuck7Gv4bq5XH+VUBH1+pd
         J6dw==
X-Gm-Message-State: AGi0PuYgrACSiZsH6NZ9T8B/vErQNrn+MvC/KP15+2KeeH0aJdjSFlSD
        0o/EZ6HizojI4vaEd7em324A1W2Ni1kB93f2
X-Google-Smtp-Source: APiQypKRLt2zSY4Ou9VI6deks5k4MCfwUuX13qpxmUxO9UsmGQqhLChqeurC7hYZJC31zES8PtBlwUhzAipwcRJU
X-Received: by 2002:a0c:910c:: with SMTP id q12mr14871311qvq.239.1588871222163;
 Thu, 07 May 2020 10:07:02 -0700 (PDT)
Date:   Thu,  7 May 2020 19:06:53 +0200
Message-Id: <cover.1588870822.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH USB v3 0/5] usb: raw-gadget: fixes for 5.7-rcN
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've put all raw-gadget fixes in a series, please ignore the previous
patches.

I've dropped the patches that change the ABI for now (those need more
testing anyway).

Changes in v3:
- Dropped ABI breaking changes for .
- A few more comment fixes for uapi headers.
- Updated documentation.

Andrey Konovalov (5):
  usb: raw-gadget: fix return value of ep read ioctls
  usb: raw-gadget: improve uapi headers comments
  usb: raw-gadget: fix gadget endpoint selection
  usb: raw-gadget: support stalling/halting/wedging endpoints
  usb: raw-gadget: documentation updates

 Documentation/usb/raw-gadget.rst       |  37 ++-
 drivers/usb/gadget/legacy/raw_gadget.c | 314 ++++++++++++++++++++-----
 include/uapi/linux/usb/raw_gadget.h    | 108 ++++++++-
 3 files changed, 377 insertions(+), 82 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog

