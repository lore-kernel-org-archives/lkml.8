Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AE6C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C912072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWIr0t5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgG3ShU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730275AbgG3ShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:11 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE77C06179E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e22so5348714pjt.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Za2X+sdlXv1PBjDCcpW+9mZ9H8oXfEoz2zW6UpS21Ss=;
        b=SWIr0t5O4oDYU2701Z7zJeN2fomFj26nwgmJmVQDxYcFlpDzQV23Oedau8cYQ21X7k
         vOCTGj2wNZBV8euG1wI3VxeCOPz15viRL+AlA/3/RCrYLo4/6wqkwimn2+LEf80aPgRA
         1TaZogRW4Go+Do8pjHr3qsNCwGnK5pv03/FpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Za2X+sdlXv1PBjDCcpW+9mZ9H8oXfEoz2zW6UpS21Ss=;
        b=IHX4kcjHAuSjBce/l6KRFJB66HXl2CtFIiKLTZ0c9PQv0J+HIKKQ4sH9SpSC6g5Uoj
         vtWEVuH7WdhREF5bDh9AaY2yZybYYtlMqCK5dwpIUBSleWouHatcj3qwMWIuj0Nf+/81
         I/jJD8oNfgCaC/CO357OqiofhznylgHvMiYgb+VkCcvkelas+j2RHgPdtrdXyHXyQPPO
         rAqznvFz6z6nyTbvNX1YNO3KDlGdLwxzmCa3lAPVwpXFWLCf3aXu8XEPpIrPFzVLIWgz
         6qG2loLKNgkHoaiFch4aSXWD7wjPCDrTqQ3+zukaei8e2ZLOFsR/kd+G8aqKE54uYktB
         6byA==
X-Gm-Message-State: AOAM532VeVjpr/fna2J57CNJL6YzM5mkC1OIyxKRx1nUREUOXndFl0Rt
        U9dxINNTT+h/Rz4GfBcLhYn6Mw==
X-Google-Smtp-Source: ABdhPJyWNvZ7E8MYiEJIisC4o6LkxiDWq6dahPjGqEGymWzHq67muY2+6IN30fKAnESJFDTE/1p9VQ==
X-Received: by 2002:a17:90a:3c8f:: with SMTP id g15mr402407pjc.215.1596134227860;
        Thu, 30 Jul 2020 11:37:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z25sm7312275pfg.150.2020.07.30.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:37:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mailmap: Restore dictionary sorting
Date:   Thu, 30 Jul 2020 11:37:00 -0700
Message-Id: <20200730183702.702552-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems like maybe Jon (or Andrew) touches .mailmap "the most" (which is
really kind of a 20-way tie), but as a result, you "get" to be in To and
Cc. ;) In adding a mailmap entry, I noticed it was overdue for sorting,
so I sorted it.

If this should go via -doc or -mm, that's fine. If I don't hear otherwise
I'll carry it as part of pstore (since the mailmap entry is for a pstore
contributor).

Looking at -next, I expect this to have conflicts, so I may rebase it
during -rc1, depending on any feedback from Linus... :P

Thanks!

-Kees

Kees Cook (2):
  mailmap: Restore dictionary sorting
  mailmap: Add WeiXiong Liao

 .mailmap | 111 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 56 insertions(+), 55 deletions(-)

-- 
2.25.1

