Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51E1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA63820715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 01:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kf/6uRcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgGGBCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 21:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGGBCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 21:02:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18EDC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 18:02:41 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so13921822qvk.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 18:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UPLglurd2bXR8gqpRZ4MDKzwYBPMt0K23wQze9gEJ2c=;
        b=Kf/6uRcVV0NUzFhvPEALeNNkq22wybhmjgUM0n8ASfuhauZ3HRcOdohgRYpPdAT3Se
         ihj/wwdmvst7WmznaeiX5G0GYcHiRfob0hNOi+TdAiKCU2Tt4562mr/VIa7g9RQ3sBTs
         DX0E/+DJ2ZLN6dvN8M2xcMVV6FSGbLBXbgva4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UPLglurd2bXR8gqpRZ4MDKzwYBPMt0K23wQze9gEJ2c=;
        b=UBcFGCxKHsXZX6wlAhiATEnFRbdppvUlDvETAnJ3NEBVi6fH48zY57uHPXk1wcXB4+
         kGodMXVfY8r2jyA6X9/f7YRTkP/77rD8zllkBq57a3ilcxFxd96RINMbyqo0wd6RKgVs
         xtKPfdkeW1t51F9422OUVvzXeno7smHng7pgmgmT64QdkT7ubM1RLoZze/eAPeYDWbr+
         GXDT6jwflefYai39ZTsf58ZdFvSa/+XUz2zUamamSd9Jbr/78WYYU4XbpJhySKb5n1NF
         AyqPCO+Zh0MAVTMRuSNq+48yBQmQ0cuQlUfyI7KPlQMR8gxc9mfUPv5TfjbDEHK94uml
         gXeA==
X-Gm-Message-State: AOAM532jYCK/iMngkhGg8xdRRBwHzVYnExgB3lI+X3skfESloHEpi4Pg
        njNlj+ZJqhysxY9rjN8PQCNM30LKIQBQfeSjfXGx1780
X-Google-Smtp-Source: ABdhPJy2ipwIBj8S3tAe2nNhvJM3NpT/pnPppOMqhdYDW5SY1bDEYpke03X5ei47wQmgixJ/twrWZDpDXw1PZbgGO8A=
X-Received: by 2002:a05:6214:3ac:: with SMTP id m12mr45511839qvy.18.1594083760821;
 Mon, 06 Jul 2020 18:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200704142607.171400-1-linux@roeck-us.net> <20200706185230.GA792857@google.com>
 <20200706194120.GB180826@roeck-us.net> <CACeCKadx5vmqT9dnTTr49T3s-ZG1h3YnKZRvFVB4vrUhnD2faw@mail.gmail.com>
 <a6567dcc-8360-6537-3147-9da6ea1bcc64@roeck-us.net>
In-Reply-To: <a6567dcc-8360-6537-3147-9da6ea1bcc64@roeck-us.net>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 6 Jul 2020 18:02:30 -0700
Message-ID: <CACeCKafa_Ou_WXSyWs8Agcr=S2H6Gyqdx1dyxieKhJ5VW_MCXg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to
 Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 2:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/6/20 1:07 PM, Prashant Malani wrote:
