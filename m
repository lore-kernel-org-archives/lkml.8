Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB56C3F34D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64A421D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811616;
	bh=NaZ5Ck3m5yTQjNSgYbiMv1Yhr7mLSkoTg4HSsqyCwuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuCNg27rRDv8kF0SedHZcRMxP0VkbNvB8WE8ef7ymYUFP1V/5XS3T9b+gBwbUya+C
	 XkJ62iUJfxGtSxPTRRXvFGKwLOYi0nhjcGIdMpbKkN07V56TUFdLgYc0zRlTOcdImE
	 M+D65jQZfB+6jjd0/z8fD/JH3IoNr/rzZkpwkW7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgB0Nxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:53424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731726AbgB0Nxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:53:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCCEF24656;
        Thu, 27 Feb 2020 13:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811613;
        bh=NaZ5Ck3m5yTQjNSgYbiMv1Yhr7mLSkoTg4HSsqyCwuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoQUIsbWbheltCSdaldbjbyPbjUFDBQj8/u9nLiv7uveHrgBWGmNp1aDo3l5EVYDE
         KWwGCxliQiJTnpnNYBEQxxrQptgD4IBKgeRti/KKMSPbW5E3Pn6Y9Ex3BYT8qWr9aT
         o9VnDQRrFNpFwvp95evJ1qQ6SsegXGnVajPGS8hs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gaurav Agrawal <agrawalgaurav@gnome.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4.14 008/237] Input: synaptics - enable SMBus on ThinkPad L470
Date:   Thu, 27 Feb 2020 14:33:42 +0100
Message-Id: <20200227132256.442309624@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gaurav Agrawal <agrawalgaurav@gnome.org>

commit b8a3d819f872e0a3a0a6db0dbbcd48071042fb98 upstream.

Add touchpad LEN2044 to the list, as it is capable of working with
psmouse.synaptics_intertouch=1

Signed-off-by: Gaurav Agrawal <agrawalgaurav@gnome.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/CADdtggVzVJq5gGNmFhKSz2MBwjTpdN5YVOdr4D3Hkkv=KZRc9g@mail.gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -183,6 +183,7 @@ static const char * const smbus_pnp_ids[
 	"LEN0097", /* X280 -> ALPS trackpoint */
 	"LEN009b", /* T580 */
 	"LEN200f", /* T450s */
+	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"SYN3052", /* HP EliteBook 840 G4 */


