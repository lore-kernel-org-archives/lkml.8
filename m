Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58FC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0974B20CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WlOhJe8W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBDAwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 19:52:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37797 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbgBDAwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 19:52:18 -0500
Received: by mail-pl1-f194.google.com with SMTP id c23so6535870plz.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 16:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:subject:cc:user-agent:date;
        bh=juH1D/JjwiXFZsR7wDUzqXKriQUzIaRkvnk6WpEYkW8=;
        b=WlOhJe8WG35ZWUHnMZxcRqm0DftkI4D2QIpdy6BXYpJT30L3p3i826iFF/TgGgajyw
         u+7kNoKYYw9sTecDF+AeBMnyD2G4vR0faATZYfdiP+8U8N4TVPs+1WtFGhMSOL2vqpzD
         6OZB8SkTXSSbPF2IuDRg3Vob8vF8HRj2X8qhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:subject:cc
         :user-agent:date;
        bh=juH1D/JjwiXFZsR7wDUzqXKriQUzIaRkvnk6WpEYkW8=;
        b=s5bomg0OQubeeZhJIIHFjCAS0eq5DkB1Ji2Z47z08Vu+Q9KpuAiQoJzMcK31Ea5V9X
         iJNyyNoAqTWrI65qA+VRhAHDos58GVTbD99/x6lpVil8vNMgDF+wSpK9UaH8nfosMp8x
         LcWhDi+gdM8BiLV7+Zhmldp0ymGIevMe4Ucw0CACcRWjqmtrihNP4EqGEUs+M/+IExzv
         oGpkhjilYv+8P4AJT9zUpcUOWoT6nCQlXXgx4ilAz/w+mlxYEHZmhTphFWmaK5e1Kr7I
         5Decg7XlS/1u2Vh2mgQ1OWl31+n4wyokgTrc/jw25O4gkgRgmXL054hFgELKtm12vrzc
         3Fpw==
X-Gm-Message-State: APjAAAWHU4ASAehYD8qZpf8NJbu8yXV93MspJ6mZoDcY7YjQJL1S8Idi
        WdzgVWCMnzxj+H6pTohh7cZzjA==
X-Google-Smtp-Source: APXvYqx0DysWV9esrDzkhiMpIHTmIfIqU1/9jj0L5WAp3alYyHpbkOnov8IzMg4CPqiAeouQyLsIKg==
X-Received: by 2002:a17:90a:a115:: with SMTP id s21mr2340735pjp.23.1580777538254;
        Mon, 03 Feb 2020 16:52:18 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b1sm22322166pfg.182.2020.02.03.16.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 16:52:17 -0800 (PST)
Message-ID: <5e38c041.1c69fb81.8c1f0.da56@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1580305919-30946-7-git-send-email-sanm@codeaurora.org>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org> <1580305919-30946-7-git-send-email-sanm@codeaurora.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: Re: [PATCH v4 6/8] arm64: dts: qcom: sc7180: Add generic QUSB2 V2 Phy compatible
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sandeep Maheswaram <sanm@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 16:52:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sandeep Maheswaram (2020-01-29 05:51:57)
> Use generic QUSB2 V2 Phy configuration for SC7180.
>=20
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

