Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BD7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B9620663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 23:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhtEwmdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgEDXxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 19:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbgEDXxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 19:53:52 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EE1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 16:53:51 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g26so537600qtv.13
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uU5L3mTKQu7zv3TIEEDa+1AYyusenBY7XS77GDMeGtU=;
        b=dhtEwmdYZyY0rRSaEhvfcNC1vITa/c/X54xRPc3E0yng8bUWygzhzNuicxUYw0p9wx
         Uc/YksC7AF7oeveIe8SZ9pqUUWT1luLkag9l0OUTeIostGlmXMBRCKw6CWhLwmbm7oQ8
         fnuP9O0PS2qxUZvw3QSic2awNcaQdSn326lFZqZ+K89aplT1BDmde15uHh2AePrHezDh
         J32jKYW7mqwaHmgHHu4qHSyrrxmks45wybtVMZgvoK8uaH8ve2sLPQw0fD993jqhY9hX
         f5uunAV4vzbneq4GfLT+I33hcvhPkDQSuGdYqxqRgIRDhNgTUDc19EliQf1p8HFIsF/b
         bGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uU5L3mTKQu7zv3TIEEDa+1AYyusenBY7XS77GDMeGtU=;
        b=dsYvaJhZCeb4jbpDECOinrNLlPFGcgBF9GmV6JwWHvK8HSInuZUesPbK3FxMsbwh8r
         kS3ARuB1uT1n5kPCQs3gwf9CcfGy5Rp2w6UlnhKLzwb7g6PAity5llIK7I6s3OxkxiTW
         nZg9p4roV678yISIgYP8uN7h/zrxO18k8Apst+ClqPW/J3vtJtcVyBntSXx9uSmF2veb
         RPEyI5TkF7QajS50MH0xGciqdU5Fq7eE6eL1HXbXIY5m3+h6NaQlMn97hRd0Z1CMNAcP
         bM4GxBolahkeg9AF5UNUVTHoil67MNzhWuAIsRIFrlrhBpn92VJemvqnxi0UHV31poov
         +qEQ==
X-Gm-Message-State: AGi0PuZTGQ22g7ugSqQ1O5wa1dF8pmggbNIHLbr5Oswur6lVDHuOb21g
        1d2BbHBjmrnhcnZ4wm3xuwgDvyvJWq8=
X-Google-Smtp-Source: APiQypJO619AUMvWP6tjl8Otz6evwH1MBuUzxWXt92IyN7ElOczdcZodDUh4lgeHbyyZyfkO5hwADw==
X-Received: by 2002:ac8:65d4:: with SMTP id t20mr36761qto.358.1588636430635;
        Mon, 04 May 2020 16:53:50 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z18sm296004qti.47.2020.05.04.16.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 16:53:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: ipa: kill endpoint stop workaround
Date:   Mon,  4 May 2020 18:53:40 -0500
Message-Id: <20200504235345.17118-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that a workaround that performs a small DMA operation
between retried attempts to stop a GSI channel is not needed for any
supported hardware.  The hardware quirk that required the extra DMA
operation was fixed after IPA v3.1.  So this series gets rid of that
workaround code, along with some other code that was only present to
support it.

NOTE:  This series depends on (and includes/duplicates) another patch
       that has already been committed in the net tree:
         713b6ebb4c37 net: ipa: fix a bug in ipa_endpoint_stop()

					-Alex
Alex Elder (5):
  net: ipa: fix a bug in ipa_endpoint_stop()
  net: ipa: get rid of workaround in ipa_endpoint_stop()
  net: ipa: don't retry in ipa_endpoint_stop()
  net: ipa: kill ipa_endpoint_stop()
  net: ipa: kill ipa_cmd_dma_task_32b_addr_add()

 drivers/net/ipa/ipa_cmd.c      | 59 -------------------------
 drivers/net/ipa/ipa_cmd.h      | 11 -----
 drivers/net/ipa/ipa_endpoint.c | 80 +++-------------------------------
 drivers/net/ipa/ipa_endpoint.h |  2 -
 4 files changed, 6 insertions(+), 146 deletions(-)

-- 
2.20.1

