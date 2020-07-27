Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEA0A20829
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595889370;
	bh=xH/2W2HYXueBgpFbXH6T7J94Jk224b7or73aw7CZnI4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FUVzI49+mZWnWorbRXYeOc52v1FGtR+OtC37YXyppm66nVAta5rmEL4w8CuhW3TKr
	 w38zgjdz2d6TsiMMg19wvgG7qsvh9PVX7NVymkkHY1LD0LzFy3H2ay8maPYI75kVqL
	 xt2jVpOopMgp0m6tlAjI0LIV6I5KTfPJmdRKgsxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG0WgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgG0WgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:36:09 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18524206D7;
        Mon, 27 Jul 2020 22:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595889368;
        bh=xH/2W2HYXueBgpFbXH6T7J94Jk224b7or73aw7CZnI4=;
        h=Date:From:To:Cc:Subject:From;
        b=SCZYQOjGindndaZIZWJs98kb88zQD1ytiM857gDvGLH9QRFHwhq846rviv9r9kZCZ
         Lckp54IMoHX+H2tKnZzKjToZ32Utb2LCeaikAMurD44D5NhtoGPXApox7MPWg28INK
         2ZM1A/pZZwljFOVbRmnnm37CbU/RacAMw0hEVq6E=
Date:   Mon, 27 Jul 2020 17:42:01 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] powerpc: Use fallthrough pseudo-keyword
Message-ID: <20200727224201.GA10133@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/kernel/align.c                 | 8 ++++----
 arch/powerpc/platforms/powermac/feature.c   | 2 +-
 arch/powerpc/platforms/powernv/opal-async.c | 2 +-
 arch/powerpc/platforms/pseries/hvcserver.c  | 2 +-
 arch/powerpc/xmon/xmon.c                    | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/align.c b/arch/powerpc/kernel/align.c
index 1f1ce8b86d5b..c7797eb958c7 100644
--- a/arch/powerpc/kernel/align.c
+++ b/arch/powerpc/kernel/align.c
@@ -178,11 +178,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __get_user_inatomic(temp.v[1], p++);
 			ret |= __get_user_inatomic(temp.v[2], p++);
 			ret |= __get_user_inatomic(temp.v[3], p++);
-			/* fall through */
+			fallthrough;
 		case 4:
 			ret |= __get_user_inatomic(temp.v[4], p++);
 			ret |= __get_user_inatomic(temp.v[5], p++);
-			/* fall through */
+			fallthrough;
 		case 2:
 			ret |= __get_user_inatomic(temp.v[6], p++);
 			ret |= __get_user_inatomic(temp.v[7], p++);
@@ -263,11 +263,11 @@ static int emulate_spe(struct pt_regs *regs, unsigned int reg,
 			ret |= __put_user_inatomic(data.v[1], p++);
 			ret |= __put_user_inatomic(data.v[2], p++);
 			ret |= __put_user_inatomic(data.v[3], p++);
-			/* fall through */
+			fallthrough;
 		case 4:
 			ret |= __put_user_inatomic(data.v[4], p++);
 			ret |= __put_user_inatomic(data.v[5], p++);
-			/* fall through */
+			fallthrough;
 		case 2:
 			ret |= __put_user_inatomic(data.v[6], p++);
 			ret |= __put_user_inatomic(data.v[7], p++);
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 181caa3f6717..5c77b9a24c0e 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -1465,7 +1465,7 @@ static long g5_i2s_enable(struct device_node *node, long param, long value)
 	case 2:
 		if (macio->type == macio_shasta)
 			break;
-		/* fall through */
+		fallthrough;
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/powerpc/platforms/powernv/opal-async.c b/arch/powerpc/platforms/powernv/opal-async.c
index 1656e8965d6b..c094fdf5825c 100644
--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -104,7 +104,7 @@ static int __opal_async_release_token(int token)
 	 */
 	case ASYNC_TOKEN_DISPATCHED:
 		opal_async_tokens[token].state = ASYNC_TOKEN_ABANDONED;
-		/* Fall through */
+		fallthrough;
 	default:
 		rc = 1;
 	}
diff --git a/arch/powerpc/platforms/pseries/hvcserver.c b/arch/powerpc/platforms/pseries/hvcserver.c
index 267139b13530..96e18d3b2fcf 100644
--- a/arch/powerpc/platforms/pseries/hvcserver.c
+++ b/arch/powerpc/platforms/pseries/hvcserver.c
@@ -45,7 +45,7 @@ static int hvcs_convert(long to_convert)
 		case H_LONG_BUSY_ORDER_10_SEC:
 		case H_LONG_BUSY_ORDER_100_SEC:
 			return -EBUSY;
-		case H_FUNCTION: /* fall through */
+		case H_FUNCTION:
 		default:
 			return -EPERM;
 	}
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 8fb1f857c11c..ed1a9f43709d 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -4278,7 +4278,7 @@ static int do_spu_cmd(void)
 		subcmd = inchar();
 		if (isxdigit(subcmd) || subcmd == '\n')
 			termch = subcmd;
-		/* fall through */
+		fallthrough;
 	case 'f':
 		scanhex(&num);
 		if (num >= XMON_NUM_SPUS || !spu_info[num].spu) {
-- 
2.27.0

