Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B87C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC2E2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXTfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:35:30 -0400
Received: from smtprelay0078.hostedemail.com ([216.40.44.78]:41518 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbgGXTf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:35:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 308C818067A63;
        Fri, 24 Jul 2020 19:35:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tray10_461783926f49
X-Filterd-Recvd-Size: 16339
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 24 Jul 2020 19:35:26 +0000 (UTC)
Message-ID: <eb1d6f204103bac5ff81dabffa212c340432b813.camel@perches.com>
Subject: [trivial treewide PATCH] treewide: Fix misuses of 0x<decimal>%x
 format specifiers
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 24 Jul 2020 12:35:25 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are almost all typos where the decimal length value
should be after the % not before it.

Done using:

$ git grep -Pn --name-only '0x\d+%' | \
  xargs perl -p -i -e 's/\b0x(\d+)%/0x%\1/g'

There was a false positive in the grep:

drivers/media/usb/gspca/ov519.c:2760:                           gspca_err(gspca_dev, "Unknown sensor: 0x76%02x\n",

as the 76 is a specific required byte that was
converted to another format: 0x%02x%02x

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/m68k/include/asm/mmu_context.h                  | 2 +-
 arch/powerpc/kvm/book3s_xive.c                       | 2 +-
 drivers/atm/eni.c                                    | 2 +-
 drivers/dma/ppc4xx/adma.c                            | 2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                | 2 +-
 drivers/gpu/drm/i915/intel_uncore.c                  | 2 +-
 drivers/media/usb/gspca/ov519.c                      | 4 ++--
 drivers/mmc/host/cqhci.c                             | 2 +-
 drivers/mmc/host/s3cmci.c                            | 2 +-
 drivers/net/can/flexcan.c                            | 2 +-
 drivers/net/ethernet/intel/i40e/i40e_debugfs.c       | 2 +-
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c      | 2 +-
 drivers/net/wireless/intersil/hostap/hostap_hw.c     | 2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c        | 2 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c                 | 4 ++--
 drivers/staging/rtl8723bs/hal/hal_com_phycfg.c       | 2 +-
 drivers/usb/serial/spcp8x5.c                         | 2 +-
 drivers/video/fbdev/s1d13xxxfb.c                     | 2 +-
 sound/pci/es1938.c                                   | 4 ++--
 tools/perf/builtin-mem.c                             | 4 ++--
 21 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index 993fd7e37069..0f17a59d4100 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -163,7 +163,7 @@ static inline void load_ksp_mmu(struct task_struct *task)
 	goto end;
 
 bug:
-	pr_info("ksp load failed: mm=0x%p ksp=0x08%lx\n", mm, mmuar);
+	pr_info("ksp load failed: mm=0x%p ksp=0x%08lx\n", mm, mmuar);
 end:
 	local_irq_restore(flags);
 }
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 85215e79db42..ab42e1d23833 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1703,7 +1703,7 @@ static int xive_set_source(struct kvmppc_xive *xive, long irq, u64 addr)
 	server = val & KVM_XICS_DESTINATION_MASK;
 	guest_prio = val >> KVM_XICS_PRIORITY_SHIFT;
 
-	pr_devel("  val=0x016%llx (server=0x%x, guest_prio=%d)\n",
+	pr_devel("  val=0x%016llx (server=0x%x, guest_prio=%d)\n",
 		 val, server, guest_prio);
 
 	/*
diff --git a/drivers/atm/eni.c b/drivers/atm/eni.c
index b3d8e00e7671..bcbef5df4065 100644
--- a/drivers/atm/eni.c
+++ b/drivers/atm/eni.c
@@ -587,7 +587,7 @@ static int rx_aal5(struct atm_vcc *vcc)
 		if (length && length <= (size << 2)-8 && length <=
 		  ATM_MAX_AAL5_PDU) eff = (length+3) >> 2;
 		else {				 /* ^ trailer length (8) */
-			EVENT("bad PDU (descr=0x08%lx,length=%ld)\n",descr,
+			EVENT("bad PDU (descr=0x%08lx,length=%ld)\n",descr,
 			    length);
 			printk(KERN_ERR DEV_LABEL "(itf %d): bad AAL5 PDU "
 			    "(VCI=%d,length=%ld,size=%ld (descr 0x%lx))\n",
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 4db000d5f01c..33680772441f 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4363,7 +4363,7 @@ static ssize_t poly_show(struct device_driver *dev, char *buf)
 #endif
 
 	size = snprintf(buf, PAGE_SIZE, "PPC440SP(e) RAID-6 driver "
-			"uses 0x1%02x polynomial.\n", reg);
+			"uses 0x%102x polynomial.\n", reg);
 	return size;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4c7655f628a8..254c6bdbb821 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3020,7 +3020,7 @@ static void gfx_v9_0_rlc_start(struct amdgpu_device *adev)
 	/* RLC_GPM_GENERAL_6 : RLC Ucode version */
 	rlc_ucode_ver = RREG32_SOC15(GC, 0, mmRLC_GPM_GENERAL_6);
 	if(rlc_ucode_ver == 0x108) {
-		DRM_INFO("Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x08%x / fw_ver == %i \n",
+		DRM_INFO("Using rlc debug ucode. mmRLC_GPM_GENERAL_6 ==0x%08x / fw_ver == %i \n",
 				rlc_ucode_ver, adev->gfx.rlc_fw_version);
 		/* RLC_GPM_TIMER_INT_3 : Timer interval in RefCLK cycles,
 		 * default is 0x9C4 to create a 100us interval */
diff --git a/drivers/gpu/drm/i915/intel_uncore.c b/drivers/gpu/drm/i915/intel_uncore.c
index 8d5a933e6af6..2b1afb24d649 100644
--- a/drivers/gpu/drm/i915/intel_uncore.c
+++ b/drivers/gpu/drm/i915/intel_uncore.c
@@ -492,7 +492,7 @@ gen6_check_for_fifo_debug(struct intel_uncore *uncore)
 	fifodbg = __raw_uncore_read32(uncore, GTFIFODBG);
 
 *  	if (unlikely(fifodbg)) {
-		drm_dbg(&uncore->i915->drm, "GTFIFODBG = 0x08%x\n", fifodbg);
+		drm_dbg(&uncore->i915->drm, "GTFIFODBG = 0x%08x\n", fifodbg);
 		__raw_uncore_write32(uncore, GTFIFODBG, fifodbg);
 	}
 
diff --git a/drivers/media/usb/gspca/ov519.c b/drivers/media/usb/gspca/ov519.c
index 0afe70a3f9a2..29f985b096a9 100644
--- a/drivers/media/usb/gspca/ov519.c
+++ b/drivers/media/usb/gspca/ov519.c
@@ -2757,8 +2757,8 @@ static void ov7xx0_configure(struct sd *sd)
 				sd->sensor = SEN_OV7660;
 				break;
 			default:
-				gspca_err(gspca_dev, "Unknown sensor: 0x76%02x\n",
-					  low);
+				gspca_err(gspca_dev, "Unknown sensor: 0x%02x%02x\n",
+					  0x76, low);
 				return;
 			}
 		} else {
diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 8cc277b4ffe9..cfa87dfa73d8 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -422,7 +422,7 @@ static void cqhci_prep_task_desc(struct mmc_request *mrq,
 		CQHCI_BLK_COUNT(mrq->data->blocks) |
 		CQHCI_BLK_ADDR((u64)mrq->data->blk_addr);
 
-	pr_debug("%s: cqhci: tag %d task descriptor 0x016%llx\n",
+	pr_debug("%s: cqhci: tag %d task descriptor 0x%016llx\n",
 		 mmc_hostname(mrq->host), mrq->tag, (unsigned long long)*data);
 }
 
diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index 444b2769ae2c..a66fb26bd0cb 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -189,7 +189,7 @@ static void prepare_dbgmsg(struct s3cmci_host *host, struct mmc_command *cmd,
 			   int stop)
 {
 	snprintf(host->dbgmsg_cmd, 300,
-		 "#%u%s op:%i arg:0x%08x flags:0x08%x retries:%u",
+		 "#%u%s op:%i arg:0x%08x flags:0x%08x retries:%u",
 		 host->ccnt, (stop ? " (STOP)" : ""),
 		 cmd->opcode, cmd->arg, cmd->flags, cmd->retries);
 
diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
index 94d10ec954a0..3a4d9067ddba 100644
--- a/drivers/net/can/flexcan.c
+++ b/drivers/net/can/flexcan.c
@@ -1514,7 +1514,7 @@ static int flexcan_setup_stop_mode(struct platform_device *pdev)
 	priv->stm.ack_bit = out_val[4];
 
 	dev_dbg(&pdev->dev,
-		"gpr %s req_gpr=0x02%x req_bit=%u ack_gpr=0x02%x ack_bit=%u\n",
+		"gpr %s req_gpr=0x%02x req_bit=%u ack_gpr=0x%02x ack_bit=%u\n",
 		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit,
 		priv->stm.ack_gpr, priv->stm.ack_bit);
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
index d3ad2e3aa838..dcf002b57ddf 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_debugfs.c
@@ -441,7 +441,7 @@ static void i40e_dbg_dump_vsi_seid(struct i40e_pf *pf, int seid)
 		 "    info: sched_reserved = 0x%02x, outer_up_table = 0x%04x\n",
 		 vsi->info.sched_reserved, vsi->info.outer_up_table);
 	dev_info(&pf->pdev->dev,
-		 "    info: cmd_reserved[] = 0x%02x 0x%02x 0x%02x 0x0%02x 0x%02x 0x%02x 0x%02x 0x0%02x\n",
+		 "    info: cmd_reserved[] = 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x\n",
 		 vsi->info.cmd_reserved[0], vsi->info.cmd_reserved[1],
 		 vsi->info.cmd_reserved[2], vsi->info.cmd_reserved[3],
 		 vsi->info.cmd_reserved[4], vsi->info.cmd_reserved[5],
diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 23f7c76737c9..6c8d5fc57b0b 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -1394,7 +1394,7 @@ pch_gbe_alloc_rx_buffers(struct pch_gbe_adapter *adapter,
 		rx_desc->gbec_status = DSC_INIT16;
 
 		netdev_dbg(netdev,
-			   "i = %d  buffer_info->dma = 0x08%llx  buffer_info->length = 0x%x\n",
+			   "i = %d  buffer_info->dma = 0x%08llx  buffer_info->length = 0x%x\n",
 			   i, (unsigned long long)buffer_info->dma,
 			   buffer_info->length);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b3e740f1b601..a291c22fce34 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2295,7 +2295,7 @@ void iwl_trans_pcie_log_scd_error(struct iwl_trans *trans, struct iwl_txq *txq)
 	active = !!(status & BIT(SCD_QUEUE_STTS_REG_POS_ACTIVE));
 
 	IWL_ERR(trans,
-		"Queue %d is %sactive on fifo %d and stuck for %u ms. SW [%d, %d] HW [%d, %d] FH TRB=0x0%x\n",
+		"Queue %d is %sactive on fifo %d and stuck for %u ms. SW [%d, %d] HW [%d, %d] FH TRB=0x%x\n",
 		txq_id, active ? "" : "in", fifo,
 		jiffies_to_msecs(txq->wd_timeout),
 		txq->read_ptr, txq->write_ptr,
diff --git a/drivers/net/wireless/intersil/hostap/hostap_hw.c b/drivers/net/wireless/intersil/hostap/hostap_hw.c
index 2ab34cf74ecc..04a67d630b94 100644
--- a/drivers/net/wireless/intersil/hostap/hostap_hw.c
+++ b/drivers/net/wireless/intersil/hostap/hostap_hw.c
@@ -776,7 +776,7 @@ static int hfa384x_setup_bap(struct net_device *dev, u16 bap, u16 id,
 	if (HFA384X_INW(o_off) & HFA384X_OFFSET_ERR) {
 		prism2_io_debug_error(dev, 9);
 		printk(KERN_DEBUG "%s: hfa384x_setup_bap - offset error "
-		       "(%d,0x04%x,%d); reg=0x%04x\n",
+		       "(%d,0x%04x,%d); reg=0x%04x\n",
 		       dev->name, bap, id, offset, HFA384X_INW(o_off));
 		ret = -EINVAL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 426808413baa..68381f483e1f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -426,7 +426,7 @@ static void rtw8822c_dac_cal_adc(struct rtw_dev *rtwdev,
 		temp = (ic & 0x3ff) | ((qc & 0x3ff) << 10);
 		rtw_write32(rtwdev, base_addr + 0x68, temp);
 		dm_info->dack_adck[path] = temp;
-		rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] ADCK 0x%08x=0x08%x\n",
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[DACK] ADCK 0x%08x=0x%08x\n",
 			base_addr + 0x68, temp);
 		/* check ADC DC offset */
 		rtw_write32(rtwdev, 0x1c3c, path_sel + 0x8103);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 08fc4b381056..055b1dcc4ac4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -6158,7 +6158,7 @@ _scsih_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle, u8 phy_num,
 	/* check if device is present */
 	if (!(le16_to_cpu(sas_device_pg0.Flags) &
 	    MPI2_SAS_DEVICE0_FLAGS_DEVICE_PRESENT)) {
-		ioc_err(ioc, "device is not present handle(0x04%x)!!!\n",
+		ioc_err(ioc, "device is not present handle(0x%04x)!!!\n",
 			handle);
 		return -1;
 	}
@@ -6920,7 +6920,7 @@ _scsih_pcie_add_device(struct MPT3SAS_ADAPTER *ioc, u16 handle)
 	/* check if device is present */
 	if (!(le32_to_cpu(pcie_device_pg0.Flags) &
 		MPI26_PCIEDEV0_FLAGS_DEVICE_PRESENT)) {
-		ioc_err(ioc, "device is not present handle(0x04%x)!!!\n",
+		ioc_err(ioc, "device is not present handle(0x%04x)!!!\n",
 			handle);
 		return 0;
 	}
diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
index 10250642d30a..5786d93fd8e9 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
@@ -325,7 +325,7 @@ u8 PHY_GetRateSectionIndexOfTxPowerByRate(
 			index = 13;
 			break;
 		default:
-			DBG_871X("Invalid RegAddr 0x3%x in PHY_GetRateSectionIndexOfTxPowerByRate()", RegAddr);
+			DBG_871X("Invalid RegAddr 0x%3x in PHY_GetRateSectionIndexOfTxPowerByRate()", RegAddr);
 			break;
 		}
 	}
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 3bac55bd9bd9..6319e9236d51 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -222,7 +222,7 @@ static int spcp8x5_get_msr(struct usb_serial_port *port, u8 *status)
 		goto out;
 	}
 
-	dev_dbg(&port->dev, "0xc0:0x22:0:6  %d - 0x02%x\n", ret, *buf);
+	dev_dbg(&port->dev, "0xc0:0x22:0:6  %d - 0x%02x\n", ret, *buf);
 	*status = *buf;
 	ret = 0;
 out:
diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 4541afcf9386..f09dfc75198f 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -497,7 +497,7 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 	dbg_blit("(copyarea) sx=%d, sy=%d\n", sx, sy);
 	dbg_blit("(copyarea) width=%d, height=%d\n", width - 1, height - 1);
 	dbg_blit("(copyarea) stride=%d\n", stride);
-	dbg_blit("(copyarea) bpp=%d=0x0%d, mem_offset1=%d, mem_offset2=%d\n", bpp, (bpp >> 1),
+	dbg_blit("(copyarea) bpp=%d=0x%x, mem_offset1=%d, mem_offset2=%d\n", bpp, (bpp >> 1),
 		(stride >> 1) & 0xff, stride >> 9);
 
 	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CC_EXP, 0x0c);
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index 09704a78d799..f06a4b393430 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -303,7 +303,7 @@ static void snd_es1938_write_cmd(struct es1938 *chip, unsigned char cmd)
 		}
 	}
 	dev_err(chip->card->dev,
-		"snd_es1938_write_cmd timeout (0x02%x/0x02%x)\n", cmd, v);
+		"snd_es1938_write_cmd timeout (0x%02x/0x%02x)\n", cmd, v);
 }
 
 /* -----------------------------------------------------------------
@@ -316,7 +316,7 @@ static int snd_es1938_get_byte(struct es1938 *chip)
 	for (i = GET_LOOP_TIMEOUT; i; i--)
 		if ((v = inb(SLSB_REG(chip, STATUS))) & 0x80)
 			return inb(SLSB_REG(chip, READDATA));
-	dev_err(chip->card->dev, "get_byte timeout: status 0x02%x\n", v);
+	dev_err(chip->card->dev, "get_byte timeout: status 0x%02x\n", v);
 	return -ENODEV;
 }
 
diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 3523279af6af..fca70bae011f 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -166,7 +166,7 @@ dump_raw_samples(struct perf_tool *tool,
 			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s0x%016"PRIx64
 			      "%s%"PRIu64"%s0x%"PRIx64"%s%s:%s\n";
 		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
+			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x%016"PRIx64
 			      "%s0x%016"PRIx64"%s%5"PRIu64"%s0x%06"PRIx64
 			      "%s%s:%s\n";
 			symbol_conf.field_sep = " ";
@@ -194,7 +194,7 @@ dump_raw_samples(struct perf_tool *tool,
 			fmt = "%d%s%d%s0x%"PRIx64"%s0x%"PRIx64"%s%"PRIu64
 			      "%s0x%"PRIx64"%s%s:%s\n";
 		} else {
-			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x016%"PRIx64
+			fmt = "%5d%s%5d%s0x%016"PRIx64"%s0x%016"PRIx64
 			      "%s%5"PRIu64"%s0x%06"PRIx64"%s%s:%s\n";
 			symbol_conf.field_sep = " ";
 		}


