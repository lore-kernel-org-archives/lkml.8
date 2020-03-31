Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B100BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869132072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="oV5P06Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgCaMkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:40:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37912 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgCaMkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:40:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id s1so25704101wrv.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlAnJrkXBGo8I/5PAoNTQvXp1pi40LxDq4eq+SGwqso=;
        b=oV5P06MkBvSrkOT1Aqm/1/YGzWCZRXO78xWc0mNjAoqJ2XAqKXqb3XRPK5hYLreV0p
         XltrDEzuffcHj1sCwWaAVXqTU9YDvMrkNwdRIwa8/R3w7k8fi9c50WAiXPvQPDFdywt4
         Z1A/mphHcYpIrgbtdOlDPFZVQ56TL5Bz+is50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YlAnJrkXBGo8I/5PAoNTQvXp1pi40LxDq4eq+SGwqso=;
        b=Iug/Y5y6AneBdsrk/63zaIo9grBa6fV7qWjErlD5h5pAjvyCDkvxIEdyKRpnFFLPtc
         ILhLAAXFg0l6g81kpufCNS4x5hniS056x7ChyRXQDBA5EMcaLpjSgDh927dr+R1HL7Y7
         u6YuUDnXa6YqhKy7S2t5PtiaR0e1miXldFiKBIzRvYtrS72g79JkfJfF/Gfmh1QKWMWN
         HX1I5ZqyKEuMKKWWgsZ6Z5H4cJBN4CgenzlqcsfDQ/sek01SjzMQ01x03DXAthUjpeVT
         mrmYg+PhnC2iwuEZRbJvBsPPRN9Ahp/zMohTmyr4KgE+0gkKxObVJDg7ye0rd7WSv/TS
         AJxQ==
X-Gm-Message-State: ANhLgQ1p6mjW+zQQJkwBrgh73va65ytXOb5g9Lf4TtSIcyigqWdhz9PL
        CXNhYqeQVlRZC7kaHdFVFF2GzWDyi2pRbw==
X-Google-Smtp-Source: ADFU+vsmRSLCggUdju+RKpUVxA9QIxOsOjyjEAu75BiSJSVqcvKDhC96dQo/67fXjZRLX7J7UDLTcw==
X-Received: by 2002:adf:e492:: with SMTP id i18mr19970031wrm.316.1585658430816;
        Tue, 31 Mar 2020 05:40:30 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id w66sm3819159wma.38.2020.03.31.05.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:40:30 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 0/1] an option to place initramfs in a leaf tmpfs instead of rootfs
Date:   Tue, 31 Mar 2020 13:40:16 +0100
Message-Id: <20200331124017.2252-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting [1] with a more verbose commit description.
Changes from v1:
  * document the flag in kernel-parameters.txt

[1]: https://lore.kernel.org/linux-fsdevel/20200305193511.28621-1-ignat@cloudflare.com/

Ignat Korchagin (1):
  mnt: add support for non-rootfs initramfs

 .../admin-guide/kernel-parameters.txt         |  9 +++-
 fs/namespace.c                                | 47 +++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.20.1

