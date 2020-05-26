Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10C9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F4E2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519595;
	bh=vGmwZHpig1AFU6Fxkz5cwv3Zkugjp1Au9Ze6oLu3msg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d3QQ2E2IcBv9PAK79fOCSleV6s7wPNeigRL1BIxfV5LNnDPsKTSH2dAG3lkkltHIl
	 cW8mly9dC2w20AefisCiaJUGjpGvXTpj7m2vkxiCgDLsW1Hq5X/BEuFjZ+gWttDJNL
	 LIBkqc/J0FaK5T6+w3v+qx9gTUZ8fiM7mbRvpjAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390613AbgEZS7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:59:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390583AbgEZS7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:59:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CD7C2084C;
        Tue, 26 May 2020 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519586;
        bh=vGmwZHpig1AFU6Fxkz5cwv3Zkugjp1Au9Ze6oLu3msg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdowEOeQt4K3e91SczR4JznLL3QAEeLZJANM3NxMqT1QOFs+4WMnucESsPtOEugRv
         yRuaEgfTgVEowKw9SznOaIWDvoa9/56YJYowXsQh8EhdNeSKJnaN1IVNKixKeZK5Pw
         zvGhqju2GfPB28VKP+B5kBjl/aXKg3lyGr/261kA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 61/64] iio: dac: vf610: Fix an error handling path in vf610_dac_probe()
Date:   Tue, 26 May 2020 20:53:30 +0200
Message-Id: <20200526183931.516954919@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183913.064413230@linuxfoundation.org>
References: <20200526183913.064413230@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit aad4742fbf0a560c25827adb58695a4497ffc204 upstream.

A call to 'vf610_dac_exit()' is missing in an error handling path.

Fixes: 1b983bf42fad ("iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/dac/vf610_dac.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/iio/dac/vf610_dac.c
+++ b/drivers/iio/dac/vf610_dac.c
@@ -235,6 +235,7 @@ static int vf610_dac_probe(struct platfo
 	return 0;
 
 error_iio_device_register:
+	vf610_dac_exit(info);
 	clk_disable_unprepare(info->clk);
 
 	return ret;


