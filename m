Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D7FC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA552468A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686547;
	bh=nSAHvOUVAz2iud++EdWPQCKYaAGoYNGyurMVBBBXbtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LwYtAglNciduGM979VDNnfVsjPJwajhH0JYZrNHaB3zjoODJjaYjeJPhJ7SWT0P3E
	 U6p2p4Xsa0dpsKofMsamIuC0dSLqY/5I9Gs+34EXwgSeRJ6fbsaerDSLm2pcN2B89A
	 2MRB8DGIwY071IWBGnik8DxT+9dTV1LFmK5CBuYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733204AbgAVJk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:40:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387439AbgAVJkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2B4024684;
        Wed, 22 Jan 2020 09:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686019;
        bh=nSAHvOUVAz2iud++EdWPQCKYaAGoYNGyurMVBBBXbtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ojXX74J/FamHPgk3KsSb392+XjmSVMR1lg208q1YjOX+WggC4zdgUczLfAHX18Jh
         OqZefH5ty1YeLpeAax54I+GMu4Hb2qAln9iaHwZP1Bn1kuEWp9FyDPqU1vfeXBdHVi
         3HIIDxsWFgbkvvPm4y7PhsxPgGpRImxxU/0xHA4M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Reinhard Speyerer <rspmn@arcor.de>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.19 011/103] USB: serial: option: add support for Quectel RM500Q in QDL mode
Date:   Wed, 22 Jan 2020 10:28:27 +0100
Message-Id: <20200122092805.353380634@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092803.587683021@linuxfoundation.org>
References: <20200122092803.587683021@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Reinhard Speyerer <rspmn@arcor.de>

commit f3eaabbfd093c93d791eb930cc68d9b15246a65e upstream.

Add support for Quectel RM500Q in QDL mode.

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#= 24 Spd=480  MxCh= 0
D:  Ver= 2.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=2c7c ProdID=0800 Rev= 0.00
S:  Manufacturer=Qualcomm CDMA Technologies MSM
S:  Product=QUSB_BULK_SN:xxxxxxxx
S:  SerialNumber=xxxxxxxx
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=  2mA
I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=10 Driver=option
E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms

It is assumed that the ZLP flag required for other Qualcomm-based
5G devices also applies to Quectel RM500Q.

Signed-off-by: Reinhard Speyerer <rspmn@arcor.de>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1107,6 +1107,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EM12, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x30) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
+	  .driver_info = ZLP },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },


