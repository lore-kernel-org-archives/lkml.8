Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F09C433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB3A206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260383;
	bh=n442EvsTbqBEqgyjT3wxtejbdW4jiSK7yLdja7AltvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uIync87RP8Bs6lfX86QThXQlf2ox2UGMJXkVwseMZkg4OmjPl3V078aSvZYdNaeF3
	 eT1UpWS4/MrMiD3iqTdsvIktwusEk1KfkLxibM6EzeJ8j2yI6MOuu3s81sOfW9zyja
	 EPgjMgijqDw2iQngLHDPPebjM+SqijzfLaGy0q18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgGTPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730407AbgGTPxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:53:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4283D22D2C;
        Mon, 20 Jul 2020 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260379;
        bh=n442EvsTbqBEqgyjT3wxtejbdW4jiSK7yLdja7AltvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fBVC8ApB7jEPZFM/1tDNFOFdF2kK32R5+ok/vLoJUfAw3faRW7mm/fy70hr1zfaX7
         K5wCZxd5iPKPug16Rejt21ppmwOhj+bTtVn5GLqOzdfHmOL97NKNjfj5ahcx28BPle
         VU3X8MOjdGb0yG13DWT5f9pUpFW7oPFqciPmHQfE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yariv <oigevald+kernel@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.19 082/133] HID: magicmouse: do not set up autorepeat
Date:   Mon, 20 Jul 2020 17:37:09 +0200
Message-Id: <20200720152807.672392967@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit 6363d2065cd399cf9d6dc9d08c437f8658831100 upstream.

Neither the trackpad, nor the mouse want input core to generate autorepeat
events for their buttons, so let's reset the bit (as hid-input sets it for
these devices based on the usage vendor code).

Cc: stable@vger.kernel.org
Reported-by: Yariv <oigevald+kernel@gmail.com>
Tested-by: Yariv <oigevald+kernel@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-magicmouse.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -452,6 +452,12 @@ static int magicmouse_setup_input(struct
 		__set_bit(MSC_RAW, input->mscbit);
 	}
 
+	/*
+	 * hid-input may mark device as using autorepeat, but neither
+	 * the trackpad, nor the mouse actually want it.
+	 */
+	__clear_bit(EV_REP, input->evbit);
+
 	return 0;
 }
 


