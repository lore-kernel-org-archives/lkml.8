Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CE1C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E252078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403838AbgDCMFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:05:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:7779 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbgDCMFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:05:09 -0400
IronPort-SDR: ScZdvbp3A0cmkTS1PYIpEu6RThyYMFEZwdoshGBVU4e72so/SWPnbM2D+qm4g6W1szUhZXvWhE
 33FsMiDO5hUQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 05:05:08 -0700
IronPort-SDR: nHiLEFmqKLZ5NMlBu0nURO7qQ5E+aVDIZvllhZAhiXgAyynFkddNYFYvFHF3z94vYn7NQtxoOC
 LceyZiaPEhmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="scan'208";a="329147693"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2020 05:05:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKL4J-000IuQ-NM; Fri, 03 Apr 2020 20:05:03 +0800
Date:   Fri, 3 Apr 2020 20:04:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: drivers/usb/gadget/legacy/inode.c:1364:8: warning: Redundant
 initialization for 'value'. The initialized value is overwritten before it
 is read. [redundantInitialization]
Message-ID: <202004032011.nwluao6B%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bef7b2a7be28638770972ab2709adf11d601c11a
commit: df8df5e4bc37e39010cfdf5d50cf726fe08aae5b usb: get rid of 'choice' for legacy gadget drivers
date:   3 weeks ago

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/usb/gadget/legacy/inode.c:1364:8: warning: Redundant initialization for 'value'. The initialized value is overwritten before it is read. [redundantInitialization]
>>  value = -EOPNOTSUPP;
          ^
>> drivers/usb/gadget/legacy/inode.c:1331:15: note: value is initialized
>>  int    value = -EOPNOTSUPP;
                 ^
>> drivers/usb/gadget/legacy/inode.c:1364:8: note: value is overwritten
>>  value = -EOPNOTSUPP;
          ^
   drivers/usb/gadget/legacy/inode.c:1817:8: warning: Redundant initialization for 'value'. The initialized value is overwritten before it is read. [redundantInitialization]
>>  value = -EINVAL;
          ^
   drivers/usb/gadget/legacy/inode.c:1787:18: note: value is initialized
>>  ssize_t   value = len, length = len;
                    ^
   drivers/usb/gadget/legacy/inode.c:1817:8: note: value is overwritten
>>  value = -EINVAL;
          ^
--
>> drivers/usb/gadget/legacy/g_ffs.c:181:10: warning: Variable 'ret' is assigned a value that is never used. [unreadVariable]
    int ret = 0;
            ^
--
>> drivers/usb/gadget/legacy/mass_storage.c:104:38: warning: syntax error [syntaxError]
>> FSG_MODULE_PARAMETERS(/* no prefix */, mod_data);
                                        ^
--
>> drivers/usb/gadget/legacy/hid.c:142:6: warning: Condition '!funcs' is always false [knownConditionTrueFalse]
>>  if (!funcs)
        ^
>> drivers/usb/gadget/legacy/hid.c:137:22: note: Assignment 'funcs=0', assigned value is 0
>>  int status, funcs = 0;
                        ^
>> drivers/usb/gadget/legacy/hid.c:140:3: note: funcs is incremented', new value is 1
>>   funcs++;
     ^
>> drivers/usb/gadget/legacy/hid.c:142:6: note: Condition '!funcs' is always false
>>  if (!funcs)
        ^
--
>> drivers/usb/gadget/legacy/dbgp.c:364:7: warning: Variable 'err' is assigned a value that is never used. [unreadVariable]
     err = 0;
         ^
--
>> drivers/usb/gadget/legacy/multi.c:121:38: warning: syntax error [syntaxError]
>> FSG_MODULE_PARAMETERS(/* no prefix */, fsg_mod_data);
                                        ^
--
>> drivers/usb/gadget/legacy/nokia.c:55:38: warning: syntax error [syntaxError]
>> FSG_MODULE_PARAMETERS(/* no prefix */, fsg_mod_data);
                                        ^
--
>> drivers/usb/gadget/legacy/acm_ms.c:94:38: warning: syntax error [syntaxError]
>> FSG_MODULE_PARAMETERS(/* no prefix */, fsg_mod_data);
                                        ^

vim +/value +1364 drivers/usb/gadget/legacy/inode.c

