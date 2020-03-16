Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18894C3F2CE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2E420658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:57:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mae18Uql"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732268AbgCPR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:57:45 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732056AbgCPR5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:57:44 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so10388998pfj.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 10:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=qzjhnEh9awmU+RBLsPJfUtIGXyo+sxpVoHpWwJojqHM=;
        b=Mae18Uql7k0fuNuBwKeTa3aya4TlMJ8Bnb3SF8fYMzvl7LahzL0mNnpeGiy1V2F8JD
         HQhfDLVrqTKT4gth8nfzq7OSO/Gv5wdjtSjStu1wuHrp8a5N1aLG2CApAeqa0D8Dn+8m
         b+YIGkqGOscsoP/NXEHOkLgLYwXqO0OIUARrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=qzjhnEh9awmU+RBLsPJfUtIGXyo+sxpVoHpWwJojqHM=;
        b=SRcuaNBU3BaIjLzBhJbt2DpiUFULyYVY2QdrzUJEAXKGf840FWDgLRh/76GbYcdonK
         qrhK0izKWP9CPQfX76Q6i321imsCAMrPYl2XiJyVthSYWGefcHNwyikbOE+gz6HZY0QB
         cGKe6KXCF1fhf5NSt2fCnr+GeIdhVVKvjtch9fVKn10+B1XueKRFcK+bMnRhaR9OT9b2
         IeGr4EXMIDKN6qIrRMsC+ISFma3czGLwZOFbJzC4UkAz/yKPBbU/6r1jOkW1fXsiYI/O
         46KV2vWxkOf6AL6xljvEgbvXecCpc2tUjNiKkgQLHiFwIVPeIm8pyE9MXJmzAf/rhB5H
         BMtw==
X-Gm-Message-State: ANhLgQ2JX+x50Jq2u8hWrnLLAa8IldhOjuQpELQpO5RCbypWwDFNDwDm
        IFkVrpobJBUqffMlCJznUVAoGw==
X-Google-Smtp-Source: ADFU+vuoaQW5kuoGcEmnavFL3M27jIDZjKhgkcUDdspNxwRdrlBO2/VRoWJmnMfGfUnR6PY3km8Exg==
X-Received: by 2002:a63:ce42:: with SMTP id r2mr1071355pgi.106.1584381462395;
        Mon, 16 Mar 2020 10:57:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id r8sm423697pjo.22.2020.03.16.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 10:57:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200313134635.2.I3648fac6c98b887742934146ac2729ecb7232eb1@changeid>
References: <20200313134635.1.Icf54c533065306b02b880c46dfd401d8db34e213@changeid> <20200313134635.2.I3648fac6c98b887742934146ac2729ecb7232eb1@changeid>
Subject: Re: [PATCH 2/2] tty: serial: qcom_geni_serial: Don't try to manually disable the console
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        bjorn.andersson@linaro.org, akashast@codeaurora.org,
        skakit@codeaurora.org, rojay@codeaurora.org,
        mgautam@codeaurora.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@google.com>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Jiri Slaby <jslaby@suse.com>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        gregkh@linuxfoundation.org
Date:   Mon, 16 Mar 2020 10:57:40 -0700
Message-ID: <158438146097.88485.15022185893506227094@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-03-13 13:46:52)
> The geni serial driver's shutdown code had a special case to call
> console_stop().  Grepping through the code, it was the only serial
> driver doing something like this (the only other caller of
> console_stop() was in serial_core.c).
>=20
> As far as I can tell there's no reason to call console_stop() in the
> geni code.  ...and a good reason _not_ to call it.  Specifically if
> you have an agetty running on the same serial port as the console then
> killing the agetty kills your console and if you start the agetty
> again the console doesn't come back.
>=20
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
