Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFB8C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AEC24962
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 04:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588999019;
	bh=07whU8E+PdoH4NwOYzR8jGBxm037oXhrsUh4WAxtlNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o/SrIoBMX5dZE5DE3FiDlYCJ7Q52LTXYV7Opl8+0pPcDbbSdXS8Y3s+f2ImuZ3Vge
	 QyqiUMk6A/Q5LMDPiczVVkYadpstNorbXaDdmd1DNeDjzLGWa9VxjmcuPqGrOV2bbE
	 uhcf1+YWK9Uf+XNlRf107KOq9X5B0sJMa7siXoqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728949AbgEIEg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 00:36:59 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33924 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728789AbgEIEgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 00:36:12 -0400
Received: by mail-pj1-f65.google.com with SMTP id h12so5932031pjz.1;
        Fri, 08 May 2020 21:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R8OF7M46D8C3jXOaoBlaMReTLKc3NpL8x+JXeBlXDQg=;
        b=nvcAwBwQZEc1lhm0aTUd7bqmWD0Ukv1tpbmzlUqeSyXpTDA+DZvi+93KaJ9E/NevpC
         5TKMOECAxCbY6REFmzfjSMlemCek0BDCl2RFzzNEkCK4jOEYlM5p8ypzLF4EYMsYaNmx
         CxwjhmEB4Sp6a4BRn8Z2Yu8z0jMVj3/FjzDq+v/FfLsxlGMre0AHHMfEFv4ZKfXorMs/
         pDCFgfZusTAFA5vhzjPACurJMs5t7Y2w7aBDGJ/Pj5lEvNpxUlSrEADrhFSo2QFSyrtG
         cFqAre0aHMEHqoTWVzHjynCj2Vcwyn8gJs852bApLN/kn/gS+soLCFyLDxunT7whWaPl
         M6PQ==
X-Gm-Message-State: AGi0PuaLZVEv3BxSaTUVVKhbikTTSi1jInjMbCp87xE3HDzOJoIA+XOM
        2SB4QkbABAnjSrEmk8Yosf0=
X-Google-Smtp-Source: APiQypJSSjbk0NmFTzHRNzIfQCloTXWW0xkAQE1qPeAZ/jpIIOTv5jKkbRXhFpIU2ohllZvSDW+DGw==
X-Received: by 2002:a17:902:eb4b:: with SMTP id i11mr5451742pli.19.1588998971874;
        Fri, 08 May 2020 21:36:11 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l15sm3565848pjk.56.2020.05.08.21.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:36:07 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 1D69742079; Sat,  9 May 2020 04:36:01 +0000 (UTC)
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
        Vishal Kulkarni <vishal@chelsio.com>
Subject: [PATCH 07/15] cxgb4: use new module_firmware_crashed()
Date:   Sat,  9 May 2020 04:35:44 +0000
Message-Id: <20200509043552.8745-8-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200509043552.8745-1-mcgrof@kernel.org>
References: <20200509043552.8745-1-mcgrof@kernel.org>
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

Cc: Vishal Kulkarni <vishal@chelsio.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index a70018f067aa..c67fc86c0e42 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -3646,6 +3646,7 @@ void t4_fatal_err(struct adapter *adap)
 	 * could be exposed to the adapter.  RDMA MWs for example...
 	 */
 	t4_shutdown_adapter(adap);
+	module_firmware_crashed();
 	for_each_port(adap, port) {
 		struct net_device *dev = adap->port[port];
 
-- 
2.25.1

