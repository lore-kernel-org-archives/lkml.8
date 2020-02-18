Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051D1C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED8722B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582056388;
	bh=3b9VvVgLrBfHjmC5JQTafY86LlzAo3TP0X+fFvFXBiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lSUSkkgfapaC4MD1m51Yhq/Fc4XOEorFNr98XN3GB0+NtR4/eNX9k1jcdHyaJNuMO
	 G+IMN+W/03B0ghnSW3UG40RECsO/mTRQk08k8ht6IRl0lO1IykMMErgv3So+TmoGFd
	 07lb2f9r3LbDxStAvbPwYMfuW6Xkschl9kO02Bt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBRUG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 15:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:39766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbgBRUAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 15:00:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4FB2467A;
        Tue, 18 Feb 2020 20:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582056029;
        bh=3b9VvVgLrBfHjmC5JQTafY86LlzAo3TP0X+fFvFXBiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iGL/XaxCmjTvRSDh0cle41b+sfADz7d428sSU2PWiHp9TWLwFpTitrqHiYd9zmlmB
         1cLJYQ6GUfAto2XzDViKD6fCRXYpkTIwd/UtsRIUjdC+bVaMdGxRuORDy8FNU8H+Qy
         Tnyf3fmOWOw4bR1Aui1kfZvZsj8QyahAfCAGTdOU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 5.4 50/66] sched/uclamp: Reject negative values in cpu_uclamp_write()
Date:   Tue, 18 Feb 2020 20:55:17 +0100
Message-Id: <20200218190432.661930025@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qais Yousef <qais.yousef@arm.com>

commit b562d140649966d4daedd0483a8fe59ad3bb465a upstream.

The check to ensure that the new written value into cpu.uclamp.{min,max}
is within range, [0:100], wasn't working because of the signed
comparison

 7301                 if (req.percent > UCLAMP_PERCENT_SCALE) {
 7302                         req.ret = -ERANGE;
 7303                         return req;
 7304                 }

	# echo -1 > cpu.uclamp.min
	# cat cpu.uclamp.min
	42949671.96

Cast req.percent into u64 to force the comparison to be unsigned and
work as intended in capacity_from_percent().

	# echo -1 > cpu.uclamp.min
	sh: write error: Numerical result out of range

Fixes: 2480c093130f ("sched/uclamp: Extend CPU's cgroup controller")
Signed-off-by: Qais Yousef <qais.yousef@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20200114210947.14083-1-qais.yousef@arm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/sched/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7250,7 +7250,7 @@ capacity_from_percent(char *buf)
 					     &req.percent);
 		if (req.ret)
 			return req;
-		if (req.percent > UCLAMP_PERCENT_SCALE) {
+		if ((u64)req.percent > UCLAMP_PERCENT_SCALE) {
 			req.ret = -ERANGE;
 			return req;
 		}


