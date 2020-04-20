Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC2C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48718206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587387474;
	bh=GP35ms7s6eukRrP35V2qI8Cv1wypBlHoorzFyo/mSfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1LDkRU936rS+LGl7warPbuf+tKQuLc5sOZF3kLYHl/02NFnhYHOG88uhyuI0bZQtT
	 MyuMexb68i3fwZtUy1EWn9570kCRJb6t/mX6XqPz9n2wLSlMDByfQ19e3bNJkwluOl
	 caOD2nWpWV3gygNeLDG3fjvKzWjULk5NZgyBEE90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgDTMn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbgDTMnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:43:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4A842070B;
        Mon, 20 Apr 2020 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386630;
        bh=GP35ms7s6eukRrP35V2qI8Cv1wypBlHoorzFyo/mSfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEtvW1Zs0iz6x+9PSJ5pC/1/eFVzsrV3VB2vYC7AAUZ+qoHvastMLUd9T6Vah/ilo
         1x3x6aiQ9suKoDUTgeFkWoTcfRDmRH+oQW3MQdD8Jy1Q9YSd8AenI5KTNc+XUezBdH
         EECKixDAL3PKysw89M5m+CAJ+UCgrxNEsg9qwFxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 5.6 34/71] HID: lg-g15: Do not fail the probe when we fail to disable F# emulation
Date:   Mon, 20 Apr 2020 14:38:48 +0200
Message-Id: <20200420121515.794307788@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit b8a75eaddae9410767c7d95a1c5f3a547aae7b81 upstream.

By default the G1-G12 keys on the Logitech gaming keyboards send
F1 - F12 when in "generic HID" mode.

The first thing the hid-lg-g15 driver does is disable this behavior.

We have received a bugreport that this does not work when the keyboard
is connected through an Aten KVM switch. Using a gaming keyboard with
a KVM is a bit weird setup, but still we can try to fail a bit more
gracefully here.

On the G510 keyboards the same USB-interface which is used for the gaming
keys is also used for the media-keys. Before this commit we would call
hid_hw_stop() on failure to disable the F# emulation and then exit the
probe method with an error code.

This not only causes us to not handle the gaming-keys, but this also
breaks the media keys which is a regression compared to the situation
when these keyboards where handled by the generic hidinput driver.

This commit changes the error handling to clear the hiddev drvdata
(to disable our .raw_event handler) and then returning from the probe
method with success.

The net result of this is that, when connected through a KVM, things
work as well as they did before the hid-lg-g15 driver was introduced.

Fixes: ad4203f5a243 ("HID: lg-g15: Add support for the G510 keyboards' gaming keys")
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1806321
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-lg-g15.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-lg-g15.c
+++ b/drivers/hid/hid-lg-g15.c
@@ -803,8 +803,10 @@ static int lg_g15_probe(struct hid_devic
 	}
 
 	if (ret < 0) {
-		hid_err(hdev, "Error disabling keyboard emulation for the G-keys\n");
-		goto error_hw_stop;
+		hid_err(hdev, "Error %d disabling keyboard emulation for the G-keys, falling back to generic hid-input driver\n",
+			ret);
+		hid_set_drvdata(hdev, NULL);
+		return 0;
 	}
 
 	/* Get initial brightness levels */


