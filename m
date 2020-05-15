Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EBBF20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589578214;
	bh=LIfEaLR4Btf7fZsQI0hmTN4QqTI8byeX+bqlA3HfH+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=thzZ11xA0Ew8tMAV6l+d6lzutKpjWDkJYE2Z4gweFVr8BI2tvBkyqvqK40CngBF4N
	 YpseWXIqa3JlHBFQnGd47nPVGVPeJBQotek+Mw1MZIJHL/iXohtibE6T/LwKwpMKcY
	 iKNO8uDL8joFiJnfEjgLEmeErFjZODGRcrXsSJMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgEOVaO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:30:14 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:53439 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgEOV25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:28:57 -0400
Received: by mail-pj1-f67.google.com with SMTP id hi11so1478795pjb.3;
        Fri, 15 May 2020 14:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfS8RWQILq5pTxsiwJfRKnCbiFfxKVOF+i1nmZH/cEc=;
        b=cHahCf7CLkL4kfpfmih1x5N6/feF48MZgbx5eEkuYk65j8O4PaHb6eGXgGVz6LR7Ax
         IP/gmHiRc4/myy7Jf7XuiqKBvz16JY5DjMaecLMP7ArLVctpv2MbxXavfj5GbqysxNaU
         rpuUwy2gzGV0e3Cc02KA4DVsy3yq0Q3RcR7n/3UFfJL02omregaz9H3u09/vcD967rVY
         s+BNyAt6zdHovGQAp6XFEY7Xp2FdmxBruWnSxoCJpzT55RvME9UGGQjgTaLWYGzyjw/k
         ayVmozkwT2YB1EWWmQKiVT8ggkf5W52W+jXASD2Hq2tmgs0xlCtX4NDK2wokgbg1n9jd
         yTVw==
X-Gm-Message-State: AOAM531QRFWiKi0nXQ+eITvPE/PjeQcfDW5KUSeM5BWaVezO5WuRu8wT
        TaibqIPa4uRPiCbEFLInBYw=
X-Google-Smtp-Source: ABdhPJyDXHKz7boZGvqXqSLG3GjzTod1lFNdJn6sXhTEjxoVmBj7l/4U3APnTK6uCHCt/7oLvtItAA==
X-Received: by 2002:a17:902:dc84:: with SMTP id n4mr5635258pld.281.1589578135789;
        Fri, 15 May 2020 14:28:55 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v7sm2644511pfm.146.2020.05.15.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 14:28:51 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B9C4A41DAB; Fri, 15 May 2020 21:28:49 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Michael Chan <michael.chan@broadcom.com>
Subject: [PATCH v2 04/15] bnxt: use new module_firmware_crashed()
Date:   Fri, 15 May 2020 21:28:35 +0000
Message-Id: <20200515212846.1347-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200515212846.1347-1-mcgrof@kernel.org>
References: <20200515212846.1347-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes use of the new module_firmware_crashed() to help
annotate when firmware for device drivers crash. When firmware
crashes devices can sometimes become unresponsive, and recovery
sometimes requires a driver unload / reload and in the worst cases
a reboot.

Using a taint flag allows us to annotate when this happens clearly.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index dd0c3f227009..5ba1bd0734e9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -3503,6 +3503,7 @@ static int bnxt_get_dump_data(struct net_device *dev, struct ethtool_dump *dump,
 
 	dump->flag = bp->dump_flag;
 	if (dump->flag == BNXT_DUMP_CRASH) {
+		module_firmware_crashed();
 #ifdef CONFIG_TEE_BNXT_FW
 		return tee_bnxt_copy_coredump(buf, 0, dump->len);
 #endif
-- 
2.26.2

