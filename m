Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED459206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sJ/HsKUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgG0OCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgG0OCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:02:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8DDC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:02:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so7958622wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r8KV96F+gaN7TANhBIEFOAQenxbJ7bcYKYSXKhGSVNg=;
        b=sJ/HsKUqqaFCS03Ij0E600tDkDC82e15zw4TOeG7gMFN7K4SYrmGIK8TTh0eUJYxnI
         Yu+svzKOUeagUNSz/tl9QqXKbUEzvVedFmgyg5xYUDmMwhZXHn1iuCdPbZ24YSqwJtS1
         l90zGT7T30DG3HA6g/Iu7Xxyrum2W0IWm2snDn9/+V0uVFC6xOrVUo6GxLIO1ryostM+
         SeF6LqDxlJG1OBGv5mfgLnsvCQIv4wyEl3s6r6gdh/6OUOui7Uga4/FdqIwsoBVM1Bj9
         si/6nuUHSclaNfvL0gM4Mg7PaGLltQl7hZJ+38aP4tLGf/f+d47x7PDI+1jFNOq4awfm
         56rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r8KV96F+gaN7TANhBIEFOAQenxbJ7bcYKYSXKhGSVNg=;
        b=Icr4zzVfXEckTFU9P7yRcVsw8hyq8yNO42y7q8sdBSqmh3nMeBTkReMW+IRPcpqflO
         t1vUEz2jxthxayCniE1AbajSKAqO7GDQcc4eHWTWZ5i+vpn4uyhilnbpqNtXYAnNUIeQ
         s83FkI0dQihNa12qaleYdpVIftg5p13opXXwxRNCA+wRFxD3gQg8UIVf3dKp8cDD4ecT
         6ACVXmk1tPYlLAgBdYen5cKEt+Ujs9E3qohkuuKE2c9eDfFLyRWzXKB2i6kYMBcd+LWo
         5pqKawKqg1Ls1mGDxf7KWMXrwVBKtBKGa9XBBzFCpuZhGfXhRJoUg6XORpmyKc4+keVR
         nFnQ==
X-Gm-Message-State: AOAM533lsy/TF4/w10ELQuAVbru1pQRp8QwkvIHGPpksOekxJH+TPXlq
        bC7xpadffnj8727aVKkcT+OhgA==
X-Google-Smtp-Source: ABdhPJx7M8RG19PQ301yDXiubgR+OZs7Pk5oY2k0iBfh/zhIsarZqMrRoz4btbjEfa3WtbM5K0MaAA==
X-Received: by 2002:a7b:c941:: with SMTP id i1mr2944745wml.73.1595858534475;
        Mon, 27 Jul 2020 07:02:14 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id c136sm18698750wmd.10.2020.07.27.07.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:02:13 -0700 (PDT)
Date:   Mon, 27 Jul 2020 15:02:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [RESEND PATCH v3 1/2] mfd: mfd-core: Add mechanism for removal
 of a subset of children
Message-ID: <20200727140212.GS1850026@dell>
References: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200723105459.5530-1-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020, Charles Keepax wrote:

> Currently, the only way to remove MFD children is with a call to
> mfd_remove_devices, which will remove all the children. Under
> some circumstances it is useful to remove only a subset of the
> child devices. For example if some additional clean up is required
> between removal of certain child devices.
> 
> To accomplish this a level field is added to mfd_cell, the normal
> mfd_remove_devices is modified to not remove devices that are set
> to a higher level and a corresponding mfd_remove_devices_late
> function is added to remove those children.
> 
> See further discussion at:
> https://lore.kernel.org/lkml/20200616075834.GF2608702@dell/
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  drivers/mfd/mfd-core.c   | 16 +++++++++++++++-
>  include/linux/mfd/core.h |  5 +++++
>  2 files changed, 20 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
