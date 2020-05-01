Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30045C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F04B22051A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341450;
	bh=761Bbgf25zGCxuCWZFVc4F5QdNTSleGkwcKFWnr7NLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SWo4UNT5dW2b466YdyA+kZEDMW4eRbnGRpXJzHJUxpDbdXdVTT/OSFpd0sqmkGw+S
	 +ZuSYQnDnAA7TEE3HxsSZBEzKT0at7XCvTi5KvwFUzkFyd0kYhuQ3FTpUtB04d62mm
	 hmPPNKcN3wRGfqq8HkvyqDDMRTrs7HaKx76GgDrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgEAN53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729078AbgEANbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C59420757;
        Fri,  1 May 2020 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339879;
        bh=761Bbgf25zGCxuCWZFVc4F5QdNTSleGkwcKFWnr7NLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BQRfgAHj/gUhJAx+4TiEhhImKO7zrrIGj6Hf/s7ttBWvxsnXV44Is9BzNxsflkCXT
         /aooutbBE+dPRz7LSmfBDVed80G+LiW/FrYhEQaNwVg/Ugm83ySmJOEMltICyMHh3s
         lYV+tQ6JDIRiONTRlRVkQqNfFoLCIFLPzwzbyhGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 003/117] net: ipv4: avoid unused variable warning for sysctl
Date:   Fri,  1 May 2020 15:20:39 +0200
Message-Id: <20200501131545.832201653@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

commit 773daa3caf5d3f87fdb1ab43e9c1b367a38fa394 upstream.

The newly introudced ip_min_valid_pmtu variable is only used when
CONFIG_SYSCTL is set:

net/ipv4/route.c:135:12: error: 'ip_min_valid_pmtu' defined but not used [-Werror=unused-variable]

This moves it to the other variables like it, to avoid the harmless
warning.

Fixes: c7272c2f1229 ("net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv4/route.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -133,8 +133,6 @@ static int ip_rt_min_advmss __read_mostl
 
 static int ip_rt_gc_timeout __read_mostly	= RT_GC_TIMEOUT;
 
-static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
-
 /*
  *	Interface to generic destination cache.
  */
@@ -2869,6 +2867,7 @@ void ip_rt_multicast_event(struct in_dev
 static int ip_rt_gc_interval __read_mostly  = 60 * HZ;
 static int ip_rt_gc_min_interval __read_mostly	= HZ / 2;
 static int ip_rt_gc_elasticity __read_mostly	= 8;
+static int ip_min_valid_pmtu __read_mostly	= IPV4_MIN_MTU;
 
 static int ipv4_sysctl_rtcache_flush(struct ctl_table *__ctl, int write,
 					void __user *buffer,


