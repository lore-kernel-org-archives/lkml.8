Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD61C33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A14D24687
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686020;
	bh=uekGNvBbb8iL4au83+tOTlq3z6PxAJJO3z4muAo2nhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k18ziiLDeR5UHu5HyJOlXb9lW5yu0AGEKsItovbw0G+un4lbGl7VEYw10O1MSsEnD
	 Xi4uu4UEBkeTf7AP6DaTMUIJDqRPYz0aKl+eJ84VjNWzRJqLOdhZmiBauPqmRmf0F2
	 4uyfITvX/5NC98vXSp3fOq6zzAPyK3Uh2FOP55x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387438AbgAVJkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:40:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387426AbgAVJkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:40:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 620CB24687;
        Wed, 22 Jan 2020 09:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579686011;
        bh=uekGNvBbb8iL4au83+tOTlq3z6PxAJJO3z4muAo2nhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tMCSW/W0zv2jUoVr/vNIO7bPW9t9aMKsNrdQM6SA+l+alTX94ZRdJWUy5EJsw5pcv
         wwl/F+bubdrE0CjD0QhYbvfcBeNtN+El9TS30coS7oj4aK8biN54LRjb98vQ9P7zq2
         aGs3IP4tH13+8bebTqk67cXJwf80Cqn5wA1DR0oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 65/65] regulator: ab8500: Remove SYSCLKREQ from enum ab8505_regulator_id
Date:   Wed, 22 Jan 2020 10:29:50 +0100
Message-Id: <20200122092801.461725060@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephan Gerhold <stephan@gerhold.net>

commit 458ea3ad033fc86e291712ce50cbe60c3428cf30 upstream.

Those regulators are not actually supported by the AB8500 regulator
driver. There is no ab8500_regulator_info for them and no entry in
ab8505_regulator_match.

As such, they cannot be registered successfully, and looking them
up in ab8505_regulator_match causes an out-of-bounds array read.

Fixes: 547f384f33db ("regulator: ab8500: add support for ab8505")
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20191106173125.14496-2-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/regulator/ab8500.h |    2 --
 1 file changed, 2 deletions(-)

--- a/include/linux/regulator/ab8500.h
+++ b/include/linux/regulator/ab8500.h
@@ -43,8 +43,6 @@ enum ab8505_regulator_id {
 	AB8505_LDO_ANAMIC2,
 	AB8505_LDO_AUX8,
 	AB8505_LDO_ANA,
-	AB8505_SYSCLKREQ_2,
-	AB8505_SYSCLKREQ_4,
 	AB8505_NUM_REGULATORS,
 };
 


