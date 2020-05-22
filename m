Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603EC20759
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S36MNoi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgEVVmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731033AbgEVVmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:42:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC27C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r10so5604296pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiuX+6uU7dplATziC7RpCrG4th92FcbfoR1QRsJspzA=;
        b=S36MNoi9Vry7VUvzuC8akd9HrlW9CvNONK1CvQg7TBeWxwpnNipFYwhP6hQrLnQfoA
         CYrzz2dqjcmPtjcBHtjb0/xG5BGlMdBGvUzpEg+4yLqk9ZXdToZo/VaHkwv2Hd2TKylM
         4Wri/Ogai8IhhgWSY8IPo+p3jXoyYd8tesdZMlGdDrTOjak3nuO5RPVHD2h54/v8lYcf
         TRQB/TYrVALBLE7wz5g0PZqr9nk8+CVzTs5CeTkXd0Sm0Jd5N6to4Rh9ud7V7RJrlauh
         fSveQ6PFrtDmozzQ6PTo9w6lNfpVyQu6cO5lrLO7iMXaPKUlKR0NrzFlhPjWja4qEFzX
         FdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OiuX+6uU7dplATziC7RpCrG4th92FcbfoR1QRsJspzA=;
        b=Abc4PuJ5W5uQjyUztt1dKs1VzrnVrSmj9IAuyYm8Ucfvz5aLao4ERRDU+rnI1E4Hav
         11/P3sEZ7MZdteHN9d56n3WVgNeKbBkBaZNkGINYRKaDz2eDuNl/JGBnrIWG2utaqU4K
         yVBG5exe3ZfIccSmjAB9VOAAQNuHkRh4Vif7b50gR/eXeKZfl41byW43nqqMEhc57EmA
         XR/JHG3C5CQsOmjjtyIajQqOpI46R461QTNaiCG9QbkaCQlPwH4vNjmz6EqL75V6sAyA
         Lk7Z9vb/0foZUSesVzLGp+mGIKXI5brW/axu+STvkfk/NAKH1dlmg1LY/GFb7RuCSP9b
         woiA==
X-Gm-Message-State: AOAM5311q8Jnw7kXbFJa7HGi6d/BCi0TNPxDWk1fQLyWcMSZae41UDhA
        k3wUsn93LYYe35Iw4THIVRTPSTtn
X-Google-Smtp-Source: ABdhPJyncLF4FCA7MiLj+vo/jkNd/ZatPEi5dWPqOWL3ATw7UCNgkD4lWnaoI6Lgu1u3K2/xS89hcw==
X-Received: by 2002:a63:3756:: with SMTP id g22mr15416483pgn.304.1590183733064;
        Fri, 22 May 2020 14:42:13 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:400:e00:d0d2:96ff:22ac:b8e6])
        by smtp.gmail.com with ESMTPSA id 4sm7625098pff.18.2020.05.22.14.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 14:42:12 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, Arnd Bergmann <arnd@arndb.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/3] xtensa: clean up __user annotations in asm/uaccess.h
Date:   Fri, 22 May 2020 14:41:50 -0700
Message-Id: <20200522214153.30163-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series adds missing __user annotations to functions in
asm/uaccess.h. It fixes a bunch of sparse warnings for otherwise correct
code.

Max Filippov (3):
  xtensa: add missing __user annotations to __{get,put}_user_check
  xtensa: fix type conversion in __get_user_size
  xtensa: add missing __user annotations to asm/uaccess.h

 arch/xtensa/include/asm/uaccess.h | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

-- 
2.20.1

