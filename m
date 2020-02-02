Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9AEC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6379220658
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 16:47:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBBQrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 11:47:51 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58153 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726885AbgBBQrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 11:47:51 -0500
Received: (qmail 21778 invoked by uid 500); 2 Feb 2020 11:47:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 2 Feb 2020 11:47:50 -0500
Date:   Sun, 2 Feb 2020 11:47:49 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Sven Schnelle <svens@stackframe.org>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb-storage: Add support for Ratoc U2SCX multiple
 device mode
In-Reply-To: <20200202093750.4439-3-svens@stackframe.org>
Message-ID: <Pine.LNX.4.44L0.2002021139010.20768-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Feb 2020, Sven Schnelle wrote:

> The Ratoc U2SCX can support more than one device but uses another
> USB ID in that case (0584:0222) with a Vendor specific class. The
> used protocol is still USB Mass storage, but we need to fetch the
> maximum LUN number as otherwise the controller would address all
> devices on the SCSI bus when an invalid LUN is probed. It looks like
> U2SCX maps SCSI ID to LUN numbers, so we must not enable
> US_FL_SCM_MULT_TARG.
> 
> dmesg with the driver enabled looks like this:
> 
> [  133.157337] usb 1-2: new high-speed USB device number 6 using xhci_hcd
> [  133.170273] usb 1-2: New USB device found, idVendor=0584, idProduct=0222, bcdDevice= 1.11
> [  133.170279] usb 1-2: New USB device strings: Mfr=1, Product=3, SerialNumber=2
> [  133.170283] usb 1-2: Product: USB-SCSI Converter
> [  133.170286] usb 1-2: Manufacturer: RATOCSystems,Inc.
> [  133.170289] usb 1-2: SerialNumber: 020301002197
> [  133.171576] usb-storage 1-2:1.0: USB Mass Storage device detected
> [  133.172084] scsi host1: usb-storage 1-2:1.0
> [  134.199245] scsi 1:0:0:0: CD-ROM            HL-DT-ST DVDRAM GSA-4163B A100 PQ: 0 ANSI: 2
> [  134.202744] scsi 1:0:0:1: Direct-Access     SyQuest  SQ5200C          A0L  PQ: 0 ANSI: 2
> [  134.219300] scsi 1:0:0:2: Direct-Access     SyQuest  SQ3270S          1_24 PQ: 0 ANSI: 2
> [  134.224660] sr 1:0:0:0: Power-on or device reset occurred
> [  134.343256] sr 1:0:0:0: [sr0] scsi3-mmc drive: 40x/40x writer dvd-ram cd/rw xa/form2 cdda tray
> [  134.343262] cdrom: Uniform CD-ROM driver Revision: 3.20
> [  134.350873] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [  134.351120] sr 1:0:0:0: Attached scsi generic sg1 type 5
> [  134.351438] sd 1:0:0:1: Attached scsi generic sg2 type 0
> [  134.351685] sd 1:0:0:2: Attached scsi generic sg3 type 0
> [  134.362141] sd 1:0:0:1: Power-on or device reset occurred
> [  134.483977] sd 1:0:0:1: [sdb] Attached SCSI removable disk
> [  134.513922] sd 1:0:0:2: Power-on or device reset occurred
> [  134.579802] sd 1:0:0:2: [sdc] Spinning up disk...
> [  135.602397] ......
> [  141.707017] sd 1:0:0:1: [sdb] Spinning up disk...
> [  151.346332] .ready
> [  151.353990] sd 1:0:0:2: [sdc] 524288 512-byte logical blocks: (268 MB/256 MiB)
> [  151.361560] sd 1:0:0:2: [sdc] Write Protect is off
> [  151.361566] sd 1:0:0:2: [sdc] Mode Sense: 99 00 00 08
> [  151.368868] sd 1:0:0:2: [sdc] Write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> [  151.428485]  sdc: sdc1
> [  151.465364] sd 1:0:0:2: [sdc] Attached SCSI removable disk
> [  152.178231] .....ready
> [  156.535115] sd 1:0:0:1: [sdb] 173456 512-byte logical blocks: (88.8 MB/84.7 MiB)
> [  156.606445]  sdb: sdb1

