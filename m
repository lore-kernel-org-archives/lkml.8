Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAE7C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705542087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 11:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgATLQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:16:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34696 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgATLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:16:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aragua)
        with ESMTPSA id C63A22925AE
Message-ID: <ed7667b85c9aa9465f1b4bb97b672aa1099572ee.camel@collabora.com>
Subject: Re: [PATCH] mfd / platform: cros_ec: Query EC protocol version if
 EC transitions between RO/RW
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
To:     Yicheng Li <yichengli@google.com>
Cc:     Yicheng Li <yichengli@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, bleung@chromium.org,
        gwendal@chromium.org, enric.balletbo@collabora.com
Date:   Mon, 20 Jan 2020 12:16:06 +0100
In-Reply-To: <CAB8_tbG8NSQyLZBizhiKFcfOszOhfi1FFoRAi9SLcFFRTuJDzw@mail.gmail.com>
References: <20191118200000.35484-1-yichengli@chromium.org>
         <b5149024683189b78224f4c6639818e9d833e126.camel@collabora.com>
         <CAB8_tbG8NSQyLZBizhiKFcfOszOhfi1FFoRAi9SLcFFRTuJDzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yicheng,

Thanks for your quick answer.

I updated the firmware after my first email on friday.
Now the version is correct:

   # ectool version --name=cros_fp
   RO version:    nocturne_fp_v2.2.64-58cf5974e
   RW version:    nocturne_fp_v2.2.191-1d529566e
   Firmware copy: RW
   Build info:    nocturne_fp_v2.2.191-1d529566e 2019-11-01 20:30:58
   @chromeos-ci-legacy-us-central1-b-x32-72-dltd
   Tool version:  v2.0.3031-9e0f24fad 2020-01-13 06:11:02 @chromeos-ci-
   legacy-us-east1-d-x32-89-i09h

The result does not change. This is the console output after I sent the
reboot command.

   $ ectool name=cros_fp output
   ...
   [250664.176204 HC 0xa9]
   [250664.176287 HC 0xa9 err 1]
   [250664.177413 HC 0x67]
   [250664.177489 HC 0x67 err 9]
   [250664.178434 HC 0x02]
   [250664.180308 HC Suppressed: 0x97=127 0x98=138 0x115=0]
   [250664.477987 HC 0x01]
   [250892.898421 HC 0x02]
   [250892.900447 HC 0x07]
   [250892.901286 HC 0x0b]
   [250902.139053 HC 0x02]
   [250902.141059 HC 0x07]
   [250902.141847 HC 0x0b]
   [250902.142988 HC 0xd2]
   [250902.143072 Executing host reboot command 1]
   [250902.143176 HC 0xd2 err 4]
   [250908.838254 HC 0x02]
   [250908.840474 HC 0x07]
   [250908.841391 HC 0x0b]

it seems we have an error when executing the 0zd2 command.

Any idea what is error 4?

Thanks

Fabien

