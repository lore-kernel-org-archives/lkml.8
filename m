Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB97CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81A622527
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 21:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uGV2axa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgA0VuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:50:10 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39431 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbgA0VuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 16:50:10 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so63295pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 13:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NpOlB//ZzI0MBEDQiVKjFEMeCtM1psB/23XTL+nYHaA=;
        b=uGV2axa3LUDYY8OP4z9b9BfFBg1WLTzo6tiMpl9fL27yrGYT6LOl7NMNHcgBX96etG
         ylJe/VrWKGKqrmOkfL+ZnX4u5iW3urL6yGakgr0tpMIupx27InplT04HUddlkX8rhGFG
         99mXBichTrBbpno8xEL1mWfxQmDPuaZZrlLRYAR6su9sJYnKpiOSvExOD5rhj+wow5Us
         12oqcx0b12tf+P8/gNi5POskqJVk6mdtUjWAA4sn7Z7qx/ELbelXzLjeCCtFW7doOlMe
         /yqsCabOvHROmgRoWoJA2BZMTtAyl5/qhdgzeQMJBJ7EkY4wRWCtLgpmr/eExF7YRsdd
         vrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NpOlB//ZzI0MBEDQiVKjFEMeCtM1psB/23XTL+nYHaA=;
        b=B+c1Q1Wb6Sxovckwua5CCdpnY6M+UJo8ZXygppP1kSNMBZPa2eYp4NwK1+ijxa4wW/
         C6nWYhZtzQQkwDjdWgjKhj5i44LFjWiws2DfHseaIJT2s4MX+BQ4NTZRyerUymYrpep9
         rx31Tfb3jSBNdqOR9Fb8qnu4v95P2MxUaa2yAheOCzMEKZMGDdu0nz9pHeGj1KDkr7Bf
         6DCu/iuYv6cCrJXyBXOQqzrfA7n9jmLyRsFeGmExYYI7kgBpCWvOGVyV/p87yYqe6Z8/
         Or6co8VkvI1HSnjVT2EmJGZ7ITcMm7CSAu1oIDVVSK05IAfljn1A8Sx4VNyu7ouXEeNh
         4Rtg==
X-Gm-Message-State: APjAAAUaaoy+CHv5+iqOhGyIxJR6wjRwXA8AXtFxRtJArGIASdDBkBYj
        ElbESPqdhguok6lngKbzHdBqQO5U
X-Google-Smtp-Source: APXvYqy0Uu3Qii7GLQAFGKM+NS/FkObRZHVA7dbEYsA91EXXOR3wneuSTi76st6N3C/TsMKJ2Ffftg==
X-Received: by 2002:a17:902:b107:: with SMTP id q7mr11993174plr.343.1580161809551;
        Mon, 27 Jan 2020 13:50:09 -0800 (PST)
Received: from gizo.domain (97-115-104-237.ptld.qwest.net. [97.115.104.237])
        by smtp.gmail.com with ESMTPSA id k9sm68301pjo.19.2020.01.27.13.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 13:50:09 -0800 (PST)
From:   Greg Rose <gvrose8192@gmail.com>
To:     linux-kernel@vger.kernel.org, dev@openvswitch.org
Cc:     dsahern@gmail.com, Greg Rose <gvrose8192@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] kbuild: Include external modules compile flags
Date:   Mon, 27 Jan 2020 13:50:06 -0800
Message-Id: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this commit:
'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into Makefile.modfinal")'
at least one out-of-tree external kernel module build fails
during the modfinal make phase because Makefile.modfinal does
not include the ccflags-y variable from the exernal module's Kbuild.
Make sure to include the external kernel module's Kbuild so that the
necessary command line flags from the external module are set.

Reported-by: David Ahern <dsahern@gmail.com>
CC: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Greg Rose <gvrose8192@gmail.com>
---
 scripts/Makefile.modfinal | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 411c1e60..a645ba6 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -21,6 +21,10 @@ __modfinal: $(modules)
 modname = $(notdir $(@:.mod.o=))
 part-of-module = y
 
+# Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
+include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
+             $(KBUILD_EXTMOD)/Kbuild)
+
 quiet_cmd_cc_o_c = CC [M]  $@
       cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
 
-- 
1.8.3.1