> > On Mon, Jul 6, 2020 at 12:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On Mon, Jul 06, 2020 at 11:52:30AM -0700, Prashant Malani wrote:
> >>> Hi Guenter,
> >>>
> >>> On Sat, Jul 04, 2020 at 07:26:07AM -0700, Guenter Roeck wrote:
> >>>> The EC reports a variety of error codes. Most of those, with the exception
> >>>> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> >>>> error code gets lost. Convert all EC errors to Linux error codes to report
> >>>> a more meaningful error to the caller to aid debugging.
> >>>>
> >>>> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> >>>> Cc: Prashant Malani <pmalani@chromium.org>
> >>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >>>> ---
> >>>>  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
> >>>>  1 file changed, 29 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> >>>> index 3e745e0fe092..10aa9e483d35 100644
> >>>> --- a/drivers/platform/chrome/cros_ec_proto.c
> >>>> +++ b/drivers/platform/chrome/cros_ec_proto.c
> >>>> @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> >>>>  }
> >>>>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >>>>
> >>>> +static const int cros_ec_error_map[] = {
> >>>> +   [EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> >>>> +   [EC_RES_ERROR] = -EIO,
> >>>> +   [EC_RES_INVALID_PARAM] = -EINVAL,
> >>>> +   [EC_RES_ACCESS_DENIED] = -EACCES,
> >>>> +   [EC_RES_INVALID_RESPONSE] = -EPROTO,
> >>>> +   [EC_RES_INVALID_VERSION] = -ENOTSUPP,
> >>>> +   [EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> >>>> +   [EC_RES_IN_PROGRESS] = -EINPROGRESS,
> >>>> +   [EC_RES_UNAVAILABLE] = -ENODATA,
> >>>> +   [EC_RES_TIMEOUT] = -ETIMEDOUT,
> >>>> +   [EC_RES_OVERFLOW] = -EOVERFLOW,
> >>>> +   [EC_RES_INVALID_HEADER] = -EBADR,
> >>>> +   [EC_RES_REQUEST_TRUNCATED] = -EBADR,
> >>>> +   [EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> >>>> +   [EC_RES_BUS_ERROR] = -EFAULT,
> >>>> +   [EC_RES_BUSY] = -EBUSY,
> >>>> +   [EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> >>>> +   [EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> >>>> +   [EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> >>>> +   [EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> >>>> +};
> >>>> +
> >>>>  /**
> >>>>   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> >>>>   * @ec_dev: EC device.
> >>>> @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
> >>>>   *
> >>>>   * Return:
> >>>>   * >=0 - The number of bytes transferred
> >>>> - * -ENOTSUPP - Operation not supported
> >>>> - * -EPROTO - Protocol error
> >>>> + * <0 - Linux error code
> >>>>   */
> >>>>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >>>>                         struct cros_ec_command *msg)
> >>>> @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >>>>     ret = cros_ec_cmd_xfer(ec_dev, msg);
> >>>>     if (ret < 0) {
> >>>>             dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> >>>> -   } else if (msg->result == EC_RES_INVALID_VERSION) {
> >>>> -           dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> >>>> -                   msg->result);
> >>>> -           return -ENOTSUPP;
> >>>>     } else if (msg->result != EC_RES_SUCCESS) {
> >>>> -           dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> >>>> -           return -EPROTO;
> >>>> +           if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> >>>
> >>> Do we expect a case where cros_ec_error_map[msg->result] == 0?
> >>>
> >>
> >> It seemed to be prudent to assume that this code is not going to be
> >> updated whenever a new EC error code is added. Doing nothing would
> >> risk returning 0, and addding WARN_ON or dev_warn seemed excessive.
> >> Having said that, I don't really have a strong opinion one way
> >> or another, and I'll be happy to change the code to whatever people
> >> think is appropriate.
> >
> > Thanks for providing the rationale. I think if a new EC error code is
> > added (and this array isn't updated),
> > msg->result < ARRAY_SIZE(cros_ec_error_map) would return false, and
> > the code block would return -EPROTO.
> >
>
> Some scenarios:
>
> Developer 1 adds EC_RES_SOME_ERROR, and does not update the array.
> Developer 2 adds EC_RES_SOME_OTHER_ERROR and updates the array, but
> does not realize that EC_RES_SOME_ERROR is missing as well, and does
> not add it.
> Developer 3 adds two (or more) error codes, and does not update the
> array. Someone else later finds a -EPROTO return code and adds the
> necessary translation to the array. That translation happens to be
> for the last error code. The developer doing that does not realize
> that other error codes are missing as well, or does not realize
> the impact, and does not add translations for the other missing
> error codes.
>
> Overall there are too many situations where this can go wrong for me
> to trust that it never will.

Fair enough.
>
> > I'll defer to the maintainer's opinion(s), but I think we can remove
> > the condition after '&&'.
> >
>
> I thought about it, but I find that I don't feel comfortable with
> doing that. If that is what is asked for, would you mind providing
> a separate patch which doesn't have my name on it ?
>

Thanks again for your explanation. As someone Cc-ed, I find it
important (for me) to seek clarification behind the code. Thank you
for providing that.
As I alluded to earlier, over to the maintainer(s) now :)

> Thanks,
> Guenter
