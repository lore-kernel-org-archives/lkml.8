Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A804C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132542085B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588105107;
	bh=k3bnp2JrBwznUcVuhHk66Arlp2a+C2BbQvoBabGvyFY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cxegPMXJPKIRtUH4+PWPxyzcRpCul1HnixWndcGsjtuJusdmNAmQTeiwhGIlWHpPL
	 gNufY/sCW8PEO1jFSgX46YQeNBYOluns9AxyDCRSvl9VwOQqCpqPpqrOTvxm4mSzUx
	 Z22GN6xrH7XABpuwTvu7Zlg/9yc42Ovy6THS6Dkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD1USZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgD1USZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:18:25 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E449206D6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588105104;
        bh=k3bnp2JrBwznUcVuhHk66Arlp2a+C2BbQvoBabGvyFY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G2OG7F8m3cFnoZLp2hppCZsznH4vEyao4eA9afgJRIxkVozlBJuR4lYGhKchEo9QR
         /tGiP1VXlOng04bdZlyYw/JUKPeDolxScTfCCWmlDUPdldRhi5oDdxCw4PF2ygvR49
         teZM0c6IF1J3q2/MiNEFVI0oPjaLzn52gboRrRFM=
Received: by mail-qt1-f174.google.com with SMTP id s30so18480438qth.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 13:18:24 -0700 (PDT)
X-Gm-Message-State: AGi0Pua2VP5VLmlVAU9tB2dtO+pGSQX/xMLFlhyOQHZyYujy7txD1E/+
        niRC8VRuaBamGWnSfkMAIHhfV64myUFpsIylRQ==
X-Google-Smtp-Source: APiQypJpZYBertwu91oC2RsdbhG8knfP1M2ukw7TDQa6uJ+Zu1++Po7yYlxazeBSwzXG4N3dCbdOLZrpqLM7FZI1kMI=
X-Received: by 2002:ac8:4cce:: with SMTP id l14mr30537890qtv.31.1588105103128;
 Tue, 28 Apr 2020 13:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200427210806.37422-1-cristian.marussi@arm.com>
In-Reply-To: <20200427210806.37422-1-cristian.marussi@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Apr 2020 15:18:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKV8j8Jm_7B7no6SsZ9AAv=WjqOx9EmCp3fomUXRO-FzQ@mail.gmail.com>
Message-ID: <CAL_JsqKV8j8Jm_7B7no6SsZ9AAv=WjqOx9EmCp3fomUXRO-FzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] SCMI System Power Support
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        james.quinlan@broadcom.com, Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 4:08 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Hi all,
>
> this series wants to add the core SCMI System Power support and related
> events' handling logic: the protocol support itself is trivial and boils
> down to some bare initializations and supporting one SCMI System Power
> notification event meant to carry platform-originated System transition
> requests. This is patch [1/3].
>
> On top of this a new SCMI driver has been developed which registers for
> such System Power notification and acts accordingly to satisfy such
> plaform system-state transition requests that can be of forceful or
> graceful kind.

I needed this 7 years ago. :) (hb_keys_notifier in
arch/arm/mach-highbank/highbank.c)

> In order to comply with such graceful requests, and co-operate with
> userspace entities to drive a clean shutdown/reboot, the logic of the
> driver relies on the same orderly_* API methods used by ACPI when handling
> ACPI Shutdown bus events. This is patch [2/3].
>
> Patch [3/3] is a mere JUNO example of the minimal DT bindings needed to
> enable the protocol at the DT level and is NOT meant to be upstream as of
> now.
>
> A viable alternative method (not implemented here) for communicating
> graceful requests to userspace could be to use instead signals to PID 1
> init process (e.g. kill_cad_pid(SIGRTMIN + 4, 1)): this method is supported
> out-of-the-box by SystemD and (to some extent) Android, and, maybe, could
> be interesting as an optional alternative, since it avoids the dependency
> on usermodehelpers introduced by the internals of the orderly_ API calls
> above.
>
> Such alternative, if deemed worth, should clearly be configurable via DT
> (also in terms of which signals to use), BUT all of this work is not done
> in this series: and that's the reason for the RFC tag: does it make sense
> to add such a configurable additional option ?

Which process signal to use in DT? I don't think so.

> The series is based on SCMI Notifications Core V7 (still not posted though)
> which in turn is based on top of scmi-for-next-5.7 and it's available (with
> some additional debug on top) at [1].
>
>
> Thanks
>
> Cristian
>
> ----
>
> [1] http://www.linux-arm.org/git?p=linux-cm.git;a=shortlog;h=refs/heads/scmi_system_power_V1
>
>
> Cristian Marussi (3):
>   firmware: arm_scmi: Add System Power Protocol support
>   firmware: arm_scmi: Add SCMI System Power Control driver
>   arm64: dts: juno: add SCMI SystemPower Protocol support
>
>  arch/arm64/boot/dts/arm/juno-base.dtsi        |   4 +
>  drivers/firmware/Kconfig                      |  12 +
>  drivers/firmware/arm_scmi/Makefile            |   3 +-
>  drivers/firmware/arm_scmi/driver.c            |   1 +
>  .../firmware/arm_scmi/scmi_power_control.c    | 359 ++++++++++++++++++
>  drivers/firmware/arm_scmi/system.c            | 146 +++++++
>  include/linux/scmi_protocol.h                 |  17 +
>  7 files changed, 541 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/arm_scmi/scmi_power_control.c
>  create mode 100644 drivers/firmware/arm_scmi/system.c
>
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
