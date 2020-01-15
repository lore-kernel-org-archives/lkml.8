Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3FC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46FBF24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 03:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CnLgBEiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAODOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 22:14:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41288 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728961AbgAODOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 22:14:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so7757236pfw.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 19:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=O3jTDnmwru005Rmfwt1mrDaoL6O6mw5SG6rHGZeKVSY=;
        b=CnLgBEiDGZrSAAG3xSHFFUBWxQ8iCuMe1rvegmralFbRWQvEMK3aMlu4eLGm96eWrd
         GFvC+Suc4XwIYMBYZvKevz493ll0wBmoeeSqIwak3qjanRzH+T47QB2PlmoFlyRIMHF8
         sDXzapZJuU3CKCA5dPtSiek8bRU5lTthQaKDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=O3jTDnmwru005Rmfwt1mrDaoL6O6mw5SG6rHGZeKVSY=;
        b=C9LM36yP2Q2JTa+yrJjULdPoOpxPFV57xWswJ6vjGJ5NWEqZgwWoMQIXEEw3gWk0B9
         TVMTCaX1mVEAsebrVMbAo0gyA9tPrKPt7SLAl3fCeFPvWnAwsrK9Q8anjebdDgQFmyzl
         MnfbhHElYSI8EojvcOX5Ido6OQkKI43SS9fMJ+AuFvoBkQUwJcAgP79quF4dbFujYkGw
         RDL9WPPz3XnlT0mxHameX7V3KDjzbqGykubeKJoAXm1Kr+AU2DH29j+KIdwPB2LI751/
         vRcDX3SXbMr7jriaCaqrl9/GBP3qac3egBcpJiiRSTbnPIcKWIHeePwnkzpK/q17tcr9
         0U5g==
X-Gm-Message-State: APjAAAUOiRZ/GpVtOyQfS83Z6jgULW/t0SlPeiIFIC2umtBWo5lcd7AM
        hEADsvDlR+9Clmn+j6CKojSrcQ==
X-Google-Smtp-Source: APXvYqzVr+KpYU3PHgwnjSxEm/7uHjy8e95zrZ1QZ7pws0hBP/Tv7PrdWYaxZslZbmgStCQ2NSd2Ag==
X-Received: by 2002:aa7:8283:: with SMTP id s3mr28715427pfm.106.1579058077486;
        Tue, 14 Jan 2020 19:14:37 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id s26sm19589003pfe.166.2020.01.14.19.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 19:14:36 -0800 (PST)
Message-ID: <5e1e839c.1c69fb81.1ab3c.06dd@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200110101802.4491-1-saiprakash.ranjan@codeaurora.org>
References: <20200110101802.4491-1-saiprakash.ranjan@codeaurora.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        devicetree@vger.kernel.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add iommus property to QUP0 and QUP1
User-Agent: alot/0.8.1
Date:   Tue, 14 Jan 2020 19:14:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sai Prakash Ranjan (2020-01-10 02:18:02)
> Define iommus property for QUP0 and QUP1 with the proper SID
> and mask. Below SMMU global faults are seen without this during
> boot and when using i2c touchscreen.
>=20
> QUP0:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x0=
0000043, GFSYNR2 0x00000000
>=20
> QUP1:
> arm-smmu 15000000.iommu: Unexpected global fault, this could be serious
> arm-smmu 15000000.iommu: GFSR 0x00000002, GFSYNR0 0x00000002, GFSYNR1 0x0=
00004c3, GFSYNR2 0x00000000
>=20
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>

