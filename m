Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBB9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C374B207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t8dBf2Re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgESWtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgESWtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:49:17 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6EDC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:49:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x2so600767pfx.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Ty1uax6DhWGAFtgE02Vizy5V0zxupHIkWCZHfOEkhA=;
        b=t8dBf2Re30D48kdWaxnWeg5qjnHBsSPjh8gl3yhU3/omM3rZox4QiSWEztEngqMnt7
         TJ9KJ9Dk6HH/bIfagl0fdv1s/3aaysmvRj6eeG9OrsYQl27NhGIVFLEfv8mGRUqb6UTl
         WGod58OPLLNcOrUZBVVgeF8ecKbVV2bKXPJT2OwjxTjrIje6Wp8RnjOx2p1udFNGb4bL
         Y1lfYVjRlJAXESxTeaahmjF7k8LyJVBejv9EzcznGcLs6BlqpMydDPDqXGUQl3+BJg0L
         tu0QKrN5lM/ydX1HxIfs7bV6nHOlx5jHnhxJnnwuAl2b1Ud1SKH0qz/gRpHIgJILyvUw
         9EiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Ty1uax6DhWGAFtgE02Vizy5V0zxupHIkWCZHfOEkhA=;
        b=QwA3ZIbqb/rESs66AFq1pZzQvtfk3ls98Sidxhi4THn/CGuITJ0tPq81q4KrV9AS9H
         RZ8OOF83BR70i8YeLeFsD6C+FNRyPDjFP6Y28WBoqKAYj9VsRp+qhIRt75Fc6EzKVdE9
         LYUFW1N30bzO4FWKLMfCsRhjW/tsul04yk/UabpIAgXVhkWU8Ns7ofpafdw7Sz3C97z6
         koLUlVNfWzDjXsZ5bbHB1pR/+seZil0Gm0rV2f1gXn54r1/CKQ5kbwY+qEGTm2Xgv5id
         jaiDDC+kav7Kin8RHIayS4c9vhmR/zFIiBeieDeJ2Sy51HRnSCxECdFloElb/qg8CBDS
         9Zpg==
X-Gm-Message-State: AOAM5320BJdeJgjeRBZk8UQBWzpptEuexlycdJNBFqRPSAnMBe4818XU
        UNgju30QJjtWbMe+cNuJw79jbA==
X-Google-Smtp-Source: ABdhPJxrF0PPloT5L7c9LARzGBOK1gTA/drsLOH7U808yVpudmrjPQgxJ5DYlfOA1iS9t+A1KuDyCQ==
X-Received: by 2002:aa7:9e90:: with SMTP id p16mr1341252pfq.38.1589928556006;
        Tue, 19 May 2020 15:49:16 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l1sm447873pjr.17.2020.05.19.15.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 15:49:15 -0700 (PDT)
Date:   Tue, 19 May 2020 16:49:13 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, clew@codeaurora.org,
        sricharan@codeaurora.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH V4 0/4] Add TIOCM Signals support for RPMSG char
 devices
Message-ID: <20200519224913.GD26832@xps15>
References: <1589346671-15226-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589346671-15226-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:41:07AM +0530, Arun Kumar Neelakantam wrote:
> Glink transport support signals to exchange state notification between
> local and remote side clients. Adding support to send/receive the signal
> command and notify the clients through callback and POLL notification.

From a general point of view it is hard to have an understanding of what this
patchset does and if it is the right solution due to a lack of context.

The cover letter and changelogs are sparse to a point where a
reviewer not familiar with the QC/Glink implementation can't offer much more
than syntactic comments.

Thanks,
Mathieu

> 
> Changes since v3:
> - Correct the TICOMGET case handling as per new rpmsg_get_signals prototype
> - Update the rpmsg_get_signals function header
> 
> Changes since v2:
> - Modify the rpmsg_get_signals function prototype
> 
> Changes since v1:
> - Split the patches as per functional areas like core, char, glink
> - Add set, clear mask for TIOCMSET
> - Merge the char signal callback and POLLPRI patches
> 
> Arun Kumar Neelakantam (4):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add TIOCMGET/TIOCMSET ioctl support
>   rpmsg: char: Add signal callback and POLLPRI support
> 
>  drivers/rpmsg/qcom_glink_native.c | 126 ++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        |  75 ++++++++++++++++++++++-
>  drivers/rpmsg/rpmsg_core.c        |  41 +++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |   5 ++
>  include/linux/rpmsg.h             |  26 ++++++++
>  5 files changed, 270 insertions(+), 3 deletions(-)
> 
> -- 
> 2.7.4
