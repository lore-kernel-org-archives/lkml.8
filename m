Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1672168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607891;
	bh=Vp1HU5MM0aP6YvXyu1D2mNusGmERSgN0wIc6HJRs83s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kmzEOr2wIu23fXgY90ChFjKRolE2I1D9u+UlVvjnSspS3fpA0mAZh6TUu+twBAK8A
	 X8oJRNK2RTtsH/l504hosv5sJnNfgj1yNp/fKPr+bJNutkieEdRpOoDwErJ7J84fOS
	 3wunMc0oTMSFKqe/o13Byq9vFb5L8UGDGmbpdV/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgBMPba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729508AbgBMP1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:55 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22D7320661;
        Thu, 13 Feb 2020 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607675;
        bh=Vp1HU5MM0aP6YvXyu1D2mNusGmERSgN0wIc6HJRs83s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sZYuofQb0EsfuxdhfrWlEDACvSd4AIuaxGBFKL4bADvnZqKcsmkRp2PQjtv+76DGD
         xdPa7Br/gRR5VFZudWNL6Q2YQ/6RZqd681INKam/JgD/gvez9RjXaPlNRKaPwyqvs5
         AR9HRJw4S6IjT9kas4Ygvy56UXPpwDbxjimTRjAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Beniamin Bia <beniamin.bia@analog.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 83/96] dt-bindings: iio: adc: ad7606: Fix wrong maxItems value
Date:   Thu, 13 Feb 2020 07:21:30 -0800
Message-Id: <20200213151910.299667068@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beniamin Bia <beniamin.bia@analog.com>

commit a6c4f77cb3b11f81077b53c4a38f21b92d41f21e upstream.

This patch set the correct value for oversampling maxItems. In the
original example, appears 3 items for oversampling while the maxItems
is set to 1, this patch fixes those issues.

Fixes: 416f882c3b40 ("dt-bindings: iio: adc: Migrate AD7606 documentation to yaml")
Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
@@ -85,7 +85,7 @@ properties:
       Must be the device tree identifier of the over-sampling
       mode pins. As the line is active high, it should be marked
       GPIO_ACTIVE_HIGH.
-    maxItems: 1
+    maxItems: 3
 
   adi,sw-mode:
     description:
@@ -128,9 +128,9 @@ examples:
                 adi,conversion-start-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
                 reset-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
                 adi,first-data-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
-                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH
-                                                &gpio 23 GPIO_ACTIVE_HIGH
-                                                &gpio 26 GPIO_ACTIVE_HIGH>;
+                adi,oversampling-ratio-gpios = <&gpio 18 GPIO_ACTIVE_HIGH>,
+                                               <&gpio 23 GPIO_ACTIVE_HIGH>,
+                                               <&gpio 26 GPIO_ACTIVE_HIGH>;
                 standby-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
                 adi,sw-mode;
         };


