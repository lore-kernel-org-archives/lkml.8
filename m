Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F6EC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015B420719
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HMg62hyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIJGpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgIJGpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:45:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A38C061796;
        Wed,  9 Sep 2020 23:45:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so5425535wrn.0;
        Wed, 09 Sep 2020 23:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SR9069WCtkEVhWLPOJ7tgY3RDB+5yi0JYbZLTKxBZmU=;
        b=HMg62hyWC/0CN6dORP0rPlD1v5pV9FM/TBprXFIC22AFmA4u0q8Py0miBSA44F0BAK
         TbsmtggTecSA1i1Ndct6TNaLo3lPDdjBjaYlsu8lHPyKQ7VpshaU6OuBMJbQ2JnEEfrz
         eWBpw1fVyu9ko1vLNKno86SK8FCC4zl6iHVrsDVhSgTG1EX5XtntWfjnIcMoxcfurgrx
         8FgA5zda3bSY9RPVNI4uvLeJiBAlSOijw5uJpwGioPqq6JJm7iIN9W1KibCBmqMJKpsa
         KYwzyRbqZAo6A3hFVLbqZbxf7s1u/hUsO4hcYsyC8oM6skibp3N9MrxCEp4uen9f/1ff
         YZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SR9069WCtkEVhWLPOJ7tgY3RDB+5yi0JYbZLTKxBZmU=;
        b=e9TkA+3L/2Ze23q3Igt7MejFgMFxidfcFoOxif/EGXkX2eWJC8q9AVOteILUHzAf8c
         IXmI9yRNnY/NuEzqw0Ypmp7tFt0sjW3v4Qj4wgYUKgDaNExC8UgTzfaJbIaMCgVF0IL2
         GGh6/Fi+9SqpMLbp7INGgXc4IrnfHzOMrqIFe1yBk77oonfKEWYVmOHPu+yadrE+ZEXC
         4S3nmpshrE4WDl912B836TYrCuZ1dJHFFTQ5ASRWXDjjd7mg8yGjW5ch3IkJJv6st5UF
         1we3L8eE4IkoSZFiVNfc/TXPYQcAngiC+DmobUC8UqkeDSTAv2oZA9sWduq9/PVZ8Svv
         xgwA==
X-Gm-Message-State: AOAM5308HBTZYhi0mbs24bq8XhmIJJgsZ2cH3EOGRJV0ZzeOt0/k3XTO
        4ZJ8G+QuXbiuODcca9mf3+nzfsKgrn/78WD5NQg=
X-Google-Smtp-Source: ABdhPJxQDygHxWCVT6rAi37rBd/V1rTbpkAbZ69OaJHg46VxCPOI/rrRStcaJZnyEzYHPQxED20mRVTlTVU89PfXFII=
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr7437931wrk.108.1599720332166;
 Wed, 09 Sep 2020 23:45:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com> <20200910054933.GA525707@kroah.com>
