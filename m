Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C76C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF66F214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="L5yGDynU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgBKMtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:31 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:3934 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgBKMt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:49:28 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48H2fF1038z6x;
        Tue, 11 Feb 2020 13:49:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581425366; bh=Oi4cDhIGtxiZAoWxm80J+ow/YXQ40nADnyXOVF9DgGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5yGDynUPr8QO3TpQJfDopTDQLwT2QGZroz7/JT0aSpQNALg5077ZwQNVGlAAXrrA
         Sf2Y+3/FtLySC6GDuDq9oLFUOCQk8F38NQo9T79cbkMoJkr8QtLelhIQJCen5NXeX/
         3wIxmnN966lWo6iRyM+4TuC+E2r4YMKa64Rkzr/Nh4OuYATkrcgWn6IvU253EPEMav
         63Fz+PHs3ujBj+u6qZOJVdtTOfFJrEVBM2F5cGfxfdxmDn/IBsPdi4UIyS03IdXUCK
         sYVt3x99QVQKVN7NqkbG8KYdJQuZxibTbvzmgB5vyWIvxb+kD+t+qAlzx58s92riL4
         F9HiCbqFfngZA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 13:49:22 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     =?iso-8859-2?B?Suly9G1l?= Pouiller <Jerome.Pouiller@silabs.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] staging: wfx: fix init/remove vs IRQ race
Message-ID: <20200211124922.GA23464@qmqm.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
 <f0c66cbb3110c2736cd4357c753fba8c14ee3aee.1581416843.git.mirq-linux@rere.qmqm.pl>
 <4119656.HTyy427nan@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4119656.HTyy427nan@pc-42>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 11:19:18AM +0000, Jérôme Pouiller wrote:
> On Tuesday 11 February 2020 11:35:01 CET Micha³ Miros³aw wrote:
> > Current code races in init/exit with interrupt handlers. This is noticed
> > by the warning below. Fix it by using devres for ordering allocations and
> > IRQ de/registration.
> > 
> > WARNING: CPU: 0 PID: 827 at drivers/staging/wfx/bus_spi.c:142 wfx_spi_irq_handler+0x5c/0x64 [wfx]
> > race condition in driver init/deinit
[...]
> > --- a/drivers/staging/wfx/bus_spi.c
> > +++ b/drivers/staging/wfx/bus_spi.c
> > @@ -154,6 +154,11 @@ static void wfx_spi_request_rx(struct work_struct *work)
> >         wfx_bh_request_rx(bus->core);
> >  }
> > 
> > +static void wfx_flush_irq_work(void *w)
> > +{
> > +       flush_work(w);
> > +}
> > +
> >  static size_t wfx_spi_align_size(void *priv, size_t size)
> >  {
> >         // Most of SPI controllers avoid DMA if buffer size is not 32bit aligned
> > @@ -207,22 +212,23 @@ static int wfx_spi_probe(struct spi_device *func)
> >                 udelay(2000);
> >         }
> > 
> > -       ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
> > -                              IRQF_TRIGGER_RISING, "wfx", bus);
> > -       if (ret)
> > -               return ret;
> > -
> >         INIT_WORK(&bus->request_rx, wfx_spi_request_rx);
> >         bus->core = wfx_init_common(&func->dev, &wfx_spi_pdata,
> >                                     &wfx_spi_hwbus_ops, bus);
> >         if (!bus->core)
> >                 return -EIO;
> > 
> > -       ret = wfx_probe(bus->core);
> > +       ret = devm_add_action_or_reset(&func->dev, wfx_flush_irq_work,
> > +                                      &bus->request_rx);
> >         if (ret)
> > -               wfx_free_common(bus->core);
> > +               return ret;
> > 
> > -       return ret;
> > +       ret = devm_request_irq(&func->dev, func->irq, wfx_spi_irq_handler,
> > +                              IRQF_TRIGGER_RISING, "wfx", bus);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return wfx_probe(bus->core);
> >  }
> > 
> >  static int wfx_spi_remove(struct spi_device *func)
> > @@ -230,11 +236,6 @@ static int wfx_spi_remove(struct spi_device *func)
> >         struct wfx_spi_priv *bus = spi_get_drvdata(func);
> > 
> >         wfx_release(bus->core);
> > -       wfx_free_common(bus->core);
> > -       // A few IRQ will be sent during device release. Hopefully, no IRQ
> > -       // should happen after wdev/wvif are released.
> > -       devm_free_irq(&func->dev, func->irq, bus);
> > -       flush_work(&bus->request_rx);
> >         return 0;
> >  }
> > 
> > diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
> > index 84adad64fc30..76b2ff7fc7fe 100644
> > --- a/drivers/staging/wfx/main.c
> > +++ b/drivers/staging/wfx/main.c
> > @@ -262,6 +262,16 @@ static int wfx_send_pdata_pds(struct wfx_dev *wdev)
> >         return ret;
> >  }
> > 
> > +static void wfx_free_common(void *data)
> > +{
> > +       struct wfx_dev *wdev = data;
> > +
> > +       mutex_destroy(&wdev->rx_stats_lock);
> > +       mutex_destroy(&wdev->conf_mutex);
> > +       wfx_tx_queues_deinit(wdev);
> > +       ieee80211_free_hw(wdev->hw);
> > +}
> > +
> >  struct wfx_dev *wfx_init_common(struct device *dev,
> >                                 const struct wfx_platform_data *pdata,
> >                                 const struct hwbus_ops *hwbus_ops,
> > @@ -332,17 +342,12 @@ struct wfx_dev *wfx_init_common(struct device *dev,
> >         wfx_init_hif_cmd(&wdev->hif_cmd);
> >         wfx_tx_queues_init(wdev);
> > 
> > +       if (devm_add_action_or_reset(dev, wfx_free_common, wdev))
> > +               return NULL;
> > +
> >         return wdev;
> >  }
> > 
> > -void wfx_free_common(struct wfx_dev *wdev)
> > -{
> > -       mutex_destroy(&wdev->rx_stats_lock);
> > -       mutex_destroy(&wdev->conf_mutex);
> > -       wfx_tx_queues_deinit(wdev);
> > -       ieee80211_free_hw(wdev->hw);
> > -}
> > -
> >  int wfx_probe(struct wfx_dev *wdev)
> >  {
> >         int i;
> > diff --git a/drivers/staging/wfx/main.h b/drivers/staging/wfx/main.h
> > index 875f8c227803..9c9410072def 100644
> > --- a/drivers/staging/wfx/main.h
> > +++ b/drivers/staging/wfx/main.h
> > @@ -34,7 +34,6 @@ struct wfx_dev *wfx_init_common(struct device *dev,
> >                                 const struct wfx_platform_data *pdata,
> >                                 const struct hwbus_ops *hwbus_ops,
> >                                 void *hwbus_priv);
> > -void wfx_free_common(struct wfx_dev *wdev);
> > 
> >  int wfx_probe(struct wfx_dev *wdev);
> >  void wfx_release(struct wfx_dev *wdev);
> > --
> > 2.20.1
> > 
> 
> Are you sure you can completely drop wfx_free_common()? If you want to
> use devres, I think that wfx_flush_irq_work() should call
> wfx_free_common(), no?

wfx_free_common() will be called by devres in the right order. That's ensured
by devm_add_action_or_reset() at the end of wfx_init_common().

Best Regards,
Micha³ Miros³aw
