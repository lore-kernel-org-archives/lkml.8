Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5F86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9165F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wpz9JxHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgGaSic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387890AbgGaSib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:38:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AC1C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:38:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so12501912plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=SNpK+3wWVxGTyist2fLUSgIvEfDZxw0Tclt5ni7TW34=;
        b=Wpz9JxHr67aJk9mP3sR63H5t7ksI0PpWbEtowXXceem2XblTkxAx8ias5Io1IBdyKN
         CjVfnyIxnhcqoGWGvljAocxdC415cvlFjbooBpvH6B0T3sy6m4BtCkJnTVub7/AFnfUP
         NbjjtPwPpjjOY31HqZpPNkFPDLKK5gOzbetc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=SNpK+3wWVxGTyist2fLUSgIvEfDZxw0Tclt5ni7TW34=;
        b=gI9iUYEOj20cG4fDr/X2/9uJn7+UL4e4mmanxn0LhuhF17h/PxakGW6huCWtaXllZY
         IkWOIFEvVTT6zmKJtL6JesyzY59oLeJZfXS4OnlD3H12bbtXgc91RGrUI2HvdN78S/Lu
         z1XHb/zSTwYxpNN800wIq1OtSo+sXOOTIouE6JNBgWByt7u1ylCyE6pyITDqn3z/dUdi
         eDDfEUARdH+WUpVSY4EJwcDpLwc/VL9kPEbg/yHBX0l4/RibJod8aFE/hGlnkIS71JBl
         GyO8y+SmEwZ9afFQvM3dzm6ihJKF0dVB9W4IXcep/UbXZfDM9QqEUCR0//HBLNc9h2yV
         3zxw==
X-Gm-Message-State: AOAM531ePcoVbUbmJwYBwBpb+Xnh1nlk2YE55Sgw11GP/ka0aQ9CEGXp
        RZKiIPyTBkYg+nhuCldzqJX9Lg==
X-Google-Smtp-Source: ABdhPJxWQH37ntc/c6bbP/1fWoO0uz6UdFlR3yqVZ7s1qSuwG9SpA1iRMLMBBX4cHatU4Pafdwg3tQ==
X-Received: by 2002:a17:90a:31ce:: with SMTP id j14mr5205373pjf.65.1596220710601;
        Fri, 31 Jul 2020 11:38:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id 137sm12324262pgg.72.2020.07.31.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:38:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200731104555.v3.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.7.Iecaa50e469918a385b3e5dab375e442540ea2ad4@changeid>
Subject: Re: [PATCH v3 07/15] iio: sx9310: Use long instead of int for channel bitmaps
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 31 Jul 2020 11:38:28 -0700
Message-ID: <159622070873.1360974.241649023719158449@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-31 09:48:44)
> Uses for_each_set_bit() macro to loop over channel bitmaps.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
