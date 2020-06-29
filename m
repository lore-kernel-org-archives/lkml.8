Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCAC620663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgF2S5p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:45 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:47515 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgF2S5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:40 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 806F1CECCA;
        Mon, 29 Jun 2020 08:29:16 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] Bluetooth: btusb: WBS support USB alternate setting 1
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200629060338.10705-1-hildawu@realtek.com>
Date:   Mon, 29 Jun 2020 08:19:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn, kidman@realtek.com
Content-Transfer-Encoding: 8BIT
Message-Id: <FBDECDBA-A76F-4276-91E0-685DC828EF87@holtmann.org>
References: <20200629060338.10705-1-hildawu@realtek.com>
To:     hildawu@realtek.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hilda,

> For WBS support, btusb driver could be set to alternate setting 1.

please be more descriptive since this is special for Realtek devices.

> 
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
> drivers/bluetooth/btusb.c | 16 +++++++++++-----
> 1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index c7cc8e594166..7942f9314fd7 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -453,6 +453,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
> #define BTUSB_HW_RESET_ACTIVE	12
> #define BTUSB_TX_WAIT_VND_EVT	13
> #define BTUSB_WAKEUP_DISABLE	14
> +#define BTUSB_WBS_ALT1		15

Use BTUSB_USE_ALT1_FOR_WBS as a more descriptive name.

> 
> struct btusb_data {
> 	struct hci_dev       *hdev;
> @@ -1666,14 +1667,18 @@ static void btusb_work(struct work_struct *work)
> 				new_alts = data->sco_num;
> 			}
> 		} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
> -
> -			data->usb_alt6_packet_flow = true;
> -
> 			/* Check if Alt 6 is supported for Transparent audio */
> -			if (btusb_find_altsetting(data, 6))
> +			if (btusb_find_altsetting(data, 6)) {
> +				data->usb_alt6_packet_flow = true;
> 				new_alts = 6;
> -			else
> +			} else if (test_bit(BTUSB_WBS_ALT1, &data->flags)) {
> +				if (btusb_find_altsetting(data, 1))
> +					new_alts = 1;
> +				else
> +					bt_dev_err(hdev, "Device does not support ALT setting 1");

Scrap this check and error and move it into the probe() function if you actually have Realtek hardware that does not support alternate setting 1.

> +			} else {
> 				bt_dev_err(hdev, "Device does not support ALT setting 6");
> +			}
> 		}
> 
> 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
> @@ -3965,6 +3970,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		 * (DEVICE_REMOTE_WAKEUP)
> 		 */
> 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
> +		set_bit(BTUSB_WBS_ALT1, &data->flags);
> 
> 		err = usb_autopm_get_interface(intf);
> 		if (err < 0)

Regards

Marcel

