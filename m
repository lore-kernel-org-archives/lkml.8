Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86137C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E120754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5hHTwBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCRCSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:18:12 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:37768 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRCSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:18:11 -0400
Received: by mail-ua1-f54.google.com with SMTP id h32so8881588uah.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 19:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFrUk2+Eyc785NzJHh9AqDzcXv9ntwKnSngSFLs9xi8=;
        b=n5hHTwBBcpJ/DhiJ0y8sCfIgYABNVBKH+0R/SfE9l8BL8B5xMBfnI6YgjR+wzsREdg
         Hgsi8cQ6SdUDcqH0HpZ7ZJ67OKpMsMH0iTFZzh4MJjCen0flpUrX/zws3ntTEcH3XXp7
         GXLRJAOQNwDuWHO8wvg93grbYyIdVENi2148n+NNDOHKcSsRHsO7fZTSanfyosCHNvQZ
         ho7lwFCZzwrFdG3on0rp20Ad9R5pixgMRkqHDn3h58eqNkt0StT0Bnf69gI64mBGmP04
         hqqfBtvhInWfW98uHKzrUEovWInbdNv8VcfPIHWTukTcdbrAhJ/vV/qf1O2hNJO0giIj
         x9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFrUk2+Eyc785NzJHh9AqDzcXv9ntwKnSngSFLs9xi8=;
        b=UsoNg8ZzdscmndIJxlVp3SBoIx4VQfEKtHzwRCKOiApJuYLPfLd3ju32G4BUb3lbAv
         om+6mDdWr1D8El+MpLUuNs2zKvpyf1j9Ro/8As2AhADqCgmECbyZH4d5j46zpZNI3f4f
         PjpauYAjVjxp9ZHInrDdmzBWT8dvPufwR/zRcglHLWtAGRdX0m6hT5yNb5IDxfIsIgsL
         V9In6u5263e4QjOTLK379ilYTbvsyRNSgPwGYX7FIndi8d8LfLh+Z0yRHGgh2E3eYe/E
         PK+3VmPXX6h1IoLKx7WVIiG6O6Sma0tmf0kIW/ZFCsRZUIGAg+E49aVrcLeoJivN1I6F
         GoIQ==
X-Gm-Message-State: ANhLgQ2u99zuvcrPXhHMeisUQ1mMU09trcFdAtcX017/k2HgMeeZY3u2
        1OMxd8965Wuh5wppU9GnJ7PT9eswzjWfKWISoAw=
X-Google-Smtp-Source: ADFU+vv+fzarl6HBXznz/RGpx9z4idfZfOZzHi1dpALbSJXjR4Y7T1Fg9qqnf5RDzv0ldp9Sv0R8L8WCGa99rVX2bHs=
X-Received: by 2002:ab0:2e91:: with SMTP id f17mr1402878uaa.22.1584497890758;
 Tue, 17 Mar 2020 19:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002e20b9059fee8a94@google.com>
In-Reply-To: <0000000000002e20b9059fee8a94@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Wed, 18 Mar 2020 10:17:59 +0800
Message-ID: <CADG63jBhCBf6r8vfT6kCwh7shYHKsuGH=Mx8D+hDxO0C3Urjqw@mail.gmail.com>
Subject: Re: WARNING in idr_destroy
To:     syzbot <syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/hqj/hqjagain_test.git idr_destroy
