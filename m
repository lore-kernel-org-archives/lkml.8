Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF898C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D9E20880
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 23:19:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGuy3lgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgBWXSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 18:18:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35766 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgBWXSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 18:18:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id b17so7457829wmb.0;
        Sun, 23 Feb 2020 15:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snlmcYtYDuvHwXmAmC2g0GkUCFgaXil3Rfxn4Ydoo+Q=;
        b=ZGuy3lgMu6uKf/X9D2SHX21zkV8GcEgjqUfqBX2/VsMNPWYVv9yk3VmWIbeXKBoX6h
         IEJ5XfchVqFSi5MortQ5DvdrkJ+w6DJtKX2ZjIJ6wkteB+gd7FLkaXNDXHT3keEqhEGq
         7+VzVRQE9s0hXskUNxNOZ1YsJPA+Ll+rRERd8aC840MN4w43/E4tHYsQuiRIN+mOa3aq
         X7VT1xs+3VvF/1BZzbft8ylQ9pmp2UcMokZfMj713duCV8mVFuct7/zrHVwDxHr3ZCe6
         3w6dfyqLL0yA7WnUEHuuQNoqoUNTw1sula3AR/Ic6Ip3Swd+DPlzTjzyNTVt6RVbhvWV
         dxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snlmcYtYDuvHwXmAmC2g0GkUCFgaXil3Rfxn4Ydoo+Q=;
        b=Cvs7UMkLovrfydS2q655NDOuQM23EBaqVhxc9Bu8I+AxuY8LaKWrfMv5gsQGIRmuLy
         ks7wlEcRNKmoKLazfYI/yLi/vzzgHLa2vMGNSis5sCd49Rmn9Vq/MYa57nGJY2Sd63kB
         v6YE1MoAAd15Iq88zVptocS5KBkrZ/ignHkzvy1Y3uQ/nM0tqe2zh4iRXtLu1zAWdQMe
         9F/KTHMSuY3wQqtMsl2kf4Xxz6K2HP4EG23JI8NF/ZV6k0tIbpy+IcVJ9+ak0JiI1rDd
         AgnP/yI9IVuDc/sIlEmbQWt5dys8n+CkMrsAjhaLo84NpJFD00Lk2MITAOlX6lYS0JW4
         8cwg==
X-Gm-Message-State: APjAAAUnl8ZepI85IR1Cw10meyMwzLIM3jvly+IvBRjUr88OZb2HHidy
        ilHG0oDbzBGir/edMdNIZYthUdeObvnv
X-Google-Smtp-Source: APXvYqyYZ3oMJ78+zymZmXiMpsjrXDyNhGOu0imdZd6MmzJ1dwnZa5BV+hh38cDu48X5BkdbSg9p7w==
X-Received: by 2002:a1c:4341:: with SMTP id q62mr18101720wma.107.1582499887152;
        Sun, 23 Feb 2020 15:18:07 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:06 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-hams@vger.kernel.org (open list:NETROM NETWORK LAYER),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH 12/30] net: netrom: Add missing annotation for nr_neigh_start()
Date:   Sun, 23 Feb 2020 23:16:53 +0000
Message-Id: <20200223231711.157699-13-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at nr_neigh_start()
warning: context imbalance in nr_neigh_start() - wrong count at exit
The root cause is the missing annotation at nr_neigh_start()
Add the missing __acquires(&nr_neigh_list_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 net/netrom/nr_route.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 637a743c060d..33e7b91fc805 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -895,6 +895,7 @@ const struct seq_operations nr_node_seqops = {
 };
 
 static void *nr_neigh_start(struct seq_file *seq, loff_t *pos)
+	__acquires(&nr_neigh_list_lock)
 {
 	spin_lock_bh(&nr_neigh_list_lock);
 	return seq_hlist_start_head(&nr_neigh_list, *pos);
-- 
2.24.1

