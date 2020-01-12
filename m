Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B25C33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 18:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27B721569
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 17:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+Bqtn3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733166AbgALR7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 12:59:50 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:42622 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732917AbgALR7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 12:59:49 -0500
Received: by mail-wr1-f50.google.com with SMTP id q6so6345972wro.9;
        Sun, 12 Jan 2020 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkGln0QRf/x6afs/q7FCW+45jv0mw0n5WnVAJt290Dw=;
        b=P+Bqtn3noQnr5XyQLuyM7vu2d3ZHWfymTFQHj5zKTwZGzlIsQvxquP+aqckhoGw62x
         3LZ0joGA2X2srcrwcwvs1V9fHhk79IJ8UWhhyxNrrYXiYyvLgp5M1e4ernLLhQSIrqJQ
         ijipoLwcD+lvBXSKPHgzz+l7jp/mdDesunp44Gkntaj6oyBuhs4t0FZCZtT8sfSLo4bb
         su1w8Qmckm82mJEMNYchl24Sa6uxe0QJy/XBYK5VtkH+GjXOiYmlEYX4fdFSlN/NXHQx
         RVxlX2ZxpRoDq6PScGSax+XBxnJkr0aUVXBfO+w7N6CLbvFR8F9ZNGT6p5COa+Rp3IG8
         pM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkGln0QRf/x6afs/q7FCW+45jv0mw0n5WnVAJt290Dw=;
        b=SiSdhXP0likZCFsI23Coai79Cr1GkQLnPC0HapCJgwveCHGqu7v2S+dokC+CNFwXoY
         Qewi7PLRH4hKU+rKaCj+/pZgTuhUZzXUx3QOLIVUE2+C8o00x+gUU445aOdlt/JV0Via
         fLWdxRe6cGwM1OUnstCLJTU1oHhHh5fBi6b1SPA1yZCc6o/v/oN56icDsXsTA36Shaij
         hWuJP0iBd0SZOiqGX91vD11oxYcWSC/7lAGpVEI48ojAnKoS50XRz73WylOeuVCo0fpQ
         GoFTmAL+WYoE8eVtZaO6aSsAmhH8NyrKKrXSAzFV7lNmDqSeI940R06ZozYFFyKq9t0P
         fmFQ==
X-Gm-Message-State: APjAAAUvLfOoIzseCPtcwtM6WV2Up3mLXWlcTWHols1v1JHaqKfLkb+L
        r+6FE5cZxMEoOlqloXpjH11Yg28K
X-Google-Smtp-Source: APXvYqwW2P+VlaYfrXQ2LwOSEOyGan788/8HN6IDAONHvKCapAyRgUSb7ruHZmBdM88obL6AQZCtzA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr14283354wrp.1.1578851987346;
        Sun, 12 Jan 2020 09:59:47 -0800 (PST)
Received: from Pali-Latitude.lan (ip-89-103-160-142.net.upcbroadband.cz. [89.103.160.142])
        by smtp.gmail.com with ESMTPSA id t25sm11076522wmj.19.2020.01.12.09.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2020 09:59:46 -0800 (PST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [WIP PATCH 0/4] Support for UDF 1.01 and 2.60 revisions
Date:   Sun, 12 Jan 2020 18:59:29 +0100
Message-Id: <20200112175933.5259-1-pali.rohar@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are my work-in-progress patches for UDF 1.01 and 2.60 revisions.
Patches are untested and UDF 2.60 support is only in R/O mode.

I'm sending them to know what do you think about it. There is missing
code for parsing of numFiles, numDirs, minUDFReadRev and minUDFWriteRev
values from UDF 1.50 VAT discs, but this could be done in other patches.

PS: If somebody is interested in UDF 1.01 specification, please let me
know and I could send it. It is missing on OSTA website.

Pali Rohár (4):
  udf: Do not access LVIDIU revision members when they are not filled
  udf: Fix reading numFiles and numDirs from UDF 2.00+ VAT discs
  udf: Fix reading minUDFReadRev and minUDFWriteRev from UDF 2.00+ VAT
    discs
  udf: Allow to read UDF 2.60 discs

 fs/udf/super.c  | 71 +++++++++++++++++++++++++++++++++++++++----------
 fs/udf/udf_sb.h | 10 ++++++-
 2 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.20.1

