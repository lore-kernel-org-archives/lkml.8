Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7500C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3ECD20409
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 12:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgCZM3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 08:29:32 -0400
Received: from mga05.intel.com ([192.55.52.43]:12370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727781AbgCZM3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 08:29:32 -0400
IronPort-SDR: dN5uaA0nrIGKSKfked7lua6qHE4Kr7b9A6cqGM0Xcmv/4vPPcjMcZgp1F123mSE2IwqYcftlIZ
 tvwKhwN4McnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 05:29:31 -0700
IronPort-SDR: dXPNEOPC5+kdmw+CvdnwzeOi9ptIUMJEKuzfPDCIKxbLhXIeXygIF/ttMOk3pFtj0IjKLzQ62q
 KGoPFyrQUwNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,308,1580803200"; 
   d="scan'208";a="282481672"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2020 05:29:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHRdY-0006mo-JG; Thu, 26 Mar 2020 20:29:28 +0800
Date:   Thu, 26 Mar 2020 20:28:58 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Colin King <colin.king@canonical.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] usb: cdns3: cdns3_clear_register_bit() can be static
Message-ID: <20200326122858.GA50118@cde5a4ed3207>
References: <20200325125041.94769-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325125041.94769-1-colin.king@canonical.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 87db1192dc33 ("usb: cdns3: make signed 1 bit bitfields unsigned")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 gadget.c |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 372460ea4df9a..54a04614d336f 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -82,7 +82,7 @@ static int cdns3_ep_run_stream_transfer(struct cdns3_endpoint *priv_ep,
  * @ptr: address of device controller register to be read and changed
  * @mask: bits requested to clar
  */
-void cdns3_clear_register_bit(void __iomem *ptr, u32 mask)
+static void cdns3_clear_register_bit(void __iomem *ptr, u32 mask)
 {
 	mask = readl(ptr) & ~mask;
 	writel(mask, ptr);
@@ -137,7 +137,7 @@ struct usb_request *cdns3_next_request(struct list_head *list)
  *
  * Returns buffer or NULL if no buffers in list
  */
-struct cdns3_aligned_buf *cdns3_next_align_buf(struct list_head *list)
+static struct cdns3_aligned_buf *cdns3_next_align_buf(struct list_head *list)
 {
 	return list_first_entry_or_null(list, struct cdns3_aligned_buf, list);
 }
@@ -148,7 +148,7 @@ struct cdns3_aligned_buf *cdns3_next_align_buf(struct list_head *list)
  *
  * Returns request or NULL if no requests in list
  */
-struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
+static struct cdns3_request *cdns3_next_priv_request(struct list_head *list)
 {
 	return list_first_entry_or_null(list, struct cdns3_request, list);
 }
@@ -190,7 +190,7 @@ dma_addr_t cdns3_trb_virt_to_dma(struct cdns3_endpoint *priv_ep,
 	return priv_ep->trb_pool_dma + offset;
 }
 
-int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
+static int cdns3_ring_size(struct cdns3_endpoint *priv_ep)
 {
 	switch (priv_ep->type) {
 	case USB_ENDPOINT_XFER_ISOC:
@@ -345,7 +345,7 @@ static void cdns3_ep_inc_deq(struct cdns3_endpoint *priv_ep)
 	cdns3_ep_inc_trb(&priv_ep->dequeue, &priv_ep->ccs, priv_ep->num_trbs);
 }
 
-void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
+static void cdns3_move_deq_to_next_trb(struct cdns3_request *priv_req)
 {
 	struct cdns3_endpoint *priv_ep = priv_req->priv_ep;
 	int current_trb = priv_req->start_trb;
@@ -511,9 +511,9 @@ static void cdns3_wa2_descmiss_copy_data(struct cdns3_endpoint *priv_ep,
 	}
 }
 
-struct usb_request *cdns3_wa2_gadget_giveback(struct cdns3_device *priv_dev,
-					      struct cdns3_endpoint *priv_ep,
-					      struct cdns3_request *priv_req)
+static struct usb_request *cdns3_wa2_gadget_giveback(struct cdns3_device *priv_dev,
+						     struct cdns3_endpoint *priv_ep,
+						     struct cdns3_request *priv_req)
 {
 	if (priv_ep->flags & EP_QUIRK_EXTRA_BUF_EN &&
 	    priv_req->flags & REQUEST_INTERNAL) {
@@ -551,9 +551,9 @@ struct usb_request *cdns3_wa2_gadget_giveback(struct cdns3_device *priv_dev,
 	return &priv_req->request;
 }
 
-int cdns3_wa2_gadget_ep_queue(struct cdns3_device *priv_dev,
-			      struct cdns3_endpoint *priv_ep,
-			      struct cdns3_request *priv_req)
+static int cdns3_wa2_gadget_ep_queue(struct cdns3_device *priv_dev,
+				     struct cdns3_endpoint *priv_ep,
+				     struct cdns3_request *priv_req)
 {
 	int deferred = 0;
 
@@ -836,7 +836,7 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);
 }
 
-void cdns3_wa1_restore_cycle_bit(struct cdns3_endpoint *priv_ep)
+static void cdns3_wa1_restore_cycle_bit(struct cdns3_endpoint *priv_ep)
 {
 	/* Work around for stale data address in TRB*/
 	if (priv_ep->wa1_set) {
@@ -1904,8 +1904,8 @@ static int cdns3_ep_onchip_buffer_reserve(struct cdns3_device *priv_dev,
 	return 0;
 }
 
-void cdns3_stream_ep_reconfig(struct cdns3_device *priv_dev,
-			      struct cdns3_endpoint *priv_ep)
+static void cdns3_stream_ep_reconfig(struct cdns3_device *priv_dev,
+				     struct cdns3_endpoint *priv_ep)
 {
 	if (!priv_ep->use_streams || priv_dev->gadget.speed < USB_SPEED_SUPER)
 		return;
@@ -1925,8 +1925,8 @@ void cdns3_stream_ep_reconfig(struct cdns3_device *priv_dev,
 			       EP_CFG_TDL_CHK | EP_CFG_SID_CHK);
 }
 
-void cdns3_configure_dmult(struct cdns3_device *priv_dev,
-			   struct cdns3_endpoint *priv_ep)
+static void cdns3_configure_dmult(struct cdns3_device *priv_dev,
+				  struct cdns3_endpoint *priv_ep)
 {
 	struct cdns3_usb_regs __iomem *regs = priv_dev->regs;
 
