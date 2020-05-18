Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 657B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4009920715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824419;
	bh=FpL7mcwiGgAZlwqxQo3u+VNrdlJ35y3eD3xLEbL3egI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VVoS4v66rlvvgb9CrgJApwkJmXlQAwvzcSA72XX4luZsdFLabJH4arNgojJdrmj/a
	 enEXkEtKJnEv6my92WyBt5NdIsSwM+tXsXcZ3TP4ZqdCtVYE0T2Wm7S3W1bHvIsXgd
	 fhhFXl0Eb6keI8bS2KD5kdfXoW/nsBz6uuJSyp2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731175AbgERRxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbgERRxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:53:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2583020829;
        Mon, 18 May 2020 17:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824415;
        bh=FpL7mcwiGgAZlwqxQo3u+VNrdlJ35y3eD3xLEbL3egI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vQk7y9bNJdsm2rsqKnP0lpLCTBdhCDfMyHZ2wx2eKQh0vC3bMgrMNVLnlh/VzLnew
         VAzyEmX4zvMWSfWeVKPgH+Tqad7oehmagVb3i9A2/CPgmi/VUFFoLQ3ooYx1w/vf9S
         MmF35hC16OSwwiqy9MtoQPF00WfFu2KTEJYn1Txo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.19 68/80] usb: gadget: net2272: Fix a memory leak in an error handling path in net2272_plat_probe()
Date:   Mon, 18 May 2020 19:37:26 +0200
Message-Id: <20200518173504.071419936@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.097837707@linuxfoundation.org>
References: <20200518173450.097837707@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit ccaef7e6e354fb65758eaddd3eae8065a8b3e295 upstream.

'dev' is allocated in 'net2272_probe_init()'. It must be freed in the error
handling path, as already done in the remove function (i.e.
'net2272_plat_remove()')

Fixes: 90fccb529d24 ("usb: gadget: Gadget directory cleanup - group UDC drivers")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/udc/net2272.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -2653,6 +2653,8 @@ net2272_plat_probe(struct platform_devic
  err_req:
 	release_mem_region(base, len);
  err:
+	kfree(dev);
+
 	return ret;
 }
 


