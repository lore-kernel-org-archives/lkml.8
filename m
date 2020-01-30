Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C824C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5B320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 09:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcTTTcK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgA3J0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 04:26:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44174 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgA3J0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 04:26:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so2497242ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=8SGJClgv7vCpuUbrzWc3aiRmA3e15IEmlFx71D1Eo48=;
        b=CcTTTcK4WM9iSIoTMMhBw2ukMSFMCQ26I0i+oKdes0NeyR6saKuPQsGnoSssOA3Mmt
         JuVykFIA7x13xH8CgmHvx8xR9VglEK9H4qluV1ocPIJFNbJ6e8pK9xSrPvODCVe622sJ
         gWs9NHwQoB5PDTLv9NPffntaB5kJgBFiSu+2WMrem8h+739aiw9B8PXS/Xz3RtWfz51f
         J+wqEVEg/pnMeYx2ROKrvmHi0osg0pM2R3Fp3SiYEzWXbLr6XomMkwK7uHSZj4hpp9Ug
         OsgF/UIIypR+RtQdA0RFdYv9uV/IjpBclRrxBx0KsvdEtrm2d0SNToTfUsW+Gw/dLAOm
         2X4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8SGJClgv7vCpuUbrzWc3aiRmA3e15IEmlFx71D1Eo48=;
        b=pgqPKk8oYLiPTpq986xaujbj5Ptc7QKHIgoO27FZSb5EJjLAIbtUy9O5PPiexuRi8k
         M0Tk6Fs6vajolSDlhNRj/0/cubcxtJULGf7YS1s67IV0o5s7nI5AgNRBRDZzzkNbzNYM
         PKCdaZZCZwLCv4Ph5YEGZ1rg5OmbedVNyMHns7Ga4Hl4aKZEIedYZftbW0SMrgMMaEv5
         oYsDDt0nbmSdPsSiq0whHNLgHqj9SOgWAe9wMmx6DqvDjqFKgMpX40uK7PD5WpKhnex1
         OD2MtCZpJVK5qCENhi9KcgXc0PQsC4xIltRgQJC0VWCCVCPAGDKKhd7kB0DEsk/N5w00
         Ey9Q==
X-Gm-Message-State: APjAAAUWLpkY1iBbKct555a9dVaIJvlSTzHwGazOMvxmfQ1kfsgXVTs8
        IkQiAn7d/4bjhbLIB1+quSsEfaTeI8kuTVJwDCDOoyt4HCKwpw==
X-Google-Smtp-Source: APXvYqxiGYPmMj0hEMVR/h1w0r7wIG+bJLEBgwKh8ESZeU2QJV7QXJIwEEgZe7CNbWh6Cx2CebVtFmVU2WRKLrLr9Ts=
X-Received: by 2002:a2e:9143:: with SMTP id q3mr2094270ljg.199.1580376369658;
 Thu, 30 Jan 2020 01:26:09 -0800 (PST)
MIME-Version: 1.0
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 30 Jan 2020 10:25:58 +0100
Message-ID: <CAN5uoS_A9TYU2aWf3WVq3KGna6oVswfut+hC7sJWvhfYggMwTA@mail.gmail.com>
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Viresh,

On Tue, Jan 28, 2020 at 04:24:19PM +0530, Viresh Kumar wrote:
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent on the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages.
>
> The transport protocols just need to provide struct scmi_transport_ops,
> with its version of the callbacks to enable exchange of SCMI messages.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> @Sudeep: Please help getting this tested as well :)
>
> V4->V5:
> - struct scmi_shared_mem is moved to mailbox.c and it is completely
>   handled by transport layer now.
> - And so lots of ops change due to this.
> - Fixed a bug from previous version where wrong dev structure was
>   getting passed to devm_kzalloc().
>

Hello Viresh, Sudeep,
I've made a first port (draft) for adding new transport channels, next
to existing mailbox channel, on top of your change.
You can find it here: https://github.com/etienne-lms/linux/pull/1.

I don't have specific comments on your change but the one below.
I think SMT header should move out of mailbox.c, but that may be a bit
out of the scope of your change.


> (...)
>
> @@ -470,13 +310,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
>  if (!ret && xfer->hdr.status)
>   ret = scmi_to_linux_errno(xfer->hdr.status);
>
> - /*
> - * NOTE: we might prefer not to need the mailbox ticker to manage the
> - * transfer queueing since the protocol layer queues things by itself.
> - * Unfortunately, we have to kick the mailbox framework after we have
> - * received our message.
> - */
> - mbox_client_txdone(cinfo->chan, ret);
> + info->desc->ops->mark_txdone(cinfo, ret);
>
>  return ret;
> }

I would prefer an optional mak_txdone callback:

    if (info->desc->ops->mark_txdone)
       info->desc->ops->mark_txdone(cinfo, ret);


> @@ -713,29 +547,18 @@ static int scmi_xfer_info_init(struct scmi_info *sinfo)
>   return 0;
>  }
>
> -static int scmi_mailbox_check(struct device_node *np, int idx)
> -{
> - return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> -   idx, NULL);
> -}
> -
> -static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *dev,
> - int prot_id, bool tx)
> +static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
> +    int prot_id, bool tx)
>
> (...)


Regards,
Etienne
