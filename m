Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3E5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348CB21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgU1vPmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBFNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:39:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37376 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFNj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:39:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so3154062pfn.4;
        Thu, 06 Feb 2020 05:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9UI/Wm4SvohT/fPhpu434OJUCJ1ebl8rShElAxdr7Lc=;
        b=GgU1vPmdodPKY+ehyRPENrKyOCijr6w3B7CVMnO5UhO5SRTKJ330PYioWCbnHAxDay
         OHNBV6qDTiXRCgGwz3Aj57US1ojxFahlJAAqPXzys2L2mBXoUQy+2Aw/SV9+0UbCwVkH
         8EhUiX+Q/S8WpSlLrdHiAATBKGuycWmt2BLsrcmqd+4ABx+rCm2zMakc20Ch1+rgv39n
         ct1riJvgPLzykTnoyxCuxpzJwKrbRk0Z8paSF2H46acgLN6zlVkXlLAPIbaeDi0mm1yP
         YS3qUpgs5JPPkQx+mJfMmlPJh7YNxP2I3bcYM3rEIJuffssPlBvbeRmj00rDD5W5z2S/
         9mbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9UI/Wm4SvohT/fPhpu434OJUCJ1ebl8rShElAxdr7Lc=;
        b=cUCjcO/sj0j2AwK56LEhT6qDhbBujSNzlaD/zV1ef1Xy/rrI+xRX4/ZgXT1ElchLYo
         0cvbpS3WcCdGCVEtnH0PXV1IzDhLtgyfSchjP+QRCJfClL1qsMIRwmawD6aoIAFNEVyd
         A+0aidW/K31UObgrO64sPeTD5M1xglSNoYnX+2Vx/JRjdxPVQ8vs+81f5qj5AB35Ebh3
         Uf1PFc2PUh+D0Jj+7CXa27Zdt6d7a6qT5Br7nj2gjnJOlaEmEJbx1LT9CPe0CPog6Qf9
         dtYix+HKNFeeUYItsh3uoQe6mVd0LZKXwpHDI/7FnyTXzUVRHRgYjVkBeTY6iFDowLXi
         8xBg==
X-Gm-Message-State: APjAAAXFo3F0wXNr+byiy2N8uWsTbXcEHohv7HrJH6qyN9W/uVe6gxnx
        ccCh/BrYdmg3K3VMISGOcSo=
X-Google-Smtp-Source: APXvYqyMN/S+UWZnFv6QS/f5sQ8QuvTBdWOZY3ai7rwzkIaw95R8Rd2Ks0E6KgzxLJM2qOGRQIdZfg==
X-Received: by 2002:a63:ed56:: with SMTP id m22mr3535003pgk.261.1580996396207;
        Thu, 06 Feb 2020 05:39:56 -0800 (PST)
Received: from localhost.localdomain ([2408:821a:3c17:470:65f2:3d88:4c94:b153])
        by smtp.gmail.com with ESMTPSA id y24sm3947432pge.72.2020.02.06.05.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:39:55 -0800 (PST)
From:   youling257 <youling257@gmail.com>
To:     alexandre.torgue@st.com
Cc:     kishon@ti.com, yoshihiro.shimoda.uh@renesas.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, youling257 <youling257@gmail.com>
Subject: Re: [PATCH] phy: core: Add consumer device link support
Date:   Thu,  6 Feb 2020 21:39:18 +0800
Message-Id: <20200206133918.15012-1-youling257@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20191104143713.11137-1-alexandre.torgue@st.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cause "dwc3 dwc3.3.auto: failed to create device link to dwc3.3.auto.ulpi" problem.
https://bugzilla.kernel.org/show_bug.cgi?id=206435
