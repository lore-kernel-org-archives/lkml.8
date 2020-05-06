Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199C0C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F080B207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588792320;
	bh=citGFZi6S2DjQsJEvhMOJMQ8CN0QUttWidsX75r3OJo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EnNWXwkHtI0mT5pYj+aZjfzznejAFnUxXGrBxHQo3LlWnSSdApEP7PsNfGKi3JoVK
	 xVBtA1StTXCsKaPve/Sea4aSa6KXVpJpqGPWyPlgV0wWPlZlRFIfLrUr0h7zNbyoxo
	 SF4KgD+OqhMfRg186o0bIpTydwVjJjsGY2HfjaH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgEFTL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 15:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725915AbgEFTL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 15:11:58 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3769B207DD
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 19:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588792318;
        bh=citGFZi6S2DjQsJEvhMOJMQ8CN0QUttWidsX75r3OJo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Aw+gB5NtkkvlBUT7tXLIY/bYcAizk6f9IGQJPWdCXny2TLOJ+j3hSmvuTidCcV4ys
         UCWAKL3K0zdSWI0xW0kdLCH9au34dMI9aEQ9F7w0AuQjiZCsqhUy/A5QX5cG8DG7cM
         eT5n0dkz5cT7NNBedDpp64YAk3Tk0zFm9c2t5MTM=
Received: by mail-ot1-f53.google.com with SMTP id m13so2304232otf.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 12:11:58 -0700 (PDT)
X-Gm-Message-State: AGi0Pub9J2Cz9WBYTsPX6vGuNPwjhw2UFINEyUTq4h+HnpJyTelLPWoY
        0vIKEzC9EGvfkNLFiDPoQbWuz2v27xDDFCnJ0w==
X-Google-Smtp-Source: APiQypLrUw5swnxye+W3hdYYDWTGz5iKhNQMAHolEI0hjg6JYAgHL6gBXXl6Wxn72fX//SnrpbedExiEb0XoVH4kQ08=
X-Received: by 2002:a9d:1441:: with SMTP id h59mr7797620oth.192.1588792317532;
 Wed, 06 May 2020 12:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427210806.37422-1-cristian.marussi@arm.com>
 <CAL_JsqKV8j8Jm_7B7no6SsZ9AAv=WjqOx9EmCp3fomUXRO-FzQ@mail.gmail.com> <DB7PR08MB3657577B2251084FF2B4A0EF9EAA0@DB7PR08MB3657.eurprd08.prod.outlook.com>
In-Reply-To: <DB7PR08MB3657577B2251084FF2B4A0EF9EAA0@DB7PR08MB3657.eurprd08.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 May 2020 14:11:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK6+2c9jXfsipqH0qakTGrszSGN4+kZqGstOmkWj40JGQ@mail.gmail.com>
Message-ID: <CAL_JsqK6+2c9jXfsipqH0qakTGrszSGN4+kZqGstOmkWj40JGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] SCMI System Power Support
To:     Cristian Marussi <Cristian.Marussi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sudeep Holla <Sudeep.Holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:23 PM Cristian Marussi
<Cristian.Marussi@arm.com> wrote:
>
> Hi Rob
>
> thanks for the feedback.

Plain text for maillists please.

>
> > On top of this a new SCMI driver has been developed which registers for
> > ----
> > such System Power notification and acts accordingly to satisfy such
> > plaform system-state transition requests that can be of forceful or
> > graceful kind.
>
> > I needed this 7 years ago. :) (hb_keys_notifier in
> > arch/arm/mach-highbank/highbank.c)
>
> ...better later than never
>
> > Such alternative, if deemed worth, should clearly be configurable via DT
> > (also in terms of which signals to use), BUT all of this work is not done
> > in this series: and that's the reason for the RFC tag: does it make sense
> > to add such a configurable additional option ?
>
> >Which process signal to use in DT? I don't think so.
>
> ... beside the awkward bad idea of mine of configuring it via DT
> (which I'll drop possibly using modparams for this config), my question
> was more about if it makes sense at all to have another alternative mechanism
> (other than orderly_poweroof/reboot)) based on signals to gracefully ask userspace
> to shutdown

gregkh will tell you no to module params.

If the signal is not standard, then we probably shouldn't go that route.

Rob
