Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD53FC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F14206F2
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 01:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eclFyjgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgC2BO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 21:14:29 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41453 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727491AbgC2BO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 21:14:29 -0400
Received: by mail-ot1-f48.google.com with SMTP id f52so14148668otf.8;
        Sat, 28 Mar 2020 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QO4jy+klBUwzUYl7hy/fcRwlFawrR1Dtlwk3BYQW9wo=;
        b=eclFyjgKOcVpVuRI7HI5c9NmBqPLMbuH4Ei8YR1Y79KCMKlNif30rNRSLJqSVHBZ0P
         uS0073efuZAO+zSuU2CtIBY2OR3D3kIckDFjCMeSQKXE9d7s1da12LSkXGipgvq+tm/s
         cZCZ9AKc4Z0USNSYmXLwY/JJXzIekhdYv6b3vZcjtAK5XOgL1G79/HwHNcOjjS3k/tQn
         FOEXXk8PxkK23OYtDdBby4ecDqgu+PknB54gvhFwv5uyxWnNR5lD0N44/uElCxvoBw6m
         KffpDlHSgleMOJyQUNJdL5a/0bsa2+/Dx/RaV0IwBG5dLZmyFno3yRBFqpG1K1vraVkm
         ayPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QO4jy+klBUwzUYl7hy/fcRwlFawrR1Dtlwk3BYQW9wo=;
        b=sUm1gDSR/IQD3t6bBBzMIr56hTNSLk0HTUQb1TiZTTPxIzqJtVm6HgsJGNsmO2o9ci
         qFwv0MeLK922wumBH2gfmO643f3H4nN9Ylz8h7PkW0UVjee1K5PBWsgXho24gJkCeqxB
         OTWIWG/7v/GLc/byITE82GpUBWvFMf24SSDSIL7cwfYnD/iZoAlqyEmlszjYY8EUyjww
         aLpK7vHi3kjt2t8bIKwcyD0QzWWQmBmyUYEIQFI5Zh+BDoL2tCMKfuJ1Rm0kA5liu146
         IU+GBIqcM2MW46CsdoyOhkHfNw6dJ5u46rpB+QYapGr5z4qk49nGpX1OXifjKe02b5Xo
         wzaw==
X-Gm-Message-State: ANhLgQ2fi8R25SQfCQQyS8osfE0S+OOogPhI4xMXUS5rZmwZpD6Riabg
        dfDXUv8iD9A4o8yv9V4g3II=
X-Google-Smtp-Source: ADFU+vvcI6yhEMgB9LsQJf26l2QA61BuBf0tSFdclFk7UKQxyvtXZ24HT0FOj5KRoLajMHNDQWbS0A==
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr4454889otl.8.1585444468074;
        Sat, 28 Mar 2020 18:14:28 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l188sm3150905oib.44.2020.03.28.18.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 18:14:27 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH RESEND] usb: gadget: udc: bdc: Remove unnecessary NULL checks in bdc_req_complete
Date:   Sat, 28 Mar 2020 18:12:46 -0700
Message-Id: <20200329011246.27599-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <87zhc0j2qi.fsf@kernel.org>
References: <87zhc0j2qi.fsf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang + -Wtautological-pointer-compare:

drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
address of 'req->queue' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                             ~~~~~^~~~~    ~~~~
drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
address of 'req->usb_req' equal to a null pointer is always false
[-Wtautological-pointer-compare]
        if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
                                                    ~~~~~^~~~~~~    ~~~~
2 warnings generated.

As it notes, these statements will always evaluate to false so remove
them.

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 device controller IP BDC")
Link: https://github.com/ClangBuiltLinux/linux/issues/749
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index a4d9b5e1e50e..d49c6dc1082d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -540,7 +540,7 @@ static void bdc_req_complete(struct bdc_ep *ep, struct bdc_req *req,
 {
 	struct bdc *bdc = ep->bdc;
 
-	if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
+	if (req == NULL)
 		return;
 
 	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);
-- 
2.26.0