Isn't this the same as we would see for any multi-LUN device?  What's 
so special about this log that you thought including it here was 
important?

> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  drivers/usb/storage/initializers.c | 27 +++++++++++++++++++++++++++
>  drivers/usb/storage/initializers.h |  2 ++
>  drivers/usb/storage/unusual_devs.h |  5 +++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/usb/storage/initializers.c b/drivers/usb/storage/initializers.c
> index f8f9ce8dc710..089d67e99aa9 100644
> --- a/drivers/usb/storage/initializers.c
> +++ b/drivers/usb/storage/initializers.c
> @@ -44,6 +44,33 @@ int usb_stor_euscsi_init(struct us_data *us)
>  	return 0;
>  }
>  
> +/* Function to get the maximum LUN (Logical Unit number) from Ratoc. */

People reading this code almost certainly already know what "LUN" 
stands for.  You don't have to remind them.

> +int usb_stor_ratoc_u2scx_init(struct us_data *us)
> +{
> +	int i, result;
> +	uint8_t *idmap = (uint8_t *)us->iobuf;
> +
> +	result = usb_stor_control_msg(us, us->recv_ctrl_pipe,
> +					0xe6, USB_DIR_IN | USB_TYPE_VENDOR |
> +					USB_RECIP_INTERFACE,
> +					0x0, 0x0, idmap, 8, 5 * HZ);
> +
> +	if (result < 0) {
> +		usb_stor_dbg(us, "fetching max lun failed: %d\n", result);
> +		return result;
> +	}

You don't want to check that the device actually returned 8 bytes of 
data?  What if it returned fewer?

> +
> +	for (i = 0; i < 7; i++) {
> +		if (idmap[i] == 0xff)

You didn't initialize the contents of idmap.  So if the device returned
fewer than 7 bytes, what makes you think the extra value will be 0xff?

> +			break;
> +	}
> +
> +	if (i == 0)
> +		return -EIO;
> +
> +	us->max_lun = i - 1;
> +	return 0;
> +}
>  /*
>   * This function is required to activate all four slots on the UCR-61S2B
>   * flash reader
> diff --git a/drivers/usb/storage/initializers.h b/drivers/usb/storage/initializers.h
> index 2dbf9c7d9749..b3ad7bfadf41 100644
> --- a/drivers/usb/storage/initializers.h
> +++ b/drivers/usb/storage/initializers.h
> @@ -37,3 +37,5 @@ int usb_stor_ucr61s2b_init(struct us_data *us);
>  
>  /* This places the HUAWEI E220 devices in multi-port mode */
>  int usb_stor_huawei_e220_init(struct us_data *us);
> +
> +int usb_stor_ratoc_u2scx_init(struct us_data *us);
> diff --git a/drivers/usb/storage/unusual_devs.h b/drivers/usb/storage/unusual_devs.h
> index 1cd9b6305b06..46b95944533c 100644
> --- a/drivers/usb/storage/unusual_devs.h
> +++ b/drivers/usb/storage/unusual_devs.h
> @@ -2372,6 +2372,11 @@ UNUSUAL_DEV( 0xed10, 0x7636, 0x0001, 0x0001,
>  		"Digital MP3 Audio Player",
>  		USB_SC_DEVICE, USB_PR_DEVICE, NULL, US_FL_NOT_LOCKABLE ),
>  
> +UNUSUAL_DEV(0x0584, 0x0222, 0x0000, 0xffff,
> +		"Ratoc",
> +		"U2SCX USB SCSI converter",
> +		USB_SC_DEVICE, USB_PR_DEVICE, usb_stor_ratoc_u2scx_init, 0),
> +

Please read the comments at the start of the file, in particular the 
part describing how the entries should e sorted.

Alan Stern

>  /* Unusual uas devices */
>  #if IS_ENABLED(CONFIG_USB_UAS)
>  #include "unusual_uas.h"
> 

