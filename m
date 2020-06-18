Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D34DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 04:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94C82186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 04:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WO4NeEsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFRE7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 00:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgFRE7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 00:59:47 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F532C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 21:59:45 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d27so2671475lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 21:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gC1sdqM+SlQgZ8LyixOr+vO5mqg+xhNICeiFoUUvAG4=;
        b=WO4NeEsLfCzmMKr6ch5J0I4aGfwgHagG69EzZDcyDnb8/8rwBu0I5XtArZJzEy/gRV
         nkisyDrAgKN68Jz9d7TKiBb1uN8OsJ7/Z4feeIhF4H1DH+BQbyOuycVPT74IflAddk3J
         5GEThXg6dD+Kp4ULNVl/2BNiVXwFgo0ywa9IANBwdLsgx8cnt/JOrfN++rYE9gITaLKv
         IP/aJGxC8hxKrIUNhySUNx+h1lcigRCTdHQRyAIAWjAED3VW1TcWRd71obap64J6TrbN
         36E21i+Ui4F16AKNRDzDWWmffpIM9ykIfkl3KTLXN31C3jpUXehXiFp9fV+LE5/yqRrW
         Sbvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC1sdqM+SlQgZ8LyixOr+vO5mqg+xhNICeiFoUUvAG4=;
        b=d9GggavLTLiMeOsOoujAc2eiCGZMih+aOEL2GcMrtyT9RrAbhrzAIQj77T8gL2Q3Ua
         FdNXbgzbdSnMAsksWjUUdHkYTVp33FFFrDbIkhKxbudaXf45yEOLXia7NeC/4WBUZeJh
         HEyf5xII/p7C0xFTiGsJ9B0WSUAcZ3UfQaKfjJjCdDZ18KSnJX3RmaDwFCVj4BKPYZCZ
         yfdsVUJ9gOIrU8dcbbuD4gqV/c5dhQhkwR+eHhvJ+v8TOWD8lemhfQ+tLYFS1t7kW/fq
         c/mHY0oRCWqGANDGaC90jRT5qRKzsLqgqQYw6OWXAMiW5S1KotztpqyVEXfemokqlv7L
         oJxA==
X-Gm-Message-State: AOAM531rz/1mBIzHGKRkYgy+g77PVbYxJeVHhCTq+4URIGNF9t3bTu5T
        f9Su7FCplws9bN5RNqLdN4Mcua1eqakeZ7KxkIKUFw==
X-Google-Smtp-Source: ABdhPJwNxlV/8q83DlZe+hudR1A3bgiAsS/XhkJ5ubd7vbS7vxryM21PGYmc/sIcjJtGmOk3gjw6H9yZ/M1SqCfAnK8=
X-Received: by 2002:a19:6c5:: with SMTP id 188mr1271905lfg.15.1592456383931;
 Wed, 17 Jun 2020 21:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200604175851.758-1-maxim.uvarov@linaro.org> <20200604175851.758-2-maxim.uvarov@linaro.org>
 <CAFA6WYNVk1RcaqnL0FGyYkB+hGkgyqeOMsSKyySL=zfCdNUZXA@mail.gmail.com> <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
