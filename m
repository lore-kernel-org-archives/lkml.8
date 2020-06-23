Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA665C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B684D207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbgFWTIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:08:45 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42789 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733220AbgFWTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:08:44 -0400
X-IronPort-AV: E=Sophos;i="5.75,272,1589234400"; 
   d="scan'208";a="456312240"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 21:08:28 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     trivial@kernel.org
Cc:     kernel-janitors@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, joe@perches.com
Subject: [PATCH v2] trivial: fix kerneldoc comments
Date:   Tue, 23 Jun 2020 20:28:00 +0200
Message-Id: <1592936880-25804-1-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the parameter names in the comment to correspond to those in the
function header.

Drop comments about return values when there is no return value.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
---

v2: Fixed some spacing and punctuation issues noted by Joe Perches and Dan
Carpenter, and rechecked all the spacing again, and made a few changes.

 arch/arm/mach-omap2/omap-secure.c                |  2 +-
 arch/arm/mach-prima2/rtciobrg.c                  |  2 +-
 arch/mips/cavium-octeon/executive/cvmx-spi.c     |  4 +---
 arch/mips/kvm/tlb.c                              |  2 +-
 arch/parisc/kernel/drivers.c                     |  2 +-
 arch/powerpc/kernel/eeh_pe.c                     |  4 ++--
 arch/powerpc/kernel/uprobes.c                    |  2 +-
 crypto/asymmetric_keys/verify_pefile.c           |  2 +-
 drivers/ata/libata-transport.c                   |  4 ++--
 drivers/base/power/wakeup.c                      |  2 +-
 drivers/bus/fsl-mc/mc-io.c                       |  2 +-
 drivers/crypto/bcm/spu.c                         |  4 ++--
 drivers/crypto/qat/qat_common/adf_dev_mgr.c      |  2 +-
 drivers/gpu/drm/omapdrm/omap_gem.c               |  2 +-
 drivers/gpu/drm/radeon/r100.c                    |  2 +-
 drivers/gpu/drm/radeon/radeon_kms.c              |  1 -
 drivers/hid/hid-core.c                           |  4 ++--
 drivers/iio/dummy/iio_simple_dummy_buffer.c      |  2 +-
 drivers/infiniband/core/roce_gid_mgmt.c          |  2 +-
 drivers/infiniband/hw/i40iw/i40iw_hmc.c          |  4 ++--
 drivers/infiniband/hw/qib/qib_driver.c           |  2 +-
 drivers/infiniband/hw/qib/qib_iba7220.c          |  2 +-
 drivers/infiniband/sw/rdmavt/srq.c               |  2 +-
 drivers/leds/trigger/ledtrig-cpu.c               |  2 +-
 drivers/mfd/atmel-smc.c                          |  6 +++---
 drivers/misc/enclosure.c                         |  4 ++--
 drivers/net/bonding/bond_3ad.c                   |  2 +-
 drivers/net/bonding/bond_main.c                  |  2 +-
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c  |  4 ++--
 drivers/net/ethernet/freescale/dpaa2/dpni.c      |  4 ++--
 drivers/net/ethernet/freescale/fman/fman.c       |  4 ++--
 drivers/net/net_failover.c                       |  2 +-
 drivers/net/wireless/marvell/libertas/firmware.c |  4 ++--
 drivers/net/wireless/mediatek/mt7601u/phy.c      |  2 +-
 drivers/net/wireless/ti/wlcore/cmd.c             |  2 +-
 drivers/of/address.c                             |  2 +-
 drivers/pci/hotplug/pci_hotplug_core.c           |  2 +-
 drivers/pinctrl/core.c                           |  6 +++---
 drivers/power/supply/power_supply_core.c         |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                   | 16 ++++++++--------
 drivers/scsi/isci/port.c                         | 16 ++++++++--------
 drivers/scsi/libfc/fc_fcp.c                      |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c              |  2 +-
 drivers/soc/mediatek/mtk-infracfg.c              |  4 ++--
 drivers/soundwire/stream.c                       |  2 +-
 drivers/thunderbolt/ctl.c                        |  2 ++
 drivers/tty/tty_buffer.c                         |  4 ++--
 drivers/tty/tty_ldisc.c                          |  2 +-
 drivers/usb/cdns3/gadget.c                       |  4 ++--
 fs/ecryptfs/crypto.c                             |  2 +-
 fs/gfs2/log.c                                    |  2 +-
 fs/nilfs2/btree.c                                |  2 +-
 fs/nilfs2/cpfile.c                               |  4 ++--
 fs/nilfs2/sufile.c                               |  2 +-
 kernel/bpf/cgroup.c                              |  2 +-
 kernel/stacktrace.c                              |  2 +-
 lib/lru_cache.c                                  |  2 +-
 mm/sparse-vmemmap.c                              |  2 +-
 net/netfilter/nf_tables_api.c                    |  8 ++++----
 net/nfc/nci/core.c                               |  4 ++--
 net/tipc/msg.c                                   |  2 +-
 sound/ac97/bus.c                                 |  4 ++--
 sound/soc/uniphier/aio-core.c                    |  3 +--
 63 files changed, 100 insertions(+), 102 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-secure.c b/arch/arm/mach-omap2/omap-secure.c