^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1325  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1326  static int
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1327  gadgetfs_setup (struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1328  {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1329  	struct dev_data			*dev = get_gadget_data (gadget);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1330  	struct usb_request		*req = dev->req;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16 @1331  	int				value = -EOPNOTSUPP;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1332  	struct usb_gadgetfs_event	*event;
1bbc169621cbe5 drivers/usb/gadget/inode.c David Brownell            2005-05-07  1333  	u16				w_value = le16_to_cpu(ctrl->wValue);
1bbc169621cbe5 drivers/usb/gadget/inode.c David Brownell            2005-05-07  1334  	u16				w_length = le16_to_cpu(ctrl->wLength);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1335  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1336  	spin_lock (&dev->lock);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1337  	dev->setup_abort = 0;
7489d149431817 drivers/usb/gadget/inode.c David Brownell            2007-01-16  1338  	if (dev->state == STATE_DEV_UNCONNECTED) {
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1339  		if (gadget_is_dualspeed(gadget)
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1340  				&& gadget->speed == USB_SPEED_HIGH
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1341  				&& dev->hs_config == NULL) {
ce46794f77f698 drivers/usb/gadget/inode.c David Brownell            2007-01-16  1342  			spin_unlock(&dev->lock);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1343  			ERROR (dev, "no high speed config??\n");
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1344  			return -EINVAL;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1345  		}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1346  
ce46794f77f698 drivers/usb/gadget/inode.c David Brownell            2007-01-16  1347  		dev->state = STATE_DEV_CONNECTED;
ce46794f77f698 drivers/usb/gadget/inode.c David Brownell            2007-01-16  1348  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1349  		INFO (dev, "connected\n");
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1350  		event = next_event (dev, GADGETFS_CONNECT);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1351  		event->u.speed = gadget->speed;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1352  		ep0_readable (dev);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1353  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1354  	/* host may have given up waiting for response.  we can miss control
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1355  	 * requests handled lower down (device/endpoint status and features);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1356  	 * then ep0_{read,write} will report the wrong status. controller
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1357  	 * driver will have aborted pending i/o.
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1358  	 */
7489d149431817 drivers/usb/gadget/inode.c David Brownell            2007-01-16  1359  	} else if (dev->state == STATE_DEV_SETUP)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1360  		dev->setup_abort = 1;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1361  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1362  	req->buf = dev->rbuf;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1363  	req->context = NULL;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16 @1364  	value = -EOPNOTSUPP;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1365  	switch (ctrl->bRequest) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1366  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1367  	case USB_REQ_GET_DESCRIPTOR:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1368  		if (ctrl->bRequestType != USB_DIR_IN)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1369  			goto unrecognized;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1370  		switch (w_value >> 8) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1371  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1372  		case USB_DT_DEVICE:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1373  			value = min (w_length, (u16) sizeof *dev->dev);
765f5b830e5472 drivers/usb/gadget/inode.c Sebastian Andrzej Siewior 2011-06-23  1374  			dev->dev->bMaxPacketSize0 = dev->gadget->ep0->maxpacket;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1375  			req->buf = dev->dev;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1376  			break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1377  		case USB_DT_DEVICE_QUALIFIER:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1378  			if (!dev->hs_config)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1379  				break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1380  			value = min (w_length, (u16)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1381  				sizeof (struct usb_qualifier_descriptor));
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1382  			make_qualifier (dev);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1383  			break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1384  		case USB_DT_OTHER_SPEED_CONFIG:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1385  			// FALLTHROUGH
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1386  		case USB_DT_CONFIG:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1387  			value = config_buf (dev,
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1388  					w_value >> 8,
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1389  					w_value & 0xff);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1390  			if (value >= 0)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1391  				value = min (w_length, (u16) value);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1392  			break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1393  		case USB_DT_STRING:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1394  			goto unrecognized;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1395  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1396  		default:		// all others are errors
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1397  			break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1398  		}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1399  		break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1400  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1401  	/* currently one config, two speeds */
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1402  	case USB_REQ_SET_CONFIGURATION:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1403  		if (ctrl->bRequestType != 0)
12cd5b984f825c drivers/usb/gadget/inode.c Roy Hashimoto             2008-03-12  1404  			goto unrecognized;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1405  		if (0 == (u8) w_value) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1406  			value = 0;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1407  			dev->current_config = 0;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1408  			usb_gadget_vbus_draw(gadget, 8 /* mA */ );
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1409  			// user mode expected to disable endpoints
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1410  		} else {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1411  			u8	config, power;
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1412  
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1413  			if (gadget_is_dualspeed(gadget)
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1414  					&& gadget->speed == USB_SPEED_HIGH) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1415  				config = dev->hs_config->bConfigurationValue;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1416  				power = dev->hs_config->bMaxPower;
a4e3ef5597e26d drivers/usb/gadget/inode.c David Brownell            2007-08-01  1417  			} else {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1418  				config = dev->config->bConfigurationValue;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1419  				power = dev->config->bMaxPower;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1420  			}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1421  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1422  			if (config == (u8) w_value) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1423  				value = 0;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1424  				dev->current_config = config;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1425  				usb_gadget_vbus_draw(gadget, 2 * power);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1426  			}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1427  		}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1428  
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1429  		/* report SET_CONFIGURATION like any other control request,
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1430  		 * except that usermode may not stall this.  the next
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1431  		 * request mustn't be allowed start until this finishes:
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1432  		 * endpoints and threads set up, etc.
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1433  		 *
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1434  		 * NOTE:  older PXA hardware (before PXA 255: without UDCCFR)
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1435  		 * has bad/racey automagic that prevents synchronizing here.
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1436  		 * even kernel mode drivers often miss them.
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1437  		 */
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1438  		if (value == 0) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1439  			INFO (dev, "configuration #%d\n", dev->current_config);
6027f3173e797b drivers/usb/gadget/inode.c Peter Chen                2014-04-29  1440  			usb_gadget_set_state(gadget, USB_STATE_CONFIGURED);
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1441  			if (dev->usermode_setup) {
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1442  				dev->setup_can_stall = 0;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1443  				goto delegate;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1444  			}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1445  		}
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1446  		break;
^1da177e4c3f41 drivers/usb/gadget/inode.c Linus Torvalds            2005-04-16  1447  

:::::: The code at line 1364 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
