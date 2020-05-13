Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADCBCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4B2C20769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363224;
	bh=JqvLFulQJvacUXzq45/Z6hDpklPx4qQiKdxm51xAiRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RrTsMb0tKMOx+9ZX/j/6F3270b+W90BR43D4vX9z5QOdEAf8oHkNpcfp/1FFhhuJq
	 rMyDID6BbXkzHLsijD6EPx+HM/xJaHU+ovLWFPa3VDftfJyASWZn4bhnTWA1to2sZ6
	 sA6TNUx8wqreOdZiGpmbncpXtKqStNDsllrX6ul4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732772AbgEMJrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:47:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732756AbgEMJq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:46:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4B4E206F5;
        Wed, 13 May 2020 09:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363218;
        bh=JqvLFulQJvacUXzq45/Z6hDpklPx4qQiKdxm51xAiRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nu0+EsBjOXl+Ijm5ezujfm8NwHdqyN6/bp5RMqwPD0vFJDhnugBuAM7OyAbfIOOo8
         D9pcH/QeFVYHMQONfgZcpZqyBwj/5Kj9DX7eSGCG9wy7zIWcRLTG/KH6Se7cHiBNDU
         AHolpYOJA8EwH6Dtx6G0porHq5EEYRdCyPM7ndZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.19 34/48] batman-adv: Fix refcnt leak in batadv_show_throughput_override
Date:   Wed, 13 May 2020 11:45:00 +0200
Message-Id: <20200513094400.382531314@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094351.100352960@linuxfoundation.org>
References: <20200513094351.100352960@linuxfoundation.org>
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
@@ -1126,6 +1126,7 @@ static ssize_t batadv_show_throughput_ov
 
 	tp_override = atomic_read(&hard_iface->bat_v.throughput_override);
 
+	batadv_hardif_put(hard_iface);
 	return sprintf(buff, "%u.%u MBit\n", tp_override / 10,
 		       tp_override % 10);
 }