In-Reply-To: <20200910054933.GA525707@kroah.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 00:45:17 -0600
Message-ID: <CADvTj4pZKeic1-Yb_baJkbfn8UWXczuoSRXqhH_1qHB=NV4FjA@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:49 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 09, 2020 at 01:34:18PM -0600, James Hilliard wrote:
> > This patch detects and reverses the effects of the malicious FTDI
> > Windows driver version 2.12.00(FTDIgate).
> >
> > While we currently load the ftdi_sio driver for devices with
> > FTDI_BRICK_PID(0x0000) userspace applications that expect the
> > appropriate FTDI_8U232AM_PID(0x6001) PID may not work properly.
> >
> > Since the malicious FTDI driver modifies the PID without modifying
> > the normal checksum field we can detect and limit the unbricking
> > to devices that were bricked specifically using the FTDI checksum
> > preimage attack technique used by the official Windows drivers.
> >
> > This should have no effect on devices where the PID was deliberately
> > set to FTDI_BRICK_PID(0x0000) as the checksum would normally change
> > and the preimage target(address 62) should be 0. We validate that
> > the preimage target is not 0 before attempting to unbrick.
> >
> > Since we only write to even addresses this should have no effect at
> > all on non-counterfeit FTDI hardware due to the hardware only
> > committing EEPROM writes when odd addresses are written.
> >
> > References:
> > https://marcan.st/transf/detect_ftdi_clone.py
> > https://hackaday.com/2014/10/22/watch-that-windows-update-ftdi-drivers-are-killing-fake-chips/
> > https://www.eevblog.com/forum/reviews/ftdi-driver-kills-fake-ftdi-ft232/msg535270/#msg535270
> > https://lkml.org/lkml/2014/10/23/266
> > https://lore.kernel.org/patchwork/patch/509929/
> > https://lore.kernel.org/patchwork/patch/510097/
> >
> > Signed-off-by: Russ Dill <Russ.Dill@gmail.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Cc: Hector Martin <hector@marcansoft.com>
> > ---
> > Changes v1 -> v2:
> >   - Move ftdi_read_eeprom and ftdi_write_eeprom outside #ifdef CONFIG_GPIOLIB
> > ---
> >  drivers/usb/serial/ftdi_sio.c | 181 +++++++++++++++++++++++++++-------
> >  drivers/usb/serial/ftdi_sio.h |   4 +
> >  2 files changed, 152 insertions(+), 33 deletions(-)
>
> This is interesting, but not something that is really needed on a Linux
> machine right?  The "bricked" devices work just fine on Linux, and Linux
> does not cause these devices to ever be "bricked", so why build into the
> Linux kernel an option that only is needed by another operating system?
Well the PID's being wrong messes up my Linux userspace applications
that match against the device VID/PID's, so while the driver does load the
serial interface the userspace application may not see it properly.

