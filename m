Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82478C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6BB20673
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737492;
	bh=fCECriq/Dd3+bz+oZpgg4nTsESff8bNif0i8bUc+1Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R0LE/YmZef6Y3Q0m40SIR8Ac8c1ADNhT17uTnBGh4RPVDVNSDgeVTVPAm4wuVLTWD
	 CAqQIaom4ZFkwox1/t516kX4i/UXBJJcxnJMB5qcK/IZpgNogJClt5KTsQIFdJ38Od
	 0oiH86hHGUvuufxMmF8vlIt255U27J7H9kZkDRyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgAKKLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:11:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgAKKLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:11:31 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CAC3206DA;
        Sat, 11 Jan 2020 10:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737490;
        bh=fCECriq/Dd3+bz+oZpgg4nTsESff8bNif0i8bUc+1Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vIQEcF+CypMMRPse2oHldA3FPwNHy7af9DgmLFegQgUxTXIx4JGLM/v581Rxe5BUs
         SaxslZPV5Ygd3tIDJptK0qIqe6czqGWEoLMRHXiPg3vDiuFWvB0KS5eKiXFZANtMd8
         p+EL+xA7nWmddviFVik66J4fKIwAZIO88eBRDu2o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 4.14 47/62] mmc: block: propagate correct returned value in mmc_rpmb_ioctl
Date:   Sat, 11 Jan 2020 10:50:29 +0100
Message-Id: <20200111094851.671908152@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094837.425430968@linuxfoundation.org>
References: <20200111094837.425430968@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Malaterre <malat@debian.org>

commit b25b750df99bcba29317d3f9d9f93c4ec58890e6 upstream.

In commit 97548575bef3 ("mmc: block: Convert RPMB to a character device") a
new function `mmc_rpmb_ioctl` was added. The final return is simply
returning a value of `0` instead of propagating the correct return code.

Discovered during a compilation with W=1, silence the following gcc warning

drivers/mmc/core/block.c:2470:6: warning: variable ‘ret’ set but not used
[-Wunused-but-set-variable]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
Fixes: 97548575bef3 ("mmc: block: Convert RPMB to a character device")
Cc: stable@vger.kernel.org # v4.15+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/block.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2305,7 +2305,7 @@ static long mmc_rpmb_ioctl(struct file *
 		break;
 	}
 
-	return 0;
+	return ret;
 }
 
 #ifdef CONFIG_COMPAT


