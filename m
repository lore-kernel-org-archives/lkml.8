Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C920C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB6120578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a94axufR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgCISHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:07:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37162 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgCISHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:07:15 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so5071282pgl.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uSDDm+szHmvIWUPLQNgJK88QQsyLobcm7m+erYi43MA=;
        b=a94axufRiybOs8QUmxdRJUFDKVHtyzYU52JehSFnSfSSbUCNc5D5hcmvKKJb2xycUk
         Qta3py6TaSaj+JanBvfoDP42W72bqzPNKHvi/KVbGDrBBnpjS+Mv5ofJXN3xRKGN3Caa
         vVbrhLTL5U5SG+YIGR5iDxV94lcQPjylD41S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uSDDm+szHmvIWUPLQNgJK88QQsyLobcm7m+erYi43MA=;
        b=iXgVXW7TMBYoRWcERNvDixAEMNIkCXTUYLka4fGxezYFifIKlWZZB7yrE7D0PCkVi1
         flXP68+LrhZFWVdP6VCxa4gzhSPpP2xpJoxAOGM6uTrd70PAVyDeb5wcudapyqfoKYXU
         Hltam6dbFxF4VapWJvryvAr0AlfNHM2CLuUTmnqd3Wd0jxYgxomwfb8hCc1VbEQsdIWB
         L5iMA+wfRevmEkCywnt2s/NrZPco6nkVBqrj+S1yf+c2Yidu+MlMiIMY07rI1Ck2Z1mn
         vUUj55Yr9JFXXFlaA9ztYwYZq3GfUyyml4fRl6/YiPxbj23hoHPopmzQPAgAP9SSWohM
         Tk/Q==
X-Gm-Message-State: ANhLgQ3WbpkOglifD5vDLC9txYQ3JaLeatS5D8g66myAwVZ7UpUi0mdI
        Tp8z5OkvLbgh0mg8pzPZVRUWuA==
X-Google-Smtp-Source: ADFU+vvY9aLEitVJtJPOO+vFStdZSayTG7guRMuMoXAdUXidcTnSY4YMWpIA6UahObJI62YYr+9DKQ==
X-Received: by 2002:a63:844a:: with SMTP id k71mr6844622pgd.79.1583777232712;
        Mon, 09 Mar 2020 11:07:12 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b70sm5500362pfb.6.2020.03.09.11.07.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 11:07:12 -0700 (PDT)
Date:   Mon, 9 Mar 2020 11:07:10 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-usb@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: usb: qcom,dwc3: Convert USB DWC3
 bindings
Message-ID: <20200309180710.GY24720@google.com>
References: <1581316605-29202-1-git-send-email-sanm@codeaurora.org>
 <1581316605-29202-2-git-send-email-sanm@codeaurora.org>
 <158137029351.121156.8319119424832255457@swboyd.mtv.corp.google.com>
 <CAE=gft47is6Td7dtM_FmP1g6TFv+yRYuz7yca015YXbRRDon5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAE=gft47is6Td7dtM_FmP1g6TFv+yRYuz7yca015YXbRRDon5w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 03:41:47PM -0800, Evan Green wrote:
> Sandeep, are you going to spin this series?

ping
