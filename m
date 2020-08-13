Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B09C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DF020838
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="jYSbh2ES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgHMSDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:03:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AFC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:03:31 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l2so6097934wrc.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlS2sWlVuCJp9TAoRoK9iQhAZM+A1AplrM1bA5vBRzI=;
        b=jYSbh2ESaWKBX7hRekbXY2KQwyrYYLdJCRMFimichM0NHWJ9dSTfPGgiCZrAsXHO8D
         9NcDKWC5pKK4oOpt9G2mm5Kgxucy+7gn2kwFCvS5nCsqqscVHtPX69DWKirIq+rbNORo
         F+1TKOc7jZaiyau7MtxcReVee8SSXmYAUL3bkUR/2AYJch6toeRw9acgd0R5CMCzs0l9
         armU3lIXcJChiUsr5nGd8Voiqu2kv4TCtrAewa/ThG5pNp+7QHl04yYw26rhYmddRXQG
         biHNr2r323W7XXMcZu1hSHNOvtPWXIy+J4OyHJVCPwDM4j1fpxZ1ia/gjx6nzNIdZWoU
         ue9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlS2sWlVuCJp9TAoRoK9iQhAZM+A1AplrM1bA5vBRzI=;
        b=PDXT7y+WIQjMJ/kr9KljFt5uPnRKjSzPjfW/8bYcptCa9CIJ/yTFgNFxORxoSdVh07
         nEUs1aEQKJ4yCXQwtLnwT9xxmikD4XI1ROqjaO0cNuk9OaPRyW2HbT6/lqJBhRdCym8/
         VI7xKNWS8CEAs/Qz+jdlCI7rZtkSXO/snCLB7EqBZSDO9nN7c3TXKDY0Kb9edMAtI/KX
         OSHnfhMVha7moLex1ASUby/S2I5qW0RnWq65TlnQb2wZVqfBRVvIkHGAwNKTkJsFigAU
         mcdGyy3feQjOClO2ZMfr1Xh4CU5nlvukwwGBV00IFd/boTXCdaTrYrZIiiiKE1jo3ys4
         m62A==
X-Gm-Message-State: AOAM530K1F/esrRz6sqxmhhUJCJUcPTDbN2YJcAz5J+gFiv5EFeJJiJs
        NNmCaMXTTwTqm2hXzhzCbDRZOw==
X-Google-Smtp-Source: ABdhPJwIvspk9z7dSu+gE53zPpdHAyk0AiD5E1lsCGSzboCyCZ18NahyFZmc5l2I8fRI4BzcXWEgXQ==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr5189415wrt.154.1597341809924;
        Thu, 13 Aug 2020 11:03:29 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id g18sm11289687wru.27.2020.08.13.11.03.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Aug 2020 11:03:29 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Thu, 13 Aug 2020 20:03:26 +0200
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Jorge Ramirez-Ortiz <jorge@foundries.io>, sumit.garg@linaro.org,
        ricardo@foundries.io, mike@foundries.io, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv8] drivers: optee: allow op-tee to access devices on the
 i2c bus
Message-ID: <20200813180326.GA20155@trex>
References: <20200812120652.30012-1-jorge@foundries.io>
 <20200813072835.GA501056@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813072835.GA501056@jade>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/20, Jens Wiklander wrote:
> On Wed, Aug 12, 2020 at 02:06:52PM +0200, Jorge Ramirez-Ortiz wrote:
> > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > control this type of cryptographic devices it needs coordinated access
> > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > 
> > This trampoline driver allow OP-TEE to access them.
> > 
> > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > ---
> > 
> > v8: review fixes
> >     fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
> > v7: add support for ten bit i2c slave addressing
> > v6: compile out if CONFIG_I2C not enabled
> > v5: alphabetic order of includes
> > v4: remove unnecessary extra line in optee_msg.h
> > v3: use from/to msg param to support all types of memory
> >     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> > 
> >  drivers/tee/optee/optee_msg.h     | 21 +++++++
> >  drivers/tee/optee/optee_private.h |  1 +
> >  drivers/tee/optee/rpc.c           | 96 +++++++++++++++++++++++++++++++
> >  3 files changed, 118 insertions(+)
> > 
> 
> This looks good to me. Did you test this with the recently merged
> https://github.com/OP-TEE/optee_os/pull/4024 ?

I am in the process (please hold this until I can validate end to end
as I was doing with the original code).
I had to rebase from 3.6.0 to the tip of op-tee so it is taking me a
bit longer than anticipated.

Also I noticed that unfortunately a bug managed to get in that PR. The
return value is on p[3] not in p[2].

See below.
https://github.com/OP-TEE/optee_os/commit/30c53a72426366d0a4eb4aa396c37b8fd048a82a#r41447494

Also this version v8 also has now a problem (params get updated after
calling optee_to_msg_param hence the i2c return value from the
transfer does never reach optee)

apologies. will fix.

> 
> Cheers,
> Jens
