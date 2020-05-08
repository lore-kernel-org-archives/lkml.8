Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D305C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2123A21835
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588941403;
	bh=EDRl+eMzqpjL0jkRlYQA21XcOBULQNQFLz9OmSOdT6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+M5qu+ni/+5xK+/8h4zwL5rDTsCGJO7Qe/EOle6e0Mx7wyk6Ys3uTmVx273CoP5Z
	 tvg2TVFjZeQgqEDV+5feEHKo+NMPwO9Qv57D7vQw9LL4C0EUapTvjQdJz4UAx09CR4
	 6qWpswFLIVjIj+iGjdZbI5HJa8xOZTn970xQK0FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgEHMgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgEHMgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:36:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB6DF215A4;
        Fri,  8 May 2020 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941397;
        bh=EDRl+eMzqpjL0jkRlYQA21XcOBULQNQFLz9OmSOdT6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISdcB044OKQp8NPSjV+ndid18q8P2El7Gd+aQNgJW+u++liFGRCH0vMAgQ+brMdGp
         oShR9kbRYlzYdnQmZXDgCD7opM4t5FJavS5J+FKhvbRmLb05Si4exlCJq2JBgRW3h0
         W4trWX5iZDQnBBKFfNalAqdFy2B0C4doJMGd2dKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 016/312] MIPS: BMIPS: local_r4k___flush_cache_all needs to blast S-cache
Date:   Fri,  8 May 2020 14:30:07 +0200
Message-Id: <20200508123125.637749585@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit f675843ddfdfdf467d08cc922201614a149e439e upstream.

local_r4k___flush_cache_all() is missing a special check for BMIPS5000
processors, we need to blast the S-cache, just like other MTI processors
since we have an inclusive cache. We also need an additional __sync() to
make sure this is completed.

Fixes: d74b0172e4e2c ("MIPS: BMIPS: Add special cache handling in c-r4k.c")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13012/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/mm/c-r4k.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -447,6 +447,11 @@ static inline void local_r4k___flush_cac
 		r4k_blast_scache();
 		break;
 
+	case CPU_BMIPS5000:
+		r4k_blast_scache();
+		__sync();
+		break;
+
 	default:
 		r4k_blast_dcache();
 		r4k_blast_icache();


