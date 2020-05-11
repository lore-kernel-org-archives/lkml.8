Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740A5C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F44206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgEKSzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:55:33 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:45216 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728808AbgEKSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:55:33 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 894BF181D3026;
        Mon, 11 May 2020 18:55:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trade74_3024178e33902
X-Filterd-Recvd-Size: 12182
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 18:55:30 +0000 (UTC)
Message-ID: <9269adb8213bd9eab64112a5ec7efcc40c52dc2e.camel@perches.com>
Subject: [trivial PATCH -next] treewide: typo: decriptor -> descriptor
From:   Joe Perches <joe@perches.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <trivial@kernel.org>
Date:   Mon, 11 May 2020 11:55:29 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just typo fixing, done with:

$ git grep -w -i --name-only decriptor | \
  xargs sed -r -i -e 's/\b([Dd])ecriptor\b/\1escriptor/'

Miscellanea:

o Fixed a nearby scartch/scratch typo too.

Signed-off-by: Joe Perches <joe@perches.com>
---

noticed when looking at a dynamic debug patch

 drivers/atm/iphase.h                | 2 +-
 drivers/devfreq/devfreq-event.c     | 4 ++--
 drivers/gpio/TODO                   | 2 +-
 drivers/gpu/drm/drm_dp_helper.c     | 2 +-
 drivers/infiniband/hw/hfi1/iowait.h | 2 +-
 drivers/input/joystick/spaceball.c  | 2 +-
 drivers/mtd/nand/raw/nand_bbt.c     | 2 +-
 drivers/net/wan/lmc/lmc_main.c      | 4 ++--
 drivers/regulator/fixed.c           | 2 +-
 drivers/regulator/gpio-regulator.c  | 2 +-
 drivers/scsi/ibmvscsi/ibmvfc.c      | 2 +-
 drivers/scsi/ibmvscsi/ibmvscsi.c    | 2 +-
 include/drm/drm_dp_helper.h         | 2 +-
 include/linux/dynamic_debug.h       | 2 +-
 kernel/trace/trace_events.c         | 2 +-
 mm/balloon_compaction.c             | 4 ++--
 16 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/atm/iphase.h b/drivers/atm/iphase.h
