Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506BFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4D9206DC
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2Pa/sks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgFEVoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgFEVoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:44:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD3EC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:44:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 69so8803857otv.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u7vrFLbpJQAV1cQ0kbQVK9ZLFY1aWi9nsqpax6+qOtQ=;
        b=g2Pa/sksz/aYmEqxoJrzi8zsTy59HbDtq07j/fkreeSaJe3dQOsO526DKGeQaw0yPm
         9AnGaueO42FfatnAKl4P9xpq+EvS/6yZKuVn9jTUA1yzzqBSoag7Qnti6NiJXTrEu38E
         U9gEoKN7o0Oq9W2lOJNNppm6wgniFrffmaebApav2KRi5cSExINsz1PN+ZEqp05XzSpK
         FwkPU3yyVUV7fucokyE3BLb1vo+pxXGN7b3n4sJfGa4sIM3nyqeZ5DIhr0HIEC8LG4Ce
         uJqsElJiNcSkRj6JO05c7uQ1hHZkQCmXuyvvyPaFLCcN94CtOXKDvp6IhikkDR8afowM
         nzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u7vrFLbpJQAV1cQ0kbQVK9ZLFY1aWi9nsqpax6+qOtQ=;
        b=BcCJo1T6nomvdltoQMB4aIJBN4NVYBQ0ER5Iei+Dt4S5UpVsrHG9yr5Fwvg5lBC0Vm
         azjOXQzlNMI9Netb0A2upDTdlgikh1z4sO4g4DK/YduAzRo82vEjs9SQFnOrfiD+Oo7V
         1SMqqD+gaY+rkdnxZrqgK5Uh/gjJnLblBrcUwea3Qu5DLh8SZypzCc/8S8xNGuX5SiJn
         OYwgoRiND9vmmv+vMogfBYfScxVJTt+GYkfCpqZ59SNe10AUG8hNjPMiPpCr9jkLTd52
         hY2DHuGFYVOPVAKpxNOct4ujC/mjgPdS/1KsluUukJVKv4XxInVAfsL7TBHh29cdHByY
         c7pA==
X-Gm-Message-State: AOAM5323zJMAa1ERNEZtrfUD5T2RPYAyiyQMCNdsLS4XXIATRQLQOtDq
        dT4sPAfIt7O0HGyYu5b1RCUorQlqCzoBa+SVEUAQf5QIlLA=
X-Google-Smtp-Source: ABdhPJwGmnxfoPiUbeKtyigW8TXtBuxy9Ingfhpbpr0TlDgmdeKUKLB60VrpSFlnEVS0oTCt4mU9IQZtiti2l2eVbxE=
X-Received: by 2002:a9d:4c0b:: with SMTP id l11mr9559158otf.139.1591393441466;
 Fri, 05 Jun 2020 14:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200605211925.87873-1-john.stultz@linaro.org>
In-Reply-To: <20200605211925.87873-1-john.stultz@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 5 Jun 2020 14:43:25 -0700
Message-ID: <CAGETcx_-ZknGcGJQMesLFWAwUyidK00-6bqF6ZZPbyyYtSPcew@mail.gmail.com>
Subject: Re: [RFC][PATCH] slimbus: core: Set fwnode for a device when setting of_node
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jun 5, 2020 at 2:19 PM John Stultz <john.stultz@linaro.org> wrote:
>
> From: Saravana Kannan <saravanak@google.com>
>
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink to work for slimbus devices.
>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: alsa-devel@alsa-project.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

I thought Srinivas already picked this up and sent it to Greg.
https://lore.kernel.org/lkml/20200511151334.362-1-srinivas.kandagatla@linaro.org/

Am I missing something?

-Saravana
