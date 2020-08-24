Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE9A2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598258022;
	bh=X1Jc6HRrlX3sT+03uEUsKl4ouu4xw5betJQxvtle9D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kh+ECvBNywFEuMPhVzD3IYNvsfuRvCQjQQnD7Bhsl4EHfZBrmrrdzbeMxhig/qY6n
	 K4+N/uLF3iqBZ3FFAzNVtWd2mOvtKS2PqmBbDFp/0jHGdcDU9X0QGF7KcgTVnJqPtv
	 s/eFOkZkOY4TQ2kPFvWpuCJSmFKBOOYGNGDCmtJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgHXIdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:33:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgHXIdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:33:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5179D206F0;
        Mon, 24 Aug 2020 08:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258015;
        bh=X1Jc6HRrlX3sT+03uEUsKl4ouu4xw5betJQxvtle9D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pttGgOa3iucOAFVdGMpboDoH+KaVLCNOgIiLOXIb8veBcoQXGZelx/iOmYpdmRqGq
         4pPHHd19NMlQvI4GpPigeTppDb7OeecirOYA2WQ1maOsETtwuP5uTvu6qBQoa3J1FM
         /Fj0n6zVlpicPCMViaeUayoRuXbxxNy71/m4+cyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.8 042/148] drm/amd/display: fix pow() crashing when given base 0
Date:   Mon, 24 Aug 2020 10:29:00 +0200
Message-Id: <20200824082416.069469455@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krunoslav Kovac <Krunoslav.Kovac@amd.com>

commit d2e59d0ff4c44d1f6f8ed884a5bea7d1bb7fd98c upstream.

[Why&How]
pow(a,x) is implemented as exp(x*log(a)). log(0) will crash.
So return 0^x = 0, unless x=0, convention seems to be 0^0 = 1.

Cc: stable@vger.kernel.org
Signed-off-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/display/include/fixed31_32.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -431,6 +431,9 @@ struct fixed31_32 dc_fixpt_log(struct fi
  */
 static inline struct fixed31_32 dc_fixpt_pow(struct fixed31_32 arg1, struct fixed31_32 arg2)
 {
+	if (arg1.value == 0)
+		return arg2.value == 0 ? dc_fixpt_one : dc_fixpt_zero;
+
 	return dc_fixpt_exp(
 		dc_fixpt_mul(
 			dc_fixpt_log(arg1),


