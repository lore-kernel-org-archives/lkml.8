Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C15FC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFB324125
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 21:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgATVCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:02:35 -0500
Received: from wp126.webpack.hosteurope.de ([80.237.132.133]:49366 "EHLO
        wp126.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgATVCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 16:02:34 -0500
Received: from [2003:a:659:3f00:1e6f:65ff:fe31:d1d5] (helo=hermes.fivetechno.de); authenticated
        by wp126.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1iteBq-0001ch-FN; Mon, 20 Jan 2020 22:02:30 +0100
X-Virus-Scanned: by amavisd-new 2.11.1 using newest ClamAV at
        linuxbbg.five-lan.de
Received: from dell2.five-lan.de (pD9E89C03.dip0.t-ipconnect.de [217.232.156.3])
        (authenticated bits=0)
        by hermes.fivetechno.de (8.15.2/8.14.5/SuSE Linux 0.8) with ESMTPSA id 00KL2SSg007612
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 20 Jan 2020 22:02:28 +0100
Subject: Re: [Bug ?] usb :typec :tcpm :fusb302
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org
References: <0ac6bbe7-6395-526d-213c-ac58a19d8673@fivetechno.de>
 <20200120115828.GC32175@kuha.fi.intel.com>
 <e05b6c1f-5e00-c000-23b9-1683230fd9f7@roeck-us.net>
 <546a5723-a974-ed0a-93e3-b46c919b0f7e@fivetechno.de>
 <2e739a08-191b-d7c9-1273-4000cbbca423@roeck-us.net>
 <d985890e-f1a4-a9b4-8f08-1860ea4486f7@fivetechno.de>
 <d3c847f7-2c8a-3cc0-00db-f46668fd83ca@roeck-us.net>
From:   Markus Reichl <m.reichl@fivetechno.de>
Message-ID: <9d4b25e4-0b88-bf3d-7265-e43026325e2d@fivetechno.de>
Date:   Mon, 20 Jan 2020 22:02:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <d3c847f7-2c8a-3cc0-00db-f46668fd83ca@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;m.reichl@fivetechno.de;1579554153;dda5b6af;
X-HE-SMSGID: 1iteBq-0001ch-FN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Am 20.01.20 um 21:26 schrieb Guenter Roeck:
> On 1/20/20 12:14 PM, Markus Reichl wrote:
>> Hi Guenter,
>>
>> Am 20.01.20 um 17:04 schrieb Guenter Roeck:
>>> On 1/20/20 6:34 AM, Markus Reichl wrote:
>>>> Hi Guenter,
>>>>
>>>> Am 20.01.20 um 15:21 schrieb Guenter Roeck:
>>>>> On 1/20/20 3:58 AM, Heikki Krogerus wrote:
>>>>>> Hi Markus,
>>>>>>
>>>>>> On Thu, Jan 09, 2020 at 05:29:07PM +0100, Markus Reichl wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm working with a ROC-RK3399-PC arm64 board from firefly, circuit sheet [1].
>>>>>>> The board is powered from an USB-C type connector via an FUSB302 PD controller.
>>>>>>> With measured 15W+ power consumption it should use higher voltage PD modes than
>>>>>>> the standard 5V USB-C mode.
>>>>>>>
>>>>>>> When I add the related connector node in DTS [2] the FUSB302 initializes
>>>>>>> the right PD mode (e.g. 15V/3A).
>>>>>>>
>>>>>>> But during initialisation the PD is switched off shortly and the board has a blackout.
>>>>>>> When I inject a backup supply voltage behind the FUSB302 (e.g. at SYS_12V line) during boot
>>>>>>> I can remove the backup after succesfull setting up the PD and the board will run fine.
>>>>>>>
>>>>>>> Is it possible to change the behaviour of the fusb302 driver to not power down the PD supply
>>>>>>> during init?
>>>>>>
>>>>>> I guess it's also possible that the problem is with tcpm.c instead of
>>>>>> fusb302.c. tcpm.c provides the USB PD state matchines. Guenter! Can
>>>>>> you take a look at this?
>>>>>>
>>>>>
>>>>> There was always a problem with handoff from the bootloader. tcpm_init() calls
>>>>> tcpm_reset_port() which turns vbus and vconn off, which I imagine can
>>>>> trigger the situation.
>>>>>
>>>>> Unfortunately I was never able to solve the puzzle. The Type-C protocol does
>>>>> not support any kind of "hand-off" from one component in the system to another.
>>>>> If the state machine doesn't start from a clean state, there is pretty
>>>>> much no guarantee that it ever synchronizes.
>>>>>
>>>>> Maybe someone can find a better solution, but when I wrote the code I just
>>>>> could not get it to work reliably without resetting everything during
>>>>> registration.
>>>>>
>>>>> Note that v4.4 did not include the upstream tcpm code, suggesting the
>>>>> code in the vendor kernel was possibly using a different or backported
>>>>> state machine. Impossible to say what was done there without access
>>>>> to the code.
>>>>
>>>> The vendor code for fusb302 is here:
>>>> https://github.com/FireflyTeam/kernel/tree/rk3399/firefly/drivers/mfd
>>>>
>>>
>>> AFAICS the vendor code don't reset VBUS, and selectively (only) resets the
>>> PD state machine in the fusb302 on startup. The tcpm state machine is embedded
>>> in the fusb302 driver, making this easier to control.
>>>
>>> The fusb302 Linux kernel driver, on the other side, resets the entire fusb302
>>> on initialization, not just PD (bit 0 of the reset register). Question is if
>>> that can be changed to just reset PD (bit 1 of the reset register).
>>> Maybe that would already fix the problem. Can you give it a try ?
>>>
>>> Guenter
>>
>> I tried
>>
>> diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
>> index ed8655c6af8c..6e15e7b22064 100644
>> --- a/drivers/usb/typec/tcpm/fusb302.c
>> +++ b/drivers/usb/typec/tcpm/fusb302.c
>> @@ -334,11 +334,11 @@ static int fusb302_sw_reset(struct fusb302_chip *chip)
>>          int ret = 0;
>>            ret = fusb302_i2c_write(chip, FUSB_REG_RESET,
>> -                               FUSB_REG_RESET_SW_RESET);
>> +                               FUSB_REG_RESET_PD_RESET);
>>          if (ret < 0)
>> -               fusb302_log(chip, "cannot sw reset the chip, ret=%d", ret);
>> +               fusb302_log(chip, "cannot pd reset the chip, ret=%d", ret);
>>          else
>> -               fusb302_log(chip, "sw reset");
>> +               fusb302_log(chip, "pd reset");
>>            return ret;
>>   }
>>
>> but did not help, after mmc and ehci initializing the PD-supply gets switched off at 1.95s.
> 
> Next step to try would be to skip vbus initialization - drop tcpm_init_vbus()
> from tcpm_reset_port(). Can you do that as well ?
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index f3087ef8265c..db2a75d67bc7 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2698,7 +2698,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
        port->rx_msgid = -1;
 
        port->tcpc->set_pd_rx(port->tcpc, false);
-       tcpm_init_vbus(port);   /* also disables charging */
+//     tcpm_init_vbus(port);   /* also disables charging */
        tcpm_init_vconn(port);
        tcpm_set_current_limit(port, 0, 0);
        tcpm_set_polarity(port, TYPEC_POLARITY_CC1);

Did not help, but instead of switching off, reboots now most of the time.
I watch with an USB-C-Power meter (V and A).
> 
> Thanks,
> Guenter
