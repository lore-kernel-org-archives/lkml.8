Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E79C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A9520738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJ+1J26V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgHaG0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgHaG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:26:28 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4774C061573;
        Sun, 30 Aug 2020 23:26:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n18so4034768qtw.0;
        Sun, 30 Aug 2020 23:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncYcfPMOgylHs3AbwbUsJDFMZYVoo80dUyXRIbMUPGo=;
        b=iJ+1J26VGIg06J5hanIusfC3WIfFG/+51TdIBJc4ElPdu2yW4LitgF+xZdyvt1AVC4
         26R+mFASCZYswrHldRC3Ol5y55mnSTJ2+50Xv0uwXlFYU0A+vtNESbsgRTivnQmtYJyo
         /rQCsUNudC9LzGjSE487SNVTF7HbWu1ZHVg7IEQl4jFKRIQUWXRDjmHTdtzg8CLN1nHg
         oZrzCiQZs/6lp1DyQk3CaoAic1wABOuuVpEYAu9Iw+8FSixdx7sH9jFkjgjGZ2H4pZUJ
         mLDqtUO7YYdUnrvjf7RQPC5ZB25en0+X3RMObbHxxKE+ZBg3JzjnKX5aXY+fALtESV1q
         c5MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncYcfPMOgylHs3AbwbUsJDFMZYVoo80dUyXRIbMUPGo=;
        b=U0h4uNPoDAjcdkwUc4nApt5K/fpSd5oP5/wIGQQVTqVynwlVVf721Zh8wtTKA1wrvz
         /muzQd+aRsK570kqvGkMux5MnvpYnQ2u9QJ7GkCbJAjCReYPoFx4ZDOUoPMeAKTjHzdI
         SGCngxEbC8UBxd6v0v7kvCv1yvE67UOoUeSHiAOx1Tb5NenRrX49yx1b3C6vQhirDe52
         D8lCyYUagTxsNsV4dgCP/ZymvfsvERR24heE1SGk7MEHOmKIeZNoFXVnrj1dOTR7neum
         cSO7Md4JEY9Ix32zYKVrBZ+5xNnZWXlEoPCYble+cTLAfqEto3oIMgy6NWaLRPnIlZhf
         Mkzg==
X-Gm-Message-State: AOAM532eHpCFWhzG97/9BsXgMj0copBm3KpSBNARneGe6QUcOhplR8IW
        9Lx5v33F8ryiGQwKCzSiOgPsL4PIqyo3jtQYZ6o=
X-Google-Smtp-Source: ABdhPJwdJSuDCmRWqqThWrapKnJnDxka/yPuuMxXGDth/6AuqXsalnqKesZc1Eq80on3CYrC+eMYl0cOWYq9qYTTo8E=
X-Received: by 2002:ac8:22fb:: with SMTP id g56mr11557199qta.141.1598855184981;
 Sun, 30 Aug 2020 23:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200818124815.11029-1-vaishnav@beagleboard.org>
 <20200818124815.11029-2-vaishnav@beagleboard.org> <CALudOK4R-Fu-xMXbip8e_Cuu0o4DQwjc=SMGdMBVsH=XTUShNw@mail.gmail.com>
In-Reply-To: <CALudOK4R-Fu-xMXbip8e_Cuu0o4DQwjc=SMGdMBVsH=XTUShNw@mail.gmail.com>
From:   Zoran Stojsavljevic <zoran.stojsavljevic@gmail.com>
Date:   Mon, 31 Aug 2020 08:26:13 +0200
Message-ID: <CAGAf8Lztap9af9kuCiFgY8gUP7KoOrHZ_2KBbJt-NtKkp=atVg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] add mikrobus descriptors to greybus_manifest
To:     Vaishnav M A <vaishnav@beagleboard.org>
Cc:     greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, arnd@arndb.de,
        johan@kernel.org, elder@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        =?UTF-8?Q?Ivan_Rajkovi=C4=87?= <rajkovic@mikroe.com>,
        chrisfriedt@gmail.com, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vaishnav,

I should say, an excellent work on the greybus_manifest.h file.

