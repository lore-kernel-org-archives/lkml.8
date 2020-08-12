Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C457BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18D92076C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gF+6KkYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLC3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgHLC3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:29:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A216CC061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:29:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w11so1160749ybi.23
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+n1LUw8DJLUyTXbv9Oe2r81KbedmVRu6OMKCTfy3ZiQ=;
        b=gF+6KkYSkPuCLW86O6juaBcdj4+WaTmJrk88Z0Ll9t0HKXakRLGtL2e+dhoGTjOnOR
         kaUAbdEXQaR5k+Qbya8c5FHurzzHJN1LAkLzVFEolC2/dwXBzRVWyqiVLvuba/NVbUZJ
         noY+rFhLK1Q9kfzlB8PDzkFSYMgTRB1JfbleLBaqnviMYn7MWW4CG7/xL6hjbElKNo14
         gmJSvbOGWteTH8BIykzQFgef/ngKDt0Sg56ylSppx36Hki0V1gGdEPBJDrlV4lT7tq+k
         uPsTKxJCjdk7QRkcXjgoMHmkaC7JaEpnFmoFuVb6hkzmNgrJwpdw3YQtKmaNsIywOXMQ
         VHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+n1LUw8DJLUyTXbv9Oe2r81KbedmVRu6OMKCTfy3ZiQ=;
        b=O7w7C5ijAkx/yllB7GKsYXZ58YG4kWTmFot6VDsO/+07+mcIn2RpdMbIH72tlHK2qr
         CfkWXg+HIXHATon67ldzBbcMvREZKDb8xxN/+etemM3AjOGHfKGFAN/FC7f6qNWQ7ld7
         XrFbM4IRjFjWSFjncDyyNaK+PVAQ7UVmS3B/6GgqMO9F1DDJYpkUuqFg9qE5X8DAyK38
         vcg20g2juIDkFiTv40d3xY8XxNzGTgOSvF4qIEiX2bOln39sSv+41RrWe1aCh0wjpEse
         pyzf6vKRC8WzWj3f/A19tetLbcK+/lMcCq7M9JfcM0GWwgcDtJZa4KrlYrdU4GcksW5d
         cxXQ==
X-Gm-Message-State: AOAM533edEWUrnBZe9QddqMijTizL2U84XOyorOdNJ0VnPA7rYCO2gf2
        HtrtPXeUU2W8NdnPp40nkYR61ec22NE=
X-Google-Smtp-Source: ABdhPJy4Ky3Al50cuQO6kqOXG7d2vNlasxYBXERWMS28MgJ0beqiTabAX+wsLbbYFzmtVPKC3nhGlkrYfuA=
X-Received: by 2002:a25:f30c:: with SMTP id c12mr55236202ybs.471.1597199385901;
 Tue, 11 Aug 2020 19:29:45 -0700 (PDT)
Date:   Tue, 11 Aug 2020 19:29:34 -0700
In-Reply-To: <20200812022934.568134-1-badhri@google.com>
Message-Id: <20200812022934.568134-2-badhri@google.com>
Mime-Version: 1.0
References: <20200812022934.568134-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH 2/2 v3] usb: typec: pd: Fix formatting in pd.h header
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing spaces with tabs for PD_T_* constants.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
Change history:
First version. Keeping the version number same as the parent.

---
 include/linux/usb/pd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 1df895e4680b..f842e4589bd2 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -471,9 +471,10 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_VCONN_SOURCE_ON	100
 #define PD_T_SINK_REQUEST	100	/* 100 ms minimum */
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
-#define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
-#define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SRCSWAPSTDBY	625	/* Maximum of 650ms */
+#define PD_T_NEWSRC		250	/* Maximum of 275ms */
 #define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
+#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
@@ -484,5 +485,4 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
 #define PD_N_HARD_RESET_COUNT	2
 
-#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
 #endif /* __LINUX_USB_PD_H */
-- 
2.28.0.236.gb10cc79966-goog

