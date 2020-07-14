Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956A8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B420C56
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="rarA1JVv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=inbox.ru header.i=@inbox.ru header.b="rarA1JVv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgGNMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:45:36 -0400
Received: from fallback17.m.smailru.net ([94.100.176.130]:38406 "EHLO
        fallback17.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgGNMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:45:35 -0400
X-Greylist: delayed 2645 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2020 08:45:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=qbHt0xTQ8gvYX85r2GgVVZNjX4CqlbhbtSIusxndApI=;
        b=rarA1JVvjcBb5okw+X5zdOWmuf1u5RpupNZRvNSNmIhlP55VbNJytTD7vEJRAIluohnrfqO+kUQbMk8GB3rh9G8v21nA+novJqE2szsk5ZgX+eNqXDkJV0GusgvlOLd9EaE7bs8nRecORAxlOWFWqBsL1BRyNkJbT8IYbUy0LM8=;
Received: from [10.161.64.44] (port=52268 helo=smtp36.i.mail.ru)
        by fallback17.m.smailru.net with esmtp (envelope-from <fido_max@inbox.ru>)
        id 1jvJcl-0007Fg-6q
        for linux-kernel@vger.kernel.org; Tue, 14 Jul 2020 15:01:27 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=inbox.ru; s=mail;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=qbHt0xTQ8gvYX85r2GgVVZNjX4CqlbhbtSIusxndApI=;
        b=rarA1JVvjcBb5okw+X5zdOWmuf1u5RpupNZRvNSNmIhlP55VbNJytTD7vEJRAIluohnrfqO+kUQbMk8GB3rh9G8v21nA+novJqE2szsk5ZgX+eNqXDkJV0GusgvlOLd9EaE7bs8nRecORAxlOWFWqBsL1BRyNkJbT8IYbUy0LM8=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <fido_max@inbox.ru>)
        id 1jvJch-0003R0-2o; Tue, 14 Jul 2020 15:01:23 +0300
From:   Maxim Kochetkov <fido_max@inbox.ru>
Cc:     Maxim Kochetkov <fido_max@inbox.ru>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gianfar: Use random MAC address when none is given
Date:   Tue, 14 Jul 2020 15:01:04 +0300
Message-Id: <20200714120104.257819-1-fido_max@inbox.ru>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9BB76C036EA8E79AC7183BC094B6F439707A04E6D4477B360182A05F538085040FE9E7DC89FC4EB4012E6849F381C3FA7DC809E60F3FC4F0404B695EBED5383FD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7AED985C8E545F588EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370D3D68FCEFFDD9EA8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FC213B1F18E6357999AC01BF80EEC924F54356B433C02D987D389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C05A64D9A1E9CA65708941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C34964A708C60C975A117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947C724336BCC0EE1BA82D242C3BD2E3F4C64AD6D5ED66289B52C79FDBAFFB82A7259735652A29929C6C725E5C173C3A84C36ED3D2230264E88FBA3038C0950A5D36B5C8C57E37DE458B0B4866841D68ED3567F23339F89546C55F5C1EE8F4F765FC2303E78B907142AC75ECD9A6C639B01BBD4B6F7A4D31EC0BC0CAF46E325F83A522CA9DD8327EE4930A3850AC1BE2E735E4A630A5B664A4FFC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C8649E89: 94EF0272A9D89B9EF87A4F89EFDF43799A759607405807F9AD839F8A94B4F7BAC9759BC6ED5F36F0
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB6ZTT+PDdQTwMtP0u4aUog==
X-Mailru-Sender: 11C2EC085EDE56FA9C10FA2967F5AB24DD87BDCA44971A3634F755EE91CABA9A8D65200875EB1684EE9242D420CFEBFD3DDE9B364B0DF2891A624F84B2C74EDA4239CF2AF0A6D4F80DA7A0AF5A3A8387
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4147F32E2E3FD3168531095BDAC846E1A692A065875C7E56768F3CF0E9FE49B692022726CF533BD93D3A5C365C5E6E138C88083DD89C81B5CBBBCFBF40EC1E8CB
X-7FA49CB5: 0D63561A33F958A5CCBB3A1FA6F977126312C4CA0301EFE23B5A80210D29EE468941B15DA834481FA18204E546F3947C744B801E316CB65FF6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8B2EE5AD8F952D28FBA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22490103F85E399B2B9276E601842F6C81A12EF20D2F80756B5F13660E01DFBDB6B6089D37D7C0E48F6CA18204E546F3947C83C798A30B85E16BCE5475246E174218C8A9BA7A39EFB7666BA297DBC24807EA089D37D7C0E48F6C8AA50765F7900637AF8E4F18C523FAA9EFF80C71ABB335746BA297DBC24807EA27F269C8F02392CDC58410348177836EABEDDA51113D120200306258E7E6ABB4E4A6367B16DE6309
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojB6ZTT+PDdQQ1hVfU5MPrKw==
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005E7955441BDF86265BFC7CBB18C8FB6147A635300F1BE684FE2167D3455AE77B5C099ADC76E806A99D50E20E2BC48EF5A30D242760C51EA9CEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no valid MAC address in the device tree,
use a random MAC address.

Signed-off-by: Maxim Kochetkov <fido_max@inbox.ru>
---
 drivers/net/ethernet/freescale/gianfar.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index b3c69e9038ea..b513b8c5c3b5 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -779,8 +779,12 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 
 	mac_addr = of_get_mac_address(np);
 
-	if (!IS_ERR(mac_addr))
+	if (!IS_ERR(mac_addr)) {
 		ether_addr_copy(dev->dev_addr, mac_addr);
+	} else {
+		eth_hw_addr_random(dev);
+		dev_info(&ofdev->dev, "Using random MAC address: %pM\n", dev->dev_addr);
+	}
 
 	if (model && !strcasecmp(model, "TSEC"))
 		priv->device_flags |= FSL_GIANFAR_DEV_HAS_GIGABIT |
-- 
2.27.0

