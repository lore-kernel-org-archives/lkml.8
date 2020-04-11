Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE556C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550C218AC
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607068;
	bh=DX7Y/bTjcDckIPhehW9XWnDnMdMo6W/bQggp6rDI8+U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y9U+Cc2G2Ma2dnS/SvCT4Kq10tw/b93esH9loGLMUfmhuWoX/k9EqAHbK6I7Q3hjH
	 owbKCP65Cd5D7eP1a82ZIcY2klfE0uh9w/pns3YRFN6wUty13MBAIt4OqI3KaODHl7
	 vWSD4GgPv2NjpeZR9IAapJmSCw/cE4Ek4FuXfFS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgDKMLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:11:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgDKMLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:11:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C50521655;
        Sat, 11 Apr 2020 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607063;
        bh=DX7Y/bTjcDckIPhehW9XWnDnMdMo6W/bQggp6rDI8+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0/Rb44oZRiop+ksQVKq5NYzYSSolZnNm63xeD+zlsGYK+kkE9E6iU29yKV2oSUrxS
         5TSh+aPzvr8CYa6wDqM5nkJO1ux/TslUBMlx5FbMWXbA0jE7sGfR0RiofLT2U0NwsM
         DVgHDESLnEMihvLXtzyNJ9w+yDhEB2yOE0pnfYG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Nobuhiro Iwamatsu (CIP)" <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH 4.4 22/29] xen-netfront: Fix mismatched rtnl_unlock
Date:   Sat, 11 Apr 2020 14:08:52 +0200
Message-Id: <20200411115411.523635527@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115407.651296755@linuxfoundation.org>
References: <20200411115407.651296755@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ross Lagerwall <ross.lagerwall@citrix.com>

commit cb257783c2927b73614b20f915a91ff78aa6f3e8 upstream.

Fixes: f599c64fdf7d ("xen-netfront: Fix race between device setup and open")
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/xen-netfront.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1835,7 +1835,7 @@ static int talk_to_netback(struct xenbus
 	err = xen_net_read_mac(dev, info->netdev->dev_addr);
 	if (err) {
 		xenbus_dev_fatal(dev, err, "parsing %s/mac", dev->nodename);
-		goto out;
+		goto out_unlocked;
 	}
 
 	rtnl_lock();
@@ -1950,6 +1950,7 @@ abort_transaction_no_dev_fatal:
 	xennet_destroy_queues(info);
  out:
 	rtnl_unlock();
+out_unlocked:
 	device_unregister(&dev->dev);
 	return err;
 }


