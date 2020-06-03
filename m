Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4896EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52262067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 08:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591171580;
	bh=qhW8fukSL5tal/Rfir1fPYqgY2A5EIe7J6nKMIZgbS8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=0UsfzKDoGvp5oyYLwzvjHDvfkMx9XmSY12DFRoxTJueOFpqXY4PRoGNM+sIrQOfTl
	 hJ8lpJgdCXUHAccVrXIM/xjraJ9OTPDzT/zpvr2WYxGTtzETdSlXR5SyAnRnS9lg6v
	 T91xObV2111t4kHrv2mhaSs2O9CBIQr0staOCGAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgFCIGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 04:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 04:06:18 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E19802067B;
        Wed,  3 Jun 2020 08:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591171565;
        bh=qhW8fukSL5tal/Rfir1fPYqgY2A5EIe7J6nKMIZgbS8=;
        h=Date:From:To:Cc:Subject:From;
        b=cdnMslGUN90U6L+25imKqPJRkfcs2KKTKfb6oFKtpKZrQi1Y0Q/iURNDu4lSThlqa
         il1WNf/i6CTyAvYaxt1iqzprkGBEHY6cIBZD23FsmyXpwu+wDnYhGVdqMWWe34vhNb
         UwprVIO5/C+TKdWBQO/2ZMA3umo4kj3yjKVqui3g=
Date:   Wed, 3 Jun 2020 10:05:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL for v5.8-rc1] media updates
Message-ID: <20200603100559.2718efba@coco.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.8-1

For:

  - Media documentation is now split into admin-guide, driver-api and
    userspace-api books (a longstanding request from Jon);
  - The media Kconfig was reorganized, in order to make easier to select
    drivers and their dependencies;
  - The testing drivers now has a separate directory;
  - added a new driver for Rockchip Video Decoder IP;
  - The atomisp staging driver was resurrected. It is meant to work with
    4 generations of cameras on Atom-based laptops, tablets and cell
    phones. So, it seems worth investing time to cleanup this driver and
    making it in good shape.
  - Added some V4L2 core ancillary routines to help with h264 codecs;
  - Added an ov2740 image sensor driver;
  - The si2157 gained support for Analog TV, which, in turn, added support
    for some cx231xx and cx23885 boards to also support analog standards;
  - Added some V4L2 controls (V4L2_CID_CAMERA_ORIENTATION and=20
    V4L2_CID_CAMERA_SENSOR_ROTATION) to help identifying where the camera
    is located at the device;
  - VIDIOC_ENUM_FMT was extended to support MC-centric devices;
  - Lots of drivers improvements and cleanups.

Thanks!
Mauro

PS.: The diffstat is so big that I almost dropped it, as it is almost
useless for humans to read. I ended by not doing it just because perhaps=20
you could be using some sort of script to check diffstat.

-


The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/me=
dia/v5.8-1

for you to fetch changes up to 938b29db3aa9c293c7c1366b16e55e308f1a1ddd:

  media: Documentation: media: Refer to mbus format documentation from CSI-=
2 docs (2020-05-25 15:47:02 +0200)

----------------------------------------------------------------
media updates for v5.8-rc1

----------------------------------------------------------------
Adrian Ratiu (1):
      media: coda: jpeg: support optimized huffman tables

Arnd Bergmann (1):
      media: ti-vpe: avoid gcc-9 warning

Bingbu Cao (6):
      media: staging/intel-ipu3: Implement lock for stream on/off operations
      media: doc-rst: add yavta test example in ipu3 docs
      media: ipu3.rst: add yuv-downscaling into pipeline diagram
      media: staging: imgu: do not hold spinlock during freeing mmu page ta=
ble
      media: ipu3.rst: add explanation for running mode
      media: i2c: Add ov2740 image sensor driver

Boris Brezillon (4):
      media: v4l2-core: Add helpers to build the H264 P/B0/B1 reflists
      media: hantro: h264: Use the generic H264 reflist builder
      media: dt-bindings: rockchip: Document RK3399 Video Decoder bindings
      media: rkvdec: Add the rkvdec driver

Brad Love (15):
      media: si2157: Enable tuner status flags
      media: si2157: Check error status bit on cmd execute
      media: si2157: Better check for running tuner in init
      media: si2157: Add analog tuning related functions
      media: si2157: Briefly wait for tuning operation to complete
      media: si2157: module debug option to wait on signal lock
      media: cx23885: Add analog frontend to Hauppauge QuadHD
      media: cx23885: Add analog frontend to 1265_K4
      media: cx23885: Add analog frontend to HVR5525
      media: cx23885: Add i2c device analog tuner support
      media: cx231xx: Add i2c device analog tuner support
      media: si2157: add on-demand rf strength func
      media: lgdt3306a: Add CNR v5 stat
      media: cx25840: Register labeling, chip specific correction
      media: dvbdev: Fix tuner->demod media controller link

Christophe JAILLET (2):
      media: m88ds3103: Add missing '\n' in log messages
      media: sun8i: Fix an error handling path in 'deinterlace_runtime_resu=
me()'

Colin Ian King (8):
      media: dvb: return -EREMOTEIO on i2c transfer failure.
      media: davinci: remove redundant assignment to pointer 'common'
      media: pwc-ctl: remove redundant assignment to variable ret
      media: gspca: remove redundant assignment to variable status
      media: dvb: remove redundant assignment to variable bw
      media: stv0900_core: remove redundant assignment to variable val
      media: mantis_dvb: remove redundant initialization to variable result
      media: dvb-frontends: remove redundant initialization of variable sta=
tus

Dafna Hirschfeld (24):
      media: v4l2-common: change the pixel_enc of V4L2_PIX_FMT_GREY to YUV
      media: doc-rst: in the RGB formats table add '-' in undefined bits
      media: v4l2-common: Add BGR666 to v4l2_format_info
      media: vimc: remove the function vimc_unregister
      media: vimc: handle error in vimc_add_subdevs
      media: vimc: keep the error value when adding an entity fails
      media: vimc: fix issues in documentation in vimc-common.h
      media: vimc: add vimc_ent_type struct for the callbacks of entities
      media: staging: rkisp1: remove TODO item - uapi structs compatibility
      media: staging: rkisp1: replace rkisp1_fmt_pix_type with v4l2_pixel_e=
ncoding
      media: staging: rkisp1: cap: remove field fmt_type from struct rkisp1=
_capture_fmt_cfg
      media: staging: rkisp1: change fields names from fmt_type to pixel_enc
      media: staging: rkisp1: remove mbus field from rkisp1_sensor_async
      media: staging: rkisp1: replace the call to v4l2_async_notifier_parse=
_fwnode_endpoints_by_port
      media: staging: rkisp1: cap: cleanup in mainpath config for uv swap f=
ormat
      media: staging: rkisp1: cap: fix value written to uv swap register in=
 selfpath
      media: staging: rkisp1: cap: change the logic for writing to uv swap =
register
      media: staging: rkisp1: cap: support uv swap only for semiplanar form=
ats
      media: staging: rkisp1: cap: support uv swapped planar formats
      media: staging: rkisp1: rsz: get the capture format info from the cap=
ture struct
      media: staging: rkisp1: rsz: remove redundant if statement and add in=
line doc
      media: staging: rkisp1: rsz: change (hv)div only if capture format is=
 YUV
      media: staging: rkisp1: cap: enable RGB capture format with YUV media=
 bus
      media: i2c: imx219: Fix a bug in imx219_enum_frame_size

Dan Carpenter (2):
      media: vicodec: Fix error codes in probe function
      media: cec: silence shift wrapping warning in __cec_s_log_addrs()

Deepak R Varma (3):
      media: staging/intel-ipu3: css: simplify expression
      media: staging/intel-ipu3: Remove extra blank lines
      media: staging/intel-ipu3: Simplify single goto jump

Dirk Nehring (1):
      media: dvb-usb: Add Cinergy S2 PCIe Dual Port support

Dongchun Zhu (1):
      media: dt-bindings: ov8856: Document YAML bindings

Ezequiel Garcia (13):
      media: v4l2-mem2mem: return CAPTURE buffer first
      media: hantro: Set buffers' zeroth plane payload in .buf_prepare
      media: hantro: Use v4l2_m2m_buf_done_and_job_finish
      media: hantro: Remove unneeded hantro_dec_buf_finish
      media: hantro: Move H264 motion vector calculation to a helper
      media: hantro: Refactor for V4L2 API spec compliancy
      media: dt-bindings: rockchip-vpu: Convert bindings to json-schema
      media: vim2m: Remove unneeded buffer lock
      media: Kconfig: Don't expose the Request API option
      media: rkisp1: Get rid of unused variable warning
      media: phy-rockchip-dphy-rx0: Drop unneeded CONFIG_OF dependency
      media: rkisp1: Fix wrong PHY config dependency
      media: MAINTAINERS: Fix Hantro, Rga and Rkvdec entries

Fabio Estevam (5):
      media: imx-media-csc-scaler: Use a shorter name for driver
      media: imx.rst: Fix the MIPI CSI-2 virtual channel
      media: imx.rst: Provide an example for unprocessed video capture
      media: imx.rst: Provide the OV560 module part number
      media: imx.rst: Provide streaming examples for imx6q-sabresd

Geert Uytterhoeven (2):
      media: media: sh_veu: Remove driver
      media: i2c: imx219: Drop <linux/clk-provider.h> and <linux/clkdev.h>

Greg Kroah-Hartman (1):
      media: staging: media: imx: no need to check return value of debugfs_=
create functions

Guillaume Tucker (1):
      media: Kconfig: include test_drivers with MEDIA_TEST_SUPPORT

Guru Das Srinagesh (1):
      media: ir-rx51: Use 64-bit division macro

Gustavo A. R. Silva (3):
      media: venus: hfi_cmds.h: Replace zero-length array with flexible-arr=
ay member
      media: venus: hfi_msgs.h: Replace zero-length array with flexible-arr=
ay member
      media: s5k5baf: Replace zero-length array with flexible-array

Hans Verkuil (11):
      media: Documentation/media: drop/fix vivi references
      media: media/test_drivers: rename to test-drivers
      media: v4l2-ctrls: v4l2_ctrl_g/s_ctrl*(): don't continue when WARN_ON
      media: v4l2-ctrls: add __v4l2_ctrl_s_ctrl_compound()
      media: rkisp1: fix missing mbus.type -> mbus_type conversion
      media: vidioc-reqbufs/create-bufs.rst: fix typo
      media: cec-gpio: handle gpiod_get_value errors correctly
      media: v4l2-ctrls.h: clarify the p_def argument of v4l2_ctrl_new_std_=
compound
      media: vidioc-enum-fmt.rst: make the ENUM_FMT text clearer
      media: v4l2-subdev: add VIDIOC_SUBDEV_QUERYCAP ioctl
      media: v4l: document VIDIOC_SUBDEV_QUERYCAP

Helen Koike (5):
      media: Makefile: fix test drivers compilation
      media: staging: rkisp1: cap: fix return values from pm functions
      media: staging: rkisp1: cap: serialize start/stop stream
      media: staging: dt-bindings: phy-rockchip-dphy-rx0: remove non-used r=
eg property
      media: dt-bindings: phy: phy-rockchip-dphy-rx0: move rockchip dphy rx=
0 bindings out of staging

Hsin-Yi Wang (1):
      media: mtk-mdp: Use correct aliases name

Jacopo Mondi (17):
      media: Documentation: media: Update sub-device API intro
      media: Documentation: media: Document read-only subdevice
      media: v4l2-dev: Add v4l2_device_register_ro_subdev_node()
      media: v4l2-subdev: Guard whole fops and ioctl hdlr
      media: i2c: imx219: Implement get_selection
      media: dt-bindings: video-interfaces: Document 'orientation' property
      media: dt-bindings: video-interface: Replace 'rotation' description
      media: v4l2-ctrl: Document V4L2_CID_CAMERA_ORIENTATION
      media: v4l2-ctrl: Document V4L2_CID_CAMERA_SENSOR_ROTATION
      media: v4l2-ctrls: Add camera orientation and rotation
      media: v4l2-fwnode: Add helper to parse device properties
      media: include: v4l2-ctrl: Sort forward declarations
      media: v4l2-ctrls: Sort includes alphabetically
      media: v4l2-ctrls: Add helper to register properties
      media: i2c: ov5670: Parse and register properties
      media: i2c: ov13858: Parse and register properties
      media: i2c: imx219: Parse and register properties

Jia-Ju Bai (1):
      media: usb: ttusb-dec: reduce the number of memory reads in ttusb_dec=
_handle_irq()

Johan Jonker (3):
      media: dt-bindings: media: convert rockchip rga bindings to yaml
      media: dt-bindings: media: rockchip-rga: add power-domains property
      media: dt-bindings: media: rockchip-vpu: fix interrupt-names

John Oldman (1):
      media: staging: media: usbvision: usbvision-core Correct spelling

Kieran Bingham (1):
      media: platform: fcp: Set appropriate DMA parameters

Koji Matsuoka (1):
      media: rcar-csi2: Fix comment of VCDT/VCDT2 register

Laurent Pinchart (21):
      media: imx: imx7-mipi-csis: Cleanup and fix subdev pad format handling
      media: imx: imx7-mipi-csis: Centralize initialization of pad formats
      media: imx: imx7-mipi-csis: Add missing RAW formats
      media: imx: imx7-mipi-csis: Expose correct YUV formats
      media: imx: imx7-mipi-csis: Fix MEDIA_BUS_FMT_UYVY8_2X8 data alignment
      media: imx: imx7-mipi-csis: Add MEDIA_BUS_FMT_UYVY10_2X10 support
      media: imx: imx7-mipi-csis: Rename data_alignment field to width
      media: imx: imx7-mipi-csis: Align image width based on format
      media: imx: imx7-mipi-csis: Never set MIPI_CSIS_ISPCFG_ALIGN_32BIT
      media: imx: imx7-mipi-csis: Align macro definitions
      media: imx: imx7-mipi-csis: Remove link setup on source pad
      media: imx: imx7-mipi-csis: Cleanup includes
      media: imx: imx7-mipi-csis: Don't use imx-media-utils helpers
      media: imx: imx7-mipi-csis: Implement the .enum_mbus_code() operation
      media: imx: utils: Inline init_mbus_colorimetry() in its caller
      media: imx: utils: Handle Bayer format lookup through a selection flag
      media: imx: utils: Make imx_media_pixfmt handle variable number of co=
des
      media: imx: utils: Rename format lookup and enumeration functions
      media: imx: utils: Constify some mbus and ipu_image arguments
      media: pci: Fill v4l2_fmtdesc with designated initializers
      media: v4l2: Extend VIDIOC_ENUM_FMT to support MC-centric devices

Lukas Bulwahn (1):
      media: MAINTAINERS: adjust entries to moving CEC USB drivers

Maheshwar Ajja (2):
      media: v4l2-ctrl: Add H264 profile and levels
      media: uapi: h264: Add new profile and levels

Mansur Alisha Shaik (1):
      media: venus: core: remove CNOC voting while device suspend

Marco Felsch (1):
      media: v4l2-image-sizes: add HD and Full-HD definitions

Mauro Carvalho Chehab (242):
      media: dvb-usb: auto-select CYPRESS_FIRMWARE
      media: Kconfig: add an option to filter in/out platform drivers
      media: Kconfig: not all V4L2 platform drivers are for camera
      media: pci: move VIDEO_PCI_SKELETON to a different Kconfig
      media: Kconfig: update the MEDIA_SUPPORT help message
      media: split test drivers from platform directory
      media: Kconfig: move comment to siano include
      media: Kconfig: move drivers-specific TTPCI_EEPROM Kconfig var
      media: Kconfig: mode firewire comment to firewire/Kconfig
      media: ddbridge: copy the dvb_dummy_fe driver to ddbridge
      media: ddbridge-dummy_fe: do some vars and function renames
      media: ddbridge: use the ddbridge's own dummy fe driver
      media: Kconfig: mark other drivers as test drivers
      media: Kconfig: simplify some dependencies
      media: Kconfig: better support hybrid TV devices
      media: Kconfig: fix selection for test drivers
      media: add SPDX headers on Kconfig and Makefile files
      media: dvb-core: Kconfig: default to use dynamic minors
      media: Kconfig files: use select for V4L2 subdevs and MC
      media: Kconfig: reorganize the drivers menu options
      media: Kconfig: use a sub-menu to select supported devices
      media: Kconfig: make filtering devices optional
      media: Kconfig: warn if drivers are filtered
      media: Kconfig: move CEC-specific options to cec/Kconfig
      media: Kconfig: move DVB-specific options to dvb-core/Kconfig
      media: Kconfig: move V4L2 subdev API to v4l2-core/Kconfig
      media: Kconfig: move media controller core select to main Kconfig
      media: Kconfig: place all options under a sub-menu
      media: Kconfig: move the position of sub-driver autoselection
      media: Kconfig: on !EMBEDDED && !EXPERT, enable driver filtering
      media: Kconfig: Better organize the per-API options
      media: i2c/Kconfig: reorganize items there
      media: Kconfig: don't use visible for device type select
      media: docs: avermedia.rst: mark a table as such
      media: docs: move soc-camera.rst to staging
      media: docs: split cpia2.rst on two files
      media: docs: split ci.rst into uAPI and user guide docs
      media: docs: split meye.rst into admin and uAPI docs
      media: docs: split vimc.rst into devel and admin parts
      media: docs: split development info from bttv.rst
      media: docs: split development info from cx88.rst
      media: docs: split cx2341x.rst into different audiences
      media: docs: cx18-streams.c: fix broken references to docs
      media: docs: split uAPI info from davinci-vpbe.rst
      media: docs: split uAPI info from fimc.rst
      media: docs: split uAPI info from saa7134-devel.rst
      media: docs: split uAPI info from omap3isp.rst
      media: docs: split uAPI info from imx.rst
      media: docs: move uAPI book to userspace-api/media
      media: docs: kAPI docs: move them to driver-api
      media: docs: move fourcc file to the uAPI document
      media: docs: move user-facing docs to the admin guide
      media: docs: move driver-specific info to driver-api
      media: docs: add an uAPI chapter for driver-specific stuff
      media: docs: get rid of Documentation/media/
      Revert "media: Kconfig: better support hybrid TV devices"
      media: vimc: fix kernel-doc markups
      media: docs: fix some broken references
      Revert "media: Kconfig: move CEC-specific options to cec/Kconfig"
      media: Kconfig: DVB support should be enabled for Digital TV
      media: cec: move the core to a separate directory
      media: place CEC menu before MEDIA_SUPPORT
      media: move CEC platform drivers to a separate directory
      media: move CEC USB drivers to a separate directory
      media: cec: rename CEC platform drivers config options
      media: docs: update cardlists
      media: docs: split avermedia.rst contents on two files
      media: docs: dvb_intro.rst: update its contents
      media: docs: intro.rst actually contain DVB references
      media: docs: update avermedia.rst contents
      media: docs: bt8xx.rst: update document info
      media: docs: update bttv.rst information
      media: docs: add a cardlist for cx18 boards
      media: docs: cpia2.rst: do some cleanups
      media: docs: update Digital TV faq.rst
      media: docs: saa7134.rst: update the documentation
      media: docs: zr364xx: update documentation
      media: docs: get rid of obsoleted udev documentation
      media: docs: Add a master topic for the index file
      media: docs: cleanup bttv-devel.rst file
      media: docs: fix references for vimc
      media: docs: move copyrights to the end and update them
      media: docs: add GPLv2 for uAPI guide
      media: docs: add cros-references to the other media guides
      media: i2c/Kconfig: use sub-menus for I2C support
      media: radio: don't use a menu just for wl128x driver
      media: cec: don't select PCI & DMI
      media: mc/Kconfig: remove staging dependency for request API
      media: cec/usb: depends on USB_SUPPORT and TTY
      media: dvb-frontends: DUMMY_FE should depends on DVB_CORE
      Merge tag 'v5.7-rc2' into patchwork
      media: staging: rkisp1 Kconfig: depends on OF
      media: usbvision: depends on USB
      media: dvb-usb-ids.h: fix an USB PID name
      media: dvb-usb-v2: use DVB_USB_DEVICE() macro
      media: pwc-if.c: Update comments about each pwc supported model
      media: pwc-if: place USB device list on numberical order
      media: admin-guide: add a card list for cx231xx boards
      media: admin-guide: update em28xx cardlist
      media: admin-guide: Add an introduction chapter
      media: admin-guide: add a generic building guide
      media: admin-guide: improve cardlist.rst documentation
      media: admin-guide: add dvb-usb-v2 card lists
      media: admin-guide: add cardlist for dib0700 driver
      media: admin-guide: add dibusb-mb and dibusb-mc card lists
      media: admin-guide: add support for the remaining dvb-usb boards
      media: admin-guide: add a card list for the Siano driver
      media: admin-guide: add a cardlist for all other USB cards
      media: admin-guide: split DVB cards.rst
      media: admin-guide: replace the frontend drivers list
      media: admin-guide: add a list of media PCI cards
      media: admin-guide: add a table with USB drivers
      media: admin-guide: add a list of platform drivers
      media: admin-guide: add a list of I2C drivers
      media: admin-guide: add SPI cards to platform drivers
      media: admin-guide: add card lists for radio and firewire
      media: admin-guide: add test-drivers
      media: admin-guide: bt8xx.rst: fix a broken cross-reference
      media: admin-guide: reorganize the guide
      media: admin-guide: split driver-specific indexes to new files
      MAINTAINERS: reorder media attributes
      media: tuners: Kconfig: add some missing VIDEO_V4L2 dependencies
      media: platform: fix VIA_CAMERA dependencies
      media: Kconfig: fix some dvb-usb-v2 dependencies
      media: admin-guide: make clear about PCI subsystem IDs
      media: admin-guide: split cardlist.rst file
      media: ipu3.rst: fix a build warning
      Revert "media: staging: atomisp: Remove driver"
      MAINTAINERS: adjust atomisp maintainership
      media: atomisp: fix usage of access_ok() kAPI
      media: atomisp: totalram_pages is now a function
      media: atomisp: replace VFL_TYPE_GRABBER by VFL_TYPE_VIDEO
      media: atomisp: Fix support for time 64 API
      media: atomisp: use cpu_latency_qos_*() instead of pm_qos_update*()
      media: atomisp: use new ida API
      media: atomisp: fix a broken compat32 code
      media: atomisp: allow building the driver again
      media: atomisp: select IOSF_MBI dependency
      media: atomisp: fix several typos
      media: atomisp: fix several coding style issues
      media: atomisp: do lots of other coding style cleanups
      media: atomisp: remove some dead code
      media: atomisp: simplify math_support.h
      media: atomisp: add a way for the driver to know the chipset version
      media: atomisp: atomisp_cmd.c test ISP version in runtime
      media: atomisp: atomisp_dfs_tables.h: don't depend on ISP version
      media: atomisp: pci/atomisp2/*.h remove #ifdef ISP2401
      media: atomisp: atomisp_ioctl.c: get rid of a ISP2400/ISP2401 depende=
ncy
      media: atomisp: atomisp_v4l2.c: set wdt timers according with ISP ver=
sion
      media: atomisp: atomisp_subdev.c check ISP version on runtime
      media: atomisp: atomisp_csi2.c: remove useless ifdefs
      media: atomisp: atomisp_compat_css20.c: detect ISP at runtime
      media: atomisp: atomisp_compat_ioctl32.c: be independent of ISP versi=
on
      media: atomisp: sh_css_defs.h: get rid of build time dependencies
      media: atomisp: make sh_css_struct.h independent of ISP version
      media: atomisp: make sh_css_sp_init_pipeline() ISP version independent
      media: atomisp: remove ISP version macros from sh_css_legacy.h
      media: atomisp: remove table duplication from dfs tables
      media: atomisp: unify sh_css_params_shading_id_table_generate()
      media: atomisp: sh_css_param_dvs.h remove ISP version macros
      media: atomisp: print css_version in runtime
      media: atomisp: add support for possible new names
      media: atomisp: css_trace.h: use the newest tracing code
      media: atomisp: ia_css_binary_get_shading_info(): don't test version
      media: atomisp: get rid of some non-existing functions for ISP2401
      media: atomisp: make util.c work with ISP2401 runtime detection
      media: atomisp: sh_css: detect ISP version at runtime
      media: atomisp: isp_const.h: get rid of an unused big define list
      media: atomisp: get rid of several typedef-style defines
      media: atomisp: get rid of trivial ISP2401 dependencies on header fil=
es
      media: atomisp: get rid of unused header files
      media: atomisp: remove unused definitions at */isp_capture_defs.h
      media: atomisp: remove several duplicated files
      media: atomisp: remove unused hive_isp_css_host_ids_hrt.h
      media: atomisp: hive_isp_css_defs.h: keep just one copy of it
      media: atomisp: get finish de-duplication of hrt/hive*.h
      media: atomisp: add Asus Transform T101HA ACPI vars
      media: atomisp: use regulator_get_optional() for first attempt
      media: atomisp: remove bayer_io_ls duplication
      media: atomisp: rename anr2 param header file
      media: atomisp: get rid of io_ls/ subdir
      media: atomisp: remove unused duplicated files
      media: atomisp: get rid of trivial version checks at *.h
      media: atomisp: get rid of ia_css_sc_param.h version dependency
      media: atomisp: get rid of ISP_VMEM_IS_BAMEM unused defines
      media: atomisp: get rid of __ISP define tests
      media: atomisp: make all file names unique at atomisp driver
      media: atomisp: simplify makefiles
      media: atomisp: cleanup directory hierarchy
      media: atomisp: get rid of some broken code
      media: atomisp: change function worders and fix include
      media: atomisp: allow building for isp2401
      media: atomisp: cleanup contents of css_2400_system/
      media: atomisp: cleanup contents of css_2401_csi2p_system
      media: atomisp: cleanup contents of css_2401_system
      media: atomisp: get rid of most checks for ISP2401 version
      media: atomisp: add firmware load code for ISP2401 rev B0
      media: atomisp: remove some file duplication and do more dir renames
      media: atomisp: use add_qos_request instead of update
      media: atomisp: fix querycap initialization logic
      media: atomisp: move ia_css_configure_sc() implementation
      media: atomisp: disable the dummy PM driver is atomisp driver is built
      media: atomisp: print a better message when fw version is wrong
      media: atomisp: limit the name of the firmware file
      media: atomisp: fix clock rate frequency setting
      media: atomisp: improve device detection code
      media: atomisp: relax firmware version detection criteria
      media: atomisp: free PCI resources when probing fail
      media: atomisp: make dfs_config_merr_117a struct const
      media: atomisp: add -dDEBUG when building this driver
      media: atomisp: Add some ACPI detection info
      media: atomisp: better display DMI and EFI found entries
      media: atomisp: print the type of PMIC that will be used
      media: atomisp: reduce the risk of a race condition
      media: atomisp: warn if unsupported subdevs are found
      media: atomisp: detect the PMIC type
      media: atomisp: move atomisp_gmin_platform.c to pci/ dir
      media: atomisp: add support for different PMIC configurations
      media: atomisp: spctrl: be sure to zero .code_addr after free
      media: atomisp: use pcim_enable_device() again
      media: atomisp: simplify the power down/up code
      media: atomisp: remove a misplaced #endif
      media: atomisp: fix an inverted logic
      media: atomisp: get rid of spmem_dump.c
      media: atomisp: get rid of __bo_alloc() macro
      media: atomisp: fix a slab error due to a wrong free
      media: atomisp: fix the value for CamClk on Asus T101HA
      media: atomisp: keep the ISP powered on when setting it
      media: atomisp: change the code to properly wait for sensor
      media: atomisp: ov2680: improve debug messages
      media: atomisp: use read/write routines from mainstream
      media: atomisp-ov2680: get rid of the type field
      media: atomisp: simplify ov2680 array write logic
      media: atomisp: turn on camera before setting it
      media: atomisp: disable the dynamic and reserved pools
      media: atomisp: add a notice about possible leak resources
      media: atomisp: isp_mmu: don't use kmem_cache
      media: atomisp: print IRQ when debugging
      media: atomisp: don't produce errs for ignored IRQs
      media: atomisp: adjust some code at sh_css that could be broken
      media: atomisp: update TODO with the current data
      media: atomisp: unify the version for isp2401 a0 and b0 versions

Maxime Jourdan (1):
      media: meson: vdec: enable mcrcc for VP9

Neil Armstrong (1):
      media: MAINTAINERS: update the Amlogic VDEC driver maintainer entry

Niklas S=C3=B6derlund (5):
      media: vimc: cap: Report a colorspace
      media: v4l2-dev/ioctl: Add V4L2_CAP_IO_MC
      media: rcar-vin: Make use of V4L2_CAP_IO_MC
      media: staging/intel-ipu3: Make use of V4L2_CAP_IO_MC
      media: vimc: Make use of V4L2_CAP_IO_MC

N=C3=ADcolas F. R. A. Prado (3):
      media: vimc: Support multiple media bus codes for each pixelformat
      media: vimc: Add missing {RGB,BGR,GBR}888 media bus codes
      media: vimc: deb: Add support for {RGB,BGR,GBR}888 bus formats on sou=
rce pad

Philipp Zabel (9):
      media: coda: round up decoded buffer size for all codecs
      media: add v4l2 JPEG helpers
      media: coda: jpeg: add CODA960 JPEG decoder support
      media: coda: split marking last meta into helper function
      media: coda: mark last capture buffer
      media: coda: lock capture queue wakeup against decoder stop command
      media: imx: utils: fix and simplify pixel format enumeration
      media: imx: utils: fix media bus format enumeration
      media: coda: add RC enable controls

Robert Foss (2):
      media: ov8856: Add devicetree support
      media: ov8856: Implement sensor module revision identification

Sakari Ailus (5):
      media: MAINTAINERS: ipu3-imgu: Add Tian Shu and Bingbu as reviewers
      media: Revert "staging: imgu: Address a compiler warning on alignment"
      media: staging: ipu3-imgu: Move alignment attribute to field
      media: staging: ipu3-imgu: Add a sanity check for the parameter struc=
t size
      media: Documentation: media: Refer to mbus format documentation from =
CSI-2 docs

Sean Young (9):
      media: dvb: digitv: remove unused array element 0
      media: rc: if kernel is built without an IR codec, don't advertise it
      media: dvb-usb: make dvb_usb_device_properties const
      media: iguanair: rc drivers no longer need to do locking
      media: m88ds3103: error in set_frontend is swallowed and not reported
      media: rc: no need for decoder state if decoder not enabled
      media: si2157: ensure wait_status is initialized
      media: gpio-ir-tx: improve precision of transmitted signal due to sch=
eduling
      media: gpio-ir-tx: allow transmission without carrier

Seungchul Kim (1):
      media: v4l2-fh: define v4l2_fh struct regardless of condition

Stanimir Varbanov (9):
      media: venus: vdec: Use pmruntime autosuspend
      media: venus: core: Add missing mutex destroy
      media: venus: core: Fix mutex destroy in remove
      media: venus: core: Constify codec frequency data array
      media: venus: helpers: Done buffers per queue type
      media: venus: vdec: Mark flushed buffers with error state
      media: venus: vdec: Init registered list unconditionally
      media: venus: Mark last capture buffer
      media: venus: venc,vdec: Return EBUSY on S_FMT while streaming

Steve Longerbeam (28):
      media: imx.rst: Add example media graphs
      media: imx: Fix some pixel format selections
      media: imx: utils: Rename pixel format selection enumeration
      media: imx: utils: Introduce PIXFMT_SEL_IPU
      media: imx: utils: Split find|enum_format into fourcc and mbus functi=
ons
      media: imx: utils: Default colorspace to SRGB
      media: entity: Pass entity to get_fwnode_pad operation
      media: v4l2-subdev: add v4l2_subdev_get_fwnode_pad_1_to_1
      media: v4l2-mc: add v4l2_create_fwnode_links helpers
      media: video-mux: Parse information from firmware without using callb=
acks
      media: imx: Parse information from firmware without using callbacks
      media: Revert "media: v4l2-fwnode: Add a convenience function for reg=
istering subdevs with notifiers"
      media: imx: csi: Implement get_fwnode_pad op
      media: video-mux: Implement get_fwnode_pad op
      media: imx: mipi csi-2: Implement get_fwnode_pad op
      media: imx: imx7-mipi-csis: Implement get_fwnode_pad op
      media: imx: imx7-media-csi: Implement get_fwnode_pad op
      media: video-mux: Create media links in bound notifier
      media: imx: mipi csi-2: Create media links in bound notifier
      media: imx7: mipi csis: Create media links in bound notifier
      media: imx7: csi: Create media links in bound notifier
      media: imx: csi: Create media links in bound notifier
      media: imx7: csi: Remove imx7_csi_get_upstream_endpoint()
      media: imx5/6/7: csi: Mark a bound video mux as a CSI mux
      media: imx: csi: Lookup upstream endpoint with imx_media_get_pad_fwno=
de
      media: imx: Create missing links from CSI-2 receiver
      media: imx: silence a couple debug messages
      media: imx: TODO: Remove media link creation todos

Tomasz Figa (1):
      media: staging: ipu3: Fix stale list entries on parameter queue failu=
re

Tomi Valkeinen (20):
      media: ov5640: fix use of destroyed mutex
      media: ti-vpe: cal: fix DMA memory corruption
      media: ti-vpe: cal: improve enable_irqs
      media: ti-vpe: cal: fix use of wrong macro
      media: ti-vpe: cal: use runtime_resume for errata handling
      media: ti-vpe: cal: drop cal_runtime_get/put
      media: ti-vpe: cal: catch error irqs and print errors
      media: ti-vpe: cal: print errors on timeouts
      media: ti-vpe: cal: simplify irq handling
      media: ti-vpe: cal: remove useless CAL_GEN_* macros
      media: ti-vpe: cal: remove useless IRQ defines
      media: ti-vpe: cal: use reg_write_field
      media: ti-vpe: cal: cleanup CIO power enable/disable
      media: ti-vpe: cal: fix dummy read to phy
      media: ti-vpe: cal: program number of lines properly
      media: ti-vpe: cal: set DMA max seg size
      media: ti-vpe: cal: move code to separate functions
      media: ti-vpe: cal: improve wait for CIO resetdone
      media: ti-vpe: cal: improve wait for stop-state
      media: ti-vpe: cal: fix stop state timeout

Wolfram Sang (6):
      media: pci: cx88: convert to use i2c_new_client_device()
      media: pci: saa7134: convert to use i2c_new_client_device()
      media: marvell-ccic: convert to use i2c_new_client_device()
      media: usb: cx231xx: convert to use i2c_new_client_device()
      media: usb: hdpvr: convert to use i2c_new_client_device()
      media: usb: pvrusb2: convert to use i2c_new_client_device()

