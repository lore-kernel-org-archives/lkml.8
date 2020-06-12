Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89977C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E963207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4V/AbtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFLGgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgFLGgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:36:32 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C306CC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:36:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c12so4856417lfc.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dKefQVYRAMri+oQH2++zVvlRQ/KmlKt8ijY5Ux7ySbg=;
        b=I4V/AbtL6WSuMu4aDY8W9u/MBzNmFAqAkQs9bwL59L8gjzMBEZI9KcUQILjKxEExA7
         538AHcum1IcjOtyfo0Z6Ta42inofWVPtpag34DXDOIdONCenwf7J4R5Hw+p2HsY67uLF
         ZGgk3F9oIgjd2hWhuuhpqEJLg85nt0BQlN+mdS9owPqm5gK6NiWYHhCJKAOPjdUtQXy5
         Mo9+78yRUDVVZvLjYKqsp20o3tkl4rPZ2FAL0c7DkQfZMopwCM/U35l7NClxqsNFkp8S
         1YTBZb22ccA+l9LRcDqbdQl3K62Am7ZRxLxn3AXgYMaaMFWF6KLfblMSlEEhNzU/PXgg
         rl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dKefQVYRAMri+oQH2++zVvlRQ/KmlKt8ijY5Ux7ySbg=;
        b=Ol/cJT9G+g7nf9efzKFWefKcNMe29QSIe4Za532dVq1HmXKS9WKF1xq0YXspMNfDmE
         QfK5v1FvU2GsVN8SHd7ljtYFlMFkDRqXj2SHOK5wwOB+kkIGc8kMxHfyHQZGP4dguCkD
         LbVKypeqFNhgdSCjAMQk8lxF9z6JmI6C4A/LxcezgcWvPG20T6LpCH/o31H7ZUHLt8Vv
         hNFpIMZXjIAx9GRLiHdYe8zo6EfGTAwvt2E5XxkdYp7FadpWFNnyZkp66d/U5HVC5zPE
         PuIbSbNloQxdSiFP3OuqhsqxE0NqCMcnYDT8OkfopQMB1QC21cE1ssmVVJ1ZfModOl2p
         y7ng==
X-Gm-Message-State: AOAM530Q4xUQ7fX1OtsirBAz81wnnYVGO1Ge0ZbnBgqYWvYjQu/854R6
        GoGNQWEI5UoFfyg2nBAHFAfVjb2gvKr80JG15If+YFHaZe4=
X-Google-Smtp-Source: ABdhPJzKZ5pn2l5FiL3+aPJV6ZUcHDO31zflVPBxSI58vtzsAJI2Splqhg1tqXHOEzuem86IDlA6JuPVj1egkwnppII=
X-Received: by 2002:ac2:490f:: with SMTP id n15mr6072521lfi.39.1591943790160;
 Thu, 11 Jun 2020 23:36:30 -0700 (PDT)
MIME-Version: 1.0
From:   Garry Filakhtov <filakhtov@gmail.com>
Date:   Fri, 12 Jun 2020 16:36:19 +1000
Message-ID: <CALKTHW0B-kpjRgJVtHwdo0sqszYzHSCH3x_Oph2gDpa0diyEVA@mail.gmail.com>
Subject: KVM guest freeze on Linux > 4.19
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good time of the day,

Hope you all are staying safe during these challenging times.

I have been struggling with KVM guest freezes after the upgrade from
4.19 LTS to 5.4 LTS.

Searching through the internet lead me to
https://www.reddit.com/r/VFIO/comments/b1xx0g/windows_10_qemukvm_freezes_after_50x_kernel_update/
and Kernel Bugzilla revealed
https://bugzilla.kernel.org/show_bug.cgi?id=200101. I have added a
detailed problem description on the aforementioned bug.

Would like to get some attention from people who might know more about
this, and see if I need to create a brand new bug report or if that's
okay to work through the existing bug.

Also, any suggestions where else to look to find any clues that can
help resolve the issue or identify what's causing it are highly
appreciated.

Kind regards,
Garry Filakhtov
