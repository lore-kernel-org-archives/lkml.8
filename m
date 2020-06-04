Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB6B20772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591293738;
	bh=XWpj5b2S01/6ECCr7X2AhmqOUvfk8e7qkk0AWoPfkD0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wmoQpO1ldDoZNLaJdNu+jo8I2qjEoRJ7ambAe/4fM6jsXrpi9WC6GFqPdb03tVgqp
	 kZ75wt7t2HcVtGHKOk8jXOzvyqbSqdi99HBy8mOFEOsCs0GzdHULhf3W/5m0StdRwf
	 DpBjXqQPUJe8uMF4WjY9Dr7iR5foj1avg9ytBUSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgFDSCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbgFDSCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:02:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CCEC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 11:02:15 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b6so8496851ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NJu9EA6IqggHbENFhEKQMn+VFyJ2Tb7JneP8S1dPbhg=;
        b=XbSYmX9dfuFt8qZyVt2utJ3X7vIZPoyPwIFMsqYr2Q5C3jeS2lL/WAb9SAoy6EyLex
         Oc11io92RIU6uWF6weNyELxtktswR5mCPRXatifZqkspYu9lRXhw8QUrSVSrwFLmcWhQ
         hcH7Dk7wyeTFSDJxjZsb5z/71YiOCWh2hucOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NJu9EA6IqggHbENFhEKQMn+VFyJ2Tb7JneP8S1dPbhg=;
        b=DxZ1KGpU9O42JDo0nm/R9eTq3A9uUKgI86i3F+7V+2DEaC390G4xo/OBAZm8qa48I4
         EVlJc+6uoxApoxmq8ufBAY5WolPW3mx/b1Gal+1JThi8KDTCMECdgPcDGO/+9RmO02Pv
         kX7Tz+iJ+OAzMtWjH6O0z4kED7NrOYpDNNcWE45jsnsMKNlICNNX9OKIfisKD+Pcrr4V
         sghwxje1UhcHObg9OcV5Zw5RAL/mS9WISrI1kUmPT70BlBkFVByhQ+gUzN5Kq/17eMqE
         qq5WhqACjm2PAKXSPkzK8GlXCl5eESzOb7z0Wcqx3SwHW7kuFlQyTw1ofhrmI8Fcnk16
         H8Fg==
X-Gm-Message-State: AOAM530eErxueD9WfQ7pCAgxqQqcf9Fgta4RW11sP5YSgEPqdbUG2UD3
        gQ0bl0oQP+zPaDfye2FiVI0d5dVMK1g=
X-Google-Smtp-Source: ABdhPJwgjRyxDPMhNHMt4KSRkL0vut5fzlX8z04vmi+tJ5/QIxk8YtOtivhBg5ZRNbr+YIE3YcFBQA==
X-Received: by 2002:a2e:b5c8:: with SMTP id g8mr2795891ljn.61.1591293733237;
        Thu, 04 Jun 2020 11:02:13 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id g3sm72436lfc.94.2020.06.04.11.02.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 11:02:12 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z206so4174465lfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:02:12 -0700 (PDT)
X-Received: by 2002:a19:6a0e:: with SMTP id u14mr3084460lfu.192.1591293731718;
 Thu, 04 Jun 2020 11:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200604001441.GA257203@google.com>
In-Reply-To: <20200604001441.GA257203@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Jun 2020 11:01:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wim6RwBGAz4CFf3mBJ-WOFR-fdKT=8eX5RrUgePXta_TA@mail.gmail.com>
Message-ID: <CAHk-=wim6RwBGAz4CFf3mBJ-WOFR-fdKT=8eX5RrUgePXta_TA@mail.gmail.com>
Subject: Re: [GIT PULL] chrome-platform changes for v5.8
To:     Benson Leung <bleung@google.com>
Cc:     bleung@kernel.org, bleung@chromium.org,
        enric.balletbo@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm. Your pull requests are confused.

Several of these commits were already merged long before 5.7.

For example:

On Wed, Jun 3, 2020 at 5:14 PM Benson Leung <bleung@google.com> wrote:
>
> Gwendal Grignou (1):
>       platform/chrome: cros_ec_sensorhub: Allocate sensorhub resource before claiming sensors

was merged back in early May because you sent me a pull request for
"tag-chrome-platform-fixes-for-v5.7-rc5"

Now you're not supposed to pull in my tree into your development tree,
but you can certainly do a "git fetch origin" or similar to _see_ what
I have merged previously and not report stuff that has already been
merged long ago as new..

               Linus