Zou Wei (1):
      media: cx231xx: Remove unneeded semicolon

 Documentation/ABI/testing/debugfs-cec-error-inj    |     2 +-
 Documentation/Makefile                             |    10 +-
 Documentation/admin-guide/index.rst                |     1 +
 Documentation/admin-guide/kernel-parameters.txt    |     4 +-
 .../media}/au0828-cardlist.rst                     |     0
 Documentation/admin-guide/media/avermedia.rst      |    94 +
 Documentation/admin-guide/media/bt8xx.rst          |   156 +
 Documentation/admin-guide/media/bttv-cardlist.rst  |   683 ++
 Documentation/admin-guide/media/bttv.rst           |  1761 +++
 Documentation/admin-guide/media/building.rst       |   357 +
 .../media}/cafe_ccic.rst                           |     0
 Documentation/admin-guide/media/cardlist.rst       |    29 +
 Documentation/admin-guide/media/cec-drivers.rst    |    10 +
 Documentation/admin-guide/media/ci.rst             |    77 +
 Documentation/admin-guide/media/cpia2.rst          |   145 +
 Documentation/admin-guide/media/cx18-cardlist.rst  |    17 +
 .../admin-guide/media/cx231xx-cardlist.rst         |    99 +
 .../admin-guide/media/cx23885-cardlist.rst         |   267 +
 Documentation/admin-guide/media/cx88-cardlist.rst  |   383 +
 Documentation/admin-guide/media/cx88.rst           |    58 +
 Documentation/admin-guide/media/davinci-vpbe.rst   |    65 +
 Documentation/admin-guide/media/dvb-drivers.rst    |    16 +
 .../admin-guide/media/dvb-usb-a800-cardlist.rst    |    16 +
 .../admin-guide/media/dvb-usb-af9005-cardlist.rst  |    20 +
 .../admin-guide/media/dvb-usb-af9015-cardlist.rst  |    80 +
 .../admin-guide/media/dvb-usb-af9035-cardlist.rst  |    74 +
 .../admin-guide/media/dvb-usb-anysee-cardlist.rst  |    16 +
 .../admin-guide/media/dvb-usb-au6610-cardlist.rst  |    16 +
 .../admin-guide/media/dvb-usb-az6007-cardlist.rst  |    20 +
 .../admin-guide/media/dvb-usb-az6027-cardlist.rst  |    24 +
 .../admin-guide/media/dvb-usb-ce6230-cardlist.rst  |    18 +
 .../media/dvb-usb-cinergyT2-cardlist.rst           |    16 +
 .../admin-guide/media/dvb-usb-cxusb-cardlist.rst   |    40 +
 .../admin-guide/media/dvb-usb-dib0700-cardlist.rst |   162 +
 .../media/dvb-usb-dibusb-mb-cardlist.rst           |    42 +
 .../media/dvb-usb-dibusb-mc-cardlist.rst           |    30 +
 .../admin-guide/media/dvb-usb-digitv-cardlist.rst  |    16 +
 .../admin-guide/media/dvb-usb-dtt200u-cardlist.rst |    22 +
 .../admin-guide/media/dvb-usb-dtv5100-cardlist.rst |    16 +
 .../admin-guide/media/dvb-usb-dvbsky-cardlist.rst  |    42 +
 .../admin-guide/media/dvb-usb-dw2102-cardlist.rst  |    52 +
 .../admin-guide/media/dvb-usb-ec168-cardlist.rst   |    16 +
 .../admin-guide/media/dvb-usb-gl861-cardlist.rst   |    20 +
 .../admin-guide/media/dvb-usb-gp8psk-cardlist.rst  |    22 +
 .../admin-guide/media/dvb-usb-lmedm04-cardlist.rst |    20 +
 .../admin-guide/media/dvb-usb-m920x-cardlist.rst   |    26 +
 .../media/dvb-usb-mxl111sf-cardlist.rst            |    36 +
 .../media/dvb-usb-nova-t-usb2-cardlist.rst         |    16 +
 .../admin-guide/media/dvb-usb-opera1-cardlist.rst  |    16 +
 .../media/dvb-usb-pctv452e-cardlist.rst            |    20 +
 .../media/dvb-usb-rtl28xxu-cardlist.rst            |    80 +
 .../media/dvb-usb-technisat-usb2-cardlist.rst      |    16 +
 .../admin-guide/media/dvb-usb-ttusb2-cardlist.rst  |    24 +
 .../admin-guide/media/dvb-usb-umt-010-cardlist.rst |    16 +
 .../admin-guide/media/dvb-usb-vp702x-cardlist.rst  |    16 +
 .../admin-guide/media/dvb-usb-vp7045-cardlist.rst  |    18 +
 .../admin-guide/media/dvb-usb-zd1301-cardlist.rst  |    16 +
 Documentation/admin-guide/media/dvb.rst            |    12 +
 Documentation/admin-guide/media/dvb_intro.rst      |   616 +
 Documentation/admin-guide/media/dvb_references.rst |    29 +
 .../admin-guide/media/em28xx-cardlist.rst          |   436 +
 Documentation/admin-guide/media/faq.rst            |   216 +
 Documentation/admin-guide/media/fimc.rst           |   153 +
 .../admin-guide/media/frontend-cardlist.rst        |   226 +
 .../media}/gspca-cardlist.rst                      |     0
 Documentation/admin-guide/media/i2c-cardlist.rst   |   290 +
 Documentation/admin-guide/media/imx.rst            |   714 ++
 .../admin-guide/media/imx6q-sabreauto.dot          |    51 +
 Documentation/admin-guide/media/imx6q-sabresd.dot  |    56 +
 .../v4l-drivers =3D> admin-guide/media}/imx7.rst     |     0
 Documentation/admin-guide/media/index.rst          |    61 +
 Documentation/admin-guide/media/intro.rst          |    27 +
 Documentation/admin-guide/media/ipu3.rst           |   591 +
 .../v4l-drivers =3D> admin-guide/media}/ipu3_rcb.svg |     0
 Documentation/admin-guide/media/ivtv-cardlist.rst  |   139 +
 .../v4l-drivers =3D> admin-guide/media}/ivtv.rst     |     0
 .../dvb-drivers =3D> admin-guide/media}/lmedm04.rst  |     0
 Documentation/admin-guide/media/meye.rst           |    93 +
 Documentation/admin-guide/media/misc-cardlist.rst  |    28 +
 Documentation/admin-guide/media/omap3isp.rst       |    92 +
 .../media}/omap4_camera.rst                        |     0
 .../media}/opera-firmware.rst                      |     0
 .../admin-guide/media/other-usb-cardlist.rst       |    92 +
 Documentation/admin-guide/media/pci-cardlist.rst   |   107 +
 .../v4l-drivers =3D> admin-guide/media}/philips.rst  |     0
 .../admin-guide/media/platform-cardlist.rst        |    90 +
 .../media}/pulse8-cec.rst                          |     0
 .../media}/qcom_camss.rst                          |     0
 .../media}/qcom_camss_8x96_graph.dot               |     0
 .../media}/qcom_camss_graph.dot                    |     0
 Documentation/admin-guide/media/radio-cardlist.rst |    44 +
 .../media}/rcar-fdp1.rst                           |     0
 .../admin-guide/media/remote-controller.rst        |    76 +
 .../admin-guide/media/saa7134-cardlist.rst         |   803 ++
 Documentation/admin-guide/media/saa7134.rst        |    88 +
 .../admin-guide/media/saa7164-cardlist.rst         |    71 +
 .../v4l-drivers =3D> admin-guide/media}/si470x.rst   |     0
 .../v4l-drivers =3D> admin-guide/media}/si4713.rst   |     0
 .../v4l-drivers =3D> admin-guide/media}/si476x.rst   |     0
 Documentation/admin-guide/media/siano-cardlist.rst |    56 +
 .../media}/technisat.rst                           |     0
 .../media}/tm6000-cardlist.rst                     |     0
 .../media}/ttusb-dec.rst                           |     0
 .../media}/tuner-cardlist.rst                      |     0
 Documentation/admin-guide/media/usb-cardlist.rst   |   157 +
 .../media}/usbvision-cardlist.rst                  |     0
 Documentation/admin-guide/media/v4l-drivers.rst    |    33 +
 .../v4l-drivers =3D> admin-guide/media}/vimc.dot     |     0
 Documentation/admin-guide/media/vimc.rst           |    90 +
 .../v4l-drivers =3D> admin-guide/media}/vivid.rst    |     0
 Documentation/admin-guide/media/zr364xx.rst        |   102 +
 .../devicetree/bindings/media/i2c/ov8856.yaml      |   142 +
 .../devicetree/bindings/media/rockchip,vdec.yaml   |    73 +
 .../devicetree/bindings/media/rockchip-rga.txt     |    34 -
 .../devicetree/bindings/media/rockchip-rga.yaml    |    83 +
 .../devicetree/bindings/media/rockchip-vpu.txt     |    43 -
 .../devicetree/bindings/media/rockchip-vpu.yaml    |    77 +
 .../devicetree/bindings/media/video-interfaces.txt |   372 +-
 .../bindings/phy/rockchip-mipi-dphy-rx0.yaml       |    73 +
 Documentation/doc-guide/parse-headers.rst          |     2 +-
 Documentation/driver-api/index.rst                 |     1 +
 .../{media/kapi =3D> driver-api/media}/cec-core.rst  |     0
 Documentation/driver-api/media/csi2.rst            |    91 +
 .../driver-api/media/drivers/bttv-devel.rst        |   116 +
 .../media/drivers}/contributors.rst                |     0
 .../driver-api/media/drivers/cpia2_devel.rst       |    56 +
 .../driver-api/media/drivers/cx2341x-devel.rst     |  3685 ++++++
 .../driver-api/media/drivers/cx88-devel.rst        |   113 +
 .../media/drivers/davinci-vpbe-devel.rst           |    39 +
 .../media/drivers}/dvb-usb.rst                     |     0
 .../driver-api/media/drivers/fimc-devel.rst        |    33 +
 .../media/drivers}/frontends.rst                   |     0
 Documentation/driver-api/media/drivers/index.rst   |    38 +
 .../media/drivers}/pvrusb2.rst                     |     0
 .../media/drivers}/pxa_camera.rst                  |     0
 .../media/drivers}/radiotrack.rst                  |     0
 .../driver-api/media/drivers/saa7134-devel.rst     |    67 +
 .../media/drivers}/sh_mobile_ceu_camera.rst        |     0
 .../media/drivers}/tuners.rst                      |     0
 .../driver-api/media/drivers/vimc-devel.rst        |    15 +
 .../{media/kapi =3D> driver-api/media}/dtv-ca.rst    |     0
 .../kapi =3D> driver-api/media}/dtv-common.rst       |     0
 .../{media/kapi =3D> driver-api/media}/dtv-core.rst  |     0
 .../{media/kapi =3D> driver-api/media}/dtv-demux.rst |     0
 .../kapi =3D> driver-api/media}/dtv-frontend.rst     |     0
 .../{media/kapi =3D> driver-api/media}/dtv-net.rst   |     0
 Documentation/driver-api/media/index.rst           |    54 +
 .../{media/kapi =3D> driver-api/media}/mc-core.rst   |     0
 .../{media/kapi =3D> driver-api/media}/rc-core.rst   |     0
 .../kapi =3D> driver-api/media}/v4l2-async.rst       |     0
 .../kapi =3D> driver-api/media}/v4l2-clocks.rst      |     0
 .../kapi =3D> driver-api/media}/v4l2-common.rst      |     0
 .../kapi =3D> driver-api/media}/v4l2-controls.rst    |     0
 .../{media/kapi =3D> driver-api/media}/v4l2-core.rst |     0
 .../{media/kapi =3D> driver-api/media}/v4l2-dev.rst  |     0
 .../kapi =3D> driver-api/media}/v4l2-device.rst      |     0
 .../kapi =3D> driver-api/media}/v4l2-dv-timings.rst  |     0
 .../kapi =3D> driver-api/media}/v4l2-event.rst       |     0
 .../{media/kapi =3D> driver-api/media}/v4l2-fh.rst   |     0
 .../media}/v4l2-flash-led-class.rst                |     0
 .../kapi =3D> driver-api/media}/v4l2-fwnode.rst      |     0
 .../kapi =3D> driver-api/media}/v4l2-intro.rst       |     0
 .../{media/kapi =3D> driver-api/media}/v4l2-mc.rst   |     0
 .../kapi =3D> driver-api/media}/v4l2-mediabus.rst    |     0
 .../kapi =3D> driver-api/media}/v4l2-mem2mem.rst     |     0
 .../{media/kapi =3D> driver-api/media}/v4l2-rect.rst |     0
 Documentation/driver-api/media/v4l2-subdev.rst     |   493 +
 .../kapi =3D> driver-api/media}/v4l2-tuner.rst       |     0
 .../kapi =3D> driver-api/media}/v4l2-tveeprom.rst    |     0
 Documentation/driver-api/media/v4l2-videobuf.rst   |   403 +
 .../kapi =3D> driver-api/media}/v4l2-videobuf2.rst   |     0
 Documentation/fb/api.rst                           |     4 +-
 Documentation/index.rst                            |     1 -
 Documentation/media/.gitignore                     |     5 -
 Documentation/media/Makefile                       |    69 -
 Documentation/media/cec-drivers/index.rst          |    34 -
 Documentation/media/dvb-drivers/avermedia.rst      |   269 -
 Documentation/media/dvb-drivers/bt8xx.rst          |   124 -
 Documentation/media/dvb-drivers/cards.rst          |   146 -
 Documentation/media/dvb-drivers/ci.rst             |   231 -
 Documentation/media/dvb-drivers/faq.rst            |   169 -
 Documentation/media/dvb-drivers/index.rst          |    45 -
 Documentation/media/dvb-drivers/intro.rst          |    23 -
 Documentation/media/dvb-drivers/udev.rst           |    63 -
 Documentation/media/index.rst                      |    26 -
 Documentation/media/kapi/csi2.rst                  |    85 -
 Documentation/media/kapi/v4l2-subdev.rst           |   444 -
 Documentation/media/kapi/v4l2-videobuf.rst         |   406 -
 Documentation/media/media_kapi.rst                 |    38 -
 Documentation/media/media_uapi.rst                 |    33 -
 Documentation/media/typical_media_device.svg       |   116 -
 Documentation/media/uapi/cec/cec-api.rst           |    54 -
 Documentation/media/uapi/cec/cec-func-close.rst    |    54 -
 Documentation/media/uapi/cec/cec-func-ioctl.rst    |    73 -
 Documentation/media/uapi/cec/cec-func-open.rst     |    85 -
 Documentation/media/uapi/cec/cec-func-poll.rst     |    85 -
 Documentation/media/uapi/cec/cec-funcs.rst         |    30 -
 Documentation/media/uapi/cec/cec-header.rst        |    17 -
 Documentation/media/uapi/cec/cec-intro.rst         |    49 -
 .../media/uapi/cec/cec-ioc-adap-g-caps.rst         |   150 -
 .../media/uapi/cec/cec-ioc-adap-g-log-addrs.rst    |   378 -
 .../media/uapi/cec/cec-ioc-adap-g-phys-addr.rst    |   100 -
 Documentation/media/uapi/cec/cec-ioc-dqevent.rst   |   257 -
 Documentation/media/uapi/cec/cec-ioc-g-mode.rst    |   301 -
 Documentation/media/uapi/cec/cec-ioc-receive.rst   |   391 -
 Documentation/media/uapi/cec/cec-pin-error-inj.rst |   334 -
 .../uapi/dvb/audio-bilingual-channel-select.rst    |    66 -
 .../media/uapi/dvb/audio-channel-select.rst        |    66 -
 .../media/uapi/dvb/audio-clear-buffer.rst          |    55 -
 Documentation/media/uapi/dvb/audio-continue.rst    |    56 -
 Documentation/media/uapi/dvb/audio-fclose.rst      |    63 -
 Documentation/media/uapi/dvb/audio-fopen.rst       |   115 -
 Documentation/media/uapi/dvb/audio-fwrite.rst      |    91 -
 .../media/uapi/dvb/audio-get-capabilities.rst      |    63 -
 Documentation/media/uapi/dvb/audio-get-status.rst  |    63 -
 Documentation/media/uapi/dvb/audio-pause.rst       |    57 -
 Documentation/media/uapi/dvb/audio-play.rst        |    56 -
 .../media/uapi/dvb/audio-select-source.rst         |    65 -
 Documentation/media/uapi/dvb/audio-set-av-sync.rst |    67 -
 .../media/uapi/dvb/audio-set-bypass-mode.rst       |    70 -
 Documentation/media/uapi/dvb/audio-set-id.rst      |    67 -
 Documentation/media/uapi/dvb/audio-set-mixer.rst   |    61 -
 Documentation/media/uapi/dvb/audio-set-mute.rst    |    71 -
 .../media/uapi/dvb/audio-set-streamtype.rst        |    77 -
 Documentation/media/uapi/dvb/audio-stop.rst        |    56 -
 Documentation/media/uapi/dvb/audio.rst             |    34 -
 Documentation/media/uapi/dvb/audio_data_types.rst  |   123 -
 .../media/uapi/dvb/audio_function_calls.rst        |    37 -
 Documentation/media/uapi/dvb/ca-fclose.rst         |    50 -
 Documentation/media/uapi/dvb/ca-fopen.rst          |    84 -
 Documentation/media/uapi/dvb/ca-get-cap.rst        |    53 -
 Documentation/media/uapi/dvb/ca-get-descr-info.rst |    49 -
 Documentation/media/uapi/dvb/ca-get-msg.rst        |    59 -
 Documentation/media/uapi/dvb/ca-get-slot-info.rst  |    64 -
 Documentation/media/uapi/dvb/ca-reset.rst          |    51 -
 Documentation/media/uapi/dvb/ca-send-msg.rst       |    58 -
 Documentation/media/uapi/dvb/ca-set-descr.rst      |    53 -
 Documentation/media/uapi/dvb/ca.rst                |    31 -
 Documentation/media/uapi/dvb/ca_data_types.rst     |    16 -
 Documentation/media/uapi/dvb/ca_function_calls.rst |    27 -
 Documentation/media/uapi/dvb/demux.rst             |    30 -
 Documentation/media/uapi/dvb/dmx-add-pid.rst       |    56 -
 Documentation/media/uapi/dvb/dmx-expbuf.rst        |    97 -
 Documentation/media/uapi/dvb/dmx-fclose.rst        |    52 -
 Documentation/media/uapi/dvb/dmx-fopen.rst         |    98 -
 Documentation/media/uapi/dvb/dmx-fread.rst         |    87 -
 Documentation/media/uapi/dvb/dmx-fwrite.rst        |    79 -
 Documentation/media/uapi/dvb/dmx-get-pes-pids.rst  |    71 -
 Documentation/media/uapi/dvb/dmx-get-stc.rst       |    73 -
 Documentation/media/uapi/dvb/dmx-mmap.rst          |   125 -
 Documentation/media/uapi/dvb/dmx-munmap.rst        |    63 -
 Documentation/media/uapi/dvb/dmx-qbuf.rst          |    93 -
 Documentation/media/uapi/dvb/dmx-querybuf.rst      |    72 -
 Documentation/media/uapi/dvb/dmx-remove-pid.rst    |    57 -
 Documentation/media/uapi/dvb/dmx-reqbufs.rst       |    83 -
 .../media/uapi/dvb/dmx-set-buffer-size.rst         |    57 -
 Documentation/media/uapi/dvb/dmx-set-filter.rst    |    64 -
 .../media/uapi/dvb/dmx-set-pes-filter.rst          |    76 -
 Documentation/media/uapi/dvb/dmx-start.rst         |    75 -
 Documentation/media/uapi/dvb/dmx-stop.rst          |    52 -
 Documentation/media/uapi/dvb/dmx_fcalls.rst        |    37 -
 Documentation/media/uapi/dvb/dmx_types.rst         |    16 -
 .../media/uapi/dvb/dvb-fe-read-status.rst          |    32 -
 .../media/uapi/dvb/dvb-frontend-event.rst          |    22 -
 .../media/uapi/dvb/dvb-frontend-parameters.rst     |   126 -
 Documentation/media/uapi/dvb/dvbapi.rst            |   126 -
 Documentation/media/uapi/dvb/dvbproperty.rst       |   133 -
 Documentation/media/uapi/dvb/dvbstb.svg            |    43 -
 Documentation/media/uapi/dvb/examples.rst          |    23 -
 Documentation/media/uapi/dvb/fe-bandwidth-t.rst    |    81 -
 .../media/uapi/dvb/fe-diseqc-recv-slave-reply.rst  |    55 -
 .../media/uapi/dvb/fe-diseqc-reset-overload.rst    |    53 -
 .../media/uapi/dvb/fe-diseqc-send-burst.rst        |    59 -
 .../media/uapi/dvb/fe-diseqc-send-master-cmd.rst   |    56 -
 .../uapi/dvb/fe-dishnetwork-send-legacy-cmd.rst    |    62 -
 .../media/uapi/dvb/fe-enable-high-lnb-voltage.rst  |    61 -
 Documentation/media/uapi/dvb/fe-get-event.rst      |    78 -
 Documentation/media/uapi/dvb/fe-get-frontend.rst   |    69 -
 Documentation/media/uapi/dvb/fe-get-info.rst       |    70 -
 Documentation/media/uapi/dvb/fe-get-property.rst   |    83 -
 Documentation/media/uapi/dvb/fe-read-ber.rst       |    57 -
 .../media/uapi/dvb/fe-read-signal-strength.rst     |    57 -
 Documentation/media/uapi/dvb/fe-read-snr.rst       |    57 -
 Documentation/media/uapi/dvb/fe-read-status.rst    |    72 -
 .../media/uapi/dvb/fe-read-uncorrected-blocks.rst  |    59 -
 .../media/uapi/dvb/fe-set-frontend-tune-mode.rst   |    64 -
 Documentation/media/uapi/dvb/fe-set-frontend.rst   |    78 -
 Documentation/media/uapi/dvb/fe-set-tone.rst       |    65 -
 Documentation/media/uapi/dvb/fe-set-voltage.rst    |    69 -
 Documentation/media/uapi/dvb/fe-type-t.rst         |    98 -
 .../media/uapi/dvb/fe_property_parameters.rst      |  1014 --
 Documentation/media/uapi/dvb/frontend-header.rst   |    13 -
 .../uapi/dvb/frontend-property-cable-systems.rst   |    82 -
 .../dvb/frontend-property-satellite-systems.rst    |   112 -
 .../dvb/frontend-property-terrestrial-systems.rst  |   301 -
 .../media/uapi/dvb/frontend-stat-properties.rst    |   252 -
 Documentation/media/uapi/dvb/frontend.rst          |    63 -
 Documentation/media/uapi/dvb/frontend_f_close.rst  |    57 -
 Documentation/media/uapi/dvb/frontend_f_open.rst   |   117 -
 Documentation/media/uapi/dvb/frontend_fcalls.rst   |    31 -
 .../media/uapi/dvb/frontend_legacy_api.rst         |    45 -
 .../media/uapi/dvb/frontend_legacy_dvbv3_api.rst   |    25 -
 Documentation/media/uapi/dvb/headers.rst           |    30 -
 Documentation/media/uapi/dvb/intro.rst             |   190 -
 Documentation/media/uapi/dvb/legacy_dvb_apis.rst   |    39 -
 Documentation/media/uapi/dvb/net-add-if.rst        |    60 -
 Documentation/media/uapi/dvb/net-get-if.rst        |    59 -
 Documentation/media/uapi/dvb/net-remove-if.rst     |    55 -
 Documentation/media/uapi/dvb/net-types.rst         |    16 -
 Documentation/media/uapi/dvb/net.rst               |    48 -
 .../media/uapi/dvb/query-dvb-frontend-info.rst     |    20 -
 .../media/uapi/dvb/video-clear-buffer.rst          |    63 -
 Documentation/media/uapi/dvb/video-command.rst     |   105 -
 Documentation/media/uapi/dvb/video-continue.rst    |    66 -
 .../media/uapi/dvb/video-fast-forward.rst          |    83 -
 Documentation/media/uapi/dvb/video-fclose.rst      |    62 -
 Documentation/media/uapi/dvb/video-fopen.rst       |   122 -
 Documentation/media/uapi/dvb/video-freeze.rst      |    70 -
 Documentation/media/uapi/dvb/video-fwrite.rst      |    90 -
 .../media/uapi/dvb/video-get-capabilities.rst      |    70 -
 Documentation/media/uapi/dvb/video-get-event.rst   |   114 -
 .../media/uapi/dvb/video-get-frame-count.rst       |    74 -
 Documentation/media/uapi/dvb/video-get-pts.rst     |    78 -
 Documentation/media/uapi/dvb/video-get-size.rst    |    78 -
 Documentation/media/uapi/dvb/video-get-status.rst  |    80 -
 Documentation/media/uapi/dvb/video-play.rst        |    66 -
 .../media/uapi/dvb/video-select-source.rst         |    84 -
 Documentation/media/uapi/dvb/video-set-blank.rst   |    73 -
 .../media/uapi/dvb/video-set-display-format.rst    |    69 -
 Documentation/media/uapi/dvb/video-set-format.rst  |    92 -
 .../media/uapi/dvb/video-set-streamtype.rst        |    70 -
 Documentation/media/uapi/dvb/video-slowmotion.rst  |    83 -
 .../media/uapi/dvb/video-stillpicture.rst          |    70 -
 Documentation/media/uapi/dvb/video-stop.rst        |    83 -
 Documentation/media/uapi/dvb/video-try-command.rst |    75 -
 Documentation/media/uapi/dvb/video.rst             |    43 -
 .../media/uapi/dvb/video_function_calls.rst        |    42 -
 Documentation/media/uapi/dvb/video_types.rst       |   255 -
 Documentation/media/uapi/fdl-appendix.rst          |   478 -
 Documentation/media/uapi/gen-errors.rst            |   103 -
 .../media/uapi/mediactl/media-controller-intro.rst |    40 -
 .../media/uapi/mediactl/media-controller-model.rst |    42 -
 .../media/uapi/mediactl/media-controller.rst       |    62 -
 .../media/uapi/mediactl/media-func-close.rst       |    54 -
 .../media/uapi/mediactl/media-func-ioctl.rst       |    74 -
 .../media/uapi/mediactl/media-func-open.rst        |    76 -
 Documentation/media/uapi/mediactl/media-funcs.rst  |    33 -
 Documentation/media/uapi/mediactl/media-header.rst |    17 -
 .../media/uapi/mediactl/media-ioc-device-info.rst  |   118 -
 .../uapi/mediactl/media-ioc-enum-entities.rst      |   156 -
 .../media/uapi/mediactl/media-ioc-enum-links.rst   |   157 -
 .../media/uapi/mediactl/media-ioc-g-topology.rst   |   307 -
 .../uapi/mediactl/media-ioc-request-alloc.rst      |    90 -
 .../media/uapi/mediactl/media-ioc-setup-link.rst   |    74 -
 .../uapi/mediactl/media-request-ioc-queue.rst      |   102 -
 .../uapi/mediactl/media-request-ioc-reinit.rst     |    75 -
 Documentation/media/uapi/mediactl/media-types.rst  |   425 -
 Documentation/media/uapi/mediactl/request-api.rst  |   276 -
 .../media/uapi/mediactl/request-func-close.rst     |    73 -
 .../media/uapi/mediactl/request-func-ioctl.rst     |    91 -
 .../media/uapi/mediactl/request-func-poll.rst      |   101 -
 Documentation/media/uapi/rc/keytable.c.rst         |   183 -
 Documentation/media/uapi/rc/lirc-dev-intro.rst     |   171 -
 Documentation/media/uapi/rc/lirc-dev.rst           |    21 -
 Documentation/media/uapi/rc/lirc-func.rst          |    34 -
 Documentation/media/uapi/rc/lirc-get-features.rst  |   200 -
 Documentation/media/uapi/rc/lirc-get-rec-mode.rst  |    74 -
 .../media/uapi/rc/lirc-get-rec-resolution.rst      |    54 -
 Documentation/media/uapi/rc/lirc-get-send-mode.rst |    78 -
 Documentation/media/uapi/rc/lirc-get-timeout.rst   |    63 -
 Documentation/media/uapi/rc/lirc-header.rst        |    17 -
 Documentation/media/uapi/rc/lirc-read.rst          |    76 -
 .../uapi/rc/lirc-set-measure-carrier-mode.rst      |    53 -
 .../media/uapi/rc/lirc-set-rec-carrier-range.rst   |    54 -
 .../media/uapi/rc/lirc-set-rec-carrier.rst         |    53 -
 .../media/uapi/rc/lirc-set-rec-timeout-reports.rst |    56 -
 .../media/uapi/rc/lirc-set-rec-timeout.rst         |    61 -
 .../media/uapi/rc/lirc-set-send-carrier.rst        |    48 -
 .../media/uapi/rc/lirc-set-send-duty-cycle.rst     |    54 -
 .../media/uapi/rc/lirc-set-transmitter-mask.rst    |    58 -
 .../media/uapi/rc/lirc-set-wideband-receiver.rst   |    63 -
 Documentation/media/uapi/rc/lirc-write.rst         |    82 -
 Documentation/media/uapi/rc/rc-intro.rst           |    31 -
 Documentation/media/uapi/rc/rc-sysfs-nodes.rst     |   151 -
 Documentation/media/uapi/rc/rc-table-change.rst    |    25 -
 Documentation/media/uapi/rc/rc-tables.rst          |   766 --
 Documentation/media/uapi/rc/remote_controllers.rst |    59 -
 Documentation/media/uapi/v4l/app-pri.rst           |    37 -
 Documentation/media/uapi/v4l/async.rst             |    16 -
 Documentation/media/uapi/v4l/audio.rst             |   104 -
 Documentation/media/uapi/v4l/bayer.svg             |    56 -
 Documentation/media/uapi/v4l/biblio.rst            |   416 -
 Documentation/media/uapi/v4l/buffer.rst            |   817 --
 Documentation/media/uapi/v4l/capture-example.rst   |    20 -
 Documentation/media/uapi/v4l/capture.c.rst         |   671 --
 Documentation/media/uapi/v4l/colorspaces-defs.rst  |   183 -
 .../media/uapi/v4l/colorspaces-details.rst         |   813 --
 Documentation/media/uapi/v4l/colorspaces.rst       |   170 -
 Documentation/media/uapi/v4l/common-defs.rst       |    20 -
 Documentation/media/uapi/v4l/common.rst            |    64 -
 Documentation/media/uapi/v4l/compat.rst            |    25 -
 Documentation/media/uapi/v4l/constraints.svg       |    37 -
 Documentation/media/uapi/v4l/control.rst           |   512 -
 Documentation/media/uapi/v4l/crop.rst              |   324 -
 Documentation/media/uapi/v4l/crop.svg              |   290 -
 Documentation/media/uapi/v4l/depth-formats.rst     |    24 -
 Documentation/media/uapi/v4l/dev-capture.rst       |   111 -
 Documentation/media/uapi/v4l/dev-event.rst         |    54 -
 Documentation/media/uapi/v4l/dev-mem2mem.rst       |    49 -
 Documentation/media/uapi/v4l/dev-meta.rst          |    74 -
 Documentation/media/uapi/v4l/dev-osd.rst           |   157 -
 Documentation/media/uapi/v4l/dev-output.rst        |   108 -
 Documentation/media/uapi/v4l/dev-overlay.rst       |   328 -
 Documentation/media/uapi/v4l/dev-radio.rst         |    59 -
 Documentation/media/uapi/v4l/dev-raw-vbi.rst       |   306 -
 Documentation/media/uapi/v4l/dev-rds.rst           |   191 -
 Documentation/media/uapi/v4l/dev-sdr.rst           |   114 -
 Documentation/media/uapi/v4l/dev-sliced-vbi.rst    |   669 --
 Documentation/media/uapi/v4l/dev-subdev.rst        |   503 -
 Documentation/media/uapi/v4l/dev-touch.rst         |    63 -
 Documentation/media/uapi/v4l/devices.rst           |    33 -
 Documentation/media/uapi/v4l/diff-v4l.rst          |   693 --
 Documentation/media/uapi/v4l/dmabuf.rst            |   169 -
 Documentation/media/uapi/v4l/dv-timings.rst        |    45 -
 Documentation/media/uapi/v4l/ext-ctrls-camera.rst  |   515 -
 Documentation/media/uapi/v4l/ext-ctrls-codec.rst   |  4264 -------
 Documentation/media/uapi/v4l/ext-ctrls-detect.rst  |    71 -
 Documentation/media/uapi/v4l/ext-ctrls-dv.rst      |   166 -
 Documentation/media/uapi/v4l/ext-ctrls-flash.rst   |   192 -
 Documentation/media/uapi/v4l/ext-ctrls-fm-rx.rst   |    95 -
 Documentation/media/uapi/v4l/ext-ctrls-fm-tx.rst   |   188 -
 .../media/uapi/v4l/ext-ctrls-image-process.rst     |    63 -
 .../media/uapi/v4l/ext-ctrls-image-source.rst      |    67 -
 Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst    |   113 -
 .../media/uapi/v4l/ext-ctrls-rf-tuner.rst          |    96 -
 Documentation/media/uapi/v4l/extended-controls.rst |   180 -
 Documentation/media/uapi/v4l/field-order.rst       |   172 -
 Documentation/media/uapi/v4l/fieldseq_bt.svg       |  2621 -----
 Documentation/media/uapi/v4l/fieldseq_tb.svg       |  2618 -----
 Documentation/media/uapi/v4l/format.rst            |    99 -
 Documentation/media/uapi/v4l/func-close.rst        |    56 -
 Documentation/media/uapi/v4l/func-ioctl.rst        |    69 -
 Documentation/media/uapi/v4l/func-mmap.rst         |   148 -
 Documentation/media/uapi/v4l/func-munmap.rst       |    65 -
 Documentation/media/uapi/v4l/func-open.rst         |    90 -
 Documentation/media/uapi/v4l/func-poll.rst         |   124 -
 Documentation/media/uapi/v4l/func-read.rst         |   140 -
 Documentation/media/uapi/v4l/func-select.rst       |   127 -
 Documentation/media/uapi/v4l/func-write.rst        |    91 -
 Documentation/media/uapi/v4l/hist-v4l2.rst         |  1374 ---
 Documentation/media/uapi/v4l/hsv-formats.rst       |    26 -
 Documentation/media/uapi/v4l/io.rst                |    58 -
 .../media/uapi/v4l/libv4l-introduction.rst         |   191 -
 Documentation/media/uapi/v4l/libv4l.rst            |    20 -
 Documentation/media/uapi/v4l/meta-formats.rst      |    27 -
 Documentation/media/uapi/v4l/mmap.rst              |   292 -
 Documentation/media/uapi/v4l/nv12mt.svg            |   477 -
 Documentation/media/uapi/v4l/nv12mt_example.svg    |  1616 ---
 Documentation/media/uapi/v4l/open.rst              |   165 -
 Documentation/media/uapi/v4l/pixfmt-bayer.rst      |    39 -
 Documentation/media/uapi/v4l/pixfmt-compressed.rst |   232 -
 Documentation/media/uapi/v4l/pixfmt-grey.rst       |    51 -
 Documentation/media/uapi/v4l/pixfmt-indexed.rst    |    54 -
 Documentation/media/uapi/v4l/pixfmt-intro.rst      |    58 -
 Documentation/media/uapi/v4l/pixfmt-inzi.rst       |    89 -
 Documentation/media/uapi/v4l/pixfmt-m420.rst       |   133 -
 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst  |   220 -
 .../media/uapi/v4l/pixfmt-meta-intel-ipu3.rst      |   104 -
 Documentation/media/uapi/v4l/pixfmt-meta-uvc.rst   |    58 -
 Documentation/media/uapi/v4l/pixfmt-meta-vivid.rst |    60 -
 .../media/uapi/v4l/pixfmt-meta-vsp1-hgo.rst        |   175 -
 .../media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst        |   136 -
 Documentation/media/uapi/v4l/pixfmt-nv12.rst       |   136 -
 Documentation/media/uapi/v4l/pixfmt-nv12m.rst      |   151 -
 Documentation/media/uapi/v4l/pixfmt-nv12mt.rst     |    67 -
 Documentation/media/uapi/v4l/pixfmt-nv16.rst       |   160 -
 Documentation/media/uapi/v4l/pixfmt-nv16m.rst      |   164 -
 Documentation/media/uapi/v4l/pixfmt-nv24.rst       |   102 -
 Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst |   164 -
 Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst |   380 -
 Documentation/media/uapi/v4l/pixfmt-reserved.rst   |   282 -
 Documentation/media/uapi/v4l/pixfmt-rgb.rst        |  1304 ---
 Documentation/media/uapi/v4l/pixfmt-sdr-cs08.rst   |    37 -
 Documentation/media/uapi/v4l/pixfmt-sdr-cs14le.rst |    41 -
 Documentation/media/uapi/v4l/pixfmt-sdr-cu08.rst   |    37 -
 Documentation/media/uapi/v4l/pixfmt-sdr-cu16le.rst |    41 -
 .../media/uapi/v4l/pixfmt-sdr-pcu16be.rst          |    62 -
 .../media/uapi/v4l/pixfmt-sdr-pcu18be.rst          |    62 -
 .../media/uapi/v4l/pixfmt-sdr-pcu20be.rst          |    62 -
 Documentation/media/uapi/v4l/pixfmt-sdr-ru12le.rst |    39 -
 .../media/uapi/v4l/pixfmt-srggb10-ipu3.rst         |   342 -
 Documentation/media/uapi/v4l/pixfmt-srggb10.rst    |    83 -
 .../media/uapi/v4l/pixfmt-srggb10alaw8.rst         |    31 -
 .../media/uapi/v4l/pixfmt-srggb10dpcm8.rst         |    35 -
 Documentation/media/uapi/v4l/pixfmt-srggb10p.rst   |    81 -
 Documentation/media/uapi/v4l/pixfmt-srggb12.rst    |    84 -
 Documentation/media/uapi/v4l/pixfmt-srggb12p.rst   |    94 -
 Documentation/media/uapi/v4l/pixfmt-srggb14.rst    |    82 -
 Documentation/media/uapi/v4l/pixfmt-srggb14p.rst   |   152 -
 Documentation/media/uapi/v4l/pixfmt-srggb16.rst    |    76 -
 Documentation/media/uapi/v4l/pixfmt-srggb8.rst     |    61 -
 Documentation/media/uapi/v4l/pixfmt-tch-td08.rst   |    59 -
 Documentation/media/uapi/v4l/pixfmt-tch-td16.rst   |    74 -
 Documentation/media/uapi/v4l/pixfmt-tch-tu08.rst   |    57 -
 Documentation/media/uapi/v4l/pixfmt-tch-tu16.rst   |    73 -
 Documentation/media/uapi/v4l/pixfmt-uv8.rst        |    54 -
 Documentation/media/uapi/v4l/pixfmt-uyvy.rst       |   117 -
 .../media/uapi/v4l/pixfmt-v4l2-mplane.rst          |   138 -
 Documentation/media/uapi/v4l/pixfmt-v4l2.rst       |   171 -
 Documentation/media/uapi/v4l/pixfmt-vyuy.rst       |   115 -
 Documentation/media/uapi/v4l/pixfmt-y10.rst        |    72 -
 Documentation/media/uapi/v4l/pixfmt-y10b.rst       |    40 -
 Documentation/media/uapi/v4l/pixfmt-y10p.rst       |    50 -
 Documentation/media/uapi/v4l/pixfmt-y12.rst        |    72 -
 Documentation/media/uapi/v4l/pixfmt-y12i.rst       |    43 -
 Documentation/media/uapi/v4l/pixfmt-y14.rst        |    72 -
 Documentation/media/uapi/v4l/pixfmt-y16-be.rst     |    76 -
 Documentation/media/uapi/v4l/pixfmt-y16.rst        |    76 -
 Documentation/media/uapi/v4l/pixfmt-y41p.rst       |   158 -
 Documentation/media/uapi/v4l/pixfmt-y8i.rst        |    73 -
 Documentation/media/uapi/v4l/pixfmt-yuv410.rst     |   134 -
 Documentation/media/uapi/v4l/pixfmt-yuv411p.rst    |   122 -
 Documentation/media/uapi/v4l/pixfmt-yuv420.rst     |   150 -
 Documentation/media/uapi/v4l/pixfmt-yuv420m.rst    |   159 -
 Documentation/media/uapi/v4l/pixfmt-yuv422m.rst    |   148 -
 Documentation/media/uapi/v4l/pixfmt-yuv422p.rst    |   136 -
 Documentation/media/uapi/v4l/pixfmt-yuv444m.rst    |   148 -
 Documentation/media/uapi/v4l/pixfmt-yuyv.rst       |   125 -
 Documentation/media/uapi/v4l/pixfmt-yvyu.rst       |   115 -
 Documentation/media/uapi/v4l/pixfmt-z16.rst        |    73 -
 Documentation/media/uapi/v4l/pixfmt.rst            |    45 -
 Documentation/media/uapi/v4l/planar-apis.rst       |    68 -
 Documentation/media/uapi/v4l/querycap.rst          |    41 -
 Documentation/media/uapi/v4l/rw.rst                |    54 -
 Documentation/media/uapi/v4l/sdr-formats.rst       |    29 -
 .../media/uapi/v4l/selection-api-configuration.rst |   144 -
 .../media/uapi/v4l/selection-api-examples.rst      |    91 -
 .../media/uapi/v4l/selection-api-intro.rst         |    35 -
 .../media/uapi/v4l/selection-api-targets.rst       |    27 -
 .../media/uapi/v4l/selection-api-vs-crop-api.rst   |    46 -
 Documentation/media/uapi/v4l/selection-api.rst     |    23 -
 Documentation/media/uapi/v4l/selection.svg         |  1178 --
 Documentation/media/uapi/v4l/selections-common.rst |    30 -
 Documentation/media/uapi/v4l/standard.rst          |   192 -
 Documentation/media/uapi/v4l/streaming-par.rst     |    40 -
 Documentation/media/uapi/v4l/subdev-formats.rst    |  7833 -------------
 .../uapi/v4l/subdev-image-processing-crop.svg      |   312 -
 .../uapi/v4l/subdev-image-processing-full.svg      |   752 --
 ...ubdev-image-processing-scaling-multi-source.svg |   550 -
 Documentation/media/uapi/v4l/tch-formats.rst       |    25 -
 Documentation/media/uapi/v4l/tuner.rst             |    92 -
 Documentation/media/uapi/v4l/user-func.rst         |    88 -
 Documentation/media/uapi/v4l/userp.rst             |   128 -
 .../media/uapi/v4l/v4l2-selection-flags.rst        |    51 -
 .../media/uapi/v4l/v4l2-selection-targets.rst      |    78 -
 Documentation/media/uapi/v4l/v4l2.rst              |   423 -
 Documentation/media/uapi/v4l/v4l2grab-example.rst  |    24 -
 Documentation/media/uapi/v4l/v4l2grab.c.rst        |   176 -
 Documentation/media/uapi/v4l/vbi_525.svg           |   821 --
 Documentation/media/uapi/v4l/vbi_625.svg           |   870 --
 Documentation/media/uapi/v4l/vbi_hsync.svg         |   321 -
 Documentation/media/uapi/v4l/video.rst             |    75 -
 Documentation/media/uapi/v4l/videodev.rst          |    16 -
 .../media/uapi/v4l/vidioc-create-bufs.rst          |   141 -
 Documentation/media/uapi/v4l/vidioc-cropcap.rst    |   143 -
 .../media/uapi/v4l/vidioc-dbg-g-chip-info.rst      |   167 -
 .../media/uapi/v4l/vidioc-dbg-g-register.rst       |   171 -
 .../media/uapi/v4l/vidioc-decoder-cmd.rst          |   226 -
 Documentation/media/uapi/v4l/vidioc-dqevent.rst    |   391 -
 .../media/uapi/v4l/vidioc-dv-timings-cap.rst       |   169 -
 .../media/uapi/v4l/vidioc-encoder-cmd.rst          |   168 -
 .../media/uapi/v4l/vidioc-enum-dv-timings.rst      |   114 -
 Documentation/media/uapi/v4l/vidioc-enum-fmt.rst   |   159 -
 .../media/uapi/v4l/vidioc-enum-frameintervals.rst  |   203 -
 .../media/uapi/v4l/vidioc-enum-framesizes.rst      |   213 -
 .../media/uapi/v4l/vidioc-enum-freq-bands.rst      |   150 -
 Documentation/media/uapi/v4l/vidioc-enumaudio.rst  |    62 -
 .../media/uapi/v4l/vidioc-enumaudioout.rst         |    67 -
 Documentation/media/uapi/v4l/vidioc-enuminput.rst  |   242 -
 Documentation/media/uapi/v4l/vidioc-enumoutput.rst |   165 -
 Documentation/media/uapi/v4l/vidioc-enumstd.rst    |   367 -
 Documentation/media/uapi/v4l/vidioc-expbuf.rst     |   175 -
 Documentation/media/uapi/v4l/vidioc-g-audio.rst    |   135 -
 Documentation/media/uapi/v4l/vidioc-g-audioout.rst |   108 -
 Documentation/media/uapi/v4l/vidioc-g-crop.rst     |   119 -
 Documentation/media/uapi/v4l/vidioc-g-ctrl.rst     |   106 -
 .../media/uapi/v4l/vidioc-g-dv-timings.rst         |   312 -
 Documentation/media/uapi/v4l/vidioc-g-edid.rst     |   154 -
 .../media/uapi/v4l/vidioc-g-enc-index.rst          |   156 -
 .../media/uapi/v4l/vidioc-g-ext-ctrls.rst          |   416 -
 Documentation/media/uapi/v4l/vidioc-g-fbuf.rst     |   362 -
 Documentation/media/uapi/v4l/vidioc-g-fmt.rst      |   161 -
 .../media/uapi/v4l/vidioc-g-frequency.rst          |   112 -
 Documentation/media/uapi/v4l/vidioc-g-input.rst    |    71 -
 Documentation/media/uapi/v4l/vidioc-g-jpegcomp.rst |   134 -
 .../media/uapi/v4l/vidioc-g-modulator.rst          |   202 -
 Documentation/media/uapi/v4l/vidioc-g-output.rst   |    73 -
 Documentation/media/uapi/v4l/vidioc-g-parm.rst     |   270 -
 Documentation/media/uapi/v4l/vidioc-g-priority.rst |   100 -
 .../media/uapi/v4l/vidioc-g-selection.rst          |   200 -
 .../media/uapi/v4l/vidioc-g-sliced-vbi-cap.rst     |   202 -
 Documentation/media/uapi/v4l/vidioc-g-std.rst      |    81 -
 Documentation/media/uapi/v4l/vidioc-g-tuner.rst    |   476 -
 Documentation/media/uapi/v4l/vidioc-log-status.rst |    56 -
 Documentation/media/uapi/v4l/vidioc-overlay.rst    |    61 -
 .../media/uapi/v4l/vidioc-prepare-buf.rst          |    65 -
 Documentation/media/uapi/v4l/vidioc-qbuf.rst       |   205 -
 .../media/uapi/v4l/vidioc-query-dv-timings.rst     |    94 -
 Documentation/media/uapi/v4l/vidioc-querybuf.rst   |    87 -
 Documentation/media/uapi/v4l/vidioc-querycap.rst   |   284 -
 Documentation/media/uapi/v4l/vidioc-queryctrl.rst  |   616 -
 Documentation/media/uapi/v4l/vidioc-querystd.rst   |    77 -
 Documentation/media/uapi/v4l/vidioc-reqbufs.rst    |   169 -
 .../media/uapi/v4l/vidioc-s-hw-freq-seek.rst       |   147 -
 Documentation/media/uapi/v4l/vidioc-streamon.rst   |   113 -
 .../uapi/v4l/vidioc-subdev-enum-frame-interval.rst |   120 -
 .../uapi/v4l/vidioc-subdev-enum-frame-size.rst     |   125 -
 .../uapi/v4l/vidioc-subdev-enum-mbus-code.rst      |    98 -
 .../media/uapi/v4l/vidioc-subdev-g-crop.rst        |   125 -
 .../media/uapi/v4l/vidioc-subdev-g-fmt.rst         |   154 -
 .../uapi/v4l/vidioc-subdev-g-frame-interval.rst    |   120 -
 .../media/uapi/v4l/vidioc-subdev-g-selection.rst   |   125 -
 .../media/uapi/v4l/vidioc-subscribe-event.rst      |   123 -
 Documentation/media/uapi/v4l/yuv-formats.rst       |    64 -
 Documentation/media/v4l-drivers/bttv-cardlist.rst  |   683 --
 Documentation/media/v4l-drivers/bttv.rst           |  1926 ----
 Documentation/media/v4l-drivers/cardlist.rst       |    20 -
 Documentation/media/v4l-drivers/cpia2.rst          |   195 -
 Documentation/media/v4l-drivers/cx2341x.rst        |  3860 -------
 .../media/v4l-drivers/cx23885-cardlist.rst         |   263 -
 Documentation/media/v4l-drivers/cx88-cardlist.rst  |   379 -
 Documentation/media/v4l-drivers/cx88.rst           |   165 -
 Documentation/media/v4l-drivers/davinci-vpbe.rst   |    97 -
 .../media/v4l-drivers/em28xx-cardlist.rst          |   428 -
 Documentation/media/v4l-drivers/fimc.rst           |   171 -
 Documentation/media/v4l-drivers/imx.rst            |   705 --
 Documentation/media/v4l-drivers/index.rst          |    68 -
 Documentation/media/v4l-drivers/ipu3.rst           |   558 -
 Documentation/media/v4l-drivers/ivtv-cardlist.rst  |   139 -
 Documentation/media/v4l-drivers/max2175.rst        |    64 -
 Documentation/media/v4l-drivers/meye.rst           |   134 -
 Documentation/media/v4l-drivers/omap3isp.rst       |   284 -
 .../media/v4l-drivers/saa7134-cardlist.rst         |   803 --
 Documentation/media/v4l-drivers/saa7134.rst        |   115 -
 .../media/v4l-drivers/saa7164-cardlist.rst         |    71 -
 Documentation/media/v4l-drivers/v4l-with-ir.rst    |    75 -
 Documentation/media/v4l-drivers/vimc.rst           |   101 -
 Documentation/media/v4l-drivers/zr364xx.rst        |   110 -
 Documentation/media/videodev2.h.rst.exceptions     |   572 -
 .../translations/it_IT/doc-guide/parse-headers.rst |     2 +-
 .../translations/zh_CN/video4linux/omap3isp.txt    |     4 +-
 .../zh_CN/video4linux/v4l2-framework.txt           |     6 +-
 Documentation/userspace-api/index.rst              |     1 +
 Documentation/userspace-api/media/Makefile         |    69 +
 .../media/audio.h.rst.exceptions                   |     0
 .../{ =3D> userspace-api}/media/ca.h.rst.exceptions  |     0
 .../{ =3D> userspace-api}/media/cec.h.rst.exceptions |     0
 Documentation/userspace-api/media/cec/cec-api.rst  |    54 +
 .../userspace-api/media/cec/cec-func-close.rst     |    54 +
 .../userspace-api/media/cec/cec-func-ioctl.rst     |    73 +
 .../userspace-api/media/cec/cec-func-open.rst      |    85 +
 .../userspace-api/media/cec/cec-func-poll.rst      |    85 +
 .../userspace-api/media/cec/cec-funcs.rst          |    30 +
 .../userspace-api/media/cec/cec-header.rst         |    17 +
 .../userspace-api/media/cec/cec-intro.rst          |    49 +
 .../media/cec/cec-ioc-adap-g-caps.rst              |   150 +
 .../media}/cec/cec-ioc-adap-g-conn-info.rst        |     0
 .../media/cec/cec-ioc-adap-g-log-addrs.rst         |   378 +
 .../media/cec/cec-ioc-adap-g-phys-addr.rst         |   100 +
 .../userspace-api/media/cec/cec-ioc-dqevent.rst    |   257 +
 .../userspace-api/media/cec/cec-ioc-g-mode.rst     |   301 +
 .../userspace-api/media/cec/cec-ioc-receive.rst    |   391 +
 .../userspace-api/media/cec/cec-pin-error-inj.rst  |   334 +
 .../{ =3D> userspace-api}/media/conf_nitpick.py      |     0
 .../{ =3D> userspace-api}/media/dmx.h.rst.exceptions |     0
 .../userspace-api/media/drivers/cx2341x-uapi.rst   |   179 +
 .../userspace-api/media/drivers/imx-uapi.rst       |   125 +
 .../userspace-api/media/drivers/index.rst          |    39 +
 .../userspace-api/media/drivers/max2175.rst        |    64 +
 .../userspace-api/media/drivers/meye-uapi.rst      |    53 +
 .../userspace-api/media/drivers/omap3isp-uapi.rst  |   208 +
 .../media/drivers}/uvcvideo.rst                    |     0
 .../media/dvb/audio-bilingual-channel-select.rst   |    66 +
 .../media/dvb/audio-channel-select.rst             |    66 +
 .../userspace-api/media/dvb/audio-clear-buffer.rst |    55 +
 .../userspace-api/media/dvb/audio-continue.rst     |    56 +
 .../userspace-api/media/dvb/audio-fclose.rst       |    63 +
 .../userspace-api/media/dvb/audio-fopen.rst        |   115 +
 .../userspace-api/media/dvb/audio-fwrite.rst       |    91 +
 .../media/dvb/audio-get-capabilities.rst           |    63 +
 .../userspace-api/media/dvb/audio-get-status.rst   |    63 +
 .../userspace-api/media/dvb/audio-pause.rst        |    57 +
 .../userspace-api/media/dvb/audio-play.rst         |    56 +
 .../media/dvb/audio-select-source.rst              |    65 +
 .../userspace-api/media/dvb/audio-set-av-sync.rst  |    67 +
 .../media/dvb/audio-set-bypass-mode.rst            |    70 +
 .../userspace-api/media/dvb/audio-set-id.rst       |    67 +
 .../userspace-api/media/dvb/audio-set-mixer.rst    |    61 +
 .../userspace-api/media/dvb/audio-set-mute.rst     |    71 +
 .../media/dvb/audio-set-streamtype.rst             |    77 +
 .../userspace-api/media/dvb/audio-stop.rst         |    56 +
 Documentation/userspace-api/media/dvb/audio.rst    |    34 +
 .../userspace-api/media/dvb/audio_data_types.rst   |   123 +
 .../media/dvb/audio_function_calls.rst             |    37 +
 .../userspace-api/media/dvb/ca-fclose.rst          |    50 +
 Documentation/userspace-api/media/dvb/ca-fopen.rst |    84 +
 .../userspace-api/media/dvb/ca-get-cap.rst         |    53 +
 .../userspace-api/media/dvb/ca-get-descr-info.rst  |    49 +
 .../userspace-api/media/dvb/ca-get-msg.rst         |    59 +
 .../userspace-api/media/dvb/ca-get-slot-info.rst   |    64 +
 Documentation/userspace-api/media/dvb/ca-reset.rst |    51 +
 .../userspace-api/media/dvb/ca-send-msg.rst        |    58 +
 .../userspace-api/media/dvb/ca-set-descr.rst       |    53 +
 Documentation/userspace-api/media/dvb/ca.rst       |    32 +
 .../userspace-api/media/dvb/ca_data_types.rst      |    16 +
 .../userspace-api/media/dvb/ca_function_calls.rst  |    27 +
 .../userspace-api/media/dvb/ca_high_level.rst      |   157 +
 Documentation/userspace-api/media/dvb/demux.rst    |    30 +
 .../userspace-api/media/dvb/dmx-add-pid.rst        |    56 +
 .../userspace-api/media/dvb/dmx-expbuf.rst         |    97 +
 .../userspace-api/media/dvb/dmx-fclose.rst         |    52 +
 .../userspace-api/media/dvb/dmx-fopen.rst          |    98 +
 .../userspace-api/media/dvb/dmx-fread.rst          |    87 +
 .../userspace-api/media/dvb/dmx-fwrite.rst         |    79 +
 .../userspace-api/media/dvb/dmx-get-pes-pids.rst   |    71 +
 .../userspace-api/media/dvb/dmx-get-stc.rst        |    73 +
 Documentation/userspace-api/media/dvb/dmx-mmap.rst |   125 +
 .../userspace-api/media/dvb/dmx-munmap.rst         |    63 +
 Documentation/userspace-api/media/dvb/dmx-qbuf.rst |    93 +
 .../userspace-api/media/dvb/dmx-querybuf.rst       |    72 +
 .../userspace-api/media/dvb/dmx-remove-pid.rst     |    57 +
 .../userspace-api/media/dvb/dmx-reqbufs.rst        |    83 +
 .../media/dvb/dmx-set-buffer-size.rst              |    57 +
 .../userspace-api/media/dvb/dmx-set-filter.rst     |    64 +
 .../userspace-api/media/dvb/dmx-set-pes-filter.rst |    76 +
 .../userspace-api/media/dvb/dmx-start.rst          |    75 +
 Documentation/userspace-api/media/dvb/dmx-stop.rst |    52 +
 .../userspace-api/media/dvb/dmx_fcalls.rst         |    37 +
 .../userspace-api/media/dvb/dmx_types.rst          |    16 +
 .../userspace-api/media/dvb/dvb-fe-read-status.rst |    32 +
 .../userspace-api/media/dvb/dvb-frontend-event.rst |    22 +
 .../media/dvb/dvb-frontend-parameters.rst          |   126 +
 Documentation/userspace-api/media/dvb/dvbapi.rst   |   126 +
 .../userspace-api/media/dvb/dvbproperty.rst        |   133 +
 Documentation/userspace-api/media/dvb/dvbstb.svg   |    43 +
 Documentation/userspace-api/media/dvb/examples.rst |    23 +
 .../userspace-api/media/dvb/fe-bandwidth-t.rst     |    81 +
 .../media/dvb/fe-diseqc-recv-slave-reply.rst       |    55 +
 .../media/dvb/fe-diseqc-reset-overload.rst         |    53 +
 .../media/dvb/fe-diseqc-send-burst.rst             |    59 +
 .../media/dvb/fe-diseqc-send-master-cmd.rst        |    56 +
 .../media/dvb/fe-dishnetwork-send-legacy-cmd.rst   |    62 +
 .../media/dvb/fe-enable-high-lnb-voltage.rst       |    61 +
 .../userspace-api/media/dvb/fe-get-event.rst       |    78 +
 .../userspace-api/media/dvb/fe-get-frontend.rst    |    69 +
 .../userspace-api/media/dvb/fe-get-info.rst        |    70 +
 .../userspace-api/media/dvb/fe-get-property.rst    |    83 +
 .../userspace-api/media/dvb/fe-read-ber.rst        |    57 +
 .../media/dvb/fe-read-signal-strength.rst          |    57 +
 .../userspace-api/media/dvb/fe-read-snr.rst        |    57 +
 .../userspace-api/media/dvb/fe-read-status.rst     |    72 +
 .../media/dvb/fe-read-uncorrected-blocks.rst       |    59 +
 .../media/dvb/fe-set-frontend-tune-mode.rst        |    64 +
 .../userspace-api/media/dvb/fe-set-frontend.rst    |    78 +
 .../userspace-api/media/dvb/fe-set-tone.rst        |    65 +
 .../userspace-api/media/dvb/fe-set-voltage.rst     |    69 +
 .../userspace-api/media/dvb/fe-type-t.rst          |    98 +
 .../media/dvb/fe_property_parameters.rst           |  1014 ++
 .../userspace-api/media/dvb/frontend-header.rst    |    13 +
 .../media/dvb/frontend-property-cable-systems.rst  |    82 +
 .../dvb/frontend-property-satellite-systems.rst    |   112 +
 .../dvb/frontend-property-terrestrial-systems.rst  |   301 +
 .../media/dvb/frontend-stat-properties.rst         |   252 +
 Documentation/userspace-api/media/dvb/frontend.rst |    63 +
 .../userspace-api/media/dvb/frontend_f_close.rst   |    57 +
 .../userspace-api/media/dvb/frontend_f_open.rst    |   117 +
 .../userspace-api/media/dvb/frontend_fcalls.rst    |    31 +
 .../media/dvb/frontend_legacy_api.rst              |    45 +
 .../media/dvb/frontend_legacy_dvbv3_api.rst        |    25 +
 Documentation/userspace-api/media/dvb/headers.rst  |    30 +
 Documentation/userspace-api/media/dvb/intro.rst    |   190 +
 .../userspace-api/media/dvb/legacy_dvb_apis.rst    |    39 +
 .../userspace-api/media/dvb/net-add-if.rst         |    60 +
 .../userspace-api/media/dvb/net-get-if.rst         |    59 +
 .../userspace-api/media/dvb/net-remove-if.rst      |    55 +
 .../userspace-api/media/dvb/net-types.rst          |    16 +
 Documentation/userspace-api/media/dvb/net.rst      |    48 +
 .../media/dvb/query-dvb-frontend-info.rst          |    20 +
 .../userspace-api/media/dvb/video-clear-buffer.rst |    63 +
 .../userspace-api/media/dvb/video-command.rst      |   105 +
 .../userspace-api/media/dvb/video-continue.rst     |    66 +
 .../userspace-api/media/dvb/video-fast-forward.rst |    83 +
 .../userspace-api/media/dvb/video-fclose.rst       |    62 +
 .../userspace-api/media/dvb/video-fopen.rst        |   122 +
 .../userspace-api/media/dvb/video-freeze.rst       |    70 +
 .../userspace-api/media/dvb/video-fwrite.rst       |    90 +
 .../media/dvb/video-get-capabilities.rst           |    70 +
 .../userspace-api/media/dvb/video-get-event.rst    |   114 +
 .../media/dvb/video-get-frame-count.rst            |    74 +
 .../userspace-api/media/dvb/video-get-pts.rst      |    78 +
 .../userspace-api/media/dvb/video-get-size.rst     |    78 +
 .../userspace-api/media/dvb/video-get-status.rst   |    80 +
 .../userspace-api/media/dvb/video-play.rst         |    66 +
 .../media/dvb/video-select-source.rst              |    84 +
 .../userspace-api/media/dvb/video-set-blank.rst    |    73 +
 .../media/dvb/video-set-display-format.rst         |    69 +
 .../userspace-api/media/dvb/video-set-format.rst   |    92 +
 .../media/dvb/video-set-streamtype.rst             |    70 +
 .../userspace-api/media/dvb/video-slowmotion.rst   |    83 +
 .../userspace-api/media/dvb/video-stillpicture.rst |    70 +
 .../userspace-api/media/dvb/video-stop.rst         |    83 +
 .../userspace-api/media/dvb/video-try-command.rst  |    75 +
 Documentation/userspace-api/media/dvb/video.rst    |    43 +
 .../media/dvb/video_function_calls.rst             |    42 +
 .../userspace-api/media/dvb/video_types.rst        |   255 +
 Documentation/userspace-api/media/fdl-appendix.rst |   478 +
 .../media/frontend.h.rst.exceptions                |     0
 Documentation/userspace-api/media/gen-errors.rst   |   103 +
 Documentation/userspace-api/media/index.rst        |    67 +
 Documentation/{ =3D> userspace-api}/media/intro.rst  |     0
 .../media/lirc.h.rst.exceptions                    |     0
 .../media/media.h.rst.exceptions                   |     0
 .../media/mediactl/media-controller-intro.rst      |    40 +
 .../media/mediactl/media-controller-model.rst      |    42 +
 .../media/mediactl/media-controller.rst            |    62 +
 .../media/mediactl/media-func-close.rst            |    54 +
 .../media/mediactl/media-func-ioctl.rst            |    74 +
 .../media/mediactl/media-func-open.rst             |    76 +
 .../userspace-api/media/mediactl/media-funcs.rst   |    33 +
 .../userspace-api/media/mediactl/media-header.rst  |    17 +
 .../media/mediactl/media-ioc-device-info.rst       |   118 +
 .../media/mediactl/media-ioc-enum-entities.rst     |   156 +
 .../media/mediactl/media-ioc-enum-links.rst        |   157 +
 .../media/mediactl/media-ioc-g-topology.rst        |   307 +
 .../media/mediactl/media-ioc-request-alloc.rst     |    90 +
 .../media/mediactl/media-ioc-setup-link.rst        |    74 +
 .../media/mediactl/media-request-ioc-queue.rst     |   102 +
 .../media/mediactl/media-request-ioc-reinit.rst    |    75 +
 .../userspace-api/media/mediactl/media-types.rst   |   425 +
 .../userspace-api/media/mediactl/request-api.rst   |   276 +
 .../media/mediactl/request-func-close.rst          |    73 +
 .../media/mediactl/request-func-ioctl.rst          |    91 +
 .../media/mediactl/request-func-poll.rst           |   101 +
 .../{ =3D> userspace-api}/media/net.h.rst.exceptions |     0
 .../userspace-api/media/rc/keytable.c.rst          |   183 +
 .../userspace-api/media/rc/lirc-dev-intro.rst      |   171 +
 Documentation/userspace-api/media/rc/lirc-dev.rst  |    21 +
 Documentation/userspace-api/media/rc/lirc-func.rst |    34 +
 .../userspace-api/media/rc/lirc-get-features.rst   |   200 +
 .../userspace-api/media/rc/lirc-get-rec-mode.rst   |    74 +
 .../media/rc/lirc-get-rec-resolution.rst           |    54 +
 .../userspace-api/media/rc/lirc-get-send-mode.rst  |    78 +
 .../userspace-api/media/rc/lirc-get-timeout.rst    |    63 +
 .../userspace-api/media/rc/lirc-header.rst         |    17 +
 Documentation/userspace-api/media/rc/lirc-read.rst |    76 +
 .../media/rc/lirc-set-measure-carrier-mode.rst     |    53 +
 .../media/rc/lirc-set-rec-carrier-range.rst        |    54 +
 .../media/rc/lirc-set-rec-carrier.rst              |    53 +
 .../media/rc/lirc-set-rec-timeout-reports.rst      |    56 +
 .../media/rc/lirc-set-rec-timeout.rst              |    61 +
 .../media/rc/lirc-set-send-carrier.rst             |    48 +
 .../media/rc/lirc-set-send-duty-cycle.rst          |    54 +
 .../media/rc/lirc-set-transmitter-mask.rst         |    58 +
 .../media/rc/lirc-set-wideband-receiver.rst        |    63 +
 .../userspace-api/media/rc/lirc-write.rst          |    82 +
 Documentation/userspace-api/media/rc/rc-intro.rst  |    31 +
 .../uapi =3D> userspace-api/media}/rc/rc-protos.rst  |     0
 .../userspace-api/media/rc/rc-sysfs-nodes.rst      |   151 +
 .../userspace-api/media/rc/rc-table-change.rst     |    25 +
 Documentation/userspace-api/media/rc/rc-tables.rst |   766 ++
 .../userspace-api/media/rc/remote_controllers.rst  |    59 +
 .../userspace-api/media/typical_media_device.svg   |   116 +
 Documentation/userspace-api/media/v4l/app-pri.rst  |    37 +
 Documentation/userspace-api/media/v4l/async.rst    |    16 +
 Documentation/userspace-api/media/v4l/audio.rst    |   104 +
 Documentation/userspace-api/media/v4l/bayer.svg    |    56 +
 Documentation/userspace-api/media/v4l/biblio.rst   |   416 +
 Documentation/userspace-api/media/v4l/buffer.rst   |   817 ++
 .../userspace-api/media/v4l/capture-example.rst    |    20 +
 .../userspace-api/media/v4l/capture.c.rst          |   671 ++
 .../userspace-api/media/v4l/colorspaces-defs.rst   |   183 +
 .../media/v4l/colorspaces-details.rst              |   813 ++
 .../userspace-api/media/v4l/colorspaces.rst        |   170 +
 .../userspace-api/media/v4l/common-defs.rst        |    20 +
 Documentation/userspace-api/media/v4l/common.rst   |    65 +
 Documentation/userspace-api/media/v4l/compat.rst   |    25 +
 .../userspace-api/media/v4l/constraints.svg        |    37 +
 Documentation/userspace-api/media/v4l/control.rst  |   512 +
 Documentation/userspace-api/media/v4l/crop.rst     |   324 +
 Documentation/userspace-api/media/v4l/crop.svg     |   290 +
 .../userspace-api/media/v4l/depth-formats.rst      |    24 +
 .../userspace-api/media/v4l/dev-capture.rst        |   111 +
 .../media}/v4l/dev-decoder.rst                     |     0
 .../userspace-api/media/v4l/dev-event.rst          |    54 +
 .../userspace-api/media/v4l/dev-mem2mem.rst        |    49 +
 Documentation/userspace-api/media/v4l/dev-meta.rst |    74 +
 Documentation/userspace-api/media/v4l/dev-osd.rst  |   157 +
 .../userspace-api/media/v4l/dev-output.rst         |   108 +
 .../userspace-api/media/v4l/dev-overlay.rst        |   328 +
 .../userspace-api/media/v4l/dev-radio.rst          |    59 +
 .../userspace-api/media/v4l/dev-raw-vbi.rst        |   306 +
 Documentation/userspace-api/media/v4l/dev-rds.rst  |   191 +
 Documentation/userspace-api/media/v4l/dev-sdr.rst  |   114 +
 .../userspace-api/media/v4l/dev-sliced-vbi.rst     |   669 ++
 .../media}/v4l/dev-stateless-decoder.rst           |     0
 .../userspace-api/media/v4l/dev-subdev.rst         |   508 +
 .../userspace-api/media/v4l/dev-touch.rst          |    63 +
 Documentation/userspace-api/media/v4l/devices.rst  |    33 +
 Documentation/userspace-api/media/v4l/diff-v4l.rst |   693 ++
 Documentation/userspace-api/media/v4l/dmabuf.rst   |   169 +
 .../userspace-api/media/v4l/dv-timings.rst         |    45 +
 .../userspace-api/media/v4l/ext-ctrls-camera.rst   |   666 ++
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    |  4274 +++++++
 .../userspace-api/media/v4l/ext-ctrls-detect.rst   |    71 +
 .../userspace-api/media/v4l/ext-ctrls-dv.rst       |   166 +
 .../userspace-api/media/v4l/ext-ctrls-flash.rst    |   192 +
 .../userspace-api/media/v4l/ext-ctrls-fm-rx.rst    |    95 +
 .../userspace-api/media/v4l/ext-ctrls-fm-tx.rst    |   188 +
 .../media/v4l/ext-ctrls-image-process.rst          |    63 +
 .../media/v4l/ext-ctrls-image-source.rst           |    67 +
 .../userspace-api/media/v4l/ext-ctrls-jpeg.rst     |   113 +
 .../userspace-api/media/v4l/ext-ctrls-rf-tuner.rst |    96 +
 .../userspace-api/media/v4l/extended-controls.rst  |   180 +
 .../userspace-api/media/v4l/field-order.rst        |   172 +
 .../userspace-api/media/v4l/fieldseq_bt.svg        |  2621 +++++
 .../userspace-api/media/v4l/fieldseq_tb.svg        |  2618 +++++
 Documentation/userspace-api/media/v4l/format.rst   |    99 +
 .../media/v4l}/fourcc.rst                          |     0
 .../userspace-api/media/v4l/func-close.rst         |    56 +
 .../userspace-api/media/v4l/func-ioctl.rst         |    69 +
 .../userspace-api/media/v4l/func-mmap.rst          |   148 +
 .../userspace-api/media/v4l/func-munmap.rst        |    65 +
 .../userspace-api/media/v4l/func-open.rst          |    90 +
 .../userspace-api/media/v4l/func-poll.rst          |   124 +
 .../userspace-api/media/v4l/func-read.rst          |   140 +
 .../userspace-api/media/v4l/func-select.rst        |   127 +
 .../userspace-api/media/v4l/func-write.rst         |    91 +
 .../userspace-api/media/v4l/hist-v4l2.rst          |  1374 +++
 .../userspace-api/media/v4l/hsv-formats.rst        |    26 +
 Documentation/userspace-api/media/v4l/io.rst       |    58 +
 .../media/v4l/libv4l-introduction.rst              |   191 +
 Documentation/userspace-api/media/v4l/libv4l.rst   |    20 +
 .../userspace-api/media/v4l/meta-formats.rst       |    27 +
 Documentation/userspace-api/media/v4l/mmap.rst     |   292 +
 Documentation/userspace-api/media/v4l/nv12mt.svg   |   477 +
 .../userspace-api/media/v4l/nv12mt_example.svg     |  1616 +++
 Documentation/userspace-api/media/v4l/open.rst     |   165 +
 .../uapi =3D> userspace-api/media}/v4l/pipeline.dot  |     0
 .../userspace-api/media/v4l/pixfmt-bayer.rst       |    39 +
 .../media}/v4l/pixfmt-cnf4.rst                     |     0
 .../userspace-api/media/v4l/pixfmt-compressed.rst  |   232 +
 .../userspace-api/media/v4l/pixfmt-grey.rst        |    51 +
 .../userspace-api/media/v4l/pixfmt-indexed.rst     |    54 +
 .../userspace-api/media/v4l/pixfmt-intro.rst       |    58 +
 .../userspace-api/media/v4l/pixfmt-inzi.rst        |    89 +
 .../userspace-api/media/v4l/pixfmt-m420.rst        |   133 +
 .../userspace-api/media/v4l/pixfmt-meta-d4xx.rst   |   220 +
 .../media/v4l/pixfmt-meta-intel-ipu3.rst           |   104 +
 .../userspace-api/media/v4l/pixfmt-meta-uvc.rst    |    58 +
 .../userspace-api/media/v4l/pixfmt-meta-vivid.rst  |    60 +
 .../media/v4l/pixfmt-meta-vsp1-hgo.rst             |   175 +
 .../media/v4l/pixfmt-meta-vsp1-hgt.rst             |   136 +
 .../userspace-api/media/v4l/pixfmt-nv12.rst        |   136 +
 .../userspace-api/media/v4l/pixfmt-nv12m.rst       |   151 +
 .../userspace-api/media/v4l/pixfmt-nv12mt.rst      |    67 +
 .../userspace-api/media/v4l/pixfmt-nv16.rst        |   160 +
 .../userspace-api/media/v4l/pixfmt-nv16m.rst       |   164 +
 .../userspace-api/media/v4l/pixfmt-nv24.rst        |   102 +
 .../userspace-api/media/v4l/pixfmt-packed-hsv.rst  |   164 +
 .../userspace-api/media/v4l/pixfmt-packed-yuv.rst  |   380 +
 .../userspace-api/media/v4l/pixfmt-reserved.rst    |   282 +
 .../userspace-api/media/v4l/pixfmt-rgb.rst         |  1304 +++
 .../userspace-api/media/v4l/pixfmt-sdr-cs08.rst    |    37 +
 .../userspace-api/media/v4l/pixfmt-sdr-cs14le.rst  |    41 +
 .../userspace-api/media/v4l/pixfmt-sdr-cu08.rst    |    37 +
 .../userspace-api/media/v4l/pixfmt-sdr-cu16le.rst  |    41 +
 .../userspace-api/media/v4l/pixfmt-sdr-pcu16be.rst |    62 +
 .../userspace-api/media/v4l/pixfmt-sdr-pcu18be.rst |    62 +
 .../userspace-api/media/v4l/pixfmt-sdr-pcu20be.rst |    62 +
 .../userspace-api/media/v4l/pixfmt-sdr-ru12le.rst  |    39 +
 .../media/v4l/pixfmt-srggb10-ipu3.rst              |   342 +
 .../userspace-api/media/v4l/pixfmt-srggb10.rst     |    83 +
 .../media/v4l/pixfmt-srggb10alaw8.rst              |    31 +
 .../media/v4l/pixfmt-srggb10dpcm8.rst              |    35 +
 .../userspace-api/media/v4l/pixfmt-srggb10p.rst    |    81 +
 .../userspace-api/media/v4l/pixfmt-srggb12.rst     |    84 +
 .../userspace-api/media/v4l/pixfmt-srggb12p.rst    |    94 +
 .../userspace-api/media/v4l/pixfmt-srggb14.rst     |    82 +
 .../userspace-api/media/v4l/pixfmt-srggb14p.rst    |   152 +
 .../userspace-api/media/v4l/pixfmt-srggb16.rst     |    76 +
 .../userspace-api/media/v4l/pixfmt-srggb8.rst      |    61 +
 .../userspace-api/media/v4l/pixfmt-tch-td08.rst    |    59 +
 .../userspace-api/media/v4l/pixfmt-tch-td16.rst    |    74 +
 .../userspace-api/media/v4l/pixfmt-tch-tu08.rst    |    57 +
 .../userspace-api/media/v4l/pixfmt-tch-tu16.rst    |    73 +
 .../userspace-api/media/v4l/pixfmt-uv8.rst         |    54 +
 .../userspace-api/media/v4l/pixfmt-uyvy.rst        |   117 +
 .../userspace-api/media/v4l/pixfmt-v4l2-mplane.rst |   138 +
 .../userspace-api/media/v4l/pixfmt-v4l2.rst        |   171 +
 .../userspace-api/media/v4l/pixfmt-vyuy.rst        |   115 +
 .../userspace-api/media/v4l/pixfmt-y10.rst         |    72 +
 .../userspace-api/media/v4l/pixfmt-y10b.rst        |    40 +
 .../userspace-api/media/v4l/pixfmt-y10p.rst        |    50 +
 .../userspace-api/media/v4l/pixfmt-y12.rst         |    72 +
 .../userspace-api/media/v4l/pixfmt-y12i.rst        |    43 +
 .../userspace-api/media/v4l/pixfmt-y14.rst         |    72 +
 .../userspace-api/media/v4l/pixfmt-y16-be.rst      |    76 +
 .../userspace-api/media/v4l/pixfmt-y16.rst         |    76 +
 .../userspace-api/media/v4l/pixfmt-y41p.rst        |   158 +
 .../userspace-api/media/v4l/pixfmt-y8i.rst         |    73 +
 .../userspace-api/media/v4l/pixfmt-yuv410.rst      |   134 +
 .../userspace-api/media/v4l/pixfmt-yuv411p.rst     |   122 +
 .../userspace-api/media/v4l/pixfmt-yuv420.rst      |   150 +
 .../userspace-api/media/v4l/pixfmt-yuv420m.rst     |   159 +
 .../userspace-api/media/v4l/pixfmt-yuv422m.rst     |   148 +
 .../userspace-api/media/v4l/pixfmt-yuv422p.rst     |   136 +
 .../userspace-api/media/v4l/pixfmt-yuv444m.rst     |   148 +
 .../userspace-api/media/v4l/pixfmt-yuyv.rst        |   125 +
 .../userspace-api/media/v4l/pixfmt-yvyu.rst        |   115 +
 .../userspace-api/media/v4l/pixfmt-z16.rst         |    73 +
 Documentation/userspace-api/media/v4l/pixfmt.rst   |    45 +
 .../userspace-api/media/v4l/planar-apis.rst        |    68 +
 Documentation/userspace-api/media/v4l/querycap.rst |    41 +
 Documentation/userspace-api/media/v4l/rw.rst       |    54 +
 .../userspace-api/media/v4l/sdr-formats.rst        |    29 +
 .../media/v4l/selection-api-configuration.rst      |   144 +
 .../media/v4l/selection-api-examples.rst           |    91 +
 .../media/v4l/selection-api-intro.rst              |    35 +
 .../media/v4l/selection-api-targets.rst            |    27 +
 .../media/v4l/selection-api-vs-crop-api.rst        |    46 +
 .../userspace-api/media/v4l/selection-api.rst      |    23 +
 .../userspace-api/media/v4l/selection.svg          |  1178 ++
 .../userspace-api/media/v4l/selections-common.rst  |    30 +
 Documentation/userspace-api/media/v4l/standard.rst |   192 +
 .../userspace-api/media/v4l/streaming-par.rst      |    40 +
 .../userspace-api/media/v4l/subdev-formats.rst     |  7833 +++++++++++++
 .../media/v4l/subdev-image-processing-crop.svg     |   312 +
 .../media/v4l/subdev-image-processing-full.svg     |   752 ++
 ...ubdev-image-processing-scaling-multi-source.svg |   550 +
 .../userspace-api/media/v4l/tch-formats.rst        |    25 +
 Documentation/userspace-api/media/v4l/tuner.rst    |    92 +
 .../userspace-api/media/v4l/user-func.rst          |    89 +
 Documentation/userspace-api/media/v4l/userp.rst    |   128 +
 .../media/v4l/v4l2-selection-flags.rst             |    51 +
 .../media/v4l/v4l2-selection-targets.rst           |    78 +
 Documentation/userspace-api/media/v4l/v4l2.rst     |   423 +
 .../userspace-api/media/v4l/v4l2grab-example.rst   |    24 +
 .../userspace-api/media/v4l/v4l2grab.c.rst         |   176 +
 Documentation/userspace-api/media/v4l/vbi_525.svg  |   821 ++
 Documentation/userspace-api/media/v4l/vbi_625.svg  |   870 ++
 .../userspace-api/media/v4l/vbi_hsync.svg          |   321 +
 Documentation/userspace-api/media/v4l/video.rst    |    75 +
 Documentation/userspace-api/media/v4l/videodev.rst |    16 +
 .../userspace-api/media/v4l/vidioc-create-bufs.rst |   141 +
 .../userspace-api/media/v4l/vidioc-cropcap.rst     |   143 +
 .../media/v4l/vidioc-dbg-g-chip-info.rst           |   167 +
 .../media/v4l/vidioc-dbg-g-register.rst            |   171 +
 .../userspace-api/media/v4l/vidioc-decoder-cmd.rst |   226 +
 .../userspace-api/media/v4l/vidioc-dqevent.rst     |   391 +
 .../media/v4l/vidioc-dv-timings-cap.rst            |   169 +
 .../userspace-api/media/v4l/vidioc-encoder-cmd.rst |   168 +
 .../media/v4l/vidioc-enum-dv-timings.rst           |   114 +
 .../userspace-api/media/v4l/vidioc-enum-fmt.rst    |   195 +
 .../media/v4l/vidioc-enum-frameintervals.rst       |   203 +
 .../media/v4l/vidioc-enum-framesizes.rst           |   213 +
 .../media/v4l/vidioc-enum-freq-bands.rst           |   150 +
 .../userspace-api/media/v4l/vidioc-enumaudio.rst   |    62 +
 .../media/v4l/vidioc-enumaudioout.rst              |    67 +
 .../userspace-api/media/v4l/vidioc-enuminput.rst   |   242 +
 .../userspace-api/media/v4l/vidioc-enumoutput.rst  |   165 +
 .../userspace-api/media/v4l/vidioc-enumstd.rst     |   367 +
 .../userspace-api/media/v4l/vidioc-expbuf.rst      |   175 +
 .../userspace-api/media/v4l/vidioc-g-audio.rst     |   135 +
 .../userspace-api/media/v4l/vidioc-g-audioout.rst  |   108 +
 .../userspace-api/media/v4l/vidioc-g-crop.rst      |   119 +
 .../userspace-api/media/v4l/vidioc-g-ctrl.rst      |   106 +
 .../media/v4l/vidioc-g-dv-timings.rst              |   318 +
 .../userspace-api/media/v4l/vidioc-g-edid.rst      |   154 +
 .../userspace-api/media/v4l/vidioc-g-enc-index.rst |   156 +
 .../userspace-api/media/v4l/vidioc-g-ext-ctrls.rst |   416 +
 .../userspace-api/media/v4l/vidioc-g-fbuf.rst      |   362 +
 .../userspace-api/media/v4l/vidioc-g-fmt.rst       |   161 +
 .../userspace-api/media/v4l/vidioc-g-frequency.rst |   112 +
 .../userspace-api/media/v4l/vidioc-g-input.rst     |    71 +
 .../userspace-api/media/v4l/vidioc-g-jpegcomp.rst  |   134 +
 .../userspace-api/media/v4l/vidioc-g-modulator.rst |   202 +
 .../userspace-api/media/v4l/vidioc-g-output.rst    |    73 +
 .../userspace-api/media/v4l/vidioc-g-parm.rst      |   270 +
 .../userspace-api/media/v4l/vidioc-g-priority.rst  |   100 +
 .../userspace-api/media/v4l/vidioc-g-selection.rst |   200 +
 .../media/v4l/vidioc-g-sliced-vbi-cap.rst          |   202 +
 .../userspace-api/media/v4l/vidioc-g-std.rst       |    87 +
 .../userspace-api/media/v4l/vidioc-g-tuner.rst     |   476 +
 .../userspace-api/media/v4l/vidioc-log-status.rst  |    56 +
 .../userspace-api/media/v4l/vidioc-overlay.rst     |    61 +
 .../userspace-api/media/v4l/vidioc-prepare-buf.rst |    65 +
 .../userspace-api/media/v4l/vidioc-qbuf.rst        |   205 +
 .../media/v4l/vidioc-query-dv-timings.rst          |    94 +
 .../userspace-api/media/v4l/vidioc-querybuf.rst    |    87 +
 .../userspace-api/media/v4l/vidioc-querycap.rst    |   290 +
 .../userspace-api/media/v4l/vidioc-queryctrl.rst   |   616 +
 .../userspace-api/media/v4l/vidioc-querystd.rst    |    77 +
 .../userspace-api/media/v4l/vidioc-reqbufs.rst     |   169 +
 .../media/v4l/vidioc-s-hw-freq-seek.rst            |   147 +
 .../userspace-api/media/v4l/vidioc-streamon.rst    |   113 +
 .../v4l/vidioc-subdev-enum-frame-interval.rst      |   120 +
 .../media/v4l/vidioc-subdev-enum-frame-size.rst    |   125 +
 .../media/v4l/vidioc-subdev-enum-mbus-code.rst     |    98 +
 .../media/v4l/vidioc-subdev-g-crop.rst             |   134 +
 .../media/v4l/vidioc-subdev-g-fmt.rst              |   162 +
 .../media/v4l/vidioc-subdev-g-frame-interval.rst   |   128 +
 .../media/v4l/vidioc-subdev-g-selection.rst        |   133 +
 .../media/v4l/vidioc-subdev-querycap.rst           |   112 +
 .../media/v4l/vidioc-subscribe-event.rst           |   123 +
 .../userspace-api/media/v4l/yuv-formats.rst        |    64 +
 .../media/video.h.rst.exceptions                   |     0
 .../userspace-api/media/videodev2.h.rst.exceptions |   573 +
 MAINTAINERS                                        |   101 +-
 arch/arm/configs/exynos_defconfig                  |     2 +-
 arch/arm/configs/multi_v7_defconfig                |     2 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |     2 +-
 drivers/media/Kconfig                              |   242 +-
 drivers/media/Makefile                             |     2 +-
 drivers/media/cec/Kconfig                          |    25 +
 drivers/media/cec/Makefile                         |    16 +-
 drivers/media/cec/cec-adap.c                       |  2199 ----
 drivers/media/cec/core/Makefile                    |    16 +
 drivers/media/cec/core/cec-adap.c                  |  2199 ++++
 drivers/media/cec/{ =3D> core}/cec-api.c             |     0
 drivers/media/cec/{ =3D> core}/cec-core.c            |     0
 drivers/media/cec/{ =3D> core}/cec-notifier.c        |     0
 drivers/media/cec/{ =3D> core}/cec-pin-error-inj.c   |     0
 drivers/media/cec/{ =3D> core}/cec-pin-priv.h        |     0
 drivers/media/cec/{ =3D> core}/cec-pin.c             |     0
 drivers/media/cec/{ =3D> core}/cec-priv.h            |     0
 drivers/media/cec/platform/Kconfig                 |   120 +
 drivers/media/cec/platform/Makefile                |    14 +
 drivers/media/{ =3D> cec}/platform/cec-gpio/Makefile |     0
 drivers/media/cec/platform/cec-gpio/cec-gpio.c     |   302 +
 drivers/media/cec/platform/cros-ec/Makefile        |     2 +
 .../platform/cros-ec}/cros-ec-cec.c                |     0
 drivers/media/cec/platform/meson/Makefile          |     3 +
 .../media/{ =3D> cec}/platform/meson/ao-cec-g12a.c   |     0
 drivers/media/{ =3D> cec}/platform/meson/ao-cec.c    |     0
 drivers/media/cec/platform/s5p/Makefile            |     3 +
 .../s5p-cec =3D> cec/platform/s5p}/exynos_hdmi_cec.h |     0
 .../platform/s5p}/exynos_hdmi_cecctrl.c            |     0
 .../s5p-cec =3D> cec/platform/s5p}/regs-cec.h        |     0
 .../s5p-cec =3D> cec/platform/s5p}/s5p_cec.c         |     0
 .../s5p-cec =3D> cec/platform/s5p}/s5p_cec.h         |     0
 drivers/media/cec/platform/seco/Makefile           |     2 +
 drivers/media/cec/platform/seco/seco-cec.c         |   803 ++
 .../seco-cec =3D> cec/platform/seco}/seco-cec.h      |     0
 drivers/media/cec/platform/sti/Makefile            |     2 +
 .../sti/cec =3D> cec/platform/sti}/stih-cec.c        |     0
 drivers/media/cec/platform/stm32/Makefile          |     2 +
 drivers/media/{ =3D> cec}/platform/stm32/stm32-cec.c |     0
 drivers/media/cec/platform/tegra/Makefile          |     2 +
 .../tegra-cec =3D> cec/platform/tegra}/tegra_cec.c   |     0
 .../tegra-cec =3D> cec/platform/tegra}/tegra_cec.h   |     0
 drivers/media/cec/usb/Kconfig                      |     8 +
 drivers/media/cec/usb/Makefile                     |     6 +
 drivers/media/cec/usb/pulse8/Kconfig               |    13 +
 .../{usb/pulse8-cec =3D> cec/usb/pulse8}/Makefile    |     0
 .../pulse8-cec =3D> cec/usb/pulse8}/pulse8-cec.c     |     0
 drivers/media/cec/usb/rainshadow/Kconfig           |    13 +
 .../rainshadow-cec =3D> cec/usb/rainshadow}/Makefile |     0
 .../usb/rainshadow}/rainshadow-cec.c               |     0
 drivers/media/common/Kconfig                       |     2 +-
 drivers/media/dvb-core/Kconfig                     |    27 +
 drivers/media/dvb-core/dvbdev.c                    |     5 +-
 drivers/media/dvb-frontends/Kconfig                |    16 +-
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c  |     2 +-
 drivers/media/dvb-frontends/dib3000.h              |     2 +-
 drivers/media/dvb-frontends/dib3000mb.c            |     2 +-
 drivers/media/dvb-frontends/drxk_hard.c            |     2 +-
 drivers/media/dvb-frontends/eds1547.h              |     2 +-
 drivers/media/dvb-frontends/lgdt3306a.c            |    14 +
 drivers/media/dvb-frontends/m88ds3103.c            |     4 +-
 drivers/media/dvb-frontends/stv0900_core.c         |     2 +-
 drivers/media/dvb-frontends/z0194a.h               |     2 +-
 drivers/media/firewire/Kconfig                     |     5 +-
 drivers/media/i2c/Kconfig                          |   457 +-
 drivers/media/i2c/Makefile                         |     1 +
 drivers/media/i2c/cx25840/cx25840-core.c           |    40 +-
 drivers/media/i2c/et8ek8/Kconfig                   |     4 +-
 drivers/media/i2c/imx219.c                         |   110 +-
 drivers/media/i2c/m5mols/Kconfig                   |     5 +-
 drivers/media/i2c/max2175.c                        |     6 +-
 drivers/media/i2c/ov13858.c                        |    13 +-
 drivers/media/i2c/ov2740.c                         |  1016 ++
 drivers/media/i2c/ov5640.c                         |     4 +-
 drivers/media/i2c/ov5670.c                         |    14 +-
 drivers/media/i2c/ov8856.c                         |   191 +-
 drivers/media/i2c/s5k5baf.c                        |     2 +-
 drivers/media/i2c/smiapp/Kconfig                   |     5 +-
 drivers/media/mc/Kconfig                           |    19 +-
 drivers/media/mc/mc-entity.c                       |     2 +-
 drivers/media/mmc/Kconfig                          |     1 -
 drivers/media/mmc/siano/Kconfig                    |     2 +
 drivers/media/pci/Kconfig                          |    14 +-
 drivers/media/pci/bt8xx/Kconfig                    |     2 +-
 drivers/media/pci/cobalt/Kconfig                   |     4 +-
 drivers/media/pci/cx18/cx18-ioctl.c                |    22 +-
 drivers/media/pci/cx18/cx18-streams.c              |     4 +-
 drivers/media/pci/cx23885/cx23885-cards.c          |    51 +-
 drivers/media/pci/cx23885/cx23885-dvb.c            |    31 +
 drivers/media/pci/cx23885/cx23885-video.c          |    99 +-
 drivers/media/pci/cx88/cx88-core.c                 |     3 +-
 drivers/media/pci/cx88/cx88-input.c                |     2 +-
 drivers/media/pci/cx88/cx88-video.c                |     2 +-
 drivers/media/pci/ddbridge/Kconfig                 |     1 -
 drivers/media/pci/ddbridge/Makefile                |     2 +-
 drivers/media/pci/ddbridge/ddbridge-core.c         |     4 +-
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c     |   153 +
 drivers/media/pci/ddbridge/ddbridge-dummy-fe.h     |    16 +
 drivers/media/pci/intel/ipu3/Kconfig               |     4 +-
 drivers/media/pci/ivtv/ivtv-ioctl.c                |    26 +-
 drivers/media/pci/mantis/mantis_dvb.c              |     2 +-
 drivers/media/pci/meye/Kconfig                     |     2 +-
 drivers/media/pci/saa7134/saa7134-input.c          |     2 +-
 drivers/media/pci/sta2x11/Kconfig                  |     6 +-
 drivers/media/platform/Kconfig                     |   191 +-
 drivers/media/platform/Makefile                    |    19 -
 drivers/media/platform/am437x/Kconfig              |     4 +-
 drivers/media/platform/atmel/Kconfig               |     4 +-
 drivers/media/platform/cadence/Kconfig             |     8 +-
 drivers/media/platform/cec-gpio/cec-gpio.c         |   298 -
 drivers/media/platform/coda/coda-bit.c             |     9 +-
 drivers/media/platform/coda/coda-common.c          |   199 +-
 drivers/media/platform/coda/coda-jpeg.c            |   577 +
 drivers/media/platform/coda/coda.h                 |    12 +-
 drivers/media/platform/cros-ec-cec/Makefile        |     2 -
 drivers/media/platform/davinci/vpif_display.c      |     1 -
 drivers/media/platform/exynos4-is/Kconfig          |     5 +-
 drivers/media/platform/marvell-ccic/cafe-driver.c  |     2 +-
 drivers/media/platform/meson/Makefile              |     3 -
 drivers/media/platform/mtk-mdp/mtk_mdp_comp.c      |     8 +-
 drivers/media/platform/pxa_camera.c                |     4 +-
 drivers/media/platform/qcom/venus/core.c           |    21 +-
 drivers/media/platform/qcom/venus/core.h           |     7 +-
 drivers/media/platform/qcom/venus/helpers.c        |    18 +-
 drivers/media/platform/qcom/venus/helpers.h        |     2 +-
 drivers/media/platform/qcom/venus/hfi.c            |    10 +-
 drivers/media/platform/qcom/venus/hfi.h            |     3 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h       |     2 +-
 drivers/media/platform/qcom/venus/hfi_msgs.c       |     2 +
 drivers/media/platform/qcom/venus/hfi_msgs.h       |    10 +-
 drivers/media/platform/qcom/venus/vdec.c           |   200 +-
 drivers/media/platform/qcom/venus/venc.c           |    10 +-
 drivers/media/platform/rcar-fcp.c                  |     5 +
 drivers/media/platform/rcar-vin/Kconfig            |     8 +-
 drivers/media/platform/rcar-vin/rcar-csi2.c        |     4 +-
 drivers/media/platform/rcar-vin/rcar-v4l2.c        |    40 +-
 drivers/media/platform/s5p-cec/Makefile            |     3 -
 drivers/media/platform/seco-cec/Makefile           |     2 -
 drivers/media/platform/seco-cec/seco-cec.c         |   803 --
 drivers/media/platform/sh_veu.c                    |  1203 --
 drivers/media/platform/sti/cec/Makefile            |     2 -
 drivers/media/platform/stm32/Makefile              |     1 -
 drivers/media/platform/sunxi/Kconfig               |     2 +
 drivers/media/platform/sunxi/Makefile              |     2 +
 drivers/media/platform/sunxi/sun4i-csi/Kconfig     |     6 +-
 drivers/media/platform/sunxi/sun4i-csi/Makefile    |     2 +
 drivers/media/platform/sunxi/sun6i-csi/Kconfig     |     4 +-
 drivers/media/platform/sunxi/sun8i-di/sun8i-di.c   |     6 +-
 drivers/media/platform/tegra-cec/Makefile          |     2 -
 drivers/media/platform/ti-vpe/cal.c                |   439 +-
 drivers/media/platform/ti-vpe/cal_regs.h           |    21 +-
 drivers/media/platform/vicodec/Kconfig             |    13 -
 drivers/media/platform/vicodec/vicodec-core.c      |  2238 ----
 drivers/media/platform/video-mux.c                 |    87 +-
 drivers/media/platform/vim2m.c                     |  1441 ---
 drivers/media/platform/vimc/Kconfig                |    15 -
 drivers/media/platform/vimc/vimc-capture.c         |   480 -
 drivers/media/platform/vimc/vimc-common.c          |   369 -
 drivers/media/platform/vimc/vimc-common.h          |   224 -
 drivers/media/platform/vimc/vimc-core.c            |   381 -
 drivers/media/platform/vimc/vimc-debayer.c         |   581 -
 drivers/media/platform/vimc/vimc-scaler.c          |   511 -
 drivers/media/platform/vimc/vimc-sensor.c          |   376 -
 drivers/media/platform/vimc/vimc-streamer.h        |    44 -
 drivers/media/platform/vivid/Kconfig               |    41 -
 drivers/media/platform/xilinx/Kconfig              |     4 +-
 drivers/media/radio/Kconfig                        |    12 +-
 drivers/media/radio/si470x/Kconfig                 |     2 +-
 drivers/media/radio/wl128x/Kconfig                 |     5 +-
 drivers/media/rc/gpio-ir-tx.c                      |    51 +-
 drivers/media/rc/iguanair.c                        |    36 +-
 drivers/media/rc/ir-rx51.c                         |     2 +-
 drivers/media/rc/rc-core-priv.h                    |    22 +
 drivers/media/spi/Kconfig                          |     8 +-
 drivers/media/test-drivers/Kconfig                 |    26 +
 drivers/media/test-drivers/Makefile                |     9 +
 drivers/media/test-drivers/vicodec/Kconfig         |    15 +
 .../{platform =3D> test-drivers}/vicodec/Makefile    |     0
 .../vicodec/codec-fwht.c                           |     0
 .../vicodec/codec-fwht.h                           |     0
 .../vicodec/codec-v4l2-fwht.c                      |     0
 .../vicodec/codec-v4l2-fwht.h                      |     0
 drivers/media/test-drivers/vicodec/vicodec-core.c  |  2241 ++++
 drivers/media/test-drivers/vim2m.c                 |  1433 +++
 drivers/media/test-drivers/vimc/Kconfig            |    17 +
 .../media/{platform =3D> test-drivers}/vimc/Makefile |     0
 drivers/media/test-drivers/vimc/vimc-capture.c     |   499 +
 drivers/media/test-drivers/vimc/vimc-common.c      |   400 +
 drivers/media/test-drivers/vimc/vimc-common.h      |   232 +
 drivers/media/test-drivers/vimc/vimc-core.c        |   369 +
 drivers/media/test-drivers/vimc/vimc-debayer.c     |   623 ++
 drivers/media/test-drivers/vimc/vimc-scaler.c      |   522 +
 drivers/media/test-drivers/vimc/vimc-sensor.c      |   381 +
 .../vimc/vimc-streamer.c                           |     0
 drivers/media/test-drivers/vimc/vimc-streamer.h    |    45 +
 drivers/media/test-drivers/vivid/Kconfig           |    43 +
 .../{platform =3D> test-drivers}/vivid/Makefile      |     0
 .../{platform =3D> test-drivers}/vivid/vivid-cec.c   |     0
 .../{platform =3D> test-drivers}/vivid/vivid-cec.h   |     0
 .../{platform =3D> test-drivers}/vivid/vivid-core.c  |     0
 .../{platform =3D> test-drivers}/vivid/vivid-core.h  |     0
 .../{platform =3D> test-drivers}/vivid/vivid-ctrls.c |     0
 .../{platform =3D> test-drivers}/vivid/vivid-ctrls.h |     0
 .../vivid/vivid-kthread-cap.c                      |     0
 .../vivid/vivid-kthread-cap.h                      |     0
 .../vivid/vivid-kthread-out.c                      |     0
 .../vivid/vivid-kthread-out.h                      |     0
 .../vivid/vivid-kthread-touch.c                    |     0
 .../vivid/vivid-kthread-touch.h                    |     0
 .../vivid/vivid-meta-cap.c                         |     0
 .../vivid/vivid-meta-cap.h                         |     0
 .../vivid/vivid-meta-out.c                         |     0
 .../vivid/vivid-meta-out.h                         |     0
 .../{platform =3D> test-drivers}/vivid/vivid-osd.c   |     0
 .../{platform =3D> test-drivers}/vivid/vivid-osd.h   |     0
 .../vivid/vivid-radio-common.c                     |     0
 .../vivid/vivid-radio-common.h                     |     0
 .../vivid/vivid-radio-rx.c                         |     0
 .../vivid/vivid-radio-rx.h                         |     0
 .../vivid/vivid-radio-tx.c                         |     0
 .../vivid/vivid-radio-tx.h                         |     0
 .../vivid/vivid-rds-gen.c                          |     0
 .../vivid/vivid-rds-gen.h                          |     0
 .../vivid/vivid-sdr-cap.c                          |     0
 .../vivid/vivid-sdr-cap.h                          |     0
 .../vivid/vivid-touch-cap.c                        |     0
 .../vivid/vivid-touch-cap.h                        |     0
 .../vivid/vivid-vbi-cap.c                          |     0
 .../vivid/vivid-vbi-cap.h                          |     0
 .../vivid/vivid-vbi-gen.c                          |     0
 .../vivid/vivid-vbi-gen.h                          |     0
 .../vivid/vivid-vbi-out.c                          |     0
 .../vivid/vivid-vbi-out.h                          |     0
 .../vivid/vivid-vid-cap.c                          |     0
 .../vivid/vivid-vid-cap.h                          |     0
 .../vivid/vivid-vid-common.c                       |     0
 .../vivid/vivid-vid-common.h                       |     0
 .../vivid/vivid-vid-out.c                          |     0
 .../vivid/vivid-vid-out.h                          |     0
 drivers/media/tuners/Kconfig                       |     6 +-
 drivers/media/tuners/si2157.c                      |   419 +-
 drivers/media/tuners/si2157_priv.h                 |     2 +
 drivers/media/usb/Kconfig                          |    12 +-
 drivers/media/usb/Makefile                         |     2 -
 drivers/media/usb/cx231xx/cx231xx-avcore.c         |    35 +-
 drivers/media/usb/cx231xx/cx231xx-input.c          |     5 +-
 drivers/media/usb/cx231xx/cx231xx-video.c          |    85 +-
 drivers/media/usb/dvb-usb-v2/Kconfig               |    10 +-
 drivers/media/usb/dvb-usb-v2/ec168.c               |    25 +-
 drivers/media/usb/dvb-usb-v2/gl861.c               |     4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |     4 +-
 drivers/media/usb/dvb-usb-v2/lmedm04.h             |     2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c            |     2 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.h            |     2 +-
 drivers/media/usb/dvb-usb/Kconfig                  |     3 +-
 drivers/media/usb/dvb-usb/a800.c                   |     8 +-
 drivers/media/usb/dvb-usb/af9005-fe.c              |     2 +-
 drivers/media/usb/dvb-usb/af9005-remote.c          |     2 +-
 drivers/media/usb/dvb-usb/af9005.c                 |     6 +-
 drivers/media/usb/dvb-usb/af9005.h                 |     2 +-
 drivers/media/usb/dvb-usb/az6027.c                 |     6 +-
 drivers/media/usb/dvb-usb/cxusb.c                  |     6 +-
 drivers/media/usb/dvb-usb/dib0700.h                |    31 +-
 drivers/media/usb/dvb-usb/dib0700_core.c           |     6 +-
 drivers/media/usb/dvb-usb/dibusb-common.c          |     2 +-
 drivers/media/usb/dvb-usb/dibusb-mb.c              |     4 +-
 drivers/media/usb/dvb-usb/dibusb-mc-common.c       |     2 +-
 drivers/media/usb/dvb-usb/dibusb-mc.c              |     2 +-
 drivers/media/usb/dvb-usb/dibusb.h                 |     2 +-
 drivers/media/usb/dvb-usb/digitv.c                 |    31 +-
 drivers/media/usb/dvb-usb/dtt200u-fe.c             |     2 +-
 drivers/media/usb/dvb-usb/dtt200u.c                |     2 +-
 drivers/media/usb/dvb-usb/dtt200u.h                |     2 +-
 drivers/media/usb/dvb-usb/dvb-usb-common.h         |     3 +-
 drivers/media/usb/dvb-usb/dvb-usb-firmware.c       |     3 +-
 drivers/media/usb/dvb-usb/dvb-usb-init.c           |    10 +-
 drivers/media/usb/dvb-usb/dvb-usb.h                |    10 +-
 drivers/media/usb/dvb-usb/dw2102.c                 |    31 +-
 drivers/media/usb/dvb-usb/gp8psk.c                 |     2 +-
 drivers/media/usb/dvb-usb/gp8psk.h                 |     2 +-
 drivers/media/usb/dvb-usb/m920x.c                  |     6 +-
 drivers/media/usb/dvb-usb/nova-t-usb2.c            |     2 +-
 drivers/media/usb/dvb-usb/opera1.c                 |     2 +-
 drivers/media/usb/dvb-usb/technisat-usb2.c         |     4 +-
 drivers/media/usb/dvb-usb/ttusb2.c                 |     9 +-
 drivers/media/usb/dvb-usb/ttusb2.h                 |     2 +-
 drivers/media/usb/dvb-usb/umt-010.c                |     2 +-
 drivers/media/usb/dvb-usb/vp702x-fe.c              |     2 +-
 drivers/media/usb/dvb-usb/vp702x.c                 |     2 +-
 drivers/media/usb/dvb-usb/vp7045-fe.c              |     2 +-
 drivers/media/usb/dvb-usb/vp7045.c                 |     2 +-
 drivers/media/usb/dvb-usb/vp7045.h                 |     2 +-
 drivers/media/usb/gspca/Kconfig                    |     2 +-
 drivers/media/usb/gspca/mr97310a.c                 |     1 -
 drivers/media/usb/hdpvr/hdpvr-core.c               |     4 +-
 drivers/media/usb/hdpvr/hdpvr-i2c.c                |     2 +-
 drivers/media/usb/pulse8-cec/Kconfig               |    12 -
 drivers/media/usb/pvrusb2/pvrusb2-i2c-core.c       |     4 +-
 drivers/media/usb/pwc/pwc-ctrl.c                   |     2 +-
 drivers/media/usb/pwc/pwc-if.c                     |    54 +-
 drivers/media/usb/rainshadow-cec/Kconfig           |    12 -
 drivers/media/usb/ttusb-dec/ttusb_dec.c            |     9 +-
 drivers/media/usb/zr364xx/Kconfig                  |     2 +-
 drivers/media/v4l2-core/Kconfig                    |    27 +-
 drivers/media/v4l2-core/Makefile                   |     3 +
 drivers/media/v4l2-core/v4l2-common.c              |     3 +-
 drivers/media/v4l2-core/v4l2-ctrls.c               |    92 +-
 drivers/media/v4l2-core/v4l2-dev.c                 |    25 +-
 drivers/media/v4l2-core/v4l2-device.c              |     7 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |   104 +-
 drivers/media/v4l2-core/v4l2-h264.c                |   270 +
 drivers/media/v4l2-core/v4l2-ioctl.c               |    72 +-
 drivers/media/v4l2-core/v4l2-jpeg.c                |   632 ++
 drivers/media/v4l2-core/v4l2-mc.c                  |    95 +
 drivers/media/v4l2-core/v4l2-mem2mem.c             |    11 +-
 drivers/media/v4l2-core/v4l2-subdev.c              |    91 +-
 drivers/platform/x86/Kconfig                       |     1 +
 drivers/staging/media/Kconfig                      |     4 +
 drivers/staging/media/Makefile                     |     2 +
 drivers/staging/media/atomisp/Kconfig              |    36 +
 drivers/staging/media/atomisp/Makefile             |   363 +
 drivers/staging/media/atomisp/TODO                 |    89 +
 drivers/staging/media/atomisp/i2c/Kconfig          |    86 +
 drivers/staging/media/atomisp/i2c/Makefile         |    18 +
 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c |  1406 +++
 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c |  1139 ++
 .../media/atomisp/i2c/atomisp-libmsrlisthelper.c   |   207 +
 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c |   972 ++
 .../staging/media/atomisp/i2c/atomisp-mt9m114.c    |  1910 ++++
 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c |  1340 +++
 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c |  1288 +++
 drivers/staging/media/atomisp/i2c/gc0310.h         |   404 +
 drivers/staging/media/atomisp/i2c/gc2235.h         |   680 ++
 drivers/staging/media/atomisp/i2c/mt9m114.h        |  1791 +++
 drivers/staging/media/atomisp/i2c/ov2680.h         |   845 ++
 drivers/staging/media/atomisp/i2c/ov2722.h         |  1272 +++
 drivers/staging/media/atomisp/i2c/ov5693/Kconfig   |    11 +
 drivers/staging/media/atomisp/i2c/ov5693/Makefile  |     2 +
 drivers/staging/media/atomisp/i2c/ov5693/ad5823.h  |    62 +
 .../media/atomisp/i2c/ov5693/atomisp-ov5693.c      |  2006 ++++
 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h  |  1391 +++
 drivers/staging/media/atomisp/include/hmm/hmm.h    |   102 +
 drivers/staging/media/atomisp/include/hmm/hmm_bo.h |   315 +
 .../staging/media/atomisp/include/hmm/hmm_common.h |    96 +
 .../staging/media/atomisp/include/hmm/hmm_pool.h   |   115 +
 drivers/staging/media/atomisp/include/hmm/hmm_vm.h |    65 +
 .../staging/media/atomisp/include/linux/atomisp.h  |  1359 +++
 .../atomisp/include/linux/atomisp_gmin_platform.h  |    38 +
 .../media/atomisp/include/linux/atomisp_platform.h |   247 +
 .../media/atomisp/include/linux/libmsrlisthelper.h |    27 +
 .../staging/media/atomisp/include/media/lm3554.h   |   130 +
 .../staging/media/atomisp/include/mmu/isp_mmu.h    |   168 +
 .../media/atomisp/include/mmu/sh_mmu_mrfld.h       |    24 +
 drivers/staging/media/atomisp/pci/atomisp-regs.h   |   199 +
 drivers/staging/media/atomisp/pci/atomisp_acc.c    |   605 +
 drivers/staging/media/atomisp/pci/atomisp_acc.h    |   119 +
 drivers/staging/media/atomisp/pci/atomisp_cmd.c    |  6629 +++++++++++
 drivers/staging/media/atomisp/pci/atomisp_cmd.h    |   442 +
 drivers/staging/media/atomisp/pci/atomisp_common.h |    74 +
 drivers/staging/media/atomisp/pci/atomisp_compat.h |   663 ++
 .../media/atomisp/pci/atomisp_compat_css20.c       |  4706 ++++++++
 .../media/atomisp/pci/atomisp_compat_css20.h       |   277 +
 .../media/atomisp/pci/atomisp_compat_ioctl32.c     |  1177 ++
 .../media/atomisp/pci/atomisp_compat_ioctl32.h     |   367 +
 drivers/staging/media/atomisp/pci/atomisp_csi2.c   |   426 +
 drivers/staging/media/atomisp/pci/atomisp_csi2.h   |    58 +
 .../staging/media/atomisp/pci/atomisp_dfs_tables.h |    40 +
 drivers/staging/media/atomisp/pci/atomisp_drvfs.c  |   205 +
 drivers/staging/media/atomisp/pci/atomisp_drvfs.h  |    24 +
 drivers/staging/media/atomisp/pci/atomisp_file.c   |   227 +
 drivers/staging/media/atomisp/pci/atomisp_file.h   |    43 +
 drivers/staging/media/atomisp/pci/atomisp_fops.c   |  1306 +++
 drivers/staging/media/atomisp/pci/atomisp_fops.h   |    50 +
 .../media/atomisp/pci/atomisp_gmin_platform.c      |  1081 ++
 drivers/staging/media/atomisp/pci/atomisp_helper.h |    28 +
 .../staging/media/atomisp/pci/atomisp_internal.h   |   307 +
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c  |  3094 ++++++
 drivers/staging/media/atomisp/pci/atomisp_ioctl.h  |    66 +
 drivers/staging/media/atomisp/pci/atomisp_subdev.c |  1456 +++
 drivers/staging/media/atomisp/pci/atomisp_subdev.h |   466 +
 drivers/staging/media/atomisp/pci/atomisp_tables.h |   187 +
 drivers/staging/media/atomisp/pci/atomisp_tpg.c    |   163 +
 drivers/staging/media/atomisp/pci/atomisp_tpg.h    |    38 +
 .../media/atomisp/pci/atomisp_trace_event.h        |   127 +
 drivers/staging/media/atomisp/pci/atomisp_v4l2.c   |  1999 ++++
 drivers/staging/media/atomisp/pci/atomisp_v4l2.h   |    36 +
 .../pci/base/circbuf/interface/ia_css_circbuf.h    |   376 +
 .../base/circbuf/interface/ia_css_circbuf_comm.h   |    58 +
 .../base/circbuf/interface/ia_css_circbuf_desc.h   |   173 +
 .../media/atomisp/pci/base/circbuf/src/circbuf.c   |   320 +
 .../pci/base/refcount/interface/ia_css_refcount.h  |    83 +
 .../media/atomisp/pci/base/refcount/src/refcount.c |   275 +
 drivers/staging/media/atomisp/pci/bits.h           |   104 +
 .../camera/pipe/interface/ia_css_pipe_binarydesc.h |   297 +
 .../camera/pipe/interface/ia_css_pipe_stagedesc.h  |    51 +
 .../pci/camera/pipe/interface/ia_css_pipe_util.h   |    39 +
 .../atomisp/pci/camera/pipe/src/pipe_binarydesc.c  |   873 ++
 .../atomisp/pci/camera/pipe/src/pipe_stagedesc.c   |   118 +
 .../media/atomisp/pci/camera/pipe/src/pipe_util.c  |    50 +
 .../pci/camera/util/interface/ia_css_util.h        |   141 +
 .../media/atomisp/pci/camera/util/src/util.c       |   225 +
 drivers/staging/media/atomisp/pci/cell_params.h    |    40 +
 .../pci/css_2400_system/hive/ia_css_isp_configs.c  |   385 +
 .../pci/css_2400_system/hive/ia_css_isp_params.c   |  3419 ++++++
 .../pci/css_2400_system/hive/ia_css_isp_states.c   |   223 +
 .../hrt/hive_isp_css_irq_types_hrt.h               |    68 +
 .../css_2400_system/hrt/isp2400_mamoiada_params.h  |   228 +
 .../atomisp/pci/css_2401_system/csi_rx_global.h    |    63 +
 .../pci/css_2401_system/hive/ia_css_isp_configs.c  |   386 +
 .../pci/css_2401_system/hive/ia_css_isp_params.c   |  3366 ++++++
 .../pci/css_2401_system/hive/ia_css_isp_states.c   |   223 +
 .../atomisp/pci/css_2401_system/host/csi_rx.c      |    40 +
 .../pci/css_2401_system/host/csi_rx_local.h        |    62 +
 .../pci/css_2401_system/host/csi_rx_private.h      |   305 +
 .../atomisp/pci/css_2401_system/host/ibuf_ctrl.c   |    22 +
 .../pci/css_2401_system/host/ibuf_ctrl_local.h     |    58 +
 .../pci/css_2401_system/host/ibuf_ctrl_private.h   |   267 +
 .../atomisp/pci/css_2401_system/host/isys_dma.c    |    40 +
 .../pci/css_2401_system/host/isys_dma_local.h      |    20 +
 .../pci/css_2401_system/host/isys_dma_private.h    |    61 +
 .../atomisp/pci/css_2401_system/host/isys_irq.c    |    43 +
 .../pci/css_2401_system/host/isys_irq_local.h      |    35 +
 .../pci/css_2401_system/host/isys_irq_private.h    |   106 +
 .../pci/css_2401_system/host/isys_stream2mmio.c    |    21 +
 .../css_2401_system/host/isys_stream2mmio_local.h  |    36 +
 .../host/isys_stream2mmio_private.h                |   167 +
 .../pci/css_2401_system/host/pixelgen_local.h      |    50 +
 .../pci/css_2401_system/host/pixelgen_private.h    |   182 +
 .../css_2401_system/hrt/PixelGen_SysBlock_defs.h   |   113 +
 .../pci/css_2401_system/hrt/ibuf_cntrl_defs.h      |   134 +
 .../css_2401_system/hrt/mipi_backend_common_defs.h |   205 +
 .../pci/css_2401_system/hrt/mipi_backend_defs.h    |   208 +
 .../atomisp/pci/css_2401_system/hrt/rx_csi_defs.h  |   169 +
 .../pci/css_2401_system/hrt/stream2mmio_defs.h     |    68 +
 .../atomisp/pci/css_2401_system/ibuf_ctrl_global.h |    79 +
 .../atomisp/pci/css_2401_system/isys_dma_global.h  |    89 +
 .../atomisp/pci/css_2401_system/isys_irq_global.h  |    35 +
 .../pci/css_2401_system/isys_stream2mmio_global.h  |    39 +
 .../atomisp/pci/css_2401_system/pixelgen_global.h  |    90 +
 .../atomisp/pci/css_receiver_2400_common_defs.h    |   198 +
 .../media/atomisp/pci/css_receiver_2400_defs.h     |   256 +
 drivers/staging/media/atomisp/pci/css_trace.h      |   278 +
 drivers/staging/media/atomisp/pci/defs.h           |    36 +
 drivers/staging/media/atomisp/pci/dma_v2_defs.h    |   199 +
 drivers/staging/media/atomisp/pci/gdc_v2_defs.h    |   163 +
 drivers/staging/media/atomisp/pci/gp_timer_defs.h  |    36 +
 .../staging/media/atomisp/pci/gpio_block_defs.h    |    41 +
 .../atomisp/pci/hive_isp_css_2401_irq_types_hrt.h  |    68 +
 .../atomisp/pci/hive_isp_css_common/debug_global.h |    81 +
 .../atomisp/pci/hive_isp_css_common/dma_global.h   |   254 +
 .../pci/hive_isp_css_common/event_fifo_global.h    |    20 +
 .../pci/hive_isp_css_common/fifo_monitor_global.h  |    32 +
 .../atomisp/pci/hive_isp_css_common/gdc_global.h   |    89 +
 .../pci/hive_isp_css_common/gp_device_global.h     |    84 +
 .../pci/hive_isp_css_common/gp_timer_global.h      |    33 +
 .../atomisp/pci/hive_isp_css_common/gpio_global.h  |    45 +
 .../atomisp/pci/hive_isp_css_common/hmem_global.h  |    45 +
 .../atomisp/pci/hive_isp_css_common/host/debug.c   |    71 +
 .../pci/hive_isp_css_common/host/debug_local.h     |    20 +
 .../pci/hive_isp_css_common/host/debug_private.h   |   126 +
 .../atomisp/pci/hive_isp_css_common/host/dma.c     |   299 +
 .../pci/hive_isp_css_common/host/dma_local.h       |   207 +
 .../pci/hive_isp_css_common/host/dma_private.h     |    41 +
 .../pci/hive_isp_css_common/host/event_fifo.c      |    19 +
 .../hive_isp_css_common/host/event_fifo_local.h    |    61 +
 .../hive_isp_css_common/host/event_fifo_private.h  |    77 +
 .../pci/hive_isp_css_common/host/fifo_monitor.c    |   569 +
 .../hive_isp_css_common/host/fifo_monitor_local.h  |    99 +
 .../host/fifo_monitor_private.h                    |    80 +
 .../atomisp/pci/hive_isp_css_common/host/gdc.c     |   125 +
 .../pci/hive_isp_css_common/host/gdc_local.h       |    20 +
 .../pci/hive_isp_css_common/host/gdc_private.h     |    20 +
 .../pci/hive_isp_css_common/host/gp_device.c       |   108 +
 .../pci/hive_isp_css_common/host/gp_device_local.h |   143 +
 .../hive_isp_css_common/host/gp_device_private.h   |    46 +
 .../pci/hive_isp_css_common/host/gp_timer.c        |    70 +
 .../pci/hive_isp_css_common/host/gp_timer_local.h  |    43 +
 .../hive_isp_css_common/host/gp_timer_private.h    |    22 +
 .../pci/hive_isp_css_common/host/gpio_local.h      |    20 +
 .../pci/hive_isp_css_common/host/gpio_private.h    |    44 +
 .../atomisp/pci/hive_isp_css_common/host/hmem.c    |    19 +
 .../pci/hive_isp_css_common/host/hmem_local.h      |    20 +
 .../pci/hive_isp_css_common/host/hmem_private.h    |    30 +
 .../pci/hive_isp_css_common/host/input_formatter.c |   241 +
 .../host/input_formatter_local.h                   |   121 +
 .../host/input_formatter_private.h                 |    46 +
 .../pci/hive_isp_css_common/host/input_system.c    |  1849 +++
 .../atomisp/pci/hive_isp_css_common/host/irq.c     |   451 +
 .../pci/hive_isp_css_common/host/irq_local.h       |   134 +
 .../pci/hive_isp_css_common/host/irq_private.h     |    44 +
 .../atomisp/pci/hive_isp_css_common/host/isp.c     |   128 +
 .../pci/hive_isp_css_common/host/isp_local.h       |    57 +
 .../pci/hive_isp_css_common/host/isp_private.h     |   160 +
 .../atomisp/pci/hive_isp_css_common/host/mmu.c     |    46 +
 .../pci/hive_isp_css_common/host/mmu_local.h       |    20 +
 .../atomisp/pci/hive_isp_css_common/host/sp.c      |    81 +
 .../pci/hive_isp_css_common/host/sp_local.h        |   101 +
 .../pci/hive_isp_css_common/host/sp_private.h      |   166 +
 .../pci/hive_isp_css_common/host/timed_ctrl.c      |    74 +
 .../hive_isp_css_common/host/timed_ctrl_local.h    |    20 +
 .../hive_isp_css_common/host/timed_ctrl_private.h  |    34 +
 .../pci/hive_isp_css_common/host/vamem_local.h     |    20 +
 .../atomisp/pci/hive_isp_css_common/host/vmem.c    |   276 +
 .../pci/hive_isp_css_common/host/vmem_local.h      |    57 +
 .../pci/hive_isp_css_common/host/vmem_private.h    |    20 +
 .../hive_isp_css_common/input_formatter_global.h   |   114 +
 .../atomisp/pci/hive_isp_css_common/irq_global.h   |    45 +
 .../atomisp/pci/hive_isp_css_common/isp_global.h   |   109 +
 .../atomisp/pci/hive_isp_css_common/mmu_global.h   |    22 +
 .../atomisp/pci/hive_isp_css_common/sp_global.h    |    93 +
 .../pci/hive_isp_css_common/timed_ctrl_global.h    |    54 +
 .../atomisp/pci/hive_isp_css_common/vamem_global.h |    34 +
 .../atomisp/pci/hive_isp_css_common/vmem_global.h  |    28 +
 .../staging/media/atomisp/pci/hive_isp_css_defs.h  |   411 +
 .../pci/hive_isp_css_include/assert_support.h      |    73 +
 .../pci/hive_isp_css_include/bitop_support.h       |    24 +
 .../atomisp/pci/hive_isp_css_include/csi_rx.h      |    42 +
 .../media/atomisp/pci/hive_isp_css_include/debug.h |    46 +
 .../device_access/device_access.h                  |   177 +
 .../media/atomisp/pci/hive_isp_css_include/dma.h   |    46 +
 .../pci/hive_isp_css_include/error_support.h       |    39 +
 .../atomisp/pci/hive_isp_css_include/event_fifo.h  |    45 +
 .../pci/hive_isp_css_include/fifo_monitor.h        |    45 +
 .../atomisp/pci/hive_isp_css_include/gdc_device.h  |    47 +
 .../atomisp/pci/hive_isp_css_include/gp_device.h   |    45 +
 .../atomisp/pci/hive_isp_css_include/gp_timer.h    |    45 +
 .../media/atomisp/pci/hive_isp_css_include/gpio.h  |    45 +
 .../media/atomisp/pci/hive_isp_css_include/hmem.h  |    45 +
 .../pci/hive_isp_css_include/host/csi_rx_public.h  |   135 +
 .../pci/hive_isp_css_include/host/debug_public.h   |    98 +
 .../pci/hive_isp_css_include/host/dma_public.h     |    72 +
 .../hive_isp_css_include/host/event_fifo_public.h  |    79 +
 .../host/fifo_monitor_public.h                     |   110 +
 .../pci/hive_isp_css_include/host/gdc_public.h     |    59 +
 .../hive_isp_css_include/host/gp_device_public.h   |    58 +
 .../hive_isp_css_include/host/gp_timer_public.h    |    33 +
 .../pci/hive_isp_css_include/host/gpio_public.h    |    45 +
 .../pci/hive_isp_css_include/host/hmem_public.h    |    32 +
 .../hive_isp_css_include/host/ibuf_ctrl_public.h   |    93 +
 .../host/input_formatter_public.h                  |   115 +
 .../pci/hive_isp_css_include/host/irq_public.h     |   184 +
 .../pci/hive_isp_css_include/host/isp_public.h     |   185 +
 .../hive_isp_css_include/host/isys_dma_public.h    |    38 +
 .../hive_isp_css_include/host/isys_irq_public.h    |    45 +
 .../pci/hive_isp_css_include/host/isys_public.h    |    37 +
 .../host/isys_stream2mmio_public.h                 |   101 +
 .../pci/hive_isp_css_include/host/mmu_public.h     |    94 +
 .../hive_isp_css_include/host/pixelgen_public.h    |    79 +
 .../pci/hive_isp_css_include/host/sp_public.h      |   223 +
 .../pci/hive_isp_css_include/host/tag_public.h     |    40 +
 .../hive_isp_css_include/host/timed_ctrl_public.h  |    59 +
 .../pci/hive_isp_css_include/host/vamem_public.h   |    18 +
 .../pci/hive_isp_css_include/host/vmem_public.h    |    20 +
 .../atomisp/pci/hive_isp_css_include/ibuf_ctrl.h   |    46 +
 .../pci/hive_isp_css_include/input_formatter.h     |    45 +
 .../pci/hive_isp_css_include/input_system.h        |    45 +
 .../media/atomisp/pci/hive_isp_css_include/irq.h   |    45 +
 .../media/atomisp/pci/hive_isp_css_include/isp.h   |    45 +
 .../atomisp/pci/hive_isp_css_include/isys_dma.h    |    46 +
 .../atomisp/pci/hive_isp_css_include/isys_irq.h    |    39 +
 .../pci/hive_isp_css_include/isys_stream2mmio.h    |    46 +
 .../pci/hive_isp_css_include/math_support.h        |   153 +
 .../memory_access/memory_access.h                  |   174 +
 .../pci/hive_isp_css_include/memory_realloc.h      |    38 +
 .../pci/hive_isp_css_include/misc_support.h        |    26 +
 .../atomisp/pci/hive_isp_css_include/mmu_device.h  |    39 +
 .../atomisp/pci/hive_isp_css_include/pixelgen.h    |    46 +
 .../pci/hive_isp_css_include/platform_support.h    |    36 +
 .../pci/hive_isp_css_include/print_support.h       |    41 +
 .../media/atomisp/pci/hive_isp_css_include/queue.h |    45 +
 .../atomisp/pci/hive_isp_css_include/resource.h    |    46 +
 .../media/atomisp/pci/hive_isp_css_include/sp.h    |    45 +
 .../pci/hive_isp_css_include/string_support.h      |   165 +
 .../pci/hive_isp_css_include/system_types.h        |    24 +
 .../media/atomisp/pci/hive_isp_css_include/tag.h   |    44 +
 .../atomisp/pci/hive_isp_css_include/timed_ctrl.h  |    45 +
 .../pci/hive_isp_css_include/type_support.h        |    40 +
 .../media/atomisp/pci/hive_isp_css_include/vamem.h |    36 +
 .../media/atomisp/pci/hive_isp_css_include/vmem.h  |    45 +
 .../pci/hive_isp_css_shared/host/queue_local.h     |    20 +
 .../pci/hive_isp_css_shared/host/queue_private.h   |    18 +
 .../atomisp/pci/hive_isp_css_shared/host/tag.c     |    91 +
 .../pci/hive_isp_css_shared/host/tag_local.h       |    22 +
 .../pci/hive_isp_css_shared/host/tag_private.h     |    18 +
 .../atomisp/pci/hive_isp_css_shared/queue_global.h |    18 +
 .../pci/hive_isp_css_shared/sw_event_global.h      |    35 +
 .../atomisp/pci/hive_isp_css_shared/tag_global.h   |    56 +
 .../pci/hive_isp_css_streaming_to_mipi_types_hrt.h |    26 +
 drivers/staging/media/atomisp/pci/hive_types.h     |   128 +
 drivers/staging/media/atomisp/pci/hmm/hmm.c        |   733 ++
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c     |  1511 +++
 .../media/atomisp/pci/hmm/hmm_dynamic_pool.c       |   233 +
 .../media/atomisp/pci/hmm/hmm_reserved_pool.c      |   252 +
 drivers/staging/media/atomisp/pci/hmm/hmm_vm.c     |   212 +
 .../atomisp/pci/hrt/hive_isp_css_custom_host_hrt.h |   106 +
 .../media/atomisp/pci/hrt/hive_isp_css_mm_hrt.c    |   124 +
 .../media/atomisp/pci/hrt/hive_isp_css_mm_hrt.h    |    57 +
 drivers/staging/media/atomisp/pci/ia_css.h         |    57 +
 drivers/staging/media/atomisp/pci/ia_css_3a.h      |   189 +
 .../staging/media/atomisp/pci/ia_css_acc_types.h   |   476 +
 drivers/staging/media/atomisp/pci/ia_css_buffer.h  |    85 +
 drivers/staging/media/atomisp/pci/ia_css_control.h |   131 +
 .../media/atomisp/pci/ia_css_device_access.c       |    95 +
 .../media/atomisp/pci/ia_css_device_access.h       |    60 +
 drivers/staging/media/atomisp/pci/ia_css_dvs.h     |   297 +
 drivers/staging/media/atomisp/pci/ia_css_env.h     |    94 +
 drivers/staging/media/atomisp/pci/ia_css_err.h     |    63 +
 .../media/atomisp/pci/ia_css_event_public.h        |   196 +
 .../staging/media/atomisp/pci/ia_css_firmware.h    |    64 +
 drivers/staging/media/atomisp/pci/ia_css_frac.h    |    37 +
 .../media/atomisp/pci/ia_css_frame_format.h        |   101 +
 .../media/atomisp/pci/ia_css_frame_public.h        |   353 +
 .../staging/media/atomisp/pci/ia_css_host_data.h   |    45 +
 .../staging/media/atomisp/pci/ia_css_input_port.h  |    60 +
 drivers/staging/media/atomisp/pci/ia_css_irq.h     |   235 +
 .../staging/media/atomisp/pci/ia_css_isp_configs.h |   183 +
 .../staging/media/atomisp/pci/ia_css_isp_params.h  |   394 +
 .../staging/media/atomisp/pci/ia_css_isp_states.h  |    73 +
 .../media/atomisp/pci/ia_css_memory_access.c       |    85 +
 .../staging/media/atomisp/pci/ia_css_metadata.h    |    72 +
 drivers/staging/media/atomisp/pci/ia_css_mipi.h    |    82 +
 drivers/staging/media/atomisp/pci/ia_css_mmu.h     |    32 +
 .../staging/media/atomisp/pci/ia_css_mmu_private.h |    29 +
 drivers/staging/media/atomisp/pci/ia_css_morph.h   |    39 +
 drivers/staging/media/atomisp/pci/ia_css_pipe.h    |   189 +
 .../staging/media/atomisp/pci/ia_css_pipe_public.h |   569 +
 drivers/staging/media/atomisp/pci/ia_css_prbs.h    |    53 +
 .../staging/media/atomisp/pci/ia_css_properties.h  |    41 +
 drivers/staging/media/atomisp/pci/ia_css_shading.h |    40 +
 drivers/staging/media/atomisp/pci/ia_css_stream.h  |   111 +
 .../media/atomisp/pci/ia_css_stream_format.h       |    29 +
 .../media/atomisp/pci/ia_css_stream_public.h       |   585 +
 drivers/staging/media/atomisp/pci/ia_css_timer.h   |    68 +
 drivers/staging/media/atomisp/pci/ia_css_tpg.h     |    78 +
 drivers/staging/media/atomisp/pci/ia_css_types.h   |   605 +
 drivers/staging/media/atomisp/pci/ia_css_version.h |    40 +
 .../media/atomisp/pci/ia_css_version_data.h        |    27 +
 drivers/staging/media/atomisp/pci/if_defs.h        |    22 +
 .../atomisp/pci/input_formatter_subsystem_defs.h   |    53 +
 .../media/atomisp/pci/input_selector_defs.h        |    88 +
 .../media/atomisp/pci/input_switch_2400_defs.h     |    30 +
 .../media/atomisp/pci/input_system_ctrl_defs.h     |   243 +
 .../staging/media/atomisp/pci/input_system_defs.h  |   126 +
 .../media/atomisp/pci/input_system_global.h        |    10 +
 .../staging/media/atomisp/pci/input_system_local.h |    10 +
 .../media/atomisp/pci/input_system_private.h       |    10 +
 .../media/atomisp/pci/input_system_public.h        |     8 +
 .../media/atomisp/pci/irq_controller_defs.h        |    28 +
 .../pci/isp/kernels/aa/aa_2/ia_css_aa2.host.c      |    31 +
 .../pci/isp/kernels/aa/aa_2/ia_css_aa2.host.h      |    27 +
 .../pci/isp/kernels/aa/aa_2/ia_css_aa2_param.h     |    24 +
 .../pci/isp/kernels/aa/aa_2/ia_css_aa2_types.h     |    46 +
 .../pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c  |    61 +
 .../pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.h  |    39 +
 .../pci/isp/kernels/anr/anr_1.0/ia_css_anr_param.h |    25 +
 .../pci/isp/kernels/anr/anr_1.0/ia_css_anr_types.h |    35 +
 .../pci/isp/kernels/anr/anr_2/ia_css_anr2.host.c   |    46 +
 .../pci/isp/kernels/anr/anr_2/ia_css_anr2.host.h   |    35 +
 .../pci/isp/kernels/anr/anr_2/ia_css_anr2_param.h  |    27 +
 .../isp/kernels/anr/anr_2/ia_css_anr2_table.host.c |    55 +
 .../isp/kernels/anr/anr_2/ia_css_anr2_table.host.h |    22 +
 .../pci/isp/kernels/anr/anr_2/ia_css_anr2_types.h  |    31 +
 .../pci/isp/kernels/bh/bh_2/ia_css_bh.host.c       |    66 +
 .../pci/isp/kernels/bh/bh_2/ia_css_bh.host.h       |    32 +
 .../pci/isp/kernels/bh/bh_2/ia_css_bh_param.h      |    40 +
 .../pci/isp/kernels/bh/bh_2/ia_css_bh_types.h      |    35 +
 .../pci/isp/kernels/bnlm/ia_css_bnlm.host.c        |   196 +
 .../pci/isp/kernels/bnlm/ia_css_bnlm.host.h        |    40 +
 .../pci/isp/kernels/bnlm/ia_css_bnlm_param.h       |    64 +
 .../pci/isp/kernels/bnlm/ia_css_bnlm_types.h       |   106 +
 .../isp/kernels/bnr/bnr2_2/ia_css_bnr2_2.host.c    |   131 +
 .../isp/kernels/bnr/bnr2_2/ia_css_bnr2_2.host.h    |    35 +
 .../isp/kernels/bnr/bnr2_2/ia_css_bnr2_2_param.h   |    47 +
 .../isp/kernels/bnr/bnr2_2/ia_css_bnr2_2_types.h   |    71 +
 .../pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.c  |    64 +
 .../pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr.host.h  |    34 +
 .../pci/isp/kernels/bnr/bnr_1.0/ia_css_bnr_param.h |    30 +
 .../pci/isp/kernels/cnr/cnr_1.0/ia_css_cnr.host.c  |    28 +
 .../pci/isp/kernels/cnr/cnr_1.0/ia_css_cnr.host.h  |    25 +
 .../pci/isp/kernels/cnr/cnr_1.0/ia_css_cnr_param.h |    24 +
 .../pci/isp/kernels/cnr/cnr_2/ia_css_cnr2.host.c   |    73 +
 .../pci/isp/kernels/cnr/cnr_2/ia_css_cnr2.host.h   |    43 +
 .../pci/isp/kernels/cnr/cnr_2/ia_css_cnr2_param.h  |    32 +
 .../pci/isp/kernels/cnr/cnr_2/ia_css_cnr2_types.h  |    54 +
 .../conversion_1.0/ia_css_conversion.host.c        |    36 +
 .../conversion_1.0/ia_css_conversion.host.h        |    29 +
 .../conversion_1.0/ia_css_conversion_param.h       |    28 +
 .../conversion_1.0/ia_css_conversion_types.h       |    32 +
 .../copy_output_1.0/ia_css_copy_output.host.c      |    46 +
 .../copy_output_1.0/ia_css_copy_output.host.h      |    34 +
 .../copy_output_1.0/ia_css_copy_output_param.h     |    26 +
 .../isp/kernels/crop/crop_1.0/ia_css_crop.host.c   |    64 +
 .../isp/kernels/crop/crop_1.0/ia_css_crop.host.h   |    41 +
 .../isp/kernels/crop/crop_1.0/ia_css_crop_param.h  |    32 +
 .../isp/kernels/crop/crop_1.0/ia_css_crop_types.h  |    34 +
 .../pci/isp/kernels/csc/csc_1.0/ia_css_csc.host.c  |   127 +
 .../pci/isp/kernels/csc/csc_1.0/ia_css_csc.host.h  |    54 +
 .../pci/isp/kernels/csc/csc_1.0/ia_css_csc_param.h |    33 +
 .../pci/isp/kernels/csc/csc_1.0/ia_css_csc_types.h |    78 +
 .../isp/kernels/ctc/ctc1_5/ia_css_ctc1_5.host.c    |   121 +
 .../isp/kernels/ctc/ctc1_5/ia_css_ctc1_5.host.h    |    33 +
 .../isp/kernels/ctc/ctc1_5/ia_css_ctc1_5_param.h   |    46 +
 .../pci/isp/kernels/ctc/ctc2/ia_css_ctc2.host.c    |   157 +
 .../pci/isp/kernels/ctc/ctc2/ia_css_ctc2.host.h    |    33 +
 .../pci/isp/kernels/ctc/ctc2/ia_css_ctc2_param.h   |    48 +
 .../pci/isp/kernels/ctc/ctc2/ia_css_ctc2_types.h   |    54 +
 .../pci/isp/kernels/ctc/ctc_1.0/ia_css_ctc.host.c  |    58 +
 .../pci/isp/kernels/ctc/ctc_1.0/ia_css_ctc.host.h  |    36 +
 .../pci/isp/kernels/ctc/ctc_1.0/ia_css_ctc_param.h |    44 +
 .../kernels/ctc/ctc_1.0/ia_css_ctc_table.host.c    |   214 +
 .../kernels/ctc/ctc_1.0/ia_css_ctc_table.host.h    |    24 +
 .../pci/isp/kernels/ctc/ctc_1.0/ia_css_ctc_types.h |   110 +
 .../pci/isp/kernels/de/de_1.0/ia_css_de.host.c     |    78 +
 .../pci/isp/kernels/de/de_1.0/ia_css_de.host.h     |    44 +
 .../pci/isp/kernels/de/de_1.0/ia_css_de_param.h    |    27 +
 .../pci/isp/kernels/de/de_1.0/ia_css_de_types.h    |    42 +
 .../pci/isp/kernels/de/de_2/ia_css_de2.host.c      |    53 +
 .../pci/isp/kernels/de/de_2/ia_css_de2.host.h      |    38 +
 .../pci/isp/kernels/de/de_2/ia_css_de2_param.h     |    30 +
 .../pci/isp/kernels/de/de_2/ia_css_de2_types.h     |    41 +
 .../pci/isp/kernels/dp/dp_1.0/ia_css_dp.host.c     |   131 +
 .../pci/isp/kernels/dp/dp_1.0/ia_css_dp.host.h     |    47 +
 .../pci/isp/kernels/dp/dp_1.0/ia_css_dp_param.h    |    36 +
 .../pci/isp/kernels/dp/dp_1.0/ia_css_dp_types.h    |    48 +
 .../pci/isp/kernels/dpc2/ia_css_dpc2.host.c        |    65 +
 .../pci/isp/kernels/dpc2/ia_css_dpc2.host.h        |    39 +
 .../pci/isp/kernels/dpc2/ia_css_dpc2_param.h       |    51 +
 .../pci/isp/kernels/dpc2/ia_css_dpc2_types.h       |    59 +
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs.host.c  |   301 +
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs.host.h  |    60 +
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs_param.h |    32 +
 .../pci/isp/kernels/dvs/dvs_1.0/ia_css_dvs_types.h |    29 +
 .../pci/isp/kernels/eed1_8/ia_css_eed1_8.host.c    |   338 +
 .../pci/isp/kernels/eed1_8/ia_css_eed1_8.host.h    |    45 +
 .../pci/isp/kernels/eed1_8/ia_css_eed1_8_param.h   |   153 +
 .../pci/isp/kernels/eed1_8/ia_css_eed1_8_types.h   |    87 +
 .../isp/kernels/fc/fc_1.0/ia_css_formats.host.c    |    63 +
 .../isp/kernels/fc/fc_1.0/ia_css_formats.host.h    |    44 +
 .../isp/kernels/fc/fc_1.0/ia_css_formats_param.h   |    25 +
 .../isp/kernels/fc/fc_1.0/ia_css_formats_types.h   |    38 +
 .../fixedbds/fixedbds_1.0/ia_css_fixedbds_param.h  |    32 +
 .../fixedbds/fixedbds_1.0/ia_css_fixedbds_types.h  |    24 +
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.c  |    88 +
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn.host.h  |    44 +
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn_param.h |    35 +
 .../pci/isp/kernels/fpn/fpn_1.0/ia_css_fpn_types.h |    52 +
 .../pci/isp/kernels/gc/gc_1.0/ia_css_gc.host.c     |   117 +
 .../pci/isp/kernels/gc/gc_1.0/ia_css_gc.host.h     |    65 +
 .../pci/isp/kernels/gc/gc_1.0/ia_css_gc_param.h    |    61 +
 .../isp/kernels/gc/gc_1.0/ia_css_gc_table.host.c   |   213 +
 .../isp/kernels/gc/gc_1.0/ia_css_gc_table.host.h   |    24 +
 .../pci/isp/kernels/gc/gc_1.0/ia_css_gc_types.h    |    97 +
 .../pci/isp/kernels/gc/gc_2/ia_css_gc2.host.c      |   109 +
 .../pci/isp/kernels/gc/gc_2/ia_css_gc2.host.h      |    79 +
 .../pci/isp/kernels/gc/gc_2/ia_css_gc2_param.h     |    43 +
 .../isp/kernels/gc/gc_2/ia_css_gc2_table.host.c    |   131 +
 .../isp/kernels/gc/gc_2/ia_css_gc2_table.host.h    |    26 +
 .../pci/isp/kernels/gc/gc_2/ia_css_gc2_types.h     |    54 +
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr.host.c  |    41 +
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr.host.h  |    31 +
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr_param.h |    59 +
 .../atomisp/pci/isp/kernels/hdr/ia_css_hdr_types.h |    70 +
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.c  |    93 +
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io.host.h  |    28 +
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io_param.h |    20 +
 .../ipu2_io_ls/bayer_io_ls/ia_css_bayer_io_types.h |    20 +
 .../ipu2_io_ls/common/ia_css_common_io_param.h     |    20 +
 .../ipu2_io_ls/common/ia_css_common_io_types.h     |    29 +
 .../yuv444_io_ls/ia_css_yuv444_io.host.c           |    93 +
 .../yuv444_io_ls/ia_css_yuv444_io.host.h           |    28 +
 .../yuv444_io_ls/ia_css_yuv444_io_param.h          |    20 +
 .../yuv444_io_ls/ia_css_yuv444_io_types.h          |    20 +
 .../iterator/iterator_1.0/ia_css_iterator.host.c   |    80 +
 .../iterator/iterator_1.0/ia_css_iterator.host.h   |    34 +
 .../iterator/iterator_1.0/ia_css_iterator_param.h  |    38 +
 .../isp/kernels/macc/macc1_5/ia_css_macc1_5.host.c |    74 +
 .../isp/kernels/macc/macc1_5/ia_css_macc1_5.host.h |    41 +
 .../kernels/macc/macc1_5/ia_css_macc1_5_param.h    |    31 +
 .../macc/macc1_5/ia_css_macc1_5_table.host.c       |    34 +
 .../macc/macc1_5/ia_css_macc1_5_table.host.h       |    22 +
 .../kernels/macc/macc1_5/ia_css_macc1_5_types.h    |    73 +
 .../isp/kernels/macc/macc_1.0/ia_css_macc.host.c   |    49 +
 .../isp/kernels/macc/macc_1.0/ia_css_macc.host.h   |    41 +
 .../isp/kernels/macc/macc_1.0/ia_css_macc_param.h  |    25 +
 .../kernels/macc/macc_1.0/ia_css_macc_table.host.c |    51 +
 .../kernels/macc/macc_1.0/ia_css_macc_table.host.h |    23 +
 .../isp/kernels/macc/macc_1.0/ia_css_macc_types.h  |    63 +
 .../isp/kernels/norm/norm_1.0/ia_css_norm.host.c   |    15 +
 .../isp/kernels/norm/norm_1.0/ia_css_norm.host.h   |    20 +
 .../isp/kernels/norm/norm_1.0/ia_css_norm_param.h  |    18 +
 .../pci/isp/kernels/ob/ob2/ia_css_ob2.host.c       |    76 +
 .../pci/isp/kernels/ob/ob2/ia_css_ob2.host.h       |    40 +
 .../pci/isp/kernels/ob/ob2/ia_css_ob2_param.h      |    28 +
 .../pci/isp/kernels/ob/ob2/ia_css_ob2_types.h      |    44 +
 .../pci/isp/kernels/ob/ob_1.0/ia_css_ob.host.c     |   154 +
 .../pci/isp/kernels/ob/ob_1.0/ia_css_ob.host.h     |    53 +
 .../pci/isp/kernels/ob/ob_1.0/ia_css_ob_param.h    |    47 +
 .../pci/isp/kernels/ob/ob_1.0/ia_css_ob_types.h    |    68 +
 .../kernels/output/output_1.0/ia_css_output.host.c |   163 +
 .../kernels/output/output_1.0/ia_css_output.host.h |    75 +
 .../output/output_1.0/ia_css_output_param.h        |    36 +
 .../output/output_1.0/ia_css_output_types.h        |    47 +
 .../kernels/qplane/qplane_2/ia_css_qplane.host.c   |    61 +
 .../kernels/qplane/qplane_2/ia_css_qplane.host.h   |    43 +
 .../kernels/qplane/qplane_2/ia_css_qplane_param.h  |    30 +
 .../kernels/qplane/qplane_2/ia_css_qplane_types.h  |    31 +
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw.host.c  |   135 +
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw.host.h  |    38 +
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw_param.h |    38 +
 .../pci/isp/kernels/raw/raw_1.0/ia_css_raw_types.h |    36 +
 .../raw_aa_binning_1.0/ia_css_raa.host.c           |    35 +
 .../raw_aa_binning_1.0/ia_css_raa.host.h           |    27 +
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref.host.c  |    76 +
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref.host.h  |    41 +
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref_param.h |    36 +
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref_state.h |    26 +
 .../pci/isp/kernels/ref/ref_1.0/ia_css_ref_types.h |    25 +
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.c  |   386 +
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a.host.h  |    77 +
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a_param.h |    53 +
 .../pci/isp/kernels/s3a/s3a_1.0/ia_css_s3a_types.h |   221 +
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc.host.c     |   158 +
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc.host.h     |    77 +
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc_param.h    |    42 +
 .../pci/isp/kernels/sc/sc_1.0/ia_css_sc_types.h    |   134 +
 .../kernels/sdis/common/ia_css_sdis_common.host.h  |   101 +
 .../kernels/sdis/common/ia_css_sdis_common_types.h |   220 +
 .../isp/kernels/sdis/sdis_1.0/ia_css_sdis.host.c   |   437 +
 .../isp/kernels/sdis/sdis_1.0/ia_css_sdis.host.h   |   101 +
 .../isp/kernels/sdis/sdis_1.0/ia_css_sdis_types.h  |    55 +
 .../isp/kernels/sdis/sdis_2/ia_css_sdis2.host.c    |   350 +
 .../isp/kernels/sdis/sdis_2/ia_css_sdis2.host.h    |    95 +
 .../isp/kernels/sdis/sdis_2/ia_css_sdis2_types.h   |    75 +
 .../pci/isp/kernels/tdf/tdf_1.0/ia_css_tdf.host.c  |    74 +
 .../pci/isp/kernels/tdf/tdf_1.0/ia_css_tdf.host.h  |    38 +
 .../pci/isp/kernels/tdf/tdf_1.0/ia_css_tdf_param.h |    43 +
 .../pci/isp/kernels/tdf/tdf_1.0/ia_css_tdf_types.h |    52 +
 .../pci/isp/kernels/tnr/tnr3/ia_css_tnr3_types.h   |    63 +
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr.host.c  |   120 +
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr.host.h  |    56 +
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr_param.h |    40 +
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr_state.h |    26 +
 .../pci/isp/kernels/tnr/tnr_1.0/ia_css_tnr_types.h |    57 +
 .../pci/isp/kernels/uds/uds_1.0/ia_css_uds_param.h |    31 +
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.c     |   138 +
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf.host.h     |    47 +
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf_param.h    |    37 +
 .../pci/isp/kernels/vf/vf_1.0/ia_css_vf_types.h    |    31 +
 .../pci/isp/kernels/wb/wb_1.0/ia_css_wb.host.c     |    86 +
 .../pci/isp/kernels/wb/wb_1.0/ia_css_wb.host.h     |    39 +
 .../pci/isp/kernels/wb/wb_1.0/ia_css_wb_param.h    |    29 +
 .../pci/isp/kernels/wb/wb_1.0/ia_css_wb_types.h    |    46 +
 .../pci/isp/kernels/xnr/xnr_1.0/ia_css_xnr.host.c  |    65 +
 .../pci/isp/kernels/xnr/xnr_1.0/ia_css_xnr.host.h  |    47 +
 .../pci/isp/kernels/xnr/xnr_1.0/ia_css_xnr_param.h |    50 +
 .../kernels/xnr/xnr_1.0/ia_css_xnr_table.host.c    |    81 +
 .../kernels/xnr/xnr_1.0/ia_css_xnr_table.host.h    |    22 +
 .../pci/isp/kernels/xnr/xnr_1.0/ia_css_xnr_types.h |    70 +
 .../pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.c |   248 +
 .../pci/isp/kernels/xnr/xnr_3.0/ia_css_xnr3.host.h |    41 +
 .../isp/kernels/xnr/xnr_3.0/ia_css_xnr3_param.h    |    83 +
 .../isp/kernels/xnr/xnr_3.0/ia_css_xnr3_types.h    |    97 +
 .../pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.c  |   217 +
 .../pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.h  |    60 +
 .../pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr_param.h |    49 +
 .../pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr_types.h |    80 +
 .../pci/isp/kernels/ynr/ynr_2/ia_css_ynr2.host.c   |   118 +
 .../pci/isp/kernels/ynr/ynr_2/ia_css_ynr2.host.h   |    56 +
 .../pci/isp/kernels/ynr/ynr_2/ia_css_ynr2_param.h  |    45 +
 .../pci/isp/kernels/ynr/ynr_2/ia_css_ynr2_types.h  |    93 +
 .../pci/isp/modes/interface/input_buf.isp.h        |    37 +
 .../atomisp/pci/isp/modes/interface/isp_const.h    |   180 +
 .../atomisp/pci/isp/modes/interface/isp_types.h    |    79 +
 .../atomisp/pci/isp2400_input_system_global.h      |   155 +
 .../media/atomisp/pci/isp2400_input_system_local.h |   539 +
 .../atomisp/pci/isp2400_input_system_private.h     |   122 +
 .../atomisp/pci/isp2400_input_system_public.h      |   369 +
 .../staging/media/atomisp/pci/isp2400_support.h    |    38 +
 .../media/atomisp/pci/isp2400_system_global.h      |   348 +
 .../media/atomisp/pci/isp2400_system_local.h       |   325 +
 .../atomisp/pci/isp2401_input_system_global.h      |   205 +
 .../media/atomisp/pci/isp2401_input_system_local.h |   106 +
 .../atomisp/pci/isp2401_input_system_private.h     |   129 +
 .../media/atomisp/pci/isp2401_mamoiada_params.h    |   228 +
 .../media/atomisp/pci/isp2401_system_global.h      |   457 +
 .../media/atomisp/pci/isp2401_system_local.h       |   406 +
 .../media/atomisp/pci/isp_acquisition_defs.h       |   229 +
 .../staging/media/atomisp/pci/isp_capture_defs.h   |   278 +
 drivers/staging/media/atomisp/pci/memory_realloc.c |    81 +
 drivers/staging/media/atomisp/pci/mmu/isp_mmu.c    |   566 +
 .../staging/media/atomisp/pci/mmu/sh_mmu_mrfld.c   |    77 +
 drivers/staging/media/atomisp/pci/mmu_defs.h       |    23 +
 .../pci/runtime/binary/interface/ia_css_binary.h   |   228 +
 .../media/atomisp/pci/runtime/binary/src/binary.c  |  1852 ++++
 .../pci/runtime/bufq/interface/ia_css_bufq.h       |   177 +
 .../pci/runtime/bufq/interface/ia_css_bufq_comm.h  |    50 +
 .../media/atomisp/pci/runtime/bufq/src/bufq.c      |   566 +
 .../pci/runtime/debug/interface/ia_css_debug.h     |   502 +
 .../debug/interface/ia_css_debug_internal.h        |    15 +
 .../runtime/debug/interface/ia_css_debug_pipe.h    |    67 +
 .../atomisp/pci/runtime/debug/src/ia_css_debug.c   |  3540 ++++++
 .../pci/runtime/event/interface/ia_css_event.h     |    30 +
 .../media/atomisp/pci/runtime/event/src/event.c    |   112 +
 .../pci/runtime/eventq/interface/ia_css_eventq.h   |    53 +
 .../media/atomisp/pci/runtime/eventq/src/eventq.c  |    77 +
 .../pci/runtime/frame/interface/ia_css_frame.h     |   163 +
 .../runtime/frame/interface/ia_css_frame_comm.h    |   115 +
 .../media/atomisp/pci/runtime/frame/src/frame.c    |   989 ++
 .../pci/runtime/ifmtr/interface/ia_css_ifmtr.h     |    33 +
 .../media/atomisp/pci/runtime/ifmtr/src/ifmtr.c    |   552 +
 .../runtime/inputfifo/interface/ia_css_inputfifo.h |    53 +
 .../atomisp/pci/runtime/inputfifo/src/inputfifo.c  |   538 +
 .../runtime/isp_param/interface/ia_css_isp_param.h |   102 +
 .../isp_param/interface/ia_css_isp_param_types.h   |    81 +
 .../atomisp/pci/runtime/isp_param/src/isp_param.c  |   216 +
 .../pci/runtime/isys/interface/ia_css_isys.h       |   184 +
 .../pci/runtime/isys/interface/ia_css_isys_comm.h  |    53 +
 .../atomisp/pci/runtime/isys/src/csi_rx_rmgr.c     |   167 +
 .../atomisp/pci/runtime/isys/src/csi_rx_rmgr.h     |    26 +
 .../atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.c  |   121 +
 .../atomisp/pci/runtime/isys/src/ibuf_ctrl_rmgr.h  |    38 +
 .../atomisp/pci/runtime/isys/src/isys_dma_rmgr.c   |    87 +
 .../atomisp/pci/runtime/isys/src/isys_dma_rmgr.h   |    24 +
 .../media/atomisp/pci/runtime/isys/src/isys_init.c |   123 +
 .../pci/runtime/isys/src/isys_stream2mmio_rmgr.c   |    89 +
 .../pci/runtime/isys/src/isys_stream2mmio_rmgr.h   |    24 +
 .../media/atomisp/pci/runtime/isys/src/rx.c        |   600 +
 .../atomisp/pci/runtime/isys/src/virtual_isys.c    |   892 ++
 .../atomisp/pci/runtime/isys/src/virtual_isys.h    |    24 +
 .../runtime/pipeline/interface/ia_css_pipeline.h   |   286 +
 .../pipeline/interface/ia_css_pipeline_common.h    |    27 +
 .../atomisp/pci/runtime/pipeline/src/pipeline.c    |   786 ++
 .../pci/runtime/queue/interface/ia_css_queue.h     |   175 +
 .../runtime/queue/interface/ia_css_queue_comm.h    |    53 +
 .../media/atomisp/pci/runtime/queue/src/queue.c    |   422 +
 .../atomisp/pci/runtime/queue/src/queue_access.c   |   176 +
 .../atomisp/pci/runtime/queue/src/queue_access.h   |    85 +
 .../pci/runtime/rmgr/interface/ia_css_rmgr.h       |    72 +
 .../pci/runtime/rmgr/interface/ia_css_rmgr_vbuf.h  |    99 +
 .../media/atomisp/pci/runtime/rmgr/src/rmgr.c      |    39 +
 .../media/atomisp/pci/runtime/rmgr/src/rmgr_vbuf.c |   336 +
 .../pci/runtime/spctrl/interface/ia_css_spctrl.h   |    68 +
 .../runtime/spctrl/interface/ia_css_spctrl_comm.h  |    45 +
 .../media/atomisp/pci/runtime/spctrl/src/spctrl.c  |   184 +
 .../tagger/interface/ia_css_tagger_common.h        |    43 +
 .../media/atomisp/pci/runtime/timer/src/timer.c    |    31 +
 .../atomisp/pci/scalar_processor_2400_params.h     |    20 +
 drivers/staging/media/atomisp/pci/sh_css.c         | 11110 +++++++++++++++=
++++
 drivers/staging/media/atomisp/pci/sh_css_defs.h    |   410 +
 .../staging/media/atomisp/pci/sh_css_dvs_info.h    |    36 +
 .../staging/media/atomisp/pci/sh_css_firmware.c    |   333 +
 .../staging/media/atomisp/pci/sh_css_firmware.h    |    55 +
 drivers/staging/media/atomisp/pci/sh_css_frac.h    |    40 +
 .../staging/media/atomisp/pci/sh_css_host_data.c   |    42 +
 drivers/staging/media/atomisp/pci/sh_css_hrt.c     |    85 +
 drivers/staging/media/atomisp/pci/sh_css_hrt.h     |    34 +
 .../staging/media/atomisp/pci/sh_css_internal.h    |  1061 ++
 drivers/staging/media/atomisp/pci/sh_css_legacy.h  |    70 +
 .../staging/media/atomisp/pci/sh_css_metadata.c    |    16 +
 drivers/staging/media/atomisp/pci/sh_css_metrics.c |   175 +
 drivers/staging/media/atomisp/pci/sh_css_metrics.h |    55 +
 drivers/staging/media/atomisp/pci/sh_css_mipi.c    |   757 ++
 drivers/staging/media/atomisp/pci/sh_css_mipi.h    |    49 +
 drivers/staging/media/atomisp/pci/sh_css_mmu.c     |    60 +
 drivers/staging/media/atomisp/pci/sh_css_morph.c   |    16 +
 .../staging/media/atomisp/pci/sh_css_param_dvs.c   |   286 +
 .../staging/media/atomisp/pci/sh_css_param_dvs.h   |    85 +
 .../media/atomisp/pci/sh_css_param_shading.c       |   402 +
 .../media/atomisp/pci/sh_css_param_shading.h       |    34 +
 drivers/staging/media/atomisp/pci/sh_css_params.c  |  5247 +++++++++
 drivers/staging/media/atomisp/pci/sh_css_params.h  |   188 +
 .../media/atomisp/pci/sh_css_params_internal.h     |    21 +
 drivers/staging/media/atomisp/pci/sh_css_pipe.c    |    16 +
 .../staging/media/atomisp/pci/sh_css_properties.c  |    43 +
 drivers/staging/media/atomisp/pci/sh_css_shading.c |    16 +
 drivers/staging/media/atomisp/pci/sh_css_sp.c      |  1829 +++
 drivers/staging/media/atomisp/pci/sh_css_sp.h      |   248 +
 drivers/staging/media/atomisp/pci/sh_css_stream.c  |    16 +
 .../media/atomisp/pci/sh_css_stream_format.c       |    76 +
 .../media/atomisp/pci/sh_css_stream_format.h       |    23 +
 drivers/staging/media/atomisp/pci/sh_css_struct.h  |    85 +
 drivers/staging/media/atomisp/pci/sh_css_uds.h     |    37 +
 drivers/staging/media/atomisp/pci/sh_css_version.c |    37 +
 drivers/staging/media/atomisp/pci/str2mem_defs.h   |    39 +
 .../media/atomisp/pci/streaming_to_mipi_defs.h     |    28 +
 drivers/staging/media/atomisp/pci/system_global.h  |    10 +
 drivers/staging/media/atomisp/pci/system_local.h   |    10 +
 .../media/atomisp/pci/timed_controller_defs.h      |    22 +
 drivers/staging/media/atomisp/pci/version.h        |    20 +
 drivers/staging/media/hantro/Kconfig               |     6 +-
 drivers/staging/media/hantro/Makefile              |     2 +
 drivers/staging/media/hantro/hantro.h              |     7 +-
 drivers/staging/media/hantro/hantro_drv.c          |    28 +-
 drivers/staging/media/hantro/hantro_h264.c         |   237 +-
 drivers/staging/media/hantro/hantro_hw.h           |    31 +
 drivers/staging/media/hantro/hantro_v4l2.c         |   111 +-
 drivers/staging/media/imx/Kconfig                  |     5 +-
 drivers/staging/media/imx/TODO                     |    29 -
 drivers/staging/media/imx/imx-ic-prp.c             |    15 +-
 drivers/staging/media/imx/imx-ic-prpencvf.c        |    14 +-
 drivers/staging/media/imx/imx-media-capture.c      |    42 +-
 drivers/staging/media/imx/imx-media-csc-scaler.c   |    13 +-
 drivers/staging/media/imx/imx-media-csi.c          |   223 +-
 drivers/staging/media/imx/imx-media-dev-common.c   |    50 +-
 drivers/staging/media/imx/imx-media-dev.c          |     2 +-
 drivers/staging/media/imx/imx-media-internal-sd.c  |     6 +-
 drivers/staging/media/imx/imx-media-of.c           |   114 -
 drivers/staging/media/imx/imx-media-utils.c        |   550 +-
 drivers/staging/media/imx/imx-media-vdic.c         |    12 +-
 drivers/staging/media/imx/imx-media.h              |    63 +-
 drivers/staging/media/imx/imx6-mipi-csi2.c         |    93 +-
 drivers/staging/media/imx/imx7-media-csi.c         |   177 +-
 drivers/staging/media/imx/imx7-mipi-csis.c         |   582 +-
 drivers/staging/media/ipu3/Kconfig                 |     3 +-
 drivers/staging/media/ipu3/TODO                    |     6 -
 drivers/staging/media/ipu3/include/intel-ipu3.h    |     7 +-
 drivers/staging/media/ipu3/ipu3-css-params.c       |    14 +-
 drivers/staging/media/ipu3/ipu3-css.c              |     7 +
 drivers/staging/media/ipu3/ipu3-mmu.c              |    10 +-
 drivers/staging/media/ipu3/ipu3-v4l2.c             |    92 +-
 drivers/staging/media/ipu3/ipu3.c                  |     5 +-
 drivers/staging/media/ipu3/ipu3.h                  |     4 +
 drivers/staging/media/meson/vdec/codec_vp9.c       |    31 +
 drivers/staging/media/omap4iss/Kconfig             |     4 +-
 .../bindings/phy/rockchip-mipi-dphy-rx0.yaml       |    76 -
 .../staging/media/phy-rockchip-dphy-rx0/Kconfig    |     2 +-
 drivers/staging/media/rkisp1/Kconfig               |     6 +-
 drivers/staging/media/rkisp1/Makefile              |     2 +
 drivers/staging/media/rkisp1/TODO                  |     6 -
 drivers/staging/media/rkisp1/rkisp1-capture.c      |   101 +-
 drivers/staging/media/rkisp1/rkisp1-common.h       |    16 +-
 drivers/staging/media/rkisp1/rkisp1-dev.c          |   114 +-
 drivers/staging/media/rkisp1/rkisp1-isp.c          |    94 +-
 drivers/staging/media/rkisp1/rkisp1-resizer.c      |    36 +-
 drivers/staging/media/rkvdec/Kconfig               |    16 +
 drivers/staging/media/rkvdec/Makefile              |     3 +
 drivers/staging/media/rkvdec/TODO                  |    11 +
 drivers/staging/media/rkvdec/rkvdec-h264.c         |  1156 ++
 drivers/staging/media/rkvdec/rkvdec-regs.h         |   223 +
 drivers/staging/media/rkvdec/rkvdec.c              |  1103 ++
 drivers/staging/media/rkvdec/rkvdec.h              |   121 +
 .../staging/media/soc_camera}/soc-camera.rst       |     0
 drivers/staging/media/sunxi/cedrus/Kconfig         |     5 +-
 drivers/staging/media/usbvision/Kconfig            |     2 +-
 drivers/staging/media/usbvision/usbvision-core.c   |     2 +-
 include/media/cec-pin.h                            |    16 +-
 include/media/dvb-usb-ids.h                        |     5 +-
 include/media/h264-ctrls.h                         |     8 +-
 include/media/media-entity.h                       |     3 +-
 include/media/rc-map.h                             |   103 +-
 include/media/v4l2-ctrls.h                         |    87 +-
 include/media/v4l2-dev.h                           |     7 +
 include/media/v4l2-device.h                        |    50 +-
 include/media/v4l2-fh.h                            |     2 -
 include/media/v4l2-fwnode.h                        |    85 +-
 include/media/v4l2-h264.h                          |    85 +
 include/media/v4l2-image-sizes.h                   |     6 +
 include/media/v4l2-jpeg.h                          |   135 +
 include/media/v4l2-mc.h                            |    48 +
 include/media/v4l2-subdev.h                        |    17 +
 include/uapi/linux/v4l2-controls.h                 |    12 +
 include/uapi/linux/v4l2-subdev.h                   |    16 +
 include/uapi/linux/videodev2.h                     |     5 +-
 2181 files changed, 260633 insertions(+), 106012 deletions(-)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/au0828-car=
dlist.rst (100%)
 create mode 100644 Documentation/admin-guide/media/avermedia.rst
 create mode 100644 Documentation/admin-guide/media/bt8xx.rst
 create mode 100644 Documentation/admin-guide/media/bttv-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/bttv.rst
 create mode 100644 Documentation/admin-guide/media/building.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/cafe_ccic.=
rst (100%)
 create mode 100644 Documentation/admin-guide/media/cardlist.rst
 create mode 100644 Documentation/admin-guide/media/cec-drivers.rst
 create mode 100644 Documentation/admin-guide/media/ci.rst
 create mode 100644 Documentation/admin-guide/media/cpia2.rst
 create mode 100644 Documentation/admin-guide/media/cx18-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/cx231xx-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/cx23885-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/cx88-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/cx88.rst
 create mode 100644 Documentation/admin-guide/media/davinci-vpbe.rst
 create mode 100644 Documentation/admin-guide/media/dvb-drivers.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-a800-cardlist.r=
st
 create mode 100644 Documentation/admin-guide/media/dvb-usb-af9005-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-af9015-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-af9035-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-anysee-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-au6610-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-az6007-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-az6027-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-ce6230-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-cinergyT2-cardl=
ist.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-cxusb-cardlist.=
rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dib0700-cardlis=
t.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dibusb-mb-cardl=
ist.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dibusb-mc-cardl=
ist.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-digitv-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dtt200u-cardlis=
t.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dtv5100-cardlis=
t.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dvbsky-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-dw2102-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-ec168-cardlist.=
rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-gl861-cardlist.=
rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-gp8psk-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-lmedm04-cardlis=
t.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-m920x-cardlist.=
rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-mxl111sf-cardli=
st.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-nova-t-usb2-car=
dlist.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-opera1-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-pctv452e-cardli=
st.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-rtl28xxu-cardli=
st.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-technisat-usb2-=
cardlist.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-ttusb2-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-umt-010-cardlis=
t.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-vp702x-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-vp7045-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb-usb-zd1301-cardlist=
.rst
 create mode 100644 Documentation/admin-guide/media/dvb.rst
 create mode 100644 Documentation/admin-guide/media/dvb_intro.rst
 create mode 100644 Documentation/admin-guide/media/dvb_references.rst
 create mode 100644 Documentation/admin-guide/media/em28xx-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/faq.rst
 create mode 100644 Documentation/admin-guide/media/fimc.rst
 create mode 100644 Documentation/admin-guide/media/frontend-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/gspca-card=
list.rst (100%)
 create mode 100644 Documentation/admin-guide/media/i2c-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/imx.rst
 create mode 100644 Documentation/admin-guide/media/imx6q-sabreauto.dot
 create mode 100644 Documentation/admin-guide/media/imx6q-sabresd.dot
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/imx7.rst (=
100%)
 create mode 100644 Documentation/admin-guide/media/index.rst
 create mode 100644 Documentation/admin-guide/media/intro.rst
 create mode 100644 Documentation/admin-guide/media/ipu3.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/ipu3_rcb.s=
vg (100%)
 create mode 100644 Documentation/admin-guide/media/ivtv-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/ivtv.rst (=
100%)
 rename Documentation/{media/dvb-drivers =3D> admin-guide/media}/lmedm04.rs=
t (100%)
 create mode 100644 Documentation/admin-guide/media/meye.rst
 create mode 100644 Documentation/admin-guide/media/misc-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/omap3isp.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/omap4_came=
ra.rst (100%)
 rename Documentation/{media/dvb-drivers =3D> admin-guide/media}/opera-firm=
ware.rst (100%)
 create mode 100644 Documentation/admin-guide/media/other-usb-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/pci-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/philips.rs=
t (100%)
 create mode 100644 Documentation/admin-guide/media/platform-cardlist.rst
 rename Documentation/{media/cec-drivers =3D> admin-guide/media}/pulse8-cec=
