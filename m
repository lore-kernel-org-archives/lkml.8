Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED429C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD2B120723
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VX3+T0wA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgGBLZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728385AbgGBLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:25:42 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AA3C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 04:25:42 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id v6so14788667iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 04:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3eOAdXw1NhnAxI5LN5ukA0ePcO6Ycjk8EHcU3ptZvg=;
        b=VX3+T0wAjOcyJQXsSE22p6hjwxIEslK9trdMOEFCpon7rOo9uZJvfRheWJfe0kIrW2
         jvBeRU6VWJdzjuewBljKV7jrqtM2NEI2gRqTjfwFfGFnNB6oHuZxn7gDgJi2hfSHaK0H
         bf/zXS6wmJxAYvZgHYmNEdAlA1m25d7kkFJ3VKn+AeMLat7jJa9Wg1Q9o7h4ezqLtnvo
         8egpR65uZSZ+43+YOQdAYSeMhtfH5zdmV/RIcT68xinjj5yHd/f1qMx+TwcqVzDvKQJ6
         MyudbArryWewtcWygFqF10Vk68G1+L9My7RyKmNqNGLQigysBrPQZLmXyWRVblgtVZTS
         nB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y3eOAdXw1NhnAxI5LN5ukA0ePcO6Ycjk8EHcU3ptZvg=;
        b=hFE8KiKbJQr4F7zcRtvL58KCatS0PuVMIDfYuq96ROGYPD+4nqmCWxeFamkHOOW2o/
         cPFRJV4i6o/eAn2EXiPW3SNSMeg1npVgeRpI+/TAO5yAcT0lsIvq/E3qFRZ73PNykRhs
         i0ggBa805DkNmtqw1g32F/8FdiUP6YPL+lUS84X7MkXTTE1voXSWmBDLDMnzapieOY91
         KQ/w/EvqGiaM42evS2HBSCvaTiUqibtdFf/OPdVMD8ttGaw4OljBnd8sorDP6uRTXWU4
         bPQnN4reLc09y2K4U65y5xYNgYbFl4pzHlWxwDKnNg5luu0gCRRIP2fVW7tnEOpf0FjY
         va4g==
X-Gm-Message-State: AOAM531acb5RDZsYeK5L9SXsHKOYguEFSDB3fB27OpWpi3h25B1SkUCY
        t4HWGGl5ZVQ9Vf8A0oqODp+4VQ==
X-Google-Smtp-Source: ABdhPJxJJVohuYXhVMwZUnkwtOEvVkj8qB74QVZNRSnSgepzbkAsC6UEJujGV5uhCD6jy5xGUbPkrQ==
X-Received: by 2002:a02:70d4:: with SMTP id f203mr34472237jac.74.1593689141424;
        Thu, 02 Jul 2020 04:25:41 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c3sm4692842ilj.31.2020.07.02.04.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 04:25:40 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/4] net: ipa: simplify endpoint programming
Date:   Thu,  2 Jul 2020 06:25:33 -0500
Message-Id: <20200702112537.347994-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tests to functions so they don't update undefined endpoint
registers, rather than requiring the caller to avoid calling them.

Move the call to a workaround function required when suspending
inside the function that puts an endpoint into suspend mode.  This
requires moving a few functions (which are otherwise unchanged).

Then simplify ipa_endpoint_program() to call essentially all
endpoint register update functions unconditionally.

					-Alex

Alex Elder (4):
  net: ipa: move version test inside ipa_endpoint_program_delay()
  net: ipa: always handle suspend workaround
  net: ipa: move version test inside ipa_endpoint_program_suspend()
  net: ipa: simplify ipa_endpoint_program()

 drivers/net/ipa/ipa_endpoint.c | 190 +++++++++++++++++----------------
 1 file changed, 99 insertions(+), 91 deletions(-)

-- 
2.25.1

