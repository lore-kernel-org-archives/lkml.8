Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D822320715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCsC0FUe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgGFK7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFK7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:59:11 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09455C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:59:11 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so38750108wmj.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fQF2K2teurmA8SbRcE6hTYSi0CXQhtS1Usin6Ky7WEQ=;
        b=hCsC0FUeFaslKD2yQ7lrjaeD00hyD6LiBBcK2x+E6OUHWNvgWYX0/iZf/R5Dq2JGQf
         7uKw2jf2+Z6DahWk4tfjWhk+OiaMW/IOhL00kOb1KAKzKfRUbgEgUx/NKic9yu3EbH9w
         5Y+aSWpW468uTvwR3G6snhSm7cB2LGc7pwqKKSPbh44r3Ybb1nKD2DA9GrVkeygFQYEK
         2VKuHhV/XHiPauykEeG4WyslLwF5bc4qtu8dHneuLo9ijGraS5CUPL536UPT5+dxvpJY
         PTzQ7Yf5MAYTNO5x0etyDgg02PoYThMXsepx86Xqshqxe2uzw4XaKKMQ37cv9pKXB7Rx
         Oodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fQF2K2teurmA8SbRcE6hTYSi0CXQhtS1Usin6Ky7WEQ=;
        b=nN+4k/b22WM6OeHYHoz26qfxc1Q7BDDMdHMSfgtgrpGxPTWv7KLfzX43PLiygVNgCd
         0dOKOVfyn54/a/r+vEe5LbpfXCczR3xbV2nEDpjVAldve68/oS0Rl/a8/4NYPIj4PGnY
         0MdA6NzazIKvoDO1+0JpmY3MY+TxPUnJ2RWq859vVfzinnue3SK9igyP/I3/JXps0H0r
         AQ0BzxJRndtFjrlK7yJAE8b3k0vZhNQAmZ6T8+GPQ3kI4zknGzVhCTF4R/h0k6p6m1MU
         8OeqcawJQXXIimT8N3Jns9rpylYquuyZOUWGtCcfBJOVrlwp3ww14Jcvx4iuKexB6d7l
         z4fA==
X-Gm-Message-State: AOAM532AEwXArgb3SeP55chf++g6FUpNuxi2x0sTeIWj18jSBXPqbT43
        jPXDyo0FGk82nqjEck29ZNVO0nOS5kc=
X-Google-Smtp-Source: ABdhPJzTe1bd98Bjozi18nMGx1DUyFPP49dw01Cqq5Px0nAFse2fllVNpkJ2xXL7KNp4fVAoWmtvWQ==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr48176380wma.88.1594033149547;
        Mon, 06 Jul 2020 03:59:09 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id x124sm18834556wmx.16.2020.07.06.03.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:59:09 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:59:07 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 5/6] vt/vt: Add URXVT mouse reporting protocol
Message-ID: <0b10a4b0c1bf127560769ec460a6432977ccb3d7.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URXVT protocol easy, all data analog to the old X10.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 drivers/tty/vt/vt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 766983a848bb..5861e4c85c84 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1859,6 +1859,9 @@ void mouse_report(struct tty_struct *tty, int butt, int mrx, int mry)
 		len = sprintf(buf, "\033[<%d;%d;%d%c", butt,
 				mrx + 1, mry + 1, rel ? 'm' : 'M');
 		break;
+	case VC_PMOUSE_URXVT:
+		len = sprintf(buf, "\033[%d;%d;%dM", butt + 32, mrx + 1, mry + 1);
+		break;
 	default:
 		len = sprintf(buf, "\033[M%c%c%c", (char)(' ' + butt),
 				(char)('!' + mrx), (char)('!' + mry));
-- 
2.27.0