Effectively my setup relies on stable USB identifiers, if the Windows
driver messes those up my applications don't work correctly, and I have
little control over these devices getting plugged into Windows systems
so I need to automatically detect and set the eeprom changes back
to their expected values.
>
> If you have "bricked" devices, you can use the userspace tool to fix
> them up so that they can work properly on other operating systems, as a
> utility.  But to build this into Linux feels very odd to me.
Yeah, I originally looked into doing this in userspace but I didn't see a clean
way to fix it there without having a bunch of side effects and complex
service management. By doing it in the driver we can fix it before
userspace even sees the device.
>
> That being said, code review:
>
> >
> > diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
> > index 871cdccf3a5f..85324e2ea107 100644
> > --- a/drivers/usb/serial/ftdi_sio.c
> > +++ b/drivers/usb/serial/ftdi_sio.c
> > @@ -1062,6 +1062,9 @@ static const char *ftdi_chip_name[] = {
> >  /* function prototypes for a FTDI serial converter */
> >  static int  ftdi_sio_probe(struct usb_serial *serial,
> >                                       const struct usb_device_id *id);
> > +static int  ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
> > +                                     u16 nbytes);
>
> No need for this, just keep this function in the same place in the file,
> right?
It needs to be outside of the #ifdef CONFIG_GPIOLIB.
>
> > +static int  ftdi_write_eeprom(struct usb_serial_port *port, u8 addr, u16 data);
> >  static int  ftdi_sio_port_probe(struct usb_serial_port *port);
> >  static int  ftdi_sio_port_remove(struct usb_serial_port *port);
> >  static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port);
> > @@ -1996,39 +1999,6 @@ static int ftdi_gpio_direction_output(struct gpio_chip *gc, unsigned int gpio,
> >       return result;
> >  }
> >
> > -static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
> > -                             u16 nbytes)
> > -{
> > -     int read = 0;
> > -
> > -     if (addr % 2 != 0)
> > -             return -EINVAL;
> > -     if (nbytes % 2 != 0)
> > -             return -EINVAL;
> > -
> > -     /* Read EEPROM two bytes at a time */
> > -     while (read < nbytes) {
> > -             int rv;
> > -
> > -             rv = usb_control_msg(serial->dev,
> > -                                  usb_rcvctrlpipe(serial->dev, 0),
> > -                                  FTDI_SIO_READ_EEPROM_REQUEST,
> > -                                  FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
> > -                                  0, (addr + read) / 2, dst + read, 2,
> > -                                  WDR_TIMEOUT);
> > -             if (rv < 2) {
> > -                     if (rv >= 0)
> > -                             return -EIO;
> > -                     else
> > -                             return rv;
> > -             }
> > -
> > -             read += rv;
> > -     }
> > -
> > -     return 0;
> > -}
>
> Why move this function?
So that it still gets included when building without CONFIG_GPIOLIB.
>
> > -
> >  static int ftdi_gpio_init_ft232h(struct usb_serial_port *port)
> >  {
> >       struct ftdi_private *priv = usb_get_serial_port_data(port);
> > @@ -2234,10 +2204,149 @@ static int ftdi_sio_probe(struct usb_serial *serial,
> >       return 0;
> >  }
> >
> > +static int ftdi_read_eeprom(struct usb_serial *serial, void *dst, u16 addr,
> > +                             u16 nbytes)
> > +{
> > +     int read = 0;
> > +
> > +     if (addr % 2 != 0)
> > +             return -EINVAL;
> > +     if (nbytes % 2 != 0)
> > +             return -EINVAL;
> > +
> > +     /* Read EEPROM two bytes at a time */
> > +     while (read < nbytes) {
> > +             int rv;
> > +
> > +             rv = usb_control_msg(serial->dev,
> > +                                  usb_rcvctrlpipe(serial->dev, 0),
> > +                                  FTDI_SIO_READ_EEPROM_REQUEST,
> > +                                  FTDI_SIO_READ_EEPROM_REQUEST_TYPE,
> > +                                  0, (addr + read) / 2, dst + read, 2,
> > +                                  WDR_TIMEOUT);
> > +             if (rv < 2) {
> > +                     if (rv >= 0)
> > +                             return -EIO;
> > +                     else
> > +                             return rv;
> > +             }
> > +
> > +             read += rv;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int ftdi_write_eeprom(struct usb_serial_port *port, u8 addr, u16 data)
> > +{
> > +     struct usb_device *udev = port->serial->dev;
> > +     int rv;
> > +
> > +     rv = usb_control_msg(udev,
> > +                          usb_sndctrlpipe(udev, 0),
> > +                          FTDI_SIO_WRITE_EEPROM_REQUEST,
> > +                          FTDI_SIO_WRITE_EEPROM_REQUEST_TYPE,
> > +                          data, addr,
> > +                          NULL, 0, WDR_TIMEOUT);
> > +     if (rv < 0)
> > +             dev_err(&port->dev, "Unable to write EEPROM: %i\n", rv);
>
> You don't check for a "short write"?
From my understanding the hardware only accepts 2 byte writes, and
the non-counterfeits actually only commit writes on odd addresses
while they buffer writes on even(this difference is what FTDI's windows
driver exploits). So I guess this should be "if (rv < 2)"?
>
> > +     return rv;
> > +}
> > +
> > +static u16 ftdi_checksum(u16 *data, int n)
> > +{
> > +     u16 checksum;
> > +     int i;
> > +
> > +     checksum = 0xaaaa;
> > +     for (i = 0; i < n - 1; i++) {
> > +             checksum ^= be16_to_cpu(data[i]);
> > +             checksum = (checksum << 1) | (checksum >> 15);
> > +     }
>
> What type of function is this, don't we have all of the needed checksum
> functions in the kernel already?
Some custom crc16 style checksum I guess, I'm not seeing anything
in the kernel that's the same, although I might not be looking in the
right places.
>
> > +
> > +     return cpu_to_be16(checksum);
> > +}
> > +
> > +static int ftdi_repair_brick(struct usb_serial_port *port)
> > +{
> > +     struct ftdi_private *priv = usb_get_serial_port_data(port);
> > +     int orig_latency;
> > +     int rv;
> > +     u16 *eeprom_data;
> > +     u16 checksum;
> > +     int eeprom_size;
> > +     int result;
> > +
> > +     switch (priv->chip_type) {
> > +     case FT232RL:
> > +             eeprom_size = 0x40;
> > +             break;
> > +     default:
> > +             /* Unsupported for brick repair */
> > +             return 0;
> > +     }
> > +
> > +     /* Latency timer needs to be 0x77 to unlock EEPROM programming */
> > +     if (priv->latency != 0x77) {
> > +             orig_latency = priv->latency;
> > +             priv->latency = 0x77;
> > +             rv = write_latency_timer(port);
> > +             priv->latency = orig_latency;
>
> So you change the latency, and then lie that it is changed?
This value will get applied immediately after ftdi_repair_brick finishes, we run
ftdi_repair_brick before the original latency ever actually gets applied.
See: https://github.com/torvalds/linux/blob/v5.8/drivers/usb/serial/ftdi_sio.c#L2258
>
> > +             if (rv < 0)
> > +                     return -EIO;
> > +     }
> > +
> > +     eeprom_data = kmalloc(eeprom_size * 2, GFP_KERNEL);
> > +     if (!eeprom_data)
> > +             return -ENOMEM;
> > +
> > +     /* Read in EEPROM */
> > +     result = ftdi_read_eeprom(port->serial, eeprom_data, 0x00, eeprom_size * 2);
> > +     if (result < 0)
> > +             goto end_repair_brick;
> > +
> > +     /* Verify EEPROM is valid */
> > +     checksum = ftdi_checksum(eeprom_data, eeprom_size);
> > +     if (checksum != eeprom_data[eeprom_size - 1])
> > +             goto end_repair_brick;
> > +
> > +     /* Skip if no preimage attack against target address 62 */
> > +     if (eeprom_data[62] == 0)
> > +             goto end_repair_brick;
>
> Here, and later on, if you error out, you are not setting the return
> value to be an error, why?
This means the device does not appear to have been attacked by the
Windows driver, so we bail out without an error and assume the 0x0000
PID was intentionally set in a normal way. The normal PID changing
utilities should leave address 62 as the default 0x0000 and instead
change the real checksum which is at address 63.
>
>
> > +
> > +     /* Attempt to restore Product ID to 0x6001 */
> > +     eeprom_data[2] = FTDI_8U232AM_PID;
> > +
> > +     /* Clear preimage attack target address */
> > +     eeprom_data[62] = 0;
> > +
> > +     /* Calculate and verify new checksum */
> > +     checksum = ftdi_checksum(eeprom_data, eeprom_size);
> > +     if (checksum != eeprom_data[eeprom_size - 1])
> > +             goto end_repair_brick;
> > +
> > +     /* Restore EEPROM PID to original pre-brick state */
> > +     if (ftdi_write_eeprom(port, 2, eeprom_data[2]) < 0)
> > +             goto end_repair_brick;
> > +
> > +     /* Restore EEPROM preimage target address to original pre-brick state */
> > +     if (ftdi_write_eeprom(port, 62, eeprom_data[62]) < 0)
> > +             goto end_repair_brick;
> > +
> > +     dev_info(&port->dev, "Successfully repaired eeprom bricked by FTDI's malicious Windows driver.\n");
> > +
> > +end_repair_brick:
> > +     kfree(eeprom_data);
> > +
> > +     return result;
> > +}
> > +
> >  static int ftdi_sio_port_probe(struct usb_serial_port *port)
> >  {
> >       struct ftdi_private *priv;
> >       const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
> > +     u16 vendor_id;
> > +     u16 product_id;
> >       int result;
> >
> >       priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
> > @@ -2255,6 +2364,12 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
> >       ftdi_set_max_packet_size(port);
> >       if (read_latency_timer(port) < 0)
> >               priv->latency = 16;
> > +     vendor_id = le16_to_cpu(port->serial->dev->descriptor.idVendor);
> > +     product_id = le16_to_cpu(port->serial->dev->descriptor.idProduct);
> > +     if (vendor_id == FTDI_VID &&
> > +             product_id == FTDI_BRICK_PID &&
> > +             priv->chip_type == FT232RL)
> > +             ftdi_repair_brick(port);
>
> So now you are forcing all devices with that id to go through this
> function?  How long does this function take?  What about devices that
> were working just fine with Linux with that id and did not want their
> eeproms to be "fixed"?
The ftdi_repair_brick function has checks that will bail out if FTDI_BRICK_PID
was intentionally set. This is because intentionally setting the PID
using normal
tools changes the checksum, while FTDI's driver does a preimage attack against
the checksum instead. We only fix those that had their PID changed via the
preimage attack and not those that were changed intentionally.

I haven't benchmarked this properly but it's under 100ms from the
looks of it, if
that is too slow I can optimize it to bail out much faster pretty
easily for intentionally
configured FTDI_BRICK_PID's as a fast preimage sanity check would be a single
read. Keep in mind though that it would be pretty rare for a device to
intentionally
use FTDI_BRICK_PID.
>
> thanks,
>
> greg k-h
