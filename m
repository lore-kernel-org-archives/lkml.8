Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BD3207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 15:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbgGVP1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 11:27:38 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35002 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730600AbgGVP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 11:27:37 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 6F6F22982CB
Subject: Re: [PATCH v2] platform/chrome: cros_ec_typec: USB4 support
To:     Prashant Malani <pmalani@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Rajmohan Mani <rajmohan.mani@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200710194017.1126000-1-pmalani@chromium.org>
 <CACeCKadwsH2yhqegZubgJnLy+p0CM3H1DzXiA-72Gagy2aYB-A@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <d09324a9-0a3e-3dd5-5521-dcd2d04a9d3f@collabora.com>
Date:   Wed, 22 Jul 2020 17:27:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACeCKadwsH2yhqegZubgJnLy+p0CM3H1DzXiA-72Gagy2aYB-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 21/7/20 21:55, Prashant Malani wrote:
> Hey Enric, Benson,
> 
> Just wondering if you've had a chance to review this patch.
> 

It's on my radar but I'm waiting for the dependencies to be merged.


> Best regards,
> 
> -Prashant
> 
> On Fri, Jul 10, 2020 at 12:40 PM Prashant Malani <pmalani@chromium.org> wrote:
>>
>> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>>
>> With USB4 mode the mux driver needs the Enter_USB Data
>> Object (EUDO) that was used when the USB mode was entered.
>> Though the object is not available in the driver, it is
>> possible to construct it from the information we have.
>>
>> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> Signed-off-by: Prashant Malani <pmalani@chromium.org>

For my own reference:

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

>> ---
>>
>> This patch depends on latest usb-next from Greg KH, this commit in
>> particular:
>> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/commit/?h=usb-next&id=ad8db94d6813dc659bd4de0531a8a1150559eafb
>>
>> Changes in v2:
>> - Removed EUDO bits for cable current and tunneling support.
>>
>>  drivers/platform/chrome/cros_ec_typec.c | 33 ++++++++++++++++++++++++-
>>  1 file changed, 32 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>> index 0c041b79cbba..a9700275a851 100644
>> --- a/drivers/platform/chrome/cros_ec_typec.c
>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/platform_data/cros_ec_proto.h>
>>  #include <linux/platform_data/cros_usbpd_notify.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/usb/pd.h>
>>  #include <linux/usb/typec.h>
>>  #include <linux/usb/typec_altmode.h>
>>  #include <linux/usb/typec_dp.h>
>> @@ -494,6 +495,34 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>>         return typec_mux_set(port->mux, &port->state);
>>  }
>>
>> +static int cros_typec_enable_usb4(struct cros_typec_data *typec,
>> +                                 int port_num,
>> +                                 struct ec_response_usb_pd_control_v2 *pd_ctrl)
>> +{
>> +       struct cros_typec_port *port = typec->ports[port_num];
>> +       struct enter_usb_data data;
>> +
>> +       data.eudo = EUDO_USB_MODE_USB4 << EUDO_USB_MODE_SHIFT;
>> +
>> +       /* Cable Speed */
>> +       data.eudo |= pd_ctrl->cable_speed << EUDO_CABLE_SPEED_SHIFT;
>> +
>> +       /* Cable Type */
>> +       if (pd_ctrl->control_flags & USB_PD_CTRL_OPTICAL_CABLE)
>> +               data.eudo |= EUDO_CABLE_TYPE_OPTICAL << EUDO_CABLE_TYPE_SHIFT;
>> +       else if (pd_ctrl->control_flags & USB_PD_CTRL_ACTIVE_CABLE)
>> +               data.eudo |= EUDO_CABLE_TYPE_RE_TIMER << EUDO_CABLE_TYPE_SHIFT;
>> +
>> +       data.active_link_training = !!(pd_ctrl->control_flags &
>> +                                      USB_PD_CTRL_ACTIVE_LINK_UNIDIR);
>> +
>> +       port->state.alt = NULL;
>> +       port->state.data = &data;
>> +       port->state.mode = TYPEC_MODE_USB4;
>> +
>> +       return typec_mux_set(port->mux, &port->state);
>> +}
>> +
>>  static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>>                                 uint8_t mux_flags,
>>                                 struct ec_response_usb_pd_control_v2 *pd_ctrl)
>> @@ -514,7 +543,9 @@ static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
>>         if (ret)
>>                 return ret;
>>
>> -       if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
>> +       if (mux_flags & USB_PD_MUX_USB4_ENABLED) {
>> +               ret = cros_typec_enable_usb4(typec, port_num, pd_ctrl);
>> +       } else if (mux_flags & USB_PD_MUX_TBT_COMPAT_ENABLED) {
>>                 ret = cros_typec_enable_tbt(typec, port_num, pd_ctrl);
>>         } else if (mux_flags & USB_PD_MUX_DP_ENABLED) {
>>                 ret = cros_typec_enable_dp(typec, port_num, pd_ctrl);
>> --
>> 2.27.0.383.g050319c2ae-goog
>>
