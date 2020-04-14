Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFDEC352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 140792076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3h4TqmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633478AbgDNU4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633457AbgDNU4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:56:17 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A9BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:56:15 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id ay1so414805plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=brNSySgeiKv0xhhX3n6LDxkGSMExsjipuaZvipjv6gI=;
        b=H3h4TqmLx9PW5L4u3K907ITQ3/MaeFseibP8BW62ucVchEu+eqtMF6WGLny4r+07a4
         w9f2EEvotTxR2QFHMHSI60acRTc+f1HRoswf8M6Hk/eizrXUIfTQKr7SAIFjfD9Qo1a0
         OWXFg36wiBCAhrCHM5zJhT1HUe1PPzZXbVk0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=brNSySgeiKv0xhhX3n6LDxkGSMExsjipuaZvipjv6gI=;
        b=knzBkEhkP8Y1fGwr/yM6wVG7b0ULiEyJI2ECyqAPk9Uk0MIYzTUYxXKMLmw77Agtac
         wszurFKurIBTsP5Y7LpeI9VekfAfiqn+dbDXTciXW0dB7GWPsUV0b/IOmf8vvrePtFtN
         q5/Ns2Ky1M23vQCMA6EAfh5UMzcOkEls+lLPxuDQ9oBSSGx4FYMhKRnPAxp8JyGm5Z1P
         ChFjnlslF9F2mFgWEQPpEZQxHlcPeLjbX818ENhICVr9R4FTVXwocpdXxG765m6I1NeZ
         aGW31vjXfbI7RqS42ouV9r+0oLzfiEiOPRo+tfuApvjBV6LfzNk3WEYDovZQwoIVjbgW
         qGbA==
X-Gm-Message-State: AGi0PuZP66CGF7Y1NsiGmJu7NheWyXiRB812wVT7eg8TH0BihtjeyN/U
        LmcFWjB+XCgjKwzBxawBhDNQAw==
X-Google-Smtp-Source: APiQypIR+i06XONT+D8ITa/IRdit2Sz40kgbj+FvORhekoMgieSKbRgQLejrYHBQYOUK1f8naFTkeQ==
X-Received: by 2002:a17:90b:4c8f:: with SMTP id my15mr2227495pjb.63.1586897774811;
        Tue, 14 Apr 2020 13:56:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x5sm6481354pfc.213.2020.04.14.13.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:56:14 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585809534-11244-3-git-send-email-sanm@codeaurora.org>
References: <1585809534-11244-1-git-send-email-sanm@codeaurora.org> <1585809534-11244-3-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v5 2/3] dt-bindings: phy: qcom,qmp: Add support for SC7180
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Tue, 14 Apr 2020 13:56:13 -0700
Message-ID: <158689777311.105027.10697729966586057172@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-04-01 23:38:53)
> Add compatible for SC7180 in QMP PHY bindings.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
