Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E897CC54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4ED20724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YKxyAk3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYCh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:37:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37345 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbgCYCh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:37:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id a32so428535pga.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 19:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=VRnQilnt07d1oqQ4KQil6Mz63llajYTl97NmNGSglPo=;
        b=YKxyAk3ZQU7yENdjEqMIxZP3xJ5UXORg5Wf994rlklKQNuw65fwL2GtrHKEuOOgQXY
         SByDSi7BXw5nEX22nOtxCwYolWNrZ5/RKwfx7pDywcRUfqxqKfQvMdw+iCUaW+DqXrtU
         WBff/Ecpq8xlXKaDdC+WJaNl9cT7o1158Rv7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=VRnQilnt07d1oqQ4KQil6Mz63llajYTl97NmNGSglPo=;
        b=I3nDN8BJnddbhA5l41ZDgIztBG1LqcVJB/87hPpA29jcJ9rM2gmEQY5f8ss1KEQrEs
         7QfDcUh4uulDt/Olt/byy2HfkuCuRHWsQxRxQj+X9DYQZLnoiv1RHdVHVhdnEh5Fp9GO
         9+VEXt3yASwveWF3CI3ucjIy2qRU7AIE5saDWp2dF68HBTOlQ0GSm7RX4zHK1/2WDeLC
         mmKTzLyaFu2LTdy+GhZxdu8oVjwO4AJmNCf/Fa/w8V/Z5iEbOWA3NwULBGq5Ibjkq62r
         Afd7pbNKNcWZUlbLdye276gCaFgx0lD8jrnHfnFv17+Am0RFkHYn2zDeZMmvUOmXnw5m
         Qtqw==
X-Gm-Message-State: ANhLgQ3E3tHPcQqa2SJ2Tkopt4t9uaTJfneFgCe/ODYvigLoFZnh7QYE
        qebuJ2AgQTOHpEyAscL8VSYH4A==
X-Google-Smtp-Source: ADFU+vseJ+fw2H4J2gLn7jXALCAM+os616BkOMYNzL7Tq2/7qkx6ZJNgGF+lIAIFjgr8xWMqoG2MaA==
X-Received: by 2002:a63:1d7:: with SMTP id 206mr727458pgb.99.1585103873356;
        Tue, 24 Mar 2020 19:37:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id e14sm16965737pfn.196.2020.03.24.19.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 19:37:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <66b8da28bbf0af6d8bd23953936e7feb6a7ed0c2.1584966325.git.mchehab+huawei@kernel.org>
References: <66b8da28bbf0af6d8bd23953936e7feb6a7ed0c2.1584966325.git.mchehab+huawei@kernel.org>
Subject: Re: [PATCH 1/2] docs: dt: qcom,dwc3.txt: fix cross-reference for a converted file
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date:   Tue, 24 Mar 2020 19:37:51 -0700
Message-ID: <158510387182.125146.16270632251829962912@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mauro Carvalho Chehab (2020-03-23 05:25:27)
> The qcom-qusb2-phy.txt file was converted and renamed to yaml.
> Update cross-reference accordingly.
>=20
> Fixes: 8ce65d8d38df ("dt-bindings: phy: qcom,qusb2: Convert QUSB2 phy bin=
dings to yaml")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