Le jeudi 16 janvier 2020 à 05:04 -0800, Yicheng Li a écrit :
> Hi Fabien,
> 
> First, you need the new firmware which has RW 2.2.191 instead of
> 2.2.110. It's available in release M80. The old firmware you were
> using does not have the RO/RW protocol incompatibility problem
> because RW 2.2.110 still only support versions 0 and 1 of
> EC_CMD_GET_NEXT_EVENT, same as RO 2.2.64. RW 2.2.191 has version 2 of
> EC_CMD_GET_NEXT_ EVENT, hence the issue described in the commit
> message.
> 
> With RW 2.2.191, if the kernal does not have this patch, rebooting
> cros_fp will leave you in an infinite loop in RO, as described in the
> commit message. This patch solves the problem and you should be in RW
> after the reboot. You can see more details on the commands sent to
> cros_fp during RO if you have cros_fp.log 
> 
> Let me know if you have other questions. Thanks!
> 
> Best,
> Yicheng
> 
> 
> On Thu, Jan 16, 2020, 4:27 AM Fabien Lahoudere <
> fabien.lahoudere@collabora.com> wrote:
> > Hi,
> > 
> > I tried to test that patch but I cannot switch to RO firmware.
> > I do the following steps:
> > 
> > root@debian:/sys/class/chromeos/cros_fp# cat version 
> > RO version:    nocturne_fp_v2.2.64-58cf5974e
> > RW version:    nocturne_fp_v2.2.110-b936c0a3c
> > Firmware copy: RW
> > Build info:    nocturne_fp_v2.2.110-b936c0a3c 2018-11-02 14:16:46
> > @swarm-cros-461
> > Chip vendor:   stm
> > Chip name:     stm32h7x3
> > Chip revision: 
> > Board version: EC error 1
> > root@debian:/sys/class/chromeos/cros_fp# echo ro > reboot
> > root@debian:/sys/class/chromeos/cros_fp# cat version 
> > RO version:    nocturne_fp_v2.2.64-58cf5974e
> > RW version:    nocturne_fp_v2.2.110-b936c0a3c
> > Firmware copy: RW
> > Build info:    nocturne_fp_v2.2.110-b936c0a3c 2018-11-02 14:16:46
> > @swarm-cros-461
> > Chip vendor:   stm
> > Chip name:     stm32h7x3
> > Chip revision: 
> > Board version: EC error 1
> > root@debian:/sys/class/chromeos/cros_fp#
> > 
> > We see here that cros_fp is still RW.
> > 
> > I also tried with:
> > 
> > debian@debian:/src/ec$ sudo build/bds/util/ectool --name=cros_fp
> > reboot_ec RO
> > debian@debian:/src/ec$ sudo build/bds/util/ectool --name=cros_fp
> > version     
> > RO version:    nocturne_fp_v2.2.64-58cf5974e
> > RW version:    nocturne_fp_v2.2.110-b936c0a3c
> > Firmware copy: RW
> > Build info:    nocturne_fp_v2.2.110-b936c0a3c 2018-11-02 14:16:46
> > @swarm-cros-461
> > Tool version:  v2.0.3074-a5052d4e7 2020-01-16 10:23:05 
> > debian@debian
> > debian@debian:/src/ec$
> > 
> > with the same result.
> > 
> > Can you decribe us steps you follow to test that patch?
> > 
> > Thanks
> > 
> > Fabien
> > 
> > Le lundi 18 novembre 2019 à 12:00 -0800, Yicheng Li a écrit :
> > > RO and RW of EC may have different EC protocol version. If EC
> > > transitions
> > > between RO and RW, but AP does not reboot (this is true for
> > > fingerprint
> > > microcontroller / cros_fp, but not true for main ec / cros_ec),
> > the
> > > AP
> > > still uses the protocol version queried before transition, which
> > can
> > > cause problems. In the case of fingerprint microcontroller, this
> > > causes
> > > AP to send the wrong version of EC_CMD_GET_NEXT_EVENT to RO in
> > the
> > > interrupt handler, which in turn prevents RO to clear the
> > interrupt
> > > line to AP, in an infinite loop.
> > > 
> > > Once an EC_HOST_EVENT_INTERFACE_READY is received, we know that
> > there
> > > might have been a transition between RO and RW, so re-query the
> > > protocol.
> > > 
> > > Signed-off-by: Yicheng Li <yichengli@chromium.org>
> > > 
> > > Change-Id: Ib58032ff4a8e113bdbd07212e8aff42807afff38
> > > Series-to: LKML <linux-kernel@vger.kernel.org>
> > > Series-cc: Benson Leung <bleung@chromium.org>, Enric Balletbo i
> > Serra
> > > <enric.balletbo@collabora.com>, Gwendal Grignou <
> > gwendal@chromium.org
> > > >
> > > ---
> > >  drivers/platform/chrome/cros_ec.c           | 24
> > > +++++++++++++++++++++
> > >  include/linux/platform_data/cros_ec_proto.h |  1 +
> > >  2 files changed, 25 insertions(+)
> > > 
> > > diff --git a/drivers/platform/chrome/cros_ec.c
> > > b/drivers/platform/chrome/cros_ec.c
> > > index 9b2d07422e17..0c910846d99d 100644
> > > --- a/drivers/platform/chrome/cros_ec.c
> > > +++ b/drivers/platform/chrome/cros_ec.c
> > > @@ -104,6 +104,23 @@ static int cros_ec_sleep_event(struct
> > > cros_ec_device *ec_dev, u8 sleep_event)
> > >       return ret;
> > >  }
> > >  
> > > +static int cros_ec_ready_event(struct notifier_block *nb,
> > > +     unsigned long queued_during_suspend, void *_notify)
> > > +{
> > > +     struct cros_ec_device *ec_dev = container_of(nb, struct
> > > cros_ec_device,
> > > +                                                 
> > notifier_ready);
> > > +     u32 host_event = cros_ec_get_host_event(ec_dev);
> > > +
> > > +     if (host_event &
> > > EC_HOST_EVENT_MASK(EC_HOST_EVENT_INTERFACE_READY)) {
> > > +             mutex_lock(&ec_dev->lock);
> > > +             cros_ec_query_all(ec_dev);
> > > +             mutex_unlock(&ec_dev->lock);
> > > +             return NOTIFY_OK;
> > > +     } else {
> > > +             return NOTIFY_DONE;
> > > +     }
> > > +}
> > > +
> > >  /**
> > >   * cros_ec_register() - Register a new ChromeOS EC, using the
> > > provided info.
> > >   * @ec_dev: Device to register.
> > > @@ -201,6 +218,13 @@ int cros_ec_register(struct cros_ec_device
> > > *ec_dev)
> > >               dev_dbg(ec_dev->dev, "Error %d clearing sleep event
> > to
> > > ec",
> > >                       err);
> > >  
> > > +     /* Register the notifier for EC_HOST_EVENT_INTERFACE_READY
> > > event. */
> > > +     ec_dev->notifier_ready.notifier_call = cros_ec_ready_event;
> > > +     err = blocking_notifier_chain_register(&ec_dev-
> > >event_notifier,
> > > +                                            &ec_dev-
> > > >notifier_ready);
> > > +     if (err < 0)
> > > +             dev_warn(ec_dev->dev, "Failed to register
> > notifier\n");
> > > +
> > >       dev_info(dev, "Chrome EC device registered\n");
> > >  
> > >       return 0;
> > > diff --git a/include/linux/platform_data/cros_ec_proto.h
> > > b/include/linux/platform_data/cros_ec_proto.h
> > > index 0d4e4aaed37a..9840408c0b01 100644
> > > --- a/include/linux/platform_data/cros_ec_proto.h
> > > +++ b/include/linux/platform_data/cros_ec_proto.h
> > > @@ -161,6 +161,7 @@ struct cros_ec_device {
> > >       int event_size;
> > >       u32 host_event_wake_mask;
> > >       u32 last_resume_result;
> > > +     struct notifier_block notifier_ready;
> > >  
> > >       /* The platform devices used by the mfd driver */
> > >       struct platform_device *ec;
> > 

