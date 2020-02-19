Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AA8C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597432465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=es-iitr-ac-in.20150623.gappssmtp.com header.i=@es-iitr-ac-in.20150623.gappssmtp.com header.b="r/l08eDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgBST5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:57:00 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45747 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgBST47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:56:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so491759pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=es-iitr-ac-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=a7yW3eGud1nSB17w6PgcUOM+BLtId9z+DBtjQPe4XL0=;
        b=r/l08eDzR96yyXbytmobJW2Bl/fPaohWkVNzuCsnrvjhVcAb6GheysMrymn9aLAksW
         heGi5eeX4ymS+7fQqjPVdqR3W+0teRBB14DV4TJArI5VmU1ClW+cC/rqNQ8SyY4O3z/M
         X/cPNzvMGkj+IfvKrMCHh2nMWM1LIpEVitkwZeZaZUusIrLQdZQ2phfNKYqhW3qt7/iY
         rf79KBtXefhjbHADz0i4mZ+ROJtY1qJ1M8Vn5syeAk1QjZzOGln6i5hpbNgHQHPztRrf
         BsdMfEPmcoclw0n7l9rYCMJJmvylvV8paInd5zRQJ37e5ogoA3FOJvpC/DAl9fRmza5m
         thQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a7yW3eGud1nSB17w6PgcUOM+BLtId9z+DBtjQPe4XL0=;
        b=fhasdCqmAG5Ga9dzzCMpMVIE/0sXs6orI8wn1XH+PCgsoOkF2IhHPKE8LO4v0mbnX5
         OrGUvg4pgVtgT3xKZmqOyBRJoDvldR3vcK2e4or9LPvOzCFfweaBNBQhbyeYXDCsfiRm
         uRiqahDVC2kEarkz5skZ4wtz7cUlbIfcfdN/KgOGSj90EZqHa+cLzJbe9BbX76Cy/d9z
         zKV+AIkqRdiIvsXNFD4DCKlx7EdzUSmffcQlDLDAlaGdutAYbHWJCNHERD3O9tnRmbAY
         XSFJZbAysCmmcPilKM4qqCpg+jyi/ElRbghU0IrRTEs7jhKFor0YoWea5v6XHEpMKUUm
         89Ag==
X-Gm-Message-State: APjAAAXZQ8xEzpmAnidbYWsDp12kPGjnb8DmNCTpwzRzJaBQo/SX2PGm
        X+rdMODYizaMjkaHr/On86qe3Q==
X-Google-Smtp-Source: APXvYqxwuzVnh9ab7+j2hcebiGY8l+/eJsMFxnHM0mMZAQQEbpFy2cBwB1vsrtm/7WJQHXpNqIW4FA==
X-Received: by 2002:a17:90a:20aa:: with SMTP id f39mr10917261pjg.35.1582142218933;
        Wed, 19 Feb 2020 11:56:58 -0800 (PST)
Received: from kaaira-HP-Pavilion-Notebook ([103.37.201.172])
        by smtp.gmail.com with ESMTPSA id t189sm422306pfd.168.2020.02.19.11.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Feb 2020 11:56:58 -0800 (PST)
Date:   Thu, 20 Feb 2020 01:26:51 +0530
From:   Kaaira Gupta <kgupta@es.iitr.ac.in>
To:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: match parenthesis alignment
Message-ID: <20200219195651.GA485@kaaira-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl warning of alignment should match open parenthesis in
audio_codec.c

Signed-off-by: Kaaira Gupta <kgupta@es.iitr.ac.in>
---
 drivers/staging/greybus/audio_codec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 08746c85dea6..d62f91f4e9a2 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -70,7 +70,7 @@ static int gbaudio_module_enable_tx(struct gbaudio_codec_info *codec,
 		i2s_port = 0;	/* fixed for now */
 		cportid = data->connection->hd_cport_id;
 		ret = gb_audio_apbridgea_register_cport(data->connection,
-						i2s_port, cportid,
+							i2s_port, cportid,
 						AUDIO_APBRIDGEA_DIRECTION_TX);
 		if (ret) {
 			dev_err_ratelimited(module->dev,
@@ -160,7 +160,7 @@ static int gbaudio_module_disable_tx(struct gbaudio_module_info *module, int id)
 		i2s_port = 0;	/* fixed for now */
 		cportid = data->connection->hd_cport_id;
 		ret = gb_audio_apbridgea_unregister_cport(data->connection,
-						i2s_port, cportid,
+							  i2s_port, cportid,
 						AUDIO_APBRIDGEA_DIRECTION_TX);
 		if (ret) {
 			dev_err_ratelimited(module->dev,
@@ -205,7 +205,7 @@ static int gbaudio_module_enable_rx(struct gbaudio_codec_info *codec,
 		i2s_port = 0;	/* fixed for now */
 		cportid = data->connection->hd_cport_id;
 		ret = gb_audio_apbridgea_register_cport(data->connection,
-						i2s_port, cportid,
+							i2s_port, cportid,
 						AUDIO_APBRIDGEA_DIRECTION_RX);
 		if (ret) {
 			dev_err_ratelimited(module->dev,
@@ -295,7 +295,7 @@ static int gbaudio_module_disable_rx(struct gbaudio_module_info *module, int id)
 		i2s_port = 0;	/* fixed for now */
 		cportid = data->connection->hd_cport_id;
 		ret = gb_audio_apbridgea_unregister_cport(data->connection,
-						i2s_port, cportid,
+							  i2s_port, cportid,
 						AUDIO_APBRIDGEA_DIRECTION_RX);
 		if (ret) {
 			dev_err_ratelimited(module->dev,
-- 
2.17.1

