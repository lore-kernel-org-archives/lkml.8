Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AECC2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4EE020728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I+gDnRKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDXCi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDXCi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:38:26 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67222C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:38:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d184so4075415pfd.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xkSGRkF++k+CMpZ51T6z7LFsFmj1btnV8v6kQtU62/U=;
        b=I+gDnRKqpg1I86DxyMy4+YzJ5N2lmDVvQJ7IZOBFnPURDa2WG8Jb6UGne5D1//TcpC
         O4zuO/zL+S686HpKagdoYlACOgwWl7ZSSm8OI4Yb9OYvGHc2Q7KiwndV185AATwlDngc
         JUe42JJmqlYbxWYQ/Li/bfgJ+dBqY5J233/Tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xkSGRkF++k+CMpZ51T6z7LFsFmj1btnV8v6kQtU62/U=;
        b=AaeWGDfmtOXaq2BsjUTD59VyD1T2U90qSkEI1xv+SL4hMFjsidu85lpD4tCyzSWuc4
         iXPWQIN9mO85zLOGVg+fC7VOh1i4GtbyLs/I1QxX1ssbqVccYqrs2qLM0u9ZOqSBB/fy
         7Uc6vkFVbGAxQguV/7Z3IVvxUpl0Q7qzuQgrfRNZHnxb3QKtC9pBZ0Tx4tbWf5xv+FWW
         uohEAjZNOClloObkAI6TqjLzlvbgiZs6vWeGhp7AANz4whI3hCA6oDEkRrP4niDDKaex
         nFbQpxH55LM0xJIfgekXq2FmlmtgknKUozKP6pMeZ9WxshVMfU9OUd22TsjX0+Q8kVzX
         cLSw==
X-Gm-Message-State: AGi0Pub6nOFg99Yb+WZLD9BfUCqHWty7N8gf4d5n9BmykYlyL4DfBzTf
        0qJWqOzDFtGbmScqt2mMpnvhtdK0hJs=
X-Google-Smtp-Source: APiQypIgY3XlWvmx5aJnJRpZHoGg4R2hlIqr3yZetx41JEcKOOkkmlsHBuzsqF5wUX9oqkvX8HuwlQ==
X-Received: by 2002:a62:38cc:: with SMTP id f195mr7024640pfa.85.1587695905622;
        Thu, 23 Apr 2020 19:38:25 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c28sm4014957pfp.200.2020.04.23.19.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:38:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200422145408.v4.2.I1927d1bca2569a27b2d04986baf285027f0818a2@changeid>
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid> <20200422145408.v4.2.I1927d1bca2569a27b2d04986baf285027f0818a2@changeid>
Subject: Re: [PATCH v4 2/5] soc: qcom: rpmh-rsc: We aren't notified of our own failure w/ NOTIFY_BAD
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, mkshah@codeaurora.org, evgreen@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com
Date:   Thu, 23 Apr 2020 19:38:24 -0700
Message-ID: <158769590404.135303.4049749400685142607@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-04-22 14:55:00)
> When a PM Notifier returns NOTIFY_BAD it doesn't get called with
> CPU_PM_ENTER_FAILED.  It only get called for CPU_PM_ENTER_FAILED if
> someone else (further down the notifier chain) returns NOTIFY_BAD.
>=20
> Handle this case by taking our CPU out of the list of ones that have
> entered PM.  Without this it's possible we could detect that the last
> CPU went down (and we would flush) even if some CPU was alive.  That's
> not good since our flushing routines currently assume they're running
> on the last CPU for mutual exclusion.
>=20
> Fixes: 985427f997b6 ("soc: qcom: rpmh: Invoke rpmh_flush() for dirty cach=
es")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reported-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
