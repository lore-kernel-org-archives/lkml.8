Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FE8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8491B246B5
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 23:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jR9hz1Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgB1Xm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:42:28 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36294 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgB1Xm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 18:42:27 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so5232368ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iId8/Patumvx4bfeqRK0XfOfMMBiyM4YKPgGmeoe3Ic=;
        b=jR9hz1HnsFYdmlGMnV8RJw+1wYnmwgmp5F4eYV/HQJq0IT8X9BmWqLirtywy1i2QP4
         PENcGt2urlSOb7+1q2awxksqIf8X5fPoDXtpW+LGhA4OHuAGV/S+OJrrdNiN25PDwSId
         oBmLzMgzt4wjcsLTuSyUutMgMmEgIhzVmQS2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iId8/Patumvx4bfeqRK0XfOfMMBiyM4YKPgGmeoe3Ic=;
        b=qUCyyXLNZ0bkByxHp26kVuyBOAYGCOC+pDqVR1mG0IK06P5SttlQhK1FZgSiPcJ2IB
         Ej7K2VJJl4gstaggNraKVlz+oC9Z8Nl+yBLnwDZtaLHSSjp1JXEH4aYpfxjq0GNHiUUz
         7+KiBSqaVWaolztX4gjCaRPt6O8hqausSglUX8h4pDHblXuMjwmgd0enFzgolXoFuCvw
         J7MO5KmNxPibnLWoiWxFZwYKcNIn5/MsDLGJXZuimjtuEWOp3rS37GwasugRTt7Wpa5j
         lYyGOgs4YKJP4yni5uSzke//CIZUuBqk91Brkc+IxJFjjP0FEYNyDGAwQ7EqYNmau2HV
         6YgA==
X-Gm-Message-State: ANhLgQ0t12r+rFTlpUzKruhLewTvMB5Acz+dytlqzX2x4q4l6ikEEgXi
        i/usLPjObFd/QCZYSMXjooOZhfVp99M=
X-Google-Smtp-Source: ADFU+vtyv7JMIdCaSm5crWnXGyGWgdc7l0QRaxHOqoqZp3hO7yLVBEVQeEdbsGRpJsmNKNdVNLwGaQ==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr4519912ljo.1.1582933345463;
        Fri, 28 Feb 2020 15:42:25 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id f4sm6614627ljo.79.2020.02.28.15.42.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 15:42:24 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id w27so3364776lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 15:42:23 -0800 (PST)
X-Received: by 2002:ac2:5226:: with SMTP id i6mr3661642lfl.99.1582933343335;
 Fri, 28 Feb 2020 15:42:23 -0800 (PST)
MIME-Version: 1.0
References: <1581316605-29202-1-git-send-email-sanm@codeaurora.org>
 <1581316605-29202-2-git-send-email-sanm@codeaurora.org> <158137029351.121156.8319119424832255457@swboyd.mtv.corp.google.com>
In-Reply-To: <158137029351.121156.8319119424832255457@swboyd.mtv.corp.google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 28 Feb 2020 15:41:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft47is6Td7dtM_FmP1g6TFv+yRYuz7yca015YXbRRDon5w@mail.gmail.com>
Message-ID: <CAE=gft47is6Td7dtM_FmP1g6TFv+yRYuz7yca015YXbRRDon5w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3 bindings
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandeep, are you going to spin this series?
-Evan
