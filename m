Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EF8C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53A2207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H8vbnYW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgH0GgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727957AbgH0GgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:36:04 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748BC061263
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:36:03 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id b18so4186927wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 23:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=akR5LsWB+L7ENwYAw9D4wcSK8jvQH6F09dbiIXvyFCk=;
        b=H8vbnYW/S+H7tZZYYO5Fs3PPBaCtYQdePiDEDqJOjsMv5DF6G2r7fYacs24CCUEaAt
         M3e1iWPRZPukneXLcYdSJGgvQQ826VwRp17Sv20+QJTNJvXWHfkZABR3zVA0DWOcTzdg
         WEgIW3cZElL+bglDngYnh1LuIaHi/EV/2I1iKVO3m3j4xIQwohTnASGkYv8BwxHFT6Tg
         htWl0SMTHiOOLoP79DFGPB7xALFkOssU25a1B7AThZesH2WFhTlnyAwyQG09UCxIlfQt
         dDsHe95PD32mdOGZohe5PKfcsO5FWScCiMzdkncTi71joxY8dybGZxXjcXIt1WNujlh7
         /dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=akR5LsWB+L7ENwYAw9D4wcSK8jvQH6F09dbiIXvyFCk=;
        b=EjTfjZpHv9+pY6azRrDJjyIzA6J+X1zhsKFV5gZ+O+XQ5p+JzTN4H9JIuTxPZGq0P9
         1+MAANLdAlHK0c6S5lA4GE4WncwePkQzdvXrLs76eDZhZyCKb1/KHS4bCI8IMX1vBXn8
         41Pt6iUzSQTWHil8OrM+5DpJtLG8zNdBFDUIs9F3M8+i7Mn3xrd1T9VpPQ/NsS/5gVe0
         cvDVBLO43Frwr7aS5Y7gwcKFxnRNlyWIvAqRrmI0VKFrvPpT77OasbA60hYefMajPJPb
         uxk9Z8Ff3h8h1Dh7b8Rsx4RQbJ1Au94uNHfMQEqwQevNRoHWH1NPRWMnCFpr0yuvbR+p
         YeBA==
X-Gm-Message-State: AOAM533lEwInYuUeoQd8TrYXA4fKGV+QevseLqu9HPukeRgWVexA+77s
        hMIkxTULMn1GB8E0d1mbihnqsw==
X-Google-Smtp-Source: ABdhPJyUoPKR71NVAZJhTV3U26Io2C1TwglVVoLwoSOZIX2rFDKJaRv5rbS/qFs4nDKGnwNHN81ydA==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr879463wrx.145.1598510162237;
        Wed, 26 Aug 2020 23:36:02 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id q11sm3530317wrw.61.2020.08.26.23.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 23:36:01 -0700 (PDT)
Date:   Thu, 27 Aug 2020 07:35:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Maya Erez <merez@codeaurora.org>, wil6210@qti.qualcomm.com
Subject: Re: [PATCH 12/30] wireless: ath: wil6210: wmi: Correct misnamed
 function parameter 'ptr_'
Message-ID: <20200827063559.GP3248864@dell>
References: <20200826093401.1458456-13-lee.jones@linaro.org>
 <20200826155625.A5A88C433A1@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200826155625.A5A88C433A1@smtp.codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Function parameter or member 'ptr_' not described in 'wmi_buffer_block'
> >  drivers/net/wireless/ath/wil6210/wmi.c:279: warning: Excess function parameter 'ptr' description in 'wmi_buffer_block'
> > 
> > Cc: Maya Erez <merez@codeaurora.org>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: wil6210@qti.qualcomm.com
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Failed to apply:
> 
> error: patch failed: drivers/net/wireless/ath/wil6210/wmi.c:266
> error: drivers/net/wireless/ath/wil6210/wmi.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Changes Requested.

Are you applying them in order?

It may be affected by:

 wireless: ath: wil6210: wmi: Fix formatting and demote non-conforming function headers

I'll also rebase onto the latest -next and resubmit.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
