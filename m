Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF8BC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325C720716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580292888;
	bh=+tCBn6vL3onIDM3KFCcmwpaESfp2Yp2C0aLBmmbjGFg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=X7p/RhRHJsI80aL0CBfXDNnIU84bLpWezcM8HCPZZ8zlNGEbqZllv7JyDX2IKSpk3
	 S00rJ069REP9mR8Z6kjjpfJNe79lOvy1t6W0nnkfjV9iTR79APFmyU4rbZh1Gb8Mqe
	 nILd4oGpt/eIVZ0P+h2crFtHA1CLFtOjXWv3z/G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgA2KOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:14:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:58006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgA2KOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 05:14:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6DE120716;
        Wed, 29 Jan 2020 10:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580292884;
        bh=+tCBn6vL3onIDM3KFCcmwpaESfp2Yp2C0aLBmmbjGFg=;
        h=Date:From:To:Cc:Subject:From;
        b=Z/xED2egmPw6kwK/yqfyPWkahJE67caGTfrtH6eYlD2QLMw509MiqLehxn5zM4VZs
         1rQqm8rvWJifB6vmQFzs0Rn/y9QAlkpPbRa8LLM9aODtIDAinWjysOjabQYWRFp2wS
         W4shdQBPIjRZepUpdH2w5iidUgTKQDMmTKz1idYM=
