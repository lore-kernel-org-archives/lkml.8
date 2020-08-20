Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80599C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DFEA2224D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597927454;
	bh=gMAJQySplqK3LODlD+yqkkSZmARBSR3jSggcw7cFqr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GGZ3t0+DIk+j36dfZvcDGcE5nRR9iR/iu47jEGsSKaolLg3X518JT411jC4ehHVff
	 0+S00fjzA4M5riFXIHwF9dijmf4Fq0s/NOv7vEqSIHLaDwX5RMAKTHRFo8JprLT9lP
	 zlkFedge2J6i2F3PhQzGcc/yMPLYi+L6Y2IT8NLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgHTMoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgHTJpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:45:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AF6922BEA;
        Thu, 20 Aug 2020 09:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916747;
        bh=gMAJQySplqK3LODlD+yqkkSZmARBSR3jSggcw7cFqr8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R85QHV7HYgtKwD0bHwh5hVRGSp+HdHm/ZoJXx++WG6s1p0Of1xeSWEWq2ccyCIrig
         e61IGK+bcCfi4SMxhE7f6P9/LTDmgTf69h6rmZcQMxBPQNwLhnZrSj3Ohq1B7yTHGX
         TZil4PFgBaUKt/gb/LPfzZ4/1SWDMVnlVo5CYmec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Christian Eggers <ceggers@arri.de>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 5.4 031/152] dt-bindings: iio: io-channel-mux: Fix compatible string in example code
Date:   Thu, 20 Aug 2020 11:19:58 +0200
Message-Id: <20200820091555.246371152@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Eggers <ceggers@arri.de>

commit add48ba425192c6e04ce70549129cacd01e2a09e upstream.

The correct compatible string is "gpio-mux" (see
bindings/mux/gpio-mux.txt).

Cc: stable@vger.kernel.org # v4.13+
Reviewed-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Christian Eggers <ceggers@arri.de>
Link: https://lore.kernel.org/r/20200727101605.24384-1-ceggers@arri.de
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
+++ b/Documentation/devicetree/bindings/iio/multiplexer/io-channel-mux.txt
@@ -21,7 +21,7 @@ controller state. The mux controller sta
 
 Example:
 	mux: mux-controller {
-		compatible = "mux-gpio";
+		compatible = "gpio-mux";
 		#mux-control-cells = <0>;
 
 		mux-gpios = <&pioA 0 GPIO_ACTIVE_HIGH>,


