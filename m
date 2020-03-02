Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393AC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6671222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7fj8X3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCBRkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:40:05 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:33007 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgCBRkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:40:05 -0500
Received: by mail-pg1-f179.google.com with SMTP id m5so170690pgg.0;
        Mon, 02 Mar 2020 09:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ccLgGlXJeyfNwA0nueYiFsMbc5nyvrsM97a1+xIUUac=;
        b=W7fj8X3a8gokG5mZbNte3SvQJzMLyc6ZsZ3I18q1+2Qnam52farx0iNFiqbPc5+HxP
         kJqiJEsRLC7eaogsdWtKTTkETP+UqktTIdofxDvV8J0WE8RmxhwxTk0dCADgqzImBe4l
         jGDig8SgkU82S1wb93DXjj1hGpbSm+o1w0WuHdybfxaIoIE6I+tLhWOv69paXjU0w/3O
         hPdgjlViSZdNcxbYiXUKUEy9EGlDS+84Dj5xOMt9yEGKBlEIwYy0BBaV5fX8UIuorLcD
         YCuSfHRae8WrrTT2YFHLY1dJ59s3tN1dDGPnj9bl+337a/0xutqLOgpThGS2Uoo073ZM
         fU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ccLgGlXJeyfNwA0nueYiFsMbc5nyvrsM97a1+xIUUac=;
        b=RrDA/lWJWvXsyqW96ktmN5wGPKRGJMyM+Wmj3QYLq9V6SK/suGDjc039Wz1BKvStvp
         gZsDHHPU5IpOcJJl9yJVcQzOdqr3ewgsIHLRMts90+ZvMoDhb9Tav4i1QPK2X6evm3PK
         NKnCVXMGcg1zFqWeE7/2q9l+Naci6YbSPUSlOIqNzy0XWMGs366FfmTyy1C4bDjhvkgl
         1cN9tB5W4MHX4DgMpkvTs76Pl6aXvM1uhCVIR6BOfoL64UvBSkIPc8m6S347xEsePEA9
         7Y4A8KDBu1ptrxY22OrtEEZI9aMngeJkcmZvxAxLz/DSiKqFjozGHx3ccWMbaPid++BM
         XHaA==
X-Gm-Message-State: ANhLgQ1J5r7iYg66GpfbpJOE1wXwTxPOoL2/5LzPbKaTJd29MkYa1JmE
        bwuLkcfHRMR5ExLTyGVioVg04nSx74tIPg==
X-Google-Smtp-Source: ADFU+vsmcgwBaN2ggQ2yDntxSGZzld20AoSwZIazsRFr8GSGi0fFrYx982ZdTaikc8pnRwYPy0tVLQ==
X-Received: by 2002:aa7:8b17:: with SMTP id f23mr149223pfd.197.1583170804359;
        Mon, 02 Mar 2020 09:40:04 -0800 (PST)
Received: from localhost.localdomain ([2405:204:800a:15c3:b0b0:78ba:d728:349e])
        by smtp.gmail.com with ESMTPSA id c184sm21764462pfa.39.2020.03.02.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:40:03 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 0/2] Documentation: Add two new rst files
Date:   Mon,  2 Mar 2020 23:09:18 +0530
Message-Id: <20200302173920.24626-1-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds following two rst files to the Documentation and
references the newly added rst files into TOCTree of index.rst
 -io_mapping.rst 
 -io_ordering.rst

Pragat Pandya (2):
  Documentation: Add a new .rst file under Documentation
  Documentation: Add a new .rst file under Documentation

 Documentation/index.rst                       |  1 +
 .../{io-mapping.txt => io_mapping.rst}        |  0
 .../{io_ordering.txt => io_ordering.rst}      |  0
 doc_make.log                                  | 35 +++++++++++++++++++
 4 files changed, 36 insertions(+)
 rename Documentation/{io-mapping.txt => io_mapping.rst} (100%)
 rename Documentation/{io_ordering.txt => io_ordering.rst} (100%)
 create mode 100644 doc_make.log

-- 
2.17.1

