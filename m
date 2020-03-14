Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3CFC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F756206E7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 02:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZr+4+Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgCNCJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 22:09:49 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:36286 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCNCJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 22:09:49 -0400
Received: by mail-ua1-f43.google.com with SMTP id 8so4403067uar.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 19:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPbWWV08r2ldSiJHPQJ01Rn4O0B3sSDdcrAcKmWph1g=;
        b=bZr+4+FziGyljaoYQA83s9KxKUprDcm5d+73PBGk95VzO4aJbtzYO+g42+UfhmEVsk
         0Hp4DTj9WQK3PIKoAxuSJEYoM2gKUI+1DHOFZe41DUR1BXGrekOc+U5v+rnfulgnZXEZ
         6ZFcG1FoSSrYsqOEoqm4834VspYiTeTXzXr5HAMK8clCOiGq0V//9Odv7gjd1YPfoO5M
         aK8baFAcKxcPo5lcLS3WdIJAnLoeKzgjOMNVwKgHjJR1uALhs8fljaDNEh4bVVB10MzZ
         NhYeKerRjQRX7rM2gyvPbYZzLd89+KeV4im+xMlGV2uWfkURPH8W9AmpT043/Om2GobY
         nDlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPbWWV08r2ldSiJHPQJ01Rn4O0B3sSDdcrAcKmWph1g=;
        b=U6GapM5T+hB3LJOlKMNuEScHrntJtg1rkFwSmMC8wozylVnWji5yeV9vqi7TS/UVE7
         qrWGq1krNDM+pLK1Xu5Sy3ym6ho7J0GRW8HDlcGOPlBDPQ9aS9AvZUnI96jfvG6BGVe3
         vIitFGcn87RW4Gc/r5Ab0n/zhszI52d4zRv5Pw1NfC0LX1mBHO859oBGp+LSsa0s3lAU
         4nqBB1MyPtpBySXSYCX0q8FCvcBcVj7ByvXDCd5weYPo5yO/tNMJfsKgYKKuxu6E0qZk
         r9n/tGAYw6vWjuJRPasQJWM+dxmjZDXkhs2KzTbGUUzg51FYwiFVDGspD0CRNp4s++5D
         7TVQ==
X-Gm-Message-State: ANhLgQ1pfiFXP1dxCHnc/Z5INHOCNzzrJHzAEJ7qiszZmYs4gNKs0R1Y
        e2r2KAANZxBHWPDc8ct1kunTAKylqEASHLgyCfA=
X-Google-Smtp-Source: ADFU+vsXHY48gs2M7YHj32iDdaterKb43Dy83U6vKnQVQIKEhjuzjrbH8f0deEdjEnmklpzykeotJ+1E5v6fDxz/J/o=
X-Received: by 2002:ab0:2e91:: with SMTP id f17mr6601281uaa.22.1584151788140;
 Fri, 13 Mar 2020 19:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002e20b9059fee8a94@google.com>
In-Reply-To: <0000000000002e20b9059fee8a94@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sat, 14 Mar 2020 10:09:36 +0800
Message-ID: <CADG63jAAgdzmVQGHhxAY-diyMisXenTpd02StvwJytqkjGeSuw@mail.gmail.com>
Subject: Re: WARNING in idr_destroy
To:     syzbot <syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz test: https://github.com/hqj/hqjagain_test.git drm