Actually, my thoughts will be to have a two-stage commit of the whole
MikroBUS patch.

The first one are these changes with greybus_manifest.h, followed by
dependent mikrobus_core.h and mikrobus_manifest.h.

These two should have included #include
<linux/greybus/greybus_manifest.h> to reflect the correct hierarchical
structure.

The rest is with the mikrobus driver .c code.

It is just an observation from me, I guess, it is obvious.

My two cent worth comment,
Zoran
_______

On Thu, Aug 20, 2020 at 2:49 AM Vaishnav M A <vaishnav@beagleboard.org> wrote:
>
> Hi,
>
> Trying to add more information regarding the newly added
> descriptors and describe how they are used now within the
> mikroBUS driver.
>
> On Tue, Aug 18, 2020 at 6:18 PM Vaishnav M A <vaishnav@beagleboard.org> wrote:
> >
> > This patch adds new descriptors used in the manifest parsing inside
> > the mikrobus driver, the device descriptor help to describe the
> > devices on a mikroBUS port, mikrobus descriptor is used to set up
> > the mikrobus port pinmux and GPIO states and property descriptor
> > to pass named properties to device drivers through the Unified
> > Properties API under linux/property.h
> >
> > The corresponding pull request for manifesto is updated
> > at : https://github.com/projectara/manifesto/pull/2
> >
> > Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> > ---
> >  include/linux/greybus/greybus_manifest.h | 47 ++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
> > index 6e62fe478712..821661ea7f01 100644
> > --- a/include/linux/greybus/greybus_manifest.h
> > +++ b/include/linux/greybus/greybus_manifest.h
> > @@ -23,6 +23,9 @@ enum greybus_descriptor_type {
> >         GREYBUS_TYPE_STRING             = 0x02,
> >         GREYBUS_TYPE_BUNDLE             = 0x03,
> >         GREYBUS_TYPE_CPORT              = 0x04,
> > +       GREYBUS_TYPE_MIKROBUS           = 0x05,
>
> The mikrobus descriptor is used to pass information about
> the specific pinmux settings and the default GPIO states on
> the mikrobus port to be set up for the add-on board to work
> correctly, this descriptor has 12 u8 fields(corresponding  to the
> 12 pins on the mikrobus port) which includes information
> about the prior setup required on the mikroBUS port for the
> device(s) on the add-on board to work correctly. The mikrobus
> descriptor is a fixed-length descriptor and there will be only a
> single instance of mikrobus descriptor per add-on board manifest.
>
> > +       GREYBUS_TYPE_PROPERTY           = 0x06,
>
> The property descriptors are used to pass named properties
> to the device drivers through the Unified device property interface
> under linux/property.h , so that device drivers using the
> device_property_read_* call can get the named properties,
> the mikrobus driver fetches the information from the manifest
> binary and forms a corresponding `struct property_entry` which
> will be attached to the `struct device`.
> The property descriptor is a variable-length descriptor similar
> to the string descriptor and there can be multiple instances of
> property descriptor per add-on board manifest.
>
> > +       GREYBUS_TYPE_DEVICE             = 0x07,
>
> The device descriptor is used to describe a device on the
> mikrobus port and has necessary fields from `struct i2c_board_info`
> and `struct spi_board_info` to describe a device on these buses
> in a mikrobus port, even though  SPI/I2C device info structs are used
> this descriptor has enough information to describe other kinds of
> devices relevant to mikrobus as well.(serdev/platform devices).
> The device descriptor is a fixed-length descriptor and there can be
> multiple instances of device descriptors in an add-on board manifest
> in cases where the add-on board presents more than one device
> to the host.
>
> >  };
> >
> >  enum greybus_protocol {
> > @@ -151,6 +154,47 @@ struct greybus_descriptor_cport {
> >         __u8    protocol_id;    /* enum greybus_protocol */
> >  } __packed;
> >
> > +/*
> > + * A mikrobus descriptor is used to describe the details
> > + * about the bus ocnfiguration for the add-on board
> > + * connected to the mikrobus port.
> > + */
> > +struct greybus_descriptor_mikrobus {
> > +       __u8 pin_state[12];
> > +} __packed;
> > +
>
> These 12 u8 fields describe the state of the pins in the
> mikrobus port(in clock wise order starting from the PWM
> pin)
> mikrobus v2 standard specification :
> https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
> This struct is filled from the mikrobus-descriptor
> in the manifest and can have one of the values
> for each pin group:
> MIKROBUS_STATE_INPUT = 0x01,
> MIKROBUS_STATE_OUTPUT_HIGH = 0x02,
> MIKROBUS_STATE_OUTPUT_LOW = 0x03,
> MIKROBUS_STATE_PWM = 0x04,  ( applicable only to  PWM pin)
> MIKROBUS_STATE_SPI = 0x05, ( applicable only to
> the group of MOSI, MISO, SCK , CS pins on mikroBUS port)
> MIKROBUS_STATE_I2C = 0x06, (applicable only to the SCL, SDA
> pins on the mikrobus port)
> MIKROBUS_STATE_UART = 0x07,(applicable only to the RX, TX
> pins on the mikrobus port)
> There are two purposes for adding this descriptor,
> 1) for some add-on boards some of the pins might need to
> be configured as GPIOs deviating from their reserved purposes
> An example for this case is an SHT15 Click (https://www.mikroe.com/sht1x-click),
> where the SCL and SDA Pins need to be configured as GPIOs
> for the driver (drivers/hwmon/sht15.c) to work. The mikrobus
> descriptor for this case would look like this :
> [mikrobus-descriptor]
> pwm-state = 4 (default, pwm)
> int-state = 1 (default, input)
> rx-state = 7 (default, uart)
> tx-state = 7 (default, uart)
> scl-state = 3 (note the SCL Pin configured as GPIO)
> sda-state = 3 (note the SCL Pin configured as GPIO)
> mosi-state = 5 (default, spi)
> miso-state = 5 (default, spi)
> sck-state = 5 (default, spi)
> cs-state = 5 (default, spi)
> rst-state = 2 (default, GPIO)
> an-state = 1 (default, input)
> 2) for some add-on boards the driver may not take care
> of some additional signals like reset/wake-up/other thus
> the mikrobus driver can set-up these GPIOs to a required
> default state from the information from the manifest, a good
> example for this is the  ENC28J60 click (https://www.mikroe.com/eth-click)
> where the reset line(RST pin on the mikrobus port) needs to be
> pulled high. The manifest example for this add-on board can
> be found here :
> https://github.com/vaishnav98/manifesto/blob/mikrobusv3/manifests/ETH-CLICK.mnfs
>
> > +/*
> > + * A property descriptor is used to pass named properties
> > + * to device drivers through the unified device properties
> > + * interface under linux/property.h
> > + */
> > +struct greybus_descriptor_property {
> > +       __u8 length;
> > +       __u8 id;
> > +       __u8 propname_stringid;
> > +       __u8 type;
> > +       __u8 value[0];
> > +} __packed;
> > +
>
> This descriptor is used to fill in `struct property_entry`
> (linux/property.h), the propname_stringid
> field is used to map to the corresponding string descriptor
> which has the property name, the type field has the types
> under dev_prop_type (linux/property.h) and there are
> some new types which are used within the mikrobus
> driver, these are the new types :
> MIKROBUS_PROPERTY_TYPE_LINK = 0x01
> MIKROBUS_PROPERTY_TYPE_GPIO = 0x02
>
> The property-link type is used to attach an array of properties
> to the corresponding device, for example, consider an SPI
> EEPROM device which works with the AT25 driver(
> drivers/misc/eeprom/at25.c), The device and property
> descriptor parts of the manifest will look like this.
>
> [device-descriptor 1]
> driver-string-id = 3
> prop-link = 1 (The ID of the property-descriptor which
> contains the list of IDs of the actual properties to attach with
> the device)
> protocol = 0xb
> reg = 0
> mode = 0x3
> max-speed-hz = 5000000
> [string-descriptor 3]
> string = at25 (driver string)
>
> [property-descriptor 1]
> name-string-id = 4
> type = 0x01 (type is property-link)
> value = <2 3 4>(attach properties with id 2,3,4 to the device)
> [string-descriptor 4]
> string = prop-link
>
> [property-descriptor 2]
> name-string-id = 5 (string id for the property name string)
> type = 0x05 (U32, driver uses device_property_read_u32 call
> to read the value)
> value = <262144>
> [string-descriptor 5]
> string = size (property name string)
>
> [property-descriptor 3]
> name-string-id = 6
> type = 0x05
> value = <256>
> [string-descriptor 6]
> string = pagesize
>
> [property-descriptor 4]
> name-string-id = 7
> type = 0x05
> value = <24>
> [string-descriptor 7]
> string = address-width
>
> The gpio-link type is very similar to property descriptor and is used to
> pass an array of named gpios to the device driver through GPIO lookup tables,
> consider an example for a SHT15 device (drivers/hwmon/sht15.c),
> the device and the property(gpio) descriptors are as follows :
>
> [device-descriptor 1]
> driver-string-id = 3
> protocol = 0xfe
> reg = 0
> gpio-link = 1 (The ID of the property-descriptor which
> contains the list of IDs of the named gpio properties to attach with
> the device)
>
> [string-descriptor 3]
> string = sht11 (device_id string)
>
> [property-descriptor 1]
> name-string-id = 4
> type = 0x02 (gpio-link)
> value = <2 3> (attach properties with id 2,3 as named gpios to the device)
> [string-descriptor 4]
> string = gpio-link
>
> [property-descriptor 2]
> name-string-id = 5
> type = 0x03
> value = <4>
> [string-descriptor 5]
> string = clk (name of the GPIO, the driver uses
> devm_gpiod_get or similar calls to get the GPIO)
>
> [property-descriptor 3]
> name-string-id = 6
> type = 0x03
> value = <5>
> [string-descriptor 6]
> string = data
>
> Note that the values here 4 and 5 for the GPIOs are
> the offset numbers(clockwise starting from PWM pin)
> within a mikrobus port, the mikrobus drivers translates this
> offset information to the actual GPIO while creating the GPIO
> lookup table, this ensures that the manifest doesn't have any
> port-specific information and a single manifest can be used for
> an add-on board over different platforms/sockets.
>
> > +/*
> > + * A device descriptor is used to describe the
> > + * details required by a add-on board device
> > + * driver.
> > + */
> > +struct greybus_descriptor_device {
> > +       __u8 id;
> > +       __u8 driver_stringid;
> > +       __u8 protocol;
> > +       __u8 reg;
> > +       __le32 max_speed_hz;
> > +       __u8 irq;
> > +       __u8 irq_type;
> > +       __u8 mode;
> > +       __u8 prop_link;
> > +       __u8 gpio_link;
> > +       __u8 pad[3];
> > +} __packed;
> > +
>
> The device descriptor is used to describe a device on the
> mikrobus port and has necessary fields from `struct i2c_board_info`
> and `struct spi_board_info`, of these fields, the irq field is similar to
> the gpio descriptor value above in that the value under irq is also
> the pin offset within the mikrobus port which will be translated to the
> actual GPIO within the mikrobus driver and the irq-type takes types
> defined under linux/interrupt.h . For a device with a
> IRQF_TRIGGER_RISING interrupt on the INT pin on the mikrobus port
> the fields will be :
> irq = 1 (offset of INT pin)
> irq_type = 1 ( IRQF_TRIGGER_RISING)
>
> >  struct greybus_descriptor_header {
> >         __le16  size;
> >         __u8    type;           /* enum greybus_descriptor_type */
> > @@ -164,6 +208,9 @@ struct greybus_descriptor {
> >                 struct greybus_descriptor_interface     interface;
> >                 struct greybus_descriptor_bundle        bundle;
> >                 struct greybus_descriptor_cport         cport;
> > +               struct greybus_descriptor_mikrobus      mikrobus;
> > +               struct greybus_descriptor_property      property;
> > +               struct greybus_descriptor_device        device;
> >         };
> >  } __packed;
> >
> > --
> > 2.25.1
> >
> Thanks and Regards,
> Vaishnav