index f70d561f37f7..eebc74384d5d 100644
--- a/arch/arm/mach-omap2/omap-secure.c
+++ b/arch/arm/mach-omap2/omap-secure.c
@@ -179,7 +179,7 @@ u32 rx51_secure_dispatcher(u32 idx, u32 process, u32 flag, u32 nargs,
 /**
  * rx51_secure_update_aux_cr: Routine to modify the contents of Auxiliary Control Register
  *  @set_bits: bits to set in ACR
- *  @clr_bits: bits to clear in ACR
+ *  @clear_bits: bits to clear in ACR
  *
  * Return the non-zero error value on failure.
 */
diff --git a/arch/arm/mach-prima2/rtciobrg.c b/arch/arm/mach-prima2/rtciobrg.c
index 97c0e333e3b9..cf345d3a08cd 100644
--- a/arch/arm/mach-prima2/rtciobrg.c
+++ b/arch/arm/mach-prima2/rtciobrg.c
@@ -127,7 +127,7 @@ static struct regmap_bus regmap_iobg = {
 /**
  * devm_regmap_init_iobg(): Initialise managed register map
  *
- * @iobg: Device that will be interacted with
+ * @dev: Device that will be interacted with
  * @config: Configuration for register map
  *
  * The return value will be an ERR_PTR() on error or a valid pointer
diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
index f51957a3e915..f798b451441d 100644
--- a/arch/mips/cavium-octeon/executive/cvmx-spi.c
+++ b/arch/mips/cavium-octeon/executive/cvmx-spi.c
@@ -69,9 +69,7 @@ static cvmx_spi_callbacks_t cvmx_spi_callbacks = {
 /**
  * Get current SPI4 initialization callbacks
  *
- * @callbacks:	Pointer to the callbacks structure.to fill
- *
- * Returns Pointer to cvmx_spi_callbacks_t structure.
+ * @callbacks:	Pointer to the callbacks structure to fill.
  */
 void cvmx_spi_get_callbacks(cvmx_spi_callbacks_t *callbacks)
 {
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 1c1fbce3f566..639e01c9bca4 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -290,7 +290,7 @@ EXPORT_SYMBOL_GPL(kvm_vz_host_tlb_inv);
 /**
  * kvm_vz_guest_tlb_lookup() - Lookup a guest VZ TLB mapping.
  * @vcpu:	KVM VCPU pointer.
- * @gpa:	Guest virtual address in a TLB mapped guest segment.
+ * @gva:	Guest virtual address in a TLB mapped guest segment.
  * @gpa:	Ponter to output guest physical address it maps to.
  *
  * Converts a guest virtual address in a guest TLB mapped segment to a guest
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index a5f3e50fe976..9464e575af43 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -280,7 +280,7 @@ int __init machine_has_merced_bus(void)
 
 /**
  * find_pa_parent_type - Find a parent of a specific type
- * @dev: The device to start searching from
+ * @padev: The device to start searching from
  * @type: The device type to search for.
  *
  * Walks up the device tree looking for a device of the specified type.
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index 177852e39a25..569e3772429c 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(eeh_pe_state_mark);
 
 /**
  * eeh_pe_mark_isolated
- * @pe: EEH PE
+ * @root: EEH PE
  *
  * Record that a PE has been isolated by marking the PE and it's children as
  * EEH_PE_ISOLATED (and EEH_PE_CFG_BLOCKED, if required) and their PCI devices
@@ -638,7 +638,7 @@ void eeh_pe_dev_mode_mark(struct eeh_pe *pe, int mode)
 
 /**
  * eeh_pe_state_clear - Clear state for the PE
- * @data: EEH PE
+ * @root: EEH PE
  * @state: state
  * @include_passed: include passed-through devices?
  *
diff --git a/arch/powerpc/kernel/uprobes.c b/arch/powerpc/kernel/uprobes.c
index d200e7df7167..ec8eaa334391 100644
--- a/arch/powerpc/kernel/uprobes.c
+++ b/arch/powerpc/kernel/uprobes.c
@@ -30,8 +30,8 @@ bool is_trap_insn(uprobe_opcode_t *insn)
 
 /**
  * arch_uprobe_analyze_insn
+ * @auprobe: the probepoint information.
  * @mm: the probed address space.
- * @arch_uprobe: the probepoint information.
  * @addr: vaddr to probe.
  * Return 0 on success or a -ve number on error.
  */
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index cc9dbcecaaca..5c89ee9dedf5 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -387,7 +387,7 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
  * verify_pefile_signature - Verify the signature on a PE binary image
  * @pebuf: Buffer containing the PE binary image
  * @pelen: Length of the binary image
- * @trust_keys: Signing certificate(s) to use as starting points
+ * @trusted_keys: Signing certificate(s) to use as starting points
  * @usage: The use to which the key is being put.
  *
  * Validate that the certificate chain inside the PKCS#7 message inside the PE
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 6a40e3c6cf49..3c7c97d2d44a 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -250,7 +250,7 @@ static int ata_tport_match(struct attribute_container *cont,
 
 /**
  * ata_tport_delete  --  remove ATA PORT
- * @port:	ATA PORT to remove
+ * @ap:	ATA PORT to remove
  *
  * Removes the specified ATA PORT.  Remove the associated link as well.
  */
@@ -376,7 +376,7 @@ static int ata_tlink_match(struct attribute_container *cont,
 
 /**
  * ata_tlink_delete  --  remove ATA LINK
- * @port:	ATA LINK to remove
+ * @link:	ATA LINK to remove
  *
  * Removes the specified ATA LINK.  remove associated ATA device(s) as well.
  */
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 92073ac68473..87247951a839 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1021,7 +1021,7 @@ bool pm_save_wakeup_count(unsigned int count)
 #ifdef CONFIG_PM_AUTOSLEEP
 /**
  * pm_wakep_autosleep_enabled - Modify autosleep_enabled for all wakeup sources.
- * @enabled: Whether to set or to clear the autosleep_enabled flags.
+ * @set: Whether to set or to clear the autosleep_enabled flags.
  */
 void pm_wakep_autosleep_enabled(bool set)
 {
diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
index 6ae48ad80409..f88cb7e911bd 100644
--- a/drivers/bus/fsl-mc/mc-io.c
+++ b/drivers/bus/fsl-mc/mc-io.c
@@ -55,7 +55,7 @@ static void fsl_mc_io_unset_dpmcp(struct fsl_mc_io *mc_io)
  * @dev: device to be associated with the MC I/O object
  * @mc_portal_phys_addr: physical address of the MC portal to use
  * @mc_portal_size: size in bytes of the MC portal
- * @dpmcp-dev: Pointer to the DPMCP object associated with this MC I/O
+ * @dpmcp_dev: Pointer to the DPMCP object associated with this MC I/O
  * object or NULL if none.
  * @flags: flags for the new MC I/O object
  * @new_mc_io: Area to return pointer to newly created MC I/O object
diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
index e7562e9bf396..0517400d0f05 100644
--- a/drivers/crypto/bcm/spu.c
+++ b/drivers/crypto/bcm/spu.c
@@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
  * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
  * in a SPU request after the AAD and before the payload.
  * @cipher_mode:  cipher mode
- * @iv_ctr_len:   initialization vector length in bytes
+ * @iv_len:       initialization vector length in bytes
  *
  * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
  * to include the IV as a separate field in the SPU request msg.
@@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
  * setkey() time in spu_cipher_req_init().
  * @spu_hdr:         Start of the request message header (MH field)
  * @spu_req_hdr_len: Length in bytes of the SPU request header
- * @isInbound:       0 encrypt, 1 decrypt
+ * @is_inbound:      0 encrypt, 1 decrypt
  * @cipher_parms:    Parameters describing cipher operation to be performed
  * @update_key:      If true, rewrite the cipher key in SCTX
  * @data_size:       Length of the data in the BD field
diff --git a/drivers/crypto/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
index 2d06409bd3c4..19f54da9c622 100644
--- a/drivers/crypto/qat/qat_common/adf_dev_mgr.c
+++ b/drivers/crypto/qat/qat_common/adf_dev_mgr.c
@@ -329,7 +329,7 @@ struct adf_accel_dev *adf_devmgr_get_first(void)
 
 /**
  * adf_devmgr_pci_to_accel_dev() - Get accel_dev associated with the pci_dev.
- * @accel_dev:  Pointer to pci device.
+ * @pci_dev:  Pointer to pci device.
  *
  * Function returns acceleration device associated with the given pci device.
  * To be used by QAT device specific drivers.
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index d08ae95ecc0a..e39a2d6721fb 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -580,7 +580,7 @@ int omap_gem_mmap_obj(struct drm_gem_object *obj,
 
 /**
  * omap_gem_dumb_create	-	create a dumb buffer
- * @drm_file: our client file
+ * @file: our client file
  * @dev: our device
  * @args: the requested arguments copied from userspace
  *
diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r100.c
index 24c8db673931..a72f4f549c32 100644
--- a/drivers/gpu/drm/radeon/r100.c
+++ b/drivers/gpu/drm/radeon/r100.c
@@ -1409,7 +1409,7 @@ int r100_cs_parse_packet0(struct radeon_cs_parser *p,
 
 /**
  * r100_cs_packet_next_vline() - parse userspace VLINE packet
- * @parser:		parser structure holding parsing context.
+ * @p:		parser structure holding parsing context.
  *
  * Userspace sends a special sequence for VLINE waits.
  * PACKET0 - VLINE_START_END + value
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index c5d1dc9618a4..e59e46fdb6e2 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -56,7 +56,6 @@ static inline bool radeon_has_atpx(void) { return false; }
  * It calls radeon_modeset_fini() to tear down the
  * displays, and radeon_device_fini() to tear down
  * the rest of the device (CP, writeback, etc.).
- * Returns 0 on success.
  */
 void radeon_driver_unload_kms(struct drm_device *dev)
 {
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 359616e3efbb..5b748505c923 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -920,7 +920,7 @@ static int hid_scan_report(struct hid_device *hid)
 /**
  * hid_parse_report - parse device report
  *
- * @device: hid device
+ * @hid: hid device
  * @start: report start
  * @size: report size
  *
@@ -945,7 +945,7 @@ static const char * const hid_report_names[] = {
 /**
  * hid_validate_values - validate existing device report's value indexes
  *
- * @device: hid device
+ * @hid: hid device
  * @type: which report type to examine
  * @id: which report ID to examine (0 for first)
  * @field_index: which report field to examine
diff --git a/drivers/iio/dummy/iio_simple_dummy_buffer.c b/drivers/iio/dummy/iio_simple_dummy_buffer.c
index 17606eca42b4..daf66ec6ebac 100644
--- a/drivers/iio/dummy/iio_simple_dummy_buffer.c
+++ b/drivers/iio/dummy/iio_simple_dummy_buffer.c
@@ -179,7 +179,7 @@ int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
 
 /**
  * iio_simple_dummy_unconfigure_buffer() - release buffer resources
- * @indo_dev: device instance state
+ * @indio_dev: device instance state
  */
 void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
 {
diff --git a/drivers/infiniband/core/roce_gid_mgmt.c b/drivers/infiniband/core/roce_gid_mgmt.c
index 2860def84f4d..5bdf3850fe28 100644
--- a/drivers/infiniband/core/roce_gid_mgmt.c
+++ b/drivers/infiniband/core/roce_gid_mgmt.c
@@ -505,7 +505,7 @@ static void enum_all_gids_of_dev_cb(struct ib_device *ib_dev,
  * rdma_roce_rescan_device - Rescan all of the network devices in the system
  * and add their gids, as needed, to the relevant RoCE devices.
  *
- * @device:         the rdma device
+ * @ib_dev:         the rdma device
  */
 void rdma_roce_rescan_device(struct ib_device *ib_dev)
 {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_hmc.c b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
index 5484cbf55f0f..02dc1b0e4b9f 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_hmc.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_hmc.c
@@ -782,9 +782,9 @@ enum i40iw_status_code i40iw_prep_remove_pd_page(struct i40iw_hmc_info *hmc_info
 
 /**
  * i40iw_pf_init_vfhmc -
- * @vf_cnt_array: array of cnt values of iwarp hmc objects
- * @vf_hmc_fn_id: hmc function id ofr vf driver
  * @dev: pointer to i40iw_dev struct
+ * @vf_hmc_fn_id: hmc function id ofr vf driver
+ * @vf_cnt_array: array of cnt values of iwarp hmc objects
  *
  * Called by pf driver to initialize hmc_info for vf driver instance.
  */
diff --git a/drivers/infiniband/hw/qib/qib_driver.c b/drivers/infiniband/hw/qib/qib_driver.c
index 92eeea5679e2..84fc4dcc5399 100644
--- a/drivers/infiniband/hw/qib/qib_driver.c
+++ b/drivers/infiniband/hw/qib/qib_driver.c
@@ -151,7 +151,7 @@ int qib_count_units(int *npresentp, int *nupp)
 
 /**
  * qib_wait_linkstate - wait for an IB link state change to occur
- * @dd: the qlogic_ib device
+ * @ppd: the qlogic_ib device
  * @state: the state to wait for
  * @msecs: the number of milliseconds to wait
  *
diff --git a/drivers/infiniband/hw/qib/qib_iba7220.c b/drivers/infiniband/hw/qib/qib_iba7220.c
index ea3ddb05cbad..c3443a4fede5 100644
--- a/drivers/infiniband/hw/qib/qib_iba7220.c
+++ b/drivers/infiniband/hw/qib/qib_iba7220.c
@@ -4468,7 +4468,7 @@ static int qib_7220_eeprom_wen(struct qib_devdata *dd, int wen)
 
 /**
  * qib_init_iba7220_funcs - set up the chip-specific function pointers
- * @dev: the pci_dev for qlogic_ib device
+ * @pdev: the pci_dev for qlogic_ib device
  * @ent: pci_device_id struct for this dev
  *
  * This is global, and is called directly at init to set up the
diff --git a/drivers/infiniband/sw/rdmavt/srq.c b/drivers/infiniband/sw/rdmavt/srq.c
index f547c115af03..7d1e283101c1 100644
--- a/drivers/infiniband/sw/rdmavt/srq.c
+++ b/drivers/infiniband/sw/rdmavt/srq.c
@@ -67,7 +67,7 @@ void rvt_driver_srq_init(struct rvt_dev_info *rdi)
 
 /**
  * rvt_create_srq - create a shared receive queue
- * @ibpd: the protection domain of the SRQ to create
+ * @ibsrq: the protection domain of the SRQ to create
  * @srq_init_attr: the attributes of the SRQ
  * @udata: data from libibverbs when creating a user SRQ
  *
diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 869976d1b734..9d272bc270b6 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -39,7 +39,7 @@ static atomic_t num_active_cpus = ATOMIC_INIT(0);
 
 /**
  * ledtrig_cpu - emit a CPU event as a trigger
- * @evt: CPU event to be emitted
+ * @ledevt: CPU event to be emitted
  *
  * Emit a CPU event on a CPU core, which will trigger a
  * bound LED to turn on or turn off.
diff --git a/drivers/mfd/atmel-smc.c b/drivers/mfd/atmel-smc.c
index 1fa2ec950e7d..f42d3cc72693 100644
--- a/drivers/mfd/atmel-smc.c
+++ b/drivers/mfd/atmel-smc.c
@@ -255,9 +255,9 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_apply);
 /**
  * atmel_hsmc_cs_conf_apply - apply an SMC CS conf
  * @regmap: the HSMC regmap
- * @cs: the CS id
  * @layout: the layout of registers
- * @conf the SMC CS conf to apply
+ * @cs: the CS id
+ * @conf: the SMC CS conf to apply
  *
  * Applies an SMC CS configuration.
  * Only valid on post-sama5 SoCs.
@@ -296,8 +296,8 @@ EXPORT_SYMBOL_GPL(atmel_smc_cs_conf_get);
 /**
  * atmel_hsmc_cs_conf_get - retrieve the current SMC CS conf
  * @regmap: the HSMC regmap
- * @cs: the CS id
  * @layout: the layout of registers
+ * @cs: the CS id
  * @conf: the SMC CS conf object to store the current conf
  *
  * Retrieve the SMC CS configuration.
diff --git a/drivers/misc/enclosure.c b/drivers/misc/enclosure.c
index 3c2d405bc79b..f39829a7f3eb 100644
--- a/drivers/misc/enclosure.c
+++ b/drivers/misc/enclosure.c
@@ -266,7 +266,7 @@ static const struct attribute_group *enclosure_component_groups[];
 /**
  * enclosure_component_alloc - prepare a new enclosure component
  * @edev:	the enclosure to add the component
- * @num:	the device number
+ * @number:	the device number
  * @type:	the type of component being added
  * @name:	an optional name to appear in sysfs (leave NULL if none)
  *
@@ -347,7 +347,7 @@ EXPORT_SYMBOL_GPL(enclosure_component_register);
 /**
  * enclosure_add_device - add a device as being part of an enclosure
  * @edev:	the enclosure device being added to.
- * @num:	the number of the component
+ * @component:	the number of the component
  * @dev:	the device being added
  *
  * Declares a real device to reside in slot (or identifier) @num of an
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 31e43a2197a3..bf4eb83cd77f 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -2500,7 +2500,7 @@ void bond_3ad_adapter_speed_duplex_changed(struct slave *slave)
 /**
  * bond_3ad_handle_link_change - handle a slave's link status change indication
  * @slave: slave struct to work on
- * @status: whether the link is now up or down
+ * @link: whether the link is now up or down
  *
  * Handle reselection of aggregator (if needed) for this port.
  */
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 004919aea5fb..893d4c6cef93 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -855,7 +855,7 @@ static bool bond_should_notify_peers(struct bonding *bond)
 /**
  * change_active_interface - change the active slave into the specified one
  * @bond: our bonding struct
- * @new: the new slave to make the active one
+ * @new_active: the new slave to make the active one
  *
  * Set the new slave to the bond's settings and unset them on the old
  * curr_active_slave.
diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index ee9e9290f112..3f07ec78530b 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4229,8 +4229,8 @@ void bnx2x_get_c2s_mapping(struct bnx2x *bp, u8 *c2s_map, u8 *c2s_default)
 /**
  * bnx2x_setup_tc - routine to configure net_device for multi tc
  *
- * @netdev: net device to configure
- * @tc: number of traffic classes to enable
+ * @dev: net device to configure
+ * @num_tc: number of traffic classes to enable
  *
  * callback connected to the ndo_setup_tc function pointer
  */
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpni.c b/drivers/net/ethernet/freescale/dpaa2/dpni.c
index 6b479ba66465..69c8940d1069 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpni.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpni.c
@@ -1558,10 +1558,10 @@ int dpni_get_statistics(struct fsl_mc_io *mc_io,
  * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
  * @token:	Token of DPNI object
  * @cg_point:	Congestion point
- * @q_type:	Queue type on which the taildrop is configured.
+ * @qtype:	Queue type on which the taildrop is configured.
  *		Only Rx queues are supported for now
  * @tc:		Traffic class to apply this taildrop to
- * @q_index:	Index of the queue if the DPNI supports multiple queues for
+ * @index:	Index of the queue if the DPNI supports multiple queues for
  *		traffic distribution. Ignored if CONGESTION_POINT is not 0.
  * @taildrop:	Taildrop structure
  *
diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index f151d6e111dd..acee93d0d860 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2092,7 +2092,7 @@ EXPORT_SYMBOL(fman_register_intr);
 /**
  * fman_unregister_intr
  * @fman:	A Pointer to FMan device
- * @mod:	Calling module
+ * @module:	Calling module
  * @mod_id:	Module id (if more than 1 exists, '0' if not)
  * @intr_type:	Interrupt type (error/normal) selection.
  *
@@ -2509,7 +2509,7 @@ EXPORT_SYMBOL(fman_get_rx_extra_headroom);
 
 /**
  * fman_bind
- * @dev:	FMan OF device pointer
+ * @fm_dev:	FMan OF device pointer
  *
  * Bind to a specific FMan device.
  *
diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index fb182bec8f06..2a4892402ed8 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -697,7 +697,7 @@ static struct failover_ops net_failover_ops = {
 /**
  * net_failover_create - Create and register a failover instance
  *
- * @dev: standby netdev
+ * @standby_dev: standby netdev
  *
  * Creates a failover netdev and registers a failover instance for a standby
  * netdev. Used by paravirtual drivers that use 3-netdev model.
diff --git a/drivers/net/wireless/marvell/libertas/firmware.c b/drivers/net/wireless/marvell/libertas/firmware.c
index 69029c59a272..d5f1cb49b946 100644
--- a/drivers/net/wireless/marvell/libertas/firmware.c
+++ b/drivers/net/wireless/marvell/libertas/firmware.c
@@ -121,12 +121,12 @@ void lbs_wait_for_firmware_load(struct lbs_private *priv)
  *  either a helper firmware and a main firmware (2-stage), or just the helper.
  *
  *  @priv:      Pointer to lbs_private instance
- *  @dev:     	A pointer to &device structure
+ *  @device:    A pointer to &device structure
  *  @card_model: Bus-specific card model ID used to filter firmware table
  *		elements
  *  @fw_table:	Table of firmware file names and device model numbers
  *		terminated by an entry with a NULL helper name
- *	@callback: User callback to invoke when firmware load succeeds or fails.
+ *  @callback: User callback to invoke when firmware load succeeds or fails.
  */
 int lbs_get_firmware_async(struct lbs_private *priv, struct device *device,
 			    u32 card_model, const struct lbs_fw_table *fw_table,
diff --git a/drivers/net/wireless/mediatek/mt7601u/phy.c b/drivers/net/wireless/mediatek/mt7601u/phy.c
index d863ab4a66c9..3c4462487ab5 100644
--- a/drivers/net/wireless/mediatek/mt7601u/phy.c
+++ b/drivers/net/wireless/mediatek/mt7601u/phy.c
@@ -1210,7 +1210,7 @@ void mt7601u_set_rx_path(struct mt7601u_dev *dev, u8 path)
 /**
  * mt7601u_set_tx_dac - set which tx DAC to use
  * @dev:	pointer to adapter structure
- * @path:	DAC index, values are 0-based
+ * @dac:	DAC index, values are 0-based
  */
 void mt7601u_set_tx_dac(struct mt7601u_dev *dev, u8 dac)
 {
diff --git a/drivers/net/wireless/ti/wlcore/cmd.c b/drivers/net/wireless/ti/wlcore/cmd.c
index 6ef8fc9ae627..561f49336178 100644
--- a/drivers/net/wireless/ti/wlcore/cmd.c
+++ b/drivers/net/wireless/ti/wlcore/cmd.c
@@ -825,7 +825,7 @@ int wl12xx_cmd_role_start_ibss(struct wl1271 *wl, struct wl12xx_vif *wlvif)
  *
  * @wl: wl struct
  * @buf: buffer containing the command, with all headers, must work with dma
- * @len: length of the buffer
+ * @buf_len: length of the buffer
  * @answer: is answer needed
  */
 int wl1271_cmd_test(struct wl1271 *wl, void *buf, size_t buf_len, u8 answer)
diff --git a/drivers/of/address.c b/drivers/of/address.c
index 8eea3f6e29a4..381dc9be7b22 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -864,7 +864,7 @@ EXPORT_SYMBOL_GPL(of_address_to_resource);
 
 /**
  * of_iomap - Maps the memory mapped IO for a given device_node
- * @device:	the device whose io range will be mapped
+ * @np:		the device whose io range will be mapped
  * @index:	index of the io range
  *
  * Returns a pointer to the mapped memory
diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 5ac31f683b85..c19fa78b56bb 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -388,8 +388,8 @@ static struct hotplug_slot *get_slot_from_name(const char *name)
 
 /**
  * __pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
- * @bus: bus this slot is on
  * @slot: pointer to the &struct hotplug_slot to register
+ * @bus: bus this slot is on
  * @devnr: device number
  * @name: name registered with kobject core
  * @owner: caller module owner
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 821242bb4b16..44ee5d70623e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -161,7 +161,7 @@ int pin_get_from_name(struct pinctrl_dev *pctldev, const char *name)
 /**
  * pin_get_name_from_id() - look up a pin name from a pin id
  * @pctldev: the pin control device to lookup the pin on
- * @name: the name of the pin to look up
+ * @pin: the name of the pin to look up
  */
 const char *pin_get_name(struct pinctrl_dev *pctldev, const unsigned pin)
 {
@@ -577,7 +577,7 @@ EXPORT_SYMBOL_GPL(pinctrl_generic_get_group_pins);
 /**
  * pinctrl_generic_get_group() - returns a pin group based on the number
  * @pctldev: pin controller device
- * @gselector: group number
+ * @selector: group number
  */
 struct group_desc *pinctrl_generic_get_group(struct pinctrl_dev *pctldev,
 					     unsigned int selector)
@@ -1451,7 +1451,7 @@ EXPORT_SYMBOL_GPL(pinctrl_register_mappings);
 
 /**
  * pinctrl_unregister_mappings() - unregister a set of pin controller mappings
- * @maps: the pincontrol mappings table passed to pinctrl_register_mappings()
+ * @map: the pincontrol mappings table passed to pinctrl_register_mappings()
  *	when registering the mappings.
  */
 void pinctrl_unregister_mappings(const struct pinctrl_map *map)
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 02b37fe6061c..595e030034d4 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
  * percent
  * @table: Pointer to battery resistance temperature table
  * @table_len: The table length
- * @ocv: Current temperature
+ * @temp: Current temperature
  *
  * This helper function is used to look up battery internal resistance percent
  * according to current temperature value from the resistance temperature table,
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index e53ebc5eff85..6b558bdc9dec 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -181,7 +181,7 @@ int bnx2i_arm_cq_event_coalescing(struct bnx2i_endpoint *ep, u8 action)
 
 /**
  * bnx2i_get_rq_buf - copy RQ buffer contents to driver buffer
- * @conn:		iscsi connection on which RQ event occurred
+ * @bnx2i_conn:		iscsi connection on which RQ event occurred
  * @ptr:		driver buffer to which RQ buffer contents is to
  *			be copied
  * @len:		length of valid data inside RQ buf
@@ -223,7 +223,7 @@ static void bnx2i_ring_577xx_doorbell(struct bnx2i_conn *conn)
 
 /**
  * bnx2i_put_rq_buf - Replenish RQ buffer, if required ring on chip doorbell
- * @conn:	iscsi connection on which event to post
+ * @bnx2i_conn:	iscsi connection on which event to post
  * @count:	number of RQ buffer being posted to chip
  *
  * No need to ring hardware doorbell for 57710 family of devices
@@ -320,7 +320,7 @@ static void bnx2i_ring_dbell_update_sq_params(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_login - post iSCSI login request MP WQE to hardware
- * @conn:	iscsi connection
+ * @bnx2i_conn:	iscsi connection
  * @cmd:	driver command structure which is requesting
  *		a WQE to sent to chip for further processing
  *
@@ -373,7 +373,7 @@ int bnx2i_send_iscsi_login(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_tmf - post iSCSI task management request MP WQE to hardware
- * @conn:	iscsi connection
+ * @bnx2i_conn:	iscsi connection
  * @mtask:	driver command structure which is requesting
  *		a WQE to sent to chip for further processing
  *
@@ -447,7 +447,7 @@ int bnx2i_send_iscsi_tmf(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_text - post iSCSI text WQE to hardware
- * @conn:	iscsi connection
+ * @bnx2i_conn:	iscsi connection
  * @mtask:	driver command structure which is requesting
  *		a WQE to sent to chip for further processing
  *
@@ -495,7 +495,7 @@ int bnx2i_send_iscsi_text(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_scsicmd - post iSCSI scsicmd request WQE to hardware
- * @conn:	iscsi connection
+ * @bnx2i_conn:	iscsi connection
  * @cmd:	driver command structure which is requesting
  *		a WQE to sent to chip for further processing
  *
@@ -517,7 +517,7 @@ int bnx2i_send_iscsi_scsicmd(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_nopout - post iSCSI NOPOUT request WQE to hardware
- * @conn:		iscsi connection
+ * @bnx2i_conn:		iscsi connection
  * @cmd:		driver command structure which is requesting
  *			a WQE to sent to chip for further processing
  * @datap:		payload buffer pointer
@@ -579,7 +579,7 @@ int bnx2i_send_iscsi_nopout(struct bnx2i_conn *bnx2i_conn,
 
 /**
  * bnx2i_send_iscsi_logout - post iSCSI logout request WQE to hardware
- * @conn:	iscsi connection
+ * @bnx2i_conn:	iscsi connection
  * @cmd:	driver command structure which is requesting
  *		a WQE to sent to chip for further processing
  *
diff --git a/drivers/scsi/isci/port.c b/drivers/scsi/isci/port.c
index 1df45f028ea7..c98c8dc6283c 100644
--- a/drivers/scsi/isci/port.c
+++ b/drivers/scsi/isci/port.c
@@ -115,9 +115,9 @@ static u32 sci_port_get_phys(struct isci_port *iport)
 /**
  * sci_port_get_properties() - This method simply returns the properties
  *    regarding the port, such as: physical index, protocols, sas address, etc.
- * @port: this parameter specifies the port for which to retrieve the physical
+ * @iport: this parameter specifies the port for which to retrieve the physical
  *    index.
- * @properties: This parameter specifies the properties structure into which to
+ * @props: This parameter specifies the properties structure into which to
  *    copy the requested information.
  *
  * Indicate if the user specified a valid port. SCI_SUCCESS This value is
@@ -742,8 +742,8 @@ static bool sci_port_is_wide(struct isci_port *iport)
  *    port wants the PHY to continue on to the link up state then the port
  *    layer must return true.  If the port object returns false the phy object
  *    must halt its attempt to go link up.
- * @sci_port: The port associated with the phy object.
- * @sci_phy: The phy object that is trying to go link up.
+ * @iport: The port associated with the phy object.
+ * @iphy: The phy object that is trying to go link up.
  *
  * true if the phy object can continue to the link up condition. true Is
  * returned if this phy can continue to the ready state. false Is returned if
@@ -1186,8 +1186,8 @@ static enum sci_status sci_port_hard_reset(struct isci_port *iport, u32 timeout)
 
 /**
  * sci_port_add_phy() -
- * @sci_port: This parameter specifies the port in which the phy will be added.
- * @sci_phy: This parameter is the phy which is to be added to the port.
+ * @iport: This parameter specifies the port in which the phy will be added.
+ * @iphy: This parameter is the phy which is to be added to the port.
  *
  * This method will add a PHY to the selected port. This method returns an
  * enum sci_status. SCI_SUCCESS the phy has been added to the port. Any other
@@ -1257,8 +1257,8 @@ enum sci_status sci_port_add_phy(struct isci_port *iport,
 
 /**
  * sci_port_remove_phy() -
- * @sci_port: This parameter specifies the port in which the phy will be added.
- * @sci_phy: This parameter is the phy which is to be added to the port.
+ * @iport: This parameter specifies the port in which the phy will be added.
+ * @iphy: This parameter is the phy which is to be added to the port.
  *
  * This method will remove the PHY from the selected PORT. This method returns
  * an enum sci_status. SCI_SUCCESS the phy has been removed from the port. Any
diff --git a/drivers/scsi/libfc/fc_fcp.c b/drivers/scsi/libfc/fc_fcp.c
index bf2cc9656e19..0f6ba7878e8d 100644
--- a/drivers/scsi/libfc/fc_fcp.c
+++ b/drivers/scsi/libfc/fc_fcp.c
@@ -1851,7 +1851,7 @@ static inline int fc_fcp_lport_queue_ready(struct fc_lport *lport)
 /**
  * fc_queuecommand() - The queuecommand function of the SCSI template
  * @shost: The Scsi_Host that the command was issued to
- * @cmd:   The scsi_cmnd to be executed
+ * @sc_cmd: The scsi_cmnd to be executed
  *
  * This is the i/o strategy routine, called by the SCSI layer.
  */
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 96b78fdc6b8a..ca90ef4310fc 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5833,7 +5833,7 @@ _base_send_ioc_reset(struct MPT3SAS_ADAPTER *ioc, u8 reset_type, int timeout)
 /**
  * mpt3sas_wait_for_ioc - IOC's operational state is checked here.
  * @ioc: per adapter object
- * @wait_count: timeout in seconds
+ * @timeout: timeout in seconds
  *
  * Return: Waits up to timeout seconds for the IOC to
  * become operational. Returns 0 if IOC is present
diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
index 341c7ac250e3..4a123796aad3 100644
--- a/drivers/soc/mediatek/mtk-infracfg.c
+++ b/drivers/soc/mediatek/mtk-infracfg.c
@@ -19,7 +19,7 @@
 
 /**
  * mtk_infracfg_set_bus_protection - enable bus protection
- * @regmap: The infracfg regmap
+ * @infracfg: The infracfg regmap
  * @mask: The mask containing the protection bits to be enabled.
  * @reg_update: The boolean flag determines to set the protection bits
  *              by regmap_update_bits with enable register(PROTECTEN) or
@@ -50,7 +50,7 @@ int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
 
 /**
  * mtk_infracfg_clear_bus_protection - disable bus protection
- * @regmap: The infracfg regmap
+ * @infracfg: The infracfg regmap
  * @mask: The mask containing the protection bits to be disabled.
  * @reg_update: The boolean flag determines to clear the protection bits
  *              by regmap_update_bits with enable register(PROTECTEN) or
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index a9a72574b34a..3c3af428e360 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1326,9 +1326,9 @@ EXPORT_SYMBOL(sdw_stream_add_master);
  *
  * @slave: SDW Slave instance
  * @stream_config: Stream configuration for audio stream
- * @stream: SoundWire stream
  * @port_config: Port configuration for audio stream
  * @num_ports: Number of ports
+ * @stream: SoundWire stream
  *
  * It is expected that Slave is added before adding Master
  * to the Stream.
diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index f77ceae5c7d7..74cb9c713a36 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -669,6 +669,7 @@ void tb_ctl_free(struct tb_ctl *ctl)
 
 /**
  * tb_cfg_start() - start/resume the control channel
+ * @ctl: Control channel to use
  */
 void tb_ctl_start(struct tb_ctl *ctl)
 {
@@ -684,6 +685,7 @@ void tb_ctl_start(struct tb_ctl *ctl)
 
 /**
  * control() - pause the control channel
+ * @ctl: Control channel to use
  *
  * All invocations of ctl->callback will have finished after this method
  * returns.
diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index ec145a59f199..647655e68610 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -107,7 +107,7 @@ static void tty_buffer_reset(struct tty_buffer *p, size_t size)
 
 /**
  *	tty_buffer_free_all		-	free buffers used by a tty
- *	@tty: tty to free from
+ *	@port: tty to free from
  *
  *	Remove all the buffers pending on a tty whether queued with data
  *	or in the free ring. Must be called when the tty is no longer in use
@@ -559,7 +559,7 @@ EXPORT_SYMBOL(tty_flip_buffer_push);
 
 /**
  *	tty_buffer_init		-	prepare a tty buffer structure
- *	@tty: tty to initialise
+ *	@port: tty to initialise
  *
  *	Set up the initial state of the buffer management for a tty device.
  *	Must be called before the other tty buffer functions are used.
diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index ec1f6a48121e..3dd0add2040c 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -542,7 +542,7 @@ static void tty_ldisc_restore(struct tty_struct *tty, struct tty_ldisc *old)
 /**
  *	tty_set_ldisc		-	set line discipline
  *	@tty: the terminal to set
- *	@ldisc: the line discipline
+ *	@disc: the line discipline
  *
  *	Set the discipline of a tty line. Must be called from a process
  *	context. The ldisc change logic has to protect itself against any
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 5e24c2e57c0d..ec1bc6e05f38 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2568,7 +2568,7 @@ int cdns3_gadget_ep_dequeue(struct usb_ep *ep,
 /**
  * __cdns3_gadget_ep_set_halt Sets stall on selected endpoint
  * Should be called after acquiring spin_lock and selecting ep
- * @ep: endpoint object to set stall on.
+ * @priv_ep: endpoint object to set stall on.
  */
 void __cdns3_gadget_ep_set_halt(struct cdns3_endpoint *priv_ep)
 {
@@ -2589,7 +2589,7 @@ void __cdns3_gadget_ep_set_halt(struct cdns3_endpoint *priv_ep)
 /**
  * __cdns3_gadget_ep_clear_halt Clears stall on selected endpoint
  * Should be called after acquiring spin_lock and selecting ep
- * @ep: endpoint object to clear stall on
+ * @priv_ep: endpoint object to clear stall on
  */
 int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 {
diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 0681540c48d9..8ebab784913b 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -629,7 +629,7 @@ void ecryptfs_set_default_sizes(struct ecryptfs_crypt_stat *crypt_stat)
 
 /**
  * ecryptfs_compute_root_iv
- * @crypt_stats
+ * @crypt_stat
  *
  * On error, sets the root IV to all 0's.
  */
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 2b05415bbc13..49d28e0f648d 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1148,7 +1148,7 @@ static inline int gfs2_ail_flush_reqd(struct gfs2_sbd *sdp)
 
 /**
  * gfs2_logd - Update log tail as Active Items get flushed to in-place blocks
- * @sdp: Pointer to GFS2 superblock
+ * @data: Pointer to GFS2 superblock
  *
  * Also, periodically check to make sure that we're using the most recent
  * journal index.
diff --git a/fs/nilfs2/btree.c b/fs/nilfs2/btree.c
index 23e043eca237..7efa4b96a81f 100644
--- a/fs/nilfs2/btree.c
+++ b/fs/nilfs2/btree.c
@@ -1841,7 +1841,7 @@ nilfs_btree_commit_convert_and_insert(struct nilfs_bmap *btree,
 
 /**
  * nilfs_btree_convert_and_insert -
- * @bmap:
+ * @btree:
  * @key:
  * @ptr:
  * @keys:
diff --git a/fs/nilfs2/cpfile.c b/fs/nilfs2/cpfile.c
index 8d41311b5db4..5b37bf76c5f4 100644
--- a/fs/nilfs2/cpfile.c
+++ b/fs/nilfs2/cpfile.c
@@ -889,7 +889,7 @@ int nilfs_cpfile_is_snapshot(struct inode *cpfile, __u64 cno)
  * nilfs_cpfile_change_cpmode - change checkpoint mode
  * @cpfile: inode of checkpoint file
  * @cno: checkpoint number
- * @status: mode of checkpoint
+ * @mode: mode of checkpoint
  *
  * Description: nilfs_change_cpmode() changes the mode of the checkpoint
  * specified by @cno. The mode @mode is NILFS_CHECKPOINT or NILFS_SNAPSHOT.
@@ -930,7 +930,7 @@ int nilfs_cpfile_change_cpmode(struct inode *cpfile, __u64 cno, int mode)
 /**
  * nilfs_cpfile_get_stat - get checkpoint statistics
  * @cpfile: inode of checkpoint file
- * @stat: pointer to a structure of checkpoint statistics
+ * @cpstat: pointer to a structure of checkpoint statistics
  *
  * Description: nilfs_cpfile_get_stat() returns information about checkpoints.
  *
diff --git a/fs/nilfs2/sufile.c b/fs/nilfs2/sufile.c
index bf3f8f05c89b..a37cddc301a0 100644
--- a/fs/nilfs2/sufile.c
+++ b/fs/nilfs2/sufile.c
@@ -549,7 +549,7 @@ int nilfs_sufile_set_segment_usage(struct inode *sufile, __u64 segnum,
 /**
  * nilfs_sufile_get_stat - get segment usage statistics
  * @sufile: inode of segment usage file
- * @stat: pointer to a structure of segment usage statistics
+ * @sustat: pointer to a structure of segment usage statistics
  *
  * Description: nilfs_sufile_get_stat() returns information about segment
  * usage.
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 4d76f16524cc..31dd0d050c6d 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -405,8 +405,8 @@ static struct bpf_prog_list *find_attach_entry(struct list_head *progs,
  *                         propagate the change to descendants
  * @cgrp: The cgroup which descendants to traverse
  * @prog: A program to attach
- * @link: A link to attach
  * @replace_prog: Previously attached program to replace if BPF_F_REPLACE is set
+ * @link: A link to attach
  * @type: Type of attach operation
  * @flags: Option flags
  *
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 2af66e449aa6..a46228e60321 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -127,7 +127,7 @@ EXPORT_SYMBOL_GPL(stack_trace_save);
 
 /**
  * stack_trace_save_tsk - Save a task stack trace into a storage array
- * @task:	The task to examine
+ * @tsk:	The task to examine
  * @store:	Pointer to storage array
  * @size:	Size of the storage array
  * @skipnr:	Number of entries to skip at the start of the stack trace
diff --git a/lib/lru_cache.c b/lib/lru_cache.c
index c69ee53d8dde..de881be64374 100644
--- a/lib/lru_cache.c
+++ b/lib/lru_cache.c
@@ -628,8 +628,8 @@ void lc_set(struct lru_cache *lc, unsigned int enr, int index)
 
 /**
  * lc_dump - Dump a complete LRU cache to seq in textual form.
- * @lc: the lru cache to operate on
  * @seq: the &struct seq_file pointer to seq_printf into
+ * @lc: the lru cache to operate on
  * @utext: user supplied additional "heading" or other info
  * @detail: function pointer the user may provide to dump further details
  * of the object the lc_element is embedded in. May be NULL.
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 0db7738d76e9..2fba70f0e189 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -96,8 +96,8 @@ static unsigned long __meminit vmem_altmap_nr_free(struct vmem_altmap *altmap)
 
 /**
  * altmap_alloc_block_buf - allocate pages from the device page map
- * @altmap:	device page map
  * @size:	size (in bytes) of the allocation
+ * @altmap:	device page map
  *
  * Allocations are aligned to the size of the request.
  */
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 073aa1051d43..42f60663640a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2307,7 +2307,7 @@ static int nf_tables_delchain(struct net *net, struct sock *nlsk,
 
 /**
  *	nft_register_expr - register nf_tables expr type
- *	@ops: expr type
+ *	@type: expr type
  *
  *	Registers the expr type for use with nf_tables. Returns zero on
  *	success or a negative errno code otherwise.
@@ -2326,7 +2326,7 @@ EXPORT_SYMBOL_GPL(nft_register_expr);
 
 /**
  *	nft_unregister_expr - unregister nf_tables expr type
- *	@ops: expr type
+ *	@type: expr type
  *
  * 	Unregisters the expr typefor use with nf_tables.
  */
@@ -5498,7 +5498,7 @@ struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
 
 /**
  *	nft_register_obj- register nf_tables stateful object type
- *	@obj: object type
+ *	@obj_type: object type
  *
  *	Registers the object type for use with nf_tables. Returns zero on
  *	success or a negative errno code otherwise.
@@ -5517,7 +5517,7 @@ EXPORT_SYMBOL_GPL(nft_register_obj);
 
 /**
  *	nft_unregister_obj - unregister nf_tables object type
- *	@obj: object type
+ *	@obj_type: object type
  *
  * 	Unregisters the object type for use with nf_tables.
  */
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 7cd524884304..f7b7dc5fe84a 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1182,7 +1182,7 @@ EXPORT_SYMBOL(nci_free_device);
 /**
  * nci_register_device - register a nci device in the nfc subsystem
  *
- * @dev: The nci device to register
+ * @ndev: The nci device to register
  */
 int nci_register_device(struct nci_dev *ndev)
 {
@@ -1246,7 +1246,7 @@ EXPORT_SYMBOL(nci_register_device);
 /**
  * nci_unregister_device - unregister a nci device in the nfc subsystem
  *
- * @dev: The nci device to unregister
+ * @ndev: The nci device to unregister
  */
 void nci_unregister_device(struct nci_dev *ndev)
 {
diff --git a/net/tipc/msg.c b/net/tipc/msg.c
index 01b64869a173..1be29ba8ee41 100644
--- a/net/tipc/msg.c
+++ b/net/tipc/msg.c
@@ -204,8 +204,8 @@ int tipc_buf_append(struct sk_buff **headbuf, struct sk_buff **buf)
  * tipc_msg_append(): Append data to tail of an existing buffer queue
  * @hdr: header to be used
  * @m: the data to be appended
- * @mss: max allowable size of buffer
  * @dlen: size of data to be appended
+ * @mss: max allowable size of buffer
  * @txq: queue to appand to
  * Returns the number og 1k blocks appended or errno value
  */
diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7985dd8198b6..3aaf621bbc30 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -181,7 +181,7 @@ static int ac97_bus_reset(struct ac97_controller *ac97_ctrl)
 
 /**
  * snd_ac97_codec_driver_register - register an AC97 codec driver
- * @dev: AC97 driver codec to register
+ * @drv: AC97 driver codec to register
  *
  * Register an AC97 codec driver to the ac97 bus driver, aka. the AC97 digital
  * controller.
@@ -197,7 +197,7 @@ EXPORT_SYMBOL_GPL(snd_ac97_codec_driver_register);
 
 /**
  * snd_ac97_codec_driver_unregister - unregister an AC97 codec driver
- * @dev: AC97 codec driver to unregister
+ * @drv: AC97 codec driver to unregister
  *
  * Unregister a previously registered ac97 codec driver.
  */
diff --git a/sound/soc/uniphier/aio-core.c b/sound/soc/uniphier/aio-core.c
index 9bcba06ba52e..7a68f66653ed 100644
--- a/sound/soc/uniphier/aio-core.c
+++ b/sound/soc/uniphier/aio-core.c
@@ -94,7 +94,7 @@ void aio_iecout_set_enable(struct uniphier_aio_chip *chip, bool enable)
 /**
  * aio_chip_set_pll - set frequency to audio PLL
  * @chip  : the AIO chip pointer
- * @source: PLL
+ * @pll_id: PLL
  * @freq  : frequency in Hz, 0 is ignored
  *
  * Sets frequency of audio PLL. This function can be called anytime,
@@ -267,7 +267,6 @@ void aio_port_reset(struct uniphier_aio_sub *sub)
 /**
  * aio_port_set_ch - set channels of LPCM
  * @sub: the AIO substream pointer, PCM substream only
- * @ch : count of channels
  *
  * Set suitable slot selecting to input/output port block of AIO.
  *
-- 
2.17.1

