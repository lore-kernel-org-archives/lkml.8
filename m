Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE3F2076B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 21:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssvLCDgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgHBVEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHBVEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 17:04:36 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB445C06174A;
        Sun,  2 Aug 2020 14:04:35 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w2so4411577qvh.12;
        Sun, 02 Aug 2020 14:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cPw9yFbvd/rSNUGXTNHtKFw1WgQRY+M/ar9vPzLb9x0=;
        b=ssvLCDgm+dIHwPq4PZCnlEmu1dTfqb5TCIj+4Deg2N/qIsup/ePgxnCstZz0nGy+nI
         CQJuJyS/o3mhWHh3H+of04Fdzk4YtkRLvOcDHR19lNAqlS47es9zSBkI1wBUa5JFdtqe
         3NiYV+B8VAiKlCf/RnSDVWC6ObeZJK5mCLbQHEhJX6CDH+Zz95M6wI7h3nb87DzUvZby
         gk2mj6Ak+GHDgZy4WUZ//muHTbrnDGLXgAFUT/RGSQldMpa5fkPDwyqtcNs+DigE4sVG
         c5I0wVSFJbp6jot3KfMNUcb2rzVMT1Ul8VkM4oZmkwYUG38uWb7xDfacC9eMQQ9xgmDZ
         eV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPw9yFbvd/rSNUGXTNHtKFw1WgQRY+M/ar9vPzLb9x0=;
        b=svMhlABYe6eScU/nbDYUWuMKjyj4DCs2k7HXdkIso8a6AE0u0brclTjZc2QH+F0/j0
         hKBKS0vdeLkj4PPtEqcS427k3EfghNKimFAfPUBMOO2Lbd16s5wIxq1rhe5QkYb1sauC
         5KUu0S81OayCgmcb9PFdzqfx2JLmbLDi1V5NUrIij73NSeNEKHu/hhzCjROC31txviXy
         7I1cxEhJ7tSrX9nWORmCdk9r2FG4b6jGleSG6hs6nWfOzNMvwTFLTf72PlGqlPiJLiz/
         t20/5VCz8fDzQqCQS8LsTkNeBgE8CcAqsxAdunl9HZGiK3rtGAfltbhUc0ZQGUw54MFP
         /WSg==
X-Gm-Message-State: AOAM533quA7ciyfebSMeFFeIHu92FJYPwlfgcjqV+oNicwF6aGqTd8Uq
        nS3wZzgk4dQs2SMU1i7ymyE=
X-Google-Smtp-Source: ABdhPJxc6eQJ2drf7U0lBhvY7UnagHDeenZ061su7b0hjgSh8S/MnbJc6nKoO55UH97oL5tCJEgDvg==
X-Received: by 2002:ad4:50c9:: with SMTP id e9mr14013950qvq.26.1596402273907;
        Sun, 02 Aug 2020 14:04:33 -0700 (PDT)
