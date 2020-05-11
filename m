Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D131C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9075206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgEKQFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730303AbgEKQFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:05:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8031AC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:05:06 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 1897E2A0A89;
        Mon, 11 May 2020 17:05:04 +0100 (BST)
Date:   Mon, 11 May 2020 18:05:00 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH v7 1/7] i3c: master: secondary master initialization
 document
Message-ID: <20200511180500.6e1c4453@collabora.com>
In-Reply-To: <1589202759-5677-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202759-5677-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:12:39 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> Document describing secondary master initialization,
> mastership handover and DEFSLVS handling processes.

Thanks for doing that, but you probably didn't try to compile the doc
(the formatting is all messed up).

# make htmldocs

and then check the output in Documentation/output/ (open index.html
with a web-browser and go to the i3c section).

> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  Documentation/driver-api/i3c/index.rst        |   1 +
>  .../i3c/secondary-master-initialization.rst   | 118 ++++++++++++++++++
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/driver-api/i3c/secondary-master-initialization.rst
> 
> diff --git a/Documentation/driver-api/i3c/index.rst b/Documentation/driver-api/i3c/index.rst
> index 783d6dad054b..af2a0aa68f5b 100644
> --- a/Documentation/driver-api/i3c/index.rst
> +++ b/Documentation/driver-api/i3c/index.rst
> @@ -9,3 +9,4 @@ I3C subsystem
>     protocol
>     device-driver-api
>     master-driver-api
> +   secondary-master-initialization
> diff --git a/Documentation/driver-api/i3c/secondary-master-initialization.rst b/Documentation/driver-api/i3c/secondary-master-initialization.rst
> new file mode 100644
> index 000000000000..9d1869550807
> --- /dev/null
> +++ b/Documentation/driver-api/i3c/secondary-master-initialization.rst
> @@ -0,0 +1,118 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================
> +I3C Secondary Master Initialization
> +===================================
> +
> ++-----------------------------------------+-------------------------------------------+
> +| **Main master**                         | **Secondary master**                      |
> ++=========================================+===========================================+
> +|                                         |                                           |
> +| | Do I3C master controller specific     | | Do I3C master controller specefic       |
> +|   initialization.                       |   initialization, except enabling         |
> +|                                         |   the DEFSLVS interrupt.                  |
> +| | Call i3c_master_register              | | Call i3c_secondary_master_register      |
> +|                                         |                                           |
> +|   *i3c_master_register*                 |   *i3c_secondary_master_register*         |
> +|    | Initialize I3C master controller   |    | Initialize I3C master controller     |
> +|      object.                            |      object.                              |
> +|    | Scan I3C and I2C devices from DTS. |    | Scan I2C devices from DTS.           |
> +|    | Set appropriate bus mode based on  |    | Set appropriate bus mode based on    |
> +|      I2C devices information.           |      I3C and I2C devices information.     |
> +|    | Create a work queue.               |    | Create a work queue.                 |
> +|    | Call i3c_master_bus_init           |    | Call i3c_secondary_master_bus_init   |
> +|                                         |                                           |
> +|      *i3c_master_bus_init*              |      *i3c_secondary_master_bus_init*      |
> +|       | Call bus_init to do controller  |       | Call bus_init to do controller    |
> +|         specific bus initialization and |         specific bus initialization and   |
> +|         enabling the controller.        |         enabling the controller.          |
> +|       | Create I3C device representing a|       | Create I3C device representing a  |
> +|         master and add it to the I3C    |         master and add it to the I3C      |
> +|         device list.                    |         device list.                      |
> +|       | Set current master to the device|                                           |
> +|         created to represent I3C master |    | Allocate memory for 'defslvs_data',  |
> +|         device.                         |      that will be used to pass I3C        |
> +|       | Reset all dynamic address that  |      device list received in DEFSLVS      |
> +|         may have been assigned before.  |      to I3C core DEFSLVS processing       |
> +|       | Disable all slave events before |    | Add I3C device representing this     |
> +|         starting DAA.                   |      master to the system.                |
> +|       | Pre-assign dynamic address and  |    | Expose our I3C bus as an I2C adapter |
> +|         retrieve device information if  |      so that I2C devices are exposed      |
> +|         needed.                         |      through the I2C subsystem.           |
> +|       | Do dynamic address assignment to|                                           |
> +|         all I3C devices currenly present| | Enable DEFSLVS interrupt.               |
> +|         on the bus.                     |                                           |
> +|       | Create I3C devices representing |                                           |
> +|         those found during DAA.         +-------------------------------------------+
> +|       | Send DEFSVLS message            | | *DEFSLVS interrupt*                     |
> +|         containing information about all| | Controller driver can chose how to      |
> +|         known I3C and I2C devices.      |   to handle I2C devices received in       |
> +|                                         |   DEFSLVS e.g. Cadence's controller       |
> +|                                         |   driver ignore I2C devices from          |
> +|                                         |   DEFSLVS and only uses I2C device        |
> +|                                         |   information from DTS.                   |
> +|                                         | | Read all I3C devices information        |
> +|                                         |   from DEFSLVS message in hardware to     |
> +|                                         |   defslvs_data in master object.          |
> +|                                         | | Call i3c_master_process_defslvs         |
> +|                                         |                                           |
> +|                                         |   *i3c_master_process_defslvs*            |
> +|                                         |    | Acquire I3c bus                      |
> +|                                         |                                           |
> +|                                         |      *i3c_master_acquire_bus*             |
> +|    | Add I3C device representing this   |       | If device is already holding the  |
> +|      master to the system.              |         mastership, just broadcast DISEC  |
> +|    | Expose our I3C bus as an I2C       |         MR, HJ message and return.        |
> +|      adapter so that I2C devices are    |       | Check if device has got a address |
> +|      exposed through the I2C subsystem. |         by polling with a timeout.        |
> +|    | Register all I3C devices.          |                                           |
> +|                                         |       | Send MR request: Controller driver|
> +|                                         |         should check if it is already in  |
> +|                                         |         master mode, to handle the case   |
> +|                                         |         of mastership yielded but due to  |
> +|                                         |         poll timeout acquire failed.      |
> +|                                         |       | If not a master, wait until MR    |
> +|                                         |         ENEC is received if currently it  |
> +|                                         |         is disabled.                      |
> +|    | Broadcast ENEC MR, HJ message.     |       | Send MR request.                  |
> ++-----------------------------------------+                                           |
> +| | *MR request interrupt*                |                                           |
> +|                                         |                                           |
> +|   *i3c_master_yield_bus*                |                                           |
> +|    | Check if this device is still a    |                                           |
> +|      master to handle a case of         |                                           |
> +|      multiple MR requests from different|                                           |
> +|      devices at a same time.            |                                           |
> +|    | Broadcast DISEC MR, HJ message.    |                                           |
> +|      New master should broadcast ENEC   |                                           |
> +|      MR, HJ once it's usage of bus is   |                                           |
> +|      done.                              |                                           |
> +|    | Get accept mastership acknowldege  |                                           |
> +|      from requesting master.            |                                           |
> +|    | Mastership hand over is done.      |       | Check if device enter master      |
> +|    | In case of failure reenable        |         mode by polling with a timeout.   |
> +|      MR requests by broadcasting ENEC   |                                           |
> +|      MR, HJ.                            |    Handle I3C device list from DEFSLVS.   |
> +|                                         |                                           |
> +|                                         |    *i3c_master_populate_bus*              |
> +|                                         |     | Free up all I3C addresses to handle |
> +|                                         |       address re assignment by main       |
> +|                                         |       master.                             |
> +|                                         |     | Move all devices from I3C list to a |
> +|                                         |       temporary list.                     |
> +|                                         |     | For every device from defslvs_data  |
> +|                                         |       list except the receiving master    |
> +|                                         |       device, retrieve pid and compare it |
> +|                                         |       with already known I3C devices from |
> +|                                         |       I3C list. If match is found,        |
> +|                                         |       allocate new address and move the   |
> +|                                         |       device to the original I3C device   |
> +|                                         |       list. If no match is found, it is a |
> +|                                         |       new device. Register and add it to  |
> +|                                         |       the original I3C list.              |
> +|                                         |     | At the end if temporary list is not |
> +|                                         |       empty, it contains unplugged I3C    |
> +|                                         |       device. Deregister and delete them. |
> +|                                         |                                           |
> +|                                         |     Broadcast ENEC MR, HJ message.        |
> ++-----------------------------------------+-------------------------------------------+
