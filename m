Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADB7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1493212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758728;
	bh=igs7xu7r/XChIxqWV7J9GvhZVftoNLULHWSoR+aDak0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B9b1j+zIvqXXdw/Sc0KoA8HzT1Vt8n8OeTL5LnWoCqKpyxJ6v9E18sSGyQZq8uTCp
	 iggJ21vttla2cR+hTnuJYfSmfhreQ7EymR+j4ReLKCPVjCDNthCLnU0CZ8Ss1tWdpw
	 CAQsWXdZuuAnCbLvaKXcw7ipTZ6Owfv5hVXFZ7ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388388AbgDAQcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:32:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:58408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388378AbgDAQcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:32:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3D72063A;
        Wed,  1 Apr 2020 16:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758723;
        bh=igs7xu7r/XChIxqWV7J9GvhZVftoNLULHWSoR+aDak0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCe2n3E/pQCQZ75o1vScldzCOcGjjoYMK/u9yI2usH+7nuFjFOhESgiGo2xy8yJ10
         znj5/9V7g8jQyx6VOZ2sDRy05WPyG9nVhwR/6IteYYY3N94sIRR16b/6ziV24xmm7D
         AB7oESctyDaCNuYaEMtlGKMKWZmAMvnTLgCHTSWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 4.4 55/91] i2c: hix5hd2: add missed clk_disable_unprepare in remove
Date:   Wed,  1 Apr 2020 18:17:51 +0200
Message-Id: <20200401161532.491799620@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

commit e1b9f99ff8c40bba6e59de9ad4a659447b1e4112 upstream.

The driver forgets to disable and unprepare clk when remove.
Add a call to clk_disable_unprepare to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-hix5hd2.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-hix5hd2.c
+++ b/drivers/i2c/busses/i2c-hix5hd2.c
@@ -500,6 +500,7 @@ static int hix5hd2_i2c_remove(struct pla
 	i2c_del_adapter(&priv->adap);
 	pm_runtime_disable(priv->dev);
 	pm_runtime_set_suspended(priv->dev);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }


