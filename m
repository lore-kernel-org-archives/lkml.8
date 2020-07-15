Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E7AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FB0320657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 20:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGOUXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 16:23:05 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:33922 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgGOUXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:23:02 -0400
Received: from [78.43.71.214] (helo=marius.localnet)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jvnvf-00049v-Fg; Wed, 15 Jul 2020 22:22:59 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-cpro: Change to HID driver
Date:   Wed, 15 Jul 2020 22:22:58 +0200
Message-ID: <3539133.zoi8ogbS3G@marius>
In-Reply-To: <7a45a7ac-ef4d-b9c8-fac7-6c226baf1329@roeck-us.net>
References: <20200715151419.43134-1-mail@mariuszachmann.de> <3864498.z6qT3ff8q6@marius> <7a45a7ac-ef4d-b9c8-fac7-6c226baf1329@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.07.20 at 22:11:39 CEST, Guenter Roeck wrote
> On 7/15/20 12:55 PM, Marius Zachmann wrote:
> > On 15.07.20 at 21:49:59 CEST, Guenter Roeck wrote
> >> On 7/15/20 12:12 PM, Marius Zachmann wrote:
> >>> On 15.07.20 at 17:35:08 CEST, Guenter Roeck wrote
> >>>> On 7/15/20 8:14 AM, Marius Zachmann wrote:
> >>>>> This changes corsair-cpro to a hid driver using hid reports.
> >>>>>
> >>>>> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> >>>>>
> >>>>> ---
> >>>>
> >>> ...
> >>>>> -module_usb_driver(ccp_driver);
> >>>>> +static int __init ccp_init(void)
> >>>>> +{
> >>>>> +	return hid_register_driver(&ccp_driver);
> >>>>> +}
> >>>>> +
> >>>>> +static void __exit ccp_exit(void)
> >>>>> +{
> >>>>> +	hid_unregister_driver(&ccp_driver);
> >>>>> +}
> >>>>> +
> >>>>> +/* make sure it is loaded after hid */
> >>>>> +late_initcall(ccp_init);
> >>>>> +module_exit(ccp_exit);
> >>>>
> >>>> Sorry for not noticing before, but can you use module_hid_driver() ?
> >>>> That seems to work for other hid drivers.
> >>>>
> >>>> Thanks,
> >>>> Guenter
> >>>>
> >>>
> >>> When using module_hid_driver() and compiling the driver as built-in
> >>> the driver init function will get called before hid and fail registering
> >>> the driver. late_initcall forces it to be loaded after hid.
> >>>
> >>
> >> That seems odd. Why does no other hid driver have that problem ?
> >> Your argument is pretty much that module_hid_driver() would not work,
> >> which seems unlikely.
> >>
> >> Thanks,
> >> Guenter
> >>
> > 
> > The order of initcalls is determined by the build order. Hwmon subsystem
> > gets build before hid subsystem and therefore the initcalls are earlier
> > than hid. But hid_register_driver needs the hid driver to be there.
> > 
> Hmm. I am not happy, but I guess we'll have to live with it.
> 
> Can you add the detailed explanation to the comment above ?
> "make sure it is loaded after hid" doesn't tell the whole story,
> and I want to avoid having to deal with "cleanup" patches later.
> 
> Alternatively, I wonder if it would make sense to force
> this driver to be built as module. Have you thought about that ?
> 
> Thanks,
> Guenter
> 

I am also not happy about this and thought about this, but I
think late_initcall is the least ugly solution to this.
I will add a more detailed explanation.

Greetings
Marius



