Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7350DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466512076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QiJ9ArI4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633194AbgDNUc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633183AbgDNUcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:32:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB2CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:32:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k18so375725pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=RoKpcxr6K9VGzAmsqGBuph/1FoGQ9qjjJ0YxDqJJHHg=;
        b=QiJ9ArI4RGUZhtyAjahBG207F3DQ0dZvDNZYdWFyHhMRRRSlzyFzC4sGGOg/4ROOBT
         Xy2fb6wp6NXZaEWLhn5Se6/JkcAwSQHiPsbE2laZg4hG5k9JNR5qDpZhNpdGdanByfFJ
         77diWG+Xdzc7JkfsQfJq2MY9esr8dS5CXo9Ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=RoKpcxr6K9VGzAmsqGBuph/1FoGQ9qjjJ0YxDqJJHHg=;
        b=bA5AQJq6o508nCcFTPCOYElqa197Bvzo0qL9KZlnH2K8Abkc1CdZJKawRMqUhDUkbE
         8Z6gXQ14HLrwuRRMra+KLJfrI+h2PJ79gC22s/jPMbkUT/n4/saaW+M26abMP1E/k2BW
         BQ3OomT2CIOEKvpABaDugLP5ipnQwc0Lq1LDttNFIaMO50emtpaV7fGnsQjCvbe+SvBb
         hbpox7yAavB6JPrL32lt5mnTAwB/PlBhOwtKEbLW/paozdKcHIGaXg/wNKEVwWXCrjPp
         BybRcHuhOrYdycd0VD+GIQHTBiVLsT/Bx3q/t9qDoFLW6o/k+WkLtfPuUsfGHkeiiQjz
         W3ag==
X-Gm-Message-State: AGi0PubSltWnyiujOfBFidblScVCs5xGx6KT9B6SY4B0WygwMSqRKbJg
        H7sUmQJrKTVKvCKpG7LXHhgj7A==
X-Google-Smtp-Source: APiQypJmomzVcaErIMWufXBh4DLq/VWKaXXky2Q+jgmXEF61n7QDVFPgCA0LLJzRIGPeVmppodfzCA==
X-Received: by 2002:a17:902:8305:: with SMTP id bd5mr1602962plb.114.1586896327676;
        Tue, 14 Apr 2020 13:32:07 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i124sm11791303pfg.14.2020.04.14.13.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:32:07 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1585718145-29537-5-git-send-email-sanm@codeaurora.org>
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org> <1585718145-29537-5-git-send-email-sanm@codeaurora.org>
Subject: Re: [PATCH v7 4/4] arm64: dts: qcom: sc7180: Add interconnect properties for USB
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
Date:   Tue, 14 Apr 2020 13:32:06 -0700
Message-ID: <158689632638.105027.4250669142733413538@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-03-31 22:15:45)
> Populate USB DT nodes with interconnect properties.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
