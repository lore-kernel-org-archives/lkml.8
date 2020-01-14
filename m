Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8D9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FE1124676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996947;
	bh=wZsuNyg52iC6tK/7FHq0jDe5n+VxHjD0GEhVgbuEv9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m+12F2pL2zucFUubLcKi8UuRsLXU6ltmxBzVhj3jMHz1JM0ijQwddrSU6MOc2v6un
	 o6BeW42U1r/R24LoEdc3s1SqYzQyj4L//dtrMF7MVsJLn9ZVz74/V99FVfxsuuuB+A
	 jNd6e88w5jbUK7b6iQBiTbWjYcr4vdwT+s/AVmrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgANKPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:15:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730909AbgANKKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:10:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A881320678;
        Tue, 14 Jan 2020 10:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996643;
        bh=wZsuNyg52iC6tK/7FHq0jDe5n+VxHjD0GEhVgbuEv9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ESehhrVIMPXt09BKNr/lsWNNX027YhZ77i+fJssc5mjbuaGYlBvOxvaAv4L4eFd65
         THMYwgYJsmmE+p6gleul3BoZKPu5l4xDG9kHEuW41Uwa+N4faqg0WyKw9F75sJ4nZg
         PAtg+mlVsQRcMMnTkt5zsJ+3I8wVOj3s0G093QJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Chris Chiu <chiu@endlessm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 31/39] rtl8xxxu: prevent leaking urb
Date:   Tue, 14 Jan 2020 11:02:05 +0100
Message-Id: <20200114094345.633479616@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094336.210038037@linuxfoundation.org>
References: <20200114094336.210038037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit a2cdd07488e666aa93a49a3fc9c9b1299e27ef3c upstream.

In rtl8xxxu_submit_int_urb if usb_submit_urb fails the allocated urb
should be released.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -5453,6 +5453,7 @@ static int rtl8xxxu_submit_int_urb(struc
 	ret = usb_submit_urb(urb, GFP_KERNEL);
 	if (ret) {
 		usb_unanchor_urb(urb);
+		usb_free_urb(urb);
 		goto error;
 	}
 


