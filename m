Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FE0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D40D920738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 00:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4vuMAVB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFCA11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 20:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFCA10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 20:27:26 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B079C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 17:27:26 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so480085pgn.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 17:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ME+J2XgncrkU0A4OBlYAXUXEjouusqpGzoZTVSrmwQw=;
        b=S4vuMAVB6G9qrlvGBq6XTFn0smHYgZQ59s07EGefADs8D56CQbqplctsoBCC4PDC7s
         JeL3PZp2BtOGp9VeIpuAX23boGbvgCKmfT+nBQHUVz4XOBFJKuaNrthT9Ag3iDmjUdta
         xFhxQNaKwDDOZHnD6CMepNCxC3ebUm4eBzDksT0zuRfUjRd4V/0OizUEHMqP/cCNMJ92
         6XF6smSZTYK0Ztkp6DbN6JqDVt5aoREZ9jq7jF6pOlxI54b9vS9C4rYyEF/TVbexiLXy
         Y55soAIfOJYoFOUHCL4LVHXI72IMgW7KkqR8vUx01Li0Q0+ncsqmNSo3f5zZ9w8/wr6H
         hCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ME+J2XgncrkU0A4OBlYAXUXEjouusqpGzoZTVSrmwQw=;
        b=KcfTKPCfDSZyEGfO3cbaLhud1jJDY+mlnBg1r6BoyPhPxuEg7TYRc1s67xad2WoxQD
         s5UPJAeSukA3K3CSQztYheK7mddv1OaNMmlwY6ZhGuPkAZuOLN8jgidzj4T1Xap6LPtK
         wwXyserK736weykrFMeIv1ovRUz5M/7jM+a96LhajvGLqexn03cxwGDTC+PwHB0gsSgq
         7DzF7MWNneZyKaI+bLvR6nuzACl8BXDUH1WgoohDn2ZGpVQts0+tO3GYSmhhlp+cz6ok
         GAGnmhCm6V96BzH9ROcXwPa8DwC0dDbi4MjSKPXqBz8iAo+9mkOq/xrRgrtJV1mNp2Tl
         Ryvg==
X-Gm-Message-State: AOAM530hHs+iaU0hT6ERWr3806IKhkF3Iu2TkwIanOzTfbSSRfafI0fB
        k/mtQ2oSSg9I5hkY+SBzVxEW
X-Google-Smtp-Source: ABdhPJzZvG3si+pcjptk9lE4DT9UohBXFUnhVpKpLi3UNRBawg7bgDJ2V8v6PiM99TbovUk1Bc/CkQ==
X-Received: by 2002:a63:d307:: with SMTP id b7mr26895913pgg.219.1591144045661;
        Tue, 02 Jun 2020 17:27:25 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e1f:d46:97b:c5ec:c70b:6998])
        by smtp.gmail.com with ESMTPSA id n2sm133759pgv.65.2020.06.02.17.27.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jun 2020 17:27:24 -0700 (PDT)
Date:   Wed, 3 Jun 2020 05:57:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rakesh Pillai <pillair@qti.qualcomm.com>,
        Govind Singh <govinds@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: Re: [PATCH] wireless: ath10k: Return early in
 ath10k_qmi_event_server_exit() to avoid hard crash on reboot
Message-ID: <20200603002715.GA5349@Mani-XPS-13-9360>
References: <20200602052533.15048-1-john.stultz@linaro.org>
 <CA+ASDXMbNvbBdsC11dzUPX7RkMFYhJev2npPsRD_SnGQB+1hag@mail.gmail.com>
 <CALAqxLVA1ZQjwEdbX5KGbSyLnMBAzm9PoN_Ta_Z7rBf4w3GOvQ@mail.gmail.com>
 <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ASDXPddgOvEX___unx7N2YsQctsZN+1vkwPbi8Ab_zfwFfzw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 01:04:26PM -0700, Brian Norris wrote:
> On Tue, Jun 2, 2020 at 12:40 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Tue, Jun 2, 2020 at 12:16 PM Brian Norris <briannorris@chromium.org> wrote:
> > > On Mon, Jun 1, 2020 at 10:25 PM John Stultz <john.stultz@linaro.org> wrote:
> > > >
> > > > Ever since 5.7-rc1, if we call
> > > > ath10k_qmi_remove_msa_permission(), the db845c hard crashes on
> > > > reboot, resulting in the device getting stuck in the usb crash
> > > > debug mode and not coming back up wihthout a hard power off.
> > > >
> > > > This hack avoids the issue by returning early in
> > > > ath10k_qmi_event_server_exit().
> > > >
> > > > A better solution is very much desired!
> > >
> > > Any chance you can bisect what caused this? There are a lot of
> > > non-ath10k pieces involved in this stuff.
> >
> > Amit had spent some work on chasing it down to the in kernel qrtr-ns
> > work, and reported it here:
> >   https://lists.infradead.org/pipermail/ath10k/2020-April/014970.html
> >
> > But that discussion seemingly stalled out, so I came up with this hack
> > to workaround it for us.
> 
> If I'm reading it right, then that means we should revert this stuff
> from v5.7-rc1:
> 
> 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace
> 
> At least, until people can resolve the tail end of that thread. New
> features (ath11k, etc.) are not a reason to break existing features
> (ath10k/wcn3990).

I don't agree with this. If you read through the replies to the bug report,
it is clear that NS migration uncovered a corner case or even a bug. So we
should try to fix that indeed.

Govind: Did you get chance to work on fixing this issue?

Thanks,
Mani

> 
> Brian
