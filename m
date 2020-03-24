Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD90C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B732070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DOdY1ocr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCXUff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:35:35 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:41920 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgCXUfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:35:34 -0400
Received: by mail-il1-f194.google.com with SMTP id l14so18100662ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wuNjlC6FefbIyXd4o0ORbiNgCLB7pgeos8yCTk+cu8=;
        b=DOdY1ocrt85K2YjlHKS+d9RgkvF9NqcPErN4Ng41pyVcEW2zFYLEo/FjaI3WYejwhi
         PpHpo4LXu7poEOpk1ttu/qAEnXXUfe+oKMO4zCmBhNBH5u9YLJYTzzqy1m9+1+4zvT3E
         SFIkdjYb87wP2H58/3a7HnuKXzNaGYYbFCN3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wuNjlC6FefbIyXd4o0ORbiNgCLB7pgeos8yCTk+cu8=;
        b=bJDiw8Tl1OHhnyZ9x7V9995+EpVtKQfjs9ksk0L6Zg9cDEa1M/0L4R/RnUTDJf4zA5
         PpC6CviGkW75sSUC0XdkztHHAIn8A+20diIKzgiEhjorkKqUuwzPsjRGdcomy7kEl7Kk
         rvgnS9X1SC8hFdYvkAh0omfjzviKqdX8iidDqunfNOyhrYsy9u0dLAZuOcjsUINweJuu
         DTrp8KwcaFzimznvIPtuaiNzTXWb6dKCpx5iYD1kU6079jGFa5otGQyaBAzkjoxtkwG2
         f/E9eLdtfKiSqIxJB3QHd0986PUiQPs3sSgpIrGuWLahM3rh2KBmM20fKSCC3jaXEPRC
         cqHg==
X-Gm-Message-State: ANhLgQ3fMN+dxyBwraJ8vUC3wDRXJVu1BVW67tYm0UXqbEp9hrMOcgov
        oOqZLsADRFAUWVnp5OCvQwyQhRBg82sIxOPKOt/+6A==
X-Google-Smtp-Source: ADFU+vtk/h4HDINRKy26KTVSHjPfqc0zhHep0xn7sSrVcrL6o+gLUzIBc1BV+OB0wXXGDHBmJEmpI6hLUHGPYUwYnas=
X-Received: by 2002:a92:d702:: with SMTP id m2mr188814iln.149.1585082132061;
 Tue, 24 Mar 2020 13:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200312071949.145300-1-gwendal@chromium.org> <692f5e9e-ff20-fd07-327a-223e254e413a@collabora.com>
 <CAPUE2uuTa8JS4g7vSZsypv6F6gcJOa7RW_35RcC7QAB6pu32xQ@mail.gmail.com> <4c58bd89-1929-fbdb-018e-c37c4d16e52d@collabora.com>
