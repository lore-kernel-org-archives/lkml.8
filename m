Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B24F3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7A123119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:03:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="msJ9eXJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgHFRDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgHFRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:01:57 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC4BC034604
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 05:32:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id jp10so23541882ejb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wITD6sAbyjVa5WRqw37Sc/Lb0EfyweCj3P0+wea36Io=;
        b=msJ9eXJ47kbGAjrgF16460tFJbqR1deSR1wZPU7U9hNgjFASv3q85xr2slEvFTf+6+
         OFVC/KLvPCzDI5Qxf76YP1S7TsIxD2WlS/YUD4j0f181kF1qkAsSYk/kzrLJ9pFLNFHg
         gAHn6CyMn4rfYiwBHHF8VwVijPNm/sHxrWS/AmS0y5JjpvXv5sdSh4e3XF30kbZ68lHa
         jXBI3++7orK5KUNl2Lw7ZVMj7Srr2/GdksdFS0Dd1NAunpT+2VCFBlmu3dXmtmXDam45
         RibxBrvNcGgGJ6AoFvguHJIYRy+01MDjpvXT4IFsl4uDDnTyJf7oPjXHHKZtPddY+hYF
         vyCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wITD6sAbyjVa5WRqw37Sc/Lb0EfyweCj3P0+wea36Io=;
        b=k1qzfUzZ8O3V0X9l58pMRCgT4JJdM5+MEDP+PTYcLDSWF9E7ZTblJIOqoEDZEbzZ4I
         rIW4KsQLFvKLSdms0wSOCQDVEBumS2gle1aacy2j6gJsGaQVWCROAteXL0EzAmMTBrMS
         gjNgAl9TVTDZE9OTs5EAH7FUyWe3l5RRklvUyjuVocFMru1ZoCo7urLe8XQUFi8Cxovh
         BbKh13ISG5pvgPf18zS+WutCLUqvDfa3UAp/iDkNSSDs+J1N7vEJXuMPckHWQGuYztY6
         vu9gHhaXj29N9691ZlfUePZvEuGGyebEejPNIghC4FSPyC4SKLlLk8QX8++ZOXcrrcRf
         N9nA==
X-Gm-Message-State: AOAM531R+wPHSrKSurnssiiF6GdkRFAtDSHatZZCBi0DPTrOeVuup/fj
        dhMy6m7pnq/4+37BAS8mfAuoiw==
X-Google-Smtp-Source: ABdhPJyyXzW2CgSWZhZQ4DtQV/ji+0A+9TGcUGcy18YDaELUmm5VvDivlLRl9mTyjP31xr+nAvgiAg==
X-Received: by 2002:a17:906:f202:: with SMTP id gt2mr4056426ejb.70.1596717129751;
        Thu, 06 Aug 2020 05:32:09 -0700 (PDT)
Received: from tim.froidcoeur.net (ptr-7tznw15pracyli75x11.18120a2.ip6.access.telenet.be. [2a02:1811:50e:f0f0:d05d:939:f42b:f575])
        by smtp.gmail.com with ESMTPSA id c5sm3695778ejb.103.2020.08.06.05.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 05:32:09 -0700 (PDT)
From:   Tim Froidcoeur <tim.froidcoeur@tessares.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Patrick McHardy <kaber@trash.net>,
        KOVACS Krisztian <hidden@balabit.hu>
Cc:     Tim Froidcoeur <tim.froidcoeur@tessares.net>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v3 2/2] net: initialize fastreuse on inet_inherit_port
Date:   Thu,  6 Aug 2020 14:30:23 +0200
Message-Id: <20200806123024.585212-3-tim.froidcoeur@tessares.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806123024.585212-1-tim.froidcoeur@tessares.net>
References: <20200806123024.585212-1-tim.froidcoeur@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of TPROXY, bind_conflict optimizations for SO_REUSEADDR or
SO_REUSEPORT are broken, possibly resulting in O(n) instead of O(1) bind
behaviour or in the incorrect reuse of a bind.

the kernel keeps track for each bind_bucket if all sockets in the
bind_bucket support SO_REUSEADDR or SO_REUSEPORT in two fastreuse flags.
These flags allow skipping the costly bind_conflict check when possible
(meaning when all sockets have the proper SO_REUSE option).

For every socket added to a bind_bucket, these flags need to be updated.
As soon as a socket that does not support reuse is added, the flag is
set to false and will never go back to true, unless the bind_bucket is
deleted.

Note that there is no mechanism to re-evaluate these flags when a socket
is removed (this might make sense when removing a socket that would not
allow reuse; this leaves room for a future patch).

For this optimization to work, it is mandatory that these flags are
properly initialized and updated.

When a child socket is created from a listen socket in
__inet_inherit_port, the TPROXY case could create a new bind bucket
without properly initializing these flags, thus preventing the
optimization to work. Alternatively, a socket not allowing reuse could
be added to an existing bind bucket without updating the flags, causing
bind_conflict to never be called as it should.

Call inet_csk_update_fastreuse when __inet_inherit_port decides to create
a new bind_bucket or use a different bind_bucket than the one of the
listen socket.

Fixes: 093d282321da ("tproxy: fix hash locking issue when using port redirection in __inet_inherit_port()")
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Tim Froidcoeur <tim.froidcoeur@tessares.net>
---
 net/ipv4/inet_hashtables.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 2bbaaf0c7176..006a34b18537 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -163,6 +163,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 				return -ENOMEM;
 			}
 		}
+		inet_csk_update_fastreuse(tb, child);
 	}
 	inet_bind_hash(child, tb, port);
 	spin_unlock(&head->lock);
-- 
2.25.1

