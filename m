Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BD8C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B08214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jmp6AYha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBFSuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:50:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33723 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:50:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id d5so5354748qto.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuwfgwqB0dqYPKLzWqU8tOo9ajVtA4MOIL0J1xcdpbQ=;
        b=Jmp6AYhao4RBdM36/OZcBwP8eZpbBSisVdzTFp/cBTMVEzM/X09roTZwjCtgyplUpE
         wF66O3llkIOnTrTFo8XMsFkg6MEoDLTBynExQbscY6OyV9nF/YQEoaRXvRmpC1ME/d5g
         FZkJJi0QFViNalvad0dtKa79RHFVk6naOtJpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuwfgwqB0dqYPKLzWqU8tOo9ajVtA4MOIL0J1xcdpbQ=;
        b=duu+iuWO4z2Um13Kyjo9HB95RoS9B0uEMjbicHPW0vC/V+HJQHpID3WQkfG12WOxSS
         HE/Ct+25IR9fbvdyx8e6pikcWSI4ZrdBPWLjC1415RN6wkMYfBxzZGrqUkfrpvyT/RT2
         BHtF3HJWjm0zU9cfcrH9IQoDEu7e0K3vlGMxaX+whICWLTBAMkh9XTBwLnm8JltDwKP0
         tWLA9XiU9Ibc+FIOsnHsv/7ylMUH7gRQnx60PBmt6b6ZgWhpsUyFeZ4PPPY1cpXyG3xQ
         3hpKTmqOS6gJDhF44N0LVgrjIwhoMpe2TBo2ZUBCnEu5swsrrGxnETw1HfSXhKCOouDI
         6Oxw==
X-Gm-Message-State: APjAAAV8CWOc9sbZXkgEaLdnK8BNSIXI+ZsXYJDE32NGWUz7p+bDuvcc
        CCflQPnYadgCZjS9Kf27L/VmDrwD3NNrMLsEagSSow==
X-Google-Smtp-Source: APXvYqwgk5WKRhBnLW+OKDR8M0PFQhkyjJ+kJb/0KadIL2EQmjhvrCJaEBVvozZT3SJFZo4/pjuBx1j3Ga2Gb5/LEJM=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr3851104qtu.141.1581015004918;
 Thu, 06 Feb 2020 10:50:04 -0800 (PST)
MIME-Version: 1.0
References: <20200205190028.183069-1-pmalani@chromium.org> <20200205190028.183069-11-pmalani@chromium.org>
 <20200206121753.7b809631@archlinux> <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
In-Reply-To: <671a55aa-1e5e-4e21-4a62-55db4dee368a@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Thu, 6 Feb 2020 10:49:53 -0800
Message-ID: <CACeCKad4zp9O7WAPu5S1rmUDwkzWLjk_1i7YtPvXUG=nDvkYAA@mail.gmail.com>
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for taking a look at the patch. Please see my response inline:

On Thu, Feb 6, 2020 at 5:45 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 6/2/20 13:17, Jonathan Cameron wrote:
> > On Wed,  5 Feb 2020 11:00:13 -0800
> > Prashant Malani <pmalani@chromium.org> wrote:
> >
> >> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
> >> which does the message buffer setup and cleanup.
> >>
> >> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
> >> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
> >> function.
> >>
> >> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> >
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> >> ---
> >>
> >> Changes in v2:
> >> - Updated to use new function name and parameter list.
> >> - Used C99 element setting to initialize param struct.
> >> - For second usage, replaced cros_ec_cmd_xfer_status() with
> >>   cros_ec_cmd_xfer() which is functionally similar.
> >>
> >>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
> >>  1 file changed, 9 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> index d3a3626c7cd834..94e22e7d927631 100644
> >> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> >>                                           u16 cmd_offset, u16 cmd, u32 *mask)
> >>  {
> >>      int ret;
> >> -    struct {
> >> -            struct cros_ec_command msg;
> >> -            union {
> >> -                    struct ec_params_get_cmd_versions params;
> >> -                    struct ec_response_get_cmd_versions resp;
> >> -            };
> >> -    } __packed buf = {
> >> -            .msg = {
> >> -                    .command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> >> -                    .insize = sizeof(struct ec_response_get_cmd_versions),
> >> -                    .outsize = sizeof(struct ec_params_get_cmd_versions)
> >> -                    },
> >> -            .params = {.cmd = cmd}
> >> +    struct ec_params_get_cmd_versions params = {
> >> +            .cmd = cmd,
> >>      };
> >> +    struct ec_response_get_cmd_versions resp = {0};
> >>
> >> -    ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> >> +    ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> >> +                      &params, sizeof(params), &resp, sizeof(resp), NULL);
> >>      if (ret >= 0)
> >> -            *mask = buf.resp.version_mask;
> >> +            *mask = resp.version_mask;
> >>      return ret;
> >>  }
> >>
> >> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
> >>
> >>      memcpy(state->msg->data, &state->param, sizeof(state->param));
> >>
> >> -    ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> >> +    ret = cros_ec_cmd_xfer(state->ec, state->msg);
> >>      if (ret < 0)
> >>              return ret;
> >> +    else if (state->msg->result != EC_RES_SUCCESS)
> >> +            return -EPROTO;
> >>
>
> There is no way to use the new cros_ec_cmd here?

I think it is doable. From looking at the code I felt the factors we
need to be careful about are:
- The function cros_ec_motion_send_host_cmd() is called from a few
other files, each of which set up the struct cros_ec_command
differently (reference:
https://elixir.bootlin.com/linux/latest/ident/cros_ec_motion_send_host_cmd)
- It is not clear to me how readability will be affected by making the
change to cros_ec_cmd().

Due to the above two factors, but primarily because I wanted to avoid
making such an involved large change in this 17 patch series, I
reasoned it would be better to make the transition to cros_ec_cmd()
for these files in a separate patch/series.
My plan after this patch series is to work on this driver(perhaps we
can eliminate cros_ec_motion_send_host_cmd() itself?), and then remove
cros_ec_cmd_xfer() usage.

WDYT?

Best regards,


>
>
> >>      if (ret &&
> >>          state->resp != (struct ec_response_motion_sense *)state->msg->data)
> >
