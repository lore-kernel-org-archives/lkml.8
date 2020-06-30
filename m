Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C20C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9A842081A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C5ddrq+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgF3XqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgF3Xpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:45:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFEDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:45:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so9874282pje.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 16:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z9hrflkjZ1SE3c/jCUth43iNN1iz+IaXdB4/4fx+a/U=;
        b=C5ddrq+a30EL/pmhVV17A12x7EVAGhtOhZ2a4Y2VUNFSdKNwcDwRUq4blrozmAgG0Q
         /kB2O63nZtN5a+rfpz1POtIlCmC2KfAVFtbuMJlsLnWdUxdE9u8ZEr15gb34cuvTGZqJ
         nb320LlvaOFDByGglISvO9JtSp8F4uKDOe2U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9hrflkjZ1SE3c/jCUth43iNN1iz+IaXdB4/4fx+a/U=;
        b=VzhkSusPY0qregwpU3vwr/0R1CDXkQq0wOtg0LxizlkmBNp/rC5/v3/UhmTL6+Xucq
         4ZRrbp1bGKN/zNunvxmT4qb6b024li+ByfYKn3xOuTQg8c0eudbJACLSE5gZqqm6zlW4
         aNzOcE+f1wk5SKON3Dor+9doV3vroS01nyjdPH2fF00BL52f3u225Y5OOtNQDk/QHHX5
         nVB33sV6mvWGLoSLHV/lLtei2YqHooCPzHX1JY70uCGHLpv0bzlDT5Ua7AQsWExKTd5Z
         +wYWgdjY8PjF7wYCQaIupHPazS0+CFNCyk4AmInSxAFFTPwf1NbCw3cu9sj8T0nKw5Hm
         lzTQ==
X-Gm-Message-State: AOAM532AgTQqWZoGqOAr0YJWwOJVfOwZ2g+++NyiVXGuG2At8/pjgwFQ
        e5eajvXagk75KEZG6SEWP6X37A==
X-Google-Smtp-Source: ABdhPJz/cQKDQr9LzDIzVxWX8iD6uKjC55b5Arumpo/AtSDFDspksBkcdE2KuF44RiswvvNC5AvUQQ==
X-Received: by 2002:a17:90b:a56:: with SMTP id gw22mr14665075pjb.52.1593560748813;
        Tue, 30 Jun 2020 16:45:48 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id o186sm3721391pgo.65.2020.06.30.16.45.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2020 16:45:48 -0700 (PDT)
Date:   Tue, 30 Jun 2020 16:45:47 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] arm64: dts: sc7180: Add sdhc opps and power-domains
Message-ID: <20200630234547.GL39073@google.com>
References: <1593506712-24557-1-git-send-email-rnayak@codeaurora.org>
 <1593506712-24557-5-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593506712-24557-5-git-send-email-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:15:12PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the sdhc device on sc7180.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
