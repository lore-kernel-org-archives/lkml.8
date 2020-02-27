Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32F5C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DFE24695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G4apIYCJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbgB0SoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:44:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35238 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgB0SoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:44:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id 145so417350qkl.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qzBo3P132jiUrbgs3PbRa9YhmehrjD7gSw2/B87JkWQ=;
        b=G4apIYCJ06kCdOWAiN9AqLr5Kqk+JwVRWTpigT0qp66Yk3DnhE/aEQJtj7nZJngk/B
         ShOmBai7Yd5rRsFUucLz1kJAzy+TYyDcIYX1p8J3J+gdpEdiMvoslaugFnQpH6HczYV1
         XZa0etCvY+6PzJ77I0Y5LNDRoiuByoWM6sZHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qzBo3P132jiUrbgs3PbRa9YhmehrjD7gSw2/B87JkWQ=;
        b=rzQiObNcz6QhB9SRWITl8AWSj6I+q/oEjgwiiAB0/2FpkaDn8UGsnFP4mlLwsKQt9a
         YRnfKPo1dW/TN9qqYeg87yi79UvmwsjSDWTbs5tHJyyUizFo6KSmmwvuF2bKvVve4Xqy
         k93RIuF+N68E06P4C9BpEr0Bbzp2jQ8dVrFuRRiwNVdV0lFZCqQdaKq9aWnfgArZQQz+
         cmHq41hR62owRBSxPmbmzj7ycGG/rQREBQqIw6RDz/I106VbP2BYHIf0oHekesmjdE4p
         s3bZqVUVuDRgFrvusRbbnf2PAqLp3lvE2LAF4qttb6rdgmMHXsdp+cee22my/VqGqoY7
         SKVg==
X-Gm-Message-State: APjAAAX97By/KE3tO8r3Irt3fVsvrViy8maIT3XBN/mNeOEgmNEY0mcW
        BQWPNTkaRLlR+GRJvNne2utYBZ+sBf2GVg==
X-Google-Smtp-Source: APXvYqx5vuSHSGirEr5t7M2ITb6qrulHybXQRsGA+qNc1oo7zpNJz0BOsecREGgHEZi/E/tMt3MVVg==
X-Received: by 2002:a05:620a:1326:: with SMTP id p6mr802574qkj.50.1582829057771;
        Thu, 27 Feb 2020 10:44:17 -0800 (PST)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id 89sm3568673qth.3.2020.02.27.10.44.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 10:44:16 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id z12so347610qkg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:44:16 -0800 (PST)
X-Received: by 2002:ae9:f301:: with SMTP id p1mr716972qkg.422.1582829055732;
 Thu, 27 Feb 2020 10:44:15 -0800 (PST)
MIME-Version: 1.0
References: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
In-Reply-To: <1582766000-23023-1-git-send-email-johnny.chuang.emc@gmail.com>
From:   Harry Cutts <hcutts@chromium.org>
Date:   Thu, 27 Feb 2020 10:44:04 -0800
X-Gmail-Original-Message-ID: <CA+jURcsvxP4gVBkt_sfCOfQ3+g2G+ZznUi4Zy2ydUSpPT3XWbA@mail.gmail.com>
Message-ID: <CA+jURcsvxP4gVBkt_sfCOfQ3+g2G+ZznUi4Zy2ydUSpPT3XWbA@mail.gmail.com>
Subject: Re: [PATCH] Input: elants_i2c - Report resolution information for
 touch major
To:     Johnny Chuang <johnny.chuang.emc@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>,
        Johnny Chuang <johnny.chuang@emc.com.tw>,
        Jennifer Tsai <jennifer.tsai@emc.com.tw>,
        James Chen <james.chen@emc.com.tw>,
        Paul Liang <paul.liang@emc.com.tw>,
        Jeff Chuang <jeff.chuang@emc.com.tw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 at 17:13, Johnny Chuang <johnny.chuang.emc@gmail.com> wrote:
>
> From: Johnny Chuang <johnny.chuang@emc.com.tw>
>
> This patch supports reporting resolution for ABS_MT_TOUCH_MAJOR event.
> This information is needed in showing pressure/width radius.
>
> Signed-off-by: Johnny Chuang <johnny.chuang@emc.com.tw>
> ---
>  drivers/input/touchscreen/elants_i2c.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Harry Cutts <hcutts@chromium.org>

Harry Cutts
Chrome OS Touch/Input team
