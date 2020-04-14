Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCB5C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B252076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dw8jLdsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633182AbgDNUcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633160AbgDNUbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:31:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1F8C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:31:43 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u65so472186pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=KvEg77doNLDzNxGfMI9Rhj8uKkWfoxdVPh7FOq7KA9M=;
        b=dw8jLdsbWZ6CDS0pB0qnJU6MRd4mZxnk1zNvrKzhqaB11JoxWnZpGsRSVr2kJPPScC
         arQcdoCVyvvxJxWV0uoessbrRiJfQzkEooIeCiKz8iRFD2IDarymsBzgPX+GZLQde0KB
         y6Rr/DECD+Nav1GKv2jK6kvc+gdVYf+2txjHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=KvEg77doNLDzNxGfMI9Rhj8uKkWfoxdVPh7FOq7KA9M=;
        b=ZfQl9tiZ7a2lNDa0Soxeuhe6lwhHcMQglRQpolm7fQfm87bKqjt0BvYC8rJlrHAvlt
         Onx6rDw5hcTBDeZwJg9AhklkKsNjK1sDrGw/hxmWp6dd4PItJaLLZcDa1Ktcbf/r/LM1
         8T2aXtqyLFBm4667wymD4R0h4OSM7CKGILRxE8Tj9KpH8d2vYrI/mMv74ya4+vRHm1Qz
         ZjzcT7sSxaWtN3LQaImP01v2LhzyyfkoWDaExItpC7O9pIruGTYEdAbOAueSchb28gst
         exrJh2Afo4jy2BiVrZcQhsmNT8z+fAGW4LIb3cUE++7LJ4EHK6vy1IzhNuAAPHTQi19i
         pfNQ==
X-Gm-Message-State: AGi0PubQ4gwKFyR2Fn6TflKKrfS4N9WyNFNwbdAWNQzfDqXTZ6mtqtbq
        6I2NyhMUgVcGSUuxwve4dLuNfg==
X-Google-Smtp-Source: APiQypINr7mOtduZ95fKBHP8P8/xhtFbUcbxNm92yMg8RWHL43ZBo6qn6/7qsqN6lHTlsu3cTO+mmg==
X-Received: by 2002:aa7:9471:: with SMTP id t17mr24339663pfq.272.1586896302796;
        Tue, 14 Apr 2020 13:31:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t126sm10887477pfb.29.2020.04.14.13.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:31:42 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585718145-29537-4-git-send-email-sanm@codeaurora.org>
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org> <1585718145-29537-4-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: sdm845: Add interconnect properties for USB
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Date:   Tue, 14 Apr 2020 13:31:41 -0700
Message-ID: <158689630151.105027.14207551281305119256@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-03-31 22:15:44)
> Populate USB DT nodes with interconnect properties.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