index 2beacf2fc1ec..c0b83ad033e7 100644
--- a/drivers/atm/iphase.h
+++ b/drivers/atm/iphase.h
@@ -569,7 +569,7 @@ struct rx_buf_desc {
 /* These memory maps are actually offsets from the segmentation and reassembly  RAM base addresses */  
   
 /* Segmentation Control Memory map */  
-#define TX_DESC_BASE	0x0000	/* Buffer Decriptor Table */  
+#define TX_DESC_BASE	0x0000	/* Buffer Descriptor Table */  
 #define TX_COMP_Q	0x1000	/* Transmit Complete Queue */  
 #define PKT_RDY_Q	0x1400	/* Packet Ready Queue */  
 #define CBR_SCHED_TABLE	0x1800	/* CBR Table */  
diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 8c31b0f2e28f..56efbeb7851e 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -293,7 +293,7 @@ static void devfreq_event_release_edev(struct device *dev)
 /**
  * devfreq_event_add_edev() - Add new devfreq-event device.
  * @dev		: the device owning the devfreq-event device being created
- * @desc	: the devfreq-event device's decriptor which include essential
+ * @desc	: the devfreq-event device's descriptor which include essential
  *		  data for devfreq-event device.
  *
  * Note that this function add new devfreq-event device to devfreq-event class
@@ -385,7 +385,7 @@ static void devm_devfreq_event_release(struct device *dev, void *res)
 /**
  * devm_devfreq_event_add_edev() - Resource-managed devfreq_event_add_edev()
  * @dev		: the device owning the devfreq-event device being created
- * @desc	: the devfreq-event device's decriptor which include essential
+ * @desc	: the devfreq-event device's descriptor which include essential
  *		  data for devfreq-event device.
  *
  * Note that this function manages automatically the memory of devfreq-event
diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index b989c9352da2..e560e45e84f8 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -5,7 +5,7 @@ subsystem.
 GPIO descriptors
 
 Starting with commit 79a9becda894 the GPIO subsystem embarked on a journey
-to move away from the global GPIO numberspace and toward a decriptor-based
+to move away from the global GPIO numberspace and toward a descriptor-based
 approach. This means that GPIO consumers, drivers and machine descriptions
 ideally have no use or idea of the global GPIO numberspace that has/was
 used in the inception of the GPIO subsystem.
diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 612a59ec8116..738d18551de6 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -1364,7 +1364,7 @@ EXPORT_SYMBOL(drm_dp_get_edid_quirks);
 /**
  * drm_dp_read_desc - read sink/branch descriptor from DPCD
  * @aux: DisplayPort AUX channel
- * @desc: Device decriptor to fill from DPCD
+ * @desc: Device descriptor to fill from DPCD
  * @is_branch: true for branch devices, false for sink devices
  *
  * Read DPCD 0x400 (sink) or 0x500 (branch) into @desc. Also debug log the
diff --git a/drivers/infiniband/hw/hfi1/iowait.h b/drivers/infiniband/hw/hfi1/iowait.h
index 07847cb72169..d580aa17ae37 100644
--- a/drivers/infiniband/hw/hfi1/iowait.h
+++ b/drivers/infiniband/hw/hfi1/iowait.h
@@ -399,7 +399,7 @@ static inline void iowait_get_priority(struct iowait *w)
  * @wait_head: the wait queue
  *
  * This function is called to insert an iowait struct into a
- * wait queue after a resource (eg, sdma decriptor or pio
+ * wait queue after a resource (eg, sdma descriptor or pio
  * buffer) is run out.
  */
 static inline void iowait_queue(bool pkts_sent, struct iowait *w,
diff --git a/drivers/input/joystick/spaceball.c b/drivers/input/joystick/spaceball.c
index cf7cbcd0c29d..92002a8b9e8b 100644
--- a/drivers/input/joystick/spaceball.c
+++ b/drivers/input/joystick/spaceball.c
@@ -124,7 +124,7 @@ static void spaceball_process_packet(struct spaceball* spaceball)
 }
 
 /*
- * Spaceball 4000 FLX packets all start with a one letter packet-type decriptor,
+ * Spaceball 4000 FLX packets all start with a one letter packet-type descriptor,
  * and end in 0x0d. It uses '^' as an escape for CR, XOFF and XON characters which
  * can occur in the axis values.
  */
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index 96045d60471e..344a24fd2ca8 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -1226,7 +1226,7 @@ static int nand_scan_bbt(struct nand_chip *this, struct nand_bbt_descr *bd)
 		return -ENOMEM;
 
 	/*
-	 * If no primary table decriptor is given, scan the device to build a
+	 * If no primary table descriptor is given, scan the device to build a
 	 * memory based bad block table.
 	 */
 	if (!td) {
diff --git a/drivers/net/wan/lmc/lmc_main.c b/drivers/net/wan/lmc/lmc_main.c
index a20f467ca48a..9755e1e5c882 100644
--- a/drivers/net/wan/lmc/lmc_main.c
+++ b/drivers/net/wan/lmc/lmc_main.c
@@ -2063,8 +2063,8 @@ static void lmc_driver_timeout(struct net_device *dev, unsigned int txqueue)
     /*
      * Chip seems to have locked up
      * Reset it
-     * This whips out all our decriptor
-     * table and starts from scartch
+     * This whips out all our descriptor
+     * table and starts from scratch
      */
 
     LMC_EVENT_LOG(LMC_EVENT_XMTPRCTMO,
diff --git a/drivers/regulator/fixed.c b/drivers/regulator/fixed.c
index bc0bbd99e98d..d54830e48b8d 100644
--- a/drivers/regulator/fixed.c
+++ b/drivers/regulator/fixed.c
@@ -210,7 +210,7 @@ static int reg_fixed_voltage_probe(struct platform_device *pdev)
 
 	/*
 	 * The signal will be inverted by the GPIO core if flagged so in the
-	 * decriptor.
+	 * descriptor.
 	 */
 	if (config->enabled_at_boot)
 		gflags = GPIOD_OUT_HIGH;
diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 110ee6fe76c4..181451f922f1 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -311,7 +311,7 @@ static int gpio_regulator_probe(struct platform_device *pdev)
 
 	/*
 	 * The signal will be inverted by the GPIO core if flagged so in the
-	 * decriptor.
+	 * descriptor.
 	 */
 	if (config->enabled_at_boot)
 		gflags = GPIOD_OUT_HIGH | GPIOD_FLAGS_BIT_NONEXCLUSIVE;
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 635f6f9cffc4..77f4d37d5bd6 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1344,7 +1344,7 @@ static void ibmvfc_map_sg_list(struct scsi_cmnd *scmd, int nseg,
 }
 
 /**
- * ibmvfc_map_sg_data - Maps dma for a scatterlist and initializes decriptor fields
+ * ibmvfc_map_sg_data - Maps dma for a scatterlist and initializes descriptor fields
  * @scmd:		struct scsi_cmnd with the scatterlist
  * @evt:		ibmvfc event struct
  * @vfc_cmd:	vfc_cmd that contains the memory descriptor
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 59f0f1030c54..9e7495aeba43 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -667,7 +667,7 @@ static int map_sg_list(struct scsi_cmnd *cmd, int nseg,
 }
 
 /**
- * map_sg_data: - Maps dma for a scatterlist and initializes decriptor fields
+ * map_sg_data: - Maps dma for a scatterlist and initializes descriptor fields
  * @cmd:	struct scsi_cmnd with the scatterlist
  * @srp_cmd:	srp_cmd that contains the memory descriptor
  * @dev:	device for which to map dma memory
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 6c4b53dcb851..b9b99629f8ff 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1698,7 +1698,7 @@ enum drm_dp_quirk {
 
 /**
  * drm_dp_has_quirk() - does the DP device have a specific quirk
- * @desc: Device decriptor filled by drm_dp_read_desc()
+ * @desc: Device descriptor filled by drm_dp_read_desc()
  * @edid_quirks: Optional quirk bitmask filled by drm_dp_get_edid_quirks()
  * @quirk: Quirk to query for
  *
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fde30eb..a06ef7380b2d 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -133,7 +133,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 /*
  * "Factory macro" for generating a call to func, guarded by a
- * DYNAMIC_DEBUG_BRANCH. The dynamic debug decriptor will be
+ * DYNAMIC_DEBUG_BRANCH. The dynamic debug descriptor will be
  * initialized using the fmt argument. The function will be called with
  * the address of the descriptor as first argument, followed by all
  * the varargs. Note that fmt is repeated in invocations of this
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 242f59e7f17d..2c1e35ffcbb6 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2475,7 +2475,7 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 }
 
 /*
- * Just create a decriptor for early init. A descriptor is required
+ * Just create a descriptor for early init. A descriptor is required
  * for enabling events at boot. We want to enable events before
  * the filesystem is initialized.
  */
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..907fefde2572 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 /**
  * balloon_page_list_dequeue() - removes pages from balloon's page list and
  *				 returns a list of the pages.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  * @pages: pointer to the list of pages that would be returned to the caller.
  * @n_req_pages: number of requested pages.
  *
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  *
  * Driver must call this function to properly dequeue a previously enqueued page
  * before definitively releasing it back to the guest system.

