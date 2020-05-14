Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A23C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B64F205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3T9H3oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbgENPGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgENPGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:06:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3799C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:06:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id a9so2912597lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s6pQpCMudujfiAjUNY0Vi1g8QyE9NzQJQONui0Wm3WM=;
        b=g3T9H3oQ9lDSC9YebE/7R2v3osY77/Pvq5h3Wqau24cmSPvO8DbK7aRZttXnHrOUAo
         VgkpMqcGLtWerb2QFx7QQ9bsLAO/PsZ8b/NQdQzfdqcLuResZab+7dn9USjGOFiPfjHO
         9qkXYVl5DG/Jlkz6BRXkoiflzpMfd6LIoSR3dHOfgemCqpFgk09SxHd9UNG/5JC5Wfpk
         ZNoP976TJEgSYLuStmsORP9g9l4OIczXeTeC3/eJRsVPMFu8pO7Pwl8b3YjkD74QCdrO
         h41HBq2Hc4Td01KebCaExCtL0L55rrSUYwgtM8dETqStj3A3LI+Jz0S4RFNpUAeebMtz
         /7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6pQpCMudujfiAjUNY0Vi1g8QyE9NzQJQONui0Wm3WM=;
        b=sD92qn8niNZC/uU2p9O6PN5r+2YOc376Bsz8fBITVNw/DB4//Nau58CcF8nK/1khVE
         0jbqGW/ygcfr1YRe9T84OhI3Wf9txrtRrLRRjf7nEP3XqIA0CxjcP2237j/M3ApFCmA1
         +44/BCzZafdZvVC52FehNP4pefjXml3mEl4vnsmyKF9li7RSHGvs07XlGuOCjiL/OEdO
         aJ77yQni4BvpBaE0xhnbzF/l2b+f9zM34Ptsj8/xMXP1o+apbXyPTGFsuXOTkCFkTaD/
         egtDjLbiwPVp8pmVD9NzevduM26JlBk2C7fidPdTS/mvzvXN7asCCOXKGdZmHDUzjptP
         Yzgg==
X-Gm-Message-State: AOAM532phJiyCItWxjjhzqi1graYLrxhLNIUqgC8JVntte0wdCuOBf49
        QtMUekCdNSjK/1ml7S9Mcc5Ecylwf+OEawZ2Z+Hd6AWtOF2pmQ==
X-Google-Smtp-Source: ABdhPJyqNOeUwCze7pjStc+fCzjwPaJVk4A8NthXF4Ocusde3ddlkvHcyH91UjYcAtdf2Q05SfUOpl++RL/M/PRWzX4=
X-Received: by 2002:ac2:5212:: with SMTP id a18mr3603745lfl.83.1589468793160;
 Thu, 14 May 2020 08:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200514082428.27864-1-etienne.carriere@linaro.org> <20200514142924.GC23401@bogus>
In-Reply-To: <20200514142924.GC23401@bogus>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 14 May 2020 17:06:22 +0200
Message-ID: <CAN5uoS_bimZsFqwaODRRWeCe15JMepQa2z9J0+dq7qNfwxRsug@mail.gmail.com>
Subject: Re: [PATCH] firmware: arm_scmi: fix SMCCC_RET_NOT_SUPPORTED management
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 at 16:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, May 14, 2020 at 10:24:28AM +0200, Etienne Carriere wrote:
> > Fix management of argument a0 output value of arm_smccc_1_1_invoke() that
> > should consider only SMCCC_RET_NOT_SUPPORTED as reporting an unsupported
> > function ID as correctly stated in the inline comment.
> >
>
> I agree on the comment part, but ...
>
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  drivers/firmware/arm_scmi/smc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/smc.c b/drivers/firmware/arm_scmi/smc.c
> > index 49bc4b0e8428..637ad439545f 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/smc.c
> > @@ -115,7 +115,7 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
> >       mutex_unlock(&scmi_info->shmem_lock);
> >
> >       /* Only SMCCC_RET_NOT_SUPPORTED is valid error code */
> > -     if (res.a0)
> > +     if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> >               return -EOPNOTSUPP;
>
> Now this will return 0 for all values other than SMCCC_RET_NOT_SUPPORTED.
> Is that what we need ? Or do you see non-zero res.a0 for a success case ?
> If later, we need some fixing, otherwise it is safer to leave it as is
> IMO.

Firmware following SMCCC v1.x for some OEM/SiP invocation may simply
not modify invocation register argument a0 on invocation with a
SCMI-SMC transport function ID.
Resulting in res.a0 == scmi_info->func_id here. Which is, by SMCCC
v1.x not an error.

From SMCCC v1.x only SMCCC_RET_NOT_SUPPORTED (-1 signed extended is a
reserved ) is a generic return error whatever function ID value.

Or consider part of the SCMI-SMC transport API that output arg a0
shall be 0 on success,
SMCCC_RET_NOT_SUPPORTED if function ID is not supported
and any non-zero value for non-generic **error** codes.

etienne

>
> --
> Regards,
> Sudeep
