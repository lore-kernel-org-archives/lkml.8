Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAECFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770D820767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpehY4BD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgFVDKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbgFVDKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:10:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BCC061794;
        Sun, 21 Jun 2020 20:10:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so2690950wru.6;
        Sun, 21 Jun 2020 20:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SCGEaLUtYBhXEn7JNjmN2oWTQgcbt6iL1vLrS5rVTKc=;
        b=fpehY4BDBzyf02wswu9An2joG4VflAvdVkIZvDXziYMfCUg6u/2ig2oAg6qNqlWfJR
         osfb0rxEleAxSmKDU++T/0X4Yi91EftpSx2u1K7488F6p2398VBUEOZEPDzIAaKSi2MF
         OUGvwLNJcvZspOzQ8Tf87nn+5KOy1EXlUQ6ZKYiNIbVQcd/PdsMSnCaqUHoUJl2eCK92
         9bZpPSilhxlHaLRXV5hwq0gYtwXkMCLPZ5uVyXhvSV/6CG3oBI/jqg0eCR84x1x4x3sU
         E6CAPbr2DoHVGBqZOqLGLzE6AGc3To4kqrxDdpGuQDztpSVP8mBxgWxTVHyd9zF+SXTv
         c3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SCGEaLUtYBhXEn7JNjmN2oWTQgcbt6iL1vLrS5rVTKc=;
        b=Oayl72E8hvfOF/UJ2XfyLLTWD9cWyRCDA07yvSCKhd4C7ruB7JdqMHFqKEJuEHBLck
         hgAlZkiU3I9eDx9zmTj842FEpoyyxHW+VVCTDuQZGCORpq9EB+NwACGvHrhVYHYCQHyq
         8yXR+tVuBa361Qi7aTt8iScPtwecIWtFyc0SUm08BiE5xCx0ZISu7GDxBAvmjhnyPh2V
         CDGmA3aI2HLeYzapOjbq+rNBVjKehd9gxy6wketSEZiuai5pxsan85eNkW2iL8aipliw
         Taf0fvFHt4TvtqpgtW4CYpEIF/aZvBNVXXcyRePAJq+Cf1H6fB7oRyPeWny6gFSkxhgd
         k7VQ==
X-Gm-Message-State: AOAM531St/p2OzQJmk+oWI91TjUWNbBvFqqd6NeMu45/iHrYadTrN+M2
        vlUH2+06eDzzP7Gt/wSBpaIhuVOiCZw=
X-Google-Smtp-Source: ABdhPJxPI+Y9JJZmimvL35x62ilf+9rT22+zpC+thkodCX3vJwk9qo+/w8di5Zjq+zL7AGsaTW4OaA==
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr16614266wrx.366.1592795420543;
        Sun, 21 Jun 2020 20:10:20 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.15])
        by smtp.gmail.com with ESMTPSA id y196sm10031766wmd.11.2020.06.21.20.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 20:10:19 -0700 (PDT)
From:   Joel Stanley <joel@jms.id.au>
To:     devicetree-compiler@vger.kernel.org,
        David Gibson <david@gibson.dropbear.id.au>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/2] dtc: Improve checks for i2c reg properties
Date:   Mon, 22 Jun 2020 12:40:03 +0930
Message-Id: <20200622031005.1890039-1-joel@jms.id.au>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to fix a build warning in the Linux kernel caused by dtc
incorrectly warning about I2C_OWN_SLAVE_ADDRESS.

v4 adds a U to the defines
v3 fixes the 10 bit size check
v2 contains a second patch to check for 10 bit vs 7 bit addresses.

Joel Stanley (2):
  checks: Remove warning for I2C_OWN_SLAVE_ADDRESS
  checks: Improve i2c reg property checking

 checks.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

-- 
2.27.0

