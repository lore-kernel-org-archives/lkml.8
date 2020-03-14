Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC2C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCBF20722
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW7i5Fee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCODvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:51:06 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38657 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgCODvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:51:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so7790345pfn.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 20:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sPbWWV08r2ldSiJHPQJ01Rn4O0B3sSDdcrAcKmWph1g=;
        b=QW7i5FeeXNjfG6R3UVN1n1/ZtkIiG39azeoF5yw9Ny5u3VDgdUHxRxSWGnG+VsF7OM
         X1+ZRGMMQAnbMEqAc9+7JI8Qg0YSvM3xJwvezj0XfBtj3ou0Ol6awmCDlj0OxYQIGIDS
         wNcLPy3bpCU3dJuSGhMRXPaVR+npzLmqN3W+6m3vs8ZKF83XuVSKoWgrxa0ti9H6IDJD
         GGL0UY4ymynGMrujQdwSVl422WU4K6bdxYwOaxPloKVZwCDii/Pt/H/hXr6RehoV66yx
         PzUUmYY/Yw+t7WPjmfAoic3KCnZsu++JGP2Dy38GyawNFT9brFwhkOScV0tjyzcgtpcS
         YuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPbWWV08r2ldSiJHPQJ01Rn4O0B3sSDdcrAcKmWph1g=;
        b=tiOopAAHeEWVAGUEs6/FB+/wPBbzohmcJq1KBnizmaNfiDRehvAkmqOPZgG/pg9j+7
         bbTQf+aLjLUlHY+/3FGeusNt1ju/SuM5WcQexLgNcf82fZ0hcqUF6siTxbkdV5PCen4+
         TNnxiLFD4EwehNp/se4Bc+NCOgqYZy9IRfXRgq4KMqmQPVBQAdgulMLOIY8f2nSR4xYX
         6fGaSsAhBlP0XVewHEc7An+kOh2C4Yd1aFRMYT85JwLiDI2uaWO1aLR7ysqvdKcQGQq7
         V8C50iQPwW+xyVO3W8ypnXXxLk1sTnn2BR5XA/J4Uoxu9p/GwEPgGFRyZ2QbDOs1wVIC
         oh5Q==
X-Gm-Message-State: ANhLgQ0c6sHXBqLqXYqhHYeEvMPKgZcE4XeFi2Kg8ljG/q2Ag3z/iGJI
        ooCosVV20kqAfYwJZbWGznXtgEp8HA83NfIvHSdv88suzboiMQ==
X-Google-Smtp-Source: ADFU+vvIkfkcfwxAYdvVjnHJJ6uBIdH/dpjrErzoz8vuZPwt2CO741RjIwXMThLIdvnECbyZq/sYyPnT4RWrZSLrf6U=
X-Received: by 2002:a05:6102:303c:: with SMTP id v28mr11077801vsa.91.1584164943910;
 Fri, 13 Mar 2020 22:49:03 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002e20b9059fee8a94@google.com>
In-Reply-To: <0000000000002e20b9059fee8a94@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sat, 14 Mar 2020 13:48:51 +0800
Message-ID: <CADG63jBKpM1vCzTHjPtTdsifpg_tuatd224BeFgra_ycXFW1ZQ@mail.gmail.com>
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
