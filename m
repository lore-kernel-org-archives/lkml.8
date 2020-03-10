Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6014C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D68D24693
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845205;
	bh=u5EESKKXh5N8XxF1ERwT6O7rJ8l+e6cksy9HpYkORGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u18JNFmdLsqWoFyXYylGGUyDg/IsA29UGeSoZccb/ejwNzMq6C7OK4e3NdDZpwZLl
	 PIIUG49+UmRyhEXjSNGgMpUeYA/tQMI9Nsmy4Lj9qeiAzHtB0LMrKd/YjEyz+PfSfR
	 8+EXW3/mHce7vNddvQpwDgW6+7gvWxdubze5xGm8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgCJNAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgCJM7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:59:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EB432468C;
        Tue, 10 Mar 2020 12:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845185;
        bh=u5EESKKXh5N8XxF1ERwT6O7rJ8l+e6cksy9HpYkORGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9xA+Db1XkN4FhxtOWkn9BLJWqA5c5AW2nZxgdl9LlCPpDkkiXOKDpEhadwS1BGfl
         hQD1yzFSsI06Nl5kFZUpYC8tIT1YVF2wO40GTCgMRWpCB42ktzjrLDimGhQvnlhNHB
         poSe+FLKExAS/70qE65Zc469FLFOuu2eGQfHFJBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.5 075/189] usb: core: hub: fix unhandled return by employing a void function
Date:   Tue, 10 Mar 2020 13:38:32 +0100
Message-Id: <20200310123647.200239875@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 63d6d7ed475c53dc1cabdfedf63de1fd8dcd72ee upstream.

Address below Coverity complaint (Feb 25, 2020, 8:06 AM CET):

---
 drivers/usb/core/hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1866,7 +1866,7 @@ static int hub_probe(struct usb_interfac
 
 	if (id->driver_info & HUB_QUIRK_DISABLE_AUTOSUSPEND) {
 		hub->quirk_disable_autosuspend = 1;
-		usb_autopm_get_interface(intf);
+		usb_autopm_get_interface_no_resume(intf);
 	}
 
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0)


