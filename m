Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SHORT_SHORTNER,SPF_HELO_NONE,SPF_PASS,
	TONOM_EQ_TOLOC_SHRT_SHRTNER,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E1FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E616D2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 20:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kLgvuDoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHKUwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 16:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 16:52:31 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:52:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id p1so107055pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Nnv7qHJRbdPD+8Zu3Qzi3do41esqRGeITilQcgmTPao=;
        b=kLgvuDoCFw/c8NL3/jGzDlWGjW5cUQti6Nxwsl4vDEvzq1Dges3PK/GH8LaT9pTQDC
         G4RWViRrhrC2qdTVEX3Cp7JicbrWUtHxNcsKZCsChlIpCnsChC7L9+97VTe/+OtvQszH
         kh7XzQBnE+jTItmqm4WRassn/4V/LgsGP/rw+E+BokWW6+YOr9Kdc7TwdB1uuybE0Xca
         CijvL8a22FYa9c+psQ6+Cp7Y+8nWBGVkCNSnIrKAoiVXYtQLV/UAt3AJgI6+mgT26FZ/
         4powb5XeYh0M9Hu57FuJYK7uWeUXp+21VaQEtYlT0QpeUeiMpvUVHi+NRKNskSEghNRD
         +iPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Nnv7qHJRbdPD+8Zu3Qzi3do41esqRGeITilQcgmTPao=;
        b=PEzqTXllt0sD+bvgmG+uhfZPFuNmUeVNdmDiZ6Nrg6xLfj/uSCi2T/eBlJ5pPYUzQn
         6zL+TgwgE7D6aUyCqM8NDYmDx4rz5F1WaJ1LI7BLZTyRveWWnlaGQOSeR4RcNPVXg9cR
         UyT0tm2bnpGquxa5b64EevwslZp8aKZgxtz83giYG0dD46gsjU/8nsuSWUe6kyhPMpUp
         w1Vz8pSRk/UqaLzq7jkgXqaghOsvvo6/xUAo4bDEqvdm88ggGYlGxt4Vuwm+CgVlmAw5
         XupiHYiBKlpDol8dheBwVrgS7yhKKkfTL71xxMw8oWYFwLYqFKUtDvQH5CS/Sjn/d2dp
         nD3Q==
X-Gm-Message-State: AOAM532B33pIYqiDGTdzxMQ3Yfmk6m44qqJYAt0Bwf0g1+ndvaCP3UrM
        s3y+Mnkk7XkmSR5VT+y4Xs5/xDJ06AJXYvwOPYxmNqe97fI=
X-Google-Smtp-Source: ABdhPJwLvk+vIeFUpZNozS+dW5N5M2ya+C/bkHf28mmvBelso50gQmkHYWNYb8g9ExBTYPXQItr3Rx+iRZgOJAUxpS0=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr2704245pjc.25.1597179150558;
 Tue, 11 Aug 2020 13:52:30 -0700 (PDT)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 11 Aug 2020 13:52:18 -0700
Message-ID: <CAKwvOdn93S1iVM9y6aB+sYvUUjccDV4ymJU7+esWpG+zChAUPQ@mail.gmail.com>
Subject: Intro to the architecture of LLVM
To:     clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sharing a link to a talk I gave recently on the basics of working with
LLVM: https://youtu.be/bUTXhcf_aNc

-- 
Thanks,
~Nick Desaulniers
