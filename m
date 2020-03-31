Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28560C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B3720675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646079;
	bh=6btdPEC8CzNBTP2CSMWFjhTl0NUxOV5Iz79NasmD+tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fs5RGDhcU+RH7VcnoUEAYS/ILtM1Q24jVs14JjTcjbZJFROy7eTJlBYw+emT3+K/h
	 KS4bM/HNA8tdyTvYdUHEjt1OYLhduZz+aYJ5IQM6AQQdJ8YYTIxvboj624Y4W8kdXM
	 q4ZekA0Nr0AEdYOYb4hMcaYmJmaVZqz00wdJ95QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731851AbgCaJOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgCaJOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:14:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDAB20675;
        Tue, 31 Mar 2020 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646073;
        bh=6btdPEC8CzNBTP2CSMWFjhTl0NUxOV5Iz79NasmD+tw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ATO0execK92TBaUIP48XK+uTEGpnHwmIGKFP9b41MXJWt2BDN9Vyt+UDh7v9pPDQD
         L6NgPEQhKMscV3gci3LnvasgOAZL6UOGWd30GhV+Gjnuxi3IhE5QUJWaTZdqmSFZCY
         JAXP1jiLWkjEvDOsiTHI7Q18Amd61ViSkUd3l32Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>, stable@kernel.org
Subject: [PATCH 5.4 076/155] i2c: hix5hd2: add missed clk_disable_unprepare in remove
Date:   Tue, 31 Mar 2020 10:58:36 +0200
Message-Id: <20200331085426.898902840@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
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
@@ -477,6 +477,7 @@ static int hix5hd2_i2c_remove(struct pla
 	i2c_del_adapter(&priv->adap);
 	pm_runtime_disable(priv->dev);
 	pm_runtime_set_suspended(priv->dev);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }


