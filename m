Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFD520702
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 02:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgF3CbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 22:31:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:30063 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbgF3CbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 22:31:03 -0400
IronPort-SDR: lq2+BSoViPY2IsopxLAK3iVMoB7g1oYaxaHOrLZCH5XzyFv+JtrZMFV/9WdCCDrIStBkTfg1y+
 tdmr8mooO44g==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="230976396"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="230976396"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 19:20:53 -0700
IronPort-SDR: e09wveUfWzaK7vAUYPPf9J873/J8eJGRYiWrzgQfaJ3n32gBgGJv92dC/EAOxPxaKP6fQUMtkX
 V863h+GmRTIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="gz'50?scan'50,208,50";a="320800288"
Received: from lkp-server01.sh.intel.com (HELO 28879958b202) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2020 19:20:51 -0700
Received: from kbuild by 28879958b202 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jq5tC-0001IF-Ur; Tue, 30 Jun 2020 02:20:50 +0000
Date:   Tue, 30 Jun 2020 10:20:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous
 prototype for 'udc_send_in_zlp'
Message-ID: <202006301056.8ppxjF2q%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7c30b859a947535f2213277e827d7ac7dcff9c84
commit: 792e559e94bc88a281b10568e99fc469fc28a34d udc: lpc32xx: fix 64-bit compiler warning
date:   9 months ago
config: c6x-randconfig-r004-20200630 (attached as .config)
compiler: c6x-elf-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 792e559e94bc88a281b10568e99fc469fc28a34d
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=c6x 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ubuf' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'count' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ppos' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 's' not described in 'ci_qheads_show'
   drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 'data' not described in 'ci_qheads_show'
   drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 's' not described in 'ci_requests_show'
   drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 'data' not described in 'ci_requests_show'
   drivers/phy/phy-core.c:1045: warning: Function parameter or member 'children' not described in '__devm_of_phy_provider_register'
   drivers/phy/phy-core.c:1092: warning: Function parameter or member 'phy_provider' not described in 'devm_of_phy_provider_unregister'
   drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'
   /tmp/ccChThg0.s: Assembler messages:
   /tmp/ccChThg0.s:1341: Warning: ignoring changed section attributes for .far
   drivers/usb/phy/phy.c:98: warning: Function parameter or member 'work' not described in 'usb_phy_notify_charger_work'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'nb' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'state' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'data' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:183: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_set_charger_current'
   drivers/usb/phy/phy.c:183: warning: Function parameter or member 'mA' not described in 'usb_phy_set_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'min' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'max' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:270: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_set_charger_state'
   drivers/usb/phy/phy.c:270: warning: Function parameter or member 'state' not described in 'usb_phy_set_charger_state'
   drivers/usb/phy/phy.c:416: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy'
   drivers/usb/phy/phy.c:416: warning: Function parameter or member 'type' not described in 'devm_usb_get_phy'
   drivers/usb/phy/phy.c:445: warning: Function parameter or member 'type' not described in 'usb_get_phy'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'node' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'nb' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'phandle' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'index' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:579: warning: Function parameter or member 'dev' not described in 'devm_usb_put_phy'
   drivers/usb/phy/phy.c:579: warning: Function parameter or member 'phy' not described in 'devm_usb_put_phy'
   drivers/usb/phy/phy.c:616: warning: Function parameter or member 'type' not described in 'usb_add_phy'
   drivers/usb/phy/phy.c:710: warning: Function parameter or member 'event' not described in 'usb_phy_set_event'
   drivers/usb/misc/adutux.c:117: warning: Function parameter or member 'dev' not described in 'adu_abort_transfers'
   drivers/usb/misc/adutux.c:652: warning: Function parameter or member 'interface' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:652: warning: Function parameter or member 'id' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:761: warning: Function parameter or member 'interface' not described in 'adu_disconnect'
   drivers/usb/host/ehci-platform.c:347:36: warning: 'ehci_acpi_match' defined but not used [-Wunused-const-variable=]
     347 | static const struct acpi_device_id ehci_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/core.c:25: warning: Incorrect use of kernel-doc format:  * struct usb_udc - describes one usb device controller
   drivers/usb/gadget/udc/core.c:36: warning: cannot understand function prototype: 'struct usb_udc '
   drivers/usb/gadget/udc/core.c:890: warning: Function parameter or member 'ep' not described in 'usb_gadget_giveback_request'
   drivers/usb/gadget/udc/core.c:890: warning: Function parameter or member 'req' not described in 'usb_gadget_giveback_request'
   drivers/usb/gadget/udc/core.c:1087: warning: Function parameter or member 'udc' not described in 'usb_gadget_udc_stop'
   drivers/usb/gadget/udc/core.c:1087: warning: Excess function parameter 'gadget' description in 'usb_gadget_udc_stop'
   drivers/usb/gadget/udc/core.c:1087: warning: Excess function parameter 'driver' description in 'usb_gadget_udc_stop'
   drivers/usb/host/oxu210hp-hcd.c: In function 'submit_async':
   drivers/usb/host/oxu210hp-hcd.c:2040:19: warning: variable 'qtd' set but not used [-Wunused-but-set-variable]
    2040 |  struct ehci_qtd *qtd;
         |                   ^~~
   In file included from drivers/usb/misc/ftdi-elan.c:80:
   drivers/usb/misc/../host/ohci.h:165:18: warning: 'cc_to_error' defined but not used [-Wunused-const-variable=]
     165 | static const int cc_to_error [16] = {
         |                  ^~~~~~~~~~~
   /tmp/ccAnJN37.s: Assembler messages:
   /tmp/ccAnJN37.s:7476: Warning: ignoring changed section attributes for .far
   drivers/usb/chipidea/udc.c:80: warning: Function parameter or member 'ci' not described in 'hw_device_state'
   drivers/usb/chipidea/udc.c:100: warning: Function parameter or member 'ci' not described in 'hw_ep_flush'
   drivers/usb/chipidea/udc.c:121: warning: Function parameter or member 'ci' not described in 'hw_ep_disable'
   drivers/usb/chipidea/udc.c:136: warning: Function parameter or member 'ci' not described in 'hw_ep_enable'
   drivers/usb/chipidea/udc.c:170: warning: Function parameter or member 'ci' not described in 'hw_ep_get_halt'
   drivers/usb/chipidea/udc.c:185: warning: Function parameter or member 'ci' not described in 'hw_ep_prime'
   drivers/usb/chipidea/udc.c:215: warning: Function parameter or member 'ci' not described in 'hw_ep_set_halt'
   drivers/usb/chipidea/udc.c:238: warning: Function parameter or member 'ci' not described in 'hw_port_is_high_speed'
   drivers/usb/chipidea/udc.c:251: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_complete'
   drivers/usb/chipidea/udc.c:263: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_intr_active'
   drivers/usb/chipidea/udc.c:277: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_setup_guard'
   drivers/usb/chipidea/udc.c:288: warning: Function parameter or member 'ci' not described in 'hw_test_and_set_setup_guard'
   drivers/usb/chipidea/udc.c:300: warning: Function parameter or member 'ci' not described in 'hw_usb_set_address'
   drivers/usb/chipidea/udc.c:312: warning: Function parameter or member 'ci' not described in 'hw_usb_reset'
   drivers/usb/chipidea/udc.c:547: warning: Function parameter or member 'hwreq' not described in '_hardware_dequeue'
   drivers/usb/chipidea/udc.c:547: warning: Excess function parameter 'gadget' description in '_hardware_dequeue'
   drivers/usb/chipidea/udc.c:1228: warning: Function parameter or member 'ep' not described in 'ep_enable'
   drivers/usb/chipidea/udc.c:1228: warning: Function parameter or member 'desc' not described in 'ep_enable'
   drivers/usb/chipidea/udc.c:1295: warning: Function parameter or member 'ep' not described in 'ep_disable'
   drivers/usb/chipidea/udc.c:1335: warning: Function parameter or member 'ep' not described in 'ep_alloc_request'
   drivers/usb/chipidea/udc.c:1335: warning: Function parameter or member 'gfp_flags' not described in 'ep_alloc_request'
   drivers/usb/chipidea/udc.c:1356: warning: Function parameter or member 'ep' not described in 'ep_free_request'
   drivers/usb/chipidea/udc.c:1356: warning: Function parameter or member 'req' not described in 'ep_free_request'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'ep' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'req' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'gfp_flags' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1414: warning: Function parameter or member 'ep' not described in 'ep_dequeue'
   drivers/usb/chipidea/udc.c:1414: warning: Function parameter or member 'req' not described in 'ep_dequeue'
   drivers/usb/chipidea/udc.c:1458: warning: Function parameter or member 'ep' not described in 'ep_set_halt'
   drivers/usb/chipidea/udc.c:1458: warning: Function parameter or member 'value' not described in 'ep_set_halt'
   drivers/usb/chipidea/udc.c:1468: warning: Function parameter or member 'ep' not described in 'ep_set_wedge'
   drivers/usb/chipidea/udc.c:1488: warning: Function parameter or member 'ep' not described in 'ep_fifo_flush'
   drivers/usb/chipidea/udc.c:1512: warning: cannot understand function prototype: 'const struct usb_ep_ops usb_ep_ops = '
   drivers/usb/chipidea/udc.c:1665: warning: cannot understand function prototype: 'const struct usb_gadget_ops usb_gadget_ops = '
   drivers/usb/chipidea/udc.c:1824: warning: Function parameter or member 'gadget' not described in 'ci_udc_stop'
   drivers/usb/chipidea/udc.c:1858: warning: Function parameter or member 'ci' not described in 'udc_irq'
   drivers/usb/chipidea/udc.c:1990: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_destroy'
   drivers/usb/chipidea/udc.c:2039: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_init'
   drivers/usb/gadget/function/u_serial.c:535: warning: Function parameter or member 'port' not described in 'gs_start_io'
   drivers/usb/gadget/function/u_serial.c:535: warning: Excess function parameter 'dev' description in 'gs_start_io'
>> drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous prototype for 'udc_send_in_zlp' [-Wmissing-prototypes]
    1928 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
         |      ^~~~~~~~~~~~~~~
>> drivers/usb/gadget/udc/lpc32xx_udc.c:1942:6: warning: no previous prototype for 'udc_handle_eps' [-Wmissing-prototypes]
    1942 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
         |      ^~~~~~~~~~~~~~
   drivers/usb/gadget/udc/mv_udc_core.c:56:19: warning: 'driver_desc' defined but not used [-Wunused-const-variable=]
      56 | static const char driver_desc[] = DRIVER_DESC;
         |                   ^~~~~~~~~~~
   drivers/usb/misc/ldusb.c:191: warning: Function parameter or member 'dev' not described in 'ld_usb_abort_transfers'
   drivers/usb/misc/ldusb.c:207: warning: Function parameter or member 'dev' not described in 'ld_usb_delete'
   drivers/usb/misc/ldusb.c:223: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_in_callback'
   drivers/usb/misc/ldusb.c:284: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_out_callback'
   drivers/usb/misc/ldusb.c:304: warning: Function parameter or member 'inode' not described in 'ld_usb_open'
   drivers/usb/misc/ldusb.c:304: warning: Function parameter or member 'file' not described in 'ld_usb_open'
   drivers/usb/misc/ldusb.c:375: warning: Function parameter or member 'inode' not described in 'ld_usb_release'
   drivers/usb/misc/ldusb.c:375: warning: Function parameter or member 'file' not described in 'ld_usb_release'
   drivers/usb/misc/ldusb.c:420: warning: Function parameter or member 'file' not described in 'ld_usb_poll'
   drivers/usb/misc/ldusb.c:420: warning: Function parameter or member 'wait' not described in 'ld_usb_poll'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'file' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'buffer' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'count' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'ppos' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'file' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'buffer' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'count' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'ppos' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'intf' not described in 'ld_usb_probe'
   drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'id' not described in 'ld_usb_probe'
   drivers/usb/misc/ldusb.c:755: warning: Function parameter or member 'intf' not described in 'ld_usb_disconnect'
   drivers/usb/core/sysfs.c: In function 'usb_create_sysfs_intf_files':
   drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1266 |   ; /* We don't actually care if the function fails. */
         |   ^
   In file included from drivers/usb/host/isp1362-hcd.c:96:
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGALTTMR' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:199:1: note: in expansion of macro 'ISP1362_REG'
     199 | ISP1362_REG(OTGALTTMR, 0x6C, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGTIMER' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:198:1: note: in expansion of macro 'ISP1362_REG'
     198 | ISP1362_REG(OTGTIMER, 0x6A, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGINTENB' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:197:1: note: in expansion of macro 'ISP1362_REG'
     197 | ISP1362_REG(OTGINTENB, 0x69, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGINT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:196:1: note: in expansion of macro 'ISP1362_REG'
     196 | ISP1362_REG(OTGINT, 0x68, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGSTATUS' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:195:1: note: in expansion of macro 'ISP1362_REG'
     195 | ISP1362_REG(OTGSTATUS, 0x67, REG_WIDTH_16, REG_ACCESS_R);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGCONTROL' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:194:1: note: in expansion of macro 'ISP1362_REG'
     194 | ISP1362_REG(OTGCONTROL, 0x62, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCATLPORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:183:1: note: in expansion of macro 'ISP1362_REG'
     183 | ISP1362_REG(HCATLPORT, 0x44, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCINTLPORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:175:1: note: in expansion of macro 'ISP1362_REG'
     175 | ISP1362_REG(HCINTLPORT, 0x43, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCISTL1PORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:171:1: note: in expansion of macro 'ISP1362_REG'
     171 | ISP1362_REG(HCISTL1PORT, 0x42, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCISTL0PORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:170:1: note: in expansion of macro 'ISP1362_REG'
     170 | ISP1362_REG(HCISTL0PORT, 0x40, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCINTDIS' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:77:1: note: in expansion of macro 'ISP1362_REG'
      77 | ISP1362_REG(HCINTDIS, 0x05, REG_WIDTH_32, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/storage/alauda.c: In function 'alauda_check_media':
   drivers/usb/storage/alauda.c:456:6: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     456 |  int rc;
--
   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ubuf' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'count' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:75: warning: Function parameter or member 'ppos' not described in 'ci_port_test_write'
   drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 's' not described in 'ci_qheads_show'
   drivers/usb/chipidea/debug.c:122: warning: Function parameter or member 'data' not described in 'ci_qheads_show'
   drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 's' not described in 'ci_requests_show'
   drivers/usb/chipidea/debug.c:154: warning: Function parameter or member 'data' not described in 'ci_requests_show'
   drivers/phy/phy-core.c:1045: warning: Function parameter or member 'children' not described in '__devm_of_phy_provider_register'
   drivers/phy/phy-core.c:1092: warning: Function parameter or member 'phy_provider' not described in 'devm_of_phy_provider_unregister'
   drivers/usb/class/cdc-wdm.c:961: warning: Function parameter or member 'manage_power' not described in 'usb_cdc_wdm_register'
   /tmp/ccChThg0.s: Assembler messages:
   /tmp/ccChThg0.s:1341: Warning: ignoring changed section attributes for .far
   drivers/usb/phy/phy.c:98: warning: Function parameter or member 'work' not described in 'usb_phy_notify_charger_work'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'nb' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'state' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:161: warning: Function parameter or member 'data' not described in 'usb_phy_get_charger_type'
   drivers/usb/phy/phy.c:183: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_set_charger_current'
   drivers/usb/phy/phy.c:183: warning: Function parameter or member 'mA' not described in 'usb_phy_set_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'min' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:233: warning: Function parameter or member 'max' not described in 'usb_phy_get_charger_current'
   drivers/usb/phy/phy.c:270: warning: Function parameter or member 'usb_phy' not described in 'usb_phy_set_charger_state'
   drivers/usb/phy/phy.c:270: warning: Function parameter or member 'state' not described in 'usb_phy_set_charger_state'
   drivers/usb/phy/phy.c:416: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy'
   drivers/usb/phy/phy.c:416: warning: Function parameter or member 'type' not described in 'devm_usb_get_phy'
   drivers/usb/phy/phy.c:445: warning: Function parameter or member 'type' not described in 'usb_get_phy'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'node' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:489: warning: Function parameter or member 'nb' not described in 'devm_usb_get_phy_by_node'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'dev' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'phandle' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:547: warning: Function parameter or member 'index' not described in 'devm_usb_get_phy_by_phandle'
   drivers/usb/phy/phy.c:579: warning: Function parameter or member 'dev' not described in 'devm_usb_put_phy'
   drivers/usb/phy/phy.c:579: warning: Function parameter or member 'phy' not described in 'devm_usb_put_phy'
   drivers/usb/phy/phy.c:616: warning: Function parameter or member 'type' not described in 'usb_add_phy'
   drivers/usb/phy/phy.c:710: warning: Function parameter or member 'event' not described in 'usb_phy_set_event'
   drivers/usb/misc/adutux.c:117: warning: Function parameter or member 'dev' not described in 'adu_abort_transfers'
   drivers/usb/misc/adutux.c:652: warning: Function parameter or member 'interface' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:652: warning: Function parameter or member 'id' not described in 'adu_probe'
   drivers/usb/misc/adutux.c:761: warning: Function parameter or member 'interface' not described in 'adu_disconnect'
   drivers/usb/host/ehci-platform.c:347:36: warning: 'ehci_acpi_match' defined but not used [-Wunused-const-variable=]
     347 | static const struct acpi_device_id ehci_acpi_match[] = {
         |                                    ^~~~~~~~~~~~~~~
   drivers/usb/gadget/udc/core.c:25: warning: Incorrect use of kernel-doc format:  * struct usb_udc - describes one usb device controller
   drivers/usb/gadget/udc/core.c:36: warning: cannot understand function prototype: 'struct usb_udc '
   drivers/usb/gadget/udc/core.c:890: warning: Function parameter or member 'ep' not described in 'usb_gadget_giveback_request'
   drivers/usb/gadget/udc/core.c:890: warning: Function parameter or member 'req' not described in 'usb_gadget_giveback_request'
   drivers/usb/gadget/udc/core.c:1087: warning: Function parameter or member 'udc' not described in 'usb_gadget_udc_stop'
   drivers/usb/gadget/udc/core.c:1087: warning: Excess function parameter 'gadget' description in 'usb_gadget_udc_stop'
   drivers/usb/gadget/udc/core.c:1087: warning: Excess function parameter 'driver' description in 'usb_gadget_udc_stop'
   drivers/usb/host/oxu210hp-hcd.c: In function 'submit_async':
   drivers/usb/host/oxu210hp-hcd.c:2040:19: warning: variable 'qtd' set but not used [-Wunused-but-set-variable]
    2040 |  struct ehci_qtd *qtd;
         |                   ^~~
   In file included from drivers/usb/misc/ftdi-elan.c:80:
   drivers/usb/misc/../host/ohci.h:165:18: warning: 'cc_to_error' defined but not used [-Wunused-const-variable=]
     165 | static const int cc_to_error [16] = {
         |                  ^~~~~~~~~~~
   /tmp/ccAnJN37.s: Assembler messages:
   /tmp/ccAnJN37.s:7476: Warning: ignoring changed section attributes for .far
   drivers/usb/chipidea/udc.c:80: warning: Function parameter or member 'ci' not described in 'hw_device_state'
   drivers/usb/chipidea/udc.c:100: warning: Function parameter or member 'ci' not described in 'hw_ep_flush'
   drivers/usb/chipidea/udc.c:121: warning: Function parameter or member 'ci' not described in 'hw_ep_disable'
   drivers/usb/chipidea/udc.c:136: warning: Function parameter or member 'ci' not described in 'hw_ep_enable'
   drivers/usb/chipidea/udc.c:170: warning: Function parameter or member 'ci' not described in 'hw_ep_get_halt'
   drivers/usb/chipidea/udc.c:185: warning: Function parameter or member 'ci' not described in 'hw_ep_prime'
   drivers/usb/chipidea/udc.c:215: warning: Function parameter or member 'ci' not described in 'hw_ep_set_halt'
   drivers/usb/chipidea/udc.c:238: warning: Function parameter or member 'ci' not described in 'hw_port_is_high_speed'
   drivers/usb/chipidea/udc.c:251: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_complete'
   drivers/usb/chipidea/udc.c:263: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_intr_active'
   drivers/usb/chipidea/udc.c:277: warning: Function parameter or member 'ci' not described in 'hw_test_and_clear_setup_guard'
   drivers/usb/chipidea/udc.c:288: warning: Function parameter or member 'ci' not described in 'hw_test_and_set_setup_guard'
   drivers/usb/chipidea/udc.c:300: warning: Function parameter or member 'ci' not described in 'hw_usb_set_address'
   drivers/usb/chipidea/udc.c:312: warning: Function parameter or member 'ci' not described in 'hw_usb_reset'
   drivers/usb/chipidea/udc.c:547: warning: Function parameter or member 'hwreq' not described in '_hardware_dequeue'
   drivers/usb/chipidea/udc.c:547: warning: Excess function parameter 'gadget' description in '_hardware_dequeue'
   drivers/usb/chipidea/udc.c:1228: warning: Function parameter or member 'ep' not described in 'ep_enable'
   drivers/usb/chipidea/udc.c:1228: warning: Function parameter or member 'desc' not described in 'ep_enable'
   drivers/usb/chipidea/udc.c:1295: warning: Function parameter or member 'ep' not described in 'ep_disable'
   drivers/usb/chipidea/udc.c:1335: warning: Function parameter or member 'ep' not described in 'ep_alloc_request'
   drivers/usb/chipidea/udc.c:1335: warning: Function parameter or member 'gfp_flags' not described in 'ep_alloc_request'
   drivers/usb/chipidea/udc.c:1356: warning: Function parameter or member 'ep' not described in 'ep_free_request'
   drivers/usb/chipidea/udc.c:1356: warning: Function parameter or member 'req' not described in 'ep_free_request'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'ep' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'req' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1390: warning: Function parameter or member 'gfp_flags' not described in 'ep_queue'
   drivers/usb/chipidea/udc.c:1414: warning: Function parameter or member 'ep' not described in 'ep_dequeue'
   drivers/usb/chipidea/udc.c:1414: warning: Function parameter or member 'req' not described in 'ep_dequeue'
   drivers/usb/chipidea/udc.c:1458: warning: Function parameter or member 'ep' not described in 'ep_set_halt'
   drivers/usb/chipidea/udc.c:1458: warning: Function parameter or member 'value' not described in 'ep_set_halt'
   drivers/usb/chipidea/udc.c:1468: warning: Function parameter or member 'ep' not described in 'ep_set_wedge'
   drivers/usb/chipidea/udc.c:1488: warning: Function parameter or member 'ep' not described in 'ep_fifo_flush'
   drivers/usb/chipidea/udc.c:1512: warning: cannot understand function prototype: 'const struct usb_ep_ops usb_ep_ops = '
   drivers/usb/chipidea/udc.c:1665: warning: cannot understand function prototype: 'const struct usb_gadget_ops usb_gadget_ops = '
   drivers/usb/chipidea/udc.c:1824: warning: Function parameter or member 'gadget' not described in 'ci_udc_stop'
   drivers/usb/chipidea/udc.c:1858: warning: Function parameter or member 'ci' not described in 'udc_irq'
   drivers/usb/chipidea/udc.c:1990: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_destroy'
   drivers/usb/chipidea/udc.c:2039: warning: Function parameter or member 'ci' not described in 'ci_hdrc_gadget_init'
   drivers/usb/gadget/function/u_serial.c:535: warning: Function parameter or member 'port' not described in 'gs_start_io'
   drivers/usb/gadget/function/u_serial.c:535: warning: Excess function parameter 'dev' description in 'gs_start_io'
>> drivers/usb/gadget/udc/lpc32xx_udc.c:1928:6: warning: no previous prototype for 'udc_send_in_zlp' [-Wmissing-prototypes]
    1928 | void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
         |      ^~~~~~~~~~~~~~~
>> drivers/usb/gadget/udc/lpc32xx_udc.c:1942:6: warning: no previous prototype for 'udc_handle_eps' [-Wmissing-prototypes]
    1942 | void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
         |      ^~~~~~~~~~~~~~
   drivers/usb/gadget/udc/mv_udc_core.c:56:19: warning: 'driver_desc' defined but not used [-Wunused-const-variable=]
      56 | static const char driver_desc[] = DRIVER_DESC;
         |                   ^~~~~~~~~~~
   drivers/usb/misc/ldusb.c:191: warning: Function parameter or member 'dev' not described in 'ld_usb_abort_transfers'
   drivers/usb/misc/ldusb.c:207: warning: Function parameter or member 'dev' not described in 'ld_usb_delete'
   drivers/usb/misc/ldusb.c:223: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_in_callback'
   drivers/usb/misc/ldusb.c:284: warning: Function parameter or member 'urb' not described in 'ld_usb_interrupt_out_callback'
   drivers/usb/misc/ldusb.c:304: warning: Function parameter or member 'inode' not described in 'ld_usb_open'
   drivers/usb/misc/ldusb.c:304: warning: Function parameter or member 'file' not described in 'ld_usb_open'
   drivers/usb/misc/ldusb.c:375: warning: Function parameter or member 'inode' not described in 'ld_usb_release'
   drivers/usb/misc/ldusb.c:375: warning: Function parameter or member 'file' not described in 'ld_usb_release'
   drivers/usb/misc/ldusb.c:420: warning: Function parameter or member 'file' not described in 'ld_usb_poll'
   drivers/usb/misc/ldusb.c:420: warning: Function parameter or member 'wait' not described in 'ld_usb_poll'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'file' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'buffer' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'count' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:445: warning: Function parameter or member 'ppos' not described in 'ld_usb_read'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'file' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'buffer' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'count' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:527: warning: Function parameter or member 'ppos' not described in 'ld_usb_write'
   drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'intf' not described in 'ld_usb_probe'
   drivers/usb/misc/ldusb.c:651: warning: Function parameter or member 'id' not described in 'ld_usb_probe'
   drivers/usb/misc/ldusb.c:755: warning: Function parameter or member 'intf' not described in 'ld_usb_disconnect'
   drivers/usb/core/sysfs.c: In function 'usb_create_sysfs_intf_files':
   drivers/usb/core/sysfs.c:1266:3: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
    1266 |   ; /* We don't actually care if the function fails. */
         |   ^
   In file included from drivers/usb/host/isp1362-hcd.c:96:
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGALTTMR' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:199:1: note: in expansion of macro 'ISP1362_REG'
     199 | ISP1362_REG(OTGALTTMR, 0x6C, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGTIMER' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:198:1: note: in expansion of macro 'ISP1362_REG'
     198 | ISP1362_REG(OTGTIMER, 0x6A, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGINTENB' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:197:1: note: in expansion of macro 'ISP1362_REG'
     197 | ISP1362_REG(OTGINTENB, 0x69, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGINT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:196:1: note: in expansion of macro 'ISP1362_REG'
     196 | ISP1362_REG(OTGINT, 0x68, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGSTATUS' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:195:1: note: in expansion of macro 'ISP1362_REG'
     195 | ISP1362_REG(OTGSTATUS, 0x67, REG_WIDTH_16, REG_ACCESS_R);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_OTGCONTROL' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:194:1: note: in expansion of macro 'ISP1362_REG'
     194 | ISP1362_REG(OTGCONTROL, 0x62, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCATLPORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:183:1: note: in expansion of macro 'ISP1362_REG'
     183 | ISP1362_REG(HCATLPORT, 0x44, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCINTLPORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:175:1: note: in expansion of macro 'ISP1362_REG'
     175 | ISP1362_REG(HCINTLPORT, 0x43, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCISTL1PORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:171:1: note: in expansion of macro 'ISP1362_REG'
     171 | ISP1362_REG(HCISTL1PORT, 0x42, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCISTL0PORT' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:170:1: note: in expansion of macro 'ISP1362_REG'
     170 | ISP1362_REG(HCISTL0PORT, 0x40, REG_WIDTH_16, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/host/isp1362.h:59:22: warning: 'ISP1362_REG_HCINTDIS' defined but not used [-Wunused-const-variable=]
      59 | static isp1362_reg_t ISP1362_REG_##name = addr
         |                      ^~~~~~~~~~~~
   drivers/usb/host/isp1362.h:77:1: note: in expansion of macro 'ISP1362_REG'
      77 | ISP1362_REG(HCINTDIS, 0x05, REG_WIDTH_32, REG_ACCESS_RW);
         | ^~~~~~~~~~~
   drivers/usb/storage/alauda.c: In function 'alauda_check_media':
   drivers/usb/storage/alauda.c:456:6: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
     456 |  int rc;
..

vim +/udc_send_in_zlp +1928 drivers/usb/gadget/udc/lpc32xx_udc.c

24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1926  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1927  /* Send a ZLP on a non-0 IN EP */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29 @1928  void udc_send_in_zlp(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1929  {
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1930  	/* Clear EP status */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1931  	udc_clearep_getsts(udc, ep->hwep_num);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1932  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1933  	/* Send ZLP via FIFO mechanism */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1934  	udc_write_hwep(udc, ep->hwep_num, NULL, 0);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1935  }
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1936  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1937  /*
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1938   * Handle EP completion for ZLP
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1939   * This function will only be called when a delayed ZLP needs to be sent out
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1940   * after a DMA transfer has filled both buffers.
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1941   */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29 @1942  void udc_handle_eps(struct lpc32xx_udc *udc, struct lpc32xx_ep *ep)
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1943  {
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1944  	u32 epstatus;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1945  	struct lpc32xx_request *req;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1946  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1947  	if (ep->hwep_num <= 0)
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1948  		return;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1949  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1950  	uda_clear_hwepint(udc, ep->hwep_num);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1951  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1952  	/* If this interrupt isn't enabled, return now */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1953  	if (!(udc->enabled_hwepints & (1 << ep->hwep_num)))
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1954  		return;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1955  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1956  	/* Get endpoint status */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1957  	epstatus = udc_clearep_getsts(udc, ep->hwep_num);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1958  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1959  	/*
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1960  	 * This should never happen, but protect against writing to the
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1961  	 * buffer when full.
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1962  	 */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1963  	if (epstatus & EP_SEL_F)
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1964  		return;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1965  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1966  	if (ep->is_in) {
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1967  		udc_send_in_zlp(udc, ep);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1968  		uda_disable_hwepint(udc, ep->hwep_num);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1969  	} else
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1970  		return;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1971  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1972  	/* If there isn't a request waiting, something went wrong */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1973  	req = list_entry(ep->queue.next, struct lpc32xx_request, queue);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1974  	if (req) {
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1975  		done(ep, req, 0);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1976  
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1977  		/* Start another request if ready */
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1978  		if (!list_empty(&ep->queue)) {
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1979  			if (ep->is_in)
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1980  				udc_ep_in_req_dma(udc, ep);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1981  			else
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1982  				udc_ep_out_req_dma(udc, ep);
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1983  		} else
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1984  			ep->req_pending = 0;
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1985  	}
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1986  }
24a28e4283510d drivers/usb/gadget/lpc32xx_udc.c Roland Stigge 2012-04-29  1987  

:::::: The code at line 1928 was first introduced by commit
:::::: 24a28e4283510dcd58890379a42b8a7d3201d9d3 USB: gadget driver for LPC32xx

:::::: TO: Roland Stigge <stigge@antcom.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Q68bSM7Ycu6FN28Q--