In-Reply-To: <b9960a51-7e00-4992-eed5-bd43e7f27b43@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 18 Jun 2020 10:29:31 +0530
Message-ID: <CAFA6WYM6XBduokYOdnWD6m+To=6k2SMbXU=HzK_Enk9h-s7VBQ@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv8 1/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Wed, 17 Jun 2020 at 20:46, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 6/17/20 3:58 PM, Sumit Garg wrote:
> > Hi Maxim,
> >
> > On Thu, 4 Jun 2020 at 23:28, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >>
> >> With the evolving use-cases for TEE bus, now it's required to support
> >> multi-stage enumeration process. But using a simple index doesn't
> >> suffice this requirement and instead leads to duplicate sysfs entries.
> >> So instead switch to use more informative device UUID for sysfs entry
> >> like:
> >> /sys/bus/tee/devices/optee-ta-<uuid>
> >>
> >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >> ---
> >>  Documentation/ABI/testing/sysfs-bus-optee-devices | 8 ++++++++
> >>  MAINTAINERS                                       | 1 +
> >>  drivers/tee/optee/device.c                        | 9 ++++++---
> >>  3 files changed, 15 insertions(+), 3 deletions(-)
> >>  create mode 100644 Documentation/ABI/testing/sysfs-bus-optee-devices
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-bus-optee-devices b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >> new file mode 100644
> >> index 000000000000..0ae04ae5374a
> >> --- /dev/null
> >> +++ b/Documentation/ABI/testing/sysfs-bus-optee-devices
> >> @@ -0,0 +1,8 @@
> >> +What:          /sys/bus/tee/devices/optee-ta-<uuid>/
> >> +Date:           May 2020
> >> +KernelVersion   5.7
> >> +Contact:        tee-dev@lists.linaro.org
> >> +Description:
> >> +               OP-TEE bus provides reference to registered drivers under this directory. The <uuid>
> >> +               matches Trusted Application (TA) driver and corresponding TA in secure OS. Drivers
> >> +               are free to create needed API under optee-ta-<uuid> directory.
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index ecc0749810b0..6717afef2de3 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -12516,6 +12516,7 @@ OP-TEE DRIVER
> >>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> >>  L:     tee-dev@lists.linaro.org
> >>  S:     Maintained
> >> +F:     Documentation/ABI/testing/sysfs-bus-optee-devices
> >>  F:     drivers/tee/optee/
> >>
> >>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
> >> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> >> index e3a148521ec1..23d264c8146e 100644
> >> --- a/drivers/tee/optee/device.c
> >> +++ b/drivers/tee/optee/device.c
> >> @@ -65,7 +65,7 @@ static int get_devices(struct tee_context *ctx, u32 session,
> >>         return 0;
> >>  }
> >>
> >> -static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >> +static int optee_register_device(const uuid_t *device_uuid)
> >>  {
> >>         struct tee_client_device *optee_device = NULL;
> >>         int rc;
> >> @@ -75,7 +75,10 @@ static int optee_register_device(const uuid_t *device_uuid, u32 device_id)
> >>                 return -ENOMEM;
> >>
> >>         optee_device->dev.bus = &tee_bus_type;
> >> -       dev_set_name(&optee_device->dev, "optee-clnt%u", device_id);
> >> +       if (dev_set_name(&optee_device->dev, "optee-ta-%pUl", device_uuid)) {
> >
> > You should be using format specifier as: "%pUb" instead of "%pUl" as
> > UUID representation for TAs is in big endian format. See below:
>
> Where does device_uuid come from? If it comes directly from OP-TEE, then
> it should be a pointer to the following struct:
>
> typedef struct
> {
>         uint32_t timeLow;
>         uint16_t timeMid;
>         uint16_t timeHiAndVersion;
>         uint8_t clockSeqAndNode[8];
> } TEE_UUID;
>
> (GlobalPlatform TEE Internal Core API spec v1.2.1 section 3.2.4)
>
> - The spec does not mandate any particular endianness and simply warns
> about possible issues if secure and non-secure worlds differ in endianness.
> - OP-TEE uses %pUl assuming that host order is little endian (that is
> true for the Arm platforms that run OP-TEE currently). By the same logic
> %pUl should be fine in the kernel.
> - On the other hand, the UUID in a Trusted App header is always encoded
> big endian by the Python script that signs and optionally encrypts the
> TA. This should not have any visible impact on UUIDs exchanged between
> the secure and non-secure world though.
>
> So I am wondering why you had to use %pUb. There must be some
> inconsistency somewhere :-/

Yes there is. Linux stores UUID in big endian format (16 byte octets)
and OP-TEE stores UUID in little endian format (in form of struct you
referenced above).

And format conversion APIs [1] in OP-TEE OS are used while passing
UUID among Linux and OP-TEE.

So we need to use %pUb in case of Linux and %pUl in case of OP-TEE.

[1] https://github.com/OP-TEE/optee_os/blob/master/core/tee/uuid.c

-Sumit

>
> --
> Jerome
>
> >
> > # ls /sys/bus/tee/devices/
> > optee-ta-405b6ad9-e5c3-e321-8794-1002a5d5c61b
> > optee-ta-71d950bc-c9d4-c442-82cb-343fb7f37896
> > optee-ta-e70f4af0-5d1f-9b4b-abf7-619b85b4ce8c
> >
> > While UUID for fTPM TA is in big endian format:
> > bc50d971-d4c9-42c4-82cb-343fb7f37896
> >
> > Sorry that I missed it during review and noticed this while testing.
> >
> > With the above fix included, I tested this series using fTPM early TA
> > on Qemu for aarch64 and used basic random number generation test using
> > tpm2-tools. So feel free to add:
> >
> > Tested-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > -Sumit
> >
> >> +               kfree(optee_device);
> >> +               return -ENOMEM;
> >> +       }
> >>         uuid_copy(&optee_device->id.uuid, device_uuid);
> >>
> >>         rc = device_register(&optee_device->dev);
> >> @@ -144,7 +147,7 @@ int optee_enumerate_devices(void)
> >>         num_devices = shm_size / sizeof(uuid_t);
> >>
> >>         for (idx = 0; idx < num_devices; idx++) {
> >> -               rc = optee_register_device(&device_uuid[idx], idx);
> >> +               rc = optee_register_device(&device_uuid[idx]);
> >>                 if (rc)
> >>                         goto out_shm;
> >>         }
> >> --
> >> 2.17.1
> >>
> > _______________________________________________
> > Tee-dev mailing list
> > Tee-dev@lists.linaro.org
> > https://lists.linaro.org/mailman/listinfo/tee-dev
> >
