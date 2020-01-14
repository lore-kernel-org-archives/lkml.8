Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E7FC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 572622467D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996397;
	bh=Jh40u/tSBu3myoAaCydzkNwil2EpuaMTa9hi9TmuNPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T5wuSgy95OQuwLjIgyWamJrRRGnrpSxVtU6rSbNNpfnbfL+dfdf3cWv0HXxysYHSa
	 UzQ2Q2leHbrk4IIi22Rxt+Kr8gfz8okO7HJEoY5m1jJmEE3UJ5vC/aZxB68d8IMRik
	 WOTM+oXJ62ZW6lcFUxmkBfX5o9nof/ENKTdCnldk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgANKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:06:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:35720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbgANKGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:06:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FC3E24677;
        Tue, 14 Jan 2020 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996391;
        bh=Jh40u/tSBu3myoAaCydzkNwil2EpuaMTa9hi9TmuNPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWhRRAPo3ygs8CHOJ2H6u6eMS2+3vvUuTfkUaY9MxAsr7rvAg3ZZ6WdQBgz3DdIYA
         FuN1r9iOqOOdMn9vEngqbWAN14awrh2WE7fIRojo8MtfLFlP3z18WOrEdZoYggBo0c
         MNqwm4H6GzON6mT+zyQMmQ2XXtL3jpU21WZvLDFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Malcolm Priestley <tvboxspy@gmail.com>
Subject: [PATCH 5.4 65/78] staging: vt6656: remove bool from vnt_radio_power_on ret
Date:   Tue, 14 Jan 2020 11:01:39 +0100
Message-Id: <20200114094402.155167930@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 07f59f180ee083c48c32a1e69ae1d0091444d212 upstream.

The driver uses logical only error checking a bool true would flag error.

Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Link: https://lore.kernel.org/r/cc52b67c-9ef8-3e57-815a-44d10701919e@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/vt6656/card.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/vt6656/card.c
+++ b/drivers/staging/vt6656/card.c
@@ -719,7 +719,7 @@ end:
  */
 int vnt_radio_power_on(struct vnt_private *priv)
 {
-	int ret = true;
+	int ret = 0;
 
 	vnt_exit_deep_sleep(priv);
 


