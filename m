Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460C2C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 236CA2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W9wU0S35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDXCny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDXCnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:43:53 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0FFC09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:43:52 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so3194026plq.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=MNMnOVg0VvvHH7uhAzqo/TEq6LY04Ce9ZaQn59nbqNE=;
        b=W9wU0S35tK3hdAWzJ5sK0FfvQ4pOzhzpB+Kp5Tz2BrjguU+aR3rN67BrYxFNIHfYIo
         LxfgPg2tX0tcnDr8MI4wT8jl1I4AXY6BsgyC2KXSJzlctVPKZzaEdcjEV6CYKIRHJ3uB
         db1an0G+FO+QGZ8xUpuGYcwfGk1+x+A/CNFH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=MNMnOVg0VvvHH7uhAzqo/TEq6LY04Ce9ZaQn59nbqNE=;
        b=fkrHD5ukIvChckbF/gXbiFfDVxuSIYEynU58EKjiBz6xm31tEvU6mCWsTh/00nTfp3
         YKcrsAhIkknYeIbiQc6LTc2eyvtKJ3iz5H3/hHfFaU+Jg/NOnfyr4NvskRx2x8Xh35Yi
         DXXW4s828HeYbFKzREJTUQKRiMPbKn05+D9P5NeyeA0cA69/68Qy+84s8LTg+lQK3vdb
         xkkltICveC35apmYwGWAIcWDfX/nF91Le5OIp25Bbd6D0AVZLA9+iEWyob313LuLW0Ra
         6Rg3oRUBb/msPsygXmltebcenkEREPvF40ulsiHQNwSW+x3EQ3Ijy0fHzUsO7gswKOBy
         7Dpg==
X-Gm-Message-State: AGi0PuZYjpVrzrkrAyZn4ciZdH1v5co8YGqyFYoStZ6mfSF3n1mgce7u
        R/+ufvI2IOcAXso8uJgPEN83jw==
X-Google-Smtp-Source: APiQypK3fY2AtARpDgKpZjQz72rkRV9mIULEsBCePCFvjPt31SoILsB4CygqnJHiX2BIX8WWIZdyRw==
X-Received: by 2002:a17:902:ee06:: with SMTP id z6mr4719895plb.125.1587696232161;
        Thu, 23 Apr 2020 19:43:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id u21sm3415738pga.21.2020.04.23.19.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:43:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200422145408.v4.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid> <20200422145408.v4.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
Subject: Re: [PATCH v4 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, mkshah@codeaurora.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
Date:   Thu, 23 Apr 2020 19:43:50 -0700
Message-ID: <158769623054.135303.13351246588453753133@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-22 14:55:01)
> cpu_pm_notify() is basically a wrapper of notifier_call_chain().
> notifier_call_chain() doesn't initialize *nr_calls to 0 before it
> starts incrementing it--presumably it's up to the callers to do this.
>=20
> Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
> This potentially means you could get too many or two few calls to
> CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
> luck of the stack.
>=20
> Let's fix this.
>=20
> Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
