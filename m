Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C623DC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CF6D20BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598974072;
	bh=weL9YdpfKwX/bBVPebMPmhQsixTnADMaMl9sjOrg8Ug=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TL9XvGTVeXI/+/axtmzJSpPX2WuoaB3mPmrQ57an+YO0b4H4EOAOgPUPa4wWK7PR1
	 cjJSannTT/C2J6mWpSR+O9deY5mj3Ljv5SKGAsya2n5iqiI966XnjYHTCvih1UI422
	 gwRwWmEXsz56+fMWgGPzGbS9M89ztpDuw+Rc5HgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730303AbgIAP1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:48602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729966AbgIAPYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C24A72078B;
        Tue,  1 Sep 2020 15:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973874;
        bh=weL9YdpfKwX/bBVPebMPmhQsixTnADMaMl9sjOrg8Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UzJypqs/tEgduxxRg66BSULtLzEjPMqKyub/6MAreVcK7s1t1DlLJkSCUG9BTUNT8
         L0rrirwX2rgTeVf7NcW9WaL2zTylXiDqseO9NE5pEHHYvULUWDqqKfWBkLjlzlYgRM
         xe8BOIWd/mzMfSkSGduBYdStn+M8rOSIYS6HWTxI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Andrea Borgia <andrea@borgia.bo.it>
Subject: [PATCH 4.19 081/125] HID: i2c-hid: Always sleep 60ms after I2C_HID_PWR_ON commands
Date:   Tue,  1 Sep 2020 17:10:36 +0200
Message-Id: <20200901150938.545315051@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit eef4016243e94c438f177ca8226876eb873b9c75 upstream.

Before this commit i2c_hid_parse() consists of the following steps:

1. Send power on cmd
2. usleep_range(1000, 5000)
3. Send reset cmd
4. Wait for reset to complete (device interrupt, or msleep(100))
5. Send power on cmd
6. Try to read HID descriptor

Notice how there is an usleep_range(1000, 5000) after the first power-on
command, but not after the second power-on command.

Testing has shown that at least on the BMAX Y13 laptop's i2c-hid touchpad,
not having a delay after the second power-on command causes the HID
descriptor to read as all zeros.

In case we hit this on other devices too, the descriptor being all zeros
can be recognized by the following message being logged many, many times:

hid-generic 0018:0911:5288.0002: unknown main item tag 0x0

At the same time as the BMAX Y13's touchpad issue was debugged,
Kai-Heng was working on debugging some issues with Goodix i2c-hid
touchpads. It turns out that these need a delay after a PWR_ON command
too, otherwise they stop working after a suspend/resume cycle.
According to Goodix a delay of minimal 60ms is needed.

Having multiple cases where we need a delay after sending the power-on
command, seems to indicate that we should always sleep after the power-on
command.

This commit fixes the mentioned issues by moving the existing 1ms sleep to
the i2c_hid_set_power() function and changing it to a 60ms sleep.

Cc: stable@vger.kernel.org
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=208247
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reported-and-tested-by: Andrea Borgia <andrea@borgia.bo.it>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/i2c-hid/i2c-hid-core.c |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -444,6 +444,19 @@ static int i2c_hid_set_power(struct i2c_
 		dev_err(&client->dev, "failed to change power setting.\n");
 
 set_pwr_exit:
+
+	/*
+	 * The HID over I2C specification states that if a DEVICE needs time
+	 * after the PWR_ON request, it should utilise CLOCK stretching.
+	 * However, it has been observered that the Windows driver provides a
+	 * 1ms sleep between the PWR_ON and RESET requests.
+	 * According to Goodix Windows even waits 60 ms after (other?)
+	 * PWR_ON requests. Testing has confirmed that several devices
+	 * will not work properly without a delay after a PWR_ON request.
+	 */
+	if (!ret && power_state == I2C_HID_PWR_ON)
+		msleep(60);
+
 	return ret;
 }
 
@@ -465,15 +478,6 @@ static int i2c_hid_hwreset(struct i2c_cl
 	if (ret)
 		goto out_unlock;
 
-	/*
-	 * The HID over I2C specification states that if a DEVICE needs time
-	 * after the PWR_ON request, it should utilise CLOCK stretching.
-	 * However, it has been observered that the Windows driver provides a
-	 * 1ms sleep between the PWR_ON and RESET requests and that some devices
-	 * rely on this.
-	 */
-	usleep_range(1000, 5000);
-
 	i2c_hid_dbg(ihid, "resetting...\n");
 
 	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);