.rst (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/qcom_camss=
.rst (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/qcom_camss=
_8x96_graph.dot (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/qcom_camss=
_graph.dot (100%)
 create mode 100644 Documentation/admin-guide/media/radio-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/rcar-fdp1.=
rst (100%)
 create mode 100644 Documentation/admin-guide/media/remote-controller.rst
 create mode 100644 Documentation/admin-guide/media/saa7134-cardlist.rst
 create mode 100644 Documentation/admin-guide/media/saa7134.rst
 create mode 100644 Documentation/admin-guide/media/saa7164-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/si470x.rst=
 (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/si4713.rst=
 (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/si476x.rst=
 (100%)
 create mode 100644 Documentation/admin-guide/media/siano-cardlist.rst
 rename Documentation/{media/dvb-drivers =3D> admin-guide/media}/technisat.=
rst (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/tm6000-car=
dlist.rst (100%)
 rename Documentation/{media/dvb-drivers =3D> admin-guide/media}/ttusb-dec.=
rst (100%)
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/tuner-card=
list.rst (100%)
 create mode 100644 Documentation/admin-guide/media/usb-cardlist.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/usbvision-=
cardlist.rst (100%)
 create mode 100644 Documentation/admin-guide/media/v4l-drivers.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/vimc.dot (=
100%)
 create mode 100644 Documentation/admin-guide/media/vimc.rst
 rename Documentation/{media/v4l-drivers =3D> admin-guide/media}/vivid.rst =
(100%)
 create mode 100644 Documentation/admin-guide/media/zr364xx.rst
 create mode 100644 Documentation/devicetree/bindings/media/i2c/ov8856.yaml
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,vdec.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.txt
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-rga.ya=
ml
 delete mode 100644 Documentation/devicetree/bindings/media/rockchip-vpu.txt
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-vpu.ya=
ml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip-mipi-dph=
y-rx0.yaml
 rename Documentation/{media/kapi =3D> driver-api/media}/cec-core.rst (100%)
 create mode 100644 Documentation/driver-api/media/csi2.rst
 create mode 100644 Documentation/driver-api/media/drivers/bttv-devel.rst
 rename Documentation/{media/dvb-drivers =3D> driver-api/media/drivers}/con=
tributors.rst (100%)
 create mode 100644 Documentation/driver-api/media/drivers/cpia2_devel.rst
 create mode 100644 Documentation/driver-api/media/drivers/cx2341x-devel.rst
 create mode 100644 Documentation/driver-api/media/drivers/cx88-devel.rst
 create mode 100644 Documentation/driver-api/media/drivers/davinci-vpbe-dev=
el.rst
 rename Documentation/{media/dvb-drivers =3D> driver-api/media/drivers}/dvb=
-usb.rst (100%)
 create mode 100644 Documentation/driver-api/media/drivers/fimc-devel.rst
 rename Documentation/{media/dvb-drivers =3D> driver-api/media/drivers}/fro=
ntends.rst (100%)
 create mode 100644 Documentation/driver-api/media/drivers/index.rst
 rename Documentation/{media/v4l-drivers =3D> driver-api/media/drivers}/pvr=
usb2.rst (100%)
 rename Documentation/{media/v4l-drivers =3D> driver-api/media/drivers}/pxa=
_camera.rst (100%)
 rename Documentation/{media/v4l-drivers =3D> driver-api/media/drivers}/rad=
iotrack.rst (100%)
 create mode 100644 Documentation/driver-api/media/drivers/saa7134-devel.rst
 rename Documentation/{media/v4l-drivers =3D> driver-api/media/drivers}/sh_=
mobile_ceu_camera.rst (100%)
 rename Documentation/{media/v4l-drivers =3D> driver-api/media/drivers}/tun=
ers.rst (100%)
 create mode 100644 Documentation/driver-api/media/drivers/vimc-devel.rst
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-ca.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-common.rst (10=
0%)
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-core.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-demux.rst (100=
%)
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-frontend.rst (=
100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/dtv-net.rst (100%)
 create mode 100644 Documentation/driver-api/media/index.rst
 rename Documentation/{media/kapi =3D> driver-api/media}/mc-core.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/rc-core.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-async.rst (10=
0%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-clocks.rst (1=
00%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-common.rst (1=
00%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-controls.rst =
(100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-core.rst (100=
%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-dev.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-device.rst (1=
00%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-dv-timings.rs=
t (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-event.rst (10=
0%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-fh.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-flash-led-cla=
ss.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-fwnode.rst (1=
00%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-intro.rst (10=
0%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-mc.rst (100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-mediabus.rst =
(100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-mem2mem.rst (=
100%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-rect.rst (100=
%)
 create mode 100644 Documentation/driver-api/media/v4l2-subdev.rst
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-tuner.rst (10=
0%)
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-tveeprom.rst =
(100%)
 create mode 100644 Documentation/driver-api/media/v4l2-videobuf.rst
 rename Documentation/{media/kapi =3D> driver-api/media}/v4l2-videobuf2.rst=
 (100%)
 delete mode 100644 Documentation/media/.gitignore
 delete mode 100644 Documentation/media/Makefile
 delete mode 100644 Documentation/media/cec-drivers/index.rst
 delete mode 100644 Documentation/media/dvb-drivers/avermedia.rst
 delete mode 100644 Documentation/media/dvb-drivers/bt8xx.rst
 delete mode 100644 Documentation/media/dvb-drivers/cards.rst
 delete mode 100644 Documentation/media/dvb-drivers/ci.rst
 delete mode 100644 Documentation/media/dvb-drivers/faq.rst
 delete mode 100644 Documentation/media/dvb-drivers/index.rst
 delete mode 100644 Documentation/media/dvb-drivers/intro.rst
 delete mode 100644 Documentation/media/dvb-drivers/udev.rst
 delete mode 100644 Documentation/media/index.rst
 delete mode 100644 Documentation/media/kapi/csi2.rst
 delete mode 100644 Documentation/media/kapi/v4l2-subdev.rst
 delete mode 100644 Documentation/media/kapi/v4l2-videobuf.rst
 delete mode 100644 Documentation/media/media_kapi.rst
 delete mode 100644 Documentation/media/media_uapi.rst
 delete mode 100644 Documentation/media/typical_media_device.svg
 delete mode 100644 Documentation/media/uapi/cec/cec-api.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-func-close.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-func-ioctl.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-func-open.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-func-poll.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-funcs.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-header.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-intro.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-adap-g-caps.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-adap-g-log-addrs.r=
st
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-adap-g-phys-addr.r=
st
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-dqevent.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-g-mode.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-ioc-receive.rst
 delete mode 100644 Documentation/media/uapi/cec/cec-pin-error-inj.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-bilingual-channel-se=
lect.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-channel-select.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-clear-buffer.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-continue.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-fclose.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-fopen.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-fwrite.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-get-capabilities.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-get-status.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-pause.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-play.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-select-source.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-av-sync.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-bypass-mode.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-id.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-mixer.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-mute.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-set-streamtype.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio-stop.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio_data_types.rst
 delete mode 100644 Documentation/media/uapi/dvb/audio_function_calls.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-fclose.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-fopen.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-get-cap.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-get-descr-info.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-get-msg.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-get-slot-info.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-reset.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-send-msg.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca-set-descr.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca_data_types.rst
 delete mode 100644 Documentation/media/uapi/dvb/ca_function_calls.rst
 delete mode 100644 Documentation/media/uapi/dvb/demux.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-add-pid.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-expbuf.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-fclose.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-fopen.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-fread.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-fwrite.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-get-pes-pids.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-get-stc.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-mmap.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-munmap.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-qbuf.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-querybuf.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-remove-pid.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-reqbufs.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-set-buffer-size.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-set-filter.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-set-pes-filter.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-start.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx-stop.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx_fcalls.rst
 delete mode 100644 Documentation/media/uapi/dvb/dmx_types.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvb-fe-read-status.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvb-frontend-event.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvb-frontend-parameters.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvbapi.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvbproperty.rst
 delete mode 100644 Documentation/media/uapi/dvb/dvbstb.svg
 delete mode 100644 Documentation/media/uapi/dvb/examples.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-bandwidth-t.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-diseqc-recv-slave-reply=
.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-diseqc-reset-overload.r=
st
 delete mode 100644 Documentation/media/uapi/dvb/fe-diseqc-send-burst.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-diseqc-send-master-cmd.=
rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-dishnetwork-send-legacy=
-cmd.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-enable-high-lnb-voltage=
.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-get-event.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-get-frontend.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-get-info.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-get-property.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-read-ber.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-read-signal-strength.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-read-snr.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-read-status.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-read-uncorrected-blocks=
.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-set-frontend-tune-mode.=
rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-set-frontend.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-set-tone.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-set-voltage.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe-type-t.rst
 delete mode 100644 Documentation/media/uapi/dvb/fe_property_parameters.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend-header.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend-property-cable-sy=
stems.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend-property-satellit=
e-systems.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend-property-terrestr=
ial-systems.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend-stat-properties.r=
st
 delete mode 100644 Documentation/media/uapi/dvb/frontend.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend_f_close.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend_f_open.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend_fcalls.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend_legacy_api.rst
 delete mode 100644 Documentation/media/uapi/dvb/frontend_legacy_dvbv3_api.=
rst
 delete mode 100644 Documentation/media/uapi/dvb/headers.rst
 delete mode 100644 Documentation/media/uapi/dvb/intro.rst
 delete mode 100644 Documentation/media/uapi/dvb/legacy_dvb_apis.rst
 delete mode 100644 Documentation/media/uapi/dvb/net-add-if.rst
 delete mode 100644 Documentation/media/uapi/dvb/net-get-if.rst
 delete mode 100644 Documentation/media/uapi/dvb/net-remove-if.rst
 delete mode 100644 Documentation/media/uapi/dvb/net-types.rst
 delete mode 100644 Documentation/media/uapi/dvb/net.rst
 delete mode 100644 Documentation/media/uapi/dvb/query-dvb-frontend-info.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-clear-buffer.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-command.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-continue.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-fast-forward.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-fclose.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-fopen.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-freeze.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-fwrite.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-capabilities.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-event.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-frame-count.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-pts.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-size.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-get-status.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-play.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-select-source.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-set-blank.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-set-display-format.r=
st
 delete mode 100644 Documentation/media/uapi/dvb/video-set-format.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-set-streamtype.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-slowmotion.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-stillpicture.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-stop.rst
 delete mode 100644 Documentation/media/uapi/dvb/video-try-command.rst
 delete mode 100644 Documentation/media/uapi/dvb/video.rst
 delete mode 100644 Documentation/media/uapi/dvb/video_function_calls.rst
 delete mode 100644 Documentation/media/uapi/dvb/video_types.rst
 delete mode 100644 Documentation/media/uapi/fdl-appendix.rst
 delete mode 100644 Documentation/media/uapi/gen-errors.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-controller-intr=
o.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-controller-mode=
l.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-controller.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-func-close.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-func-ioctl.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-func-open.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-funcs.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-header.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-device-info=
.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-enum-entiti=
es.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-enum-links.=
rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-g-topology.=
rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-request-all=
oc.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-ioc-setup-link.=
rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-request-ioc-que=
ue.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-request-ioc-rei=
nit.rst
 delete mode 100644 Documentation/media/uapi/mediactl/media-types.rst
 delete mode 100644 Documentation/media/uapi/mediactl/request-api.rst
 delete mode 100644 Documentation/media/uapi/mediactl/request-func-close.rst
 delete mode 100644 Documentation/media/uapi/mediactl/request-func-ioctl.rst
 delete mode 100644 Documentation/media/uapi/mediactl/request-func-poll.rst
 delete mode 100644 Documentation/media/uapi/rc/keytable.c.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-dev-intro.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-dev.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-func.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-get-features.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-get-rec-mode.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-get-rec-resolution.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-get-send-mode.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-get-timeout.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-header.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-read.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-measure-carrier-mo=
de.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-rec-carrier-range.=
rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-rec-carrier.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-rec-timeout-report=
s.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-rec-timeout.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-send-carrier.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-send-duty-cycle.rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-transmitter-mask.r=
st
 delete mode 100644 Documentation/media/uapi/rc/lirc-set-wideband-receiver.=
rst
 delete mode 100644 Documentation/media/uapi/rc/lirc-write.rst
 delete mode 100644 Documentation/media/uapi/rc/rc-intro.rst
 delete mode 100644 Documentation/media/uapi/rc/rc-sysfs-nodes.rst
 delete mode 100644 Documentation/media/uapi/rc/rc-table-change.rst
 delete mode 100644 Documentation/media/uapi/rc/rc-tables.rst
 delete mode 100644 Documentation/media/uapi/rc/remote_controllers.rst
 delete mode 100644 Documentation/media/uapi/v4l/app-pri.rst
 delete mode 100644 Documentation/media/uapi/v4l/async.rst
 delete mode 100644 Documentation/media/uapi/v4l/audio.rst
 delete mode 100644 Documentation/media/uapi/v4l/bayer.svg
 delete mode 100644 Documentation/media/uapi/v4l/biblio.rst
 delete mode 100644 Documentation/media/uapi/v4l/buffer.rst
 delete mode 100644 Documentation/media/uapi/v4l/capture-example.rst
 delete mode 100644 Documentation/media/uapi/v4l/capture.c.rst
 delete mode 100644 Documentation/media/uapi/v4l/colorspaces-defs.rst
 delete mode 100644 Documentation/media/uapi/v4l/colorspaces-details.rst
 delete mode 100644 Documentation/media/uapi/v4l/colorspaces.rst
 delete mode 100644 Documentation/media/uapi/v4l/common-defs.rst
 delete mode 100644 Documentation/media/uapi/v4l/common.rst
 delete mode 100644 Documentation/media/uapi/v4l/compat.rst
 delete mode 100644 Documentation/media/uapi/v4l/constraints.svg
 delete mode 100644 Documentation/media/uapi/v4l/control.rst
 delete mode 100644 Documentation/media/uapi/v4l/crop.rst
 delete mode 100644 Documentation/media/uapi/v4l/crop.svg
 delete mode 100644 Documentation/media/uapi/v4l/depth-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-capture.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-event.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-mem2mem.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-meta.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-osd.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-output.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-overlay.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-radio.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-raw-vbi.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-rds.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-sdr.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-sliced-vbi.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-subdev.rst
 delete mode 100644 Documentation/media/uapi/v4l/dev-touch.rst
 delete mode 100644 Documentation/media/uapi/v4l/devices.rst
 delete mode 100644 Documentation/media/uapi/v4l/diff-v4l.rst
 delete mode 100644 Documentation/media/uapi/v4l/dmabuf.rst
 delete mode 100644 Documentation/media/uapi/v4l/dv-timings.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-camera.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-codec.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-detect.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-dv.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-flash.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-fm-rx.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-fm-tx.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-image-process.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-image-source.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-jpeg.rst
 delete mode 100644 Documentation/media/uapi/v4l/ext-ctrls-rf-tuner.rst
 delete mode 100644 Documentation/media/uapi/v4l/extended-controls.rst
 delete mode 100644 Documentation/media/uapi/v4l/field-order.rst
 delete mode 100644 Documentation/media/uapi/v4l/fieldseq_bt.svg
 delete mode 100644 Documentation/media/uapi/v4l/fieldseq_tb.svg
 delete mode 100644 Documentation/media/uapi/v4l/format.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-close.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-ioctl.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-mmap.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-munmap.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-open.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-poll.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-read.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-select.rst
 delete mode 100644 Documentation/media/uapi/v4l/func-write.rst
 delete mode 100644 Documentation/media/uapi/v4l/hist-v4l2.rst
 delete mode 100644 Documentation/media/uapi/v4l/hsv-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/io.rst
 delete mode 100644 Documentation/media/uapi/v4l/libv4l-introduction.rst
 delete mode 100644 Documentation/media/uapi/v4l/libv4l.rst
 delete mode 100644 Documentation/media/uapi/v4l/meta-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/mmap.rst
 delete mode 100644 Documentation/media/uapi/v4l/nv12mt.svg
 delete mode 100644 Documentation/media/uapi/v4l/nv12mt_example.svg
 delete mode 100644 Documentation/media/uapi/v4l/open.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-bayer.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-compressed.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-grey.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-indexed.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-intro.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-inzi.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-m420.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-d4xx.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-intel-ipu3.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-uvc.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-vivid.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgo.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-meta-vsp1-hgt.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv12.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv12m.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv12mt.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv16m.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-nv24.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-packed-hsv.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-packed-yuv.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-reserved.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-rgb.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-cs08.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-cs14le.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-cu08.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-cu16le.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-pcu16be.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-pcu18be.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-pcu20be.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-sdr-ru12le.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb10-ipu3.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb10.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb10alaw8.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb10dpcm8.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb10p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb12.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb12p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb14.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb14p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-srggb8.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-tch-td08.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-tch-td16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-tch-tu08.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-tch-tu16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-uv8.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-uyvy.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-v4l2-mplane.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-v4l2.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-vyuy.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y10.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y10b.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y10p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y12.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y12i.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y14.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y16-be.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y41p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-y8i.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv410.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv411p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv420.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv420m.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv422m.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv422p.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuv444m.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yuyv.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-yvyu.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt-z16.rst
 delete mode 100644 Documentation/media/uapi/v4l/pixfmt.rst
 delete mode 100644 Documentation/media/uapi/v4l/planar-apis.rst
 delete mode 100644 Documentation/media/uapi/v4l/querycap.rst
 delete mode 100644 Documentation/media/uapi/v4l/rw.rst
 delete mode 100644 Documentation/media/uapi/v4l/sdr-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api-configuratio=
n.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api-examples.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api-intro.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api-targets.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api-vs-crop-api.=
rst
 delete mode 100644 Documentation/media/uapi/v4l/selection-api.rst
 delete mode 100644 Documentation/media/uapi/v4l/selection.svg
 delete mode 100644 Documentation/media/uapi/v4l/selections-common.rst
 delete mode 100644 Documentation/media/uapi/v4l/standard.rst
 delete mode 100644 Documentation/media/uapi/v4l/streaming-par.rst
 delete mode 100644 Documentation/media/uapi/v4l/subdev-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/subdev-image-processing-cr=
op.svg
 delete mode 100644 Documentation/media/uapi/v4l/subdev-image-processing-fu=
ll.svg
 delete mode 100644 Documentation/media/uapi/v4l/subdev-image-processing-sc=
aling-multi-source.svg
 delete mode 100644 Documentation/media/uapi/v4l/tch-formats.rst
 delete mode 100644 Documentation/media/uapi/v4l/tuner.rst
 delete mode 100644 Documentation/media/uapi/v4l/user-func.rst
 delete mode 100644 Documentation/media/uapi/v4l/userp.rst
 delete mode 100644 Documentation/media/uapi/v4l/v4l2-selection-flags.rst
 delete mode 100644 Documentation/media/uapi/v4l/v4l2-selection-targets.rst
 delete mode 100644 Documentation/media/uapi/v4l/v4l2.rst
 delete mode 100644 Documentation/media/uapi/v4l/v4l2grab-example.rst
 delete mode 100644 Documentation/media/uapi/v4l/v4l2grab.c.rst
 delete mode 100644 Documentation/media/uapi/v4l/vbi_525.svg
 delete mode 100644 Documentation/media/uapi/v4l/vbi_625.svg
 delete mode 100644 Documentation/media/uapi/v4l/vbi_hsync.svg
 delete mode 100644 Documentation/media/uapi/v4l/video.rst
 delete mode 100644 Documentation/media/uapi/v4l/videodev.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-create-bufs.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-cropcap.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-dbg-g-chip-info.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-dbg-g-register.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-decoder-cmd.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-dqevent.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-dv-timings-cap.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-encoder-cmd.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enum-dv-timings.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enum-fmt.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enum-frameintervals=
.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enum-framesizes.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enum-freq-bands.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enumaudio.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enumaudioout.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enuminput.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enumoutput.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-enumstd.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-expbuf.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-audio.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-audioout.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-crop.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-ctrl.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-dv-timings.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-edid.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-enc-index.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-ext-ctrls.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-fbuf.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-fmt.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-frequency.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-input.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-jpegcomp.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-modulator.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-output.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-parm.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-priority.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-selection.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-sliced-vbi-cap.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-std.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-g-tuner.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-log-status.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-overlay.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-prepare-buf.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-qbuf.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-query-dv-timings.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-querybuf.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-querycap.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-queryctrl.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-querystd.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-reqbufs.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-s-hw-freq-seek.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-streamon.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-enum-frame-i=
nterval.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-enum-frame-s=
ize.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-enum-mbus-co=
de.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-g-crop.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-g-fmt.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-g-frame-inte=
rval.rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subdev-g-selection.=
rst
 delete mode 100644 Documentation/media/uapi/v4l/vidioc-subscribe-event.rst
 delete mode 100644 Documentation/media/uapi/v4l/yuv-formats.rst
 delete mode 100644 Documentation/media/v4l-drivers/bttv-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/bttv.rst
 delete mode 100644 Documentation/media/v4l-drivers/cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/cpia2.rst
 delete mode 100644 Documentation/media/v4l-drivers/cx2341x.rst
 delete mode 100644 Documentation/media/v4l-drivers/cx23885-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/cx88-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/cx88.rst
 delete mode 100644 Documentation/media/v4l-drivers/davinci-vpbe.rst
 delete mode 100644 Documentation/media/v4l-drivers/em28xx-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/fimc.rst
 delete mode 100644 Documentation/media/v4l-drivers/imx.rst
 delete mode 100644 Documentation/media/v4l-drivers/index.rst
 delete mode 100644 Documentation/media/v4l-drivers/ipu3.rst
 delete mode 100644 Documentation/media/v4l-drivers/ivtv-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/max2175.rst
 delete mode 100644 Documentation/media/v4l-drivers/meye.rst
 delete mode 100644 Documentation/media/v4l-drivers/omap3isp.rst
 delete mode 100644 Documentation/media/v4l-drivers/saa7134-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/saa7134.rst
 delete mode 100644 Documentation/media/v4l-drivers/saa7164-cardlist.rst
 delete mode 100644 Documentation/media/v4l-drivers/v4l-with-ir.rst
 delete mode 100644 Documentation/media/v4l-drivers/vimc.rst
 delete mode 100644 Documentation/media/v4l-drivers/zr364xx.rst
 delete mode 100644 Documentation/media/videodev2.h.rst.exceptions
 create mode 100644 Documentation/userspace-api/media/Makefile
 rename Documentation/{ =3D> userspace-api}/media/audio.h.rst.exceptions (1=
00%)
 rename Documentation/{ =3D> userspace-api}/media/ca.h.rst.exceptions (100%)
 rename Documentation/{ =3D> userspace-api}/media/cec.h.rst.exceptions (100=
%)
 create mode 100644 Documentation/userspace-api/media/cec/cec-api.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-func-close.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-func-ioctl.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-func-open.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-func-poll.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-funcs.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-header.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-intro.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-adap-g-ca=
ps.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/cec/cec-ioc-ada=
p-g-conn-info.rst (100%)
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-adap-g-lo=
g-addrs.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-adap-g-ph=
ys-addr.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-dqevent.r=
st
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-g-mode.rst
 create mode 100644 Documentation/userspace-api/media/cec/cec-ioc-receive.r=
st
 create mode 100644 Documentation/userspace-api/media/cec/cec-pin-error-inj=
.rst
 rename Documentation/{ =3D> userspace-api}/media/conf_nitpick.py (100%)
 rename Documentation/{ =3D> userspace-api}/media/dmx.h.rst.exceptions (100=
%)
 create mode 100644 Documentation/userspace-api/media/drivers/cx2341x-uapi.=
rst
 create mode 100644 Documentation/userspace-api/media/drivers/imx-uapi.rst
 create mode 100644 Documentation/userspace-api/media/drivers/index.rst
 create mode 100644 Documentation/userspace-api/media/drivers/max2175.rst
 create mode 100644 Documentation/userspace-api/media/drivers/meye-uapi.rst
 create mode 100644 Documentation/userspace-api/media/drivers/omap3isp-uapi=
.rst
 rename Documentation/{media/v4l-drivers =3D> userspace-api/media/drivers}/=
uvcvideo.rst (100%)
 create mode 100644 Documentation/userspace-api/media/dvb/audio-bilingual-c=
hannel-select.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-channel-sel=
ect.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-clear-buffe=
r.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-continue.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-fclose.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-fopen.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-fwrite.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-get-capabil=
ities.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-get-status.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-pause.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-play.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-select-sour=
ce.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-av-sync=
.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-bypass-=
mode.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-id.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-mixer.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-mute.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-set-streamt=
ype.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio-stop.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio.rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio_data_types.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/audio_function_ca=
lls.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-fclose.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-fopen.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-get-cap.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-get-descr-info=
.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-get-msg.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-get-slot-info.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-reset.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-send-msg.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca-set-descr.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca_data_types.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca_function_calls=
.rst
 create mode 100644 Documentation/userspace-api/media/dvb/ca_high_level.rst
 create mode 100644 Documentation/userspace-api/media/dvb/demux.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-add-pid.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-expbuf.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-fclose.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-fopen.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-fread.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-fwrite.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-get-pes-pids.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-get-stc.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-mmap.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-munmap.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-qbuf.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-querybuf.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-remove-pid.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-reqbufs.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-set-buffer-si=
ze.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-set-filter.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-set-pes-filte=
r.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-start.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx-stop.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx_fcalls.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dmx_types.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvb-fe-read-statu=
s.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvb-frontend-even=
t.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvb-frontend-para=
meters.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvbapi.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvbproperty.rst
 create mode 100644 Documentation/userspace-api/media/dvb/dvbstb.svg
 create mode 100644 Documentation/userspace-api/media/dvb/examples.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-bandwidth-t.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-diseqc-recv-sl=
ave-reply.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-diseqc-reset-o=
verload.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-diseqc-send-bu=
rst.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-diseqc-send-ma=
ster-cmd.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-dishnetwork-se=
nd-legacy-cmd.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-enable-high-ln=
b-voltage.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-get-event.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-get-frontend.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/fe-get-info.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-get-property.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/fe-read-ber.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-read-signal-st=
rength.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-read-snr.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-read-status.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-read-uncorrect=
ed-blocks.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-set-frontend-t=
une-mode.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-set-frontend.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/fe-set-tone.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-set-voltage.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe-type-t.rst
 create mode 100644 Documentation/userspace-api/media/dvb/fe_property_param=
eters.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend-header.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/frontend-property=
-cable-systems.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend-property=
-satellite-systems.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend-property=
-terrestrial-systems.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend-stat-pro=
perties.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend_f_close.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend_f_open.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/frontend_fcalls.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/frontend_legacy_a=
pi.rst
 create mode 100644 Documentation/userspace-api/media/dvb/frontend_legacy_d=
vbv3_api.rst
 create mode 100644 Documentation/userspace-api/media/dvb/headers.rst
 create mode 100644 Documentation/userspace-api/media/dvb/intro.rst
 create mode 100644 Documentation/userspace-api/media/dvb/legacy_dvb_apis.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/net-add-if.rst
 create mode 100644 Documentation/userspace-api/media/dvb/net-get-if.rst
 create mode 100644 Documentation/userspace-api/media/dvb/net-remove-if.rst
 create mode 100644 Documentation/userspace-api/media/dvb/net-types.rst
 create mode 100644 Documentation/userspace-api/media/dvb/net.rst
 create mode 100644 Documentation/userspace-api/media/dvb/query-dvb-fronten=
d-info.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-clear-buffe=
r.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-command.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-continue.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-fast-forwar=
d.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-fclose.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-fopen.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-freeze.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-fwrite.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-capabil=
ities.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-event.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-frame-c=
ount.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-pts.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-size.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-get-status.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-play.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-select-sour=
ce.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-set-blank.r=
st
 create mode 100644 Documentation/userspace-api/media/dvb/video-set-display=
-format.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-set-format.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-set-streamt=
ype.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-slowmotion.=
rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-stillpictur=
e.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-stop.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video-try-command=
.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video_function_ca=
lls.rst
 create mode 100644 Documentation/userspace-api/media/dvb/video_types.rst
 create mode 100644 Documentation/userspace-api/media/fdl-appendix.rst
 rename Documentation/{ =3D> userspace-api}/media/frontend.h.rst.exceptions=
 (100%)
 create mode 100644 Documentation/userspace-api/media/gen-errors.rst
 create mode 100644 Documentation/userspace-api/media/index.rst
 rename Documentation/{ =3D> userspace-api}/media/intro.rst (100%)
 rename Documentation/{ =3D> userspace-api}/media/lirc.h.rst.exceptions (10=
0%)
 rename Documentation/{ =3D> userspace-api}/media/media.h.rst.exceptions (1=
00%)
 create mode 100644 Documentation/userspace-api/media/mediactl/media-contro=
ller-intro.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-contro=
ller-model.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-contro=
ller.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-func-c=
lose.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-func-i=
octl.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-func-o=
pen.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-funcs.=
rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-header=
.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-de=
vice-info.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-en=
um-entities.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-en=
um-links.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-g-=
topology.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-re=
quest-alloc.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-ioc-se=
tup-link.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-reques=
t-ioc-queue.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-reques=
t-ioc-reinit.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/media-types.=
rst
 create mode 100644 Documentation/userspace-api/media/mediactl/request-api.=
rst
 create mode 100644 Documentation/userspace-api/media/mediactl/request-func=
-close.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/request-func=
-ioctl.rst
 create mode 100644 Documentation/userspace-api/media/mediactl/request-func=
-poll.rst
 rename Documentation/{ =3D> userspace-api}/media/net.h.rst.exceptions (100=
%)
 create mode 100644 Documentation/userspace-api/media/rc/keytable.c.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-dev-intro.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-dev.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-func.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-get-features.=
rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-get-rec-mode.=
rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-get-rec-resol=
ution.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-get-send-mode=
.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-get-timeout.r=
st
 create mode 100644 Documentation/userspace-api/media/rc/lirc-header.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-read.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-measure-c=
arrier-mode.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-rec-carri=
er-range.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-rec-carri=
er.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-rec-timeo=
ut-reports.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-rec-timeo=
ut.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-send-carr=
ier.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-send-duty=
-cycle.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-transmitt=
er-mask.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-set-wideband-=
receiver.rst
 create mode 100644 Documentation/userspace-api/media/rc/lirc-write.rst
 create mode 100644 Documentation/userspace-api/media/rc/rc-intro.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/rc/rc-protos.rs=
t (100%)
 create mode 100644 Documentation/userspace-api/media/rc/rc-sysfs-nodes.rst
 create mode 100644 Documentation/userspace-api/media/rc/rc-table-change.rst
 create mode 100644 Documentation/userspace-api/media/rc/rc-tables.rst
 create mode 100644 Documentation/userspace-api/media/rc/remote_controllers=
.rst
 create mode 100644 Documentation/userspace-api/media/typical_media_device.=
svg
 create mode 100644 Documentation/userspace-api/media/v4l/app-pri.rst
 create mode 100644 Documentation/userspace-api/media/v4l/async.rst
 create mode 100644 Documentation/userspace-api/media/v4l/audio.rst
 create mode 100644 Documentation/userspace-api/media/v4l/bayer.svg
 create mode 100644 Documentation/userspace-api/media/v4l/biblio.rst
 create mode 100644 Documentation/userspace-api/media/v4l/buffer.rst
 create mode 100644 Documentation/userspace-api/media/v4l/capture-example.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/capture.c.rst
 create mode 100644 Documentation/userspace-api/media/v4l/colorspaces-defs.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/colorspaces-detai=
ls.rst
 create mode 100644 Documentation/userspace-api/media/v4l/colorspaces.rst
 create mode 100644 Documentation/userspace-api/media/v4l/common-defs.rst
 create mode 100644 Documentation/userspace-api/media/v4l/common.rst
 create mode 100644 Documentation/userspace-api/media/v4l/compat.rst
 create mode 100644 Documentation/userspace-api/media/v4l/constraints.svg
 create mode 100644 Documentation/userspace-api/media/v4l/control.rst
 create mode 100644 Documentation/userspace-api/media/v4l/crop.rst
 create mode 100644 Documentation/userspace-api/media/v4l/crop.svg
 create mode 100644 Documentation/userspace-api/media/v4l/depth-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-capture.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/v4l/dev-decoder=
.rst (100%)
 create mode 100644 Documentation/userspace-api/media/v4l/dev-event.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-mem2mem.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-meta.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-osd.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-output.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-overlay.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-radio.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-raw-vbi.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-rds.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-sdr.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-sliced-vbi.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/v4l/dev-statele=
ss-decoder.rst (100%)
 create mode 100644 Documentation/userspace-api/media/v4l/dev-subdev.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dev-touch.rst
 create mode 100644 Documentation/userspace-api/media/v4l/devices.rst
 create mode 100644 Documentation/userspace-api/media/v4l/diff-v4l.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dmabuf.rst
 create mode 100644 Documentation/userspace-api/media/v4l/dv-timings.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-camera.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-codec.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-detect.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-dv.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-flash.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-fm-rx.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-fm-tx.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-image-p=
rocess.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-image-s=
ource.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-jpeg.rst
 create mode 100644 Documentation/userspace-api/media/v4l/ext-ctrls-rf-tune=
r.rst
 create mode 100644 Documentation/userspace-api/media/v4l/extended-controls=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/field-order.rst
 create mode 100644 Documentation/userspace-api/media/v4l/fieldseq_bt.svg
 create mode 100644 Documentation/userspace-api/media/v4l/fieldseq_tb.svg
 create mode 100644 Documentation/userspace-api/media/v4l/format.rst
 rename Documentation/{media/v4l-drivers =3D> userspace-api/media/v4l}/four=
cc.rst (100%)
 create mode 100644 Documentation/userspace-api/media/v4l/func-close.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-ioctl.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-mmap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-munmap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-open.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-poll.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-read.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-select.rst
 create mode 100644 Documentation/userspace-api/media/v4l/func-write.rst
 create mode 100644 Documentation/userspace-api/media/v4l/hist-v4l2.rst
 create mode 100644 Documentation/userspace-api/media/v4l/hsv-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/io.rst
 create mode 100644 Documentation/userspace-api/media/v4l/libv4l-introducti=
on.rst
 create mode 100644 Documentation/userspace-api/media/v4l/libv4l.rst
 create mode 100644 Documentation/userspace-api/media/v4l/meta-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/mmap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/nv12mt.svg
 create mode 100644 Documentation/userspace-api/media/v4l/nv12mt_example.svg
 create mode 100644 Documentation/userspace-api/media/v4l/open.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/v4l/pipeline.do=
t (100%)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-bayer.rst
 rename Documentation/{media/uapi =3D> userspace-api/media}/v4l/pixfmt-cnf4=
.rst (100%)
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-compressed=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-grey.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-indexed.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-intro.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-inzi.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-m420.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-d4xx.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-intel=
-ipu3.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-uvc.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-vivid=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-=
hgo.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-meta-vsp1-=
hgt.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv12.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv12m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv12mt.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv16.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv16m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-nv24.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-packed-hsv=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-packed-yuv=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-reserved.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-rgb.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-cs08.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-cs14le=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-cu08.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-cu16le=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu16b=
e.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu18b=
e.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-pcu20b=
e.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-sdr-ru12le=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb10-ip=
u3.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb10.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb10ala=
w8.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb10dpc=
m8.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb10p.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb12.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb12p.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb14.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb14p.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb16.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-srggb8.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-tch-td08.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-tch-td16.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-tch-tu08.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-tch-tu16.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-uv8.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-uyvy.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-v4l2-mplan=
e.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-v4l2.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-vyuy.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y10.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y10b.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y10p.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y12.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y12i.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y14.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y16-be.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y16.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y41p.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-y8i.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv410.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv411p.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv420.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv420m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv422m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv422p.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuv444m.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yuyv.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-yvyu.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt-z16.rst
 create mode 100644 Documentation/userspace-api/media/v4l/pixfmt.rst
 create mode 100644 Documentation/userspace-api/media/v4l/planar-apis.rst
 create mode 100644 Documentation/userspace-api/media/v4l/querycap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/rw.rst
 create mode 100644 Documentation/userspace-api/media/v4l/sdr-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api-con=
figuration.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api-exa=
mples.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api-int=
ro.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api-tar=
gets.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api-vs-=
crop-api.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection-api.rst
 create mode 100644 Documentation/userspace-api/media/v4l/selection.svg
 create mode 100644 Documentation/userspace-api/media/v4l/selections-common=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/standard.rst
 create mode 100644 Documentation/userspace-api/media/v4l/streaming-par.rst
 create mode 100644 Documentation/userspace-api/media/v4l/subdev-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/subdev-image-proc=
essing-crop.svg
 create mode 100644 Documentation/userspace-api/media/v4l/subdev-image-proc=
essing-full.svg
 create mode 100644 Documentation/userspace-api/media/v4l/subdev-image-proc=
essing-scaling-multi-source.svg
 create mode 100644 Documentation/userspace-api/media/v4l/tch-formats.rst
 create mode 100644 Documentation/userspace-api/media/v4l/tuner.rst
 create mode 100644 Documentation/userspace-api/media/v4l/user-func.rst
 create mode 100644 Documentation/userspace-api/media/v4l/userp.rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2-selection-fl=
ags.rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2-selection-ta=
rgets.rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2.rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2grab-example.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/v4l2grab.c.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vbi_525.svg
 create mode 100644 Documentation/userspace-api/media/v4l/vbi_625.svg
 create mode 100644 Documentation/userspace-api/media/v4l/vbi_hsync.svg
 create mode 100644 Documentation/userspace-api/media/v4l/video.rst
 create mode 100644 Documentation/userspace-api/media/v4l/videodev.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-create-buf=
s.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-cropcap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-dbg-g-chip=
-info.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-dbg-g-regi=
ster.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-decoder-cm=
d.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-dqevent.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-dv-timings=
-cap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-encoder-cm=
d.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enum-dv-ti=
mings.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enum-fmt.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enum-frame=
intervals.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enum-frame=
sizes.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enum-freq-=
bands.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enumaudio.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enumaudioo=
ut.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enuminput.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enumoutput=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-enumstd.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-expbuf.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-audio.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-audioout=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-crop.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-ctrl.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-dv-timin=
gs.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-edid.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-enc-inde=
x.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrl=
s.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-fbuf.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-fmt.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-frequenc=
y.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-input.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-jpegcomp=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-modulato=
r.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-output.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-parm.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-priority=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-selectio=
n.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-sliced-v=
bi-cap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-std.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-g-tuner.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-log-status=
.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-overlay.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-prepare-bu=
f.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-qbuf.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-query-dv-t=
imings.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-querybuf.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-querycap.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-queryctrl.=
rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-querystd.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-s-hw-freq-=
seek.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-streamon.r=
st
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-enu=
m-frame-interval.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-enu=
m-frame-size.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-enu=
m-mbus-code.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-c=
rop.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-f=
mt.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-f=
rame-interval.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-g-s=
election.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subdev-que=
rycap.rst
 create mode 100644 Documentation/userspace-api/media/v4l/vidioc-subscribe-=
event.rst
 create mode 100644 Documentation/userspace-api/media/v4l/yuv-formats.rst
 rename Documentation/{ =3D> userspace-api}/media/video.h.rst.exceptions (1=
00%)
 create mode 100644 Documentation/userspace-api/media/videodev2.h.rst.excep=
tions
 delete mode 100644 drivers/media/cec/cec-adap.c
 create mode 100644 drivers/media/cec/core/Makefile
 create mode 100644 drivers/media/cec/core/cec-adap.c
 rename drivers/media/cec/{ =3D> core}/cec-api.c (100%)
 rename drivers/media/cec/{ =3D> core}/cec-core.c (100%)
 rename drivers/media/cec/{ =3D> core}/cec-notifier.c (100%)
 rename drivers/media/cec/{ =3D> core}/cec-pin-error-inj.c (100%)
 rename drivers/media/cec/{ =3D> core}/cec-pin-priv.h (100%)
 rename drivers/media/cec/{ =3D> core}/cec-pin.c (100%)
 rename drivers/media/cec/{ =3D> core}/cec-priv.h (100%)
 create mode 100644 drivers/media/cec/platform/Kconfig
 create mode 100644 drivers/media/cec/platform/Makefile
 rename drivers/media/{ =3D> cec}/platform/cec-gpio/Makefile (100%)
 create mode 100644 drivers/media/cec/platform/cec-gpio/cec-gpio.c
 create mode 100644 drivers/media/cec/platform/cros-ec/Makefile
 rename drivers/media/{platform/cros-ec-cec =3D> cec/platform/cros-ec}/cros=
-ec-cec.c (100%)
 create mode 100644 drivers/media/cec/platform/meson/Makefile
 rename drivers/media/{ =3D> cec}/platform/meson/ao-cec-g12a.c (100%)
 rename drivers/media/{ =3D> cec}/platform/meson/ao-cec.c (100%)
 create mode 100644 drivers/media/cec/platform/s5p/Makefile
 rename drivers/media/{platform/s5p-cec =3D> cec/platform/s5p}/exynos_hdmi_=
cec.h (100%)
 rename drivers/media/{platform/s5p-cec =3D> cec/platform/s5p}/exynos_hdmi_=
cecctrl.c (100%)
 rename drivers/media/{platform/s5p-cec =3D> cec/platform/s5p}/regs-cec.h (=
100%)
 rename drivers/media/{platform/s5p-cec =3D> cec/platform/s5p}/s5p_cec.c (1=
00%)
 rename drivers/media/{platform/s5p-cec =3D> cec/platform/s5p}/s5p_cec.h (1=
00%)
 create mode 100644 drivers/media/cec/platform/seco/Makefile
 create mode 100644 drivers/media/cec/platform/seco/seco-cec.c
 rename drivers/media/{platform/seco-cec =3D> cec/platform/seco}/seco-cec.h=
 (100%)
 create mode 100644 drivers/media/cec/platform/sti/Makefile
 rename drivers/media/{platform/sti/cec =3D> cec/platform/sti}/stih-cec.c (=
100%)
 create mode 100644 drivers/media/cec/platform/stm32/Makefile
 rename drivers/media/{ =3D> cec}/platform/stm32/stm32-cec.c (100%)
 create mode 100644 drivers/media/cec/platform/tegra/Makefile
 rename drivers/media/{platform/tegra-cec =3D> cec/platform/tegra}/tegra_ce=
c.c (100%)
 rename drivers/media/{platform/tegra-cec =3D> cec/platform/tegra}/tegra_ce=
c.h (100%)
 create mode 100644 drivers/media/cec/usb/Kconfig
 create mode 100644 drivers/media/cec/usb/Makefile
 create mode 100644 drivers/media/cec/usb/pulse8/Kconfig
 rename drivers/media/{usb/pulse8-cec =3D> cec/usb/pulse8}/Makefile (100%)
 rename drivers/media/{usb/pulse8-cec =3D> cec/usb/pulse8}/pulse8-cec.c (10=
0%)
 create mode 100644 drivers/media/cec/usb/rainshadow/Kconfig
 rename drivers/media/{usb/rainshadow-cec =3D> cec/usb/rainshadow}/Makefile=
 (100%)
 rename drivers/media/{usb/rainshadow-cec =3D> cec/usb/rainshadow}/rainshad=
ow-cec.c (100%)
 create mode 100644 drivers/media/i2c/ov2740.c
 create mode 100644 drivers/media/pci/ddbridge/ddbridge-dummy-fe.c
 create mode 100644 drivers/media/pci/ddbridge/ddbridge-dummy-fe.h
 delete mode 100644 drivers/media/platform/cec-gpio/cec-gpio.c
 delete mode 100644 drivers/media/platform/cros-ec-cec/Makefile
 delete mode 100644 drivers/media/platform/meson/Makefile
 delete mode 100644 drivers/media/platform/s5p-cec/Makefile
 delete mode 100644 drivers/media/platform/seco-cec/Makefile
 delete mode 100644 drivers/media/platform/seco-cec/seco-cec.c
 delete mode 100644 drivers/media/platform/sh_veu.c
 delete mode 100644 drivers/media/platform/sti/cec/Makefile
 delete mode 100644 drivers/media/platform/tegra-cec/Makefile
 delete mode 100644 drivers/media/platform/vicodec/Kconfig
 delete mode 100644 drivers/media/platform/vicodec/vicodec-core.c
 delete mode 100644 drivers/media/platform/vim2m.c
 delete mode 100644 drivers/media/platform/vimc/Kconfig
 delete mode 100644 drivers/media/platform/vimc/vimc-capture.c
 delete mode 100644 drivers/media/platform/vimc/vimc-common.c
 delete mode 100644 drivers/media/platform/vimc/vimc-common.h
 delete mode 100644 drivers/media/platform/vimc/vimc-core.c
 delete mode 100644 drivers/media/platform/vimc/vimc-debayer.c
 delete mode 100644 drivers/media/platform/vimc/vimc-scaler.c
 delete mode 100644 drivers/media/platform/vimc/vimc-sensor.c
 delete mode 100644 drivers/media/platform/vimc/vimc-streamer.h
 delete mode 100644 drivers/media/platform/vivid/Kconfig
 create mode 100644 drivers/media/test-drivers/Kconfig
 create mode 100644 drivers/media/test-drivers/Makefile
 create mode 100644 drivers/media/test-drivers/vicodec/Kconfig
 rename drivers/media/{platform =3D> test-drivers}/vicodec/Makefile (100%)
 rename drivers/media/{platform =3D> test-drivers}/vicodec/codec-fwht.c (10=
0%)
 rename drivers/media/{platform =3D> test-drivers}/vicodec/codec-fwht.h (10=
0%)
 rename drivers/media/{platform =3D> test-drivers}/vicodec/codec-v4l2-fwht.=
c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vicodec/codec-v4l2-fwht.=
h (100%)
 create mode 100644 drivers/media/test-drivers/vicodec/vicodec-core.c
 create mode 100644 drivers/media/test-drivers/vim2m.c
 create mode 100644 drivers/media/test-drivers/vimc/Kconfig
 rename drivers/media/{platform =3D> test-drivers}/vimc/Makefile (100%)
 create mode 100644 drivers/media/test-drivers/vimc/vimc-capture.c
 create mode 100644 drivers/media/test-drivers/vimc/vimc-common.c
 create mode 100644 drivers/media/test-drivers/vimc/vimc-common.h
 create mode 100644 drivers/media/test-drivers/vimc/vimc-core.c
 create mode 100644 drivers/media/test-drivers/vimc/vimc-debayer.c
 create mode 100644 drivers/media/test-drivers/vimc/vimc-scaler.c
 create mode 100644 drivers/media/test-drivers/vimc/vimc-sensor.c
 rename drivers/media/{platform =3D> test-drivers}/vimc/vimc-streamer.c (10=
0%)
 create mode 100644 drivers/media/test-drivers/vimc/vimc-streamer.h
 create mode 100644 drivers/media/test-drivers/vivid/Kconfig
 rename drivers/media/{platform =3D> test-drivers}/vivid/Makefile (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-cec.c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-cec.h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-core.c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-core.h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-ctrls.c (100=
%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-ctrls.h (100=
%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-cap.=
c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-cap.=
h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-out.=
c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-out.=
h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-touc=
h.c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-kthread-touc=
h.h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-meta-cap.c (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-meta-cap.h (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-meta-out.c (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-meta-out.h (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-osd.c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-osd.h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-common=
.c (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-common=
.h (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-rx.c (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-rx.h (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-tx.c (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-radio-tx.h (=
100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-rds-gen.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-rds-gen.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-sdr-cap.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-sdr-cap.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-touch-cap.c =
(100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-touch-cap.h =
(100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-cap.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-cap.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-gen.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-gen.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-out.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vbi-out.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-cap.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-cap.h (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-common.c=
 (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-common.h=
 (100%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-out.c (1=
00%)
 rename drivers/media/{platform =3D> test-drivers}/vivid/vivid-vid-out.h (1=
00%)
 delete mode 100644 drivers/media/usb/pulse8-cec/Kconfig
 delete mode 100644 drivers/media/usb/rainshadow-cec/Kconfig
 create mode 100644 drivers/media/v4l2-core/v4l2-h264.c
 create mode 100644 drivers/media/v4l2-core/v4l2-jpeg.c
 create mode 100644 drivers/staging/media/atomisp/Kconfig
 create mode 100644 drivers/staging/media/atomisp/Makefile
 create mode 100644 drivers/staging/media/atomisp/TODO
 create mode 100644 drivers/staging/media/atomisp/i2c/Kconfig
 create mode 100644 drivers/staging/media/atomisp/i2c/Makefile
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-gc0310.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-gc2235.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-libmsrlisthel=
per.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-lm3554.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-mt9m114.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-ov2680.c
 create mode 100644 drivers/staging/media/atomisp/i2c/atomisp-ov2722.c
 create mode 100644 drivers/staging/media/atomisp/i2c/gc0310.h
 create mode 100644 drivers/staging/media/atomisp/i2c/gc2235.h
 create mode 100644 drivers/staging/media/atomisp/i2c/mt9m114.h
 create mode 100644 drivers/staging/media/atomisp/i2c/ov2680.h
 create mode 100644 drivers/staging/media/atomisp/i2c/ov2722.h
 create mode 100644 drivers/staging/media/atomisp/i2c/ov5693/Kconfig
 create mode 100644 drivers/staging/media/atomisp/i2c/ov5693/Makefile
 create mode 100644 drivers/staging/media/atomisp/i2c/ov5693/ad5823.h
 create mode 100644 drivers/staging/media/atomisp/i2c/ov5693/atomisp-ov5693=
.c
 create mode 100644 drivers/staging/media/atomisp/i2c/ov5693/ov5693.h
 create mode 100644 drivers/staging/media/atomisp/include/hmm/hmm.h
 create mode 100644 drivers/staging/media/atomisp/include/hmm/hmm_bo.h
 create mode 100644 drivers/staging/media/atomisp/include/hmm/hmm_common.h
 create mode 100644 drivers/staging/media/atomisp/include/hmm/hmm_pool.h
 create mode 100644 drivers/staging/media/atomisp/include/hmm/hmm_vm.h
 create mode 100644 drivers/staging/media/atomisp/include/linux/atomisp.h
 create mode 100644 drivers/staging/media/atomisp/include/linux/atomisp_gmi=
n_platform.h
 create mode 100644 drivers/staging/media/atomisp/include/linux/atomisp_pla=
tform.h
 create mode 100644 drivers/staging/media/atomisp/include/linux/libmsrlisth=
elper.h
 create mode 100644 drivers/staging/media/atomisp/include/media/lm3554.h
 create mode 100644 drivers/staging/media/atomisp/include/mmu/isp_mmu.h
 create mode 100644 drivers/staging/media/atomisp/include/mmu/sh_mmu_mrfld.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp-regs.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_acc.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_acc.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_cmd.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_cmd.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_common.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_compat.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_compat_css20.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_compat_css20.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_compat_ioctl3=
2.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_compat_ioctl3=
2.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_csi2.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_csi2.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_dfs_tables.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_drvfs.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_drvfs.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_file.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_file.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_fops.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_fops.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_gmin_platform=
.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_helper.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_internal.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_ioctl.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_ioctl.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_subdev.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_subdev.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_tables.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_tpg.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_tpg.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_trace_event.h
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_v4l2.c
 create mode 100644 drivers/staging/media/atomisp/pci/atomisp_v4l2.h
 create mode 100644 drivers/staging/media/atomisp/pci/base/circbuf/interfac=
e/ia_css_circbuf.h
 create mode 100644 drivers/staging/media/atomisp/pci/base/circbuf/interfac=
e/ia_css_circbuf_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/base/circbuf/interfac=
e/ia_css_circbuf_desc.h
 create mode 100644 drivers/staging/media/atomisp/pci/base/circbuf/src/circ=
buf.c
 create mode 100644 drivers/staging/media/atomisp/pci/base/refcount/interfa=
ce/ia_css_refcount.h
 create mode 100644 drivers/staging/media/atomisp/pci/base/refcount/src/ref=
count.c
 create mode 100644 drivers/staging/media/atomisp/pci/bits.h
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/interface=
/ia_css_pipe_binarydesc.h
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/interface=
/ia_css_pipe_stagedesc.h
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/interface=
/ia_css_pipe_util.h
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_=
binarydesc.c
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_=
stagedesc.c
 create mode 100644 drivers/staging/media/atomisp/pci/camera/pipe/src/pipe_=
util.c
 create mode 100644 drivers/staging/media/atomisp/pci/camera/util/interface=
/ia_css_util.h
 create mode 100644 drivers/staging/media/atomisp/pci/camera/util/src/util.c
 create mode 100644 drivers/staging/media/atomisp/pci/cell_params.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hive/=
ia_css_isp_configs.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hive/=
ia_css_isp_params.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hive/=
ia_css_isp_states.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hrt/h=
ive_isp_css_irq_types_hrt.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2400_system/hrt/i=
sp2400_mamoiada_params.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/csi_r=
x_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hive/=
ia_css_isp_configs.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hive/=
ia_css_isp_params.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hive/=
ia_css_isp_states.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
csi_rx.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
csi_rx_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
csi_rx_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
ibuf_ctrl.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
ibuf_ctrl_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
ibuf_ctrl_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_dma.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_dma_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_dma_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_irq.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_irq_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_irq_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_stream2mmio.c
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_stream2mmio_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
isys_stream2mmio_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
pixelgen_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/host/=
pixelgen_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/P=
ixelGen_SysBlock_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/i=
buf_cntrl_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/m=
ipi_backend_common_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/m=
ipi_backend_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/r=
x_csi_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/hrt/s=
tream2mmio_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/ibuf_=
ctrl_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/isys_=
dma_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/isys_=
irq_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/isys_=
stream2mmio_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_2401_system/pixel=
gen_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_receiver_2400_com=
mon_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_receiver_2400_def=
s.h
 create mode 100644 drivers/staging/media/atomisp/pci/css_trace.h
 create mode 100644 drivers/staging/media/atomisp/pci/defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/dma_v2_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/gdc_v2_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/gp_timer_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/gpio_block_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_2401_irq=
_types_hrt.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/d=
ebug_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/d=
ma_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/e=
vent_fifo_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/f=
ifo_monitor_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/g=
dc_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/g=
p_device_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/g=
p_timer_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/g=
pio_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
mem_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/debug.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/debug_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/debug_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/dma.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/dma_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/dma_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/event_fifo.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/event_fifo_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/event_fifo_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/fifo_monitor.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/fifo_monitor_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/fifo_monitor_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gdc.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gdc_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gdc_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_device.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_device_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_device_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_timer.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_timer_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gp_timer_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gpio_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/gpio_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/hmem.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/hmem_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/hmem_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/input_formatter.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/input_formatter_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/input_formatter_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/input_system.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/irq.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/irq_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/irq_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/isp.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/isp_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/isp_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/mmu.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/mmu_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/sp.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/sp_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/sp_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/timed_ctrl.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/timed_ctrl_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/timed_ctrl_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/vamem_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/vmem.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/vmem_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/h=
ost/vmem_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/i=
nput_formatter_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/i=
rq_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/i=
sp_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/m=
mu_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/s=
p_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/t=
imed_ctrl_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/v=
amem_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_common/v=
mem_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
assert_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
bitop_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
csi_rx.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
debug.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
device_access/device_access.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
dma.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
error_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
event_fifo.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
fifo_monitor.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
gdc_device.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
gp_device.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
gp_timer.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
gpio.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
hmem.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/csi_rx_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/debug_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/dma_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/event_fifo_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/fifo_monitor_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/gdc_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/gp_device_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/gp_timer_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/gpio_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/hmem_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/ibuf_ctrl_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/input_formatter_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/irq_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isp_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isys_dma_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isys_irq_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isys_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/isys_stream2mmio_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/mmu_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/pixelgen_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/sp_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/tag_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/timed_ctrl_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/vamem_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
host/vmem_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
ibuf_ctrl.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
input_formatter.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
input_system.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
irq.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
isp.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
isys_dma.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
isys_irq.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
isys_stream2mmio.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
math_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
memory_access/memory_access.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
memory_realloc.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
misc_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
mmu_device.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
pixelgen.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
platform_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
print_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
queue.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
resource.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
sp.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
string_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
system_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
tag.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
timed_ctrl.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
type_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
vamem.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_include/=
vmem.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/h=
ost/queue_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/h=
ost/queue_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/h=
ost/tag.c
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/h=
ost/tag_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/h=
ost/tag_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/q=
ueue_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/s=
w_event_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_shared/t=
ag_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_isp_css_streamin=
g_to_mipi_types_hrt.h
 create mode 100644 drivers/staging/media/atomisp/pci/hive_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm.c
 create mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
 create mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c
 create mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool=
.c
 create mode 100644 drivers/staging/media/atomisp/pci/hmm/hmm_vm.c
 create mode 100644 drivers/staging/media/atomisp/pci/hrt/hive_isp_css_cust=
om_host_hrt.h
 create mode 100644 drivers/staging/media/atomisp/pci/hrt/hive_isp_css_mm_h=
rt.c
 create mode 100644 drivers/staging/media/atomisp/pci/hrt/hive_isp_css_mm_h=
rt.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_3a.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_acc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_buffer.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_control.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_device_access.c
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_device_access.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_dvs.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_env.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_err.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_event_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_firmware.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_frac.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_frame_format.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_frame_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_host_data.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_input_port.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_irq.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_isp_configs.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_isp_params.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_isp_states.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_memory_access.c
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_metadata.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_mipi.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_mmu.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_mmu_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_morph.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_pipe.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_pipe_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_prbs.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_properties.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_shading.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_stream.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_stream_format.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_stream_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_timer.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_tpg.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_version.h
 create mode 100644 drivers/staging/media/atomisp/pci/ia_css_version_data.h
 create mode 100644 drivers/staging/media/atomisp/pci/if_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_formatter_subsy=
stem_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_selector_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_switch_2400_def=
s.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_ctrl_def=
s.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_private.h
 create mode 100644 drivers/staging/media/atomisp/pci/input_system_public.h
 create mode 100644 drivers/staging/media/atomisp/pci/irq_controller_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/aa/aa_2/i=
a_css_aa2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/aa/aa_2/i=
a_css_aa2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/aa/aa_2/i=
a_css_aa2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/aa/aa_2/i=
a_css_aa2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1=
.0/ia_css_anr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1=
.0/ia_css_anr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1=
.0/ia_css_anr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1=
.0/ia_css_anr_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_2=
/ia_css_anr2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/i=
a_css_bh.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/i=
a_css_bh.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/i=
a_css_bh_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bh/bh_2/i=
a_css_bh_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnlm/ia_c=
ss_bnlm.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnlm/ia_c=
ss_bnlm.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnlm/ia_c=
ss_bnlm_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnlm/ia_c=
ss_bnlm_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr2_=
2/ia_css_bnr2_2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr2_=
2/ia_css_bnr2_2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr2_=
2/ia_css_bnr2_2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr2_=
2/ia_css_bnr2_2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1=
.0/ia_css_bnr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1=
.0/ia_css_bnr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/bnr/bnr_1=
.0/ia_css_bnr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_1=
.0/ia_css_cnr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_1=
.0/ia_css_cnr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_1=
.0/ia_css_cnr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_2=
/ia_css_cnr2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_2=
/ia_css_cnr2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_2=
/ia_css_cnr2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/cnr/cnr_2=
/ia_css_cnr2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/conversio=
n/conversion_1.0/ia_css_conversion.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/conversio=
n/conversion_1.0/ia_css_conversion.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/conversio=
n/conversion_1.0/ia_css_conversion_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/conversio=
n/conversion_1.0/ia_css_conversion_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/copy_outp=
ut/copy_output_1.0/ia_css_copy_output.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/copy_outp=
ut/copy_output_1.0/ia_css_copy_output.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/copy_outp=
ut/copy_output_1.0/ia_css_copy_output_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/crop/crop=
_1.0/ia_css_crop.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/crop/crop=
_1.0/ia_css_crop.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/crop/crop=
_1.0/ia_css_crop_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/crop/crop=
_1.0/ia_css_crop_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/csc/csc_1=
.0/ia_css_csc.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/csc/csc_1=
.0/ia_css_csc.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/csc/csc_1=
.0/ia_css_csc_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/csc/csc_1=
.0/ia_css_csc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc1_=
5/ia_css_ctc1_5.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc1_=
5/ia_css_ctc1_5.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc1_=
5/ia_css_ctc1_5_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc2/=
ia_css_ctc2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc2/=
ia_css_ctc2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc2/=
ia_css_ctc2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc2/=
ia_css_ctc2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ctc/ctc_1=
.0/ia_css_ctc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0=
/ia_css_de.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0=
/ia_css_de.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0=
/ia_css_de_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_1.0=
/ia_css_de_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_2/i=
a_css_de2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_2/i=
a_css_de2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_2/i=
a_css_de2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/de/de_2/i=
a_css_de2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dp/dp_1.0=
/ia_css_dp.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dp/dp_1.0=
/ia_css_dp.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dp/dp_1.0=
/ia_css_dp_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dp/dp_1.0=
/ia_css_dp_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dpc2/ia_c=
ss_dpc2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dpc2/ia_c=
ss_dpc2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dpc2/ia_c=
ss_dpc2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dpc2/ia_c=
ss_dpc2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dvs/dvs_1=
.0/ia_css_dvs.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dvs/dvs_1=
.0/ia_css_dvs.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dvs/dvs_1=
.0/ia_css_dvs_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/dvs/dvs_1=
.0/ia_css_dvs_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia=
_css_eed1_8.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia=
_css_eed1_8.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia=
_css_eed1_8_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/eed1_8/ia=
_css_eed1_8_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fc/fc_1.0=
/ia_css_formats.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fc/fc_1.0=
/ia_css_formats.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fc/fc_1.0=
/ia_css_formats_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fc/fc_1.0=
/ia_css_formats_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/=
fixedbds_1.0/ia_css_fixedbds_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fixedbds/=
fixedbds_1.0/ia_css_fixedbds_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1=
.0/ia_css_fpn.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1=
.0/ia_css_fpn.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1=
.0/ia_css_fpn_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/fpn/fpn_1=
.0/ia_css_fpn_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_1.0=
/ia_css_gc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/gc/gc_2/i=
a_css_gc2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_cs=
s_hdr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_cs=
s_hdr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_cs=
s_hdr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/hdr/ia_cs=
s_hdr_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/bayer_io_ls/ia_css_bayer_io.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/bayer_io_ls/ia_css_bayer_io.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/bayer_io_ls/ia_css_bayer_io_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/bayer_io_ls/ia_css_bayer_io_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/common/ia_css_common_io_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/common/ia_css_common_io_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/yuv444_io_ls/ia_css_yuv444_io.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/yuv444_io_ls/ia_css_yuv444_io.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/yuv444_io_ls/ia_css_yuv444_io_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ipu2_io_l=
s/yuv444_io_ls/ia_css_yuv444_io_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/iterator/=
iterator_1.0/ia_css_iterator.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/iterator/=
iterator_1.0/ia_css_iterator.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/iterator/=
iterator_1.0/ia_css_iterator_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
1_5/ia_css_macc1_5_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/macc/macc=
_1.0/ia_css_macc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/norm/norm=
_1.0/ia_css_norm.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/norm/norm=
_1.0/ia_css_norm.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/norm/norm=
_1.0/ia_css_norm_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob2/ia=
_css_ob2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob2/ia=
_css_ob2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob2/ia=
_css_ob2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob2/ia=
_css_ob2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob_1.0=
/ia_css_ob.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob_1.0=
/ia_css_ob.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob_1.0=
/ia_css_ob_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ob/ob_1.0=
/ia_css_ob_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/output/ou=
tput_1.0/ia_css_output.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/output/ou=
tput_1.0/ia_css_output.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/output/ou=
tput_1.0/ia_css_output_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/output/ou=
tput_1.0/ia_css_output_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/qplane/qp=
lane_2/ia_css_qplane.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/qplane/qp=
lane_2/ia_css_qplane.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/qplane/qp=
lane_2/ia_css_qplane_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/qplane/qp=
lane_2/ia_css_qplane_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw/raw_1=
.0/ia_css_raw.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw/raw_1=
.0/ia_css_raw.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw/raw_1=
.0/ia_css_raw_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw/raw_1=
.0/ia_css_raw_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_bi=
nning/raw_aa_binning_1.0/ia_css_raa.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/raw_aa_bi=
nning/raw_aa_binning_1.0/ia_css_raa.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ref/ref_1=
.0/ia_css_ref.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ref/ref_1=
.0/ia_css_ref.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ref/ref_1=
.0/ia_css_ref_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ref/ref_1=
.0/ia_css_ref_state.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ref/ref_1=
.0/ia_css_ref_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1=
.0/ia_css_s3a.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1=
.0/ia_css_s3a.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1=
.0/ia_css_s3a_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/s3a/s3a_1=
.0/ia_css_s3a_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sc/sc_1.0=
/ia_css_sc.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sc/sc_1.0=
/ia_css_sc.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sc/sc_1.0=
/ia_css_sc_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sc/sc_1.0=
/ia_css_sc_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/comm=
on/ia_css_sdis_common.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/comm=
on/ia_css_sdis_common_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_1.0/ia_css_sdis.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_1.0/ia_css_sdis.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_1.0/ia_css_sdis_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_2/ia_css_sdis2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_2/ia_css_sdis2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/sdis/sdis=
_2/ia_css_sdis2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tdf/tdf_1=
.0/ia_css_tdf.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tdf/tdf_1=
.0/ia_css_tdf.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tdf/tdf_1=
.0/ia_css_tdf_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tdf/tdf_1=
.0/ia_css_tdf_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr3/=
ia_css_tnr3_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr_1=
.0/ia_css_tnr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr_1=
.0/ia_css_tnr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr_1=
.0/ia_css_tnr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr_1=
.0/ia_css_tnr_state.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/tnr/tnr_1=
.0/ia_css_tnr_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/uds/uds_1=
.0/ia_css_uds_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0=
/ia_css_vf.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0=
/ia_css_vf.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0=
/ia_css_vf_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/vf/vf_1.0=
/ia_css_vf_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/wb/wb_1.0=
/ia_css_wb.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/wb/wb_1.0=
/ia_css_wb.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/wb/wb_1.0=
/ia_css_wb_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/wb/wb_1.0=
/ia_css_wb_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr_table.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr_table.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_1=
.0/ia_css_xnr_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3=
.0/ia_css_xnr3.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3=
.0/ia_css_xnr3.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3=
.0/ia_css_xnr3_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/xnr/xnr_3=
.0/ia_css_xnr3_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1=
.0/ia_css_ynr.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1=
.0/ia_css_ynr.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1=
.0/ia_css_ynr_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1=
.0/ia_css_ynr_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_2=
/ia_css_ynr2.host.c
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_2=
/ia_css_ynr2.host.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_2=
/ia_css_ynr2_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_2=
/ia_css_ynr2_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/modes/interface/i=
nput_buf.isp.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/modes/interface/i=
sp_const.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp/modes/interface/i=
sp_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_input_system_=
global.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_input_system_=
local.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_input_system_=
private.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_input_system_=
public.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_support.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_system_global=
.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2400_system_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_input_system_=
global.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_input_system_=
local.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_input_system_=
private.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_mamoiada_para=
ms.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_system_global=
.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp2401_system_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp_acquisition_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/isp_capture_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/memory_realloc.c
 create mode 100644 drivers/staging/media/atomisp/pci/mmu/isp_mmu.c
 create mode 100644 drivers/staging/media/atomisp/pci/mmu/sh_mmu_mrfld.c
 create mode 100644 drivers/staging/media/atomisp/pci/mmu_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/binary/interf=
ace/ia_css_binary.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/binary/src/bi=
nary.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/bufq/interfac=
e/ia_css_bufq.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/bufq/interfac=
e/ia_css_bufq_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/bufq/src/bufq=
.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/debug/interfa=
ce/ia_css_debug.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/debug/interfa=
ce/ia_css_debug_internal.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/debug/interfa=
ce/ia_css_debug_pipe.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/debug/src/ia_=
css_debug.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/event/interfa=
ce/ia_css_event.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/event/src/eve=
nt.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/eventq/interf=
ace/ia_css_eventq.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/eventq/src/ev=
entq.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/frame/interfa=
ce/ia_css_frame.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/frame/interfa=
ce/ia_css_frame_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/frame/src/fra=
me.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/ifmtr/interfa=
ce/ia_css_ifmtr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/ifmtr/src/ifm=
tr.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/inputfifo/int=
erface/ia_css_inputfifo.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/inputfifo/src=
/inputfifo.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isp_param/int=
erface/ia_css_isp_param.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isp_param/int=
erface/ia_css_isp_param_types.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isp_param/src=
/isp_param.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/interfac=
e/ia_css_isys.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/interfac=
e/ia_css_isys_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/csi_=
rx_rmgr.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/csi_=
rx_rmgr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/ibuf=
_ctrl_rmgr.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/ibuf=
_ctrl_rmgr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/isys=
_dma_rmgr.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/isys=
_dma_rmgr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/isys=
_init.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/isys=
_stream2mmio_rmgr.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/isys=
_stream2mmio_rmgr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/rx.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/virt=
ual_isys.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/isys/src/virt=
ual_isys.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/pipeline/inte=
rface/ia_css_pipeline.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/pipeline/inte=
rface/ia_css_pipeline_common.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/pipeline/src/=
pipeline.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/queue/interfa=
ce/ia_css_queue.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/queue/interfa=
ce/ia_css_queue_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/queue/src/que=
ue.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/queue/src/que=
ue_access.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/queue/src/que=
ue_access.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/rmgr/interfac=
e/ia_css_rmgr.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/rmgr/interfac=
e/ia_css_rmgr_vbuf.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr=
.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/rmgr/src/rmgr=
_vbuf.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/spctrl/interf=
ace/ia_css_spctrl.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/spctrl/interf=
ace/ia_css_spctrl_comm.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/spctrl/src/sp=
ctrl.c
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/tagger/interf=
ace/ia_css_tagger_common.h
 create mode 100644 drivers/staging/media/atomisp/pci/runtime/timer/src/tim=
er.c
 create mode 100644 drivers/staging/media/atomisp/pci/scalar_processor_2400=
_params.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_dvs_info.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_firmware.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_firmware.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_frac.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_host_data.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_hrt.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_hrt.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_internal.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_legacy.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_metadata.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_metrics.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_metrics.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_mipi.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_mipi.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_mmu.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_morph.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_param_dvs.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_param_dvs.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_param_shading.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_param_shading.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_params.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_params.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_params_interna=
l.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_pipe.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_properties.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_shading.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_sp.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_sp.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_stream.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_stream_format.c
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_stream_format.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_struct.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_uds.h
 create mode 100644 drivers/staging/media/atomisp/pci/sh_css_version.c
 create mode 100644 drivers/staging/media/atomisp/pci/str2mem_defs.h
 create mode 100644 drivers/staging/media/atomisp/pci/streaming_to_mipi_def=
s.h
 create mode 100644 drivers/staging/media/atomisp/pci/system_global.h
 create mode 100644 drivers/staging/media/atomisp/pci/system_local.h
 create mode 100644 drivers/staging/media/atomisp/pci/timed_controller_defs=
.h
 create mode 100644 drivers/staging/media/atomisp/pci/version.h
 delete mode 100644 drivers/staging/media/phy-rockchip-dphy-rx0/Documentati=
on/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
 create mode 100644 drivers/staging/media/rkvdec/Kconfig
 create mode 100644 drivers/staging/media/rkvdec/Makefile
 create mode 100644 drivers/staging/media/rkvdec/TODO
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-h264.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec-regs.h
 create mode 100644 drivers/staging/media/rkvdec/rkvdec.c
 create mode 100644 drivers/staging/media/rkvdec/rkvdec.h
 rename {Documentation/media/v4l-drivers =3D> drivers/staging/media/soc_cam=
era}/soc-camera.rst (100%)
 create mode 100644 include/media/v4l2-h264.h
 create mode 100644 include/media/v4l2-jpeg.h

