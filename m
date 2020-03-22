Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1490C43332
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83A3206F8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 07:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m96WaUkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgCVHx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 03:53:58 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:45540 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCVHx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 03:53:57 -0400
Received: by mail-vs1-f51.google.com with SMTP id x82so6678459vsc.12;
        Sun, 22 Mar 2020 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGOXhbNE/Yvzyog9sFZHGWWLHVko+x/bs3AqHRI4q8Q=;
        b=m96WaUkt7JedMDG4ISXzSttGGPakucXaGSVr/CYifkOtp1fXoh6INQyccXIcIHwWkN
         kwHQcCsQV7Q+TSHtHrK9ld/SyfRZdtQr2Qvt2j/UaZaGXv7K4RQVCBIgDPD5ezAbmyAL
         Udey756fd1cdVbIMrkT1TXC9TGTUfAUw/vd9wbBgnbb5MGMYpLuChPZecSi3XaxgXPaJ
         bwt7GDbEo/DCfm5GoDyEIu6S9SaXgR9Uj3M1mI9VymysO2XUPC/cVRblxr50e5NAnCHx
         jWTUaXxpGIQdTvWM00hvprFzLv19IlFZNmTcAHhFfui3ZXW+K0fWS8QxgwBZ2sZdpHSf
         HnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGOXhbNE/Yvzyog9sFZHGWWLHVko+x/bs3AqHRI4q8Q=;
        b=CprABLM6GQ9ynrYqjEYe/oAgHhCcqg4lbrwOQwCjq4EmgZN2d1NRtaaz54WaRC1QAw
         IoLI3dqLxXctV650hiDZqlab9oTxcMaAlfifxITQtygYZx/6ymipJbtrNb3davP9hGEM
         uXOZnNIQya+ThdTTzM4bu6vxTMZCL9I7xTz8RBFP/H0vcmSJzx3SnrBQrNzHl9LG7hOh
         4yK+37EZ7NvTE5zso/4gSxUlg3deih21UVrXCcMwPp8Me7SyrHn6b1JYFAyGAM4hrf/f
         Mtwo9ryx5Br6LlfdvJeD9I2coPj7HejecUairN78u9w5MxnA1bbEpjwBqQVHyh7UEKI0
         L8Ig==
X-Gm-Message-State: ANhLgQ1k46lJojdgp2ayxWJmYEy9zsncwM5kW+TNYKjMYsH6c7V5ulgZ
        9MfunUN7+eOqou1x+tL5qeiTg1NZgp0tJk1F5h8=
X-Google-Smtp-Source: ADFU+vtEaTWfmqFJuCBiwee7to6ZSYgE6Hq6H5nMKMxws5DkFoNazDU8YjIGQOGlm3hDkX3bRwxL9pdx9gcfqgOYvJQ=
X-Received: by 2002:a67:3201:: with SMTP id y1mr12112175vsy.54.1584863635053;
 Sun, 22 Mar 2020 00:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000001a033405a15e3acb@google.com>
In-Reply-To: <0000000000001a033405a15e3acb@google.com>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Sun, 22 Mar 2020 15:53:44 +0800
Message-ID: <CADG63jBdvJMAem7_VF3GbCUSXGRuFrrv6_GqFc=KcKkxcNebCA@mail.gmail.com>
Subject: Re: WARNING in hwahc_probe
To:     syzbot <syzbot+df767d588771697b0433@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tranmanphong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of snprintf is longer than expected if the string is
truncated. Bytes need to be checked here.

diff --git a/drivers/staging/wusbcore/host/hwa-hc.c
b/drivers/staging/wusbcore/host/hwa-hc.c
index 8d959e9..1475a48 100644
--- a/drivers/staging/wusbcore/host/hwa-hc.c
+++ b/drivers/staging/wusbcore/host/hwa-hc.c
@@ -680,10 +680,12 @@ static int hwahc_security_create(struct hwahc *hwahc)
                        break;
                }
                itr += etd->bLength;
-               bytes += snprintf(buf + bytes, sizeof(buf) - bytes,
-                                 "%s (0x%02x) ",
-                                 wusb_et_name(etd->bEncryptionType),
-                                 etd->bEncryptionValue);
+
+               if (sizeof(buf) > bytes)
+                       bytes += snprintf(buf + bytes, sizeof(buf) - bytes,
+                                       "%s (0x%02x) ",
+                                       wusb_et_name(etd->bEncryptionType),
+                                       etd->bEncryptionValue);
                wusbhc->ccm1_etd = etd;
        }
        dev_info(dev, "supported encryption types: %s\n", buf);
