Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43565C3405F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165022467A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUP4ZDsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSSKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:10:00 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38777 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:09:58 -0500
Received: by mail-lf1-f48.google.com with SMTP id r14so860465lfm.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BzO//zfGvvmDXWFrnnBIQSHTy0ns1CXRccR7GcbPRlo=;
        b=JUP4ZDsbz/nmLgQNFKk7ZZas36mU5d/63thVdthtw/+JDzFZLmm9Vj+mqjzrSmschw
         YeksJAFYmxokDcgysmGHTfXsO1dvAp4X3RkAM/LTau78Zl4JXaagptPoIM5sLuCnoR1/
         6SVcUuwkb3URjB/vNyQs+ScYqRbjB5A3ZvCVU/WNFaQ6AZbCIuvu/d7zFsR+CHemuo/1
         /J0m3A2dlLsN9LGRdWNnJLdcnekETD9HMfDuuRkUH/8KVdzir+9mXlGmaigPhZfexv3Q
         kWqGXwKbEA1h1pOGvwi+PSsa885Ip0sRniQ8kS6jEBG7R1m3tD4vphMjWc3mC25hkdzu
         /uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BzO//zfGvvmDXWFrnnBIQSHTy0ns1CXRccR7GcbPRlo=;
        b=HOe2vD8Mly0u9jMDDHFbPYJ+194RK2Dnr1K6a5rb4KTuKhqeGZBrMViKyE2DB0hFJ7
         Rcc4Bbu+RsV/EvhK1Q/9aADJzR68mFZd4mmMQb0HO4ez90EsCmu/hUXG3f3TxR2h/wyv
         IVl/Qj7xQv1poCoNGW8cwfSrQ4Xd2GGscTP0fpuRpr07yeXZ/xvLxGfgdr1ucfyc3Euk
         VX8CJruogegr7pxxuID2z9a9b7BJMQddfRFI5op0GToFYDytVyfLTJryAW7yfFeczb7v
         EQCNWg6UxRG5KgnxKiiHv/QacoIqDP2gJJFq/uyrwIktwzwUJ9I/3LktS5rKTfL2FZJa
         q3ew==
X-Gm-Message-State: APjAAAVrdhEieJqbyNDAHIZGLq9KagR2t1jCoKKBuol6IGvmpxahz29l
        wzTJqrDfpugpDyJd1Wq2rZ4=
X-Google-Smtp-Source: APXvYqx/ns6qi730SvnAx7FkLa5GwKNXVqSyJ3M9ldEtC/E9MqH1QWbqSJudFSiqcFW6FXpQjYj21w==
X-Received: by 2002:ac2:5596:: with SMTP id v22mr14129478lfg.200.1582135797136;
        Wed, 19 Feb 2020 10:09:57 -0800 (PST)
Received: from localhost.localdomain ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id 14sm183942lfz.47.2020.02.19.10.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 10:09:56 -0800 (PST)
From:   Andrey Lebedev <andrey.lebedev@gmail.com>
To:     mripard@kernel.org, wens@csie.org, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com
Subject: PATCH v4
Date:   Wed, 19 Feb 2020 20:08:53 +0200
Message-Id: <20200219180858.4806-1-andrey.lebedev@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210195633.GA21832@kedthinkpad>
References: <20200210195633.GA21832@kedthinkpad>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Address all outstanding review comments.

Maxime, please confirm I've got "document the new
compatibles" part right.


