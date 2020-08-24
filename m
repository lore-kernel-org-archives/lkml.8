Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0D9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497AE20656
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2U6POoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHXUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHXUDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:03:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2653FC061573;
        Mon, 24 Aug 2020 13:03:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p11so2286394pfn.11;
        Mon, 24 Aug 2020 13:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=isOavbC0CqCTOWpwarMOyw2TDbIMP+uJPiDdCwZdCm4=;
        b=c2U6POoJvv+0vYTJHvEKQaX7ET3zmfZwu9hCOQz2NJZ+PiNfhFvjFQkeNq2hSR42uW
         7S8VHrutiLhiRBILzasdfdAJAUnRG1BHOCXg+p3O3MnhKvLqagdmz9JFCDcXCQjh55oY
         +f/IPLBAsnBHlUOyvhRwO9nsmc8HG92Qbgce3slKVbJKFawgJNYx1D+Z4lADIh2TFrhG
         AAQvK+mlzor09CElVJkoHNgs8uWmwthGXkvATFK48jV6B9yy1Bwy7gHmmM7rktLFFFkg
         xOykXFC2KPGf9A+h/7exWOnjehmtzUPeRqpqsFOFSR19UiXRudkmG3F43aht6Jpr7lZ7
         wN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=isOavbC0CqCTOWpwarMOyw2TDbIMP+uJPiDdCwZdCm4=;
        b=WTurTcg55fTsQIkCM7103viaEBo7c5mNR0dWsvLqWqNE6Yy123w/ArcPu/I0qUfD3F
         hIVx8RTq0125wvS2VMxqRdXGsuKffaJojOUC9TkmZqSnhcqZsHc2l5vufs8Ky0gSG9qQ
         K36SrFnyY2BSyD+/FDqFNXy2y4cocfHqzxyA5BjMLfpdOfRBbdBdFw5Ekujyv/Nh7gfn
         87ItI3umJSCW4CqcNtWeBg6/hRffikGpycsKSjabsEN2q+5xKso1pD9UcyAXfNtcgJlo
         kTsOQMevDs/YcQMBI7eo6veOCm3oRcs0u767oRY7CjkK8nIh6qfuAZemET5s/RAFsqvH
         WNfg==
X-Gm-Message-State: AOAM532YBl5TD3QkNPbJw7QJbkSfIpXUmXe5UxNOr1+jiS5v4dA/P3Bw
        3tZqtMeilEtWxjRXeEkpGbg=
X-Google-Smtp-Source: ABdhPJyNNJ7ZQ0kH+sJbXxUJ+q4pt6tVcRPH37tIEAQf5D8RdnbjPmfJNMPVfDiij6bCHTAMNMa81g==
X-Received: by 2002:a63:7018:: with SMTP id l24mr4221170pgc.55.1598299396720;
        Mon, 24 Aug 2020 13:03:16 -0700 (PDT)
Received: from Kaladin ([49.207.215.194])
        by smtp.gmail.com with ESMTPSA id d23sm10418236pgm.11.2020.08.24.13.03.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 13:03:16 -0700 (PDT)
Date:   Tue, 25 Aug 2020 01:33:11 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     davem@davemloft.net
Cc:     Julia.Lawall@lip6.fr, andrew@lunn.ch, sean.wang@mediatek.com,
        vivien.didelot@gmail.com, f.fainelli@gmail.com, kuba@kernel.org,
        matthias.bgg@gmail.com, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4] net: dsa: mt7530: Add of_node_put() before break and
 return statements
Message-ID: <20200824200311.GA19436@Kaladin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every iteration of for_each_child_of_node() decrements
the reference count of the previous node, however when control
is transferred from the middle of the loop, as in the case of
a return or break or goto, there is no decrement thus ultimately
resulting in a memory leak.

Fix a potential memory leak in mt7530.c by inserting of_node_put()
before the break and return statements.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
Changes in v2:
        Add another of_node_put() in for_each_child_of_node() as
pointed out by Andrew.

Changes in v3:
        - Correct syntax errors
        - Modify commit message

Changes in v4:
	- Change commit prefix to include the driver name,
mt7530, as pointed out by Vladimir.
	- Change the signoff to the correct format.

---
 drivers/net/dsa/mt7530.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 8dcb8a49ab67..4b4701c69fe1 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -1326,14 +1326,17 @@ mt7530_setup(struct dsa_switch *ds)
 
 			if (phy_node->parent == priv->dev->of_node->parent) {
 				ret = of_get_phy_mode(mac_np, &interface);
-				if (ret && ret != -ENODEV)
+				if (ret && ret != -ENODEV) {
+					of_node_put(mac_np);
 					return ret;
+				}
 				id = of_mdio_parse_addr(ds->dev, phy_node);
 				if (id == 0)
 					priv->p5_intf_sel = P5_INTF_SEL_PHY_P0;
 				if (id == 4)
 					priv->p5_intf_sel = P5_INTF_SEL_PHY_P4;
 			}
+			of_node_put(mac_np);
 			of_node_put(phy_node);
 			break;
 		}
-- 
2.17.1