In-Reply-To: <4c58bd89-1929-fbdb-018e-c37c4d16e52d@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 24 Mar 2020 13:35:19 -0700
Message-ID: <CAPUE2usPr5PQ7XajMk4fhmojyxHb2PZTqGRGHB5MeO6jOUNzQg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/chrome: Update cros_ec_commands.h to latest
 ec commands
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 1:00 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> On 13/3/20 1:02, Gwendal Grignou wrote:
> > On Thu, Mar 12, 2020 at 2:48 AM Enric Balletbo i Serra
> > <enric.balletbo@collabora.com> wrote:
> >>
> >> Hi Gwendal,
> >>
> >> Many thanks to send this patch upstream.
> >>
> >> On 12/3/20 8:19, Gwendal Grignou wrote:
> >>> Update from EC code base
> >>> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
> >>> Formatted to match kernel syntax.
> >>>
> >>
> >> I know that is a bit more of work, but I suspect we will have other patches to
> >> sync the ec_command file, and I wouldn't like to end with a bunch of patches
> >> only saying `Update cros_ec_commands.h to latest ec commands` in our git log
> >> which is meaningless.
> >>
> >> Could we split that patch per command functionality, so it's clear which exact
> >> command we're introducing?
Yes. I can add the changes on a need basis, when the command is really
used by the kernel. Although it is possible some commands will be used
by command space directly, that will add holes in the command space
however.
> >>
> >> (If you are fine with this approach but you don't have time, I am volunteer to
> >> split that patch, just let me know ;-) )
> > Thanks.
> > Before we split this CL, let me fix the kenel-doc issues in the
> > original file on the firmware side, as cros_ec_commands.h file is
> > autogenerated.
>
> For next changes, would make sense adding me as a reviewer in the firmware CL,
> so I can give my feedback earlier?
Sure
>
> Cheers,
>  Enric
>
>
> >>
> >> The comments below are just minor kernel-doc format issues, but there is a lot
> >> of them. Just make sure that if you use kernel-doc doesn't report a warning when
> >> generate the documentation, or don't use kernel-doc.
> >>
> >>> Add new commands:
> >>> EC_CMD_RAND_NUM : Request random numbers.
> >>> EC_CMD_RWSIG_INFO: Key information
> >>> EC_CMD_MKBP_WAKE_MASK: Define wake up mask for MKBP events.
> >>> EC_CMD_LOCATE_CHIP: For power delivery
> >>> EC_CMD_REBOOT_AP_ON_G3: For testing purposes
> >>> EC_CMD_GET_PD_PORT_CAPS: Get PD device information
> >>> EC_CMD_FP_READ_MATCH_SECRET: Used for Finger print sensor management.
> >>>
> >>
> >> Note that we should also update the cros_ec_trace to match current commands.
> >>
> >>> Update commands:
> >>> EC_CMD_POWER_INFO (v0 was not used in the kernel)
> >>> EC_CMD_MOTION_SENSE_CMD (Add calibration mode, online calibration info).
> >>>
> >>> Add new Mems sensors.
> >>>
> >>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> >>> ---
> >>> Changes since v1: Include limits.h as U16_MAX is used.
> >>>
> >>>  .../linux/platform_data/cros_ec_commands.h    | 605 ++++++++++++++++--
> >>>  1 file changed, 555 insertions(+), 50 deletions(-)
> >>>
> >>> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> >>> index 69210881ebac8..db23bcc464dc1 100644
> >>> --- a/include/linux/platform_data/cros_ec_commands.h
> >>> +++ b/include/linux/platform_data/cros_ec_commands.h
> >>> @@ -15,9 +15,10 @@
> >>>
> >>>
> >>>
> >>> -
> >>
> >> Please remove that change as is unrelated
> >>
> >>>  #define BUILD_ASSERT(_cond)
> >>>
> >>> +#include <linux/limits.h>
> >>> +
> >>>  /*
> >>>   * Current version of this protocol
> >>>   *
> >>> @@ -400,7 +401,7 @@
> >>>   * parent structure that the alignment will still be true given the packing of
> >>>   * the parent structure.  This is particularly important if the sub-structure
> >>>   * will be passed as a pointer to another function, since that function will
> >>> - * not know about the misaligment caused by the parent structure's packing.
> >>> + * not know about the misalignment caused by the parent structure's packing.
> >>
> >> This is a typo fix.
> >>
> >>>   *
> >>>   * Also be very careful using __packed - particularly when nesting non-packed
> >>>   * structures inside packed ones.  In fact, DO NOT use __packed directly;
> >>> @@ -456,8 +457,7 @@
> >>>       (EC_LPC_STATUS_FROM_HOST | EC_LPC_STATUS_PROCESSING)
> >>>
> >>>  /*
> >>> - * Host command response codes (16-bit).  Note that response codes should be
> >>> - * stored in a uint16_t rather than directly in a value of this type.
> >>> + * Host command response codes (16-bit).
> >>>   */
> >>>  enum ec_status {
> >>>       EC_RES_SUCCESS = 0,
> >>> @@ -481,7 +481,10 @@ enum ec_status {
> >>>       EC_RES_INVALID_HEADER_CRC = 18,      /* Header CRC invalid */
> >>>       EC_RES_INVALID_DATA_CRC = 19,        /* Data CRC invalid */
> >>>       EC_RES_DUP_UNAVAILABLE = 20,         /* Can't resend response */
> >>> -};
> >>> +
> >>> +     EC_RES_MAX = U16_MAX            /**< Force enum to be 16 bits */
> >>
> >> This is not a kernel-doc comment, so should be just:
> >> /* Force enum to be 16 bits */
> >>
> >>> +} __packed;
> >>> +BUILD_ASSERT(sizeof(enum ec_status) == sizeof(uint16_t));
> >>>
> >>>  /*
> >>>   * Host event codes.  Note these are 1-based, not 0-based, because ACPI query
> >>> @@ -550,7 +553,12 @@ enum host_event_code {
> >>>       /* EC desires to change state of host-controlled USB mux */
> >>>       EC_HOST_EVENT_USB_MUX = 28,
> >>>
> >>> -     /* TABLET/LAPTOP mode or detachable base attach/detach event */
> >>> +     /*
> >>> +      * The device has changed "modes". This can be one of the following:
> >>> +      *
> >>> +      * - TABLET/LAPTOP mode
> >>> +      * - detachable base attach/detach event
> >>> +      */
> >>
> >> I don't see a lot more value on this new comment than the old one. Is really
> >> needed to update that comment?
> > To make it clear a given device can only change within 2 sets of modes.
> >>
> >>>       EC_HOST_EVENT_MODE_CHANGE = 29,
> >>>
> >>>       /* Keyboard recovery combo with hardware reinitialization */
> >>> @@ -963,10 +971,14 @@ struct ec_response_hello {
> >>>  /* Get version number */
> >>>  #define EC_CMD_GET_VERSION 0x0002
> >>>
> >>> -enum ec_current_image {
> >>> +
> >>> +enum ec_image {
> >>>       EC_IMAGE_UNKNOWN = 0,
> >>>       EC_IMAGE_RO,
> >>> -     EC_IMAGE_RW
> >>> +     EC_IMAGE_RW,
> >>> +     EC_IMAGE_RW_A = EC_IMAGE_RW,
> >>
> >> That's weird, why define EC_IMAGE_RW_A? Can we just use EC_IMAGE_RW?
> > To make it clear some newer EC have 2 images, while preserving
> > backward compatibility.
> > Coreboot has the same layout: RO, RW_A and RW_B.
> >>
> >>> +     EC_IMAGE_RO_B,
> >>> +     EC_IMAGE_RW_B
> >>
> >> Add a colon at the end so if you add a new enum value the diff will be more clear.
> >>
> >>>  };
> >>>
> >>>  /**
> >>> @@ -974,7 +986,7 @@ enum ec_current_image {
> >>>   * @version_string_ro: Null-terminated RO firmware version string.
> >>>   * @version_string_rw: Null-terminated RW firmware version string.
> >>>   * @reserved: Unused bytes; was previously RW-B firmware version string.
> >>> - * @current_image: One of ec_current_image.
> >>> + * @current_image: One of ec_image.
> >>>   */
> >>>  struct ec_response_get_version {
> >>>       char version_string_ro[32];
> >>> @@ -1679,6 +1691,82 @@ struct ec_params_flash_select {
> >>>  } __ec_align4;
> >>>
> >>>
> >>> +/**
> >>> + * Request random numbers to be generated and returned.
> >>
> >> This will trigger a kernel-doc warning. Fix the warning or just don't use
> >> kernel-doc format (/*)
> >>
> >>> + * Can be used to test the random number generator is truly random.
> >>> + * See https://csrc.nist.gov/publications/detail/sp/800-22/rev-1a/final and
> >>> + * https://webhome.phy.duke.edu/~rgb/General/dieharder.php.
> >>> + */
> >>> +#define EC_CMD_RAND_NUM      0x001A
> >>> +#define EC_VER_RAND_NUM 0
> >>> +
> >>> +struct ec_params_rand_num {
> >>> +     uint16_t num_rand_bytes;        /**< num random bytes to generate */
> >>
> >> Not a proper kernel-doc comment, just (/*)?
> >>
> >>> +} __ec_align4;
> >>> +
> >>> +struct ec_response_rand_num {
> >>> +     uint8_t rand[0];                /**< generated random numbers */
> >>
> >> Not a proper kernel-doc comment, just (/*)?
> >>
> >>> +} __ec_align4;
> >>> +
> >>> +BUILD_ASSERT(sizeof(struct ec_response_rand_num) == 0);
> >>> +
> >>> +/**
> >>
> >> This will trigger a kernel-doc warning. Fix the warning or just don't use
> >> kernel-doc format (/*)
> >>
> >>> + * Get information about the key used to sign the RW firmware.
> >>> + * For more details on the fields, see "struct vb21_packed_key".
> >>> + */
> >>> +#define EC_CMD_RWSIG_INFO 0x001B
> >>> +#define EC_VER_RWSIG_INFO 0
> >>> +
> >>> +#define VBOOT2_KEY_ID_BYTES 20
> >>> +
> >>> +
> >>
> >> Remove the extra line.
> >>
> >>> +struct ec_response_rwsig_info {
> >>> +     /**
> >>> +      * Signature algorithm used by the key
> >>> +      * (enum vb2_signature_algorithm).
> >>> +      */
> >>> +     uint16_t sig_alg;
> >>> +
> >>> +     /**
> >>> +      * Hash digest algorithm used with the key
> >>> +      * (enum vb2_hash_algorithm).
> >>> +      */
> >>> +     uint16_t hash_alg;
> >>> +
> >>> +     /** Key version. */
> >>> +     uint32_t key_version;
> >>> +
> >>> +     /** Key ID (struct vb2_id). */
> >>> +     uint8_t key_id[VBOOT2_KEY_ID_BYTES];
> >>> +
> >>> +     uint8_t key_is_valid;
> >>> +
> >>> +     /** Alignment padding. */
> >>> +     uint8_t reserved[3];
> >>> +} __ec_align4;
> >>> +
> >>
> >> Use proper kernel-doc or remove it.
> >>
> >>> +BUILD_ASSERT(sizeof(struct ec_response_rwsig_info) == 32);
> >>> +
> >>> +/**
> >>
> >> This will trigger a kernel-doc warning. Fix the warning or just don't use
> >> kernel-doc format (/*)
> >>
> >> There are more kernel-doc issues below, but all are the same as above, so I'll
> >> stop commenting those from now.
> >>
> >>
> >>> + * Get information about the system, such as reset flags, locked state, etc.
> >>> + */
> >>> +#define EC_CMD_SYSINFO 0x001C
> >>> +#define EC_VER_SYSINFO 0
> >>> +
> >>> +enum sysinfo_flags {
> >>> +     SYSTEM_IS_LOCKED = BIT(0),
> >>> +     SYSTEM_IS_FORCE_LOCKED = BIT(1),
> >>> +     SYSTEM_JUMP_ENABLED = BIT(2),
> >>> +     SYSTEM_JUMPED_TO_CURRENT_IMAGE = BIT(3),
> >>> +     SYSTEM_REBOOT_AT_SHUTDOWN = BIT(4)
> >>> +};
> >>> +
> >>> +struct ec_response_sysinfo {
> >>> +     uint32_t reset_flags;           /**< EC_RESET_FLAG_* flags */
> >>> +     uint32_t current_image;         /**< enum ec_current_image */
> >>> +     uint32_t flags;                 /**< enum sysinfo_flags */
> >>> +} __ec_align4;
> >>> +
> >>>  /*****************************************************************************/
> >>>  /* PWM commands */
> >>>
> >>> @@ -2283,7 +2371,7 @@ enum motionsense_command {
> >>>
> >>>       /*
> >>>        * Sensor Offset command is a setter/getter command for the offset
> >>> -      * used for calibration.
> >>> +      * used for factory calibration.
> >>>        * The offsets can be calculated by the host, or via
> >>>        * PERFORM_CALIB command.
> >>>        */
> >>> @@ -2328,6 +2416,11 @@ enum motionsense_command {
> >>>        */
> >>>       MOTIONSENSE_CMD_SENSOR_SCALE = 18,
> >>>
> >>> +     /*
> >>> +      * Read the current online calibration values (if available).
> >>> +      */
> >>> +     MOTIONSENSE_CMD_ONLINE_CALIB_READ = 19,
> >>> +
> >>>       /* Number of motionsense sub-commands. */
> >>>       MOTIONSENSE_NUM_CMDS
> >>>  };
> >>> @@ -2342,6 +2435,7 @@ enum motionsensor_type {
> >>>       MOTIONSENSE_TYPE_ACTIVITY = 5,
> >>>       MOTIONSENSE_TYPE_BARO = 6,
> >>>       MOTIONSENSE_TYPE_SYNC = 7,
> >>> +     MOTIONSENSE_TYPE_LIGHT_RGB = 8,
> >>>       MOTIONSENSE_TYPE_MAX,
> >>>  };
> >>>
> >>> @@ -2375,6 +2469,9 @@ enum motionsensor_chip {
> >>>       MOTIONSENSE_CHIP_LSM6DS3 = 17,
> >>>       MOTIONSENSE_CHIP_LSM6DSO = 18,
> >>>       MOTIONSENSE_CHIP_LNG2DM = 19,
> >>> +     MOTIONSENSE_CHIP_TCS3400 = 20,
> >>> +     MOTIONSENSE_CHIP_LIS2DW12 = 21,
> >>> +     MOTIONSENSE_CHIP_LIS2DWL = 22,
> >>>       MOTIONSENSE_CHIP_MAX,
> >>>  };
> >>>
> >>> @@ -2407,6 +2504,12 @@ struct ec_response_motion_sensor_data {
> >>>       };
> >>>  } __ec_todo_packed;
> >>>
> >>> +/* Response to AP reporting calibration data for a given sensor. */
> >>> +struct ec_response_online_calibration_data {
> >>> +     /** The calibration values. */
> >>> +     int16_t data[3];
> >>> +};
> >>> +
> >>>  /* Note: used in ec_response_get_next_data */
> >>>  struct ec_response_motion_sense_fifo_info {
> >>>       /* Size of the fifo */
> >>> @@ -2517,12 +2620,19 @@ struct ec_params_motion_sense {
> >>>
> >>>               /*
> >>>                * Used for MOTIONSENSE_CMD_INFO, MOTIONSENSE_CMD_DATA
> >>> -              * and MOTIONSENSE_CMD_PERFORM_CALIB.
> >>>                */
> >>>               struct __ec_todo_unpacked {
> >>>                       uint8_t sensor_num;
> >>> -             } info, info_3, data, fifo_flush, perform_calib,
> >>> -                             list_activities;
> >>> +             } info, info_3, info_4, data, fifo_flush, list_activities;
> >>> +
> >>> +             /*
> >>> +              * Used for MOTIONSENSE_CMD_PERFORM_CALIB:
> >>> +              * Allow entering/exiting the calibration mode.
> >>> +              */
> >>> +             struct __ec_todo_unpacked {
> >>> +                     uint8_t sensor_num;
> >>> +                     uint8_t enable;
> >>> +             } perform_calib;
> >>>
> >>>               /*
> >>>                * Used for MOTIONSENSE_CMD_EC_RATE, MOTIONSENSE_CMD_SENSOR_ODR
> >>> @@ -2656,9 +2766,23 @@ struct ec_params_motion_sense {
> >>>                        */
> >>>                       int16_t hys_degree;
> >>>               } tablet_mode_threshold;
> >>> +
> >>> +             /*
> >>> +              * Used for MOTIONSENSE_CMD_ONLINE_CALIB_READ:
> >>> +              * Allow reading a single sensor's online calibration value.
> >>> +              */
> >>> +             struct __ec_todo_unpacked {
> >>> +                     uint8_t sensor_num;
> >>> +             } online_calib_read;
> >>> +
> >>>       };
> >>>  } __ec_todo_packed;
> >>>
> >>> +enum motion_sense_cmd_info_flags {
> >>> +     /* The sensor supports online calibration */
> >>> +     MOTION_SENSE_CMD_INFO_FLAG_ONLINE_CALIB = BIT(0),
> >>> +};
> >>> +
> >>>  struct ec_response_motion_sense {
> >>>       union {
> >>>               /* Used for MOTIONSENSE_CMD_DUMP */
> >>> @@ -2709,6 +2833,33 @@ struct ec_response_motion_sense {
> >>>                       uint32_t fifo_max_event_count;
> >>>               } info_3;
> >>>
> >>> +             /* Used for MOTIONSENSE_CMD_INFO version 4 */
> >>> +             struct __ec_align4 {
> >>> +                     /* Should be element of enum motionsensor_type. */
> >>> +                     uint8_t type;
> >>> +
> >>> +                     /* Should be element of enum motionsensor_location. */
> >>> +                     uint8_t location;
> >>> +
> >>> +                     /* Should be element of enum motionsensor_chip. */
> >>> +                     uint8_t chip;
> >>> +
> >>> +                     /* Minimum sensor sampling frequency */
> >>> +                     uint32_t min_frequency;
> >>> +
> >>> +                     /* Maximum sensor sampling frequency */
> >>> +                     uint32_t max_frequency;
> >>> +
> >>> +                     /* Max number of sensor events that could be in fifo */
> >>> +                     uint32_t fifo_max_event_count;
> >>> +
> >>> +                     /*
> >>> +                      * Should be elements of
> >>> +                      * enum motion_sense_cmd_info_flags
> >>> +                      */
> >>> +                     uint32_t flags;
> >>> +             } info_4;
> >>> +
> >>>               /* Used for MOTIONSENSE_CMD_DATA */
> >>>               struct ec_response_motion_sensor_data data;
> >>>
> >>> @@ -2744,6 +2895,8 @@ struct ec_response_motion_sense {
> >>>
> >>>               struct ec_response_motion_sense_fifo_data fifo_read;
> >>>
> >>> +             struct ec_response_online_calibration_data online_calib_read;
> >>> +
> >>>               struct __ec_todo_packed {
> >>>                       uint16_t reserved;
> >>>                       uint32_t enabled;
> >>> @@ -2806,10 +2959,34 @@ struct ec_params_config_power_button {
> >>>  /* Set USB port charging mode */
> >>>  #define EC_CMD_USB_CHARGE_SET_MODE 0x0030
> >>>
> >>> +enum usb_charge_mode {
> >>> +     /* Disable USB port. */
> >>> +     USB_CHARGE_MODE_DISABLED,
> >>> +     /* Set USB port to Standard Downstream Port, USB 2.0 mode. */
> >>> +     USB_CHARGE_MODE_SDP2,
> >>> +     /* Set USB port to Charging Downstream Port, BC 1.2. */
> >>> +     USB_CHARGE_MODE_CDP,
> >>> +     /* Set USB port to Dedicated Charging Port, BC 1.2. */
> >>> +     USB_CHARGE_MODE_DCP_SHORT,
> >>> +     /* Enable USB port (for dumb ports). */
> >>> +     USB_CHARGE_MODE_ENABLED,
> >>> +     /* Set USB port to CONFIG_USB_PORT_POWER_SMART_DEFAULT_MODE. */
> >>> +     USB_CHARGE_MODE_DEFAULT,
> >>> +
> >>> +     USB_CHARGE_MODE_COUNT
> >>> +};
> >>> +
> >>> +enum usb_suspend_charge {
> >>> +     /* Enable charging in suspend */
> >>> +     USB_ALLOW_SUSPEND_CHARGE,
> >>> +     /* Disable charging in suspend */
> >>> +     USB_DISALLOW_SUSPEND_CHARGE
> >>> +};
> >>> +
> >>>  struct ec_params_usb_charge_set_mode {
> >>>       uint8_t usb_port_id;
> >>> -     uint8_t mode:7;
> >>> -     uint8_t inhibit_charge:1;
> >>> +     uint8_t mode:7;              /* enum usb_charge_mode */
> >>> +     uint8_t inhibit_charge:1;    /* enum usb_suspend_charge */
> >>>  } __ec_align1;
> >>>
> >>>  /*****************************************************************************/
> >>> @@ -3374,6 +3551,12 @@ enum ec_mkbp_event {
> >>>       /* Send an incoming CEC message to the AP */
> >>>       EC_MKBP_EVENT_CEC_MESSAGE = 9,
> >>>
> >>> +     /* We have entered DisplayPort Alternate Mode on a Type-C port. */
> >>> +     EC_MKBP_EVENT_DP_ALT_MODE_ENTERED = 10,
> >>> +
> >>> +     /* New online calibration values are available. */
> >>> +     EC_MKBP_EVENT_ONLINE_CALIBRATION = 11,
> >>> +
> >>>       /* Number of MKBP events */
> >>>       EC_MKBP_EVENT_COUNT,
> >>>  };
> >>> @@ -3497,6 +3680,57 @@ struct ec_response_keyboard_factory_test {
> >>>  #define EC_MKBP_FP_ERR_MATCH_YES_UPDATE_FAILED 5
> >>>
> >>>
> >>> +#define EC_CMD_MKBP_WAKE_MASK 0x0069
> >>> +enum ec_mkbp_event_mask_action {
> >>> +     /* Retrieve the value of a wake mask. */
> >>> +     GET_WAKE_MASK = 0,
> >>> +
> >>> +     /* Set the value of a wake mask. */
> >>> +     SET_WAKE_MASK,
> >>> +};
> >>> +
> >>> +enum ec_mkbp_mask_type {
> >>> +     /*
> >>> +      * These are host events sent via MKBP.
> >>> +      *
> >>> +      * Some examples are:
> >>> +      *    EC_HOST_EVENT_MASK(EC_HOST_EVENT_LID_OPEN)
> >>> +      *    EC_HOST_EVENT_MASK(EC_HOST_EVENT_KEY_PRESSED)
> >>> +      *
> >>> +      * The only things that should be in this mask are:
> >>> +      *    EC_HOST_EVENT_MASK(EC_HOST_EVENT_*)
> >>> +      */
> >>> +     EC_MKBP_HOST_EVENT_WAKE_MASK = 0,
> >>> +
> >>> +     /*
> >>> +      * These are MKBP events. Some examples are:
> >>> +      *
> >>> +      *    EC_MKBP_EVENT_KEY_MATRIX
> >>> +      *    EC_MKBP_EVENT_SWITCH
> >>> +      *
> >>> +      * The only things that should be in this mask are EC_MKBP_EVENT_*.
> >>> +      */
> >>> +     EC_MKBP_EVENT_WAKE_MASK,
> >>> +};
> >>> +
> >>> +struct ec_params_mkbp_event_wake_mask {
> >>> +     /* One of enum ec_mkbp_event_mask_action */
> >>> +     uint8_t action;
> >>> +
> >>> +     /*
> >>> +      * Which MKBP mask are you interested in acting upon?  This is one of
> >>> +      * ec_mkbp_mask_type.
> >>> +      */
> >>> +     uint8_t mask_type;
> >>> +
> >>> +     /* If setting a new wake mask, this contains the mask to set. */
> >>> +     uint32_t new_wake_mask;
> >>> +};
> >>> +
> >>> +struct ec_response_mkbp_event_wake_mask {
> >>> +     uint32_t wake_mask;
> >>> +};
> >>> +
> >>>  /*****************************************************************************/
> >>>  /* Temperature sensor commands */
> >>>
> >>> @@ -3879,16 +4113,69 @@ struct ec_response_ldo_get {
> >>>
> >>>  /*
> >>>   * Get power info.
> >>> + *
> >>> + * Note: v0 of this command is deprecated
> >>>   */
> >>>  #define EC_CMD_POWER_INFO 0x009D
> >>>
> >>> -struct ec_response_power_info {
> >>> -     uint32_t usb_dev_type;
> >>> -     uint16_t voltage_ac;
> >>> -     uint16_t voltage_system;
> >>> -     uint16_t current_system;
> >>> -     uint16_t usb_current_limit;
> >>> -} __ec_align4;
> >>> +/*
> >>> + * v1 of EC_CMD_POWER_INFO
> >>> + */
> >>> +enum system_power_source {
> >>> +     /*
> >>> +      * Haven't established which power source is used yet,
> >>> +      * or no presence signals are available
> >>> +      */
> >>> +     POWER_SOURCE_UNKNOWN = 0,
> >>> +     /* System is running on battery alone */
> >>> +     POWER_SOURCE_BATTERY = 1,
> >>> +     /* System is running on A/C alone */
> >>> +     POWER_SOURCE_AC = 2,
> >>> +     /* System is running on A/C and battery */
> >>> +     POWER_SOURCE_AC_BATTERY = 3,
> >>> +};
> >>> +
> >>> +struct ec_response_power_info_v1 {
> >>> +     /* enum system_power_source */
> >>> +     uint8_t system_power_source;
> >>> +     /* Battery state-of-charge, 0-100, 0 if not present */
> >>> +     uint8_t battery_soc;
> >>> +     /* AC Adapter 100% rating, Watts */
> >>> +     uint8_t ac_adapter_100pct;
> >>> +     /* AC Adapter 10ms rating, Watts */
> >>> +     uint8_t ac_adapter_10ms;
> >>> +     /* Battery 1C rating, derated */
> >>> +     uint8_t battery_1cd;
> >>> +     /* Rest of Platform average, Watts */
> >>> +     uint8_t rop_avg;
> >>> +     /* Rest of Platform peak, Watts */
> >>> +     uint8_t rop_peak;
> >>> +     /* Nominal charger efficiency, % */
> >>> +     uint8_t nominal_charger_eff;
> >>> +     /* Rest of Platform VR Average Efficiency, % */
> >>> +     uint8_t rop_avg_eff;
> >>> +     /* Rest of Platform VR Peak Efficiency, % */
> >>> +     uint8_t rop_peak_eff;
> >>> +     /* SoC VR Efficiency at Average level, % */
> >>> +     uint8_t soc_avg_eff;
> >>> +     /* SoC VR Efficiency at Peak level, % */
> >>> +     uint8_t soc_peak_eff;
> >>> +     /* Intel-specific items */
> >>> +     struct {
> >>> +             /* Battery's level of DBPT support: 0, 2 */
> >>> +             uint8_t batt_dbpt_support_level;
> >>> +             /*
> >>> +              * Maximum peak power from battery (10ms), Watts
> >>> +              * If DBPT is not supported, this is 0
> >>> +              */
> >>> +             uint8_t batt_dbpt_max_peak_power;
> >>> +             /*
> >>> +              * Sustained peak power from battery, Watts
> >>> +              * If DBPT is not supported, this is 0
> >>> +              */
> >>> +             uint8_t batt_dbpt_sus_peak_power;
> >>> +     } intel;
> >>> +} __ec_align1;
> >>>
> >>>  /*****************************************************************************/
> >>>  /* I2C passthru command */
> >>> @@ -3908,7 +4195,7 @@ struct ec_response_power_info {
> >>>  #define EC_I2C_STATUS_ERROR  (EC_I2C_STATUS_NAK | EC_I2C_STATUS_TIMEOUT)
> >>>
> >>>  struct ec_params_i2c_passthru_msg {
> >>> -     uint16_t addr_flags;    /* I2C slave address (7 or 10 bits) and flags */
> >>> +     uint16_t addr_flags;    /* I2C slave address and flags */
> >>>       uint16_t len;           /* Number of bytes to read or write */
> >>>  } __ec_align2;
> >>>
> >>> @@ -4360,6 +4647,9 @@ struct ec_response_sb_fw_update {
> >>>   * Entering Verified Boot Mode Command
> >>>   * Default mode is VBOOT_MODE_NORMAL if EC did not receive this command.
> >>>   * Valid Modes are: normal, developer, and recovery.
> >>> + *
> >>> + * EC no longer needs to know what mode vboot has entered,
> >>> + * so this command is deprecated.  (See chromium:1014379.)
> >>>   */
> >>>  #define EC_CMD_ENTERING_MODE 0x00B6
> >>>
> >>> @@ -4379,8 +4669,9 @@ struct ec_params_entering_mode {
> >>>  #define EC_CMD_I2C_PASSTHRU_PROTECT 0x00B7
> >>>
> >>>  enum ec_i2c_passthru_protect_subcmd {
> >>> -     EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0x0,
> >>> -     EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 0x1,
> >>> +     EC_CMD_I2C_PASSTHRU_PROTECT_STATUS = 0,
> >>> +     EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE = 1,
> >>> +     EC_CMD_I2C_PASSTHRU_PROTECT_ENABLE_TCPCS = 2,
> >>>  };
> >>>
> >>>  struct ec_params_i2c_passthru_protect {
> >>> @@ -4893,7 +5184,7 @@ struct ec_params_usb_pd_control {
> >>>  #define PD_CTRL_RESP_ROLE_DR_POWER      BIT(3) /* Partner is dualrole power */
> >>>  #define PD_CTRL_RESP_ROLE_DR_DATA       BIT(4) /* Partner is dualrole data */
> >>>  #define PD_CTRL_RESP_ROLE_USB_COMM      BIT(5) /* Partner USB comm capable */
> >>> -#define PD_CTRL_RESP_ROLE_EXT_POWERED   BIT(6) /* Partner externally powerd */
> >>> +#define PD_CTRL_RESP_ROLE_UNCONSTRAINED BIT(6) /* Partner unconstrained power */
> >>>
> >>>  struct ec_response_usb_pd_control {
> >>>       uint8_t enabled;
> >>> @@ -4909,23 +5200,45 @@ struct ec_response_usb_pd_control_v1 {
> >>>       char state[32];
> >>>  } __ec_align1;
> >>>
> >>> -/* Values representing usbc PD CC state */
> >>> -#define USBC_PD_CC_NONE              0 /* No accessory connected */
> >>> -#define USBC_PD_CC_NO_UFP    1 /* No UFP accessory connected */
> >>> -#define USBC_PD_CC_AUDIO_ACC 2 /* Audio accessory connected */
> >>> -#define USBC_PD_CC_DEBUG_ACC 3 /* Debug accessory connected */
> >>> -#define USBC_PD_CC_UFP_ATTACHED      4 /* UFP attached to usbc */
> >>> -#define USBC_PD_CC_DFP_ATTACHED      5 /* DPF attached to usbc */
> >>> +/* Possible port partner connections based on CC line states */
> >>> +enum pd_cc_states {
> >>> +     PD_CC_NONE = 0,                 /* No port partner attached */
> >>> +
> >>> +     /* From DFP perspective */
> >>> +     PD_CC_UFP_NONE = 1,             /* No UFP accessory connected */
> >>> +     PD_CC_UFP_AUDIO_ACC = 2,        /* UFP Audio accessory connected */
> >>> +     PD_CC_UFP_DEBUG_ACC = 3,        /* UFP Debug accessory connected */
> >>> +     PD_CC_UFP_ATTACHED = 4,         /* Plain UFP attached */
> >>>
> >>> +     /* From UFP perspective */
> >>> +     PD_CC_DFP_ATTACHED = 5,         /* Plain DFP attached */
> >>> +     PD_CC_DFP_DEBUG_ACC = 6,        /* DFP debug accessory connected */
> >>> +};
> >>> +
> >>> +/* Active/Passive Cable */
> >>> +#define USB_PD_CTRL_ACTIVE_CABLE        BIT(0)
> >>> +/* Optical/Non-optical cable */
> >>> +#define USB_PD_CTRL_OPTICAL_CABLE       BIT(1)
> >>> +/* 3rd Gen TBT device (or AMA)/2nd gen tbt Adapter */
> >>> +#define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
> >>> +/* Active Link Uni-Direction */
> >>> +#define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
> >>> +
> >>> +/*
> >>> + * Underdevelopement :
> >>> + * Please remove this tag if using _v2 outside platform/ec
> >>> + */
> >>>  struct ec_response_usb_pd_control_v2 {
> >>>       uint8_t enabled;
> >>>       uint8_t role;
> >>>       uint8_t polarity;
> >>>       char state[32];
> >>> -     uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
> >>> -     uint8_t dp_mode;  /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> >>> -     /* CL:1500994 Current cable type */
> >>> -     uint8_t reserved_cable_type;
> >>> +     uint8_t cc_state;       /* enum pd_cc_states representing cc state */
> >>> +     uint8_t dp_mode;        /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> >>> +     uint8_t reserved;       /* Reserved for future use */
> >>> +     uint8_t control_flags;  /* USB_PD_CTRL_*flags */
> >>> +     uint8_t cable_speed;    /* TBT_SS_* cable speed */
> >>> +     uint8_t cable_gen;      /* TBT_GEN3_* cable rounded support */
> >>>  } __ec_align1;
> >>>
> >>>  #define EC_CMD_USB_PD_PORTS 0x0102
> >>> @@ -5021,7 +5334,7 @@ struct ec_params_usb_pd_rw_hash_entry {
> >>>                                 * TODO(rspangler) but it's not aligned!
> >>>                                 * Should have been reserved[2].
> >>>                                 */
> >>> -     uint32_t current_image;  /* One of ec_current_image */
> >>> +     uint32_t current_image;  /* One of ec_image */
> >>>  } __ec_align1;
> >>>
> >>>  /* Read USB-PD Accessory info */
> >>> @@ -5046,7 +5359,7 @@ struct ec_params_usb_pd_discovery_entry {
> >>>  enum usb_pd_override_ports {
> >>>       OVERRIDE_DONT_CHARGE = -2,
> >>>       OVERRIDE_OFF = -1,
> >>> -     /* [0, CONFIG_USB_PD_PORT_COUNT): Port# */
> >>> +     /* [0, CONFIG_USB_PD_PORT_MAX_COUNT): Port# */
> >>>  };
> >>>
> >>>  struct ec_params_charge_port_override {
> >>> @@ -5207,11 +5520,18 @@ struct ec_params_usb_pd_mux_info {
> >>>  } __ec_align1;
> >>>
> >>>  /* Flags representing mux state */
> >>> -#define USB_PD_MUX_USB_ENABLED       BIT(0) /* USB connected */
> >>> -#define USB_PD_MUX_DP_ENABLED        BIT(1) /* DP connected */
> >>> -#define USB_PD_MUX_POLARITY_INVERTED BIT(2) /* CC line Polarity inverted */
> >>> -#define USB_PD_MUX_HPD_IRQ           BIT(3) /* HPD IRQ is asserted */
> >>> -#define USB_PD_MUX_HPD_LVL           BIT(4) /* HPD level is asserted */
> >>> +#define USB_PD_MUX_NONE               0      /* Open switch */
> >>> +#define USB_PD_MUX_USB_ENABLED        BIT(0) /* USB connected */
> >>> +#define USB_PD_MUX_DP_ENABLED         BIT(1) /* DP connected */
> >>> +#define USB_PD_MUX_POLARITY_INVERTED  BIT(2) /* CC line Polarity inverted */
> >>> +#define USB_PD_MUX_HPD_IRQ            BIT(3) /* HPD IRQ is asserted */
> >>> +#define USB_PD_MUX_HPD_LVL            BIT(4) /* HPD level is asserted */
> >>> +#define USB_PD_MUX_SAFE_MODE          BIT(5) /* DP is in safe mode */
> >>> +#define USB_PD_MUX_TBT_COMPAT_ENABLED BIT(6) /* TBT compat enabled */
> >>> +#define USB_PD_MUX_USB4_ENABLED       BIT(7) /* USB4 enabled */
> >>> +
> >>> +/* USB-C Dock connected */
> >>> +#define USB_PD_MUX_DOCK              (USB_PD_MUX_USB_ENABLED | USB_PD_MUX_DP_ENABLED)
> >>>
> >>>  struct ec_response_usb_pd_mux_info {
> >>>       uint8_t flags; /* USB_PD_MUX_*-encoded USB mux state */
> >>> @@ -5221,7 +5541,12 @@ struct ec_response_usb_pd_mux_info {
> >>>
> >>>  struct ec_params_pd_chip_info {
> >>>       uint8_t port;   /* USB-C port number */
> >>> -     uint8_t renew;  /* Force renewal */
> >>> +     /*
> >>> +      * Fetch the live chip info or hard-coded + cached chip info
> >>> +      * 0: hardcoded value for VID/PID, cached value for FW version
> >>> +      * 1: live chip value for VID/PID/FW Version
> >>> +      */
> >>> +     uint8_t live;
> >>>  } __ec_align1;
> >>>
> >>>  struct ec_response_pd_chip_info {
> >>> @@ -5293,6 +5618,7 @@ enum cbi_data_tag {
> >>>       CBI_TAG_DRAM_PART_NUM = 3, /* variable length ascii, nul terminated. */
> >>>       CBI_TAG_OEM_NAME = 4,      /* variable length ascii, nul terminated. */
> >>>       CBI_TAG_MODEL_ID = 5,      /* uint32_t or smaller */
> >>> +     CBI_TAG_FW_CONFIG = 6,     /* uint32_t bit field */
> >>>       CBI_TAG_COUNT,
> >>>  };
> >>>
> >>> @@ -5332,6 +5658,32 @@ struct ec_params_set_cbi {
> >>>   */
> >>>  #define EC_CMD_GET_UPTIME_INFO 0x0121
> >>>
> >>> +/* Reset causes */
> >>> +#define EC_RESET_FLAG_OTHER       BIT(0)   /* Other known reason */
> >>> +#define EC_RESET_FLAG_RESET_PIN   BIT(1)   /* Reset pin asserted */
> >>> +#define EC_RESET_FLAG_BROWNOUT    BIT(2)   /* Brownout */
> >>> +#define EC_RESET_FLAG_POWER_ON    BIT(3)   /* Power-on reset */
> >>> +#define EC_RESET_FLAG_WATCHDOG    BIT(4)   /* Watchdog timer reset */
> >>> +#define EC_RESET_FLAG_SOFT        BIT(5)   /* Soft reset trigger by core */
> >>> +#define EC_RESET_FLAG_HIBERNATE   BIT(6)   /* Wake from hibernate */
> >>> +#define EC_RESET_FLAG_RTC_ALARM   BIT(7)   /* RTC alarm wake */
> >>> +#define EC_RESET_FLAG_WAKE_PIN    BIT(8)   /* Wake pin triggered wake */
> >>> +#define EC_RESET_FLAG_LOW_BATTERY BIT(9)   /* Low battery triggered wake */
> >>> +#define EC_RESET_FLAG_SYSJUMP     BIT(10)  /* Jumped directly to this image */
> >>> +#define EC_RESET_FLAG_HARD        BIT(11)  /* Hard reset from software */
> >>> +#define EC_RESET_FLAG_AP_OFF      BIT(12)  /* Do not power on AP */
> >>> +#define EC_RESET_FLAG_PRESERVED   BIT(13)  /* Some reset flags preserved from
> >>> +                                         * previous boot
> >>> +                                         */
> >>> +#define EC_RESET_FLAG_USB_RESUME  BIT(14)  /* USB resume triggered wake */
> >>> +#define EC_RESET_FLAG_RDD         BIT(15)  /* USB Type-C debug cable */
> >>> +#define EC_RESET_FLAG_RBOX        BIT(16)  /* Fixed Reset Functionality */
> >>> +#define EC_RESET_FLAG_SECURITY    BIT(17)  /* Security threat */
> >>> +#define EC_RESET_FLAG_AP_WATCHDOG BIT(18)  /* AP experienced a watchdog reset */
> >>> +#define EC_RESET_FLAG_STAY_IN_RO  BIT(19)  /* Do not select RW in EFS. This
> >>> +                                         * enables PD in RO for Chromebox.
> >>> +                                         */
> >>> +
> >>>  struct ec_response_uptime_info {
> >>>       /*
> >>>        * Number of milliseconds since the last EC boot. Sysjump resets
> >>> @@ -5352,8 +5704,8 @@ struct ec_response_uptime_info {
> >>>       uint32_t ap_resets_since_ec_boot;
> >>>
> >>>       /*
> >>> -      * The set of flags which describe the EC's most recent reset.  See
> >>> -      * include/system.h RESET_FLAG_* for details.
> >>> +      * The set of flags which describe the EC's most recent reset.
> >>> +      * See EC_RESET_FLAG_* for details.
> >>>        */
> >>>       uint32_t ec_reset_flags;
> >>>
> >>> @@ -5430,6 +5782,133 @@ struct ec_response_rollback_info {
> >>>  /* Issue AP reset */
> >>>  #define EC_CMD_AP_RESET 0x0125
> >>>
> >>> +/*****************************************************************************/
> >>> +/* Locate peripheral chips
> >>> + *
> >>> + * Return values:
> >>> + * EC_RES_UNAVAILABLE: The chip type is supported but not found on system.
> >>> + * EC_RES_INVALID_PARAM: The chip type was unrecognized.
> >>> + * EC_RES_OVERFLOW: The index number exceeded the number of chip instances.
> >>> + */
> >>> +#define EC_CMD_LOCATE_CHIP 0x0126
> >>> +
> >>> +enum ec_chip_type {
> >>> +     EC_CHIP_TYPE_CBI_EEPROM = 0,
> >>> +     EC_CHIP_TYPE_TCPC = 1,
> >>> +     EC_CHIP_TYPE_COUNT,
> >>> +     EC_CHIP_TYPE_MAX = 0xFF,
> >>> +};
> >>> +
> >>> +enum ec_bus_type {
> >>> +     EC_BUS_TYPE_I2C = 0,
> >>> +     EC_BUS_TYPE_EMBEDDED = 1,
> >>> +     EC_BUS_TYPE_COUNT,
> >>> +     EC_BUS_TYPE_MAX = 0xFF,
> >>> +};
> >>> +
> >>> +struct ec_i2c_info {
> >>> +     uint16_t port;          /* Physical port for device */
> >>> +     uint16_t addr_flags;    /* 7-bit (or 10-bit) address */
> >>> +};
> >>> +
> >>> +struct ec_params_locate_chip {
> >>> +     uint8_t type;           /* enum ec_chip_type */
> >>> +     uint8_t index;          /* Specifies one instance of chip type */
> >>> +     /* Used for type specific parameters in future */
> >>> +     union {
> >>> +             uint16_t reserved;
> >>> +     };
> >>> +} __ec_align2;
> >>> +
> >>> +
> >>> +struct ec_response_locate_chip {
> >>> +     uint8_t bus_type;       /* enum ec_bus_type */
> >>> +     uint8_t reserved;       /* Aligning the following union to 2 bytes */
> >>> +     union {
> >>> +             struct ec_i2c_info i2c_info;
> >>> +     };
> >>> +} __ec_align2;
> >>> +
> >>> +/*
> >>> + * Reboot AP on G3
> >>> + *
> >>> + * This command is used for validation purpose, where the AP needs to be
> >>> + * returned back to S0 state from G3 state without using the servo to trigger
> >>> + * wake events.For this,there is no request or response struct.
> >>> + *
> >>> + * Order of command usage:
> >>> + * ectool reboot_ap_on_g3 && shutdown -h now
> >>> + */
> >>> +#define EC_CMD_REBOOT_AP_ON_G3 0x0127
> >>> +
> >>> +/*****************************************************************************/
> >>> +/* Get PD port capabilities
> >>> + *
> >>> + * Returns the following static *capabilities* of the given port:
> >>> + * 1) Power role: source, sink, or dual. It is not anticipated that
> >>> + *    future CrOS devices would ever be only a source, so the options are
> >>> + *    sink or dual.
> >>> + * 2) Try-power role: source, sink, or none (practically speaking, I don't
> >>> + *    believe any CrOS device would support Try.SNK, so this would be source
> >>> + *    or none).
> >>> + * 3) Data role: dfp, ufp, or dual. This will probably only be DFP or dual
> >>> + *    for CrOS devices.
> >>> + */
> >>> +#define EC_CMD_GET_PD_PORT_CAPS 0x0128
> >>> +
> >>> +enum ec_pd_power_role_caps {
> >>> +     EC_PD_POWER_ROLE_SOURCE = 0,
> >>> +     EC_PD_POWER_ROLE_SINK = 1,
> >>> +     EC_PD_POWER_ROLE_DUAL = 2,
> >>> +};
> >>> +
> >>> +enum ec_pd_try_power_role_caps {
> >>> +     EC_PD_TRY_POWER_ROLE_NONE = 0,
> >>> +     EC_PD_TRY_POWER_ROLE_SINK = 1,
> >>> +     EC_PD_TRY_POWER_ROLE_SOURCE = 2,
> >>> +};
> >>> +
> >>> +enum ec_pd_data_role_caps {
> >>> +     EC_PD_DATA_ROLE_DFP = 0,
> >>> +     EC_PD_DATA_ROLE_UFP = 1,
> >>> +     EC_PD_DATA_ROLE_DUAL = 2,
> >>> +};
> >>> +
> >>> +/* From: power_manager/power_supply_properties.proto */
> >>> +enum ec_pd_port_location {
> >>> +     /* The location of the port is unknown, or there's only one port. */
> >>> +     EC_PD_PORT_LOCATION_UNKNOWN = 0,
> >>> +
> >>> +     /*
> >>> +      * Various positions on the device. The first word describes the side of
> >>> +      * the device where the port is located while the second clarifies the
> >>> +      * position. For example, LEFT_BACK means the farthest-back port on the
> >>> +      * left side, while BACK_LEFT means the leftmost port on the back of the
> >>> +      * device.
> >>> +      */
> >>> +     EC_PD_PORT_LOCATION_LEFT        = 1,
> >>> +     EC_PD_PORT_LOCATION_RIGHT       = 2,
> >>> +     EC_PD_PORT_LOCATION_BACK        = 3,
> >>> +     EC_PD_PORT_LOCATION_FRONT       = 4,
> >>> +     EC_PD_PORT_LOCATION_LEFT_FRONT  = 5,
> >>> +     EC_PD_PORT_LOCATION_LEFT_BACK   = 6,
> >>> +     EC_PD_PORT_LOCATION_RIGHT_FRONT = 7,
> >>> +     EC_PD_PORT_LOCATION_RIGHT_BACK  = 8,
> >>> +     EC_PD_PORT_LOCATION_BACK_LEFT   = 9,
> >>> +     EC_PD_PORT_LOCATION_BACK_RIGHT  = 10,
> >>> +};
> >>> +
> >>> +struct ec_params_get_pd_port_caps {
> >>> +     uint8_t port;           /* Which port to interrogate */
> >>> +} __ec_align1;
> >>> +
> >>> +struct ec_response_get_pd_port_caps {
> >>> +     uint8_t pd_power_role_cap;      /* enum ec_pd_power_role_caps */
> >>> +     uint8_t pd_try_power_role_cap;  /* enum ec_pd_try_power_role_caps */
> >>> +     uint8_t pd_data_role_cap;       /* enum ec_pd_data_role_caps */
> >>> +     uint8_t pd_port_location;       /* enum ec_pd_port_location */
> >>> +} __ec_align1;
> >>> +
> >>>  /*****************************************************************************/
> >>>  /* The command range 0x200-0x2FF is reserved for Rotor. */
> >>>
> >>> @@ -5585,15 +6064,18 @@ struct ec_response_fp_info {
> >>>  #define FP_FRAME_OFFSET_MASK       0x0FFFFFFF
> >>>
> >>>  /* Version of the format of the encrypted templates. */
> >>> -#define FP_TEMPLATE_FORMAT_VERSION 3
> >>> +#define FP_TEMPLATE_FORMAT_VERSION 4
> >>>
> >>>  /* Constants for encryption parameters */
> >>>  #define FP_CONTEXT_NONCE_BYTES 12
> >>>  #define FP_CONTEXT_USERID_WORDS (32 / sizeof(uint32_t))
> >>>  #define FP_CONTEXT_TAG_BYTES 16
> >>> -#define FP_CONTEXT_SALT_BYTES 16
> >>> +#define FP_CONTEXT_ENCRYPTION_SALT_BYTES 16
> >>>  #define FP_CONTEXT_TPM_BYTES 32
> >>>
> >>> +/* Constants for positive match parameters. */
> >>> +#define FP_POSITIVE_MATCH_SALT_BYTES 16
> >>> +
> >>>  struct ec_fp_template_encryption_metadata {
> >>>       /*
> >>>        * Version of the structure format (N=3).
> >>> @@ -5606,7 +6088,7 @@ struct ec_fp_template_encryption_metadata {
> >>>        * a different one is used for every message.
> >>>        */
> >>>       uint8_t nonce[FP_CONTEXT_NONCE_BYTES];
> >>> -     uint8_t salt[FP_CONTEXT_SALT_BYTES];
> >>> +     uint8_t encryption_salt[FP_CONTEXT_ENCRYPTION_SALT_BYTES];
> >>>       uint8_t tag[FP_CONTEXT_TAG_BYTES];
> >>>  };
> >>>
> >>> @@ -5639,6 +6121,18 @@ struct ec_params_fp_context {
> >>>       uint32_t userid[FP_CONTEXT_USERID_WORDS];
> >>>  } __ec_align4;
> >>>
> >>> +enum fp_context_action {
> >>> +     FP_CONTEXT_ASYNC = 0,
> >>> +     FP_CONTEXT_GET_RESULT = 1,
> >>> +};
> >>> +
> >>> +/* Version 1 of the command is "asynchronous". */
> >>> +struct ec_params_fp_context_v1 {
> >>> +     uint8_t action;         /**< enum fp_context_action */
> >>> +     uint8_t reserved[3];    /**< padding for alignment */
> >>> +     uint32_t userid[FP_CONTEXT_USERID_WORDS];
> >>> +} __ec_align4;
> >>> +
> >>>  #define EC_CMD_FP_STATS 0x0407
> >>>
> >>>  #define FPSTATS_CAPTURE_INV  BIT(0)
> >>> @@ -5680,6 +6174,17 @@ struct ec_response_fp_encryption_status {
> >>>       uint32_t status;
> >>>  } __ec_align4;
> >>>
> >>> +#define EC_CMD_FP_READ_MATCH_SECRET 0x040A
> >>
> >> Add an empty line here.
> >>
> >>> +struct ec_params_fp_read_match_secret {
> >>> +     uint16_t fgr;
> >>> +} __ec_align4;
> >>> +
> >>> +/* The positive match secret has the length of the SHA256 digest. */
> >>> +#define FP_POSITIVE_MATCH_SECRET_BYTES 32
> >>
> >> Add an empty line here.
> >>
> >>> +struct ec_response_fp_read_match_secret {
> >>> +     uint8_t positive_match_secret[FP_POSITIVE_MATCH_SECRET_BYTES];
> >>> +} __ec_align4;
> >>> +
> >>>  /*****************************************************************************/
> >>>  /* Touchpad MCU commands: range 0x0500-0x05FF */
> >>>
> >>>