Date:   Wed, 29 Jan 2020 11:14:41 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Staging and IIO driver patches for 5.6-rc1
Message-ID: <20200129101441.GA3858429@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit def9d2780727cec3313ed3522d0123158d87224d:

  Linux 5.5-rc7 (2020-01-19 16:02:49 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-5.6-rc1

for you to fetch changes up to fc157998b8257fb9cfe753e7f4af1411da995c9b:

  staging: most: usb: check for NULL device (2020-01-24 10:08:41 +0100)

----------------------------------------------------------------
Staging/IIO patches for 5.6-rc1

Here is the big staging/iio driver patches for 5.6-rc1

Included in here are:
	- lots of new IIO drivers and updates for that subsystem
	- the usual huge quantity of minor cleanups for staging drivers
	- removal of the following staging drivers:
		- isdn/avm
		- isdn/gigaset
		- isdn/hysdn
		- octeon-usb
		- octeon ethernet

Overall we deleted far more lines than we added, removing over 40k of
old and obsolete driver code.

All of these changes have been in linux-next for a while with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aditya Pakki (1):
      staging: kpc2000: remove unnecessary assertions in kpc_dma_transfer

Ajay Singh (9):
      staging: wilc1000: remove unused compile time featurization
      staging: wilc1000: use kernel provided struct cast to extract mac header
      staging: wilc1000: use GENMASK to extract wid type
      staging: wilc1000: remove use of infinite loop conditions
      staging: wilc1000: move firmware API struct's to separate header file
      staging: wilc1000: added 'wilc_' prefix for 'struct assoc_resp' name
      staging: wilc1000: remove unused code prior to throughput enhancement in SPI
      staging: wilc1000: return zero on success and non-zero on function failure
      staging: wilc1000: avoid mutex unlock without lock in wilc_wlan_handle_txq()

Alexandru Ardelean (13):
      iio: imu: adis: rename txrx_lock -> state_lock
      iio: imu: adis: add unlocked read/write function versions
      iio: imu: adis[16480]: group RW into a single lock in adis_enable_irq()
      iio: imu: adis: create an unlocked version of adis_check_status()
      iio: imu: adis: create an unlocked version of adis_reset()
      iio: imu: adis: protect initial startup routine with state lock
      iio: imu: adis: group single conversion under a single state lock
      iio: imu: adis16400: rework locks using ADIS library's state lock
      iio: gyro: adis16136: rework locks using ADIS library's state lock
      iio: imu: adis16480: use state lock for filter freq set
      iio: gyro: adis16260: replace mlock with ADIS lib's state_lock
      iio: imu: adis: use new `delay` structure for SPI transfer delays
      dt-bindings: iio: adis16480: add compatible entry for ADIS16490

Alexandru Tachici (3):
      iio: dac: ad7303: use regulator get optional to check for ext supply
      iio: adc: ad-sigma-delta: Allow custom IRQ flags
      iio: adc: ad7124: Set IRQ type to falling

Amir Mahdi Ghorbanian (1):
      staging: vt6656: remove unnecessary parenthesis

Andrea Merello (9):
      iio: max31856: add option for setting mains filter rejection frequency
      Documentation: ABI: document IIO in_temp_filter_notch_center_frequency file
      iio: max31856: add support for configuring the HW averaging
      iio: core: add char type for sysfs attributes
      iio: core: add thermocouple_type standard attribute
      Documentation: ABI: document IIO thermocouple_type file
      iio: max31856: add support for runtime-configuring the thermocouple type
      iio: maxim_thermocouple: add thermocouple_type sysfs attribute
      dt-bindings: iio: maxim_thermocouple: document new 'compatible' strings

Andreas Hellmich (2):
      staging: rtl8723bs: Fix spelling errors
      staging: rtl8723bs: Fix line length

Andreas Klinger (4):
      dt-bindings: add vendor prefix parallax
      dt-bindings: add parallax ping sensors
      MAINTAINERS: add maintainer for ping iio sensors
      iio: ping: add parallax ping sensors

Andrey Shvetsov (1):
      staging: most: net: fix buffer overflow

Andy Shevchenko (19):
      iio: adc: ti-ads1015: Get rid of legacy platform data
      iio: adc: ti-ads1015: Make use of device property API
      iio: st_lsm6dsx: Mark predefined constants with __maybe_unused
      iio: st_lsm6dsx: Drop unneeded OF code
      iio: st_lsm6dsx: Make use of device properties
      iio: light: st_uvis25: Drop unneeded header inclusion
      iio: accel: st_accel: Drop unnecessary #else branch for ACPI
      iio: pressure: st_press: Drop unnecessary #else branch for ACPI
      iio: gyro: st_gyro: Mark gyro_pdata with __maybe_unused
      iio: accel: st_accel: Mark default_accel_pdata with __maybe_unused
      iio: pressure: st_press: Mark default_press_pdata with __maybe_unused
      iio: st_sensors: Describe function parameters in kernel-doc
      iio: pressure: bmp280: Drop ACPI support
      iio: pressure: bmp280: Allow device to be enumerated from ACPI
      iio: st_gyro: Correct data for LSM9DS0 gyro
      iio: st_sensors: Drop redundant parameter from st_sensors_of_name_probe()
      iio: st_sensors: Make use of device properties
      iio: magnetometer: ak8975: Get rid of platform data
      iio: magnetometer: ak8975: Convert to use device_get_match_data()

Arnd Bergmann (4):
      staging: remove isdn capi drivers
      isdn: capi: dead code removal
      isdn: don't mark kcapi_proc_exit as __exit
      staging: rtl8188: avoid excessive stack usage

Beniamin Bia (4):
      dt-binding: iio: Add documentation for AD7091R5
      MAINTAINERS: add entry for AD7091R5 driver
      iio: adc: ad7887: Cleanup channel assignment
      iio: adc: Move AD7091R5 entry in a alphabetical order in Makefile

Chen Zhou (1):
      iio: light: remove unneeded semicolon

Christian Gromm (17):
      staging: most: fix improper SPDX-License comment style
      staging: most: rename core.h to most.h
      staging: most: rename struct core_component
      staging: most: rename enum mbo_status_flags
      staging: most: configfs: use strlcpy
      staging: most: configfs: reduce array size
      staging: most: use angle brackets in include path
      staging: most: core: fix date in file comment
      staging: most: core: use dev_* function for logging
      staging: most: core: remove noisy log messages
      staging: most: remove device from interface structure
      staging: most: core: drop device reference
      staging: most: remove struct device core driver
      staging: most: core: remove container struct
      staging: most: core: fix logging messages
      staging: next: configfs: fix release link
      staging: most: usb: check for NULL device

Christophe JAILLET (1):
      iio: adc: ti-ads7950: Fix a typo in an error message

Chuanhong Guo (1):
      staging: mt7621-dts: fix register range of memc node in mt7621.dtsi

Chuhong Yuan (1):
      staging: rts5208: add missed pci_release_regions

Colin Ian King (5):
      staging: wfx: check for memory allocation failures from wfx_alloc_hif
      staging: wlan-ng: ensure error return is actually returned
      staging: wilc1000: remove redundant assignment to variable result
      staging: vt6655: remove redundant assignment to variable ret
      staging: comedi: drivers: fix spelling mistake "to" -> "too"

Dan Carpenter (1):
      iio: accel: bma400: prevent setting accel scale too low

Dan Robertson (3):
      dt-bindings: iio: accel: bma400: add bindings
      iio: accel: Add driver for the BMA400
      iio: accel: bma400: basic regulator support

Daniel Junho (4):
      iio: adc: ad7923: Remove the unused defines
      iio: adc: ad7923: Fix checkpatch warning
      iio: adc: ad7923: Add of_device_id table
      iio: adc: ad7923: Add support for the ad7908/ad7918/ad7928

Dmitry Osipenko (2):
      iio: accel: kxcjk1013: Support orientation matrix
      dt-bindings: iio: accel: kxcjk1013: Document mount-matrix property

Dorothea Ehrl (5):
      staging/qlge: remove initialising of static local variable
      staging/qlge: add blank lines after declarations
      staging/qlge: add braces to conditional statement
      staging/qlge: remove braces in conditional statement
      staging/qlge: fix block comment coding style

Etienne Carriere (3):
      iio: adc: stm32-adc: don't print an error on probe deferral
      iio: dac: stm32-dac: use reset controller only at probe time
      iio: dac: stm32-dac: better handle reset controller failures

Fabrice Gasnier (2):
      iio: trigger: stm32-timer: remove unnecessary update event
      iio: adc: stm32-adc: Add check on overrun interrupt

Felipe Cardoso Resende (1):
      Staging: kpc2000: Remove warning: "dubious: x | !y" detected by sparse

Geert Uytterhoeven (1):
      iio: adc: max9611: Make enum relations more future proof

Greg Kroah-Hartman (8):
      Merge 5.5-rc2 into staging-next
      staging: octeon: delete driver
      staging: octeon-usb: delete the octeon usb host controller driver
      Merge 5.5-rc3 into staging-next
      Merge tag 'iio-for-5.6a' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 5.5-rc6 into staging-next
      Merge tag 'iio-for-5.6b' of git://git.kernel.org/.../jic23/iio into staging-next
      Merge 5.5-rc7 into staging-next

Guenter Roeck (1):
      staging/octeon: Mark Ethernet driver as BROKEN

Jean-Baptiste Maneyrol (3):
      iio: imu: inv_mpu6050: delete not existing MPU9150 spi support
      iio: imu: inv_mpu6050: add support of MPU9150 magnetometer
      iio: imu: inv_mpu6050: add fifo temperature data support

Jerry Lin (1):
      staging: kpc2000: rename variables with kpc namespace

Jérôme Pouiller (120):
      staging: wfx: fix the cache of rate policies on interface reset
      staging: wfx: fix case of lack of tx_retry_policies
      staging: wfx: fix counter overflow
      staging: wfx: use boolean appropriately
      staging: wfx: firmware does not support more than 32 total retries
      staging: wfx: fix rate control handling
      staging: wfx: ensure that retry policy always fallbacks to MCS0 / 1Mbps
      staging: wfx: detect race condition in WEP authentication
      staging: wfx: fix hif_set_mfp() with big endian hosts
      staging: wfx: fix wrong error message
      staging: wfx: increase SPI bus frequency limit
      staging: wfx: don't print useless error messages
      staging: wfx: avoid double warning when no more tx policy are available
      staging: wfx: improve error message on unexpected confirmation
      staging: wfx: take advantage of IS_ERR_OR_NULL()
      staging: wfx: uniformize naming rule
      staging: wfx: use meaningful names for CFG_BYTE_ORDER_*
      staging: wfx: remove useless include
      staging: wfx: simplify variable assignment
      staging: wfx: make conditions easier to read
      staging: wfx: ensure that traces never modify arguments
      staging: wfx: ensure that received hif messages are never modified
      staging: wfx: fix typo in "num_of_ssi_ds"
      staging: wfx: fix typo in "num_i_es"
      staging: wfx: fix name of struct hif_req_start_scan_alt
      staging: wfx: improve API of hif_req_join->infrastructure_bss_mode
      staging: wfx: better naming for hif_req_join->short_preamble
      staging: wfx: better naming for hif_mib_set_association_mode->greenfield
      staging: wfx: simplify handling of tx_lock in wfx_do_join()
      staging: wfx: firmware already handle powersave mode during scan
      staging: wfx: declare wfx_set_pm() static
      staging: wfx: drop useless argument from wfx_set_pm()
      staging: wfx: remove redundant test while calling wfx_update_pm()
      staging: wfx: drop unnecessary wvif->powersave_mode
      staging: wfx: do not try to save call to hif_set_pm()
      staging: wfx: fix pm_mode timeout
      staging: wfx: simplify wfx_conf_tx()
      staging: wfx: prefer a bitmask instead of an array of boolean
      staging: wfx: simplify hif_set_uapsd_info() usage
      staging: wfx: simplify hif_set_pm() usage
      staging: wfx: drop struct wfx_edca_params
      staging: wfx: remove unnecessary EDCA initialisation
      staging: wfx: simplify hif_set_edca_queue_params() usage
      staging: wfx: hif_scan() never fails
      staging: wfx: device already handle sleep mode during scan
      staging: wfx: drop useless wfx_scan_complete()
      staging: wfx: simplify hif_scan() usage
      staging: wfx: introduce update_probe_tmpl()
      staging: wfx: simplify hif_set_template_frame() usage
      staging: wfx: rewrite wfx_hw_scan()
      staging: wfx: workaround bug with "iw scan"
      staging: wfx: delayed_unjoin cannot happen
      staging: wfx: delayed_link_loss cannot happen
      staging: wfx: implement cancel_hw_scan()
      staging: wfx: update TODO
      staging: wfx: revert unexpected change in debugfs output
      staging: wfx: make hif_scan() usage clearer
      staging: wfx: add missing PROBE_RESP_OFFLOAD feature
      staging: wfx: send rate policies one by one
      staging: wfx: simplify hif_set_tx_rate_retry_policy() usage
      staging: wfx: simplify hif_set_output_power() usage
      staging: wfx: simplify hif_set_rcpi_rssi_threshold() usage
      staging: wfx: simplify hif_set_arp_ipv4_filter() usage
      staging: wfx: simplify hif_start() usage
      staging: wfx: use specialized structs for HIF arguments
      staging: wfx: retrieve ampdu_density from sta->ht_cap
      staging: wfx: retrieve greenfield mode from sta->ht_cap and bss_conf
      staging: wfx: drop struct wfx_ht_info
      staging: wfx: drop wdev->output_power
      staging: wfx: simplify wfx_config()
      staging: wfx: rename wfx_upload_beacon()
      staging: wfx: simplify wfx_upload_ap_templates()
      staging: wfx: simplify wfx_update_beaconing()
      staging: wfx: fix __wfx_flush() when drop == false
      staging: wfx: simplify wfx_flush()
      staging: wfx: simplify update of DTIM period
      staging: wfx: drop wvif->dtim_period
      staging: wfx: drop wvif->enable_beacon
      staging: wfx: drop wvif->cqm_rssi_thold
      staging: wfx: drop wvif->setbssparams_done
      staging: wfx: drop wfx_set_cts_work()
      staging: wfx: SSID should be provided to hif_start() even if hidden
      staging: wfx: simplify hif_update_ie()
      staging: wfx: simplify hif_join()
      staging: wfx: simplify hif_set_association_mode()
      staging: wfx: simplify hif_set_uc_mc_bc_condition()
      staging: wfx: simplify hif_mib_uc_mc_bc_data_frame_condition
      staging: wfx: simplify hif_mib_set_data_filtering
      staging: wfx: simplify hif_set_data_filtering()
      staging: wfx: simplify hif_set_mac_addr_condition()
      staging: wfx: simplify hif_set_config_data_filter()
      staging: wfx: simplify wfx_set_mcast_filter()
      staging: wfx: simplify wfx_update_filtering()
      staging: wfx: simplify wfx_scan_complete()
      staging: wfx: update power-save per interface
      staging: wfx: with multiple vifs, force PS only if channels differs
      staging: wfx: do not update uapsd if not necessary
      staging: wfx: fix case where RTS threshold is 0
      staging: wfx: fix possible overflow on jiffies comparaison
      staging: wfx: remove handling of "early_data"
      staging: wfx: relocate "buffered" information to sta_priv
      staging: wfx: fix bss_loss
      staging: wfx: fix RCU usage
      staging: wfx: simplify wfx_set_tim_impl()
      staging: wfx: simplify the link-id allocation
      staging: wfx: check that no tx is pending before release sta
      staging: wfx: replace wfx_tx_get_tid() with ieee80211_get_tid()
      staging: wfx: pspoll_mask make no sense
      staging: wfx: sta and dtim
      staging: wfx: firmware never return PS status for stations
      staging: wfx: simplify wfx_suspend_resume_mc()
      staging: wfx: simplify handling of IEEE80211_TX_CTL_SEND_AFTER_DTIM
      staging: wfx: simplify wfx_ps_notify_sta()
      staging: wfx: ensure that packet_id is unique
      staging: wfx: remove unused do_probe
      staging: wfx: remove check for interface state
      staging: wfx: simplify hif_handle_tx_data()
      staging: wfx: simplify wfx_tx_queue_get_num_queued()
      staging: wfx: simplify hif_multi_tx_confirm()
      staging: wfx: update TODO

Kent Gustavsson (1):
      iio: humidity: dht11 remove TODO since it doesn't make sense

Krzysztof Kozlowski (1):
      iio: Fix Kconfig indentation

Lars-Peter Clausen (3):
      iio: buffer-dmaengine: Add module information
      iio: buffer-dmaengine: Report buffer length requirements
      iio: buffer: rename 'read_first_n' callback to 'read'

Linus Walleij (16):
      iio: imu: inv_mpu6050: Select I2C_MUX again
      iio: ak8975: Convert to use GPIO descriptor
      iio: as3935: Drop GPIO includes
      iio: si1145: Drop GPIO include
      iio: ad2s1200: Drop legacy include
      iio: apds9960: Drop GPIO includes
      iio: itg3200: Drop GPIO include
      iio: adf4350: Convert to use GPIO descriptor
      iio: ad5592r: Drop surplus GPIO header
      iio: ad7266: Convert to use GPIO descriptors
      iio: atlas-ph-sensor: Drop GPIO include
      iio: ssp_sensors: Convert to use GPIO descriptors
      iio: accel: bma180: Add dev helper variable
      iio: accel: bma180: Basic regulator support
      iio: accel: bma180: Use explicit member assignment
      iio: accel: bma180: BMA254 support

Lorenzo Bianconi (9):
      iio: imu: st_lsm6dsx: fix checkpatch warning
      iio: humidity: hts221: move register definitions to sensor structs
      iio: imu: st_lsm6dsx: export max num of slave devices in st_lsm6dsx_shub_settings
      iio: imu: st_lsm6dsx: check if master_enable is located in primary page
      iio: imu: st_lsm6dsx: check if pull_up is located in primary page
      iio: imu: st_lsm6dsx: check if shub_output reg is located in primary page
      iio: imu: st_lsm6dsx: rename st_lsm6dsx_shub_read_reg in st_lsm6dsx_shub_read_output
      iio: imu: st_lsm6dsx: enable sensor-hub support for lsm6dsm
      iio: imu: st_lsm6dsx: check return value from st_lsm6dsx_sensor_set_enable

Malcolm Priestley (9):
      staging: vt6656: correct packet types for CTS protect, mode.
      staging: vt6656: use NULLFUCTION stack on mac80211
      staging: vt6656: Fix false Tx excessive retries reporting.
      staging: vt6656: Move ieee80211_rx_status off stack.
      staging: vt6656: Simplify RX finding bit rates
      staging: vt6656: create vnt rx header for sk_buff.
      staging: vt6656: Use vnt_rx_tail struct for tail variables.
      staging: vt6656: Just check NEWRSR_DECRYPTOK for RX_FLAG_DECRYPTED.
      staging: vt6656: Remove memory buffer from vnt_download_firmware.

Marco Felsch (1):
      iio: adc: ad799x: add pm_ops to disable the device completely

Martin Kepplinger (1):
      iio: imu: st_lsm6dsx: add mount matrix support

Masahiro Yamada (6):
      staging: rts5208: remove unneeded header include path
      staging: rtl8192u: remove unused Makefile
      staging: rtl8192u: remove header include path to ieee80211/
      staging: rtl8192u: remove unneeded compiler flags
      staging: vc04_services: remove header include path to vc04_services
      staging: most: remove header include path to drivers/staging

Matt Ranostay (2):
      iio: chemical: atlas-ph-sensor: rename atlas-ph-sensor to atlas-sensor
      iio: chemical: atlas-sensor: add helper function atlas_buffer_num_channels()

Michael Kupfer (1):
      staging/vc04_services/bcm2835-camera: distinct numeration and names for devices

Michael Straube (21):
      staging: rtl8188eu: remove unnecessary parentheses in rtw_pwrctrl.c
      staging: rtl8188eu: cleanup declarations in rtw_pwrctrl.c
      staging: rtl8188eu: remove return variable from rtw_pwr_unassociated_idle
      staging: rtl8188eu: cleanup comparsions to NULL in rtw_mlme_ext.c
      staging: rtl8188eu: add spaces around operators in rtw_mlme_ext.c
      staging: rtl8188eu: use break to exit while loop
      staging: rtl8188eu: remove else after return
      staging: rtl8188eu: refactor rtl88eu_dm_update_rx_idle_ant()
      staging: rtl8188eu: remove unused parameters from rtw_check_network_type
      staging: rtl8723bs: remove ODM_GetRightChnlPlaceforIQK()
      staging: rtl8188eu: refactor rtw_hal_antdiv_before_linked()
      staging: rtl8188eu: convert rtw_hal_antdiv_before_linked() to bool
      staging: rtl8188eu: cleanup long lines in rtl8188e_dm.c
      staging: rtl8188eu: remove unnecessary parentheses in rtl8188e_dm.c
      staging: rtl8188eu: cleanup whitespace in rtl8188e_dm.c
      staging: rtl8188eu: remove else after break or return
      staging: rtl8188eu: remove redundant defines
      staging: rtl8188eu: remove unused enum and defines
      staging: rtl8192e: simplify rtl92e_evm_db_to_percent()
      staging: rtl8192u: simplify rtl819x_evm_dbtopercentage()
      staging: rtl8712: simplify evm_db2percentage()

Michał Mirosław (1):
      iio: imu/mpu6050: support dual-edge IRQ

Namjae Jeon (1):
      staging: exfat: add STAGING prefix to config names

Nuno Sá (2):
      iio: adis: Introduce timeouts structure
      iio: adis: Remove startup_delay

Ole Wiedemann (1):
      staging: android: ashmem: Replace strcpy with strscpy

Olivier Moysan (3):
      dt-bindings: iio: adc: convert sd modulator to json-schema
      iio: adc: stm32-dfsdm: fix single conversion
      iio: adc: stm32-dfsdm: adapt sampling rate to oversampling ratio

Paul Cercueil (2):
      iio: adc: Add support for AD7091R5 ADC
      iio: adc: ad7091r5: Add scale and external VREF support

Paulo Miguel Almeida (1):
      staging: rtl8192u: replace printk with natdev_<LEVEL> statements in ieee80211

Peter Ujfalusi (4):
      iio: buffer-dmaengine: Use dma_request_chan() directly for channel request
      iio: adc: stm32-dfsdm: Use dma_request_chan() instead dma_request_slave_channel()
      iio: adc: stm32-adc: Use dma_request_chan() instead dma_request_slave_channel()
      iio: adc: at91-sama5d2_adc: Use dma_request_chan() instead dma_request_slave_channel()

Pragat Pandya (1):
      staging: exfat: Fix alignment warnings

Quentin Deslandes (1):
      staging: axis-fifo: replace spinlock with mutex

Rodrigo Carvalho (2):
      staging: iio: accel: adis16240: enforce SPI mode on probe function
      dt-bindings: iio: accel: add binding documentation for ADIS16240

Scott Schafer (3):
      staging: qlge: Fix CamelCase in qlge.h and qlge_dbg.c
      staging: qlge: Fix CHECK extra blank lines in many files
      staging: qlge: Fix CHECK: Alignment should match open parenthesis

Stefan Popa (1):
      iio: imu: adis16480: Add support for ADIS16490

Susarla Nikhilesh (1):
      staging: exfat: fix spelling mistake

Takashi Iwai (4):
      staging: most: Use managed buffer allocation
      staging: bcm2835-audio: Use managed buffer allocation
      staging: most: Drop superfluous ioctl PCM ops
      staging: bcm2835-audio: Drop superfluous ioctl PCM ops

Tetsuhiro Kohada (1):
      staging: exfat: remove fs_func struct.

Tomislav Denis (3):
      iio: pressure: Add driver for DLH pressure sensors
      dt-bindings: Add asc vendor
      bindings: iio: pressure: Add documentation for dlh driver

Uwe Kleine-König (3):
      iio: adc: ltc2496: provide device tree binding document
      iio: adc: ltc2497: split protocol independent part in a separate module
      iio: adc: new driver to support Linear technology's ltc2496

Xidong Wang (1):
      staging: nvec: check return value

YueHaibing (1):
      staging: hp100: Use match_string() helper to simplify the code

 Documentation/ABI/testing/sysfs-bus-iio            |   13 +
 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer |   19 +
 .../bindings/iio/accel/adi,adis16240.yaml          |   49 +
 .../devicetree/bindings/iio/accel/bma180.txt       |    7 +-
 .../bindings/iio/accel/bosch,bma400.yaml           |   54 +
 .../bindings/iio/accel/kionix,kxcjk1013.txt        |    7 +
 .../devicetree/bindings/iio/adc/adi,ad7091r5.yaml  |   54 +
 .../devicetree/bindings/iio/adc/lltc,ltc2496.yaml  |   47 +
 .../bindings/iio/adc/sigma-delta-modulator.txt     |   13 -
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |   37 +
 .../devicetree/bindings/iio/imu/adi,adis16480.txt  |    1 +
 .../bindings/iio/pressure/asc,dlhl60d.yaml         |   51 +
 .../bindings/iio/proximity/parallax-ping.yaml      |   51 +
 .../iio/temperature/maxim_thermocouple.txt         |    7 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    4 +
 Documentation/isdn/avmb1.rst                       |  246 --
 Documentation/isdn/gigaset.rst                     |  465 ---
 Documentation/isdn/hysdn.rst                       |  196 -
 Documentation/isdn/index.rst                       |    3 -
 Documentation/isdn/interface_capi.rst              |   71 -
 Documentation/userspace-api/ioctl/ioctl-number.rst |    1 -
 MAINTAINERS                                        |   35 +-
 drivers/iio/accel/Kconfig                          |   20 +-
 drivers/iio/accel/Makefile                         |    2 +
 drivers/iio/accel/adis16201.c                      |    8 +-
 drivers/iio/accel/adis16209.c                      |    8 +-
 drivers/iio/accel/bma180.c                         |  225 +-
 drivers/iio/accel/bma400.h                         |   99 +
 drivers/iio/accel/bma400_core.c                    |  853 +++++
 drivers/iio/accel/bma400_i2c.c                     |   61 +
 drivers/iio/accel/kxcjk-1013.c                     |   27 +-
 drivers/iio/accel/st_accel.h                       |    2 +-
 drivers/iio/accel/st_accel_i2c.c                   |    8 +-
 drivers/iio/accel/st_accel_spi.c                   |    9 +-
 drivers/iio/adc/Kconfig                            |   17 +
 drivers/iio/adc/Makefile                           |    4 +-
 drivers/iio/adc/ad7091r-base.c                     |  298 ++
 drivers/iio/adc/ad7091r-base.h                     |   26 +
 drivers/iio/adc/ad7091r5.c                         |  113 +
 drivers/iio/adc/ad7124.c                           |    2 +
 drivers/iio/adc/ad7266.c                           |   29 +-
 drivers/iio/adc/ad7780.c                           |    1 +
 drivers/iio/adc/ad7791.c                           |    1 +
 drivers/iio/adc/ad7793.c                           |    1 +
 drivers/iio/adc/ad7887.c                           |   82 +-
 drivers/iio/adc/ad7923.c                           |   64 +-
 drivers/iio/adc/ad799x.c                           |   66 +-
 drivers/iio/adc/ad_sigma_delta.c                   |    2 +-
 drivers/iio/adc/at91-sama5d2_adc.c                 |    6 +-
 drivers/iio/adc/ltc2496.c                          |  108 +
 drivers/iio/adc/ltc2497-core.c                     |  243 ++
 drivers/iio/adc/ltc2497.c                          |  234 +-
 drivers/iio/adc/ltc2497.h                          |   18 +
 drivers/iio/adc/max9611.c                          |   36 +-
 drivers/iio/adc/stm32-adc-core.c                   |   23 +-
 drivers/iio/adc/stm32-adc-core.h                   |    9 +
 drivers/iio/adc/stm32-adc.c                        |   71 +-
 drivers/iio/adc/stm32-dfsdm-adc.c                  |   55 +-
 drivers/iio/adc/ti-ads1015.c                       |   73 +-
 drivers/iio/adc/ti-ads7950.c                       |    2 +-
 drivers/iio/buffer/industrialio-buffer-dma.c       |    2 +-
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |   30 +-
 drivers/iio/buffer/kfifo_buf.c                     |    5 +-
 drivers/iio/chemical/Makefile                      |    2 +-
 .../chemical/{atlas-ph-sensor.c => atlas-sensor.c} |   24 +-
 drivers/iio/common/ssp_sensors/ssp.h               |   14 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c           |   29 +-
 drivers/iio/common/ssp_sensors/ssp_spi.c           |    8 +-
 drivers/iio/common/st_sensors/st_sensors_core.c    |   45 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c     |   21 -
 drivers/iio/common/st_sensors/st_sensors_spi.c     |   12 +-
 drivers/iio/common/st_sensors/st_sensors_trigger.c |    3 +
 drivers/iio/dac/ad5592r-base.c                     |    1 -
 drivers/iio/dac/ad7303.c                           |   25 +-
 drivers/iio/dac/stm32-dac-core.c                   |   19 +-
 drivers/iio/frequency/adf4350.c                    |   30 +-
 drivers/iio/gyro/Kconfig                           |   32 +-
 drivers/iio/gyro/adis16136.c                       |   72 +-
 drivers/iio/gyro/adis16260.c                       |   14 +-
 drivers/iio/gyro/itg3200_core.c                    |    1 -
 drivers/iio/gyro/st_gyro.h                         |    2 +-
 drivers/iio/gyro/st_gyro_core.c                    |   75 +-
 drivers/iio/gyro/st_gyro_i2c.c                     |    9 +-
 drivers/iio/gyro/st_gyro_spi.c                     |    9 +-
 drivers/iio/humidity/dht11.c                       |    1 -
 drivers/iio/humidity/hts221_core.c                 |   19 +-
 drivers/iio/iio_core.h                             |    8 +-
 drivers/iio/imu/adis.c                             |  139 +-
 drivers/iio/imu/adis16400.c                        |  115 +-
 drivers/iio/imu/adis16460.c                        |    7 +
 drivers/iio/imu/adis16480.c                        |   92 +-
 drivers/iio/imu/adis_buffer.c                      |    4 +-
 drivers/iio/imu/inv_mpu6050/Kconfig                |    9 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         |  237 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c          |    2 +
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |   22 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c         |   80 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c         |   11 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c          |    1 -
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c      |    4 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            |   49 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     |   27 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       |  121 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        |    3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c       |   76 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        |    3 +-
 drivers/iio/industrialio-buffer.c                  |   10 +-
 drivers/iio/industrialio-core.c                    |   25 +-
 drivers/iio/light/apds9960.c                       |    2 -
 drivers/iio/light/lm3533-als.c                     |    2 +-
 drivers/iio/light/si1145.c                         |    1 -
 drivers/iio/light/st_uvis25_i2c.c                  |    1 -
 drivers/iio/magnetometer/ak8975.c                  |  107 +-
 drivers/iio/magnetometer/st_magn_i2c.c             |    9 +-
 drivers/iio/magnetometer/st_magn_spi.c             |    9 +-
 drivers/iio/pressure/Kconfig                       |   12 +
 drivers/iio/pressure/Makefile                      |    1 +
 drivers/iio/pressure/bmp280-i2c.c                  |   18 +-
 drivers/iio/pressure/dlhl60d.c                     |  375 ++
 drivers/iio/pressure/st_pressure.h                 |    2 +-
 drivers/iio/pressure/st_pressure_i2c.c             |   22 +-
 drivers/iio/pressure/st_pressure_spi.c             |    9 +-
 drivers/iio/proximity/Kconfig                      |   15 +
 drivers/iio/proximity/Makefile                     |    1 +
 drivers/iio/proximity/as3935.c                     |    3 -
 drivers/iio/proximity/ping.c                       |  335 ++
 drivers/iio/resolver/ad2s1200.c                    |    1 -
 drivers/iio/temperature/max31856.c                 |  134 +-
 drivers/iio/temperature/maxim_thermocouple.c       |   44 +-
 drivers/iio/trigger/stm32-timer-trigger.c          |    3 -
 drivers/isdn/Makefile                              |    2 +-
 drivers/isdn/capi/Kconfig                          |   32 +-
 drivers/isdn/capi/Makefile                         |   18 +-
 drivers/isdn/capi/capi.c                           |   14 +-
 drivers/isdn/capi/capilib.c                        |  202 --
 drivers/isdn/capi/capiutil.c                       |  231 +-
 drivers/isdn/capi/kcapi.c                          |  409 +--
 drivers/isdn/capi/kcapi.h                          |  149 +-
 drivers/isdn/capi/kcapi_proc.c                     |   36 +-
 drivers/staging/Kconfig                            |    6 -
 drivers/staging/Makefile                           |    5 +-
 drivers/staging/android/ashmem.c                   |    6 +-
 drivers/staging/axis-fifo/axis-fifo.c              |  160 +-
 drivers/staging/comedi/drivers/das6402.c           |    2 +-
 drivers/staging/exfat/Kconfig                      |   26 +-
 drivers/staging/exfat/Makefile                     |    2 +-
 drivers/staging/exfat/exfat.h                      |   93 +-
 drivers/staging/exfat/exfat_blkdev.c               |   16 +-
 drivers/staging/exfat/exfat_core.c                 |  211 +-
 drivers/staging/exfat/exfat_super.c                |  175 +-
 drivers/staging/hp/hp100.c                         |   11 +-
 drivers/staging/iio/accel/adis16203.c              |    8 +-
 drivers/staging/iio/accel/adis16240.c              |   15 +-
 drivers/staging/isdn/Kconfig                       |   12 -
 drivers/staging/isdn/Makefile                      |    8 -
 drivers/staging/isdn/TODO                          |   22 -
 drivers/staging/isdn/avm/Kconfig                   |   65 -
 drivers/staging/isdn/avm/Makefile                  |   12 -
 drivers/staging/isdn/avm/avm_cs.c                  |  166 -
 drivers/staging/isdn/avm/avmcard.h                 |  581 ---
 drivers/staging/isdn/avm/b1.c                      |  819 -----
 drivers/staging/isdn/avm/b1dma.c                   |  981 -----
 drivers/staging/isdn/avm/b1isa.c                   |  243 --
 drivers/staging/isdn/avm/b1pci.c                   |  416 ---
 drivers/staging/isdn/avm/b1pcmcia.c                |  224 --
 drivers/staging/isdn/avm/c4.c                      | 1317 -------
 drivers/staging/isdn/avm/t1isa.c                   |  594 ----
 drivers/staging/isdn/avm/t1pci.c                   |  259 --
 drivers/staging/isdn/gigaset/Kconfig               |   62 -
 drivers/staging/isdn/gigaset/Makefile              |   17 -
 drivers/staging/isdn/gigaset/asyncdata.c           |  606 ----
 drivers/staging/isdn/gigaset/bas-gigaset.c         | 2672 --------------
 drivers/staging/isdn/gigaset/capi.c                | 2517 -------------
 drivers/staging/isdn/gigaset/common.c              | 1153 ------
 drivers/staging/isdn/gigaset/dummyll.c             |   74 -
 drivers/staging/isdn/gigaset/ev-layer.c            | 1910 ----------
 drivers/staging/isdn/gigaset/gigaset.h             |  827 -----
 drivers/staging/isdn/gigaset/interface.c           |  613 ----
 drivers/staging/isdn/gigaset/isocdata.c            | 1006 ------
 drivers/staging/isdn/gigaset/proc.c                |   77 -
 drivers/staging/isdn/gigaset/ser-gigaset.c         |  796 -----
 drivers/staging/isdn/gigaset/usb-gigaset.c         |  959 -----
 drivers/staging/isdn/hysdn/Kconfig                 |   15 -
 drivers/staging/isdn/hysdn/Makefile                |   12 -
 drivers/staging/isdn/hysdn/boardergo.c             |  445 ---
 drivers/staging/isdn/hysdn/boardergo.h             |  100 -
 drivers/staging/isdn/hysdn/hycapi.c                |  785 ----
 drivers/staging/isdn/hysdn/hysdn_boot.c            |  400 ---
 drivers/staging/isdn/hysdn/hysdn_defs.h            |  282 --
 drivers/staging/isdn/hysdn/hysdn_init.c            |  213 --
 drivers/staging/isdn/hysdn/hysdn_net.c             |  330 --
 drivers/staging/isdn/hysdn/hysdn_pof.h             |   78 -
 drivers/staging/isdn/hysdn/hysdn_procconf.c        |  411 ---
 drivers/staging/isdn/hysdn/hysdn_proclog.c         |  357 --
 drivers/staging/isdn/hysdn/hysdn_sched.c           |  197 --
 drivers/staging/isdn/hysdn/ince1pc.h               |  134 -
 drivers/staging/kpc2000/kpc2000_i2c.c              |  120 +-
 drivers/staging/kpc2000/kpc_dma/fileops.c          |    2 -
 drivers/staging/most/Makefile                      |    1 -
 drivers/staging/most/cdev/Makefile                 |    1 -
 drivers/staging/most/cdev/cdev.c                   |    5 +-
 drivers/staging/most/configfs.c                    |   59 +-
 drivers/staging/most/core.c                        |  204 +-
 drivers/staging/most/dim2/Makefile                 |    1 -
 drivers/staging/most/dim2/dim2.c                   |    5 +-
 drivers/staging/most/i2c/Makefile                  |    1 -
 drivers/staging/most/i2c/i2c.c                     |    2 +-
 drivers/staging/most/{core.h => most.h}            |   30 +-
 drivers/staging/most/net/Makefile                  |    1 -
 drivers/staging/most/net/net.c                     |   17 +-
 drivers/staging/most/sound/Makefile                |    1 -
 drivers/staging/most/sound/sound.c                 |   54 +-
 drivers/staging/most/usb/Makefile                  |    1 -
 drivers/staging/most/usb/usb.c                     |   26 +-
 drivers/staging/most/video/Makefile                |    1 -
 drivers/staging/most/video/video.c                 |    6 +-
 drivers/staging/mt7621-dts/mt7621.dtsi             |    2 +-
 drivers/staging/nvec/nvec_kbd.c                    |    2 +
 drivers/staging/octeon-usb/Kconfig                 |   11 -
 drivers/staging/octeon-usb/Makefile                |    2 -
 drivers/staging/octeon-usb/TODO                    |    8 -
 drivers/staging/octeon-usb/octeon-hcd.c            | 3737 --------------------
 drivers/staging/octeon-usb/octeon-hcd.h            | 1847 ----------
 drivers/staging/octeon/Kconfig                     |   16 -
 drivers/staging/octeon/Makefile                    |   19 -
 drivers/staging/octeon/TODO                        |    9 -
 drivers/staging/octeon/ethernet-defines.h          |   40 -
 drivers/staging/octeon/ethernet-mdio.c             |  178 -
 drivers/staging/octeon/ethernet-mdio.h             |   28 -
 drivers/staging/octeon/ethernet-mem.c              |  154 -
 drivers/staging/octeon/ethernet-mem.h              |    9 -
 drivers/staging/octeon/ethernet-rgmii.c            |  158 -
 drivers/staging/octeon/ethernet-rx.c               |  538 ---
 drivers/staging/octeon/ethernet-rx.h               |   31 -
 drivers/staging/octeon/ethernet-sgmii.c            |   30 -
 drivers/staging/octeon/ethernet-spi.c              |  226 --
 drivers/staging/octeon/ethernet-tx.c               |  717 ----
 drivers/staging/octeon/ethernet-tx.h               |   14 -
 drivers/staging/octeon/ethernet-util.h             |   47 -
 drivers/staging/octeon/ethernet.c                  |  992 ------
 drivers/staging/octeon/octeon-ethernet.h           |  107 -
 drivers/staging/octeon/octeon-stubs.h              | 1433 --------
 drivers/staging/qlge/qlge.h                        |   15 +-
 drivers/staging/qlge/qlge_dbg.c                    |   32 +-
 drivers/staging/qlge/qlge_ethtool.c                |   39 +-
 drivers/staging/qlge/qlge_main.c                   |  215 +-
 drivers/staging/qlge/qlge_mpi.c                    |   26 +-
 drivers/staging/rtl8188eu/core/rtw_ap.c            |    4 +-
 drivers/staging/rtl8188eu/core/rtw_efuse.c         |   14 +-
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c     |   20 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c      |  200 +-
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c       |   34 +-
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c     |    8 +-
 drivers/staging/rtl8188eu/core/rtw_xmit.c          |    4 +-
 drivers/staging/rtl8188eu/hal/odm.c                |    7 +-
 drivers/staging/rtl8188eu/hal/odm_rtl8188e.c       |   82 +-
 drivers/staging/rtl8188eu/hal/phy.c                |   41 +-
 drivers/staging/rtl8188eu/hal/rtl8188e_dm.c        |   97 +-
 .../staging/rtl8188eu/include/hal8188e_phy_cfg.h   |    5 -
 drivers/staging/rtl8188eu/include/hal_intf.h       |    2 +-
 drivers/staging/rtl8188eu/include/ieee80211.h      |    2 +-
 drivers/staging/rtl8188eu/include/odm.h            |    1 -
 drivers/staging/rtl8188eu/include/rtl8188e_dm.h    |    7 +-
 drivers/staging/rtl8188eu/include/rtw_rf.h         |   16 -
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |   15 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |   11 +-
 drivers/staging/rtl8192u/Makefile                  |    4 -
 drivers/staging/rtl8192u/ieee80211/Makefile        |   27 -
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  |   62 +-
 drivers/staging/rtl8192u/r8192U_core.c             |   13 +-
 drivers/staging/rtl8192u/r8192U_wx.c               |    2 +-
 drivers/staging/rtl8192u/r819xU_phy.c              |    2 +-
 drivers/staging/rtl8712/rtl8712_recv.c             |   10 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c      |   54 +-
 drivers/staging/rtl8723bs/hal/HalPhyRf.c           |   30 -
 drivers/staging/rtl8723bs/hal/HalPhyRf.h           |    8 -
 drivers/staging/rtl8723bs/hal/HalPhyRf_8723B.c     |   23 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c  |   44 +-
 drivers/staging/rts5208/Makefile                   |    2 -
 drivers/staging/rts5208/rtsx.c                     |    7 +-
 drivers/staging/vc04_services/Makefile             |    2 +-
 .../vc04_services/bcm2835-audio/bcm2835-pcm.c      |   19 +-
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |    9 +-
 .../staging/vc04_services/interface/vchi/vchi.h    |    4 +-
 .../vc04_services/interface/vchiq_arm/vchiq_shim.c |    2 +-
 drivers/staging/vt6655/rf.c                        |    2 +-
 drivers/staging/vt6656/baseband.c                  |    8 +-
 drivers/staging/vt6656/device.h                    |   19 +-
 drivers/staging/vt6656/dpc.c                       |  114 +-
 drivers/staging/vt6656/firmware.c                  |   14 +-
 drivers/staging/vt6656/int.c                       |    6 +-
 drivers/staging/vt6656/main_usb.c                  |    1 +
 drivers/staging/vt6656/rxtx.c                      |   26 +-
 drivers/staging/vt6656/usbpipe.c                   |    2 +-
 drivers/staging/vt6656/usbpipe.h                   |    2 +-
 drivers/staging/wfx/TODO                           |   71 +-
 drivers/staging/wfx/bh.c                           |    3 +-
 drivers/staging/wfx/bus_spi.c                      |    9 +-
 drivers/staging/wfx/data_rx.c                      |   85 +-
 drivers/staging/wfx/data_rx.h                      |    4 +-
 drivers/staging/wfx/data_tx.c                      |  322 +-
 drivers/staging/wfx/data_tx.h                      |   27 +-
 drivers/staging/wfx/debug.c                        |    2 +-
 drivers/staging/wfx/fwio.c                         |   28 +-
 drivers/staging/wfx/hif_api_cmd.h                  |   35 +-
 drivers/staging/wfx/hif_api_mib.h                  |   35 +-
 drivers/staging/wfx/hif_rx.c                       |  115 +-
 drivers/staging/wfx/hif_tx.c                       |  164 +-
 drivers/staging/wfx/hif_tx.h                       |   28 +-
 drivers/staging/wfx/hif_tx_mib.h                   |  183 +-
 drivers/staging/wfx/hwio.h                         |   15 +-
 drivers/staging/wfx/main.c                         |   10 +-
 drivers/staging/wfx/queue.c                        |  216 +-
 drivers/staging/wfx/queue.h                        |   10 +-
 drivers/staging/wfx/scan.c                         |  321 +-
 drivers/staging/wfx/scan.h                         |   26 +-
 drivers/staging/wfx/secure_link.h                  |    8 +-
 drivers/staging/wfx/sta.c                          | 1058 ++----
 drivers/staging/wfx/sta.h                          |   20 +-
 drivers/staging/wfx/traces.h                       |   14 +-
 drivers/staging/wfx/wfx.h                          |   43 +-
 drivers/staging/wilc1000/fw.h                      |  119 +
 drivers/staging/wilc1000/hif.c                     |   90 +-
 drivers/staging/wilc1000/hif.h                     |   19 -
 drivers/staging/wilc1000/netdev.c                  |   63 +-
 drivers/staging/wilc1000/netdev.h                  |    1 -
 drivers/staging/wilc1000/sdio.c                    |  178 +-
 drivers/staging/wilc1000/spi.c                     |  285 +-
 drivers/staging/wilc1000/wlan.c                    |  192 +-
 drivers/staging/wilc1000/wlan.h                    |    2 +
 drivers/staging/wilc1000/wlan_cfg.c                |  152 +-
 drivers/staging/wilc1000/wlan_if.h                 |    1 +
 drivers/staging/wlan-ng/prism2mgmt.c               |    2 +-
 include/linux/b1pcmcia.h                           |   21 -
 include/linux/iio/accel/kxcjk_1013.h               |    3 +
 include/linux/iio/adc/ad_sigma_delta.h             |    2 +
 include/linux/iio/buffer_impl.h                    |    6 +-
 include/linux/iio/common/st_sensors.h              |   12 +-
 include/linux/iio/common/st_sensors_i2c.h          |   10 -
 include/linux/iio/frequency/adf4350.h              |    4 -
 include/linux/iio/imu/adis.h                       |  164 +-
 include/linux/iio/magnetometer/ak8975.h            |   17 -
 include/linux/iio/types.h                          |    2 +
 include/linux/isdn/capilli.h                       |   18 -
 include/linux/isdn/capiutil.h                      |  456 ---
 include/linux/kernelcapi.h                         |   75 -
 include/linux/platform_data/ad7266.h               |    3 -
 include/linux/platform_data/ads1015.h              |   23 -
 include/uapi/linux/b1lli.h                         |   74 -
 include/uapi/linux/gigaset_dev.h                   |   39 -
 include/uapi/linux/hysdn_if.h                      |   34 -
 351 files changed, 7825 insertions(+), 40990 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-dma-buffer
 create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adis16240.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.yaml
 delete mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
 create mode 100644 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/asc,dlhl60d.yaml
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/parallax-ping.yaml
 delete mode 100644 Documentation/isdn/avmb1.rst
 delete mode 100644 Documentation/isdn/gigaset.rst
 delete mode 100644 Documentation/isdn/hysdn.rst
 create mode 100644 drivers/iio/accel/bma400.h
 create mode 100644 drivers/iio/accel/bma400_core.c
 create mode 100644 drivers/iio/accel/bma400_i2c.c
 create mode 100644 drivers/iio/adc/ad7091r-base.c
 create mode 100644 drivers/iio/adc/ad7091r-base.h
 create mode 100644 drivers/iio/adc/ad7091r5.c
 create mode 100644 drivers/iio/adc/ltc2496.c
 create mode 100644 drivers/iio/adc/ltc2497-core.c
 create mode 100644 drivers/iio/adc/ltc2497.h
 rename drivers/iio/chemical/{atlas-ph-sensor.c => atlas-sensor.c} (97%)
 create mode 100644 drivers/iio/pressure/dlhl60d.c
 create mode 100644 drivers/iio/proximity/ping.c
 delete mode 100644 drivers/isdn/capi/capilib.c
 delete mode 100644 drivers/staging/isdn/Kconfig
 delete mode 100644 drivers/staging/isdn/Makefile
 delete mode 100644 drivers/staging/isdn/TODO
 delete mode 100644 drivers/staging/isdn/avm/Kconfig
 delete mode 100644 drivers/staging/isdn/avm/Makefile
 delete mode 100644 drivers/staging/isdn/avm/avm_cs.c
 delete mode 100644 drivers/staging/isdn/avm/avmcard.h
 delete mode 100644 drivers/staging/isdn/avm/b1.c
 delete mode 100644 drivers/staging/isdn/avm/b1dma.c
 delete mode 100644 drivers/staging/isdn/avm/b1isa.c
 delete mode 100644 drivers/staging/isdn/avm/b1pci.c
 delete mode 100644 drivers/staging/isdn/avm/b1pcmcia.c
 delete mode 100644 drivers/staging/isdn/avm/c4.c
 delete mode 100644 drivers/staging/isdn/avm/t1isa.c
 delete mode 100644 drivers/staging/isdn/avm/t1pci.c
 delete mode 100644 drivers/staging/isdn/gigaset/Kconfig
 delete mode 100644 drivers/staging/isdn/gigaset/Makefile
 delete mode 100644 drivers/staging/isdn/gigaset/asyncdata.c
 delete mode 100644 drivers/staging/isdn/gigaset/bas-gigaset.c
 delete mode 100644 drivers/staging/isdn/gigaset/capi.c
 delete mode 100644 drivers/staging/isdn/gigaset/common.c
 delete mode 100644 drivers/staging/isdn/gigaset/dummyll.c
 delete mode 100644 drivers/staging/isdn/gigaset/ev-layer.c
 delete mode 100644 drivers/staging/isdn/gigaset/gigaset.h
 delete mode 100644 drivers/staging/isdn/gigaset/interface.c
 delete mode 100644 drivers/staging/isdn/gigaset/isocdata.c
 delete mode 100644 drivers/staging/isdn/gigaset/proc.c
 delete mode 100644 drivers/staging/isdn/gigaset/ser-gigaset.c
 delete mode 100644 drivers/staging/isdn/gigaset/usb-gigaset.c
 delete mode 100644 drivers/staging/isdn/hysdn/Kconfig
 delete mode 100644 drivers/staging/isdn/hysdn/Makefile
 delete mode 100644 drivers/staging/isdn/hysdn/boardergo.c
 delete mode 100644 drivers/staging/isdn/hysdn/boardergo.h
 delete mode 100644 drivers/staging/isdn/hysdn/hycapi.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_boot.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_defs.h
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_init.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_net.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_pof.h
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_procconf.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_proclog.c
 delete mode 100644 drivers/staging/isdn/hysdn/hysdn_sched.c
 delete mode 100644 drivers/staging/isdn/hysdn/ince1pc.h
 rename drivers/staging/most/{core.h => most.h} (94%)
 delete mode 100644 drivers/staging/octeon-usb/Kconfig
 delete mode 100644 drivers/staging/octeon-usb/Makefile
 delete mode 100644 drivers/staging/octeon-usb/TODO
 delete mode 100644 drivers/staging/octeon-usb/octeon-hcd.c
 delete mode 100644 drivers/staging/octeon-usb/octeon-hcd.h
 delete mode 100644 drivers/staging/octeon/Kconfig
 delete mode 100644 drivers/staging/octeon/Makefile
 delete mode 100644 drivers/staging/octeon/TODO
 delete mode 100644 drivers/staging/octeon/ethernet-defines.h
 delete mode 100644 drivers/staging/octeon/ethernet-mdio.c
 delete mode 100644 drivers/staging/octeon/ethernet-mdio.h
 delete mode 100644 drivers/staging/octeon/ethernet-mem.c
 delete mode 100644 drivers/staging/octeon/ethernet-mem.h
 delete mode 100644 drivers/staging/octeon/ethernet-rgmii.c
 delete mode 100644 drivers/staging/octeon/ethernet-rx.c
 delete mode 100644 drivers/staging/octeon/ethernet-rx.h
 delete mode 100644 drivers/staging/octeon/ethernet-sgmii.c
 delete mode 100644 drivers/staging/octeon/ethernet-spi.c
 delete mode 100644 drivers/staging/octeon/ethernet-tx.c
 delete mode 100644 drivers/staging/octeon/ethernet-tx.h
 delete mode 100644 drivers/staging/octeon/ethernet-util.h
 delete mode 100644 drivers/staging/octeon/ethernet.c
 delete mode 100644 drivers/staging/octeon/octeon-ethernet.h
 delete mode 100644 drivers/staging/octeon/octeon-stubs.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/Makefile
 create mode 100644 drivers/staging/wilc1000/fw.h
 delete mode 100644 include/linux/b1pcmcia.h
 delete mode 100644 include/linux/iio/magnetometer/ak8975.h
 delete mode 100644 include/linux/platform_data/ads1015.h
 delete mode 100644 include/uapi/linux/b1lli.h
 delete mode 100644 include/uapi/linux/gigaset_dev.h
 delete mode 100644 include/uapi/linux/hysdn_if.h