Received: from shinobu (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id e4sm20143362qts.57.2020.08.02.14.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 14:04:32 -0700 (PDT)
Date:   Sun, 2 Aug 2020 17:04:15 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     jic23@kernel.org, kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        David.Laight@ACULAB.COM
Subject: Re: [PATCH v4 1/5] counter: Internalize sysfs interface code
Message-ID: <20200802210415.GA606173@shinobu>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
 <e13d43849f68af8227c6aaa0ef672b459d47e9ab.1595358237.git.vilhelm.gray@gmail.com>
 <7209ac3d-d1ca-1b4c-b22c-8d98b13742e2@lechnology.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <7209ac3d-d1ca-1b4c-b22c-8d98b13742e2@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2020 at 05:45:53PM -0500, David Lechner wrote:
> On 7/21/20 2:35 PM, William Breathitt Gray wrote:
> > This is a reimplementation of the Generic Counter driver interface.
> > There are no modifications to the Counter subsystem userspace interface,
> > so existing userspace applications should continue to run seamlessly.
> >=20
> > Overview
> > =3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > The purpose of this patch is to internalize the sysfs interface code
> > among the various counter drivers into a shared module. Counter drivers
> > pass and take data natively (i.e. u8, u64, etc.) and the shared counter
> > module handles the translation between the sysfs interface. This
> > gurantees a standard userspace interface for all counter drivers, and
>=20
> spelling: guarantees

Thanks, I'll fix this.

> > helps generalize the Generic Counter driver ABI in order to support the
> > Generic Counter chrdev interface (introduced in a subsequent patch)
> > without significant changes to the existing counter drivers.
> >=20
> > A high-level view of how a count value is passed down from a counter
> > driver is exemplified by the following:
> >=20
> >                   ----------------------
> >                  / Counter device       \
> >                  +----------------------+
> >                  | Count register: 0x28 |
> >                  +----------------------+
> >                          |
> >                   -----------------
> >                  / raw count data /
> >                  -----------------
> >                          |
> >                          V
> >                  +----------------------------+
> >                  | Counter device driver      |----------+
> >                  +----------------------------+          |
> >                  | Processes data from device |   -------------------
> >                  |----------------------------|  / driver callbacks /
> >                  | Type: u64                  |  -------------------
> >                  | Value: 42                  |          |
> >                  +----------------------------+          |
> >                          |                               |
> >                   ----------                             |
> >                  / u64     /                             |
> >                  ----------                              |
> >                          |                               |
>=20
> The line on the left is meta data describing the type of the value and
> the line on the right is the value itself?

The left line is the data being passed by the callbacks; the right line
is the callbacks being registered via the counter_register function.

This chart might be better represented as two separate charts: I was
attempting to show how "Counter core" is used simply to register the
callbacks for "Counter sysfs" and "Counter chrdev", whereafter the
callbacks are called directly by those components when needed without
passing through "Counter core" again.

> >                          |                               V
> >                          |               +----------------------+
> >                          |               | Counter core         |
> >                          |               +----------------------+
> >                          |               | Routes device driver |
> >                          |               | callbacks to the     |
> >                          |               | userspace interfaces |
> >                          |               +----------------------+
> >                          |                       |
> >                          |                -------------------
> >                          |               / driver callbacks /
> >                          |               -------------------
> >                          |                       |
> >                  +-------+                       |
> >                  |                               |
> >                  |               +---------------+
> >                  |               |
> >                  V               |
> >          +--------------------+  |
> >          | Counter sysfs      |<-+
> >          +--------------------+
> >          | Translates to the  |
> >          | standard Counter   |
> >          | sysfs output       |
> >          |--------------------|
> >          | Type: const char * |
> >          | Value: "42"        |
> >          +--------------------+
> >                  |
> >           ---------------
> >          / const char * /
> >          ---------------
> >                  |
> >                  V
> >          +--------------------------------------------------+
> >          | `/sys/bus/counter/devices/counterX/countY/count` |
> >          +--------------------------------------------------+
> >          \ Count: "42"                                      /
> >           --------------------------------------------------
> >=20
> > There are three primary components involved:
> >=20
> > 	Counter device driver
> > 	---------------------
> > 	Communicates with the hardware device to read/write data; e.g.
> > 	counter drivers for 104-quad-8, stm32-timer, etc.
> >=20
> > 	Counter core
> > 	------------
> > 	Registers the counter device driver to the system so that the
> > 	respective callbacks are called during userspace interaction
> >=20
> > 	Counter sysfs
> > 	-------------
> > 	Translates counter data to the standard Counter sysfs interface
> > 	format and vice versa
> >=20
> > Driver ABI
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > This reimplementation entails several changes to the driver ABI. In
> > particular, the device driver callbacks are now expected to handle
> > standard C datatypes rather than translating the sysfs I/O directly.
> >=20
> > To that end, the struct counter_data structure is introduced to
> > establish counter extensions for Signals, Synapses, and Counts.
> >=20
> > The "type" member specifies the type of high-level data (e.g. BOOL,
> > COUNT_DIRECTION, etc.) handled by this extension. The "*_read" and
> > "*_write" members can then be set by the counter device driver with
> > callbacks to handle that data using native C data types (i.e. u8, u64,
> > etc.).
> >=20
> > Convenience macros such as COUNTER_DATA_COUNT_U64 are provided for use
> > by driver authors. In particular, driver authors are expected to use
> > the provided macros for standard Counter subsystem attributes in order
> > to maintain a consistent interface for userspace. For example, a counter
> > device driver may define several standard attributes like so:
> >=20
> > struct counter_data count_ext[] =3D {
> > 	COUNTER_DATA_DIRECTION(count_direction_read),
> > 	COUNTER_DATA_ENABLE(count_enable_read, count_enable_write),
> > 	COUNTER_DATA_CEILING(count_ceiling_read, count_ceiling_write),
> > };
> >=20
> > This makes it simple to see, add, and modify the attributes that are
> > supported by this driver ("direction", "enable", and "ceiling") and to
> > maintain this code without getting lost in a web of struct braces.
> >=20
> > Callbacks must match the function type expected for the respective
> > component or extension. These function types are defined in the struct
> > counter_data structure as the "*_read" and "*_write" union members.
> >=20
> > The corresponding callback prototypes for the extensions above would be:
> >=20
> > int count_direction_read(struct counter_device *counter,
> > 			 struct counter_count *count, u8 *direction);
> > int count_enable_read(struct counter_device *counter,
> > 		      struct counter_count *count, u8 *enable);
> > int count_enable_write(struct counter_device *counter,
> > 		       struct counter_count *count, u8 enable);
> > int count_ceiling_read(struct counter_device *counter,
> > 		       struct counter_count *count, u64 *ceiling);
> > int count_ceiling_write(struct counter_device *counter,
> > 			struct counter_count *count, u64 ceiling);
> >=20
> > In this way, driver authors no longer need to mess with sysfs strings
> > and are instead able to focus on what they actually care about doing --
> > getting data to/from the devices -- while the Generic Counter interface
> > handles the translation of that data for them between the various
> > userspace interfaces (e.g. sysfs and chardev).
> >=20
> > Architecture
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > Counter device registration is the same as before: drivers populate a
> > struct counter_device with components and callbacks, then pass the
> > structure to the devm_counter_register function. However, what's
> > different now is how the Counter subsystem code handles this
> > registration internally.
> >=20
> > Whereas before callbacks would interact directly with sysfs data, this
> > interaction is now abstracted and instead callbacks interact with native
> > C data types. The counter_data structure forms the basis for Counter
> > extentions.
>=20
> spelling: extensions

Thanks, I'll fix this.

> >=20
> > The counter-sysfs.c file contains the code to parse through the
> > counter_device structure and register the requested components and
> > extensions. Attributes are created and populated based on type, with
> > respective translation functions to handle the mapping between sysfs and
> > the counter driver callbacks.
> >=20
> > The translation performed for each attribute is straightforward: the
> > attribute type and data is parsed from the counter_attribute structure,
> > the respective counter driver read/write callback is called, and sysfs
> > I/O is handled before or after the driver read/write function is called.
> >=20
> > Cc: Syed Nayyar Waris <syednwaris@gmail.com>
> > Cc: Patrick Havelange <patrick.havelange@essensium.com>
> > Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
> > Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
> > Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> > Cc: Alexandre Torgue <alexandre.torgue@st.com>
> > Cc: David Lechner <david@lechnology.com>
> > Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > ---
> >   MAINTAINERS                             |    2 +-
> >   drivers/counter/104-quad-8.c            |  474 +++----
> >   drivers/counter/Makefile                |    1 +
> >   drivers/counter/counter-core.c          |  157 +++
> >   drivers/counter/counter-sysfs.c         |  849 +++++++++++++
> >   drivers/counter/counter-sysfs.h         |   14 +
> >   drivers/counter/counter.c               | 1496 -----------------------
> >   drivers/counter/ftm-quaddec.c           |   59 +-
> >   drivers/counter/microchip-tcb-capture.c |  104 +-
> >   drivers/counter/stm32-lptimer-cnt.c     |  161 +--
> >   drivers/counter/stm32-timer-cnt.c       |  139 +--
> >   drivers/counter/ti-eqep.c               |  211 ++--
> >   include/linux/counter.h                 |  618 ++++------
> >   include/linux/counter_enum.h            |   45 -
> >   include/uapi/linux/counter.h            |   38 +
> >   15 files changed, 1829 insertions(+), 2539 deletions(-)
> >   create mode 100644 drivers/counter/counter-core.c
> >   create mode 100644 drivers/counter/counter-sysfs.c
> >   create mode 100644 drivers/counter/counter-sysfs.h
> >   delete mode 100644 drivers/counter/counter.c
> >   delete mode 100644 include/linux/counter_enum.h
> >   create mode 100644 include/uapi/linux/counter.h
> >=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9077411c9890..a94d8b900c2f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4415,7 +4415,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
> >   F:	Documentation/driver-api/generic-counter.rst
> >   F:	drivers/counter/
> >   F:	include/linux/counter.h
> > -F:	include/linux/counter_enum.h
> > +F:	include/uapi/linux/counter.h
>=20
> Seems odd to be introducing a uapi header here since this patch doesn't
> make any changes to userspace.

These defines are needed by userspace for the character device
interface, but I see your point that at this point in the patchset they
don't need to be exposed yet.

I could create temporary include/linux/counter_types.h to house these
defines, and then later move them to include/uapi/linux/counter.h in the
character device interface introduction patch. Do you think I should do
so?

> >  =20
> >   CPMAC ETHERNET DRIVER
> >   M:	Florian Fainelli <f.fainelli@gmail.com>
> > diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
> > index 78766b6ec271..0f20920073d6 100644
> > --- a/drivers/counter/104-quad-8.c
> > +++ b/drivers/counter/104-quad-8.c
> > @@ -621,7 +621,7 @@ static const struct iio_chan_spec quad8_channels[] =
=3D {
> >   };
> >  =20
> >   static int quad8_signal_read(struct counter_device *counter,
> > -	struct counter_signal *signal, enum counter_signal_value *val)
> > +			     struct counter_signal *signal, u8 *val)
>=20
> I'm not a fan of replacing enum types with u8 everywhere in this patch.
> But if we have to for technical reasons (e.g. causes compiler error if
> we don't) then it would be helpful to add comments giving the enum type
> everywhere like this instance where u8 is actually an enum value.
>=20
> If we use u32 as the generic type for enums instead of u8, I think the
> compiler will happlily let us use enum type and u32 interchangeably and
> not complain.

I switched to fixed-width types after the suggestion by David Laight:
https://lkml.org/lkml/2020/5/3/159. I'll CC David Laight just in case he
wants to chime in again.

Enum types would be nice for making the valid values explicit, but there
is one benefit I have appreciated from the move to fixed-width types:
there has been a significant reduction of duplicate code; before, we had
a different read function for each different enum type, but now we use a
single function to handle them all.

> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	unsigned int state;
> > @@ -639,7 +639,7 @@ static int quad8_signal_read(struct counter_device =
*counter,
> >   }
> >  =20
> >   static int quad8_count_read(struct counter_device *counter,
> > -	struct counter_count *count, unsigned long *val)
> > +			    struct counter_count *count, u64 *val)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int base_offset =3D priv->base + 2 * count->id;
> > @@ -670,7 +670,7 @@ static int quad8_count_read(struct counter_device *=
counter,
> >   }
> >  =20
> >   static int quad8_count_write(struct counter_device *counter,
> > -	struct counter_count *count, unsigned long val)
> > +			     struct counter_count *count, u64 val)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int base_offset =3D priv->base + 2 * count->id;
> > @@ -710,22 +710,16 @@ static int quad8_count_write(struct counter_devic=
e *counter,
> >   	return 0;
> >   }
> >  =20
> > -enum quad8_count_function {
> > -	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION =3D 0,
> > -	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
> > -	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
> > -	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
> > -};
> >  =20
> > -static enum counter_count_function quad8_count_functions_list[] =3D {
> > -	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] =3D COUNTER_COUNT_FUNCTION_PUL=
SE_DIRECTION,
> > -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] =3D COUNTER_COUNT_FUNCTION_QUADR=
ATURE_X1_A,
> > -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] =3D COUNTER_COUNT_FUNCTION_QUADR=
ATURE_X2_A,
> > -	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] =3D COUNTER_COUNT_FUNCTION_QUADR=
ATURE_X4
> > +static const u8 quad8_count_functions_list[] =3D {
> > +	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> > +	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> > +	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> > +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> >   };
> >  =20
> > -static int quad8_function_get(struct counter_device *counter,
> > -	struct counter_count *count, size_t *function)
> > +static int quad8_function_read(struct counter_device *counter,
> > +			       struct counter_count *count, u8 *function)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int id =3D count->id;
> > @@ -735,25 +729,25 @@ static int quad8_function_get(struct counter_devi=
ce *counter,
> >   	if (priv->quadrature_mode[id])
> >   		switch (priv->quadrature_scale[id]) {
> >   		case 0:
> > -			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
> > +			*function =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A;
> >   			break;
> >   		case 1:
> > -			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
> > +			*function =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A;
> >   			break;
> >   		case 2:
> > -			*function =3D QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
> > +			*function =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
> >   			break;
> >   		}
> >   	else
> > -		*function =3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
> > +		*function =3D COUNTER_COUNT_FUNCTION_PULSE_DIRECTION;
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static int quad8_function_set(struct counter_device *counter,
> > -	struct counter_count *count, size_t function)
> > +static int quad8_function_write(struct counter_device *counter,
> > +				struct counter_count *count, u8 function)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int id =3D count->id;
> > @@ -769,7 +763,7 @@ static int quad8_function_set(struct counter_device=
 *counter,
> >   	mode_cfg =3D priv->count_mode[id] << 1;
> >   	idr_cfg =3D priv->index_polarity[id] << 1;
> >  =20
> > -	if (function =3D=3D QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
> > +	if (function =3D=3D COUNTER_COUNT_FUNCTION_PULSE_DIRECTION) {
> >   		*quadrature_mode =3D 0;
> >  =20
> >   		/* Quadrature scaling only available in quadrature mode */
> > @@ -785,15 +779,15 @@ static int quad8_function_set(struct counter_devi=
ce *counter,
> >   		*quadrature_mode =3D 1;
> >  =20
> >   		switch (function) {
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> > +		case COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A:
> >   			*scale =3D 0;
> >   			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X1;
> >   			break;
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> > +		case COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A:
> >   			*scale =3D 1;
> >   			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X2;
> >   			break;
> > -		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> > +		case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
> >   			*scale =3D 2;
> >   			mode_cfg |=3D QUAD8_CMR_QUADRATURE_X4;
> >   			break;
> > @@ -808,8 +802,8 @@ static int quad8_function_set(struct counter_device=
 *counter,
> >   	return 0;
> >   }
> >  =20
> > -static void quad8_direction_get(struct counter_device *counter,
> > -	struct counter_count *count, enum counter_count_direction *direction)
> > +static int quad8_direction_read(struct counter_device *counter,
> > +				struct counter_count *count, u8 *direction)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	unsigned int ud_flag;
> > @@ -820,93 +814,82 @@ static void quad8_direction_get(struct counter_de=
vice *counter,
> >  =20
> >   	*direction =3D (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
> >   		COUNTER_COUNT_DIRECTION_BACKWARD;
> > -}
> >  =20
> > -enum quad8_synapse_action {
> > -	QUAD8_SYNAPSE_ACTION_NONE =3D 0,
> > -	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
> > -	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
> > -	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
> > -};
> > +	return 0;
> > +}
> >  =20
> > -static enum counter_synapse_action quad8_index_actions_list[] =3D {
> > -	[QUAD8_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> > -	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RISING_=
EDGE
> > +static const u8 quad8_index_actions_list[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> >   };
> >  =20
> > -static enum counter_synapse_action quad8_synapse_actions_list[] =3D {
> > -	[QUAD8_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> > -	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RISING_=
EDGE,
> > -	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_FALLIN=
G_EDGE,
> > -	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_BOTH_EDG=
ES
> > +static const u8 quad8_synapse_actions_list[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> >   };
> >  =20
> > -static int quad8_action_get(struct counter_device *counter,
> > -	struct counter_count *count, struct counter_synapse *synapse,
> > -	size_t *action)
> > +static int quad8_action_read(struct counter_device *counter,
> > +			     struct counter_count *count,
> > +			     struct counter_synapse *synapse, u8 *action)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	int err;
> > -	size_t function =3D 0;
> > +	u8 function;
> >   	const size_t signal_a_id =3D count->synapses[0].signal->id;
> > -	enum counter_count_direction direction;
> > +	u8 direction;
> >  =20
> >   	/* Handle Index signals */
> >   	if (synapse->signal->id >=3D 16) {
> >   		if (priv->preset_enable[count->id])
> > -			*action =3D QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   		else
> > -			*action =3D QUAD8_SYNAPSE_ACTION_NONE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >  =20
> >   		return 0;
> >   	}
> >  =20
> > -	err =3D quad8_function_get(counter, count, &function);
> > +	err =3D quad8_function_read(counter, count, &function);
> >   	if (err)
> >   		return err;
> >  =20
> >   	/* Default action mode */
> > -	*action =3D QUAD8_SYNAPSE_ACTION_NONE;
> > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >  =20
> >   	/* Determine action mode based on current count function mode */
> >   	switch (function) {
> > -	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
> > +	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
> >   		if (synapse->signal->id =3D=3D signal_a_id)
> > -			*action =3D QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   		break;
> > -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A:
> >   		if (synapse->signal->id =3D=3D signal_a_id) {
> > -			quad8_direction_get(counter, count, &direction);
> > +			err =3D quad8_direction_read(counter, count, &direction);
> > +			if (err)
> > +				return err;
> >  =20
> >   			if (direction =3D=3D COUNTER_COUNT_DIRECTION_FORWARD)
> > -				*action =3D QUAD8_SYNAPSE_ACTION_RISING_EDGE;
> > +				*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   			else
> > -				*action =3D QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
> > +				*action =3D COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> >   		}
> >   		break;
> > -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A:
> >   		if (synapse->signal->id =3D=3D signal_a_id)
> > -			*action =3D QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> > -	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
> > -		*action =3D QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> >   	}
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static const struct counter_ops quad8_ops =3D {
> > -	.signal_read =3D quad8_signal_read,
> > -	.count_read =3D quad8_count_read,
> > -	.count_write =3D quad8_count_write,
> > -	.function_get =3D quad8_function_get,
> > -	.function_set =3D quad8_function_set,
> > -	.action_get =3D quad8_action_get
> > -};
> > -
> >   static int quad8_index_polarity_get(struct counter_device *counter,
> > -	struct counter_signal *signal, size_t *index_polarity)
> > +				    struct counter_signal *signal,
> > +				    u8 *index_polarity)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id - 16;
> > @@ -917,20 +900,20 @@ static int quad8_index_polarity_get(struct counte=
r_device *counter,
> >   }
> >  =20
> >   static int quad8_index_polarity_set(struct counter_device *counter,
> > -	struct counter_signal *signal, size_t index_polarity)
> > +				    struct counter_signal *signal,
> > +				    u8 index_polarity)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id - 16;
> >   	const int base_offset =3D priv->base + 2 * channel_id + 1;
> > -	unsigned int idr_cfg =3D index_polarity << 1;
> > +	unsigned int idr_cfg;
> >  =20
> >   	mutex_lock(&priv->lock);
> >  =20
> > -	idr_cfg |=3D priv->synchronous_mode[channel_id];
> > -
> >   	priv->index_polarity[channel_id] =3D index_polarity;
> >  =20
> >   	/* Load Index Control configuration to Index Control Register */
> > +	idr_cfg =3D priv->synchronous_mode[channel_id] | index_polarity << 1;
>=20
> This change seems unrelated to the

Good eye! Looks like I mistakenly squashed an unrelated (and obsolete)
bug fix here. I'll fix this.

> >   	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> >  =20
> >   	mutex_unlock(&priv->lock);
> > @@ -938,15 +921,9 @@ static int quad8_index_polarity_set(struct counter=
_device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static struct counter_signal_enum_ext quad8_index_pol_enum =3D {
> > -	.items =3D quad8_index_polarity_modes,
> > -	.num_items =3D ARRAY_SIZE(quad8_index_polarity_modes),
> > -	.get =3D quad8_index_polarity_get,
> > -	.set =3D quad8_index_polarity_set
> > -};
> > -
> >   static int quad8_synchronous_mode_get(struct counter_device *counter,
> > -	struct counter_signal *signal, size_t *synchronous_mode)
> > +				      struct counter_signal *signal,
> > +				      u8 *synchronous_mode)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id - 16;
> > @@ -957,17 +934,16 @@ static int quad8_synchronous_mode_get(struct coun=
ter_device *counter,
> >   }
> >  =20
> >   static int quad8_synchronous_mode_set(struct counter_device *counter,
> > -	struct counter_signal *signal, size_t synchronous_mode)
> > +				      struct counter_signal *signal,
> > +				      u8 synchronous_mode)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id - 16;
> >   	const int base_offset =3D priv->base + 2 * channel_id + 1;
> > -	unsigned int idr_cfg =3D synchronous_mode;
> > +	unsigned int idr_cfg;
> >  =20
> >   	mutex_lock(&priv->lock);
> >  =20
> > -	idr_cfg |=3D priv->index_polarity[channel_id] << 1;
> > -
> >   	/* Index function must be non-synchronous in non-quadrature mode */
> >   	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
> >   		mutex_unlock(&priv->lock);
> > @@ -977,6 +953,7 @@ static int quad8_synchronous_mode_set(struct counte=
r_device *counter,
> >   	priv->synchronous_mode[channel_id] =3D synchronous_mode;
> >  =20
> >   	/* Load Index Control configuration to Index Control Register */
> > +	idr_cfg =3D synchronous_mode | priv->index_polarity[channel_id] << 1;
> >   	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
> >  =20
> >   	mutex_unlock(&priv->lock);
> > @@ -984,22 +961,17 @@ static int quad8_synchronous_mode_set(struct coun=
ter_device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static struct counter_signal_enum_ext quad8_syn_mode_enum =3D {
> > -	.items =3D quad8_synchronous_modes,
> > -	.num_items =3D ARRAY_SIZE(quad8_synchronous_modes),
> > -	.get =3D quad8_synchronous_mode_get,
> > -	.set =3D quad8_synchronous_mode_set
> > -};
> > -
> > -static ssize_t quad8_count_floor_read(struct counter_device *counter,
> > -	struct counter_count *count, void *private, char *buf)
> > +static int quad8_count_floor_read(struct counter_device *counter,
> > +				  struct counter_count *count, u64 *floor)
> >   {
> >   	/* Only a floor of 0 is supported */
> > -	return sprintf(buf, "0\n");
> > +	*floor =3D 0;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static int quad8_count_mode_get(struct counter_device *counter,
> > -	struct counter_count *count, size_t *cnt_mode)
> > +static int quad8_count_mode_read(struct counter_device *counter,
> > +				 struct counter_count *count, u8 *cnt_mode)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >  =20
> > @@ -1022,35 +994,36 @@ static int quad8_count_mode_get(struct counter_d=
evice *counter,
> >   	return 0;
> >   }
> >  =20
> > -static int quad8_count_mode_set(struct counter_device *counter,
> > -	struct counter_count *count, size_t cnt_mode)
> > +static int quad8_count_mode_write(struct counter_device *counter,
> > +				  struct counter_count *count, u8 cnt_mode)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> > +	unsigned int count_mode;
> >   	unsigned int mode_cfg;
> >   	const int base_offset =3D priv->base + 2 * count->id + 1;
> >  =20
> >   	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
> >   	switch (cnt_mode) {
> >   	case COUNTER_COUNT_MODE_NORMAL:
> > -		cnt_mode =3D 0;
> > +		count_mode =3D 0;
> >   		break;
> >   	case COUNTER_COUNT_MODE_RANGE_LIMIT:
> > -		cnt_mode =3D 1;
> > +		count_mode =3D 1;
> >   		break;
> >   	case COUNTER_COUNT_MODE_NON_RECYCLE:
> > -		cnt_mode =3D 2;
> > +		count_mode =3D 2;
> >   		break;
> >   	case COUNTER_COUNT_MODE_MODULO_N:
> > -		cnt_mode =3D 3;
> > +		count_mode =3D 3;
> >   		break;
> >   	}
> >  =20
> >   	mutex_lock(&priv->lock);
> >  =20
> > -	priv->count_mode[count->id] =3D cnt_mode;
> > +	priv->count_mode[count->id] =3D count_mode;
> >  =20
> >   	/* Set count mode configuration value */
> > -	mode_cfg =3D cnt_mode << 1;
> > +	mode_cfg =3D count_mode << 1;
> >  =20
> >   	/* Add quadrature mode configuration */
> >   	if (priv->quadrature_mode[count->id])
> > @@ -1064,60 +1037,39 @@ static int quad8_count_mode_set(struct counter_=
device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static struct counter_count_enum_ext quad8_cnt_mode_enum =3D {
> > -	.items =3D counter_count_mode_str,
> > -	.num_items =3D ARRAY_SIZE(counter_count_mode_str),
> > -	.get =3D quad8_count_mode_get,
> > -	.set =3D quad8_count_mode_set
> > -};
> > -
> > -static ssize_t quad8_count_direction_read(struct counter_device *count=
er,
> > -	struct counter_count *count, void *priv, char *buf)
> > -{
> > -	enum counter_count_direction dir;
> > -
> > -	quad8_direction_get(counter, count, &dir);
> > -
> > -	return sprintf(buf, "%s\n", counter_count_direction_str[dir]);
> > -}
> > -
> > -static ssize_t quad8_count_enable_read(struct counter_device *counter,
> > -	struct counter_count *count, void *private, char *buf)
> > +static int quad8_count_enable_read(struct counter_device *counter,
> > +				   struct counter_count *count, u8 *enable)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >  =20
> > -	return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
> > +	*enable =3D priv->ab_enable[count->id];
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_count_enable_write(struct counter_device *counter,
> > -	struct counter_count *count, void *private, const char *buf, size_t l=
en)
> > +static int quad8_count_enable_write(struct counter_device *counter,
> > +				    struct counter_count *count, u8 enable)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int base_offset =3D priv->base + 2 * count->id;
> > -	int err;
> > -	bool ab_enable;
> >   	unsigned int ior_cfg;
> >  =20
> > -	err =3D kstrtobool(buf, &ab_enable);
> > -	if (err)
> > -		return err;
> > -
> >   	mutex_lock(&priv->lock);
> >  =20
> > -	priv->ab_enable[count->id] =3D ab_enable;
> > +	priv->ab_enable[count->id] =3D enable;
> >  =20
> > -	ior_cfg =3D ab_enable | priv->preset_enable[count->id] << 1;
> > +	ior_cfg =3D enable | priv->preset_enable[count->id] << 1;
> >  =20
> >   	/* Load I/O control configuration */
> >   	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> >   static int quad8_error_noise_get(struct counter_device *counter,
> > -	struct counter_count *count, size_t *noise_error)
> > +				 struct counter_count *count, u8 *noise_error)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	const int base_offset =3D priv->base + 2 * count->id + 1;
> > @@ -1127,22 +1079,18 @@ static int quad8_error_noise_get(struct counter=
_device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static struct counter_count_enum_ext quad8_error_noise_enum =3D {
> > -	.items =3D quad8_noise_error_states,
> > -	.num_items =3D ARRAY_SIZE(quad8_noise_error_states),
> > -	.get =3D quad8_error_noise_get
> > -};
> > -
> > -static ssize_t quad8_count_preset_read(struct counter_device *counter,
> > -	struct counter_count *count, void *private, char *buf)
> > +static int quad8_count_preset_read(struct counter_device *counter,
> > +				   struct counter_count *count, u64 *preset)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >  =20
> > -	return sprintf(buf, "%u\n", priv->preset[count->id]);
> > +	*preset =3D priv->preset[count->id];
> > +
> > +	return 0;
> >   }
> >  =20
> > -static void quad8_preset_register_set(struct quad8_iio *quad8iio, int =
id,
> > -		unsigned int preset)
> > +static void quad8_preset_register_set(struct quad8_iio *const quad8iio,
> > +				      const int id, const u64 preset)
>=20
> Why using const on value types here? This isn't really done much in the
> kernel.

Over the course of this patchset develop, these value types ocassionally
became pointer types (and vice versa) and other such changes in the
callback interface. These const qualifiers help me make sure I'm not
mistakening trying to set these values, and other similar common errors.

Since this is a static function that won't be exposed to the rest of the
kernel, I don't see much harm in leaving these qualified as const in
this driver. Although, if others do see these qualifiers as too
confusing, then I'll remove them for the sake of readability.

> >   {
> >   	const unsigned int base_offset =3D quad8iio->base + 2 * id;
> >   	int i;
> > @@ -1157,16 +1105,10 @@ static void quad8_preset_register_set(struct qu=
ad8_iio *quad8iio, int id,
> >   		outb(preset >> (8 * i), base_offset);
> >   }
> >  =20
> > -static ssize_t quad8_count_preset_write(struct counter_device *counter,
> > -	struct counter_count *count, void *private, const char *buf, size_t l=
en)
> > +static int quad8_count_preset_write(struct counter_device *counter,
> > +				    struct counter_count *count, u64 preset)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> > -	unsigned int preset;
> > -	int ret;
> > -
> > -	ret =3D kstrtouint(buf, 0, &preset);
> > -	if (ret)
> > -		return ret;
> >  =20
> >   	/* Only 24-bit values are supported */
> >   	if (preset > 0xFFFFFF)
> > @@ -1178,11 +1120,11 @@ static ssize_t quad8_count_preset_write(struct =
counter_device *counter,
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
> > -	struct counter_count *count, void *private, char *buf)
> > +static int quad8_count_ceiling_read(struct counter_device *counter,
> > +				    struct counter_count *count, u64 *ceiling)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >  =20
> > @@ -1193,25 +1135,21 @@ static ssize_t quad8_count_ceiling_read(struct =
counter_device *counter,
> >   	case 1:
> >   	case 3:
> >   		mutex_unlock(&priv->lock);
> > -		return sprintf(buf, "%u\n", priv->preset[count->id]);
> > +		return quad8_count_preset_read(counter, count, ceiling);
> >   	}
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> >   	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
> > -	return sprintf(buf, "33554431\n");
> > +	*ceiling =3D 0x1FFFFFF;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_count_ceiling_write(struct counter_device *counte=
r,
> > -	struct counter_count *count, void *private, const char *buf, size_t l=
en)
> > +static int quad8_count_ceiling_write(struct counter_device *counter,
> > +				     struct counter_count *count, u64 ceiling)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> > -	unsigned int ceiling;
> > -	int ret;
> > -
> > -	ret =3D kstrtouint(buf, 0, &ceiling);
> > -	if (ret)
> > -		return ret;
> >  =20
> >   	/* Only 24-bit values are supported */
> >   	if (ceiling > 0xFFFFFF)
> > @@ -1223,36 +1161,33 @@ static ssize_t quad8_count_ceiling_write(struct=
 counter_device *counter,
> >   	switch (priv->count_mode[count->id]) {
> >   	case 1:
> >   	case 3:
> > -		quad8_preset_register_set(priv, count->id, ceiling);
> > -		break;
>=20
> Does this release the mutex lock?

The mutex code was merged in after the development of this code, so I
missed this error. Thanks, I fix this.

> > +		return quad8_count_preset_write(counter, count, ceiling);
> >   	}
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return -EINVAL;
> >   }
> >  =20
> > -static ssize_t quad8_count_preset_enable_read(struct counter_device *c=
ounter,
> > -	struct counter_count *count, void *private, char *buf)
> > +static int quad8_count_preset_enable_read(struct counter_device *count=
er,
> > +					  struct counter_count *count,
> > +					  u8 *preset_enable)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >  =20
> > -	return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
> > +	*preset_enable =3D !priv->preset_enable[count->id];
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_count_preset_enable_write(struct counter_device *=
counter,
> > -	struct counter_count *count, void *private, const char *buf, size_t l=
en)
> > +static int quad8_count_preset_enable_write(struct counter_device *coun=
ter,
> > +					   struct counter_count *count,
> > +					   u8 preset_enable)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const int base_offset =3D priv->base + 2 * count->id + 1;
> > -	bool preset_enable;
> > -	int ret;
> >   	unsigned int ior_cfg;
> >  =20
> > -	ret =3D kstrtobool(buf, &preset_enable);
> > -	if (ret)
> > -		return ret;
> > -
> >   	/* Preset enable is active low in Input/Output Control register */
> >   	preset_enable =3D !preset_enable;
> >  =20
> > @@ -1260,25 +1195,24 @@ static ssize_t quad8_count_preset_enable_write(=
struct counter_device *counter,
> >  =20
> >   	priv->preset_enable[count->id] =3D preset_enable;
> >  =20
> > -	ior_cfg =3D priv->ab_enable[count->id] | (unsigned int)preset_enable =
<< 1;
> > +	ior_cfg =3D priv->ab_enable[count->id] | preset_enable << 1;
> >  =20
> >   	/* Load I/O control configuration to Input / Output Control Register=
 */
> >   	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_signal_cable_fault_read(struct counter_device *co=
unter,
> > -					     struct counter_signal *signal,
> > -					     void *private, char *buf)
> > +static int quad8_signal_cable_fault_read(struct counter_device *counte=
r,
> > +					 struct counter_signal *signal,
> > +					 u8 *cable_fault)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id / 2;
> >   	bool disabled;
> >   	unsigned int status;
> > -	unsigned int fault;
> >  =20
> >   	mutex_lock(&priv->lock);
> >  =20
> > @@ -1295,36 +1229,31 @@ static ssize_t quad8_signal_cable_fault_read(st=
ruct counter_device *counter,
> >   	mutex_unlock(&priv->lock);
> >  =20
> >   	/* Mask respective channel and invert logic */
> > -	fault =3D !(status & BIT(channel_id));
> > +	*cable_fault =3D !(status & BIT(channel_id));
> >  =20
> > -	return sprintf(buf, "%u\n", fault);
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_signal_cable_fault_enable_read(
> > -	struct counter_device *counter, struct counter_signal *signal,
> > -	void *private, char *buf)
> > +static int quad8_signal_cable_fault_enable_read(struct counter_device =
*counter,
> > +						struct counter_signal *signal,
> > +						u8 *enable)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id / 2;
> > -	const unsigned int enb =3D !!(priv->cable_fault_enable & BIT(channel_=
id));
> >  =20
> > -	return sprintf(buf, "%u\n", enb);
> > +	*enable =3D !!(priv->cable_fault_enable & BIT(channel_id));
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_signal_cable_fault_enable_write(
> > -	struct counter_device *counter, struct counter_signal *signal,
> > -	void *private, const char *buf, size_t len)
> > +static int quad8_signal_cable_fault_enable_write(struct counter_device=
 *counter,
> > +						 struct counter_signal *signal,
> > +						 u8 enable)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id / 2;
> > -	bool enable;
> > -	int ret;
> >   	unsigned int cable_fault_enable;
> >  =20
> > -	ret =3D kstrtobool(buf, &enable);
> > -	if (ret)
> > -		return ret;
> > -
> >   	mutex_lock(&priv->lock);
> >  =20
> >   	if (enable)
> > @@ -1339,31 +1268,27 @@ static ssize_t quad8_signal_cable_fault_enable_=
write(
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *=
counter,
> > -	struct counter_signal *signal, void *private, char *buf)
> > +static int quad8_signal_fck_prescaler_read(struct counter_device *coun=
ter,
> > +					   struct counter_signal *signal,
> > +					   u8 *prescaler)
> >   {
> >   	const struct quad8_iio *const priv =3D counter->priv;
> > -	const size_t channel_id =3D signal->id / 2;
> >  =20
> > -	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
> > +	*prescaler =3D priv->fck_prescaler[signal->id / 2];
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t quad8_signal_fck_prescaler_write(struct counter_device =
*counter,
> > -	struct counter_signal *signal, void *private, const char *buf,
> > -	size_t len)
> > +static int quad8_signal_fck_prescaler_write(struct counter_device *cou=
nter,
> > +					    struct counter_signal *signal,
> > +					    u8 prescaler)
> >   {
> >   	struct quad8_iio *const priv =3D counter->priv;
> >   	const size_t channel_id =3D signal->id / 2;
> >   	const int base_offset =3D priv->base + 2 * channel_id;
> > -	u8 prescaler;
> > -	int ret;
> > -
> > -	ret =3D kstrtou8(buf, 0, &prescaler);
> > -	if (ret)
> > -		return ret;
> >  =20
> >   	mutex_lock(&priv->lock);
> >  =20
> > @@ -1379,31 +1304,30 @@ static ssize_t quad8_signal_fck_prescaler_write=
(struct counter_device *counter,
> >  =20
> >   	mutex_unlock(&priv->lock);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static const struct counter_signal_ext quad8_signal_ext[] =3D {
> > -	{
> > -		.name =3D "cable_fault",
> > -		.read =3D quad8_signal_cable_fault_read
> > -	},
> > -	{
> > -		.name =3D "cable_fault_enable",
> > -		.read =3D quad8_signal_cable_fault_enable_read,
> > -		.write =3D quad8_signal_cable_fault_enable_write
> > -	},
> > -	{
> > -		.name =3D "filter_clock_prescaler",
> > -		.read =3D quad8_signal_fck_prescaler_read,
> > -		.write =3D quad8_signal_fck_prescaler_write
> > -	}
> > +static struct counter_data quad8_signal_ext[] =3D {
> > +	COUNTER_DATA_SIGNAL_BOOL("cable_fault", quad8_signal_cable_fault_read,
> > +				 NULL),
> > +	COUNTER_DATA_SIGNAL_BOOL("cable_fault_enable",
> > +				 quad8_signal_cable_fault_enable_read,
> > +				 quad8_signal_cable_fault_enable_write),
> > +	COUNTER_DATA_SIGNAL_U8("filter_clock_prescaler",
> > +			       quad8_signal_fck_prescaler_read,
> > +			       quad8_signal_fck_prescaler_write)
> >   };
> >  =20
> > -static const struct counter_signal_ext quad8_index_ext[] =3D {
> > -	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
> > -	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum=
),
> > -	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
> > -	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enu=
m)
> > +static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_=
modes);
> > +static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_mo=
des);
> > +
> > +static struct counter_data quad8_index_ext[] =3D {
> > +	COUNTER_DATA_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
> > +				 quad8_index_polarity_set,
> > +				 quad8_index_pol_enum),
> > +	COUNTER_DATA_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_g=
et,
> > +				 quad8_synchronous_mode_set,
> > +				 quad8_synch_mode_enum),
> >   };
> >  =20
> >   #define QUAD8_QUAD_SIGNAL(_id, _name) {		\
> > @@ -1472,39 +1396,30 @@ static struct counter_synapse quad8_count_synap=
ses[][3] =3D {
> >   	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
> >   };
> >  =20
> > -static const struct counter_count_ext quad8_count_ext[] =3D {
> > -	{
> > -		.name =3D "ceiling",
> > -		.read =3D quad8_count_ceiling_read,
> > -		.write =3D quad8_count_ceiling_write
> > -	},
> > -	{
> > -		.name =3D "floor",
> > -		.read =3D quad8_count_floor_read
> > -	},
> > -	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
> > -	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
> > -	{
> > -		.name =3D "direction",
> > -		.read =3D quad8_count_direction_read
> > -	},
> > -	{
> > -		.name =3D "enable",
> > -		.read =3D quad8_count_enable_read,
> > -		.write =3D quad8_count_enable_write
> > -	},
> > -	COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
> > -	COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_enum),
> > -	{
> > -		.name =3D "preset",
> > -		.read =3D quad8_count_preset_read,
> > -		.write =3D quad8_count_preset_write
> > -	},
> > -	{
> > -		.name =3D "preset_enable",
> > -		.read =3D quad8_count_preset_enable_read,
> > -		.write =3D quad8_count_preset_enable_write
> > -	}
> > +static const u8 quad8_cnt_modes[] =3D {
> > +	COUNTER_COUNT_MODE_NORMAL,
> > +	COUNTER_COUNT_MODE_RANGE_LIMIT,
> > +	COUNTER_COUNT_MODE_NON_RECYCLE,
> > +	COUNTER_COUNT_MODE_MODULO_N,
> > +};
> > +
> > +static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_=
modes);
> > +
> > +static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_s=
tates);
> > +
> > +static struct counter_data quad8_count_ext[] =3D {
> > +	COUNTER_DATA_CEILING(quad8_count_ceiling_read,
> > +			     quad8_count_ceiling_write),
> > +	COUNTER_DATA_FLOOR(quad8_count_floor_read, NULL),
> > +	COUNTER_DATA_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_write,
> > +				quad8_count_mode_available),
> > +	COUNTER_DATA_DIRECTION(quad8_direction_read),
> > +	COUNTER_DATA_ENABLE(quad8_count_enable_read, quad8_count_enable_write=
),
> > +	COUNTER_DATA_COUNT_ENUM("error_noise", quad8_error_noise_get, NULL,
> > +				quad8_error_noise_enum),
> > +	COUNTER_DATA_PRESET(quad8_count_preset_read, quad8_count_preset_write=
),
> > +	COUNTER_DATA_PRESET_ENABLE(quad8_count_preset_enable_read,
> > +				   quad8_count_preset_enable_write),
> >   };
> >  =20
> >   #define QUAD8_COUNT(_id, _cntname) {					\
> > @@ -1559,7 +1474,12 @@ static int quad8_probe(struct device *dev, unsig=
ned int id)
> >   	quad8iio =3D iio_priv(indio_dev);
> >   	quad8iio->counter.name =3D dev_name(dev);
> >   	quad8iio->counter.parent =3D dev;
> > -	quad8iio->counter.ops =3D &quad8_ops;
> > +	quad8iio->counter.signal_read =3D quad8_signal_read;
> > +	quad8iio->counter.count_read =3D quad8_count_read;
> > +	quad8iio->counter.count_write =3D quad8_count_write;
> > +	quad8iio->counter.function_read =3D quad8_function_read;
> > +	quad8iio->counter.function_write =3D quad8_function_write;
> > +	quad8iio->counter.action_read =3D quad8_action_read;
> >   	quad8iio->counter.counts =3D quad8_counts;
> >   	quad8iio->counter.num_counts =3D ARRAY_SIZE(quad8_counts);
> >   	quad8iio->counter.signals =3D quad8_signals;
> > diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
> > index 0a393f71e481..cbe1d06af6a9 100644
> > --- a/drivers/counter/Makefile
> > +++ b/drivers/counter/Makefile
> > @@ -4,6 +4,7 @@
> >   #
> >  =20
> >   obj-$(CONFIG_COUNTER) +=3D counter.o
> > +counter-y :=3D counter-core.o counter-sysfs.o
> >  =20
> >   obj-$(CONFIG_104_QUAD_8)	+=3D 104-quad-8.o
> >   obj-$(CONFIG_STM32_TIMER_CNT)	+=3D stm32-timer-cnt.o
> > diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-c=
ore.c
> > new file mode 100644
> > index 000000000000..499664809c75
> > --- /dev/null
> > +++ b/drivers/counter/counter-core.c
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Generic Counter interface
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#include <linux/counter.h>
> > +#include <linux/device.h>
> > +#include <linux/export.h>
> > +#include <linux/gfp.h>
> > +#include <linux/idr.h>
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +
> > +#include "counter-sysfs.h"
> > +
> > +/* Provides a unique ID for each counter device */
> > +static DEFINE_IDA(counter_ida);
> > +
> > +static void counter_device_release(struct device *dev)
> > +{
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +
> > +	counter_sysfs_free(counter);
> > +	ida_simple_remove(&counter_ida, counter->id);
> > +}
> > +
> > +static struct device_type counter_device_type =3D {
> > +	.name =3D "counter_device",
> > +	.release =3D counter_device_release
> > +};
> > +
> > +static struct bus_type counter_bus_type =3D {
> > +	.name =3D "counter"
> > +};
> > +
> > +/**
> > + * counter_register - register Counter to the system
> > + * @counter:	pointer to Counter to register
> > + *
> > + * This function registers a Counter to the system. A sysfs "counter" =
directory
> > + * will be created and populated with sysfs attributes correlating wit=
h the
> > + * Counter Signals, Synapses, and Counts respectively.
> > + */
> > +int counter_register(struct counter_device *const counter)
> > +{
> > +	struct device *const dev =3D &counter->dev;
> > +	int err;
> > +
> > +	/* Acquire unique ID */
> > +	counter->id =3D ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> > +	if (counter->id < 0)
> > +		return counter->id;
> > +
> > +	/* Configure device structure for Counter */
> > +	dev->type =3D &counter_device_type;
> > +	dev->bus =3D &counter_bus_type;
> > +	if (counter->parent) {
> > +		dev->parent =3D counter->parent;
> > +		dev->of_node =3D counter->parent->of_node;
> > +	}
> > +	dev_set_name(dev, "counter%d", counter->id);
> > +	device_initialize(dev);
> > +	dev_set_drvdata(dev, counter);
> > +
> > +	/* Add Counter sysfs attributes */
> > +	err =3D counter_sysfs_add(counter);
> > +	if (err)
> > +		goto err_free_id;
> > +
> > +	/* Add device to system */
> > +	err =3D device_add(dev);
> > +	if (err)
> > +		goto err_free_sysfs;
> > +
> > +	return 0;
> > +
> > +err_free_sysfs:
> > +	counter_sysfs_free(counter);
> > +err_free_id:
> > +	ida_simple_remove(&counter_ida, counter->id);
> > +	return err;
> > +}
> > +EXPORT_SYMBOL_GPL(counter_register);
> > +
> > +/**
> > + * counter_unregister - unregister Counter from the system
> > + * @counter:	pointer to Counter to unregister
> > + *
> > + * The Counter is unregistered from the system; all allocated memory i=
s freed.
> > + */
> > +void counter_unregister(struct counter_device *const counter)
> > +{
> > +	if (counter) {
>=20
> Might be nicer to say:
>=20
> 	if (!counter)
> 		return;
>=20
> Instead of indenting normal code flow.

Good idea, I'll do that instead.

> > +		device_del(&counter->dev);
> > +		counter_sysfs_free(counter);
>=20
> Should sysfs be freed before deleting device? I think sysfs might be
> using dev still.

I think it's the other way around isn't it? The Counter sysfs memory
should stay alive for the lifetime of the device. Once the device is
deleted, there's nothing left to access those struct attributes, so that
memory can now be freed. Correct me if my reasoning is wrong here.

> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(counter_unregister);
> > +
> > +static void devm_counter_unreg(struct device *dev, void *res)
> > +{
> > +	counter_unregister(*(struct counter_device **)res);
> > +}
> > +
> > +/**
> > + * devm_counter_register - Resource-managed counter_register
> > + * @dev:	device to allocate counter_device for
> > + * @counter:	pointer to Counter to register
> > + *
> > + * Managed counter_register. The Counter registered with this function=
 is
> > + * automatically unregistered on driver detach. This function calls
> > + * counter_register internally. Refer to that function for more inform=
ation.
> > + *
> > + * If an Counter registered with this function needs to be unregistered
> > + * separately, devm_counter_unregister must be used.
> > + *
> > + * RETURNS:
> > + * 0 on success, negative error number on failure.
> > + */
> > +int devm_counter_register(struct device *dev,
> > +			  struct counter_device *const counter)
> > +{
> > +	struct counter_device **ptr;
> > +	int ret;
> > +
> > +	ptr =3D devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
> > +	if (!ptr)
> > +		return -ENOMEM;
> > +
> > +	ret =3D counter_register(counter);
> > +	if (!ret) {
> > +		*ptr =3D counter;
> > +		devres_add(dev, ptr);
> > +	} else {
> > +		devres_free(ptr);
> > +	}
> > +
> > +	return ret;
>=20
> A bit easier to follow the flow this way:
>=20
> 	if (ret) {
> 		devres_free(ptr);
> 		return ret;
> 	}
>=20
> 	*ptr =3D counter;
> 	devres_add(dev, ptr);
>=20
> 	return 0;

Agreed, I'll make this change.

> > +}
> > +EXPORT_SYMBOL_GPL(devm_counter_register);
> > +
> > +static int __init counter_init(void)
> > +{
> > +	return bus_register(&counter_bus_type);
> > +}
> > +
> > +static void __exit counter_exit(void)
> > +{
> > +	bus_unregister(&counter_bus_type);
> > +}
> > +
> > +subsys_initcall(counter_init);
> > +module_exit(counter_exit);
> > +
> > +MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> > +MODULE_DESCRIPTION("Generic Counter interface");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-=
sysfs.c
> > new file mode 100644
> > index 000000000000..dd9cd9ce8dd9
> > --- /dev/null
> > +++ b/drivers/counter/counter-sysfs.c
> > @@ -0,0 +1,849 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Generic Counter sysfs interface
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#include <linux/counter.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/gfp.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> > +#include <linux/slab.h>
> > +#include <linux/string.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/types.h>
> > +
> > +#include "counter-sysfs.h"
> > +
>=20
> Comments describing the fields would be helpful.

Okay, I'll add some documentation for this structure.

> > +struct counter_attribute {
> > +	struct device_attribute dev_attr;
> > +	struct list_head l;
> > +
> > +	struct counter_data data;
> > +	__u8 type;
> > +	void *owner;
> > +};
> > +
> > +#define to_counter_attribute(_dev_attr) \
> > +	container_of(_dev_attr, struct counter_attribute, dev_attr)
> > +
> > +static const char *const counter_count_function_str[] =3D {
> > +	[COUNTER_COUNT_FUNCTION_INCREASE] =3D "increase",
> > +	[COUNTER_COUNT_FUNCTION_DECREASE] =3D "decrease",
> > +	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] =3D "pulse-direction",
> > +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] =3D "quadrature x1 a",
> > +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] =3D "quadrature x1 b",
> > +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] =3D "quadrature x2 a",
> > +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] =3D "quadrature x2 b",
> > +	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] =3D "quadrature x4"
> > +};
> > +
> > +static const char *const counter_signal_value_str[] =3D {
> > +	[COUNTER_SIGNAL_LOW] =3D "low",
> > +	[COUNTER_SIGNAL_HIGH] =3D "high"
> > +};
> > +
> > +static const char *const counter_synapse_action_str[] =3D {
> > +	[COUNTER_SYNAPSE_ACTION_NONE] =3D "none",
> > +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D "rising edge",
> > +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D "falling edge",
> > +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D "both edges"
> > +};
> > +
> > +static const char *const counter_count_direction_str[] =3D {
> > +	[COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> > +	[COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> > +};
> > +
> > +static const char *const counter_count_mode_str[] =3D {
> > +	[COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> > +	[COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> > +	[COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> > +	[COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> > +};
> > +
> > +static ssize_t counter_data_u8_show(struct device *dev,
> > +				    struct device_attribute *attr, char *buf)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +	const struct counter_available *const avail =3D a->data.priv;
> > +	int err;
> > +	u8 data;
> > +
> > +	switch (a->type) {
>=20
> I don't understand the use of the word "owner" here. What is being "owned=
"?
>=20
> Perhaps "component" would be a better choice?

I wasn't too set on calling this "owner" either, but I'm not sure if
"component" would make sense either because I wouldn't label a device
attribute as belonging to any particular component (in fact it's quite
the opposite).

Perhaps the word "scope" would be better. What do you think? Or would
that be too vague as well.

> > +	case COUNTER_OWNER_TYPE_DEVICE:
> > +		err =3D a->data.device_u8_read(counter, &data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_SIGNAL:
> > +		err =3D a->data.signal_u8_read(counter, a->owner, &data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_COUNT:
> > +		if (a->data.type =3D=3D COUNTER_DATA_TYPE_SYNAPSE_ACTION)
> > +			err =3D a->data.action_read(counter, a->owner,
> > +						  a->data.priv, &data);
> > +		else
> > +			err =3D a->data.count_u8_read(counter, a->owner, &data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	switch (a->data.type) {
> > +	case COUNTER_DATA_TYPE_BOOL:
> > +		return sprintf(buf, "%u\n", (unsigned int)!!data);
> > +	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
> > +		return sprintf(buf, "%s\n", counter_count_function_str[data]);
> > +	case COUNTER_DATA_TYPE_SIGNAL:
> > +		return sprintf(buf, "%s\n", counter_signal_value_str[data]);
> > +	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
> > +		return sprintf(buf, "%s\n", counter_synapse_action_str[data]);
> > +	case COUNTER_DATA_TYPE_ENUM:
> > +		return sprintf(buf, "%s\n", avail->enums[data]);
> > +	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
> > +		return sprintf(buf, "%s\n", counter_count_direction_str[data]);
> > +	case COUNTER_DATA_TYPE_COUNT_MODE:
> > +		return sprintf(buf, "%s\n", counter_count_mode_str[data]);
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return sprintf(buf, "%u\n", (unsigned int)data);
> > +}
> > +
> > +static int find_in_string_array(u8 *const item, const u8 *const items,
> > +				const size_t num_items, const char *const buf,
> > +				const char *const string_array[])
> > +{
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < num_items; index++) {
> > +		*item =3D items[index];
> > +		if (sysfs_streq(buf, string_array[*item]))
> > +			return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static ssize_t counter_data_u8_store(struct device *dev,
> > +				     struct device_attribute *attr,
> > +				     const char *buf, size_t len)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +	struct counter_count *const count =3D a->owner;
> > +	struct counter_synapse *const synapse =3D a->data.priv;
> > +	const struct counter_available *const avail =3D a->data.priv;
> > +	int err;
> > +	bool bool_data;
> > +	u8 data;
> > +
> > +	switch (a->data.type) {
> > +	case COUNTER_DATA_TYPE_BOOL:
> > +		err =3D kstrtobool(buf, &bool_data);
> > +		data =3D bool_data;
> > +		break;
> > +	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
> > +		err =3D find_in_string_array(&data, count->functions_list,
> > +					   count->num_functions, buf,
> > +					   counter_count_function_str);
> > +		break;
> > +	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
> > +		err =3D find_in_string_array(&data, synapse->actions_list,
> > +					   synapse->num_actions, buf,
> > +					   counter_synapse_action_str);
> > +		break;
> > +	case COUNTER_DATA_TYPE_ENUM:
> > +		err =3D __sysfs_match_string(avail->enums, avail->num_items, buf);
> > +		data =3D err;
> > +		break;
> > +	case COUNTER_DATA_TYPE_COUNT_MODE:
> > +		err =3D find_in_string_array(&data, avail->items,
> > +					   avail->num_items, buf,
> > +					   counter_count_mode_str);
> > +		break;
> > +	default:
> > +		err =3D kstrtou8(buf, 0, &data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	switch (a->type) {
> > +	case COUNTER_OWNER_TYPE_DEVICE:
> > +		err =3D a->data.device_u8_write(counter, data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_SIGNAL:
> > +		err =3D a->data.signal_u8_write(counter, a->owner, data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_COUNT:
> > +		if (a->data.type =3D=3D COUNTER_DATA_TYPE_SYNAPSE_ACTION)
> > +			err =3D a->data.action_write(counter, count, synapse,
> > +						   data);
> > +		else
> > +			err =3D a->data.count_u8_write(counter, count, data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t counter_data_u64_show(struct device *dev,
> > +				     struct device_attribute *attr, char *buf)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +	int err;
> > +	u64 data;
> > +
> > +	switch (a->type) {
> > +	case COUNTER_OWNER_TYPE_DEVICE:
> > +		err =3D a->data.device_u64_read(counter, &data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_SIGNAL:
> > +		err =3D a->data.signal_u64_read(counter, a->owner, &data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_COUNT:
> > +		err =3D a->data.count_u64_read(counter, a->owner, &data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	return sprintf(buf, "%llu\n", (unsigned long long)data);
> > +}
> > +
> > +static ssize_t counter_data_u64_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > +	int err;
> > +	u64 data;
> > +
> > +	err =3D kstrtou64(buf, 0, &data);
> > +	if (err)
> > +		return err;
> > +
> > +	switch (a->type) {
> > +	case COUNTER_OWNER_TYPE_DEVICE:
> > +		err =3D a->data.device_u64_write(counter, data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_SIGNAL:
> > +		err =3D a->data.signal_u64_write(counter, a->owner, data);
> > +		break;
> > +	case COUNTER_OWNER_TYPE_COUNT:
> > +		err =3D a->data.count_u64_write(counter, a->owner, data);
> > +		break;
> > +	}
> > +	if (err)
> > +		return err;
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t items_available_show(const u8 *const items,
> > +				    const size_t num_items,
> > +				    const char *const string_array[], char *buf)
> > +{
> > +	size_t len =3D 0;
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < num_items; index++)
> > +		len +=3D sprintf(buf + len, "%s\n", string_array[items[index]]);
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t enums_available_show(const struct counter_available *co=
nst avail,
> > +				    char *buf)
> > +{
> > +	size_t len =3D 0;
> > +	size_t index;
> > +
> > +	for (index =3D 0; index < avail->num_items; index++)
> > +		len +=3D sprintf(buf + len, "%s\n", avail->enums[index]);
> > +
> > +	return len;
> > +}
> > +
> > +static ssize_t counter_data_available_show(struct device *dev,
> > +					   struct device_attribute *attr,
> > +					   char *buf)
> > +{
> > +	const struct counter_attribute *const a =3D to_counter_attribute(attr=
);
> > +	const struct counter_count *const count =3D a->owner;
> > +	const struct counter_synapse *const synapse =3D a->data.priv;
> > +	const struct counter_available *const avail =3D a->data.priv;
> > +
> > +	switch (a->data.type) {
> > +	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
> > +		return items_available_show(count->functions_list,
> > +					    count->num_functions,
> > +					    counter_count_function_str, buf);
> > +	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
> > +		return items_available_show(synapse->actions_list,
> > +					    synapse->num_actions,
> > +					    counter_synapse_action_str, buf);
> > +	case COUNTER_DATA_TYPE_ENUM:
> > +		return enums_available_show(avail, buf);
> > +	case COUNTER_DATA_TYPE_COUNT_MODE:
> > +		return items_available_show(avail->items, avail->num_items,
> > +					    counter_count_mode_str, buf);
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +struct counter_dynamic_name {
> > +	struct list_head l;
> > +	const char *name;
> > +};
> > +
> > +static int counter_available_attribute_create(
> > +	struct counter_attribute_group *const group,
> > +	struct list_head *const names, const struct counter_data *const data,
> > +	void *const owner)
> > +{
> > +	struct counter_attribute *counter_attr;
> > +	struct device_attribute *dev_attr;
> > +	struct counter_dynamic_name *dyn_name;
> > +
> > +	/* Allocate Counter attribute */
> > +	counter_attr =3D kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> > +	if (!counter_attr)
> > +		return -ENOMEM;
> > +	list_add(&counter_attr->l, &group->attr_list);
> > +	group->num_attr++;
> > +
> > +	/* Configure Counter attribute */
> > +	counter_attr->data =3D *data;
> > +	counter_attr->owner =3D owner;
> > +
> > +	/* Initialize sysfs attribute */
> > +	dev_attr =3D &counter_attr->dev_attr;
> > +	sysfs_attr_init(&dev_attr->attr);
> > +
> > +	/* Generate dynamic name list item */
> > +	dyn_name =3D kmalloc(sizeof(*dyn_name), GFP_KERNEL);
> > +	if (!dyn_name)
> > +		return -ENOMEM;
> > +	list_add(&dyn_name->l, names);
> > +
> > +	/* Generate available attribute name */
> > +	dyn_name->name =3D kasprintf(GFP_KERNEL, "%s_available", data->name);
> > +	if (!dyn_name->name)
> > +		return -ENOMEM;
>=20
> Should we try to unwind on error?

Sure, it'll probably be best to not delay cleanup so I'll try to unwind
here instead of delaying it until the end.

> > +
> > +	/* Configure device attribute */
> > +	dev_attr->attr.name =3D dyn_name->name;
> > +	dev_attr->attr.mode =3D 0444;
> > +	dev_attr->show =3D counter_data_available_show;
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_attribute_create(struct counter_attribute_group *co=
nst group,
> > +				    struct list_head *const names,
> > +				    const struct counter_data *const data,
> > +				    const __u8 type, void *const owner)
> > +{
> > +	struct counter_attribute *counter_attr;
> > +	struct device_attribute *dev_attr;
> > +
> > +	/* Allocate Counter attribute */
> > +	counter_attr =3D kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> > +	if (!counter_attr)
> > +		return -ENOMEM;
> > +	list_add(&counter_attr->l, &group->attr_list);
> > +	group->num_attr++;
> > +
> > +	/* Configure Counter attribute */
> > +	counter_attr->data =3D *data;
> > +	counter_attr->type =3D type;
> > +	counter_attr->owner =3D owner;
> > +
> > +	/* Configure device attribute */
> > +	dev_attr =3D &counter_attr->dev_attr;
> > +	sysfs_attr_init(&dev_attr->attr);
> > +	dev_attr->attr.name =3D data->name;
> > +	switch (data->type) {
> > +	case COUNTER_DATA_TYPE_U8:
> > +	case COUNTER_DATA_TYPE_BOOL:
> > +	case COUNTER_DATA_TYPE_SIGNAL:
> > +	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
> > +	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
> > +	case COUNTER_DATA_TYPE_ENUM:
> > +	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
> > +	case COUNTER_DATA_TYPE_COUNT_MODE:
> > +		if (data->device_u8_read) {
> > +			dev_attr->attr.mode |=3D 0444;
> > +			dev_attr->show =3D counter_data_u8_show;
> > +		}
> > +		if (data->device_u8_write) {
> > +			dev_attr->attr.mode |=3D 0200;
> > +			dev_attr->store =3D counter_data_u8_store;
> > +		}
> > +		break;
> > +	case COUNTER_DATA_TYPE_U64:
> > +		if (data->device_u64_read) {
> > +			dev_attr->attr.mode |=3D 0444;
> > +			dev_attr->show =3D counter_data_u64_show;
> > +		}
> > +		if (data->device_u64_write) {
> > +			dev_attr->attr.mode |=3D 0200;
> > +			dev_attr->store =3D counter_data_u64_store;
> > +		}
> > +		break;
> > +	}
> > +
> > +	switch (data->type) {
> > +	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
> > +	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
> > +	case COUNTER_DATA_TYPE_ENUM:
> > +	case COUNTER_DATA_TYPE_COUNT_MODE:
> > +		return counter_available_attribute_create(group, names, data,
> > +							  owner);
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static ssize_t counter_data_name_show(struct device *dev,
> > +				      struct device_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%s\n", to_counter_attribute(attr)->data.name);
> > +}
> > +
> > +static int counter_name_attr_create(struct counter_attribute_group *co=
nst group,
> > +				    const char *const name)
> > +{
> > +	struct counter_attribute *counter_attr;
> > +
> > +	/* Allocate Counter attribute */
> > +	counter_attr =3D kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> > +	if (!counter_attr)
> > +		return -ENOMEM;
> > +	list_add(&counter_attr->l, &group->attr_list);
> > +	group->num_attr++;
> > +
> > +	/* Configure Counter attribute */
> > +	counter_attr->data.name =3D name;
> > +
> > +	/* Configure device attribute */
> > +	sysfs_attr_init(&counter_attr->dev_attr.attr);
> > +	counter_attr->dev_attr.attr.name =3D "name";
> > +	counter_attr->dev_attr.attr.mode =3D 0444;
> > +	counter_attr->dev_attr.show =3D counter_data_name_show;
> > +
> > +	return 0;
> > +}
> > +static struct counter_data counter_signal_data =3D {
> > +	.type =3D COUNTER_DATA_TYPE_SIGNAL,
> > +	.name =3D "signal",
> > +};
> > +
> > +static int counter_signal_attributes_create(
> > +	struct counter_attribute_group *const group,
> > +	struct counter_device *const counter,
> > +	struct counter_signal *const signal)
> > +{
> > +	struct list_head *const names =3D &counter->dynamic_names_list;
> > +	const __u8 type =3D COUNTER_OWNER_TYPE_SIGNAL;
> > +	int err;
> > +	struct counter_data data;
> > +	size_t i;
> > +	const struct counter_data *ext;
> > +
> > +	/* Create main Signal attribute */
> > +	data =3D counter_signal_data;
> > +	data.signal_u8_read =3D counter->signal_read;
> > +	err =3D counter_attribute_create(group, names, &data, type, signal);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Create Signal name attribute */
> > +	err =3D counter_name_attr_create(group, signal->name);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Create an attribute for each extension */
> > +	for (i =3D 0; i < signal->num_ext; i++) {
> > +		ext =3D signal->ext + i;
> > +		err =3D counter_attribute_create(group, names, ext, type, signal);
> > +		if (err)
> > +			return err;
> > +	}
> > +
>=20
> Do we need to unwind and free attributes on error?

I was delaying this cleanup until later, but I'll try to do it early
instead here.

> > +	return 0;
> > +}
> > +
> > +static int counter_signals_register(
> > +	struct counter_attribute_group *const groups_list,
> > +	struct counter_device *const counter)
> > +{
> > +	size_t i;
> > +	const char *name;
> > +	int err;
> > +
> > +	/* Register each Signal */
> > +	for (i =3D 0; i < counter->num_signals; i++) {
> > +		/* Generate Signal attribute directory name */
> > +		name =3D kasprintf(GFP_KERNEL, "signal%zu", i);
> > +		if (!name)
> > +			return -ENOMEM;
> > +		groups_list[i].attr_group.name =3D name;
> > +
> > +		/* Create all attributes associated with Signal */
> > +		err =3D counter_signal_attributes_create(groups_list + i, counter,
> > +						       counter->signals + i);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_synapses_register(
> > +	struct counter_attribute_group *const group,
> > +	struct counter_device *const counter, struct counter_count *const cou=
nt)
> > +{
> > +	struct list_head *const names =3D &counter->dynamic_names_list;
> > +	const __u8 type =3D COUNTER_OWNER_TYPE_COUNT;
> > +	size_t i;
> > +	struct counter_synapse *synapse;
> > +	struct counter_dynamic_name *dyn_name;
> > +	size_t id;
> > +	struct counter_data data;
> > +	int err;
> > +
> > +	/* Register each Synapse */
> > +	for (i =3D 0; i < count->num_synapses; i++) {
> > +		synapse =3D count->synapses + i;
> > +
> > +		/* Generate dynamic name list item */
> > +		dyn_name =3D kmalloc(sizeof(*dyn_name), GFP_KERNEL);
> > +		if (!dyn_name)
> > +			return -ENOMEM;
> > +		list_add(&dyn_name->l, names);
> > +
> > +		/* Generate Synapse action name */
> > +		id =3D synapse->signal - counter->signals;
> > +		dyn_name->name =3D kasprintf(GFP_KERNEL, "signal%zu_action", id);
> > +		if (!dyn_name->name)
> > +			return -ENOMEM;
> > +
> > +		/* Create action attribute */
> > +		data.type =3D COUNTER_DATA_TYPE_SYNAPSE_ACTION;
> > +		data.name =3D dyn_name->name;
> > +		data.action_read =3D counter->action_read;
> > +		data.action_write =3D counter->action_write;
> > +		data.priv =3D synapse;
> > +		err =3D counter_attribute_create(group, names, &data, type,
> > +					       count);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct counter_data counter_count_data =3D
> > +	COUNTER_DATA_COUNT_U64("count", NULL, NULL);
> > +
> > +static struct counter_data counter_count_function_data =3D {
> > +	.type =3D COUNTER_DATA_TYPE_COUNT_FUNCTION,
> > +	.name =3D "function",
> > +};
> > +
> > +static int counter_count_attributes_create(
> > +	struct counter_attribute_group *const group,
> > +	struct counter_device *const counter,
> > +	struct counter_count *const count)
> > +{
> > +	struct list_head *const names =3D &counter->dynamic_names_list;
> > +	const __u8 type =3D COUNTER_OWNER_TYPE_COUNT;
> > +	int err;
> > +	struct counter_data data;
> > +	size_t i;
> > +	const struct counter_data *ext;
> > +
> > +	/* Create main Count attribute */
> > +	data =3D counter_count_data;
> > +	data.count_u64_read =3D counter->count_read;
> > +	data.count_u64_write =3D counter->count_write;
> > +	err =3D counter_attribute_create(group, names, &data, type, count);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Create Count name attribute */
> > +	err =3D counter_name_attr_create(group, count->name);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Create Count function attribute */
> > +	data =3D counter_count_function_data;
> > +	data.count_u8_read =3D counter->function_read;
> > +	data.count_u8_write =3D counter->function_write;
> > +	err =3D counter_attribute_create(group, names, &data, type, count);
> > +	if (err)
> > +		return err;
> > +
> > +	/* Create an attribute for each extension */
> > +	for (i =3D 0; i < count->num_ext; i++) {
> > +		ext =3D count->ext + i;
> > +		err =3D counter_attribute_create(group, names, ext, type, count);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_counts_register(
> > +	struct counter_attribute_group *const groups_list,
> > +	struct counter_device *const counter)
> > +{
> > +	size_t i;
> > +	struct counter_count *count;
> > +	const char *name;
> > +	int err;
> > +
> > +	/* Register each Count */
> > +	for (i =3D 0; i < counter->num_counts; i++) {
> > +		count =3D counter->counts + i;
> > +
> > +		/* Generate Count attribute directory name */
> > +		name =3D kasprintf(GFP_KERNEL, "count%zu", i);
> > +		if (!name)
> > +			return -ENOMEM;
> > +		groups_list[i].attr_group.name =3D name;
> > +
> > +		/* Register the Synapses associated with each Count */
> > +		err =3D counter_synapses_register(groups_list + i, counter,
> > +						count);
> > +		if (err)
> > +			return err;
> > +
> > +		/* Create all attributes associated with Count */
> > +		err =3D counter_count_attributes_create(groups_list + i, counter,
> > +						      count);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int counter_num_signals_read(struct counter_device *counter, u8=
 *val)
> > +{
> > +	*val =3D counter->num_signals;
> > +	return 0;
> > +}
> > +
> > +static int counter_num_counts_read(struct counter_device *counter, u8 =
*val)
> > +{
> > +	*val =3D counter->num_counts;
> > +	return 0;
> > +}
> > +
> > +static void counter_groups_list_free(struct counter_device *const coun=
ter)
> > +{
> > +	struct counter_attribute_group *group;
> > +	struct counter_attribute *p, *n;
> > +
> > +	/* Loop through all attribute groups (signals, counts, device, etc.) =
*/
> > +	while (counter->num_groups--) {
> > +		group =3D counter->groups_list + counter->num_groups;
> > +
> > +		/* Free all attribute group and associated attributes memory */
> > +		kfree(group->attr_group.name);
> > +		kfree(group->attr_group.attrs);
> > +
> > +		/* Free attribute list */
> > +		list_for_each_entry_safe(p, n, &group->attr_list, l)
> > +			kfree(p);
> > +	}
> > +
> > +	kfree(counter->groups_list);
> > +}
> > +
> > +static struct counter_data counter_num_signals_data =3D
> > +	COUNTER_DATA_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
> > +
> > +static struct counter_data counter_num_counts_data =3D
> > +	COUNTER_DATA_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
> > +
> > +static int counter_device_register(struct counter_attribute_group *gro=
up,
> > +				   struct counter_device *const counter)
> > +{
> > +	struct list_head *const names =3D &counter->dynamic_names_list;
> > +	const __u8 type =3D COUNTER_OWNER_TYPE_DEVICE;
> > +	struct counter_data data;
> > +	int err;
> > +	size_t i;
> > +	const struct counter_data *ext;
> > +
> > +	/* Register Signals */
> > +	err =3D counter_signals_register(group, counter);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +	group +=3D counter->num_signals;
> > +
> > +	/* Register Counts and respective Synapses */
> > +	err =3D counter_counts_register(group, counter);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +	group +=3D counter->num_counts;
> > +
> > +	/* Create name attribute */
> > +	err =3D counter_name_attr_create(group, counter->name);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +
> > +	/* Create num_signals attribute */
> > +	data =3D counter_num_signals_data;
> > +	err =3D counter_attribute_create(group, names, &data, type, NULL);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +
> > +	/* Create num_counts attribute */
> > +	data =3D counter_num_counts_data;
> > +	err =3D counter_attribute_create(group, names, &data, type, NULL);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +
> > +	/* Create an attribute for each extension */
> > +	for (i =3D 0; i < counter->num_ext; i++) {
> > +		ext =3D counter->ext + i;
> > +		err =3D counter_attribute_create(group, names, ext, type, NULL);
> > +		if (err)
> > +			goto err_free_groups_list;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_free_groups_list:
> > +	counter_groups_list_free(counter);
> > +	return err;
> > +}
> > +
> > +static int counter_groups_list_prepare(struct counter_device *const co=
unter)
> > +{
> > +	const size_t num_grps =3D counter->num_signals + counter->num_counts =
+ 1;
> > +	struct counter_attribute_group *groups_list;
> > +	size_t i;
> > +
> > +	/* Allocate space for attribute groups (signals, counts, and ext) */
> > +	groups_list =3D kcalloc(num_grps, sizeof(*groups_list), GFP_KERNEL);
> > +	if (!groups_list)
> > +		return -ENOMEM;
> > +
> > +	/* Store groups_list in counter structure */
> > +	counter->groups_list =3D groups_list;
> > +	counter->num_groups =3D num_grps;
> > +
> > +	/* Initialize attribute lists */
> > +	for (i =3D 0; i < num_grps; i++)
> > +		INIT_LIST_HEAD(&groups_list[i].attr_list);
> > +
> > +	/* Register Counter device attributes */
> > +	return counter_device_register(groups_list, counter);
> > +}
> > +
> > +static int counter_groups_prepare(struct counter_device *const counter)
> > +{
> > +	size_t i, j;
> > +	struct counter_attribute_group *group;
> > +	struct attribute **attrs;
> > +	int err;
> > +	struct counter_attribute *p;
> > +
> > +	/* Allocate attribute groups for association with device */
> > +	counter->groups =3D kcalloc(counter->num_groups + 1,
> > +				  sizeof(*counter->groups), GFP_KERNEL);
> > +	if (!counter->groups)
> > +		return -ENOMEM;
> > +
> > +	/* Prepare each group of attributes for association */
> > +	for (i =3D 0; i < counter->num_groups; i++) {
> > +		group =3D counter->groups_list + i;
> > +
> > +		/* Allocate space for attribute pointers */
> > +		attrs =3D kcalloc(group->num_attr + 1, sizeof(*attrs),
> > +				GFP_KERNEL);
> > +		if (!attrs) {
> > +			err =3D -ENOMEM;
> > +			goto err_free_groups;
> > +		}
> > +		group->attr_group.attrs =3D attrs;
> > +
> > +		/* Add attribute pointers to attribute group */
> > +		j =3D 0;
> > +		list_for_each_entry(p, &group->attr_list, l)
> > +			attrs[j++] =3D &p->dev_attr.attr;
> > +
> > +		/* Group attributes in attribute group */
> > +		counter->groups[i] =3D &group->attr_group;
> > +	}
> > +	/* Associate attributes with device */
> > +	counter->dev.groups =3D counter->groups;
> > +
> > +	return 0;
> > +
> > +err_free_groups:
> > +	kfree(counter->groups);
> > +	return err;
> > +}
> > +
> > +static void counter_dynamic_names_free(struct list_head *const names)
> > +{
> > +	struct counter_dynamic_name *p, *n;
> > +
> > +	list_for_each_entry_safe(p, n, names, l) {
> > +		kfree(p->name);
> > +		kfree(p);
> > +	}
> > +}
> > +
> > +int counter_sysfs_add(struct counter_device *const counter)
> > +{
> > +	int err;
> > +
> > +	/* Initialize Synapse names list */
> > +	INIT_LIST_HEAD(&counter->dynamic_names_list);
> > +
> > +	/* Prepare device attributes */
> > +	err =3D counter_groups_list_prepare(counter);
> > +	if (err)
> > +		goto err_free_names;
> > +
> > +	/* Organize device attributes to groups and match to device */
> > +	err =3D counter_groups_prepare(counter);
> > +	if (err)
> > +		goto err_free_groups_list;
> > +
> > +	return 0;
> > +
> > +err_free_groups_list:
> > +	counter_groups_list_free(counter);
> > +err_free_names:
> > +	counter_dynamic_names_free(&counter->dynamic_names_list);
> > +	return err;
> > +}
> > +
> > +void counter_sysfs_free(struct counter_device *const counter)
> > +{
> > +	kfree(counter->groups);
> > +	counter_groups_list_free(counter);
> > +	counter_dynamic_names_free(&counter->dynamic_names_list);
> > +}
>=20
> Not sure how much of this is new vs. split out from counter core
> so maybe this is a suggestion for future cleanup...
>=20
> Using devm_kzalloc() and devm_kasprintf() could greatly simplify
> memory management in all of the sysfs attribute functions above.

Thanks, I wasn't aware of these functions. I'll look into this.

> > diff --git a/drivers/counter/counter-sysfs.h b/drivers/counter/counter-=
sysfs.h
> > new file mode 100644
> > index 000000000000..00e7cd6ea083
> > --- /dev/null
> > +++ b/drivers/counter/counter-sysfs.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Counter sysfs interface
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#ifndef _COUNTER_SYSFS_H_
> > +#define _COUNTER_SYSFS_H_
> > +
> > +#include <linux/counter.h>
> > +
> > +int counter_sysfs_add(struct counter_device *const counter);
> > +void counter_sysfs_free(struct counter_device *const counter);
>=20
> "remove" is usually the complementy function to "add" rather than
> "free".

That sounds reasonable. I'll change this to "remove".

> > +
> > +#endif /* _COUNTER_SYSFS_H_ */
> > diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
> > deleted file mode 100644
> > index 6a683d086008..000000000000
> > --- a/drivers/counter/counter.c
> > +++ /dev/null
> > @@ -1,1496 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0
> > -/*
> > - * Generic Counter interface
> > - * Copyright (C) 2018 William Breathitt Gray
> > - */
> > -#include <linux/counter.h>
> > -#include <linux/device.h>
> > -#include <linux/err.h>
> > -#include <linux/export.h>
> > -#include <linux/fs.h>
> > -#include <linux/gfp.h>
> > -#include <linux/idr.h>
> > -#include <linux/init.h>
> > -#include <linux/kernel.h>
> > -#include <linux/list.h>
> > -#include <linux/module.h>
> > -#include <linux/printk.h>
> > -#include <linux/slab.h>
> > -#include <linux/string.h>
> > -#include <linux/sysfs.h>
> > -#include <linux/types.h>
> > -
> > -const char *const counter_count_direction_str[2] =3D {
> > -	[COUNTER_COUNT_DIRECTION_FORWARD] =3D "forward",
> > -	[COUNTER_COUNT_DIRECTION_BACKWARD] =3D "backward"
> > -};
> > -EXPORT_SYMBOL_GPL(counter_count_direction_str);
> > -
> > -const char *const counter_count_mode_str[4] =3D {
> > -	[COUNTER_COUNT_MODE_NORMAL] =3D "normal",
> > -	[COUNTER_COUNT_MODE_RANGE_LIMIT] =3D "range limit",
> > -	[COUNTER_COUNT_MODE_NON_RECYCLE] =3D "non-recycle",
> > -	[COUNTER_COUNT_MODE_MODULO_N] =3D "modulo-n"
> > -};
> > -EXPORT_SYMBOL_GPL(counter_count_mode_str);
> > -
> > -ssize_t counter_signal_enum_read(struct counter_device *counter,
> > -				 struct counter_signal *signal, void *priv,
> > -				 char *buf)
> > -{
> > -	const struct counter_signal_enum_ext *const e =3D priv;
> > -	int err;
> > -	size_t index;
> > -
> > -	if (!e->get)
> > -		return -EINVAL;
> > -
> > -	err =3D e->get(counter, signal, &index);
> > -	if (err)
> > -		return err;
> > -
> > -	if (index >=3D e->num_items)
> > -		return -EINVAL;
> > -
> > -	return sprintf(buf, "%s\n", e->items[index]);
> > -}
> > -EXPORT_SYMBOL_GPL(counter_signal_enum_read);
> > -
> > -ssize_t counter_signal_enum_write(struct counter_device *counter,
> > -				  struct counter_signal *signal, void *priv,
> > -				  const char *buf, size_t len)
> > -{
> > -	const struct counter_signal_enum_ext *const e =3D priv;
> > -	ssize_t index;
> > -	int err;
> > -
> > -	if (!e->set)
> > -		return -EINVAL;
> > -
> > -	index =3D __sysfs_match_string(e->items, e->num_items, buf);
> > -	if (index < 0)
> > -		return index;
> > -
> > -	err =3D e->set(counter, signal, index);
> > -	if (err)
> > -		return err;
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_signal_enum_write);
> > -
> > -ssize_t counter_signal_enum_available_read(struct counter_device *coun=
ter,
> > -					   struct counter_signal *signal,
> > -					   void *priv, char *buf)
> > -{
> > -	const struct counter_signal_enum_ext *const e =3D priv;
> > -	size_t i;
> > -	size_t len =3D 0;
> > -
> > -	if (!e->num_items)
> > -		return 0;
> > -
> > -	for (i =3D 0; i < e->num_items; i++)
> > -		len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_signal_enum_available_read);
> > -
> > -ssize_t counter_count_enum_read(struct counter_device *counter,
> > -				struct counter_count *count, void *priv,
> > -				char *buf)
> > -{
> > -	const struct counter_count_enum_ext *const e =3D priv;
> > -	int err;
> > -	size_t index;
> > -
> > -	if (!e->get)
> > -		return -EINVAL;
> > -
> > -	err =3D e->get(counter, count, &index);
> > -	if (err)
> > -		return err;
> > -
> > -	if (index >=3D e->num_items)
> > -		return -EINVAL;
> > -
> > -	return sprintf(buf, "%s\n", e->items[index]);
> > -}
> > -EXPORT_SYMBOL_GPL(counter_count_enum_read);
> > -
> > -ssize_t counter_count_enum_write(struct counter_device *counter,
> > -				 struct counter_count *count, void *priv,
> > -				 const char *buf, size_t len)
> > -{
> > -	const struct counter_count_enum_ext *const e =3D priv;
> > -	ssize_t index;
> > -	int err;
> > -
> > -	if (!e->set)
> > -		return -EINVAL;
> > -
> > -	index =3D __sysfs_match_string(e->items, e->num_items, buf);
> > -	if (index < 0)
> > -		return index;
> > -
> > -	err =3D e->set(counter, count, index);
> > -	if (err)
> > -		return err;
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_count_enum_write);
> > -
> > -ssize_t counter_count_enum_available_read(struct counter_device *count=
er,
> > -					  struct counter_count *count,
> > -					  void *priv, char *buf)
> > -{
> > -	const struct counter_count_enum_ext *const e =3D priv;
> > -	size_t i;
> > -	size_t len =3D 0;
> > -
> > -	if (!e->num_items)
> > -		return 0;
> > -
> > -	for (i =3D 0; i < e->num_items; i++)
> > -		len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_count_enum_available_read);
> > -
> > -ssize_t counter_device_enum_read(struct counter_device *counter, void =
*priv,
> > -				 char *buf)
> > -{
> > -	const struct counter_device_enum_ext *const e =3D priv;
> > -	int err;
> > -	size_t index;
> > -
> > -	if (!e->get)
> > -		return -EINVAL;
> > -
> > -	err =3D e->get(counter, &index);
> > -	if (err)
> > -		return err;
> > -
> > -	if (index >=3D e->num_items)
> > -		return -EINVAL;
> > -
> > -	return sprintf(buf, "%s\n", e->items[index]);
> > -}
> > -EXPORT_SYMBOL_GPL(counter_device_enum_read);
> > -
> > -ssize_t counter_device_enum_write(struct counter_device *counter, void=
 *priv,
> > -				  const char *buf, size_t len)
> > -{
> > -	const struct counter_device_enum_ext *const e =3D priv;
> > -	ssize_t index;
> > -	int err;
> > -
> > -	if (!e->set)
> > -		return -EINVAL;
> > -
> > -	index =3D __sysfs_match_string(e->items, e->num_items, buf);
> > -	if (index < 0)
> > -		return index;
> > -
> > -	err =3D e->set(counter, index);
> > -	if (err)
> > -		return err;
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_device_enum_write);
> > -
> > -ssize_t counter_device_enum_available_read(struct counter_device *coun=
ter,
> > -					   void *priv, char *buf)
> > -{
> > -	const struct counter_device_enum_ext *const e =3D priv;
> > -	size_t i;
> > -	size_t len =3D 0;
> > -
> > -	if (!e->num_items)
> > -		return 0;
> > -
> > -	for (i =3D 0; i < e->num_items; i++)
> > -		len +=3D sprintf(buf + len, "%s\n", e->items[i]);
> > -
> > -	return len;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_device_enum_available_read);
> > -
> > -struct counter_attr_parm {
> > -	struct counter_device_attr_group *group;
> > -	const char *prefix;
> > -	const char *name;
> > -	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
> > -			char *buf);
> > -	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
> > -			 const char *buf, size_t len);
> > -	void *component;
> > -};
> > -
> > -struct counter_device_attr {
> > -	struct device_attribute dev_attr;
> > -	struct list_head l;
> > -	void *component;
> > -};
> > -
> > -static int counter_attribute_create(const struct counter_attr_parm *co=
nst parm)
> > -{
> > -	struct counter_device_attr *counter_attr;
> > -	struct device_attribute *dev_attr;
> > -	int err;
> > -	struct list_head *const attr_list =3D &parm->group->attr_list;
> > -
> > -	/* Allocate a Counter device attribute */
> > -	counter_attr =3D kzalloc(sizeof(*counter_attr), GFP_KERNEL);
> > -	if (!counter_attr)
> > -		return -ENOMEM;
> > -	dev_attr =3D &counter_attr->dev_attr;
> > -
> > -	sysfs_attr_init(&dev_attr->attr);
> > -
> > -	/* Configure device attribute */
> > -	dev_attr->attr.name =3D kasprintf(GFP_KERNEL, "%s%s", parm->prefix,
> > -					parm->name);
> > -	if (!dev_attr->attr.name) {
> > -		err =3D -ENOMEM;
> > -		goto err_free_counter_attr;
> > -	}
> > -	if (parm->show) {
> > -		dev_attr->attr.mode |=3D 0444;
> > -		dev_attr->show =3D parm->show;
> > -	}
> > -	if (parm->store) {
> > -		dev_attr->attr.mode |=3D 0200;
> > -		dev_attr->store =3D parm->store;
> > -	}
> > -
> > -	/* Store associated Counter component with attribute */
> > -	counter_attr->component =3D parm->component;
> > -
> > -	/* Keep track of the attribute for later cleanup */
> > -	list_add(&counter_attr->l, attr_list);
> > -	parm->group->num_attr++;
> > -
> > -	return 0;
> > -
> > -err_free_counter_attr:
> > -	kfree(counter_attr);
> > -	return err;
> > -}
> > -
> > -#define to_counter_attr(_dev_attr) \
> > -	container_of(_dev_attr, struct counter_device_attr, dev_attr)
> > -
> > -struct counter_signal_unit {
> > -	struct counter_signal *signal;
> > -};
> > -
> > -static const char *const counter_signal_value_str[] =3D {
> > -	[COUNTER_SIGNAL_LOW] =3D "low",
> > -	[COUNTER_SIGNAL_HIGH] =3D "high"
> > -};
> > -
> > -static ssize_t counter_signal_show(struct device *dev,
> > -				   struct device_attribute *attr, char *buf)
> > -{
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_signal_unit *const component =3D devattr->compon=
ent;
> > -	struct counter_signal *const signal =3D component->signal;
> > -	int err;
> > -	enum counter_signal_value val;
> > -
> > -	err =3D counter->ops->signal_read(counter, signal, &val);
> > -	if (err)
> > -		return err;
> > -
> > -	return sprintf(buf, "%s\n", counter_signal_value_str[val]);
> > -}
> > -
> > -struct counter_name_unit {
> > -	const char *name;
> > -};
> > -
> > -static ssize_t counter_device_attr_name_show(struct device *dev,
> > -					     struct device_attribute *attr,
> > -					     char *buf)
> > -{
> > -	const struct counter_name_unit *const comp =3D to_counter_attr(attr)-=
>component;
> > -
> > -	return sprintf(buf, "%s\n", comp->name);
> > -}
> > -
> > -static int counter_name_attribute_create(
> > -	struct counter_device_attr_group *const group,
> > -	const char *const name)
> > -{
> > -	struct counter_name_unit *name_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Skip if no name */
> > -	if (!name)
> > -		return 0;
> > -
> > -	/* Allocate name attribute component */
> > -	name_comp =3D kmalloc(sizeof(*name_comp), GFP_KERNEL);
> > -	if (!name_comp)
> > -		return -ENOMEM;
> > -	name_comp->name =3D name;
> > -
> > -	/* Allocate Signal name attribute */
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D "name";
> > -	parm.show =3D counter_device_attr_name_show;
> > -	parm.store =3D NULL;
> > -	parm.component =3D name_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err)
> > -		goto err_free_name_comp;
> > -
> > -	return 0;
> > -
> > -err_free_name_comp:
> > -	kfree(name_comp);
> > -	return err;
> > -}
> > -
> > -struct counter_signal_ext_unit {
> > -	struct counter_signal *signal;
> > -	const struct counter_signal_ext *ext;
> > -};
> > -
> > -static ssize_t counter_signal_ext_show(struct device *dev,
> > -				       struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_signal_ext_unit *const comp =3D devattr->compone=
nt;
> > -	const struct counter_signal_ext *const ext =3D comp->ext;
> > -
> > -	return ext->read(dev_get_drvdata(dev), comp->signal, ext->priv, buf);
> > -}
> > -
> > -static ssize_t counter_signal_ext_store(struct device *dev,
> > -					struct device_attribute *attr,
> > -					const char *buf, size_t len)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_signal_ext_unit *const comp =3D devattr->compone=
nt;
> > -	const struct counter_signal_ext *const ext =3D comp->ext;
> > -
> > -	return ext->write(dev_get_drvdata(dev), comp->signal, ext->priv, buf,
> > -		len);
> > -}
> > -
> > -static void counter_device_attr_list_free(struct list_head *attr_list)
> > -{
> > -	struct counter_device_attr *p, *n;
> > -
> > -	list_for_each_entry_safe(p, n, attr_list, l) {
> > -		/* free attribute name and associated component memory */
> > -		kfree(p->dev_attr.attr.name);
> > -		kfree(p->component);
> > -		list_del(&p->l);
> > -		kfree(p);
> > -	}
> > -}
> > -
> > -static int counter_signal_ext_register(
> > -	struct counter_device_attr_group *const group,
> > -	struct counter_signal *const signal)
> > -{
> > -	const size_t num_ext =3D signal->num_ext;
> > -	size_t i;
> > -	const struct counter_signal_ext *ext;
> > -	struct counter_signal_ext_unit *signal_ext_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Create an attribute for each extension */
> > -	for (i =3D 0 ; i < num_ext; i++) {
> > -		ext =3D signal->ext + i;
> > -
> > -		/* Allocate signal_ext attribute component */
> > -		signal_ext_comp =3D kmalloc(sizeof(*signal_ext_comp), GFP_KERNEL);
> > -		if (!signal_ext_comp) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_list;
> > -		}
> > -		signal_ext_comp->signal =3D signal;
> > -		signal_ext_comp->ext =3D ext;
> > -
> > -		/* Allocate a Counter device attribute */
> > -		parm.group =3D group;
> > -		parm.prefix =3D "";
> > -		parm.name =3D ext->name;
> > -		parm.show =3D (ext->read) ? counter_signal_ext_show : NULL;
> > -		parm.store =3D (ext->write) ? counter_signal_ext_store : NULL;
> > -		parm.component =3D signal_ext_comp;
> > -		err =3D counter_attribute_create(&parm);
> > -		if (err) {
> > -			kfree(signal_ext_comp);
> > -			goto err_free_attr_list;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -static int counter_signal_attributes_create(
> > -	struct counter_device_attr_group *const group,
> > -	const struct counter_device *const counter,
> > -	struct counter_signal *const signal)
> > -{
> > -	struct counter_signal_unit *signal_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Allocate Signal attribute component */
> > -	signal_comp =3D kmalloc(sizeof(*signal_comp), GFP_KERNEL);
> > -	if (!signal_comp)
> > -		return -ENOMEM;
> > -	signal_comp->signal =3D signal;
> > -
> > -	/* Create main Signal attribute */
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D "signal";
> > -	parm.show =3D (counter->ops->signal_read) ? counter_signal_show : NUL=
L;
> > -	parm.store =3D NULL;
> > -	parm.component =3D signal_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err) {
> > -		kfree(signal_comp);
> > -		return err;
> > -	}
> > -
> > -	/* Create Signal name attribute */
> > -	err =3D counter_name_attribute_create(group, signal->name);
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	/* Register Signal extension attributes */
> > -	err =3D counter_signal_ext_register(group, signal);
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -static int counter_signals_register(
> > -	struct counter_device_attr_group *const groups_list,
> > -	const struct counter_device *const counter)
> > -{
> > -	const size_t num_signals =3D counter->num_signals;
> > -	size_t i;
> > -	struct counter_signal *signal;
> > -	const char *name;
> > -	int err;
> > -
> > -	/* Register each Signal */
> > -	for (i =3D 0; i < num_signals; i++) {
> > -		signal =3D counter->signals + i;
> > -
> > -		/* Generate Signal attribute directory name */
> > -		name =3D kasprintf(GFP_KERNEL, "signal%d", signal->id);
> > -		if (!name) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_groups;
> > -		}
> > -		groups_list[i].attr_group.name =3D name;
> > -
> > -		/* Create all attributes associated with Signal */
> > -		err =3D counter_signal_attributes_create(groups_list + i, counter,
> > -						       signal);
> > -		if (err)
> > -			goto err_free_attr_groups;
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_attr_groups:
> > -	do {
> > -		kfree(groups_list[i].attr_group.name);
> > -		counter_device_attr_list_free(&groups_list[i].attr_list);
> > -	} while (i--);
> > -	return err;
> > -}
> > -
> > -static const char *const counter_synapse_action_str[] =3D {
> > -	[COUNTER_SYNAPSE_ACTION_NONE] =3D "none",
> > -	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D "rising edge",
> > -	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D "falling edge",
> > -	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D "both edges"
> > -};
> > -
> > -struct counter_action_unit {
> > -	struct counter_synapse *synapse;
> > -	struct counter_count *count;
> > -};
> > -
> > -static ssize_t counter_action_show(struct device *dev,
> > -				   struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	int err;
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	const struct counter_action_unit *const component =3D devattr->compon=
ent;
> > -	struct counter_count *const count =3D component->count;
> > -	struct counter_synapse *const synapse =3D component->synapse;
> > -	size_t action_index;
> > -	enum counter_synapse_action action;
> > -
> > -	err =3D counter->ops->action_get(counter, count, synapse, &action_ind=
ex);
> > -	if (err)
> > -		return err;
> > -
> > -	synapse->action =3D action_index;
> > -
> > -	action =3D synapse->actions_list[action_index];
> > -	return sprintf(buf, "%s\n", counter_synapse_action_str[action]);
> > -}
> > -
> > -static ssize_t counter_action_store(struct device *dev,
> > -				    struct device_attribute *attr,
> > -				    const char *buf, size_t len)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_action_unit *const component =3D devattr->compon=
ent;
> > -	struct counter_synapse *const synapse =3D component->synapse;
> > -	size_t action_index;
> > -	const size_t num_actions =3D synapse->num_actions;
> > -	enum counter_synapse_action action;
> > -	int err;
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	struct counter_count *const count =3D component->count;
> > -
> > -	/* Find requested action mode */
> > -	for (action_index =3D 0; action_index < num_actions; action_index++) {
> > -		action =3D synapse->actions_list[action_index];
> > -		if (sysfs_streq(buf, counter_synapse_action_str[action]))
> > -			break;
> > -	}
> > -	/* If requested action mode not found */
> > -	if (action_index >=3D num_actions)
> > -		return -EINVAL;
> > -
> > -	err =3D counter->ops->action_set(counter, count, synapse, action_inde=
x);
> > -	if (err)
> > -		return err;
> > -
> > -	synapse->action =3D action_index;
> > -
> > -	return len;
> > -}
> > -
> > -struct counter_action_avail_unit {
> > -	const enum counter_synapse_action *actions_list;
> > -	size_t num_actions;
> > -};
> > -
> > -static ssize_t counter_synapse_action_available_show(struct device *de=
v,
> > -	struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_action_avail_unit *const component =3D devattr->=
component;
> > -	size_t i;
> > -	enum counter_synapse_action action;
> > -	ssize_t len =3D 0;
> > -
> > -	for (i =3D 0; i < component->num_actions; i++) {
> > -		action =3D component->actions_list[i];
> > -		len +=3D sprintf(buf + len, "%s\n",
> > -			       counter_synapse_action_str[action]);
> > -	}
> > -
> > -	return len;
> > -}
> > -
> > -static int counter_synapses_register(
> > -	struct counter_device_attr_group *const group,
> > -	const struct counter_device *const counter,
> > -	struct counter_count *const count, const char *const count_attr_name)
> > -{
> > -	size_t i;
> > -	struct counter_synapse *synapse;
> > -	const char *prefix;
> > -	struct counter_action_unit *action_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -	struct counter_action_avail_unit *avail_comp;
> > -
> > -	/* Register each Synapse */
> > -	for (i =3D 0; i < count->num_synapses; i++) {
> > -		synapse =3D count->synapses + i;
> > -
> > -		/* Generate attribute prefix */
> > -		prefix =3D kasprintf(GFP_KERNEL, "signal%d_",
> > -				   synapse->signal->id);
> > -		if (!prefix) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_list;
> > -		}
> > -
> > -		/* Allocate action attribute component */
> > -		action_comp =3D kmalloc(sizeof(*action_comp), GFP_KERNEL);
> > -		if (!action_comp) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_prefix;
> > -		}
> > -		action_comp->synapse =3D synapse;
> > -		action_comp->count =3D count;
> > -
> > -		/* Create action attribute */
> > -		parm.group =3D group;
> > -		parm.prefix =3D prefix;
> > -		parm.name =3D "action";
> > -		parm.show =3D (counter->ops->action_get) ? counter_action_show : NUL=
L;
> > -		parm.store =3D (counter->ops->action_set) ? counter_action_store : N=
ULL;
> > -		parm.component =3D action_comp;
> > -		err =3D counter_attribute_create(&parm);
> > -		if (err) {
> > -			kfree(action_comp);
> > -			goto err_free_prefix;
> > -		}
> > -
> > -		/* Allocate action available attribute component */
> > -		avail_comp =3D kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> > -		if (!avail_comp) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_prefix;
> > -		}
> > -		avail_comp->actions_list =3D synapse->actions_list;
> > -		avail_comp->num_actions =3D synapse->num_actions;
> > -
> > -		/* Create action_available attribute */
> > -		parm.group =3D group;
> > -		parm.prefix =3D prefix;
> > -		parm.name =3D "action_available";
> > -		parm.show =3D counter_synapse_action_available_show;
> > -		parm.store =3D NULL;
> > -		parm.component =3D avail_comp;
> > -		err =3D counter_attribute_create(&parm);
> > -		if (err) {
> > -			kfree(avail_comp);
> > -			goto err_free_prefix;
> > -		}
> > -
> > -		kfree(prefix);
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_prefix:
> > -	kfree(prefix);
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -struct counter_count_unit {
> > -	struct counter_count *count;
> > -};
> > -
> > -static ssize_t counter_count_show(struct device *dev,
> > -				  struct device_attribute *attr,
> > -				  char *buf)
> > -{
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_unit *const component =3D devattr->compone=
nt;
> > -	struct counter_count *const count =3D component->count;
> > -	int err;
> > -	unsigned long val;
> > -
> > -	err =3D counter->ops->count_read(counter, count, &val);
> > -	if (err)
> > -		return err;
> > -
> > -	return sprintf(buf, "%lu\n", val);
> > -}
> > -
> > -static ssize_t counter_count_store(struct device *dev,
> > -				   struct device_attribute *attr,
> > -				   const char *buf, size_t len)
> > -{
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_unit *const component =3D devattr->compone=
nt;
> > -	struct counter_count *const count =3D component->count;
> > -	int err;
> > -	unsigned long val;
> > -
> > -	err =3D kstrtoul(buf, 0, &val);
> > -	if (err)
> > -		return err;
> > -
> > -	err =3D counter->ops->count_write(counter, count, val);
> > -	if (err)
> > -		return err;
> > -
> > -	return len;
> > -}
> > -
> > -static const char *const counter_count_function_str[] =3D {
> > -	[COUNTER_COUNT_FUNCTION_INCREASE] =3D "increase",
> > -	[COUNTER_COUNT_FUNCTION_DECREASE] =3D "decrease",
> > -	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] =3D "pulse-direction",
> > -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] =3D "quadrature x1 a",
> > -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] =3D "quadrature x1 b",
> > -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] =3D "quadrature x2 a",
> > -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] =3D "quadrature x2 b",
> > -	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] =3D "quadrature x4"
> > -};
> > -
> > -static ssize_t counter_function_show(struct device *dev,
> > -				     struct device_attribute *attr, char *buf)
> > -{
> > -	int err;
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_unit *const component =3D devattr->compone=
nt;
> > -	struct counter_count *const count =3D component->count;
> > -	size_t func_index;
> > -	enum counter_count_function function;
> > -
> > -	err =3D counter->ops->function_get(counter, count, &func_index);
> > -	if (err)
> > -		return err;
> > -
> > -	count->function =3D func_index;
> > -
> > -	function =3D count->functions_list[func_index];
> > -	return sprintf(buf, "%s\n", counter_count_function_str[function]);
> > -}
> > -
> > -static ssize_t counter_function_store(struct device *dev,
> > -				      struct device_attribute *attr,
> > -				      const char *buf, size_t len)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_unit *const component =3D devattr->compone=
nt;
> > -	struct counter_count *const count =3D component->count;
> > -	const size_t num_functions =3D count->num_functions;
> > -	size_t func_index;
> > -	enum counter_count_function function;
> > -	int err;
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -
> > -	/* Find requested Count function mode */
> > -	for (func_index =3D 0; func_index < num_functions; func_index++) {
> > -		function =3D count->functions_list[func_index];
> > -		if (sysfs_streq(buf, counter_count_function_str[function]))
> > -			break;
> > -	}
> > -	/* Return error if requested Count function mode not found */
> > -	if (func_index >=3D num_functions)
> > -		return -EINVAL;
> > -
> > -	err =3D counter->ops->function_set(counter, count, func_index);
> > -	if (err)
> > -		return err;
> > -
> > -	count->function =3D func_index;
> > -
> > -	return len;
> > -}
> > -
> > -struct counter_count_ext_unit {
> > -	struct counter_count *count;
> > -	const struct counter_count_ext *ext;
> > -};
> > -
> > -static ssize_t counter_count_ext_show(struct device *dev,
> > -				      struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_ext_unit *const comp =3D devattr->componen=
t;
> > -	const struct counter_count_ext *const ext =3D comp->ext;
> > -
> > -	return ext->read(dev_get_drvdata(dev), comp->count, ext->priv, buf);
> > -}
> > -
> > -static ssize_t counter_count_ext_store(struct device *dev,
> > -				       struct device_attribute *attr,
> > -				       const char *buf, size_t len)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_count_ext_unit *const comp =3D devattr->componen=
t;
> > -	const struct counter_count_ext *const ext =3D comp->ext;
> > -
> > -	return ext->write(dev_get_drvdata(dev), comp->count, ext->priv, buf,
> > -		len);
> > -}
> > -
> > -static int counter_count_ext_register(
> > -	struct counter_device_attr_group *const group,
> > -	struct counter_count *const count)
> > -{
> > -	size_t i;
> > -	const struct counter_count_ext *ext;
> > -	struct counter_count_ext_unit *count_ext_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Create an attribute for each extension */
> > -	for (i =3D 0 ; i < count->num_ext; i++) {
> > -		ext =3D count->ext + i;
> > -
> > -		/* Allocate count_ext attribute component */
> > -		count_ext_comp =3D kmalloc(sizeof(*count_ext_comp), GFP_KERNEL);
> > -		if (!count_ext_comp) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_list;
> > -		}
> > -		count_ext_comp->count =3D count;
> > -		count_ext_comp->ext =3D ext;
> > -
> > -		/* Allocate count_ext attribute */
> > -		parm.group =3D group;
> > -		parm.prefix =3D "";
> > -		parm.name =3D ext->name;
> > -		parm.show =3D (ext->read) ? counter_count_ext_show : NULL;
> > -		parm.store =3D (ext->write) ? counter_count_ext_store : NULL;
> > -		parm.component =3D count_ext_comp;
> > -		err =3D counter_attribute_create(&parm);
> > -		if (err) {
> > -			kfree(count_ext_comp);
> > -			goto err_free_attr_list;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -struct counter_func_avail_unit {
> > -	const enum counter_count_function *functions_list;
> > -	size_t num_functions;
> > -};
> > -
> > -static ssize_t counter_count_function_available_show(struct device *de=
v,
> > -	struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_func_avail_unit *const component =3D devattr->co=
mponent;
> > -	const enum counter_count_function *const func_list =3D component->fun=
ctions_list;
> > -	const size_t num_functions =3D component->num_functions;
> > -	size_t i;
> > -	enum counter_count_function function;
> > -	ssize_t len =3D 0;
> > -
> > -	for (i =3D 0; i < num_functions; i++) {
> > -		function =3D func_list[i];
> > -		len +=3D sprintf(buf + len, "%s\n",
> > -			       counter_count_function_str[function]);
> > -	}
> > -
> > -	return len;
> > -}
> > -
> > -static int counter_count_attributes_create(
> > -	struct counter_device_attr_group *const group,
> > -	const struct counter_device *const counter,
> > -	struct counter_count *const count)
> > -{
> > -	struct counter_count_unit *count_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -	struct counter_count_unit *func_comp;
> > -	struct counter_func_avail_unit *avail_comp;
> > -
> > -	/* Allocate count attribute component */
> > -	count_comp =3D kmalloc(sizeof(*count_comp), GFP_KERNEL);
> > -	if (!count_comp)
> > -		return -ENOMEM;
> > -	count_comp->count =3D count;
> > -
> > -	/* Create main Count attribute */
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D "count";
> > -	parm.show =3D (counter->ops->count_read) ? counter_count_show : NULL;
> > -	parm.store =3D (counter->ops->count_write) ? counter_count_store : NU=
LL;
> > -	parm.component =3D count_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err) {
> > -		kfree(count_comp);
> > -		return err;
> > -	}
> > -
> > -	/* Allocate function attribute component */
> > -	func_comp =3D kmalloc(sizeof(*func_comp), GFP_KERNEL);
> > -	if (!func_comp) {
> > -		err =3D -ENOMEM;
> > -		goto err_free_attr_list;
> > -	}
> > -	func_comp->count =3D count;
> > -
> > -	/* Create Count function attribute */
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D "function";
> > -	parm.show =3D (counter->ops->function_get) ? counter_function_show : =
NULL;
> > -	parm.store =3D (counter->ops->function_set) ? counter_function_store =
: NULL;
> > -	parm.component =3D func_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err) {
> > -		kfree(func_comp);
> > -		goto err_free_attr_list;
> > -	}
> > -
> > -	/* Allocate function available attribute component */
> > -	avail_comp =3D kmalloc(sizeof(*avail_comp), GFP_KERNEL);
> > -	if (!avail_comp) {
> > -		err =3D -ENOMEM;
> > -		goto err_free_attr_list;
> > -	}
> > -	avail_comp->functions_list =3D count->functions_list;
> > -	avail_comp->num_functions =3D count->num_functions;
> > -
> > -	/* Create Count function_available attribute */
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D "function_available";
> > -	parm.show =3D counter_count_function_available_show;
> > -	parm.store =3D NULL;
> > -	parm.component =3D avail_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err) {
> > -		kfree(avail_comp);
> > -		goto err_free_attr_list;
> > -	}
> > -
> > -	/* Create Count name attribute */
> > -	err =3D counter_name_attribute_create(group, count->name);
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	/* Register Count extension attributes */
> > -	err =3D counter_count_ext_register(group, count);
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -static int counter_counts_register(
> > -	struct counter_device_attr_group *const groups_list,
> > -	const struct counter_device *const counter)
> > -{
> > -	size_t i;
> > -	struct counter_count *count;
> > -	const char *name;
> > -	int err;
> > -
> > -	/* Register each Count */
> > -	for (i =3D 0; i < counter->num_counts; i++) {
> > -		count =3D counter->counts + i;
> > -
> > -		/* Generate Count attribute directory name */
> > -		name =3D kasprintf(GFP_KERNEL, "count%d", count->id);
> > -		if (!name) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_groups;
> > -		}
> > -		groups_list[i].attr_group.name =3D name;
> > -
> > -		/* Register the Synapses associated with each Count */
> > -		err =3D counter_synapses_register(groups_list + i, counter, count,
> > -						name);
> > -		if (err)
> > -			goto err_free_attr_groups;
> > -
> > -		/* Create all attributes associated with Count */
> > -		err =3D counter_count_attributes_create(groups_list + i, counter,
> > -						      count);
> > -		if (err)
> > -			goto err_free_attr_groups;
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_attr_groups:
> > -	do {
> > -		kfree(groups_list[i].attr_group.name);
> > -		counter_device_attr_list_free(&groups_list[i].attr_list);
> > -	} while (i--);
> > -	return err;
> > -}
> > -
> > -struct counter_size_unit {
> > -	size_t size;
> > -};
> > -
> > -static ssize_t counter_device_attr_size_show(struct device *dev,
> > -					     struct device_attribute *attr,
> > -					     char *buf)
> > -{
> > -	const struct counter_size_unit *const comp =3D to_counter_attr(attr)-=
>component;
> > -
> > -	return sprintf(buf, "%zu\n", comp->size);
> > -}
> > -
> > -static int counter_size_attribute_create(
> > -	struct counter_device_attr_group *const group,
> > -	const size_t size, const char *const name)
> > -{
> > -	struct counter_size_unit *size_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Allocate size attribute component */
> > -	size_comp =3D kmalloc(sizeof(*size_comp), GFP_KERNEL);
> > -	if (!size_comp)
> > -		return -ENOMEM;
> > -	size_comp->size =3D size;
> > -
> > -	parm.group =3D group;
> > -	parm.prefix =3D "";
> > -	parm.name =3D name;
> > -	parm.show =3D counter_device_attr_size_show;
> > -	parm.store =3D NULL;
> > -	parm.component =3D size_comp;
> > -	err =3D counter_attribute_create(&parm);
> > -	if (err)
> > -		goto err_free_size_comp;
> > -
> > -	return 0;
> > -
> > -err_free_size_comp:
> > -	kfree(size_comp);
> > -	return err;
> > -}
> > -
> > -struct counter_ext_unit {
> > -	const struct counter_device_ext *ext;
> > -};
> > -
> > -static ssize_t counter_device_ext_show(struct device *dev,
> > -				       struct device_attribute *attr, char *buf)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_ext_unit *const component =3D devattr->component;
> > -	const struct counter_device_ext *const ext =3D component->ext;
> > -
> > -	return ext->read(dev_get_drvdata(dev), ext->priv, buf);
> > -}
> > -
> > -static ssize_t counter_device_ext_store(struct device *dev,
> > -					struct device_attribute *attr,
> > -					const char *buf, size_t len)
> > -{
> > -	const struct counter_device_attr *const devattr =3D to_counter_attr(a=
ttr);
> > -	const struct counter_ext_unit *const component =3D devattr->component;
> > -	const struct counter_device_ext *const ext =3D component->ext;
> > -
> > -	return ext->write(dev_get_drvdata(dev), ext->priv, buf, len);
> > -}
> > -
> > -static int counter_device_ext_register(
> > -	struct counter_device_attr_group *const group,
> > -	struct counter_device *const counter)
> > -{
> > -	size_t i;
> > -	struct counter_ext_unit *ext_comp;
> > -	struct counter_attr_parm parm;
> > -	int err;
> > -
> > -	/* Create an attribute for each extension */
> > -	for (i =3D 0 ; i < counter->num_ext; i++) {
> > -		/* Allocate extension attribute component */
> > -		ext_comp =3D kmalloc(sizeof(*ext_comp), GFP_KERNEL);
> > -		if (!ext_comp) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_attr_list;
> > -		}
> > -
> > -		ext_comp->ext =3D counter->ext + i;
> > -
> > -		/* Allocate extension attribute */
> > -		parm.group =3D group;
> > -		parm.prefix =3D "";
> > -		parm.name =3D counter->ext[i].name;
> > -		parm.show =3D (counter->ext[i].read) ? counter_device_ext_show : NUL=
L;
> > -		parm.store =3D (counter->ext[i].write) ? counter_device_ext_store : =
NULL;
> > -		parm.component =3D ext_comp;
> > -		err =3D counter_attribute_create(&parm);
> > -		if (err) {
> > -			kfree(ext_comp);
> > -			goto err_free_attr_list;
> > -		}
> > -	}
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -static int counter_global_attr_register(
> > -	struct counter_device_attr_group *const group,
> > -	struct counter_device *const counter)
> > -{
> > -	int err;
> > -
> > -	/* Create name attribute */
> > -	err =3D counter_name_attribute_create(group, counter->name);
> > -	if (err)
> > -		return err;
> > -
> > -	/* Create num_counts attribute */
> > -	err =3D counter_size_attribute_create(group, counter->num_counts,
> > -					    "num_counts");
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	/* Create num_signals attribute */
> > -	err =3D counter_size_attribute_create(group, counter->num_signals,
> > -					    "num_signals");
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	/* Register Counter device extension attributes */
> > -	err =3D counter_device_ext_register(group, counter);
> > -	if (err)
> > -		goto err_free_attr_list;
> > -
> > -	return 0;
> > -
> > -err_free_attr_list:
> > -	counter_device_attr_list_free(&group->attr_list);
> > -	return err;
> > -}
> > -
> > -static void counter_device_groups_list_free(
> > -	struct counter_device_attr_group *const groups_list,
> > -	const size_t num_groups)
> > -{
> > -	struct counter_device_attr_group *group;
> > -	size_t i;
> > -
> > -	/* loop through all attribute groups (signals, counts, global, etc.) =
*/
> > -	for (i =3D 0; i < num_groups; i++) {
> > -		group =3D groups_list + i;
> > -
> > -		/* free all attribute group and associated attributes memory */
> > -		kfree(group->attr_group.name);
> > -		kfree(group->attr_group.attrs);
> > -		counter_device_attr_list_free(&group->attr_list);
> > -	}
> > -
> > -	kfree(groups_list);
> > -}
> > -
> > -static int counter_device_groups_list_prepare(
> > -	struct counter_device *const counter)
> > -{
> > -	const size_t total_num_groups =3D
> > -		counter->num_signals + counter->num_counts + 1;
> > -	struct counter_device_attr_group *groups_list;
> > -	size_t i;
> > -	int err;
> > -	size_t num_groups =3D 0;
> > -
> > -	/* Allocate space for attribute groups (signals, counts, and ext) */
> > -	groups_list =3D kcalloc(total_num_groups, sizeof(*groups_list),
> > -			      GFP_KERNEL);
> > -	if (!groups_list)
> > -		return -ENOMEM;
> > -
> > -	/* Initialize attribute lists */
> > -	for (i =3D 0; i < total_num_groups; i++)
> > -		INIT_LIST_HEAD(&groups_list[i].attr_list);
> > -
> > -	/* Register Signals */
> > -	err =3D counter_signals_register(groups_list, counter);
> > -	if (err)
> > -		goto err_free_groups_list;
> > -	num_groups +=3D counter->num_signals;
> > -
> > -	/* Register Counts and respective Synapses */
> > -	err =3D counter_counts_register(groups_list + num_groups, counter);
> > -	if (err)
> > -		goto err_free_groups_list;
> > -	num_groups +=3D counter->num_counts;
> > -
> > -	/* Register Counter global attributes */
> > -	err =3D counter_global_attr_register(groups_list + num_groups, counte=
r);
> > -	if (err)
> > -		goto err_free_groups_list;
> > -	num_groups++;
> > -
> > -	/* Store groups_list in device_state */
> > -	counter->device_state->groups_list =3D groups_list;
> > -	counter->device_state->num_groups =3D num_groups;
> > -
> > -	return 0;
> > -
> > -err_free_groups_list:
> > -	counter_device_groups_list_free(groups_list, num_groups);
> > -	return err;
> > -}
> > -
> > -static int counter_device_groups_prepare(
> > -	struct counter_device_state *const device_state)
> > -{
> > -	size_t i, j;
> > -	struct counter_device_attr_group *group;
> > -	int err;
> > -	struct counter_device_attr *p;
> > -
> > -	/* Allocate attribute groups for association with device */
> > -	device_state->groups =3D kcalloc(device_state->num_groups + 1,
> > -				       sizeof(*device_state->groups),
> > -				       GFP_KERNEL);
> > -	if (!device_state->groups)
> > -		return -ENOMEM;
> > -
> > -	/* Prepare each group of attributes for association */
> > -	for (i =3D 0; i < device_state->num_groups; i++) {
> > -		group =3D device_state->groups_list + i;
> > -
> > -		/* Allocate space for attribute pointers in attribute group */
> > -		group->attr_group.attrs =3D kcalloc(group->num_attr + 1,
> > -			sizeof(*group->attr_group.attrs), GFP_KERNEL);
> > -		if (!group->attr_group.attrs) {
> > -			err =3D -ENOMEM;
> > -			goto err_free_groups;
> > -		}
> > -
> > -		/* Add attribute pointers to attribute group */
> > -		j =3D 0;
> > -		list_for_each_entry(p, &group->attr_list, l)
> > -			group->attr_group.attrs[j++] =3D &p->dev_attr.attr;
> > -
> > -		/* Group attributes in attribute group */
> > -		device_state->groups[i] =3D &group->attr_group;
> > -	}
> > -	/* Associate attributes with device */
> > -	device_state->dev.groups =3D device_state->groups;
> > -
> > -	return 0;
> > -
> > -err_free_groups:
> > -	do {
> > -		group =3D device_state->groups_list + i;
> > -		kfree(group->attr_group.attrs);
> > -		group->attr_group.attrs =3D NULL;
> > -	} while (i--);
> > -	kfree(device_state->groups);
> > -	return err;
> > -}
> > -
> > -/* Provides a unique ID for each counter device */
> > -static DEFINE_IDA(counter_ida);
> > -
> > -static void counter_device_release(struct device *dev)
> > -{
> > -	struct counter_device *const counter =3D dev_get_drvdata(dev);
> > -	struct counter_device_state *const device_state =3D counter->device_s=
tate;
> > -
> > -	kfree(device_state->groups);
> > -	counter_device_groups_list_free(device_state->groups_list,
> > -					device_state->num_groups);
> > -	ida_simple_remove(&counter_ida, device_state->id);
> > -	kfree(device_state);
> > -}
> > -
> > -static struct device_type counter_device_type =3D {
> > -	.name =3D "counter_device",
> > -	.release =3D counter_device_release
> > -};
> > -
> > -static struct bus_type counter_bus_type =3D {
> > -	.name =3D "counter"
> > -};
> > -
> > -/**
> > - * counter_register - register Counter to the system
> > - * @counter:	pointer to Counter to register
> > - *
> > - * This function registers a Counter to the system. A sysfs "counter" =
directory
> > - * will be created and populated with sysfs attributes correlating wit=
h the
> > - * Counter Signals, Synapses, and Counts respectively.
> > - */
> > -int counter_register(struct counter_device *const counter)
> > -{
> > -	struct counter_device_state *device_state;
> > -	int err;
> > -
> > -	/* Allocate internal state container for Counter device */
> > -	device_state =3D kzalloc(sizeof(*device_state), GFP_KERNEL);
> > -	if (!device_state)
> > -		return -ENOMEM;
> > -	counter->device_state =3D device_state;
> > -
> > -	/* Acquire unique ID */
> > -	device_state->id =3D ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
> > -	if (device_state->id < 0) {
> > -		err =3D device_state->id;
> > -		goto err_free_device_state;
> > -	}
> > -
> > -	/* Configure device structure for Counter */
> > -	device_state->dev.type =3D &counter_device_type;
> > -	device_state->dev.bus =3D &counter_bus_type;
> > -	if (counter->parent) {
> > -		device_state->dev.parent =3D counter->parent;
> > -		device_state->dev.of_node =3D counter->parent->of_node;
> > -	}
> > -	dev_set_name(&device_state->dev, "counter%d", device_state->id);
> > -	device_initialize(&device_state->dev);
> > -	dev_set_drvdata(&device_state->dev, counter);
> > -
> > -	/* Prepare device attributes */
> > -	err =3D counter_device_groups_list_prepare(counter);
> > -	if (err)
> > -		goto err_free_id;
> > -
> > -	/* Organize device attributes to groups and match to device */
> > -	err =3D counter_device_groups_prepare(device_state);
> > -	if (err)
> > -		goto err_free_groups_list;
> > -
> > -	/* Add device to system */
> > -	err =3D device_add(&device_state->dev);
> > -	if (err)
> > -		goto err_free_groups;
> > -
> > -	return 0;
> > -
> > -err_free_groups:
> > -	kfree(device_state->groups);
> > -err_free_groups_list:
> > -	counter_device_groups_list_free(device_state->groups_list,
> > -					device_state->num_groups);
> > -err_free_id:
> > -	ida_simple_remove(&counter_ida, device_state->id);
> > -err_free_device_state:
> > -	kfree(device_state);
> > -	return err;
> > -}
> > -EXPORT_SYMBOL_GPL(counter_register);
> > -
> > -/**
> > - * counter_unregister - unregister Counter from the system
> > - * @counter:	pointer to Counter to unregister
> > - *
> > - * The Counter is unregistered from the system; all allocated memory i=
s freed.
> > - */
> > -void counter_unregister(struct counter_device *const counter)
> > -{
> > -	if (counter)
> > -		device_del(&counter->device_state->dev);
> > -}
> > -EXPORT_SYMBOL_GPL(counter_unregister);
> > -
> > -static void devm_counter_unreg(struct device *dev, void *res)
> > -{
> > -	counter_unregister(*(struct counter_device **)res);
> > -}
> > -
> > -/**
> > - * devm_counter_register - Resource-managed counter_register
> > - * @dev:	device to allocate counter_device for
> > - * @counter:	pointer to Counter to register
> > - *
> > - * Managed counter_register. The Counter registered with this function=
 is
> > - * automatically unregistered on driver detach. This function calls
> > - * counter_register internally. Refer to that function for more inform=
ation.
> > - *
> > - * If an Counter registered with this function needs to be unregistered
> > - * separately, devm_counter_unregister must be used.
> > - *
> > - * RETURNS:
> > - * 0 on success, negative error number on failure.
> > - */
> > -int devm_counter_register(struct device *dev,
> > -			  struct counter_device *const counter)
> > -{
> > -	struct counter_device **ptr;
> > -	int ret;
> > -
> > -	ptr =3D devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
> > -	if (!ptr)
> > -		return -ENOMEM;
> > -
> > -	ret =3D counter_register(counter);
> > -	if (!ret) {
> > -		*ptr =3D counter;
> > -		devres_add(dev, ptr);
> > -	} else {
> > -		devres_free(ptr);
> > -	}
> > -
> > -	return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(devm_counter_register);
> > -
> > -static int devm_counter_match(struct device *dev, void *res, void *dat=
a)
> > -{
> > -	struct counter_device **r =3D res;
> > -
> > -	if (!r || !*r) {
> > -		WARN_ON(!r || !*r);
> > -		return 0;
> > -	}
> > -
> > -	return *r =3D=3D data;
> > -}
> > -
> > -/**
> > - * devm_counter_unregister - Resource-managed counter_unregister
> > - * @dev:	device this counter_device belongs to
> > - * @counter:	pointer to Counter associated with the device
> > - *
> > - * Unregister Counter registered with devm_counter_register.
> > - */
> > -void devm_counter_unregister(struct device *dev,
> > -			     struct counter_device *const counter)
> > -{
> > -	int rc;
> > -
> > -	rc =3D devres_release(dev, devm_counter_unreg, devm_counter_match,
> > -			    counter);
> > -	WARN_ON(rc);
> > -}
> > -EXPORT_SYMBOL_GPL(devm_counter_unregister);
> > -
> > -static int __init counter_init(void)
> > -{
> > -	return bus_register(&counter_bus_type);
> > -}
> > -
> > -static void __exit counter_exit(void)
> > -{
> > -	bus_unregister(&counter_bus_type);
> > -}
> > -
> > -subsys_initcall(counter_init);
> > -module_exit(counter_exit);
> > -
> > -MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
> > -MODULE_DESCRIPTION("Generic Counter interface");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quadde=
c.c
> > index c2b3fdfd8b77..71a0f7131237 100644
> > --- a/drivers/counter/ftm-quaddec.c
> > +++ b/drivers/counter/ftm-quaddec.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/mutex.h>
> >   #include <linux/counter.h>
> >   #include <linux/bitfield.h>
> > +#include <linux/types.h>
> >  =20
> >   #define FTM_FIELD_UPDATE(ftm, offset, mask, val)			\
> >   	({								\
> > @@ -115,8 +116,7 @@ static void ftm_quaddec_disable(void *ftm)
> >   }
> >  =20
> >   static int ftm_quaddec_get_prescaler(struct counter_device *counter,
> > -				     struct counter_count *count,
> > -				     size_t *cnt_mode)
> > +				     struct counter_count *count, u8 *cnt_mode)
> >   {
> >   	struct ftm_quaddec *ftm =3D counter->priv;
> >   	uint32_t scflags;
> > @@ -129,8 +129,7 @@ static int ftm_quaddec_get_prescaler(struct counter=
_device *counter,
> >   }
> >  =20
> >   static int ftm_quaddec_set_prescaler(struct counter_device *counter,
> > -				     struct counter_count *count,
> > -				     size_t cnt_mode)
> > +				     struct counter_count *count, u8 cnt_mode)
> >   {
> >   	struct ftm_quaddec *ftm =3D counter->priv;
> >  =20
> > @@ -151,34 +150,21 @@ static const char * const ftm_quaddec_prescaler[]=
 =3D {
> >   	"1", "2", "4", "8", "16", "32", "64", "128"
> >   };
> >  =20
> > -static struct counter_count_enum_ext ftm_quaddec_prescaler_enum =3D {
> > -	.items =3D ftm_quaddec_prescaler,
> > -	.num_items =3D ARRAY_SIZE(ftm_quaddec_prescaler),
> > -	.get =3D ftm_quaddec_get_prescaler,
> > -	.set =3D ftm_quaddec_set_prescaler
> > -};
> > -
> > -enum ftm_quaddec_synapse_action {
> > -	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
> > -};
> > -
> > -static enum counter_synapse_action ftm_quaddec_synapse_actions[] =3D {
> > -	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =3D
> > +static const u8 ftm_quaddec_synapse_actions[] =3D {
> >   	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> >   };
> >  =20
> >   enum ftm_quaddec_count_function {
> > -	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
> > +	FTM_QUADDEC_COUNT_ENCODER_MODE_1 =3D COUNTER_COUNT_FUNCTION_QUADRATUR=
E_X4,
> >   };
> >  =20
> > -static const enum counter_count_function ftm_quaddec_count_functions[]=
 =3D {
> > -	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =3D
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> > +static const u8 ftm_quaddec_count_functions[] =3D {
> > +	FTM_QUADDEC_COUNT_ENCODER_MODE_1
> >   };
> >  =20
> >   static int ftm_quaddec_count_read(struct counter_device *counter,
> >   				  struct counter_count *count,
> > -				  unsigned long *val)
> > +				  u64 *val)
> >   {
> >   	struct ftm_quaddec *const ftm =3D counter->priv;
> >   	uint32_t cntval;
> > @@ -192,7 +178,7 @@ static int ftm_quaddec_count_read(struct counter_de=
vice *counter,
> >  =20
> >   static int ftm_quaddec_count_write(struct counter_device *counter,
> >   				   struct counter_count *count,
> > -				   const unsigned long val)
> > +				   const u64 val)
> >   {
> >   	struct ftm_quaddec *const ftm =3D counter->priv;
> >  =20
> > @@ -208,7 +194,7 @@ static int ftm_quaddec_count_write(struct counter_d=
evice *counter,
> >  =20
> >   static int ftm_quaddec_count_function_get(struct counter_device *coun=
ter,
> >   					  struct counter_count *count,
> > -					  size_t *function)
> > +					  u8 *function)
> >   {
> >   	*function =3D FTM_QUADDEC_COUNT_ENCODER_MODE_1;
> >  =20
> > @@ -218,20 +204,13 @@ static int ftm_quaddec_count_function_get(struct =
counter_device *counter,
> >   static int ftm_quaddec_action_get(struct counter_device *counter,
> >   				  struct counter_count *count,
> >   				  struct counter_synapse *synapse,
> > -				  size_t *action)
> > +				  u8 *action)
> >   {
> > -	*action =3D FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
> > +	*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static const struct counter_ops ftm_quaddec_cnt_ops =3D {
> > -	.count_read =3D ftm_quaddec_count_read,
> > -	.count_write =3D ftm_quaddec_count_write,
> > -	.function_get =3D ftm_quaddec_count_function_get,
> > -	.action_get =3D ftm_quaddec_action_get,
> > -};
> > -
> >   static struct counter_signal ftm_quaddec_signals[] =3D {
> >   	{
> >   		.id =3D 0,
> > @@ -256,9 +235,12 @@ static struct counter_synapse ftm_quaddec_count_sy=
napses[] =3D {
> >   	}
> >   };
> >  =20
> > -static const struct counter_count_ext ftm_quaddec_count_ext[] =3D {
> > -	COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
> > -	COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_enum=
),
> > +static DEFINE_COUNTER_ENUM(ftm_quaddec_prescaler_enum, ftm_quaddec_pre=
scaler);
> > +
> > +static struct counter_data ftm_quaddec_count_ext[] =3D {
> > +	COUNTER_DATA_COUNT_ENUM("prescaler", ftm_quaddec_get_prescaler,
> > +				ftm_quaddec_set_prescaler,
> > +				ftm_quaddec_prescaler_enum),
> >   };
> >  =20
> >   static struct counter_count ftm_quaddec_counts =3D {
> > @@ -302,7 +284,10 @@ static int ftm_quaddec_probe(struct platform_devic=
e *pdev)
> >   	}
> >   	ftm->counter.name =3D dev_name(&pdev->dev);
> >   	ftm->counter.parent =3D &pdev->dev;
> > -	ftm->counter.ops =3D &ftm_quaddec_cnt_ops;
> > +	ftm->counter.count_read =3D ftm_quaddec_count_read;
> > +	ftm->counter.count_write =3D ftm_quaddec_count_write;
> > +	ftm->counter.function_read =3D ftm_quaddec_count_function_get;
> > +	ftm->counter.action_read =3D ftm_quaddec_action_get;
> >   	ftm->counter.counts =3D &ftm_quaddec_counts;
> >   	ftm->counter.num_counts =3D 1;
> >   	ftm->counter.signals =3D ftm_quaddec_signals;
> > diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/=
microchip-tcb-capture.c
> > index f7b7743ddb94..27c449bbadd7 100644
> > --- a/drivers/counter/microchip-tcb-capture.c
> > +++ b/drivers/counter/microchip-tcb-capture.c
> > @@ -32,28 +32,16 @@ struct mchp_tc_data {
> >   	bool trig_inverted;
> >   };
> >  =20
> > -enum mchp_tc_count_function {
> > -	MCHP_TC_FUNCTION_INCREASE,
> > -	MCHP_TC_FUNCTION_QUADRATURE,
> > +static const u8 mchp_tc_count_functions[] =3D {
> > +	COUNTER_COUNT_FUNCTION_INCREASE,
> > +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> >   };
> >  =20
> > -static enum counter_count_function mchp_tc_count_functions[] =3D {
> > -	[MCHP_TC_FUNCTION_INCREASE] =3D COUNTER_COUNT_FUNCTION_INCREASE,
> > -	[MCHP_TC_FUNCTION_QUADRATURE] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X=
4,
> > -};
> > -
> > -enum mchp_tc_synapse_action {
> > -	MCHP_TC_SYNAPSE_ACTION_NONE =3D 0,
> > -	MCHP_TC_SYNAPSE_ACTION_RISING_EDGE,
> > -	MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE,
> > -	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
> > -};
> > -
> > -static enum counter_synapse_action mchp_tc_synapse_actions[] =3D {
> > -	[MCHP_TC_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> > -	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_RISIN=
G_EDGE,
> > -	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION_FALL=
ING_EDGE,
> > -	[MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE] =3D COUNTER_SYNAPSE_ACTION_BOTH_ED=
GES,
> > +static const u8 mchp_tc_synapse_actions[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> >   };
> >  =20
> >   static struct counter_signal mchp_tc_count_signals[] =3D {
> > @@ -80,23 +68,23 @@ static struct counter_synapse mchp_tc_count_synapse=
s[] =3D {
> >   	}
> >   };
> >  =20
> > -static int mchp_tc_count_function_get(struct counter_device *counter,
> > -				      struct counter_count *count,
> > -				      size_t *function)
> > +static int mchp_tc_count_function_read(struct counter_device *counter,
> > +				       struct counter_count *count,
> > +				       u8 *function)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >  =20
> >   	if (priv->qdec_mode)
> > -		*function =3D MCHP_TC_FUNCTION_QUADRATURE;
> > +		*function =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
> >   	else
> > -		*function =3D MCHP_TC_FUNCTION_INCREASE;
> > +		*function =3D COUNTER_COUNT_FUNCTION_INCREASE;
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static int mchp_tc_count_function_set(struct counter_device *counter,
> > -				      struct counter_count *count,
> > -				      size_t function)
> > +static int mchp_tc_count_function_write(struct counter_device *counter,
> > +					struct counter_count *count,
> > +					u8 function)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >   	u32 bmr, cmr;
> > @@ -108,7 +96,7 @@ static int mchp_tc_count_function_set(struct counter=
_device *counter,
> >   	cmr &=3D ~ATMEL_TC_WAVE;
> >  =20
> >   	switch (function) {
> > -	case MCHP_TC_FUNCTION_INCREASE:
> > +	case COUNTER_COUNT_FUNCTION_INCREASE:
> >   		priv->qdec_mode =3D 0;
> >   		/* Set highest rate based on whether soc has gclk or not */
> >   		bmr &=3D ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
> > @@ -120,7 +108,7 @@ static int mchp_tc_count_function_set(struct counte=
r_device *counter,
> >   		cmr |=3D  ATMEL_TC_CMR_MASK;
> >   		cmr &=3D ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);
> >   		break;
> > -	case MCHP_TC_FUNCTION_QUADRATURE:
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
> >   		if (!priv->tc_cfg->has_qdec)
> >   			return -EINVAL;
> >   		/* In QDEC mode settings both channels 0 and 1 are required */
> > @@ -154,8 +142,7 @@ static int mchp_tc_count_function_set(struct counte=
r_device *counter,
> >   }
> >  =20
> >   static int mchp_tc_count_signal_read(struct counter_device *counter,
> > -				     struct counter_signal *signal,
> > -				     enum counter_signal_value *val)
> > +				     struct counter_signal *signal, u8 *val)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >   	bool sigstatus;
> > @@ -173,34 +160,34 @@ static int mchp_tc_count_signal_read(struct count=
er_device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static int mchp_tc_count_action_get(struct counter_device *counter,
> > -				    struct counter_count *count,
> > -				    struct counter_synapse *synapse,
> > -				    size_t *action)
> > +static int mchp_tc_count_action_read(struct counter_device *counter,
> > +				     struct counter_count *count,
> > +				     struct counter_synapse *synapse,
> > +				     u8 *action)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >   	u32 cmr;
> >  =20
> >   	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
> >  =20
> > -	*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >  =20
> >   	if (cmr & ATMEL_TC_ETRGEDG_NONE)
> > -		*action =3D MCHP_TC_SYNAPSE_ACTION_NONE;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >   	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
> > -		*action =3D MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
> > -		*action =3D MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
> >   	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
> > -		*action =3D MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static int mchp_tc_count_action_set(struct counter_device *counter,
> > -				    struct counter_count *count,
> > -				    struct counter_synapse *synapse,
> > -				    size_t action)
> > +static int mchp_tc_count_action_write(struct counter_device *counter,
> > +				      struct counter_count *count,
> > +				      struct counter_synapse *synapse,
> > +				      u8 action)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >   	u32 edge =3D ATMEL_TC_ETRGEDG_NONE;
> > @@ -210,16 +197,16 @@ static int mchp_tc_count_action_set(struct counte=
r_device *counter,
> >   		return -EINVAL;
> >  =20
> >   	switch (action) {
> > -	case MCHP_TC_SYNAPSE_ACTION_NONE:
> > +	case COUNTER_SYNAPSE_ACTION_NONE:
> >   		edge =3D ATMEL_TC_ETRGEDG_NONE;
> >   		break;
> > -	case MCHP_TC_SYNAPSE_ACTION_RISING_EDGE:
> > +	case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
> >   		edge =3D ATMEL_TC_ETRGEDG_RISING;
> >   		break;
> > -	case MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE:
> > +	case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
> >   		edge =3D ATMEL_TC_ETRGEDG_FALLING;
> >   		break;
> > -	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
> > +	case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
> >   		edge =3D ATMEL_TC_ETRGEDG_BOTH;
> >   		break;
> >   	}
> > @@ -230,8 +217,7 @@ static int mchp_tc_count_action_set(struct counter_=
device *counter,
> >   }
> >  =20
> >   static int mchp_tc_count_read(struct counter_device *counter,
> > -			      struct counter_count *count,
> > -			      unsigned long *val)
> > +			      struct counter_count *count, u64 *val)
> >   {
> >   	struct mchp_tc_data *const priv =3D counter->priv;
> >   	u32 cnt;
> > @@ -253,15 +239,6 @@ static struct counter_count mchp_tc_counts[] =3D {
> >   	},
> >   };
> >  =20
> > -static struct counter_ops mchp_tc_ops =3D {
> > -	.signal_read  =3D mchp_tc_count_signal_read,
> > -	.count_read   =3D mchp_tc_count_read,
> > -	.function_get =3D mchp_tc_count_function_get,
> > -	.function_set =3D mchp_tc_count_function_set,
> > -	.action_get   =3D mchp_tc_count_action_get,
> > -	.action_set   =3D mchp_tc_count_action_set
> > -};
> > -
> >   static const struct atmel_tcb_config tcb_rm9200_config =3D {
> >   		.counter_width =3D 16,
> >   };
> > @@ -367,7 +344,12 @@ static int mchp_tc_probe(struct platform_device *p=
dev)
> >   	priv->regmap =3D regmap;
> >   	priv->counter.name =3D dev_name(&pdev->dev);
> >   	priv->counter.parent =3D &pdev->dev;
> > -	priv->counter.ops =3D &mchp_tc_ops;
> > +	priv->counter.signal_read  =3D mchp_tc_count_signal_read,
> > +	priv->counter.count_read   =3D mchp_tc_count_read,
> > +	priv->counter.function_read =3D mchp_tc_count_function_read,
> > +	priv->counter.function_write =3D mchp_tc_count_function_write,
> > +	priv->counter.action_read   =3D mchp_tc_count_action_read,
> > +	priv->counter.action_write   =3D mchp_tc_count_action_write
> >   	priv->counter.num_counts =3D ARRAY_SIZE(mchp_tc_counts);
> >   	priv->counter.counts =3D mchp_tc_counts;
> >   	priv->counter.num_signals =3D ARRAY_SIZE(mchp_tc_count_signals);
> > diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm3=
2-lptimer-cnt.c
> > index fd6828e2d34f..a37c2456d33a 100644
> > --- a/drivers/counter/stm32-lptimer-cnt.c
> > +++ b/drivers/counter/stm32-lptimer-cnt.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/module.h>
> >   #include <linux/pinctrl/consumer.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/types.h>
> >  =20
> >   struct stm32_lptim_cnt {
> >   	struct counter_device counter;
> > @@ -352,32 +353,46 @@ static const struct iio_chan_spec stm32_lptim_cnt=
_channels =3D {
> >    * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 qua=
drature)
> >    */
> >   enum stm32_lptim_cnt_function {
> > -	STM32_LPTIM_COUNTER_INCREASE,
> > -	STM32_LPTIM_ENCODER_BOTH_EDGE,
> > +	STM32_LPTIM_COUNTER_INCREASE =3D COUNTER_COUNT_FUNCTION_INCREASE,
> > +	STM32_LPTIM_ENCODER_BOTH_EDGE =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X=
4,
> >   };
> >  =20
> > -static enum counter_count_function stm32_lptim_cnt_functions[] =3D {
> > -	[STM32_LPTIM_COUNTER_INCREASE] =3D COUNTER_COUNT_FUNCTION_INCREASE,
> > -	[STM32_LPTIM_ENCODER_BOTH_EDGE] =3D COUNTER_COUNT_FUNCTION_QUADRATURE=
_X4,
> > +static u8 stm32_lptim_cnt_functions[] =3D {
> > +	STM32_LPTIM_COUNTER_INCREASE,
> > +	STM32_LPTIM_ENCODER_BOTH_EDGE,
> >   };
> >  =20
> >   enum stm32_lptim_synapse_action {
> > +	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) =
*/
> >   	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
> >   	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
> >   	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
> >   	STM32_LPTIM_SYNAPSE_ACTION_NONE,
> >   };
> >  =20
> > -static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] =
=3D {
> > -	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) =
*/
> > +static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_m=
ap[] =3D {
> > +	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACTION_R=
ISING_EDGE,
> > +	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] =3D STM32_LPTIM_SYNAPSE_ACTION_=
FALLING_EDGE,
> > +	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] =3D STM32_LPTIM_SYNAPSE_ACTION_BO=
TH_EDGES,
> > +	[COUNTER_SYNAPSE_ACTION_NONE] =3D STM32_LPTIM_SYNAPSE_ACTION_NONE,
> > +};
> > +
> > +static const u8 stm32_lptim_l2c_actions_map[] =3D {
> >   	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] =3D COUNTER_SYNAPSE_ACTION_=
RISING_EDGE,
> >   	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] =3D COUNTER_SYNAPSE_ACTION=
_FALLING_EDGE,
> >   	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_B=
OTH_EDGES,
> >   	[STM32_LPTIM_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> >   };
> >  =20
> > +static const u8 stm32_lptim_cnt_synapse_actions[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +};
> > +
> >   static int stm32_lptim_cnt_read(struct counter_device *counter,
> > -				struct counter_count *count, unsigned long *val)
> > +				struct counter_count *count, u64 *val)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >   	u32 cnt;
> > @@ -394,7 +409,7 @@ static int stm32_lptim_cnt_read(struct counter_devi=
ce *counter,
> >  =20
> >   static int stm32_lptim_cnt_function_get(struct counter_device *counte=
r,
> >   					struct counter_count *count,
> > -					size_t *function)
> > +					u8 *function)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >  =20
> > @@ -413,7 +428,7 @@ static int stm32_lptim_cnt_function_get(struct coun=
ter_device *counter,
> >  =20
> >   static int stm32_lptim_cnt_function_set(struct counter_device *counte=
r,
> >   					struct counter_count *count,
> > -					size_t function)
> > +					u8 function)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >  =20
> > @@ -423,19 +438,20 @@ static int stm32_lptim_cnt_function_set(struct co=
unter_device *counter,
> >   	switch (function) {
> >   	case STM32_LPTIM_COUNTER_INCREASE:
> >   		priv->quadrature_mode =3D 0;
> > -		return 0;
> > +		break;
> >   	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> >   		priv->quadrature_mode =3D 1;
> >   		priv->polarity =3D STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
> > -		return 0;
> > +		break;
> > +	default: return -EINVAL;
> >   	}
> >  =20
> > -	return -EINVAL;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *coun=
ter,
> > -					   struct counter_count *count,
> > -					   void *private, char *buf)
> > +static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
> > +				       struct counter_count *count,
> > +				       u8 *enable)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >   	int ret;
> > @@ -444,22 +460,18 @@ static ssize_t stm32_lptim_cnt_enable_read(struct=
 counter_device *counter,
> >   	if (ret < 0)
> >   		return ret;
> >  =20
> > -	return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
> > +	*enable =3D ret;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *cou=
nter,
> > -					    struct counter_count *count,
> > -					    void *private,
> > -					    const char *buf, size_t len)
> > +static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
> > +					struct counter_count *count,
> > +					u8 enable)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > -	bool enable;
> >   	int ret;
> >  =20
> > -	ret =3D kstrtobool(buf, &enable);
> > -	if (ret)
> > -		return ret;
> > -
> >   	/* Check nobody uses the timer, or already disabled/enabled */
> >   	ret =3D stm32_lptim_is_enabled(priv);
> >   	if ((ret < 0) || (!ret && !enable))
> > @@ -475,48 +487,51 @@ static ssize_t stm32_lptim_cnt_enable_write(struc=
t counter_device *counter,
> >   	if (ret)
> >   		return ret;
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *cou=
nter,
> > -					    struct counter_count *count,
> > -					    void *private, char *buf)
> > +static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
> > +					struct counter_count *count,
> > +					u64 *ceiling)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >  =20
> > -	return stm32_lptim_cnt_get_ceiling(priv, buf);
> > +	*ceiling =3D priv->ceiling;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *co=
unter,
> > -					     struct counter_count *count,
> > -					     void *private,
> > -					     const char *buf, size_t len)
> > +static int stm32_lptim_cnt_ceiling_write(struct counter_device *counte=
r,
> > +					 struct counter_count *count,
> > +					 u64 ceiling)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> >  =20
> > -	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
> > +	if (ceiling > STM32_LPTIM_MAX_ARR)
> > +		return -EINVAL;
> > +
> > +	if (stm32_lptim_is_enabled(priv))
> > +		return -EBUSY;
> > +
> > +	priv->ceiling =3D ceiling;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static const struct counter_count_ext stm32_lptim_cnt_ext[] =3D {
> > -	{
> > -		.name =3D "enable",
> > -		.read =3D stm32_lptim_cnt_enable_read,
> > -		.write =3D stm32_lptim_cnt_enable_write
> > -	},
> > -	{
> > -		.name =3D "ceiling",
> > -		.read =3D stm32_lptim_cnt_ceiling_read,
> > -		.write =3D stm32_lptim_cnt_ceiling_write
> > -	},
> > +static struct counter_data stm32_lptim_cnt_ext[] =3D {
> > +	COUNTER_DATA_ENABLE(stm32_lptim_cnt_enable_read,
> > +			    stm32_lptim_cnt_enable_write),
> > +	COUNTER_DATA_CEILING(stm32_lptim_cnt_ceiling_read,
> > +			     stm32_lptim_cnt_ceiling_write),
> >   };
> >  =20
> >   static int stm32_lptim_cnt_action_get(struct counter_device *counter,
> >   				      struct counter_count *count,
> >   				      struct counter_synapse *synapse,
> > -				      size_t *action)
> > +				      u8 *action)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > -	size_t function;
> > +	u8 function;
> >   	int err;
> >  =20
> >   	err =3D stm32_lptim_cnt_function_get(counter, count, &function);
> > @@ -527,25 +542,25 @@ static int stm32_lptim_cnt_action_get(struct coun=
ter_device *counter,
> >   	case STM32_LPTIM_COUNTER_INCREASE:
> >   		/* LP Timer acts as up-counter on input 1 */
> >   		if (synapse->signal->id =3D=3D count->synapses[0].signal->id)
> > -			*action =3D priv->polarity;
> > +			*action =3D stm32_lptim_l2c_actions_map[priv->polarity];
> >   		else
> > -			*action =3D STM32_LPTIM_SYNAPSE_ACTION_NONE;
> > -		return 0;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> > +		break;
> >   	case STM32_LPTIM_ENCODER_BOTH_EDGE:
> > -		*action =3D priv->polarity;
> > -		return 0;
> > +		*action =3D stm32_lptim_l2c_actions_map[priv->polarity];
> > +		break;
> >   	}
> >  =20
> > -	return -EINVAL;
> > +	return 0;
> >   }
> >  =20
> >   static int stm32_lptim_cnt_action_set(struct counter_device *counter,
> >   				      struct counter_count *count,
> >   				      struct counter_synapse *synapse,
> > -				      size_t action)
> > +				      u8 action)
> >   {
> >   	struct stm32_lptim_cnt *const priv =3D counter->priv;
> > -	size_t function;
> > +	u8 function;
> >   	int err;
> >  =20
> >   	if (stm32_lptim_is_enabled(priv))
> > @@ -556,27 +571,15 @@ static int stm32_lptim_cnt_action_set(struct coun=
ter_device *counter,
> >   		return err;
> >  =20
> >   	/* only set polarity when in counter mode (on input 1) */
> > -	if (function =3D=3D STM32_LPTIM_COUNTER_INCREASE
> > -	    && synapse->signal->id =3D=3D count->synapses[0].signal->id) {
> > -		switch (action) {
> > -		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
> > -		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
> > -		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
> > -			priv->polarity =3D action;
> > -			return 0;
> > -		}
> > -	}
> > +	if (function !=3D STM32_LPTIM_COUNTER_INCREASE
> > +	    || synapse->signal->id !=3D count->synapses[0].signal->id
> > +	    || action =3D=3D COUNTER_SYNAPSE_ACTION_NONE)
> > +		return -EINVAL;
> >  =20
> > -	return -EINVAL;
> > -}
> > +	priv->polarity =3D stm32_lptim_c2l_actions_map[action];
> >  =20
> > -static const struct counter_ops stm32_lptim_cnt_ops =3D {
> > -	.count_read =3D stm32_lptim_cnt_read,
> > -	.function_get =3D stm32_lptim_cnt_function_get,
> > -	.function_set =3D stm32_lptim_cnt_function_set,
> > -	.action_get =3D stm32_lptim_cnt_action_get,
> > -	.action_set =3D stm32_lptim_cnt_action_set,
> > -};
> > +	return 0;
> > +}
> >  =20
> >   static struct counter_signal stm32_lptim_cnt_signals[] =3D {
> >   	{
> > @@ -659,7 +662,11 @@ static int stm32_lptim_cnt_probe(struct platform_d=
evice *pdev)
> >   	/* Initialize Counter device */
> >   	priv->counter.name =3D dev_name(&pdev->dev);
> >   	priv->counter.parent =3D &pdev->dev;
> > -	priv->counter.ops =3D &stm32_lptim_cnt_ops;
> > +	priv->counter.count_read =3D stm32_lptim_cnt_read;
> > +	priv->counter.function_read =3D stm32_lptim_cnt_function_get;
> > +	priv->counter.function_write =3D stm32_lptim_cnt_function_set;
> > +	priv->counter.action_read =3D stm32_lptim_cnt_action_get;
> > +	priv->counter.action_write =3D stm32_lptim_cnt_action_set;
> >   	if (ddata->has_encoder) {
> >   		priv->counter.counts =3D &stm32_lptim_enc_counts;
> >   		priv->counter.num_signals =3D ARRAY_SIZE(stm32_lptim_cnt_signals);
> > diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-=
timer-cnt.c
> > index ef2a974a2f10..502e525836a9 100644
> > --- a/drivers/counter/stm32-timer-cnt.c
> > +++ b/drivers/counter/stm32-timer-cnt.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/module.h>
> >   #include <linux/pinctrl/consumer.h>
> >   #include <linux/platform_device.h>
> > +#include <linux/types.h>
> >  =20
> >   #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
> >   #define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
> > @@ -45,19 +46,19 @@ struct stm32_timer_cnt {
> >    */
> >   enum stm32_count_function {
> >   	STM32_COUNT_SLAVE_MODE_DISABLED =3D -1,
> > +	STM32_COUNT_ENCODER_MODE_1 =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> > +	STM32_COUNT_ENCODER_MODE_2 =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> > +	STM32_COUNT_ENCODER_MODE_3 =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> > +};
> > +
> > +static const u8 stm32_count_functions[] =3D {
> >   	STM32_COUNT_ENCODER_MODE_1,
> >   	STM32_COUNT_ENCODER_MODE_2,
> >   	STM32_COUNT_ENCODER_MODE_3,
> >   };
> >  =20
> > -static enum counter_count_function stm32_count_functions[] =3D {
> > -	[STM32_COUNT_ENCODER_MODE_1] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2=
_A,
> > -	[STM32_COUNT_ENCODER_MODE_2] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X2=
_B,
> > -	[STM32_COUNT_ENCODER_MODE_3] =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> > -};
> > -
> >   static int stm32_count_read(struct counter_device *counter,
> > -			    struct counter_count *count, unsigned long *val)
> > +			    struct counter_count *count, u64 *val)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >   	u32 cnt;
> > @@ -69,8 +70,7 @@ static int stm32_count_read(struct counter_device *co=
unter,
> >   }
> >  =20
> >   static int stm32_count_write(struct counter_device *counter,
> > -			     struct counter_count *count,
> > -			     const unsigned long val)
> > +			     struct counter_count *count, const u64 val)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >  =20
> > @@ -81,8 +81,7 @@ static int stm32_count_write(struct counter_device *c=
ounter,
> >   }
> >  =20
> >   static int stm32_count_function_get(struct counter_device *counter,
> > -				    struct counter_count *count,
> > -				    size_t *function)
> > +				    struct counter_count *count, u8 *function)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >   	u32 smcr;
> > @@ -105,8 +104,7 @@ static int stm32_count_function_get(struct counter_=
device *counter,
> >   }
> >  =20
> >   static int stm32_count_function_set(struct counter_device *counter,
> > -				    struct counter_count *count,
> > -				    size_t function)
> > +				    struct counter_count *count, u8 function)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >   	u32 cr1, sms;
> > @@ -146,78 +144,67 @@ static int stm32_count_function_set(struct counte=
r_device *counter,
> >   	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_count_direction_read(struct counter_device *count=
er,
> > +static int stm32_count_direction_read(struct counter_device *counter,
> >   				      struct counter_count *count,
> > -				      void *private, char *buf)
> > +				      u8 *direction)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> > -	const char *direction;
> >   	u32 cr1;
> >  =20
> >   	regmap_read(priv->regmap, TIM_CR1, &cr1);
> > -	direction =3D (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
> > +	*direction =3D (cr1 & TIM_CR1_DIR) ? COUNTER_COUNT_DIRECTION_BACKWARD=
 :
> > +		COUNTER_COUNT_DIRECTION_FORWARD;
> >  =20
> > -	return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
> > -					struct counter_count *count,
> > -					void *private, char *buf)
> > +static int stm32_count_ceiling_read(struct counter_device *counter,
> > +				    struct counter_count *count, u64 *ceiling)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >   	u32 arr;
> >  =20
> >   	regmap_read(priv->regmap, TIM_ARR, &arr);
> >  =20
> > -	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
> > +	*ceiling =3D arr;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_count_ceiling_write(struct counter_device *counte=
r,
> > -					 struct counter_count *count,
> > -					 void *private,
> > -					 const char *buf, size_t len)
> > +static int stm32_count_ceiling_write(struct counter_device *counter,
> > +				     struct counter_count *count, u64 ceiling)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> > -	unsigned int ceiling;
> > -	int ret;
> >  =20
> > -	ret =3D kstrtouint(buf, 0, &ceiling);
> > -	if (ret)
> > -		return ret;
> > +	if (ceiling !=3D (u32)ceiling)
> > +		return -ERANGE;
> >  =20
> >   	/* TIMx_ARR register shouldn't be buffered (ARPE=3D0) */
> >   	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
> >   	regmap_write(priv->regmap, TIM_ARR, ceiling);
> >  =20
> >   	priv->ceiling =3D ceiling;
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_count_enable_read(struct counter_device *counter,
> > -				       struct counter_count *count,
> > -				       void *private, char *buf)
> > +static int stm32_count_enable_read(struct counter_device *counter,
> > +				   struct counter_count *count, u8 *enable)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> >   	u32 cr1;
> >  =20
> >   	regmap_read(priv->regmap, TIM_CR1, &cr1);
> >  =20
> > -	return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN));
> > +	*enable =3D cr1 & TIM_CR1_CEN;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t stm32_count_enable_write(struct counter_device *counter,
> > -					struct counter_count *count,
> > -					void *private,
> > -					const char *buf, size_t len)
> > +static int stm32_count_enable_write(struct counter_device *counter,
> > +				    struct counter_count *count, u8 enable)
> >   {
> >   	struct stm32_timer_cnt *const priv =3D counter->priv;
> > -	int err;
> >   	u32 cr1;
> > -	bool enable;
> > -
> > -	err =3D kstrtobool(buf, &enable);
> > -	if (err)
> > -		return err;
> >  =20
> >   	if (enable) {
> >   		regmap_read(priv->regmap, TIM_CR1, &cr1);
> > @@ -236,46 +223,30 @@ static ssize_t stm32_count_enable_write(struct co=
unter_device *counter,
> >   	/* Keep enabled state to properly handle low power states */
> >   	priv->enabled =3D enable;
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static const struct counter_count_ext stm32_count_ext[] =3D {
> > -	{
> > -		.name =3D "direction",
> > -		.read =3D stm32_count_direction_read,
> > -	},
> > -	{
> > -		.name =3D "enable",
> > -		.read =3D stm32_count_enable_read,
> > -		.write =3D stm32_count_enable_write
> > -	},
> > -	{
> > -		.name =3D "ceiling",
> > -		.read =3D stm32_count_ceiling_read,
> > -		.write =3D stm32_count_ceiling_write
> > -	},
> > -};
> > -
> > -enum stm32_synapse_action {
> > -	STM32_SYNAPSE_ACTION_NONE,
> > -	STM32_SYNAPSE_ACTION_BOTH_EDGES
> > +static struct counter_data stm32_count_ext[] =3D {
> > +	COUNTER_DATA_DIRECTION(stm32_count_direction_read),
> > +	COUNTER_DATA_ENABLE(stm32_count_enable_read, stm32_count_enable_write=
),
> > +	COUNTER_DATA_CEILING(stm32_count_ceiling_read,
> > +			     stm32_count_ceiling_write),
> >   };
> >  =20
> > -static enum counter_synapse_action stm32_synapse_actions[] =3D {
> > -	[STM32_SYNAPSE_ACTION_NONE] =3D COUNTER_SYNAPSE_ACTION_NONE,
> > -	[STM32_SYNAPSE_ACTION_BOTH_EDGES] =3D COUNTER_SYNAPSE_ACTION_BOTH_EDG=
ES
> > +static const u8 stm32_synapse_actions[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> >   };
> >  =20
> >   static int stm32_action_get(struct counter_device *counter,
> >   			    struct counter_count *count,
> > -			    struct counter_synapse *synapse,
> > -			    size_t *action)
> > +			    struct counter_synapse *synapse, u8 *action)
> >   {
> > -	size_t function;
> > +	u8 function;
> >   	int err;
> >  =20
> >   	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
> > -	*action =3D STM32_SYNAPSE_ACTION_NONE;
> > +	*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >  =20
> >   	err =3D stm32_count_function_get(counter, count, &function);
> >   	if (err)
> > @@ -285,30 +256,22 @@ static int stm32_action_get(struct counter_device=
 *counter,
> >   	case STM32_COUNT_ENCODER_MODE_1:
> >   		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
> >   		if (synapse->signal->id =3D=3D count->synapses[0].signal->id)
> > -			*action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> >   	case STM32_COUNT_ENCODER_MODE_2:
> >   		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
> >   		if (synapse->signal->id =3D=3D count->synapses[1].signal->id)
> > -			*action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> >   	case STM32_COUNT_ENCODER_MODE_3:
> >   		/* counts up/down on both TI1FP1 and TI2FP2 edges */
> > -		*action =3D STM32_SYNAPSE_ACTION_BOTH_EDGES;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> >   	}
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static const struct counter_ops stm32_timer_cnt_ops =3D {
> > -	.count_read =3D stm32_count_read,
> > -	.count_write =3D stm32_count_write,
> > -	.function_get =3D stm32_count_function_get,
> > -	.function_set =3D stm32_count_function_set,
> > -	.action_get =3D stm32_action_get,
> > -};
> > -
> >   static struct counter_signal stm32_signals[] =3D {
> >   	{
> >   		.id =3D 0,
> > @@ -363,7 +326,11 @@ static int stm32_timer_cnt_probe(struct platform_d=
evice *pdev)
> >  =20
> >   	priv->counter.name =3D dev_name(dev);
> >   	priv->counter.parent =3D dev;
> > -	priv->counter.ops =3D &stm32_timer_cnt_ops;
> > +	priv->counter.count_read =3D stm32_count_read;
> > +	priv->counter.count_write =3D stm32_count_write;
> > +	priv->counter.function_read =3D stm32_count_function_get;
> > +	priv->counter.function_write =3D stm32_count_function_set;
> > +	priv->counter.action_read =3D stm32_action_get;
> >   	priv->counter.counts =3D &stm32_counts;
> >   	priv->counter.num_counts =3D 1;
> >   	priv->counter.signals =3D stm32_signals;
> > diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> > index 1ff07faef27f..7152f0b3c2de 100644
> > --- a/drivers/counter/ti-eqep.c
> > +++ b/drivers/counter/ti-eqep.c
> > @@ -13,6 +13,7 @@
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> >   #include <linux/regmap.h>
> > +#include <linux/types.h>
> >  =20
> >   /* 32-bit registers */
> >   #define QPOSCNT		0x0
> > @@ -80,12 +81,6 @@ enum {
> >   	TI_EQEP_COUNT_FUNC_DOWN_COUNT,
> >   };
> >  =20
> > -enum {
> > -	TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
> > -	TI_EQEP_SYNAPSE_ACTION_RISING_EDGE,
> > -	TI_EQEP_SYNAPSE_ACTION_NONE,
> > -};
> > -
> >   struct ti_eqep_cnt {
> >   	struct counter_device counter;
> >   	struct regmap *regmap32;
> > @@ -93,7 +88,7 @@ struct ti_eqep_cnt {
> >   };
> >  =20
> >   static int ti_eqep_count_read(struct counter_device *counter,
> > -			      struct counter_count *count, unsigned long *val)
> > +			      struct counter_count *count, u64 *val)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 cnt;
> > @@ -105,7 +100,7 @@ static int ti_eqep_count_read(struct counter_device=
 *counter,
> >   }
> >  =20
> >   static int ti_eqep_count_write(struct counter_device *counter,
> > -			       struct counter_count *count, unsigned long val)
> > +			       struct counter_count *count, u64 val)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 max;
> > @@ -117,33 +112,66 @@ static int ti_eqep_count_write(struct counter_dev=
ice *counter,
> >   	return regmap_write(priv->regmap32, QPOSCNT, val);
> >   }
> >  =20
> > +static const u8 ti_qep_t2c_functions_map[] =3D {
> > +};
> > +
> >   static int ti_eqep_function_get(struct counter_device *counter,
> > -				struct counter_count *count, size_t *function)
> > +				struct counter_count *count, u8 *function)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 qdecctl;
> >  =20
> >   	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
> > -	*function =3D (qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT;
> > +
> > +	switch ((qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT) {
> > +	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> > +		*function =3D COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
> > +		break;
> > +	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> > +		*function =3D COUNTER_COUNT_FUNCTION_PULSE_DIRECTION;
> > +		break;
> > +	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> > +		*function =3D COUNTER_COUNT_FUNCTION_INCREASE;
> > +		break;
> > +	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> > +		*function =3D COUNTER_COUNT_FUNCTION_DECREASE;
> > +		break;
> > +	}
> >  =20
> >   	return 0;
> >   }
> >  =20
> >   static int ti_eqep_function_set(struct counter_device *counter,
> > -				struct counter_count *count, size_t function)
> > +				struct counter_count *count, u8 function)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > +	unsigned long qsrc;
>=20
> Would be nice to give the enum that defines TI_EQEP_COUNT_FUNC_* a name
> and use that type.

Good idea. I'll do that.

> > +
> > +	switch (function) {
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
> > +		qsrc =3D TI_EQEP_COUNT_FUNC_QUAD_COUNT;
> > +		break;
> > +	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
> > +		qsrc =3D TI_EQEP_COUNT_FUNC_DIR_COUNT;
> > +		break;
> > +	case COUNTER_COUNT_FUNCTION_INCREASE:
> > +		qsrc =3D TI_EQEP_COUNT_FUNC_UP_COUNT;
> > +		break;
> > +	case COUNTER_COUNT_FUNCTION_DECREASE:
> > +		qsrc =3D TI_EQEP_COUNT_FUNC_DOWN_COUNT;
> > +		break;
> > +	}
> >  =20
> >   	return regmap_write_bits(priv->regmap16, QDECCTL, QDECCTL_QSRC,
> > -				 function << QDECCTL_QSRC_SHIFT);
> > +				 qsrc << QDECCTL_QSRC_SHIFT);
> >   }
> >  =20
> >   static int ti_eqep_action_get(struct counter_device *counter,
> >   			      struct counter_count *count,
> > -			      struct counter_synapse *synapse, size_t *action)
> > +			      struct counter_synapse *synapse, u8 *action)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > -	size_t function;
> > +	u8 function;
> >   	u32 qdecctl;
> >   	int err;
> >  =20
> > @@ -152,27 +180,27 @@ static int ti_eqep_action_get(struct counter_devi=
ce *counter,
> >   		return err;
> >  =20
> >   	switch (function) {
> > -	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
> > +	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
> >   		/* In quadrature mode, the rising and falling edge of both
> >   		 * QEPA and QEPB trigger QCLK.
> >   		 */
> > -		*action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> > +		*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   		break;
> > -	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
> > +	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
> >   		/* In direction-count mode only rising edge of QEPA is counted
> >   		 * and QEPB gives direction.
> >   		 */
> >   		switch (synapse->signal->id) {
> >   		case TI_EQEP_SIGNAL_QEPA:
> > -			*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   			break;
> >   		default:
> > -			*action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >   			break;
> >   		}
> >   		break;
> > -	case TI_EQEP_COUNT_FUNC_UP_COUNT:
> > -	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
> > +	case COUNTER_COUNT_FUNCTION_INCREASE:
> > +	case COUNTER_COUNT_FUNCTION_DECREASE:
> >   		/* In up/down-count modes only QEPA is counted and QEPB is not
> >   		 * used.
> >   		 */
> > @@ -183,134 +211,105 @@ static int ti_eqep_action_get(struct counter_de=
vice *counter,
> >   				return err;
> >  =20
> >   			if (qdecctl & QDECCTL_XCR)
> > -				*action =3D TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
> > +				*action =3D COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
> >   			else
> > -				*action =3D TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
> > +				*action =3D COUNTER_SYNAPSE_ACTION_RISING_EDGE;
> >   			break;
> >   		default:
> > -			*action =3D TI_EQEP_SYNAPSE_ACTION_NONE;
> > +			*action =3D COUNTER_SYNAPSE_ACTION_NONE;
> >   			break;
> >   		}
> >   		break;
> > +	default: return -EINVAL;
>=20
> Would be nice to put return on new line.

Sure, I'll move it down to its own line.

> >   	}
> >  =20
> >   	return 0;
> >   }
> >  =20
> > -static const struct counter_ops ti_eqep_counter_ops =3D {
> > -	.count_read	=3D ti_eqep_count_read,
> > -	.count_write	=3D ti_eqep_count_write,
> > -	.function_get	=3D ti_eqep_function_get,
> > -	.function_set	=3D ti_eqep_function_set,
> > -	.action_get	=3D ti_eqep_action_get,
> > -};
> > -
> > -static ssize_t ti_eqep_position_ceiling_read(struct counter_device *co=
unter,
> > -					     struct counter_count *count,
> > -					     void *ext_priv, char *buf)
> > +static int ti_eqep_position_ceiling_read(struct counter_device *counte=
r,
> > +					 struct counter_count *count,
> > +					 u64 *ceiling)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 qposmax;
> >  =20
> >   	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
> >  =20
> > -	return sprintf(buf, "%u\n", qposmax);
> > +	*ceiling =3D qposmax;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t ti_eqep_position_ceiling_write(struct counter_device *c=
ounter,
> > -					      struct counter_count *count,
> > -					      void *ext_priv, const char *buf,
> > -					      size_t len)
> > +static int ti_eqep_position_ceiling_write(struct counter_device *count=
er,
> > +					  struct counter_count *count,
> > +					  u64 ceiling)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > -	int err;
> > -	u32 res;
> >  =20
> > -	err =3D kstrtouint(buf, 0, &res);
> > -	if (err < 0)
> > -		return err;
> > +	if (ceiling !=3D (u32)ceiling)
> > +		return -ERANGE;
> >  =20
> > -	regmap_write(priv->regmap32, QPOSMAX, res);
> > +	regmap_write(priv->regmap32, QPOSMAX, ceiling);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t ti_eqep_position_floor_read(struct counter_device *coun=
ter,
> > -					   struct counter_count *count,
> > -					   void *ext_priv, char *buf)
> > +static int ti_eqep_position_floor_read(struct counter_device *counter,
> > +				       struct counter_count *count, u64 *floor)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 qposinit;
> >  =20
> >   	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
> >  =20
> > -	return sprintf(buf, "%u\n", qposinit);
> > +	*floor =3D qposinit;
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t ti_eqep_position_floor_write(struct counter_device *cou=
nter,
> > -					    struct counter_count *count,
> > -					    void *ext_priv, const char *buf,
> > -					    size_t len)
> > +static int ti_eqep_position_floor_write(struct counter_device *counter,
> > +					struct counter_count *count, u64 floor)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > -	int err;
> > -	u32 res;
> >  =20
> > -	err =3D kstrtouint(buf, 0, &res);
> > -	if (err < 0)
> > -		return err;
> > +	if (floor !=3D (u32)floor)
> > +		return -ERANGE;
> >  =20
> > -	regmap_write(priv->regmap32, QPOSINIT, res);
> > +	regmap_write(priv->regmap32, QPOSINIT, floor);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t ti_eqep_position_enable_read(struct counter_device *cou=
nter,
> > -					    struct counter_count *count,
> > -					    void *ext_priv, char *buf)
> > +static int ti_eqep_position_enable_read(struct counter_device *counter,
> > +					struct counter_count *count, u8 *enable)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> >   	u32 qepctl;
> >  =20
> >   	regmap_read(priv->regmap16, QEPCTL, &qepctl);
> >  =20
> > -	return sprintf(buf, "%u\n", !!(qepctl & QEPCTL_PHEN));
> > +	*enable =3D !!(qepctl & QEPCTL_PHEN);
> > +
> > +	return 0;
> >   }
> >  =20
> > -static ssize_t ti_eqep_position_enable_write(struct counter_device *co=
unter,
> > -					     struct counter_count *count,
> > -					     void *ext_priv, const char *buf,
> > -					     size_t len)
> > +static int ti_eqep_position_enable_write(struct counter_device *counte=
r,
> > +					 struct counter_count *count, u8 enable)
> >   {
> >   	struct ti_eqep_cnt *priv =3D counter->priv;
> > -	int err;
> > -	bool res;
> >  =20
> > -	err =3D kstrtobool(buf, &res);
> > -	if (err < 0)
> > -		return err;
> > -
> > -	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, res ? -1 : 0);
> > +	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : =
0);
> >  =20
> > -	return len;
> > +	return 0;
> >   }
> >  =20
> > -static struct counter_count_ext ti_eqep_position_ext[] =3D {
> > -	{
> > -		.name	=3D "ceiling",
> > -		.read	=3D ti_eqep_position_ceiling_read,
> > -		.write	=3D ti_eqep_position_ceiling_write,
> > -	},
> > -	{
> > -		.name	=3D "floor",
> > -		.read	=3D ti_eqep_position_floor_read,
> > -		.write	=3D ti_eqep_position_floor_write,
> > -	},
> > -	{
> > -		.name	=3D "enable",
> > -		.read	=3D ti_eqep_position_enable_read,
> > -		.write	=3D ti_eqep_position_enable_write,
> > -	},
> > +static struct counter_data ti_eqep_position_ext[] =3D {
> > +	COUNTER_DATA_CEILING(ti_eqep_position_ceiling_read,
> > +			     ti_eqep_position_ceiling_write),
> > +	COUNTER_DATA_FLOOR(ti_eqep_position_floor_read,
> > +			   ti_eqep_position_floor_write),
> > +	COUNTER_DATA_ENABLE(ti_eqep_position_enable_read,
> > +			    ti_eqep_position_enable_write),
> >   };
> >  =20
> >   static struct counter_signal ti_eqep_signals[] =3D {
> > @@ -324,17 +323,17 @@ static struct counter_signal ti_eqep_signals[] =
=3D {
> >   	},
> >   };
> >  =20
> > -static const enum counter_count_function ti_eqep_position_functions[] =
=3D {
> > -	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	=3D COUNTER_COUNT_FUNCTION_QUADRATURE=
_X4,
> > -	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	=3D COUNTER_COUNT_FUNCTION_PULSE_DIREC=
TION,
> > -	[TI_EQEP_COUNT_FUNC_UP_COUNT]	=3D COUNTER_COUNT_FUNCTION_INCREASE,
> > -	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	=3D COUNTER_COUNT_FUNCTION_DECREASE,
> > +static const u8 ti_eqep_position_functions[] =3D {
> > +	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
> > +	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> > +	COUNTER_COUNT_FUNCTION_INCREASE,
> > +	COUNTER_COUNT_FUNCTION_DECREASE,
> >   };
> >  =20
> > -static const enum counter_synapse_action ti_eqep_position_synapse_acti=
ons[] =3D {
> > -	[TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES]	=3D COUNTER_SYNAPSE_ACTION_BOTH_E=
DGES,
> > -	[TI_EQEP_SYNAPSE_ACTION_RISING_EDGE]	=3D COUNTER_SYNAPSE_ACTION_RISIN=
G_EDGE,
> > -	[TI_EQEP_SYNAPSE_ACTION_NONE]		=3D COUNTER_SYNAPSE_ACTION_NONE,
> > +static const u8 ti_eqep_position_synapse_actions[] =3D {
> > +	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
> > +	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > +	COUNTER_SYNAPSE_ACTION_NONE,
> >   };
> >  =20
> >   static struct counter_synapse ti_eqep_position_synapses[] =3D {
> > @@ -406,7 +405,11 @@ static int ti_eqep_probe(struct platform_device *p=
dev)
> >  =20
> >   	priv->counter.name =3D dev_name(dev);
> >   	priv->counter.parent =3D dev;
> > -	priv->counter.ops =3D &ti_eqep_counter_ops;
> > +	priv->counter.count_read =3D ti_eqep_count_read;
> > +	priv->counter.count_write =3D ti_eqep_count_write;
> > +	priv->counter.function_read =3D ti_eqep_function_get;
> > +	priv->counter.function_write =3D ti_eqep_function_set;
> > +	priv->counter.action_read =3D ti_eqep_action_get;
> >   	priv->counter.counts =3D ti_eqep_counts;
> >   	priv->counter.num_counts =3D ARRAY_SIZE(ti_eqep_counts);
> >   	priv->counter.signals =3D ti_eqep_signals;
> > diff --git a/include/linux/counter.h b/include/linux/counter.h
> > index 9dbd5df4cd34..76657d203a26 100644
> > --- a/include/linux/counter.h
> > +++ b/include/linux/counter.h
> > @@ -6,418 +6,157 @@
> >   #ifndef _COUNTER_H_
> >   #define _COUNTER_H_
> >  =20
> > -#include <linux/counter_enum.h>
> >   #include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/list.h>
> >   #include <linux/types.h>
> > -
> > -enum counter_count_direction {
> > -	COUNTER_COUNT_DIRECTION_FORWARD =3D 0,
> > -	COUNTER_COUNT_DIRECTION_BACKWARD
> > -};
> > -extern const char *const counter_count_direction_str[2];
> > -
> > -enum counter_count_mode {
> > -	COUNTER_COUNT_MODE_NORMAL =3D 0,
> > -	COUNTER_COUNT_MODE_RANGE_LIMIT,
> > -	COUNTER_COUNT_MODE_NON_RECYCLE,
> > -	COUNTER_COUNT_MODE_MODULO_N
> > -};
> > -extern const char *const counter_count_mode_str[4];
> > +#include <uapi/linux/counter.h>
> >  =20
> >   struct counter_device;
> > +struct counter_count;
> > +struct counter_synapse;
> >   struct counter_signal;
> >  =20
> > -/**
> > - * struct counter_signal_ext - Counter Signal extensions
> > - * @name:	attribute name
> > - * @read:	read callback for this attribute; may be NULL
> > - * @write:	write callback for this attribute; may be NULL
> > - * @priv:	data private to the driver
> > - */
> > -struct counter_signal_ext {
> > +enum counter_data_type {
> > +	COUNTER_DATA_TYPE_U8,
> > +	COUNTER_DATA_TYPE_U64,
> > +	COUNTER_DATA_TYPE_BOOL,
> > +	COUNTER_DATA_TYPE_SIGNAL,
>=20
> Does this mean signal name?

This represents the signal values "high" or "low". With the introduction
of this patchset, these values are no longer strings internally so I
gave them their own data type here.

> > +	COUNTER_DATA_TYPE_COUNT_FUNCTION,
> > +	COUNTER_DATA_TYPE_SYNAPSE_ACTION,
> > +	COUNTER_DATA_TYPE_ENUM,
>=20
> Why do some enums get their own type while others use a common
> generic ENUM type?

COUNTER_DATA_TYPE_ENUM is intended for driver-specific Counter enums.
This allows driver authors to define their own Counter enums so that we
don't pollute the Generic Counter interface with enums that are unique
to individual drivers.

> > +	COUNTER_DATA_TYPE_COUNT_DIRECTION,
> > +	COUNTER_DATA_TYPE_COUNT_MODE,
>=20
> Would be nice to group all COUNTER_DATA_TYPE_COUNT_* together

I assume you're referring to COUNTER_DATA_TYPE_COUNT_FUNCTION being
separate from these two. That's because a "count function" is actually
part of the Generic Counter paradigm: it's the trigger operation for the
Synapse.

In retrospect, I should have named it "trigger operation" or something
similar when I developed the paradigm originally, but hindsight is
20/20 (I'd probably rename "Synapse" to something else too if I could).
It's unfortunately too late to rename this because we've exposed it to
userspace already as a named sysfs attribute.

Perhaps I can rename this enum constant however to
COUNTER_DATA_TYPE_FUNCTION, or similar, to differentiate it from the
Count extensions.

> > +};
> > +
> > +struct counter_data {
>=20
> The stuct name is a bit confusing to me. The name sounds like data for the
> entire counter device, but the fields look like data for a single attribu=
te.
>=20
> Maybe struct counter_ext_data is a better name?

This structure is used by more than just the Counter extensions, so
maybe a different name than counter_ext_data. Regardless, I see what you
mean by counter_data being too general, so I'll see if I can come up
with another name.

> > +	enum counter_data_type type;
> >   	const char *name;
> > -	ssize_t (*read)(struct counter_device *counter,
> > -			struct counter_signal *signal, void *priv, char *buf);
> > -	ssize_t (*write)(struct counter_device *counter,
> > -			 struct counter_signal *signal, void *priv,
> > -			 const char *buf, size_t len);
> >   	void *priv;
> > +	union {
> > +		int (*action_read)(struct counter_device *counter,
> > +				   struct counter_count *count,
> > +				   struct counter_synapse *synapse, u8 *action);
> > +		int (*device_u8_read)(struct counter_device *counter, u8 *val);
> > +		int (*count_u8_read)(struct counter_device *counter,
> > +				     struct counter_count *count, u8 *val);
> > +		int (*signal_u8_read)(struct counter_device *counter,
> > +				      struct counter_signal *signal, u8 *val);
> > +		int (*device_u64_read)(struct counter_device *counter,
> > +				       u64 *val);
> > +		int (*count_u64_read)(struct counter_device *counter,
> > +				      struct counter_count *count, u64 *val);
> > +		int (*signal_u64_read)(struct counter_device *counter,
> > +				       struct counter_signal *signal, u64 *val);
> > +	};
> > +	union {
> > +		int (*action_write)(struct counter_device *counter,
> > +				    struct counter_count *count,
> > +				    struct counter_synapse *synapse, u8 action);
> > +		int (*device_u8_write)(struct counter_device *counter, u8 val);
> > +		int (*count_u8_write)(struct counter_device *counter,
> > +				      struct counter_count *count, u8 val);
> > +		int (*signal_u8_write)(struct counter_device *counter,
> > +				       struct counter_signal *signal, u8 val);
> > +		int (*device_u64_write)(struct counter_device *counter,
> > +					u64 val);
> > +		int (*count_u64_write)(struct counter_device *counter,
> > +				       struct counter_count *count, u64 val);
> > +		int (*signal_u64_write)(struct counter_device *counter,
> > +					struct counter_signal *signal, u64 val);
> > +	};
> >   };
> >  =20
> >   /**
> >    * struct counter_signal - Counter Signal node
> > - * @id:		unique ID used to identify signal
> > - * @name:	device-specific Signal name; ideally, this should match the =
name
> > - *		as it appears in the datasheet documentation
> > - * @ext:	optional array of Counter Signal extensions
> > - * @num_ext:	number of Counter Signal extensions specified in @ext
> > - * @priv:	optional private data supplied by driver
> > + * @id:		unique ID used to identify the Signal
> > + * @name:	device-specific Signal name
> > + * @ext:	optional array of Signal extensions
> > + * @num_ext:	number of Signal extensions specified in @ext
> >    */
> >   struct counter_signal {
> >   	int id;
> >   	const char *name;
> >  =20
> > -	const struct counter_signal_ext *ext;
> > +	struct counter_data *ext;
> >   	size_t num_ext;
> > -
> > -	void *priv;
> > -};
> > -
> > -/**
> > - * struct counter_signal_enum_ext - Signal enum extension attribute
> > - * @items:	Array of strings
> > - * @num_items:	Number of items specified in @items
> > - * @set:	Set callback function; may be NULL
> > - * @get:	Get callback function; may be NULL
> > - *
> > - * The counter_signal_enum_ext structure can be used to implement enum=
 style
> > - * Signal extension attributes. Enum style attributes are those which =
have a set
> > - * of strings that map to unsigned integer values. The Generic Counter=
 Signal
> > - * enum extension helper code takes care of mapping between value and =
string, as
> > - * well as generating a "_available" file which contains a list of all=
 available
> > - * items. The get callback is used to query the currently active item;=
 the index
> > - * of the item within the respective items array is returned via the '=
item'
> > - * parameter. The set callback is called when the attribute is updated=
; the
> > - * 'item' parameter contains the index of the newly activated item wit=
hin the
> > - * respective items array.
> > - */
> > -struct counter_signal_enum_ext {
> > -	const char * const *items;
> > -	size_t num_items;
> > -	int (*get)(struct counter_device *counter,
> > -		   struct counter_signal *signal, size_t *item);
> > -	int (*set)(struct counter_device *counter,
> > -		   struct counter_signal *signal, size_t item);
> > -};
> > -
> > -/**
> > - * COUNTER_SIGNAL_ENUM() - Initialize Signal enum extension
> > - * @_name:	Attribute name
> > - * @_e:		Pointer to a counter_signal_enum_ext structure
> > - *
> > - * This should usually be used together with COUNTER_SIGNAL_ENUM_AVAIL=
ABLE()
> > - */
> > -#define COUNTER_SIGNAL_ENUM(_name, _e) \
> > -{ \
> > -	.name =3D (_name), \
> > -	.read =3D counter_signal_enum_read, \
> > -	.write =3D counter_signal_enum_write, \
> > -	.priv =3D (_e) \
> > -}
> > -
> > -/**
> > - * COUNTER_SIGNAL_ENUM_AVAILABLE() - Initialize Signal enum available =
extension
> > - * @_name:	Attribute name ("_available" will be appended to the name)
> > - * @_e:		Pointer to a counter_signal_enum_ext structure
> > - *
> > - * Creates a read only attribute that lists all the available enum ite=
ms in a
> > - * newline separated list. This should usually be used together with
> > - * COUNTER_SIGNAL_ENUM()
> > - */
> > -#define COUNTER_SIGNAL_ENUM_AVAILABLE(_name, _e) \
> > -{ \
> > -	.name =3D (_name "_available"), \
> > -	.read =3D counter_signal_enum_available_read, \
> > -	.priv =3D (_e) \
> > -}
> > -
> > -enum counter_synapse_action {
> > -	COUNTER_SYNAPSE_ACTION_NONE =3D 0,
> > -	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
> > -	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
> > -	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
> >   };
> >  =20
> >   /**
> >    * struct counter_synapse - Counter Synapse node
> > - * @action:		index of current action mode
> >    * @actions_list:	array of available action modes
> >    * @num_actions:	number of action modes specified in @actions_list
> > - * @signal:		pointer to associated signal
> > + * @signal:		pointer to the associated Signal
> >    */
> >   struct counter_synapse {
> > -	size_t action;
> > -	const enum counter_synapse_action *actions_list;
> > +	const u8 *actions_list;
> >   	size_t num_actions;
> >  =20
> >   	struct counter_signal *signal;
> >   };
> >  =20
> > -struct counter_count;
> > -
> > -/**
> > - * struct counter_count_ext - Counter Count extension
> > - * @name:	attribute name
> > - * @read:	read callback for this attribute; may be NULL
> > - * @write:	write callback for this attribute; may be NULL
> > - * @priv:	data private to the driver
> > - */
> > -struct counter_count_ext {
> > -	const char *name;
> > -	ssize_t (*read)(struct counter_device *counter,
> > -			struct counter_count *count, void *priv, char *buf);
> > -	ssize_t (*write)(struct counter_device *counter,
> > -			 struct counter_count *count, void *priv,
> > -			 const char *buf, size_t len);
> > -	void *priv;
> > -};
> > -
> > -enum counter_count_function {
> > -	COUNTER_COUNT_FUNCTION_INCREASE =3D 0,
> > -	COUNTER_COUNT_FUNCTION_DECREASE,
> > -	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
> > -	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
> > -};
> > -
> >   /**
> >    * struct counter_count - Counter Count node
> > - * @id:			unique ID used to identify Count
> > - * @name:		device-specific Count name; ideally, this should match
> > - *			the name as it appears in the datasheet documentation
> > - * @function:		index of current function mode
> > - * @functions_list:	array available function modes
> > + * @id:			unique ID used to identify the Count
> > + * @name:		device-specific Count name
> > + * @functions_list:	array of available function modes
> >    * @num_functions:	number of function modes specified in @functions_l=
ist
> > - * @synapses:		array of synapses for initialization
> > - * @num_synapses:	number of synapses specified in @synapses
> > - * @ext:		optional array of Counter Count extensions
> > - * @num_ext:		number of Counter Count extensions specified in @ext
> > - * @priv:		optional private data supplied by driver
> > + * @synapses:		array of Synapses for initialization
> > + * @num_synapses:	number of Synapses specified in @synapses
> > + * @ext:		optional array of Count extensions
> > + * @num_ext:		number of Count extensions specified in @ext
> >    */
> >   struct counter_count {
> >   	int id;
> >   	const char *name;
> >  =20
> > -	size_t function;
> > -	const enum counter_count_function *functions_list;
> > +	const u8 *functions_list;
> >   	size_t num_functions;
> >  =20
> >   	struct counter_synapse *synapses;
> >   	size_t num_synapses;
> >  =20
> > -	const struct counter_count_ext *ext;
> > +	struct counter_data *ext;
> >   	size_t num_ext;
> > -
> > -	void *priv;
> > -};
> > -
> > -/**
> > - * struct counter_count_enum_ext - Count enum extension attribute
> > - * @items:	Array of strings
> > - * @num_items:	Number of items specified in @items
> > - * @set:	Set callback function; may be NULL
> > - * @get:	Get callback function; may be NULL
> > - *
> > - * The counter_count_enum_ext structure can be used to implement enum =
style
> > - * Count extension attributes. Enum style attributes are those which h=
ave a set
> > - * of strings that map to unsigned integer values. The Generic Counter=
 Count
> > - * enum extension helper code takes care of mapping between value and =
string, as
> > - * well as generating a "_available" file which contains a list of all=
 available
> > - * items. The get callback is used to query the currently active item;=
 the index
> > - * of the item within the respective items array is returned via the '=
item'
> > - * parameter. The set callback is called when the attribute is updated=
; the
> > - * 'item' parameter contains the index of the newly activated item wit=
hin the
> > - * respective items array.
> > - */
> > -struct counter_count_enum_ext {
> > -	const char * const *items;
> > -	size_t num_items;
> > -	int (*get)(struct counter_device *counter, struct counter_count *coun=
t,
> > -		   size_t *item);
> > -	int (*set)(struct counter_device *counter, struct counter_count *coun=
t,
> > -		   size_t item);
> >   };
> >  =20
> >   /**
> > - * COUNTER_COUNT_ENUM() - Initialize Count enum extension
> > - * @_name:	Attribute name
> > - * @_e:		Pointer to a counter_count_enum_ext structure
> > - *
> > - * This should usually be used together with COUNTER_COUNT_ENUM_AVAILA=
BLE()
> > - */
> > -#define COUNTER_COUNT_ENUM(_name, _e) \
> > -{ \
> > -	.name =3D (_name), \
> > -	.read =3D counter_count_enum_read, \
> > -	.write =3D counter_count_enum_write, \
> > -	.priv =3D (_e) \
> > -}
> > -
> > -/**
> > - * COUNTER_COUNT_ENUM_AVAILABLE() - Initialize Count enum available ex=
tension
> > - * @_name:	Attribute name ("_available" will be appended to the name)
> > - * @_e:		Pointer to a counter_count_enum_ext structure
> > - *
> > - * Creates a read only attribute that lists all the available enum ite=
ms in a
> > - * newline separated list. This should usually be used together with
> > - * COUNTER_COUNT_ENUM()
> > - */
> > -#define COUNTER_COUNT_ENUM_AVAILABLE(_name, _e) \
> > -{ \
> > -	.name =3D (_name "_available"), \
> > -	.read =3D counter_count_enum_available_read, \
> > -	.priv =3D (_e) \
> > -}
> > -
> > -/**
> > - * struct counter_device_attr_group - internal container for attribute=
 group
> > + * struct counter_attribute_group - internal container for attribute g=
roup
> >    * @attr_group:	Counter sysfs attributes group
> >    * @attr_list:	list to keep track of created Counter sysfs attributes
> >    * @num_attr:	number of Counter sysfs attributes
> >    */
> > -struct counter_device_attr_group {
> > +struct counter_attribute_group {
> >   	struct attribute_group attr_group;
> >   	struct list_head attr_list;
> >   	size_t num_attr;
> >   };
> >  =20
> > -/**
> > - * struct counter_device_state - internal state container for a Counte=
r device
> > - * @id:			unique ID used to identify the Counter
> > - * @dev:		internal device structure
> > - * @groups_list:	attribute groups list (for Signals, Counts, and ext)
> > - * @num_groups:		number of attribute groups containers
> > - * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
> > - */
> > -struct counter_device_state {
> > -	int id;
> > -	struct device dev;
> > -	struct counter_device_attr_group *groups_list;
> > -	size_t num_groups;
> > -	const struct attribute_group **groups;
> > -};
> > -
> > -enum counter_signal_value {
> > -	COUNTER_SIGNAL_LOW =3D 0,
> > -	COUNTER_SIGNAL_HIGH
> > -};
> > -
> > -/**
> > - * struct counter_ops - Callbacks from driver
> > - * @signal_read:	optional read callback for Signal attribute. The read
> > - *			value of the respective Signal should be passed back via
> > - *			the val parameter.
> > - * @count_read:		optional read callback for Count attribute. The read
> > - *			value of the respective Count should be passed back via
> > - *			the val parameter.
> > - * @count_write:	optional write callback for Count attribute. The write
> > - *			value for the respective Count is passed in via the val
> > - *			parameter.
> > - * @function_get:	function to get the current count function mode. Ret=
urns
> > - *			0 on success and negative error code on error. The index
> > - *			of the respective Count's returned function mode should
> > - *			be passed back via the function parameter.
> > - * @function_set:	function to set the count function mode. function is=
 the
> > - *			index of the requested function mode from the respective
> > - *			Count's functions_list array.
> > - * @action_get:		function to get the current action mode. Returns 0 on
> > - *			success and negative error code on error. The index of
> > - *			the respective Synapse's returned action mode should be
> > - *			passed back via the action parameter.
> > - * @action_set:		function to set the action mode. action is the index =
of
> > - *			the requested action mode from the respective Synapse's
> > - *			actions_list array.
> > - */
> > -struct counter_ops {
> > -	int (*signal_read)(struct counter_device *counter,
> > -			   struct counter_signal *signal,
> > -			   enum counter_signal_value *val);
> > -	int (*count_read)(struct counter_device *counter,
> > -			  struct counter_count *count, unsigned long *val);
> > -	int (*count_write)(struct counter_device *counter,
> > -			   struct counter_count *count, unsigned long val);
> > -	int (*function_get)(struct counter_device *counter,
> > -			    struct counter_count *count, size_t *function);
> > -	int (*function_set)(struct counter_device *counter,
> > -			    struct counter_count *count, size_t function);
> > -	int (*action_get)(struct counter_device *counter,
> > -			  struct counter_count *count,
> > -			  struct counter_synapse *synapse, size_t *action);
> > -	int (*action_set)(struct counter_device *counter,
> > -			  struct counter_count *count,
> > -			  struct counter_synapse *synapse, size_t action);
> > -};
> > -
> > -/**
> > - * struct counter_device_ext - Counter device extension
> > - * @name:	attribute name
> > - * @read:	read callback for this attribute; may be NULL
> > - * @write:	write callback for this attribute; may be NULL
> > - * @priv:	data private to the driver
> > - */
> > -struct counter_device_ext {
> > -	const char *name;
> > -	ssize_t (*read)(struct counter_device *counter, void *priv, char *buf=
);
> > -	ssize_t (*write)(struct counter_device *counter, void *priv,
> > -			 const char *buf, size_t len);
> > -	void *priv;
> > -};
> > -
> > -/**
> > - * struct counter_device_enum_ext - Counter enum extension attribute
> > - * @items:	Array of strings
> > - * @num_items:	Number of items specified in @items
> > - * @set:	Set callback function; may be NULL
> > - * @get:	Get callback function; may be NULL
> > - *
> > - * The counter_device_enum_ext structure can be used to implement enum=
 style
> > - * Counter extension attributes. Enum style attributes are those which=
 have a
> > - * set of strings that map to unsigned integer values. The Generic Cou=
nter enum
> > - * extension helper code takes care of mapping between value and strin=
g, as well
> > - * as generating a "_available" file which contains a list of all avai=
lable
> > - * items. The get callback is used to query the currently active item;=
 the index
> > - * of the item within the respective items array is returned via the '=
item'
> > - * parameter. The set callback is called when the attribute is updated=
; the
> > - * 'item' parameter contains the index of the newly activated item wit=
hin the
> > - * respective items array.
> > - */
> > -struct counter_device_enum_ext {
> > -	const char * const *items;
> > -	size_t num_items;
> > -	int (*get)(struct counter_device *counter, size_t *item);
> > -	int (*set)(struct counter_device *counter, size_t item);
> > -};
> > -
> > -/**
> > - * COUNTER_DEVICE_ENUM() - Initialize Counter enum extension
> > - * @_name:	Attribute name
> > - * @_e:		Pointer to a counter_device_enum_ext structure
> > - *
> > - * This should usually be used together with COUNTER_DEVICE_ENUM_AVAIL=
ABLE()
> > - */
> > -#define COUNTER_DEVICE_ENUM(_name, _e) \
> > -{ \
> > -	.name =3D (_name), \
> > -	.read =3D counter_device_enum_read, \
> > -	.write =3D counter_device_enum_write, \
> > -	.priv =3D (_e) \
> > -}
> > -
> > -/**
> > - * COUNTER_DEVICE_ENUM_AVAILABLE() - Initialize Counter enum available=
 extension
> > - * @_name:	Attribute name ("_available" will be appended to the name)
> > - * @_e:		Pointer to a counter_device_enum_ext structure
> > - *
> > - * Creates a read only attribute that lists all the available enum ite=
ms in a
> > - * newline separated list. This should usually be used together with
> > - * COUNTER_DEVICE_ENUM()
> > - */
> > -#define COUNTER_DEVICE_ENUM_AVAILABLE(_name, _e) \
> > -{ \
> > -	.name =3D (_name "_available"), \
> > -	.read =3D counter_device_enum_available_read, \
> > -	.priv =3D (_e) \
> > -}
> > -
> >   /**
> >    * struct counter_device - Counter data structure
> > - * @name:		name of the device as it appears in the datasheet
> > + * @name:		name of the device
> >    * @parent:		optional parent device providing the counters
> > - * @device_state:	internal device state container
> > - * @ops:		callbacks from driver
> > + * @signal_read:	optional read callback for Signals. The read value of
> > + *			the respective Signal should be passed back via the
> > + *			value parameter.
> > + * @count_read:		optional read callback for Counts. The read value of =
the
> > + *			respective Count should be passed back via the value
> > + *			parameter.
> > + * @count_write:	optional write callback for Counts. The write value f=
or
> > + *			the respective Count is passed in via the value
> > + *			parameter.
> > + * @function_read:	optional read callback the Count function modes. The
> > + *			read function mode of the respective Count should be
> > + *			passed back via the function parameter.
> > + * @function_write:	option write callback for Count function modes. The
> > + *			function mode to write for the respective Count is
> > + *			passed in via the function parameter.
> > + * @action_read:	optional read callback the Synapse action modes. The
> > + *			read action mode of the respective Synapse should be
> > + *			passed back via the action parameter.
> > + * @action_write:	option write callback for Synapse action modes. The
> > + *			action mode to write for the respective Synapse is
> > + *			passed in via the action parameter.
> >    * @signals:		array of Signals
>=20
> Why not keep the ops struct?

Defining static ops structures in the drivers seemed to have no
advantage when those callbacks are always used via the counter_device
structure. I decided it'd be simpler to just set them directly in the
counter_device structure then.

I could reorganize them into an ops structure again if there's enough
interest.

> >    * @num_signals:	number of Signals specified in @signals
> >    * @counts:		array of Counts
> > @@ -425,23 +164,50 @@ struct counter_device_enum_ext {
> >    * @ext:		optional array of Counter device extensions
> >    * @num_ext:		number of Counter device extensions specified in @ext
> >    * @priv:		optional private data supplied by driver
> > + * @id:			unique ID used to identify the Counter
> > + * @dev:		internal device structure
> > + * @dynamic_names_list:	list for dynamically allocated names
> > + * @groups_list:	attribute groups list (for Signals, Counts, and ext)
> > + * @num_groups:		number of attribute groups containers
> > + * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
> >    */
> >   struct counter_device {
> >   	const char *name;
> >   	struct device *parent;
> > -	struct counter_device_state *device_state;
> >  =20
> > -	const struct counter_ops *ops;
> > +	int (*signal_read)(struct counter_device *counter,
> > +			   struct counter_signal *signal, u8 *value);
> > +	int (*count_read)(struct counter_device *counter,
> > +			  struct counter_count *count, u64 *value);
> > +	int (*count_write)(struct counter_device *counter,
> > +			   struct counter_count *count, u64 value);
> > +	int (*function_read)(struct counter_device *counter,
> > +			     struct counter_count *count, u8 *function);
> > +	int (*function_write)(struct counter_device *counter,
> > +			      struct counter_count *count, u8 function);
> > +	int (*action_read)(struct counter_device *counter,
> > +			   struct counter_count *count,
> > +			   struct counter_synapse *synapse, u8 *action);
> > +	int (*action_write)(struct counter_device *counter,
> > +			    struct counter_count *count,
> > +			    struct counter_synapse *synapse, u8 action);
> >  =20
> >   	struct counter_signal *signals;
> >   	size_t num_signals;
> >   	struct counter_count *counts;
> >   	size_t num_counts;
> >  =20
> > -	const struct counter_device_ext *ext;
> > +	struct counter_data *ext;
> >   	size_t num_ext;
> >  =20
> >   	void *priv;
> > +
> > +	int id;
> > +	struct device dev;
> > +	struct list_head dynamic_names_list;
> > +	struct counter_attribute_group *groups_list;
> > +	size_t num_groups;
> > +	const struct attribute_group **groups;
> >   };
> >  =20
> >   int counter_register(struct counter_device *const counter);
> > @@ -451,4 +217,146 @@ int devm_counter_register(struct device *dev,
> >   void devm_counter_unregister(struct device *dev,
> >   			     struct counter_device *const counter);
> >  =20
> > +#define COUNTER_DATA_DEVICE_U8(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U8, \
> > +	.name =3D (_name), \
> > +	.device_u8_read =3D (_read), \
> > +	.device_u8_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_COUNT_U8(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U8, \
> > +	.name =3D (_name), \
> > +	.count_u8_read =3D (_read), \
> > +	.count_u8_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_SIGNAL_U8(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U8, \
> > +	.name =3D (_name), \
> > +	.signal_u8_read =3D (_read), \
> > +	.signal_u8_write =3D (_write), \
> > +}
> > +
> > +#define COUNTER_DATA_DEVICE_U64(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U64, \
> > +	.name =3D (_name), \
> > +	.device_u64_read =3D (_read), \
> > +	.device_u64_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_COUNT_U64(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U64, \
> > +	.name =3D (_name), \
> > +	.count_u64_read =3D (_read), \
> > +	.count_u64_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_SIGNAL_U64(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_U64, \
> > +	.name =3D (_name), \
> > +	.signal_u64_read =3D (_read), \
> > +	.signal_u64_write =3D (_write), \
> > +}
> > +
> > +#define COUNTER_DATA_DEVICE_BOOL(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_BOOL, \
> > +	.name =3D (_name), \
> > +	.device_u8_read =3D (_read), \
> > +	.device_u8_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_COUNT_BOOL(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_BOOL, \
> > +	.name =3D (_name), \
> > +	.count_u8_read =3D (_read), \
> > +	.count_u8_write =3D (_write), \
> > +}
> > +#define COUNTER_DATA_SIGNAL_BOOL(_name, _read, _write) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_BOOL, \
> > +	.name =3D (_name), \
> > +	.signal_u8_read =3D (_read), \
> > +	.signal_u8_write =3D (_write), \
> > +}
> > +
> > +struct counter_available {
> > +	union {
> > +		const u8 *items;
> > +		const char *const *enums;
>=20
> Isn't the items field supposed to be an array of enums?
> And the enums field is an array of strings?
>=20
> So maybe name them *enums and *strs instead?

All right, I can rename these.

Thanks,

William Breathitt Gray

> > +	};
> > +	size_t num_items;
> > +};
> > +
> > +#define DEFINE_COUNTER_AVAILABLE(_name, _items) \
> > +	struct counter_available _name =3D { \
> > +		.items =3D (_items), \
> > +		.num_items =3D ARRAY_SIZE(_items), \
> > +	}
> > +
> > +#define DEFINE_COUNTER_ENUM(_name, _enums) \
> > +	struct counter_available _name =3D { \
> > +		.enums =3D (_enums), \
> > +		.num_items =3D ARRAY_SIZE(_enums), \
> > +	}
> > +
> > +#define COUNTER_DATA_DEVICE_ENUM(_name, _get, _set, _available) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_ENUM, \
> > +	.name =3D (_name), \
> > +	.device_u8_read =3D (_get), \
> > +	.device_u8_write =3D (_set), \
> > +	.priv =3D &(_available), \
> > +}
> > +#define COUNTER_DATA_COUNT_ENUM(_name, _get, _set, _available) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_ENUM, \
> > +	.name =3D (_name), \
> > +	.count_u8_read =3D (_get), \
> > +	.count_u8_write =3D (_set), \
> > +	.priv =3D &(_available), \
> > +}
> > +#define COUNTER_DATA_SIGNAL_ENUM(_name, _get, _set, _available) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_ENUM, \
> > +	.name =3D (_name), \
> > +	.signal_u8_read =3D (_get), \
> > +	.signal_u8_write =3D (_set), \
> > +	.priv =3D &(_available), \
> > +}
> > +
> > +#define COUNTER_DATA_CEILING(_read, _write) \
> > +	COUNTER_DATA_COUNT_U64("ceiling", _read, _write)
> > +
> > +#define COUNTER_DATA_COUNT_MODE(_read, _write, _available) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_COUNT_MODE, \
> > +	.name =3D "count_mode", \
> > +	.count_u8_read =3D (_read), \
> > +	.count_u8_write =3D (_write), \
> > +	.priv =3D &(_available), \
> > +}
> > +
> > +#define COUNTER_DATA_DIRECTION(_read) \
> > +{ \
> > +	.type =3D COUNTER_DATA_TYPE_COUNT_DIRECTION, \
> > +	.name =3D "direction", \
> > +	.count_u8_read =3D (_read), \
> > +}
> > +
> > +#define COUNTER_DATA_ENABLE(_read, _write) \
> > +	COUNTER_DATA_COUNT_BOOL("enable", _read, _write)
> > +
> > +#define COUNTER_DATA_FLOOR(_read, _write) \
> > +	COUNTER_DATA_COUNT_U64("floor", _read, _write)
> > +
> > +#define COUNTER_DATA_PRESET(_read, _write) \
> > +	COUNTER_DATA_COUNT_U64("preset", _read, _write)
> > +
> > +#define COUNTER_DATA_PRESET_ENABLE(_read, _write) \
> > +	COUNTER_DATA_COUNT_BOOL("preset_enable", _read, _write)
> > +
> >   #endif /* _COUNTER_H_ */
> > diff --git a/include/linux/counter_enum.h b/include/linux/counter_enum.h
> > deleted file mode 100644
> > index 9f917298a88f..000000000000
> > --- a/include/linux/counter_enum.h
> > +++ /dev/null
> > @@ -1,45 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 */
> > -/*
> > - * Counter interface enum functions
> > - * Copyright (C) 2018 William Breathitt Gray
> > - */
> > -#ifndef _COUNTER_ENUM_H_
> > -#define _COUNTER_ENUM_H_
> > -
> > -#include <linux/types.h>
> > -
> > -struct counter_device;
> > -struct counter_signal;
> > -struct counter_count;
> > -
> > -ssize_t counter_signal_enum_read(struct counter_device *counter,
> > -				 struct counter_signal *signal, void *priv,
> > -				 char *buf);
> > -ssize_t counter_signal_enum_write(struct counter_device *counter,
> > -				  struct counter_signal *signal, void *priv,
> > -				  const char *buf, size_t len);
> > -
> > -ssize_t counter_signal_enum_available_read(struct counter_device *coun=
ter,
> > -					   struct counter_signal *signal,
> > -					   void *priv, char *buf);
> > -
> > -ssize_t counter_count_enum_read(struct counter_device *counter,
> > -				struct counter_count *count, void *priv,
> > -				char *buf);
> > -ssize_t counter_count_enum_write(struct counter_device *counter,
> > -				 struct counter_count *count, void *priv,
> > -				 const char *buf, size_t len);
> > -
> > -ssize_t counter_count_enum_available_read(struct counter_device *count=
er,
> > -					  struct counter_count *count,
> > -					  void *priv, char *buf);
> > -
> > -ssize_t counter_device_enum_read(struct counter_device *counter, void =
*priv,
> > -				 char *buf);
> > -ssize_t counter_device_enum_write(struct counter_device *counter, void=
 *priv,
> > -				  const char *buf, size_t len);
> > -
> > -ssize_t counter_device_enum_available_read(struct counter_device *coun=
ter,
> > -					   void *priv, char *buf);
> > -
> > -#endif /* _COUNTER_ENUM_H_ */
> > diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> > new file mode 100644
> > index 000000000000..2ddee9fc93e0
> > --- /dev/null
> > +++ b/include/uapi/linux/counter.h
> > @@ -0,0 +1,38 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Userspace ABI for Counter character devices
> > + * Copyright (C) 2020 William Breathitt Gray
> > + */
> > +#ifndef _UAPI_COUNTER_H_
> > +#define _UAPI_COUNTER_H_
> > +
> > +#define COUNTER_OWNER_TYPE_DEVICE 0
> > +#define COUNTER_OWNER_TYPE_SIGNAL 1
> > +#define COUNTER_OWNER_TYPE_COUNT 2
> > +
> > +#define COUNTER_COUNT_DIRECTION_FORWARD 0
> > +#define COUNTER_COUNT_DIRECTION_BACKWARD 1
> > +
> > +#define COUNTER_COUNT_MODE_NORMAL 0
> > +#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
> > +#define COUNTER_COUNT_MODE_NON_RECYCLE 2
> > +#define COUNTER_COUNT_MODE_MODULO_N 3
> > +
> > +#define COUNTER_COUNT_FUNCTION_INCREASE 0
> > +#define COUNTER_COUNT_FUNCTION_DECREASE 1
> > +#define COUNTER_COUNT_FUNCTION_PULSE_DIRECTION 2
> > +#define COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A 3
> > +#define COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B 4
> > +#define COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A 5
> > +#define COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B 6
> > +#define COUNTER_COUNT_FUNCTION_QUADRATURE_X4 7
> > +
> > +#define COUNTER_SIGNAL_LOW 0
> > +#define COUNTER_SIGNAL_HIGH 1
> > +
> > +#define COUNTER_SYNAPSE_ACTION_NONE 0
> > +#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
> > +#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
> > +#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
> > +
> > +#endif /* _UAPI_COUNTER_H_ */
> >=20
>=20

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEk5I4PDJ2w1cDf/bghvpINdm7VJIFAl8nKkIACgkQhvpINdm7
VJJjnBAA2DoJO2SyMOIllkoXEku1j1B+XTf+0ZNZHSV49MCt04dkOEX/+J3dYBBN
H8xwMkHC8E43jkgMB03kCqgvobkyBP1pLTRrko06vKH/zBbJv80dWKQLnPHAS/RE
aBSNV4RQGmsPMjjFRumHkeOCtgKLdcLsp8aq/m/DFBe5G1OjX2lq+UZavB3tU9iD
0LUNWSvAvVBRpojTjyQeqBTVFKiX7gIbJim+LxE8EjuHpwe2nyKtJC1tL65mUuUf
hMxjacQ2hSvRwsAw3CGowFay4kcYKDMcwfPVvHk1mThBc7JY+65rSlAg692OISD9
bbn74bY/jN6wq2MiQfa0nm+FEDSTukNtMwMCOjslgTFlqW1kbn7pd+bNIepACqxt
+4NOkXDRIRRaSz4doM+qCX5HOhQJ/Xfwj6bRAUWa4+XBGdOrVdMCEnm52OLrHYB6
gqVUFTjsmSAO2WZTRPM6oNaYEQC60tyLVJzQZ/Twuwn7OrV1piOmhMfvyZhzd+fk
dnaRyRoW89YztQXgwl5sxj2T5IwhsNaEVRTLHCauB23yTebe62oHH68Os0PrLZlb
1JZ1j6TQQC3FO8v1KxoCxbbuOLS8f34pvpb7Oi6g+93P8SmykFDxU4NkYkecvO+b
7qQEsk7cDq9f3n/bsLf6XBiOrSA64a3eJ6RpOCQoYFgKGqynKgo=
=YMSp
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
