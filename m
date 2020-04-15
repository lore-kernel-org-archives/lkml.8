Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24718C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F408720732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JKgYDj3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634313AbgDOTd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2411907AbgDOTdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:33:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D8C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:33:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a32so276304pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:to:date:message-id:user-agent;
        bh=DhwjFm7NO3lz1+xSJxAVKegOT+4cvg/+tKLXup9pu8M=;
        b=JKgYDj3WnLm+i4KmF9cDrLbRzosg5ADIuIHwrxYrWTY6uyO3OXbBu62c3g6lMSDH/U
         rqb3PfYkTY/ItPGP391y30npnhYiKm5O73DiJ7aqpbMIVUT9xdzvK/cFzvf3p2BKQiVk
         jBtrWWfOOI3WXd9BWspvi3RgIm2SaOqHw7Gz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:to:date:message-id:user-agent;
        bh=DhwjFm7NO3lz1+xSJxAVKegOT+4cvg/+tKLXup9pu8M=;
        b=WsPbx54mr2YzYBlstPFr3GOJeiVzdlOzdW4kMQbVI3eDuwiVHxCxwxjXLego21VXo3
         WLMRvYKbiDyrCELsxcVRzhzL3u6Qh9sWQqrDnu1DqEn78tZt9Dv8iWX8+9lpbGULV6Bx
         wDFcvBjImCgUV+Oloc/Ryg3SACflERGFJxVpQfinUeFeQu90qMMOYvBYfM6k21Cl8r0z
         L6VGSAnX+zS53jlkpS1j79KrWFuYGE0TS84Bq6MkBPxkedTmRgDuU07/mARt9BM2ZYef
         jzw5B1Mtt8sUB5y2suvc0DFEOtTaPIWjZaE+NkyyCedQs1+ZcTNXK1YRr+tFLvX+3LKB
         EyXw==
X-Gm-Message-State: AGi0PubnXtfkO7P/gwpJv0++8cwHATmfx8OdzUbMV7mLtlfwIeOWPFhZ
        XsydFnNrAMBpeNrBUlzUPffxO289ayc=
X-Google-Smtp-Source: APiQypLF9I1HGpqBY5XoRsgbjZngLXUL4G8bMPpAW97Xf9cwgyxResxh8RcnSlTgxVSFyiABXXuyKg==
X-Received: by 2002:a17:902:8d89:: with SMTP id v9mr6512515plo.83.1586979225103;
        Wed, 15 Apr 2020 12:33:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id t12sm9098856pgm.37.2020.04.15.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 12:33:44 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1cdc4409-2113-cfe5-7eb2-6b1a6671e262@infradead.org>
References: <1cdc4409-2113-cfe5-7eb2-6b1a6671e262@infradead.org>
Subject: Re: uvcvideo: shift exponent -7 is negative
From:   Stephen Boyd <swboyd@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-media <linux-media@vger.kernel.org>,
        linux-uvc-devel@lists.sourceforge.net,
        Fritz Koenig <frkoenig@google.com>
Date:   Wed, 15 Apr 2020 12:33:43 -0700
Message-ID: <158697922381.105027.9312351935387255622@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2020-03-29 15:43:28)
> This is kernel version 5.6-rc6.
>=20
> UBSAN detected a bad shift value:
>=20
> [  511.693411] UBSAN: Undefined behaviour in ../drivers/media/usb/uvc/uvc=
_ctrl.c:781:13
> [  511.694043] shift exponent -7 is negative

I saw a similar problem. This patch fixed it for me but I'm not sure if
it's correct. The negative shift is done on the mask but we're going to
break out of the loop in that case so it isn't going to be used. Maybe
the loop should be a do while instead and then the mask can be
calculated at the start?

---8<----
diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_c=
trl.c
index e399b9fad757..ea6eb68329f3 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -778,7 +778,8 @@ static s32 uvc_get_le_value(struct uvc_control_mapping =
*mapping,
 		value |=3D offset > 0 ? (byte >> offset) : (byte << (-offset));
 		bits -=3D 8 - (offset > 0 ? offset : 0);
 		offset -=3D 8;
-		mask =3D (1 << bits) - 1;
+		if (bits > 0)
+			mask =3D (1 << bits) - 1;
 	}
=20
 	/* Sign-extend the value if needed. */
