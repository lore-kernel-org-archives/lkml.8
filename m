Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAACC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3632E23128
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363716;
	bh=17QPbeEKarOTesGJ57OM/RN6hhUjRNgopEosfdRyfkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x8VyB+6jXh7WLLBCFnWDq+aBulAv+whFkdqmYCDQpfM1ZO1Wa7lCveSKFybpbmNT1
	 4u5pgiaWr0aS3eDPQLGp5jk8R9gQv6Tl5gqEcUL7u8YtuIX3nCYVnuPMo0XoF3A6JZ
	 C5AtGoecuPACHoCZJJ2toF/TnYIwRcaVH2p8ocik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388234AbgEMJzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:55:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:57928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388220AbgEMJzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:55:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 342E324935;
        Wed, 13 May 2020 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363707;
        bh=17QPbeEKarOTesGJ57OM/RN6hhUjRNgopEosfdRyfkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h08wkGzousmk4DTo9I5Vz1f9I3hcfB+NyPc61xttpmgECtr52KX48d+y6H8H2ue+t
         HsbqbeY/QySUwM7PuCHAv5etnjkeYZoCg8IM8ULnkQLdV70C+jdnFrrbzWVsEp9KRX
         A2nYMT3R9ZbTUEcoMadL4B5RK4hIwSyqAGMKhQMA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.6 093/118] batman-adv: Fix refcnt leak in batadv_show_throughput_override
Date:   Wed, 13 May 2020 11:45:12 +0200
Message-Id: <20200513094425.463259783@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094417.618129545@linuxfoundation.org>
References: <20200513094417.618129545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>

commit f872de8185acf1b48b954ba5bd8f9bc0a0d14016 upstream.

batadv_show_throughput_override() invokes batadv_hardif_get_by_netdev(),
which gets a batadv_hard_iface object from net_dev with increased refcnt
and its reference is assigned to a local pointer 'hard_iface'.

When batadv_show_throughput_override() returns, "hard_iface" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The issue happens in the normal path of
batadv_show_throughput_override(), which forgets to decrease the refcnt
increased by batadv_hardif_get_by_netdev() before the function returns,
causing a refcnt leak.

Fix this issue by calling batadv_hardif_put() before the
batadv_show_throughput_override() returns in the normal path.

Fixes: 0b5ecc6811bd ("batman-adv: add throughput override attribute to hard_ifaces")
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/batman-adv/sysfs.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/batman-adv/sysfs.c
+++ b/net/batman-adv/sysfs.c
@@ -1190,6 +1190,7 @@ static ssize_t batadv_show_throughput_ov
 
 	tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 
+	batadv_hardif_put(hard_iface);
 	return sprintf(buff, "%u.%u MBit\n", tp_override / 10,
 		       tp_override % 10);
 }


